/* Frame unwinder for frames with DWARF Call Frame Information.

   Copyright 2003 Free Software Foundation, Inc.

   Contributed by Mark Kettenis.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

#include "defs.h"
#include "dwarf2expr.h"
#include "elf/dwarf2.h"
#include "frame.h"
#include "frame-base.h"
#include "frame-unwind.h"
#include "gdbcore.h"
#include "gdbtypes.h"
#include "symtab.h"
#include "objfiles.h"
#include "regcache.h"

#include "gdb_assert.h"
#include "gdb_string.h"

#include "complaints.h"
#include "dwarf2-frame.h"

/* Call Frame Information (CFI).  */

/* Common Information Entry (CIE).  */

struct dwarf2_cie
{
  /* Offset into the .debug_frame section where this CIE was found.
     Used to identify this CIE.  */
  ULONGEST cie_pointer;

  /* Constant that is factored out of all advance location
     instructions.  */
  ULONGEST code_alignment_factor;

  /* Constants that is factored out of all offset instructions.  */
  LONGEST data_alignment_factor;

  /* Return address column.  */
  ULONGEST return_address_register;

  /* Instruction sequence to initialize a register set.  */
  unsigned char *initial_instructions;
  unsigned char *end;

  /* Encoding of addresses.  */
  unsigned char encoding;

  /* True if a 'z' augmentation existed.  */
  unsigned char saw_z_augmentation;

  struct dwarf2_cie *next;
};

/* Frame Description Entry (FDE).  */

struct dwarf2_fde
{
  /* CIE for this FDE.  */
  struct dwarf2_cie *cie;

  /* First location associated with this FDE.  */
  CORE_ADDR initial_location;

  /* Number of bytes of program instructions described by this FDE.  */
  CORE_ADDR address_range;

  /* Instruction sequence.  */
  unsigned char *instructions;
  unsigned char *end;

  struct dwarf2_fde *next;
};

static struct dwarf2_fde *dwarf2_frame_find_fde (CORE_ADDR *pc);


/* Structure describing a frame state.  */

struct dwarf2_frame_state
{
  /* Each register save state can be described in terms of a CFA slot,
     another register, or a location expression.  */
  struct dwarf2_frame_state_reg_info
  {
    struct dwarf2_frame_state_reg
    {
      union {
	LONGEST offset;
	ULONGEST reg;
	unsigned char *exp;
      } loc;
      ULONGEST exp_len;
      enum {
	REG_UNSAVED,
	REG_SAVED_OFFSET,
	REG_SAVED_REG,
	REG_SAVED_EXP,
	REG_UNMODIFIED
      } how;
    } *reg;
    int num_regs;

    /* Used to implement DW_CFA_remember_state.  */
    struct dwarf2_frame_state_reg_info *prev;
  } regs;

  LONGEST cfa_offset;
  ULONGEST cfa_reg;
  unsigned char *cfa_exp;
  enum {
    CFA_UNSET,
    CFA_REG_OFFSET,
    CFA_EXP
  } cfa_how;

  /* The PC described by the current frame state.  */
  CORE_ADDR pc;

  /* Initial register set from the CIE.
     Used to implement DW_CFA_restore.  */
  struct dwarf2_frame_state_reg_info initial;

  /* The information we care about from the CIE.  */
  LONGEST data_align;
  ULONGEST code_align;
  ULONGEST retaddr_column;
};

/* Store the length the expression for the CFA in the `cfa_reg' field,
   which is unused in that case.  */
#define cfa_exp_len cfa_reg

/* Assert that the register set RS is large enough to store NUM_REGS
   columns.  If necessary, enlarge the register set.  */

static void
dwarf2_frame_state_alloc_regs (struct dwarf2_frame_state_reg_info *rs,
			       int num_regs)
{
  size_t size = sizeof (struct dwarf2_frame_state_reg);

  if (num_regs <= rs->num_regs)
    return;

  rs->reg = (struct dwarf2_frame_state_reg *)
    xrealloc (rs->reg, num_regs * size);

  /* Initialize newly allocated registers.  */
  memset (rs->reg + rs->num_regs, 0, (num_regs - rs->num_regs) * size);
  rs->num_regs = num_regs;
}

/* Copy the register columns in register set RS into newly allocated
   memory and return a pointer to this newly created copy.  */

static struct dwarf2_frame_state_reg *
dwarf2_frame_state_copy_regs (struct dwarf2_frame_state_reg_info *rs)
{
  size_t size = rs->num_regs * sizeof (struct dwarf2_frame_state_reg_info);
  struct dwarf2_frame_state_reg *reg;

  reg = (struct dwarf2_frame_state_reg *) xmalloc (size);
  memcpy (reg, rs->reg, size);

  return reg;
}

/* Release the memory allocated to register set RS.  */

static void
dwarf2_frame_state_free_regs (struct dwarf2_frame_state_reg_info *rs)
{
  if (rs)
    {
      dwarf2_frame_state_free_regs (rs->prev);

      xfree (rs->reg);
      xfree (rs);
    }
}

/* Release the memory allocated to the frame state FS.  */

static void
dwarf2_frame_state_free (void *p)
{
  struct dwarf2_frame_state *fs = p;

  dwarf2_frame_state_free_regs (fs->initial.prev);
  dwarf2_frame_state_free_regs (fs->regs.prev);
  xfree (fs->initial.reg);
  xfree (fs->regs.reg);
  xfree (fs);
}


/* Helper functions for execute_stack_op.  */

static CORE_ADDR
read_reg (void *baton, int reg)
{
  struct frame_info *next_frame = (struct frame_info *) baton;
  int regnum;
  char *buf;

  regnum = DWARF2_REG_TO_REGNUM (reg);

  buf = (char *) alloca (register_size (current_gdbarch, regnum));
  frame_unwind_register (next_frame, regnum, buf);
  return extract_typed_address (buf, builtin_type_void_data_ptr);
}

static void
read_mem (void *baton, char *buf, CORE_ADDR addr, size_t len)
{
  read_memory (addr, buf, len);
}

static void
no_get_frame_base (void *baton, unsigned char **start, size_t *length)
{
  internal_error (__FILE__, __LINE__,
		  "Support for DW_OP_fbreg is unimplemented");
}

static CORE_ADDR
no_get_tls_address (void *baton, CORE_ADDR offset)
{
  internal_error (__FILE__, __LINE__,
		  "Support for DW_OP_GNU_push_tls_address is unimplemented");
}

static CORE_ADDR
execute_stack_op (unsigned char *exp, ULONGEST len,
		  struct frame_info *next_frame, CORE_ADDR initial)
{
  struct dwarf_expr_context *ctx;
  CORE_ADDR result;

  ctx = new_dwarf_expr_context ();
  ctx->baton = next_frame;
  ctx->read_reg = read_reg;
  ctx->read_mem = read_mem;
  ctx->get_frame_base = no_get_frame_base;
  ctx->get_tls_address = no_get_tls_address;

  dwarf_expr_push (ctx, initial);
  dwarf_expr_eval (ctx, exp, len);
  result = dwarf_expr_fetch (ctx, 0);

  if (ctx->in_reg)
    result = read_reg (next_frame, result);

  free_dwarf_expr_context (ctx);

  return result;
}


static void
execute_cfa_program (unsigned char *insn_ptr, unsigned char *insn_end,
		     struct frame_info *next_frame,
		     struct dwarf2_frame_state *fs)
{
  CORE_ADDR pc = frame_pc_unwind (next_frame);
  int bytes_read;

  while (insn_ptr < insn_end && fs->pc <= pc)
    {
      unsigned char insn = *insn_ptr++;
      ULONGEST utmp, reg;
      LONGEST offset;

      if ((insn & 0xc0) == DW_CFA_advance_loc)
	fs->pc += (insn & 0x3f) * fs->code_align;
      else if ((insn & 0xc0) == DW_CFA_offset)
	{
	  reg = insn & 0x3f;
	  insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	  offset = utmp * fs->data_align;
	  dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	  fs->regs.reg[reg].how = REG_SAVED_OFFSET;
	  fs->regs.reg[reg].loc.offset = offset;
	}
      else if ((insn & 0xc0) == DW_CFA_restore)
	{
	  gdb_assert (fs->initial.reg);
	  reg = insn & 0x3f;
	  dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	  fs->regs.reg[reg] = fs->initial.reg[reg];
	}
      else
	{
	  switch (insn)
	    {
	    case DW_CFA_set_loc:
	      fs->pc = dwarf2_read_address (insn_ptr, insn_end, &bytes_read);
	      insn_ptr += bytes_read;
	      break;

	    case DW_CFA_advance_loc1:
	      utmp = extract_unsigned_integer (insn_ptr, 1);
	      fs->pc += utmp * fs->code_align;
	      insn_ptr++;
	      break;
	    case DW_CFA_advance_loc2:
	      utmp = extract_unsigned_integer (insn_ptr, 2);
	      fs->pc += utmp * fs->code_align;
	      insn_ptr += 2;
	      break;
	    case DW_CFA_advance_loc4:
	      utmp = extract_unsigned_integer (insn_ptr, 4);
	      fs->pc += utmp * fs->code_align;
	      insn_ptr += 4;
	      break;

	    case DW_CFA_offset_extended:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	      offset = utmp * fs->data_align;
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      fs->regs.reg[reg].how = REG_SAVED_OFFSET;
	      fs->regs.reg[reg].loc.offset = offset;
	      break;

	    case DW_CFA_restore_extended:
	      gdb_assert (fs->initial.reg);
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      fs->regs.reg[reg] = fs->initial.reg[reg];
	      break;

	    case DW_CFA_undefined:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      fs->regs.reg[reg].how = REG_UNSAVED;
	      break;

	    case DW_CFA_same_value:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      fs->regs.reg[reg].how = REG_UNMODIFIED;
	      break;

	    case DW_CFA_register:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      fs->regs.reg[reg].loc.reg = utmp;
	      break;

	    case DW_CFA_remember_state:
	      {
		struct dwarf2_frame_state_reg_info *new_rs;

		new_rs = XMALLOC (struct dwarf2_frame_state_reg_info);
		*new_rs = fs->regs;
		fs->regs.reg = dwarf2_frame_state_copy_regs (&fs->regs);
		fs->regs.prev = new_rs;
	      }
	      break;

	    case DW_CFA_restore_state:
	      {
		struct dwarf2_frame_state_reg_info *old_rs = fs->regs.prev;

		gdb_assert (old_rs);

		xfree (fs->regs.reg);
		fs->regs = *old_rs;
		xfree (old_rs);
	      }
	      break;

	    case DW_CFA_def_cfa:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &fs->cfa_reg);
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	      fs->cfa_offset = utmp;
	      fs->cfa_how = CFA_REG_OFFSET;
	      break;

	    case DW_CFA_def_cfa_register:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &fs->cfa_reg);
	      fs->cfa_how = CFA_REG_OFFSET;
	      break;

	    case DW_CFA_def_cfa_offset:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &fs->cfa_offset);
	      /* cfa_how deliberately not set.  */
	      break;

	    case DW_CFA_def_cfa_expression:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &fs->cfa_exp_len);
	      fs->cfa_exp = insn_ptr;
	      fs->cfa_how = CFA_EXP;
	      insn_ptr += fs->cfa_exp_len;
	      break;

	    case DW_CFA_expression:
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &reg);
	      dwarf2_frame_state_alloc_regs (&fs->regs, reg + 1);
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	      fs->regs.reg[reg].loc.exp = insn_ptr;
	      fs->regs.reg[reg].exp_len = utmp;
	      fs->regs.reg[reg].how = REG_SAVED_EXP;
	      insn_ptr += utmp;
	      break;

	    case DW_CFA_nop:
	      break;

	    case DW_CFA_GNU_args_size:
	      /* Ignored.  */
	      insn_ptr = read_uleb128 (insn_ptr, insn_end, &utmp);
	      break;

	    default:
	      internal_error (__FILE__, __LINE__, "Unknown CFI encountered.");
	    }
	}
    }

  /* Don't allow remember/restore between CIE and FDE programs.  */
  dwarf2_frame_state_free_regs (fs->regs.prev);
  fs->regs.prev = NULL;
}

struct dwarf2_frame_cache
{
  /* DWARF Call Frame Address.  */
  CORE_ADDR cfa;

  /* Saved registers, indexed by GDB register number, not by DWARF
     register number.  */
  struct dwarf2_frame_state_reg *reg;
};

static struct dwarf2_frame_cache *
dwarf2_frame_cache (struct frame_info *next_frame, void **this_cache)
{
  struct cleanup *old_chain;
  int num_regs = NUM_REGS + NUM_PSEUDO_REGS;
  struct dwarf2_frame_cache *cache;
  struct dwarf2_frame_state *fs;
  struct dwarf2_fde *fde;
  int reg;

  if (*this_cache)
    return *this_cache;

  /* Allocate a new cache.  */
  cache = FRAME_OBSTACK_ZALLOC (struct dwarf2_frame_cache);
  cache->reg = FRAME_OBSTACK_CALLOC (num_regs, struct dwarf2_frame_state_reg);

  /* Allocate and initialize the frame state.  */
  fs = XMALLOC (struct dwarf2_frame_state);
  memset (fs, 0, sizeof (struct dwarf2_frame_state));
  old_chain = make_cleanup (dwarf2_frame_state_free, fs);

  /* Unwind the PC.

     Note that if NEXT_FRAME is never supposed to return (i.e. a call
     to abort), the compiler might optimize away the instruction at
     NEXT_FRAME's return address.  As a result the return address will
     point at some random instruction, and the CFI for that
     instruction is probably wortless to us.  GCC's unwinder solves
     this problem by substracting 1 from the return address to get an
     address in the middle of a presumed call instruction (or the
     instruction in the associated delay slot).  This should only be
     done for "normal" frames and not for resume-type frames (signal
     handlers, sentinel frames, dummy frames).

     We don't do what GCC's does here (yet).  It's not clear how
     reliable the method is.  There's also a problem with finding the
     right FDE; see the comment in dwarf_frame_p.  If dwarf_frame_p
     selected this frame unwinder because it found the FDE for the
     next function, using the adjusted return address might not yield
     a FDE at all.  The problem isn't specific to DWARF CFI; other
     unwinders loose in similar ways.  Therefore it's probably
     acceptable to leave things slightly broken for now.  */
  fs->pc = frame_pc_unwind (next_frame);

  /* Find the correct FDE.  */
  fde = dwarf2_frame_find_fde (&fs->pc);
  gdb_assert (fde != NULL);

  /* Extract any interesting information from the CIE.  */
  fs->data_align = fde->cie->data_alignment_factor;
  fs->code_align = fde->cie->code_alignment_factor;
  fs->retaddr_column = fde->cie->return_address_register;

  /* First decode all the insns in the CIE.  */
  execute_cfa_program (fde->cie->initial_instructions,
		       fde->cie->end, next_frame, fs);

  /* Save the initialized register set.  */
  fs->initial = fs->regs;
  fs->initial.reg = dwarf2_frame_state_copy_regs (&fs->regs);

  /* Then decode the insns in the FDE up to our target PC.  */
  execute_cfa_program (fde->instructions, fde->end, next_frame, fs);

  /* Caclulate the CFA.  */
  switch (fs->cfa_how)
    {
    case CFA_REG_OFFSET:
      cache->cfa = read_reg (next_frame, fs->cfa_reg);
      cache->cfa += fs->cfa_offset;
      break;

    case CFA_EXP:
      cache->cfa =
	execute_stack_op (fs->cfa_exp, fs->cfa_exp_len, next_frame, 0);
      break;

    default:
      internal_error (__FILE__, __LINE__, "Unknown CFA rule.");
    }

  /* Save the register info in the cache.  */
  for (reg = 0; reg < fs->regs.num_regs; reg++)
    {
      int regnum;

      /* Skip the return address column.  */
      if (reg == fs->retaddr_column)
	/* NOTE: cagney/2003-06-07: Is this right?  What if the
           RETADDR_COLUM corresponds to a real register (and, worse,
           that isn't the PC_REGNUM)?  I'm guessing that the PC_REGNUM
           further down is trying to handle this.  That can't be right
           though - PC_REGNUM may not be valid (it can be -ve).  I
           think, instead when RETADDR_COLUM isn't a real register, it
           should map itself onto frame_pc_unwind.  */
	continue;

      /* Use the GDB register number as index.  */
      regnum = DWARF2_REG_TO_REGNUM (reg);

      if (regnum >= 0 && regnum < num_regs)
	cache->reg[regnum] = fs->regs.reg[reg];
    }

  /* Store the location of the return addess.  If the return address
     column (adjusted) is not the same as gdb's PC_REGNUM, then this
     implies a copy from the ra column register.  */
  if (fs->retaddr_column < fs->regs.num_regs
      && fs->regs.reg[fs->retaddr_column].how != REG_UNSAVED)
    {
      /* See comment above about a possibly -ve PC_REGNUM.  If this
         assertion fails, it's a problem with this code and not the
         architecture.  */
      gdb_assert (PC_REGNUM >= 0);
      cache->reg[PC_REGNUM] = fs->regs.reg[fs->retaddr_column];
    }
  else
    {
      reg = DWARF2_REG_TO_REGNUM (fs->retaddr_column);
      if (reg != PC_REGNUM)
	{
	  /* See comment above about PC_REGNUM being -ve.  If this
	     assertion fails, it's a problem with this code and not
	     the architecture.  */
	  gdb_assert (PC_REGNUM >= 0);
	  cache->reg[PC_REGNUM].loc.reg = reg;
	  cache->reg[PC_REGNUM].how = REG_SAVED_REG;
	}
    }

  do_cleanups (old_chain);

  *this_cache = cache;
  return cache;
}

static void
dwarf2_frame_this_id (struct frame_info *next_frame, void **this_cache,
		      struct frame_id *this_id)
{
  struct dwarf2_frame_cache *cache =
    dwarf2_frame_cache (next_frame, this_cache);

  (*this_id) = frame_id_build (cache->cfa, frame_func_unwind (next_frame));
}

static void
dwarf2_frame_prev_register (struct frame_info *next_frame, void **this_cache,
			    int regnum, int *optimizedp,
			    enum lval_type *lvalp, CORE_ADDR *addrp,
			    int *realnump, void *valuep)
{
  struct dwarf2_frame_cache *cache =
    dwarf2_frame_cache (next_frame, this_cache);

  switch (cache->reg[regnum].how)
    {
    case REG_UNSAVED:
      *optimizedp = 1;
      *lvalp = not_lval;
      *addrp = 0;
      *realnump = -1;
      if (regnum == SP_REGNUM)
	{
	  /* GCC defines the CFA as the value of the stack pointer
	     just before the call instruction is executed.  Do other
	     compilers use the same definition?  */
	  /* DWARF V3 Draft 7 p102: Typically, the CFA is defined to
	     be the value of the stack pointer at the call site in the
	     previous frame (which may be different from its value on
	     entry to the current frame).  */
	  /* DWARF V3 Draft 7 p103: The first column of the rules
             defines the rule which computes the CFA value; it may be
             either a register and a signed offset that are added
             together or a DWARF expression that is evaluated.  */
	  /* FIXME: cagney/2003-07-07: I don't understand this.  The
             CFI info should have provided unwind information for the
             SP register and then pointed ->cfa_reg at it, not the
             reverse.  Assuming that SP_REGNUM is !-ve, there is a
             very real posibility that CFA is an offset from some
             other register, having nothing to do with the unwound SP
             value.  */
	  *optimizedp = 0;
	  if (valuep)
	    {
	      /* Store the value.  */
	      store_typed_address (valuep, builtin_type_void_data_ptr,
				   cache->cfa);
	    }
	}
      else if (valuep)
	{
	  /* In some cases, for example %eflags on the i386, we have
	     to provide a sane value, even though this register wasn't
	     saved.  Assume we can get it from NEXT_FRAME.  */
	  frame_unwind_register (next_frame, regnum, valuep);
	}
      break;

    case REG_SAVED_OFFSET:
      *optimizedp = 0;
      *lvalp = lval_memory;
      *addrp = cache->cfa + cache->reg[regnum].loc.offset;
      *realnump = -1;
      if (valuep)
	{
	  /* Read the value in from memory.  */
	  read_memory (*addrp, valuep,
		       register_size (current_gdbarch, regnum));
	}
      break;

    case REG_SAVED_REG:
      regnum = DWARF2_REG_TO_REGNUM (cache->reg[regnum].loc.reg);
      frame_register_unwind (next_frame, regnum,
			     optimizedp, lvalp, addrp, realnump, valuep);
      break;

    case REG_SAVED_EXP:
      *optimizedp = 0;
      *lvalp = lval_memory;
      *addrp = execute_stack_op (cache->reg[regnum].loc.exp,
				 cache->reg[regnum].exp_len,
				 next_frame, cache->cfa);
      *realnump = -1;
      if (valuep)
	{
	  /* Read the value in from memory.  */
	  read_memory (*addrp, valuep,
		       register_size (current_gdbarch, regnum));
	}
      break;

    case REG_UNMODIFIED:
      frame_register_unwind (next_frame, regnum,
			     optimizedp, lvalp, addrp, realnump, valuep);
      break;

    default:
      internal_error (__FILE__, __LINE__, "Unknown register rule.");
    }
}

static const struct frame_unwind dwarf2_frame_unwind =
{
  NORMAL_FRAME,
  dwarf2_frame_this_id,
  dwarf2_frame_prev_register
};

const struct frame_unwind *
dwarf2_frame_p (CORE_ADDR pc)
{
  /* The way GDB works, this function can be called with PC just after
     the last instruction of the function we're supposed to return the
     unwind methods for.  In that case we won't find the correct FDE;
     instead we find the FDE for the next function, or we won't find
     an FDE at all.  There is a possible solution (see the comment in
     dwarf2_frame_cache), GDB doesn't pass us enough information to
     implement it.  */
  if (dwarf2_frame_find_fde (&pc))
    return &dwarf2_frame_unwind;

  return NULL;
}


/* There is no explicitly defined relationship between the CFA and the
   location of frame's local variables and arguments/parameters.
   Therefore, frame base methods on this page should probably only be
   used as a last resort, just to avoid printing total garbage as a
   response to the "info frame" command.  */

static CORE_ADDR
dwarf2_frame_base_address (struct frame_info *next_frame, void **this_cache)
{
  struct dwarf2_frame_cache *cache =
    dwarf2_frame_cache (next_frame, this_cache);

  return cache->cfa;
}

static const struct frame_base dwarf2_frame_base =
{
  &dwarf2_frame_unwind,
  dwarf2_frame_base_address,
  dwarf2_frame_base_address,
  dwarf2_frame_base_address
};

const struct frame_base *
dwarf2_frame_base_p (CORE_ADDR pc)
{
  if (dwarf2_frame_find_fde (&pc))
    return &dwarf2_frame_base;

  return NULL;
}

/* A minimal decoding of DWARF2 compilation units.  We only decode
   what's needed to get to the call frame information.  */

struct comp_unit
{
  /* Keep the bfd convenient.  */
  bfd *abfd;

  struct objfile *objfile;

  /* Linked list of CIEs for this object.  */
  struct dwarf2_cie *cie;

  /* Address size for this unit - from unit header.  */
  unsigned char addr_size;

  /* Pointer to the .debug_frame section loaded into memory.  */
  char *dwarf_frame_buffer;

  /* Length of the loaded .debug_frame section.  */
  unsigned long dwarf_frame_size;

  /* Pointer to the .debug_frame section.  */
  asection *dwarf_frame_section;

  /* Base for DW_EH_PE_datarel encodings.  */
  bfd_vma dbase;
};

static unsigned int
read_1_byte (bfd *bfd, char *buf)
{
  return bfd_get_8 (abfd, (bfd_byte *) buf);
}

static unsigned int
read_4_bytes (bfd *abfd, char *buf)
{
  return bfd_get_32 (abfd, (bfd_byte *) buf);
}

static ULONGEST
read_8_bytes (bfd *abfd, char *buf)
{
  return bfd_get_64 (abfd, (bfd_byte *) buf);
}

static ULONGEST
read_unsigned_leb128 (bfd *abfd, char *buf, unsigned int *bytes_read_ptr)
{
  ULONGEST result;
  unsigned int num_read;
  int shift;
  unsigned char byte;

  result = 0;
  shift = 0;
  num_read = 0;

  do
    {
      byte = bfd_get_8 (abfd, (bfd_byte *) buf);
      buf++;
      num_read++;
      result |= ((byte & 0x7f) << shift);
      shift += 7;
    }
  while (byte & 0x80);

  *bytes_read_ptr = num_read;

  return result;
}

static LONGEST
read_signed_leb128 (bfd *abfd, char *buf, unsigned int *bytes_read_ptr)
{
  LONGEST result;
  int shift;
  unsigned int num_read;
  unsigned char byte;

  result = 0;
  shift = 0;
  num_read = 0;

  do
    {
      byte = bfd_get_8 (abfd, (bfd_byte *) buf);
      buf++;
      num_read++;
      result |= ((byte & 0x7f) << shift);
      shift += 7;
    }
  while (byte & 0x80);

  if ((shift < 32) && (byte & 0x40))
    result |= -(1 << shift);

  *bytes_read_ptr = num_read;

  return result;
}

static ULONGEST
read_initial_length (bfd *abfd, char *buf, unsigned int *bytes_read_ptr)
{
  LONGEST result;

  result = bfd_get_32 (abfd, (bfd_byte *) buf);
  if (result == 0xffffffff)
    {
      result = bfd_get_64 (abfd, (bfd_byte *) buf + 4);
      *bytes_read_ptr = 12;
    }
  else
    *bytes_read_ptr = 4;

  return result;
}


/* Pointer encoding helper functions.  */

/* GCC supports exception handling based on DWARF2 CFI.  However, for
   technical reasons, it encodes addresses in its FDE's in a different
   way.  Several "pointer encodings" are supported.  The encoding
   that's used for a particular FDE is determined by the 'R'
   augmentation in the associated CIE.  The argument of this
   augmentation is a single byte.  

   The address can be encoded as 2 bytes, 4 bytes, 8 bytes, or as a
   LEB128.  This is encoded in bits 0, 1 and 2.  Bit 3 encodes whether
   the address is signed or unsigned.  Bits 4, 5 and 6 encode how the
   address should be interpreted (absolute, relative to the current
   position in the FDE, ...).  Bit 7, indicates that the address
   should be dereferenced.  */

static unsigned char
encoding_for_size (unsigned int size)
{
  switch (size)
    {
    case 2:
      return DW_EH_PE_udata2;
    case 4:
      return DW_EH_PE_udata4;
    case 8:
      return DW_EH_PE_udata8;
    default:
      internal_error (__FILE__, __LINE__, "Unsupported address size");
    }
}

static unsigned int
size_of_encoded_value (unsigned char encoding)
{
  if (encoding == DW_EH_PE_omit)
    return 0;

  switch (encoding & 0x07)
    {
    case DW_EH_PE_absptr:
      return TYPE_LENGTH (builtin_type_void_data_ptr);
    case DW_EH_PE_udata2:
      return 2;
    case DW_EH_PE_udata4:
      return 4;
    case DW_EH_PE_udata8:
      return 8;
    default:
      internal_error (__FILE__, __LINE__, "Invalid or unsupported encoding");
    }
}

static CORE_ADDR
read_encoded_value (struct comp_unit *unit, unsigned char encoding,
		    char *buf, unsigned int *bytes_read_ptr)
{
  CORE_ADDR base;

  /* GCC currently doesn't generate DW_EH_PE_indirect encodings for
     FDE's.  */
  if (encoding & DW_EH_PE_indirect)
    internal_error (__FILE__, __LINE__, 
		    "Unsupported encoding: DW_EH_PE_indirect");

  switch (encoding & 0x70)
    {
    case DW_EH_PE_absptr:
      base = 0;
      break;
    case DW_EH_PE_pcrel:
      base = bfd_get_section_vma (unit->bfd, unit->dwarf_frame_section);
      base += (buf - unit->dwarf_frame_buffer);
      break;
    case DW_EH_PE_datarel:
      base = unit->dbase;
      break;
    default:
      internal_error (__FILE__, __LINE__, "Invalid or unsupported encoding");
    }

  if ((encoding & 0x0f) == 0x00)
    encoding |= encoding_for_size (TYPE_LENGTH(builtin_type_void_data_ptr));

  switch (encoding & 0x0f)
    {
    case DW_EH_PE_udata2:
      *bytes_read_ptr = 2;
      return (base + bfd_get_16 (unit->abfd, (bfd_byte *) buf));
    case DW_EH_PE_udata4:
      *bytes_read_ptr = 4;
      return (base + bfd_get_32 (unit->abfd, (bfd_byte *) buf));
    case DW_EH_PE_udata8:
      *bytes_read_ptr = 8;
      return (base + bfd_get_64 (unit->abfd, (bfd_byte *) buf));
    case DW_EH_PE_sdata2:
      *bytes_read_ptr = 2;
      return (base + bfd_get_signed_16 (unit->abfd, (bfd_byte *) buf));
    case DW_EH_PE_sdata4:
      *bytes_read_ptr = 4;
      return (base + bfd_get_signed_32 (unit->abfd, (bfd_byte *) buf));
    case DW_EH_PE_sdata8:
      *bytes_read_ptr = 8;
      return (base + bfd_get_signed_64 (unit->abfd, (bfd_byte *) buf));
    default:
      internal_error (__FILE__, __LINE__, "Invalid or unsupported encoding");
    }
}


/* GCC uses a single CIE for all FDEs in a .debug_frame section.
   That's why we use a simple linked list here.  */

static struct dwarf2_cie *
find_cie (struct comp_unit *unit, ULONGEST cie_pointer)
{
  struct dwarf2_cie *cie = unit->cie;

  while (cie)
    {
      if (cie->cie_pointer == cie_pointer)
	return cie;

      cie = cie->next;
    }

  return NULL;
}

static void
add_cie (struct comp_unit *unit, struct dwarf2_cie *cie)
{
  cie->next = unit->cie;
  unit->cie = cie;
}

/* Find the FDE for *PC.  Return a pointer to the FDE, and store the
   inital location associated with it into *PC.  */

static struct dwarf2_fde *
dwarf2_frame_find_fde (CORE_ADDR *pc)
{
  struct objfile *objfile;

  ALL_OBJFILES (objfile)
    {
      struct dwarf2_fde *fde;
      CORE_ADDR offset;

      offset = ANOFFSET (objfile->section_offsets, SECT_OFF_TEXT (objfile));
      
      fde = objfile->sym_private;
      while (fde)
	{
	  if (*pc >= fde->initial_location + offset
	      && *pc < fde->initial_location + offset + fde->address_range)
	    {
	      *pc = fde->initial_location + offset;
	      return fde;
	    }

	  fde = fde->next;
	}
    }

  return NULL;
}

static void
add_fde (struct comp_unit *unit, struct dwarf2_fde *fde)
{
  fde->next = unit->objfile->sym_private;
  unit->objfile->sym_private = fde;
}

#ifdef CC_HAS_LONG_LONG
#define DW64_CIE_ID 0xffffffffffffffffULL
#else
#define DW64_CIE_ID ~0
#endif

static char *decode_frame_entry (struct comp_unit *unit, char *start,
				 int eh_frame_p);

/* Decode the next CIE or FDE.  Return NULL if invalid input, otherwise
   the next byte to be processed.  */
static char *
decode_frame_entry_1 (struct comp_unit *unit, char *start, int eh_frame_p)
{
  char *buf;
  LONGEST length;
  unsigned int bytes_read;
  int dwarf64_p;
  ULONGEST cie_id;
  ULONGEST cie_pointer;
  char *end;

  buf = start;
  length = read_initial_length (unit->abfd, buf, &bytes_read);
  buf += bytes_read;
  end = buf + length;

  /* Are we still within the section? */
  if (end > unit->dwarf_frame_buffer + unit->dwarf_frame_size)
    return NULL;

  if (length == 0)
    return end;

  /* Distinguish between 32 and 64-bit encoded frame info.  */
  dwarf64_p = (bytes_read == 12);

  /* In a .eh_frame section, zero is used to distinguish CIEs from FDEs.  */
  if (eh_frame_p)
    cie_id = 0;
  else if (dwarf64_p)
    cie_id = DW64_CIE_ID;
  else
    cie_id = DW_CIE_ID;

  if (dwarf64_p)
    {
      cie_pointer = read_8_bytes (unit->abfd, buf);
      buf += 8;
    }
  else
    {
      cie_pointer = read_4_bytes (unit->abfd, buf);
      buf += 4;
    }

  if (cie_pointer == cie_id)
    {
      /* This is a CIE.  */
      struct dwarf2_cie *cie;
      char *augmentation;

      /* Record the offset into the .debug_frame section of this CIE.  */
      cie_pointer = start - unit->dwarf_frame_buffer;

      /* Check whether we've already read it.  */
      if (find_cie (unit, cie_pointer))
	return end;

      cie = (struct dwarf2_cie *)
	obstack_alloc (&unit->objfile->psymbol_obstack,
		       sizeof (struct dwarf2_cie));
      cie->initial_instructions = NULL;
      cie->cie_pointer = cie_pointer;

      /* The encoding for FDE's in a normal .debug_frame section
         depends on the target address size as specified in the
         Compilation Unit Header.  */
      cie->encoding = encoding_for_size (unit->addr_size);

      /* Check version number.  */
      if (read_1_byte (unit->abfd, buf) != DW_CIE_VERSION)
	return NULL;
      buf += 1;

      /* Interpret the interesting bits of the augmentation.  */
      augmentation = buf;
      buf = augmentation + strlen (augmentation) + 1;

      /* The GCC 2.x "eh" augmentation has a pointer immediately
         following the augmentation string, so it must be handled
         first.  */
      if (augmentation[0] == 'e' && augmentation[1] == 'h')
	{
	  /* Skip.  */
	  buf += TYPE_LENGTH (builtin_type_void_data_ptr);
	  augmentation += 2;
	}

      cie->code_alignment_factor =
	read_unsigned_leb128 (unit->abfd, buf, &bytes_read);
      buf += bytes_read;

      cie->data_alignment_factor =
	read_signed_leb128 (unit->abfd, buf, &bytes_read);
      buf += bytes_read;

      cie->return_address_register = read_1_byte (unit->abfd, buf);
      buf += 1;

      cie->saw_z_augmentation = (*augmentation == 'z');
      if (cie->saw_z_augmentation)
	{
	  ULONGEST length;

	  length = read_unsigned_leb128 (unit->abfd, buf, &bytes_read);
	  buf += bytes_read;
	  if (buf > end)
	    return NULL;
	  cie->initial_instructions = buf + length;
	  augmentation++;
	}

      while (*augmentation)
	{
	  /* "L" indicates a byte showing how the LSDA pointer is encoded.  */
	  if (*augmentation == 'L')
	    {
	      /* Skip.  */
	      buf++;
	      augmentation++;
	    }

	  /* "R" indicates a byte indicating how FDE addresses are encoded.  */
	  else if (*augmentation == 'R')
	    {
	      cie->encoding = *buf++;
	      augmentation++;
	    }

	  /* "P" indicates a personality routine in the CIE augmentation.  */
	  else if (*augmentation == 'P')
	    {
	      /* Skip.  */
	      buf += size_of_encoded_value (*buf++);
	      augmentation++;
	    }

	  /* Otherwise we have an unknown augmentation.
	     Bail out unless we saw a 'z' prefix.  */
	  else
	    {
	      if (cie->initial_instructions == NULL)
		return end;

	      /* Skip unknown augmentations.  */
	      buf = cie->initial_instructions;
	      break;
	    }
	}

      cie->initial_instructions = buf;
      cie->end = end;

      add_cie (unit, cie);
    }
  else
    {
      /* This is a FDE.  */
      struct dwarf2_fde *fde;

      /* In an .eh_frame section, the CIE pointer is the delta between the
	 address within the FDE where the CIE pointer is stored and the
	 address of the CIE.  Convert it to an offset into the .eh_frame
	 section.  */
      if (eh_frame_p)
	{
	  cie_pointer = buf - unit->dwarf_frame_buffer - cie_pointer;
	  cie_pointer -= (dwarf64_p ? 8 : 4);
	}

      /* In either case, validate the result is still within the section.  */
      if (cie_pointer >= unit->dwarf_frame_size)
	return NULL;

      fde = (struct dwarf2_fde *)
	obstack_alloc (&unit->objfile->psymbol_obstack,
		       sizeof (struct dwarf2_fde));
      fde->cie = find_cie (unit, cie_pointer);
      if (fde->cie == NULL)
	{
	  decode_frame_entry (unit, unit->dwarf_frame_buffer + cie_pointer,
			      eh_frame_p);
	  fde->cie = find_cie (unit, cie_pointer);
	}

      gdb_assert (fde->cie != NULL);

      fde->initial_location =
	read_encoded_value (unit, fde->cie->encoding, buf, &bytes_read);
      buf += bytes_read;

      fde->address_range =
	read_encoded_value (unit, fde->cie->encoding & 0x0f, buf, &bytes_read);
      buf += bytes_read;

      /* A 'z' augmentation in the CIE implies the presence of an
	 augmentation field in the FDE as well.  The only thing known
	 to be in here at present is the LSDA entry for EH.  So we
	 can skip the whole thing.  */
      if (fde->cie->saw_z_augmentation)
	{
	  ULONGEST length;

	  length = read_unsigned_leb128 (unit->abfd, buf, &bytes_read);
	  buf += bytes_read + length;
	  if (buf > end)
	    return NULL;
	}

      fde->instructions = buf;
      fde->end = end;

      add_fde (unit, fde);
    }

  return end;
}

/* Read a CIE or FDE in BUF and decode it.  */
static char *
decode_frame_entry (struct comp_unit *unit, char *start, int eh_frame_p)
{
  enum { NONE, ALIGN4, ALIGN8, FAIL } workaround = NONE;
  char *ret;
  const char *msg;
  ptrdiff_t start_offset;

  while (1)
    {
      ret = decode_frame_entry_1 (unit, start, eh_frame_p);
      if (ret != NULL)
	break;

      /* We have corrupt input data of some form.  */

      /* ??? Try, weakly, to work around compiler/assembler/linker bugs
	 and mismatches wrt padding and alignment of debug sections.  */
      /* Note that there is no requirement in the standard for any
	 alignment at all in the frame unwind sections.  Testing for
	 alignment before trying to interpret data would be incorrect.

	 However, GCC traditionally arranged for frame sections to be
	 sized such that the FDE length and CIE fields happen to be
	 aligned (in theory, for performance).  This, unfortunately,
	 was done with .align directives, which had the side effect of
	 forcing the section to be aligned by the linker.

	 This becomes a problem when you have some other producer that
	 creates frame sections that are not as strictly aligned.  That
	 produces a hole in the frame info that gets filled by the 
	 linker with zeros.

	 The GCC behaviour is arguably a bug, but it's effectively now
	 part of the ABI, so we're now stuck with it, at least at the
	 object file level.  A smart linker may decide, in the process
	 of compressing duplicate CIE information, that it can rewrite
	 the entire output section without this extra padding.  */

      start_offset = start - unit->dwarf_frame_buffer;
      if (workaround < ALIGN4 && (start_offset & 3) != 0)
	{
	  start += 4 - (start_offset & 3);
	  workaround = ALIGN4;
	  continue;
	}
      if (workaround < ALIGN8 && (start_offset & 7) != 0)
	{
	  start += 8 - (start_offset & 7);
	  workaround = ALIGN8;
	  continue;
	}

      /* Nothing left to try.  Arrange to return as if we've consumed
	 the entire input section.  Hopefully we'll get valid info from
	 the other of .debug_frame/.eh_frame.  */
      workaround = FAIL;
      ret = unit->dwarf_frame_buffer + unit->dwarf_frame_size;
      break;
    }

  switch (workaround)
    {
    case NONE:
      break;

    case ALIGN4:
      complaint (&symfile_complaints,
		 "Corrupt data in %s:%s; align 4 workaround apparently succeeded",
		 unit->dwarf_frame_section->owner->filename,
		 unit->dwarf_frame_section->name);
      break;

    case ALIGN8:
      complaint (&symfile_complaints,
		 "Corrupt data in %s:%s; align 8 workaround apparently succeeded",
		 unit->dwarf_frame_section->owner->filename,
		 unit->dwarf_frame_section->name);
      break;

    default:
      complaint (&symfile_complaints,
		 "Corrupt data in %s:%s",
		 unit->dwarf_frame_section->owner->filename,
		 unit->dwarf_frame_section->name);
      break;
    }

  return ret;
}



/* FIXME: kettenis/20030504: This still needs to be integrated with
   dwarf2read.c in a better way.  */

/* Imported from dwarf2read.c.  */
extern file_ptr dwarf_frame_offset;
extern unsigned int dwarf_frame_size;
extern asection *dwarf_frame_section;
extern file_ptr dwarf_eh_frame_offset;
extern unsigned int dwarf_eh_frame_size;
extern asection *dwarf_eh_frame_section;

/* Imported from dwarf2read.c.  */
extern char *dwarf2_read_section (struct objfile *objfile, file_ptr offset,
				  unsigned int size, asection *sectp);

void
dwarf2_build_frame_info (struct objfile *objfile)
{
  struct comp_unit unit;
  char *frame_ptr;

  /* Build a minimal decoding of the DWARF2 compilation unit.  */
  unit.abfd = objfile->obfd;
  unit.objfile = objfile;
  unit.addr_size = objfile->obfd->arch_info->bits_per_address / 8;
  unit.dbase = 0;

  /* First add the information from the .eh_frame section.  That way,
     the FDEs from that section are searched last.  */
  if (dwarf_eh_frame_offset)
    {
      asection *got;

      unit.cie = NULL;
      unit.dwarf_frame_buffer = dwarf2_read_section (objfile,
						     dwarf_eh_frame_offset,
						     dwarf_eh_frame_size,
						     dwarf_eh_frame_section);

      unit.dwarf_frame_size = dwarf_eh_frame_size;
      unit.dwarf_frame_section = dwarf_eh_frame_section;

      /* FIXME: kettenis/20030602: This is the DW_EH_PE_datarel base
	 that for the i386/amd64 target, which currently is the only
	 target in GCC that supports/uses the DW_EH_PE_datarel
	 encoding.  */
      got = bfd_get_section_by_name (unit.abfd, ".got");
      if (got)
	unit.dbase = got->vma;

      frame_ptr = unit.dwarf_frame_buffer;
      while (frame_ptr < unit.dwarf_frame_buffer + unit.dwarf_frame_size)
	frame_ptr = decode_frame_entry (&unit, frame_ptr, 1);
    }

  if (dwarf_frame_offset)
    {
      unit.cie = NULL;
      unit.dwarf_frame_buffer = dwarf2_read_section (objfile,
						     dwarf_frame_offset,
						     dwarf_frame_size,
						     dwarf_frame_section);
      unit.dwarf_frame_size = dwarf_frame_size;
      unit.dwarf_frame_section = dwarf_frame_section;

      frame_ptr = unit.dwarf_frame_buffer;
      while (frame_ptr < unit.dwarf_frame_buffer + unit.dwarf_frame_size)
	frame_ptr = decode_frame_entry (&unit, frame_ptr, 0);
    }
}
