/* Target-dependent code for the nanoMIPS architecture, for GDB,
   the GNU Debugger.

   Copyright (C) 2017 Free Software Foundation, Inc.
   Contributed by <FIXME-MIPS>

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include "defs.h"
#include "frame.h"
#include "inferior.h"
#include "symtab.h"
#include "value.h"
#include "gdbcmd.h"
#include "language.h"
#include "gdbcore.h"
#include "symfile.h"
#include "objfiles.h"
#include "gdbtypes.h"
#include "target.h"
#include "arch-utils.h"
#include "regcache.h"
#include "osabi.h"
#include "nanomips-tdep.h"
#include "block.h"
#include "reggroups.h"
#include "opcode/nanomips.h"
#include "elf/mips-common.h"
#include "elf/nanomips.h"
#include "elf-bfd.h"
#include "symcat.h"
#include "sim-regno.h"
#include "dis-asm.h"
#include "disasm.h"
#include "frame-unwind.h"
#include "frame-base.h"
#include "trad-frame.h"
#include "infcall.h"
#include "floatformat.h"
#include "remote.h"
#include "target-descriptions.h"
#include "dwarf2-frame.h"
#include "user-regs.h"
#include "valprint.h"
#include "ax.h"
#include <algorithm>

#include "features/nanomips.c"

static const struct objfile_data *nanomips_pdr_data;

/* The sizes of registers.  */

enum
{
  NANOMIPS32_REGSIZE = 4,
  NANOMIPS64_REGSIZE = 8
};

static const char *const nanomips_abi_strings[] = {
  "auto",
  "p32",
  "p64",
  NULL
};

/* Enum describing the different kinds of breakpoints.  */

enum nanomips_breakpoint_kind
{
  /* 16-bit breakpoint.  */
  NANOMIPS_BP_KIND_16 = 3,

  /* 32-bit breakpoint.  */
  NANOMIPS_BP_KIND_32 = 5,
};

/* The standard register names, and all the valid aliases for them.  */
struct register_alias
{
  const char *name;
  int regnum;
};

/* Aliases for ABI-independent registers.  */
const struct register_alias nanomips_register_aliases[] = {
  /* The architecture manuals specify these ABI-independent names for
     the GPRs.  */
#define R(n) { "r" #n, n }
  R(0), R(1), R(2), R(3), R(4), R(5), R(6), R(7),
  R(8), R(9), R(10), R(11), R(12), R(13), R(14), R(15),
  R(16), R(17), R(18), R(19), R(20), R(21), R(22), R(23),
  R(24), R(25), R(26), R(27), R(28), R(29), R(30), R(31),
#undef R

  /* k0 and k1 are sometimes called these instead (for "kernel
     temp").  */
  { "kt0", 26 },
  { "kt1", 27 },

  /* This is the traditional GDB name for the CP0 status register.  */
  { "sr", PS_REGNUM },

  /* This is the traditional GDB name for the CP0 BadVAddr register.  */
  { "bad", EMBED_BADVADDR_REGNUM },

  /* This is the traditional GDB name for the FCSR.  */
  { "fsr", EMBED_FP0_REGNUM + 32 }
};

static unsigned int nanomips_debug = 0;

/* Properties (for struct target_desc) describing the g/G packet
   layout.  */
#define PROPERTY_GP32 "internal: transfers-32bit-registers"
#define PROPERTY_GP64 "internal: transfers-64bit-registers"

struct target_desc *nanomips_tdesc_gp32;
struct target_desc *nanomips_tdesc_gp64;

const struct nanomips_regnum *
nanomips_regnum (struct gdbarch *gdbarch)
{
  return gdbarch_tdep (gdbarch)->regnum;
}

static int
nanomips_fp_arg_regnum (struct gdbarch *gdbarch)
{
  return nanomips_regnum (gdbarch)->fp0;
}

/* Return 1 if REGNUM refers to a floating-point general register, raw
   or cooked.  Otherwise return 0.  */

static int
nanomips_float_register_p (struct gdbarch *gdbarch, int regnum)
{
  int rawnum = regnum % gdbarch_num_regs (gdbarch);

  return (rawnum >= nanomips_regnum (gdbarch)->fp0
	  && rawnum < nanomips_regnum (gdbarch)->fp0 + 32);
}

#define FPU_TYPE(gdbarch) (gdbarch_tdep (gdbarch)->fpu_type)

/* Return the nanoMIPS ABI associated with GDBARCH.  */
enum nanomips_abi
nanomips_abi (struct gdbarch *gdbarch)
{
  return gdbarch_tdep (gdbarch)->nanomips_abi;
}

int
nanomips_isa_regsize (struct gdbarch *gdbarch)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);

  /* If we know how big the registers are, use that size.  */
  if (tdep->register_size_valid_p)
    return tdep->register_size;

  /* Fall back to the previous behavior.  */
  return (gdbarch_bfd_arch_info (gdbarch)->bits_per_word
	  / gdbarch_bfd_arch_info (gdbarch)->bits_per_byte);
}

/* Return the currently configured (or set) saved register size.  */

unsigned int
nanomips_abi_regsize (struct gdbarch *gdbarch)
{
  switch (nanomips_abi (gdbarch))
    {
    case NANOMIPS_ABI_P32:
      return 4;
    case NANOMIPS_ABI_P64:
      return 8;
    case NANOMIPS_ABI_UNKNOWN:
    default:
      internal_error (__FILE__, __LINE__, _("bad switch"));
    }
}

static void
nanomips_xfer_register (struct gdbarch *gdbarch, struct regcache *regcache,
        int reg_num, int length,
        enum bfd_endian endian, gdb_byte *in,
        const gdb_byte *out, int buf_offset)
{
  int reg_offset = 0;

  gdb_assert (reg_num >= gdbarch_num_regs (gdbarch));
  /* Need to transfer the left or right part of the register, based on
     the targets byte order.  */
  switch (endian)
    {
    case BFD_ENDIAN_BIG:
      reg_offset = register_size (gdbarch, reg_num) - length;
      break;
    case BFD_ENDIAN_LITTLE:
      reg_offset = 0;
      break;
    case BFD_ENDIAN_UNKNOWN:  /* Indicates no alignment.  */
      reg_offset = 0;
      break;
    default:
      internal_error (__FILE__, __LINE__, _("bad switch"));
    }
  if (nanomips_debug)
    fprintf_unfiltered (gdb_stderr,
      "xfer $%d, reg offset %d, buf offset %d, length %d, ",
      reg_num, reg_offset, buf_offset, length);
  if (nanomips_debug && out != NULL)
    {
      int i;
      fprintf_unfiltered (gdb_stdlog, "out ");
      for (i = 0; i < length; i++)
  fprintf_unfiltered (gdb_stdlog, "%02x", out[buf_offset + i]);
    }
  if (in != NULL)
    regcache_cooked_read_part (regcache, reg_num, reg_offset, length,
             in + buf_offset);
  if (out != NULL)
    regcache_cooked_write_part (regcache, reg_num, reg_offset, length,
        out + buf_offset);
  if (nanomips_debug && in != NULL)
    {
      int i;
      fprintf_unfiltered (gdb_stdlog, "in ");
      for (i = 0; i < length; i++)
  fprintf_unfiltered (gdb_stdlog, "%02x", in[buf_offset + i]);
    }
  if (nanomips_debug)
    fprintf_unfiltered (gdb_stdlog, "\n");
}

#define VM_MIN_ADDRESS (CORE_ADDR)0x400000

static CORE_ADDR heuristic_proc_start (struct gdbarch *, CORE_ADDR);

static void reinit_frame_cache_sfunc (char *, int, struct cmd_list_element *);

/* The list of available "set nanomips " and "show nanomips " commands.  */

static struct cmd_list_element *setnanomipscmdlist = NULL;
static struct cmd_list_element *shownanomipscmdlist = NULL;

/* Integer registers 0 thru 31 are handled explicitly by
   nanomips_register_name().  Processor specific registers 32 and above
   are listed in the following tables.  */

enum
{ NUM_PROCESSOR_REGS = (90 - 32) };

/* Generic nanoMIPS.  */

static const char *nanomips_generic_reg_names[NUM_PROCESSOR_REGS] = {
  "sr", "bad", "cause", "pc",
  "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
  "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
  "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
  "fsr", "fir",
};

/* Names of registers with Linux kernels.  */
static const char *nanomips_linux_reg_names[NUM_PROCESSOR_REGS] = {
  "sr", "bad", "cause", "pc",
  "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
  "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
  "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
  "fsr", "fir"
};


/* Return the name of the register corresponding to REGNO.  */
static const char *
nanomips_register_name (struct gdbarch *gdbarch, int regno)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
  /* GPR names for p32 and p64 ABIs.  */
  static const char *gpr_names[] = {
    "zero", "at", "t4", "t5", "a0", "a1", "a2", "a3",
    "a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
    "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
    "t8", "t9", "k0", "k1", "gp", "sp", "raw_fp", "ra"
  };

  /* Map [gdbarch_num_regs .. 2*gdbarch_num_regs) onto the raw registers,
     but then don't make the raw register names visible.  This (upper)
     range of user visible register numbers are the pseudo-registers.

     This approach was adopted accommodate the following scenario:
     It is possible to debug a 64-bit device using a 32-bit
     programming model.  In such instances, the raw registers are
     configured to be 64-bits wide, while the pseudo registers are
     configured to be 32-bits wide.  The registers that the user
     sees - the pseudo registers - match the users expectations
     given the programming model being used.  */
  int rawnum = regno % gdbarch_num_regs (gdbarch);
  if (regno < gdbarch_num_regs (gdbarch))
    return "";

  /* The nanoMIPS integer registers are always mapped from 0 to 31.  The
     names of the registers (which reflects the conventions regarding
     register use) vary depending on the ABI.  */
  if (0 <= rawnum && rawnum < 32)
    return gpr_names[rawnum];
  else if (tdesc_has_registers (gdbarch_target_desc (gdbarch)))
    return tdesc_register_name (gdbarch, rawnum);
  else if (32 <= rawnum && rawnum < gdbarch_num_regs (gdbarch))
    {
      gdb_assert (rawnum - 32 < NUM_PROCESSOR_REGS);
      if (tdep->mips_processor_reg_names[rawnum - 32])
	return tdep->mips_processor_reg_names[rawnum - 32];
      return "";
    }
  else
    internal_error (__FILE__, __LINE__,
		    _("nanomips_register_name: bad register number %d"),
		    rawnum);
}

/* Return the groups that a nanoMIPS register can be categorised into.  */

static int
nanomips_register_reggroup_p (struct gdbarch *gdbarch, int regnum,
			      struct reggroup *reggroup)
{
  int vector_p;
  int float_p;
  int raw_p;
  int rawnum = regnum % gdbarch_num_regs (gdbarch);
  int pseudo = regnum / gdbarch_num_regs (gdbarch);
  if (reggroup == all_reggroup)
    return pseudo;
  vector_p = TYPE_VECTOR (register_type (gdbarch, regnum));
  float_p = (nanomips_float_register_p (gdbarch, rawnum) ||
	     rawnum == nanomips_regnum (gdbarch)->fp_control_status ||
	     rawnum == nanomips_regnum (gdbarch)->fp_implementation_revision);
  /* FIXME: cagney/2003-04-13: Can't yet use gdbarch_num_regs
     (gdbarch), as not all architectures are multi-arch.  */
  raw_p = rawnum < gdbarch_num_regs (gdbarch);
  if (gdbarch_register_name (gdbarch, regnum) == NULL
      || gdbarch_register_name (gdbarch, regnum)[0] == '\0')
    return 0;
  if (reggroup == float_reggroup)
    return float_p && pseudo;
  if (reggroup == vector_reggroup)
    return vector_p && pseudo;
  if (reggroup == general_reggroup)
    return (!vector_p && !float_p) && pseudo;
  /* Save the pseudo registers.  Need to make certain that any code
     extracting register values from a saved register cache also uses
     pseudo registers.  */
  if (reggroup == save_reggroup)
    return raw_p && pseudo;
  /* Restore the same pseudo register.  */
  if (reggroup == restore_reggroup)
    return raw_p && pseudo;
  return 0;
}

/* Return the groups that a nanoMIPS register can be categorised into.
   This version is only used if we have a target description which
   describes real registers (and their groups).  */

static int
nanomips_tdesc_register_reggroup_p (struct gdbarch *gdbarch, int regnum,
				    struct reggroup *reggroup)
{
  int rawnum = regnum % gdbarch_num_regs (gdbarch);
  int pseudo = regnum / gdbarch_num_regs (gdbarch);
  int ret;

  /* Only save, restore, and display the pseudo registers.  Need to
     make certain that any code extracting register values from a
     saved register cache also uses pseudo registers.

     Note: saving and restoring the pseudo registers is slightly
     strange; if we have 64 bits, we should save and restore all
     64 bits.  But this is hard and has little benefit.  */
  if (!pseudo)
    return 0;

  ret = tdesc_register_in_reggroup_p (gdbarch, rawnum, reggroup);
  if (ret != -1)
    return ret;

  return nanomips_register_reggroup_p (gdbarch, regnum, reggroup);
}

/* Map the symbol table registers which live in the range [1 *
   gdbarch_num_regs .. 2 * gdbarch_num_regs) back onto the corresponding raw
   registers.  Take care of alignment and size problems.  */

static enum register_status
nanomips_pseudo_register_read (struct gdbarch *gdbarch,
			       struct regcache *regcache,
			       int cookednum, gdb_byte *buf)
{
  int rawnum = cookednum % gdbarch_num_regs (gdbarch);
  gdb_assert (cookednum >= gdbarch_num_regs (gdbarch)
	      && cookednum < 2 * gdbarch_num_regs (gdbarch));
  if (register_size (gdbarch, rawnum) == register_size (gdbarch, cookednum))
    return regcache_raw_read (regcache, rawnum, buf);
  else if (register_size (gdbarch, rawnum) >
	   register_size (gdbarch, cookednum))
    {
      enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
      LONGEST regval;
      enum register_status status;

      status = regcache_raw_read_signed (regcache, rawnum, &regval);
      if (status == REG_VALID)
        store_signed_integer (buf, 4, byte_order, regval);
      return status;
    }
  else
    internal_error (__FILE__, __LINE__, _("bad register size"));
}

static void
nanomips_pseudo_register_write (struct gdbarch *gdbarch,
				struct regcache *regcache, int cookednum,
				const gdb_byte *buf)
{
  int rawnum = cookednum % gdbarch_num_regs (gdbarch);
  gdb_assert (cookednum >= gdbarch_num_regs (gdbarch)
	      && cookednum < 2 * gdbarch_num_regs (gdbarch));
  if (register_size (gdbarch, rawnum) == register_size (gdbarch, cookednum))
    regcache_raw_write (regcache, rawnum, buf);
  else if (register_size (gdbarch, rawnum) >
	   register_size (gdbarch, cookednum))
    {
      /* Sign extend the shortened version of the register prior
         to placing it in the raw register.  This is required for
         some mips64 parts in order to avoid unpredictable behavior.  */
      enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
      LONGEST regval = extract_signed_integer (buf, 4, byte_order);
      regcache_raw_write_signed (regcache, rawnum, regval);
    }
  else
    internal_error (__FILE__, __LINE__, _("bad register size"));
}

static int
nanomips_ax_pseudo_register_collect (struct gdbarch *gdbarch,
				     struct agent_expr *ax, int reg)
{
  int rawnum = reg % gdbarch_num_regs (gdbarch);
  gdb_assert (reg >= gdbarch_num_regs (gdbarch)
	      && reg < 2 * gdbarch_num_regs (gdbarch));

  ax_reg_mask (ax, rawnum);

  return 0;
}

static int
nanomips_ax_pseudo_register_push_stack (struct gdbarch *gdbarch,
				    struct agent_expr *ax, int reg)
{
  int rawnum = reg % gdbarch_num_regs (gdbarch);
  gdb_assert (reg >= gdbarch_num_regs (gdbarch)
	      && reg < 2 * gdbarch_num_regs (gdbarch));
  if (register_size (gdbarch, rawnum) >= register_size (gdbarch, reg))
    {
      ax_reg (ax, rawnum);

      if (register_size (gdbarch, rawnum) > register_size (gdbarch, reg))
        {
	  if (gdbarch_byte_order (gdbarch) != BFD_ENDIAN_BIG)
	    {
	      ax_const_l (ax, 32);
	      ax_simple (ax, aop_lsh);
	    }
	  ax_const_l (ax, 32);
	  ax_simple (ax, aop_rsh_signed);
	}
    }
  else
    internal_error (__FILE__, __LINE__, _("bad register size"));

  return 0;
}

/* Table to translate nanomips 3-bit register field to
   actual register number.  */
static const signed char reg3_to_reg[8] = { 16, 17, 18, 19, 4, 5, 6, 7 };

/* Heuristic_proc_start may hunt through the text section for a long
   time across a 2400 baud serial line.  Allows the user to limit this
   search.  */

static int heuristic_fence_post = 0;

/* Convert to/from a register and the corresponding memory value.  */

/* This predicate tests for the case of a 4 byte floating point
   value that is being transferred to or from a floating point
   register which is 8 bytes wide.  */

static int
nanomips_convert_register_float_case_p (struct gdbarch *gdbarch, int regnum,
					struct type *type)
{
  return (register_size (gdbarch, regnum) == 8
	  && nanomips_float_register_p (gdbarch, regnum)
	  && TYPE_CODE (type) == TYPE_CODE_FLT && TYPE_LENGTH (type) == 4);
}

/* This predicate tests for the case of a value of less than 8
   bytes in width that is being transfered to or from an 8 byte
   general purpose register.  */
static int
nanomips_convert_register_gpreg_case_p (struct gdbarch *gdbarch, int regnum,
					struct type *type)
{
  int num_regs = gdbarch_num_regs (gdbarch);

  return (register_size (gdbarch, regnum) == 8
          && regnum % num_regs > 0 && regnum % num_regs < 32
          && TYPE_LENGTH (type) < 8);
}

static int
nanomips_convert_register_p (struct gdbarch *gdbarch,
			     int regnum, struct type *type)
{
  return (nanomips_convert_register_float_case_p (gdbarch, regnum, type)
	  || nanomips_convert_register_gpreg_case_p (gdbarch, regnum, type));
}

static int
nanomips_register_to_value (struct frame_info *frame, int regnum,
			    struct type *type, gdb_byte *to,
			    int *optimizedp, int *unavailablep)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);

  if (nanomips_convert_register_float_case_p (gdbarch, regnum, type))
    {
      /* single comes from low half of 64-bit register */
      if (gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG)
	{
	  if (!get_frame_register_bytes (frame, regnum, 4, 4, to,
					 optimizedp, unavailablep))
	    return 0;
	}
      else
	{
	  if (!get_frame_register_bytes (frame, regnum, 0, 4, to,
					 optimizedp, unavailablep))
	    return 0;
	}
      *optimizedp = *unavailablep = 0;
      return 1;
    }
  else if (nanomips_convert_register_gpreg_case_p (gdbarch, regnum, type))
    {
      int len = TYPE_LENGTH (type);
      CORE_ADDR offset;

      offset = gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG ? 8 - len : 0;
      if (!get_frame_register_bytes (frame, regnum, offset, len, to,
				     optimizedp, unavailablep))
	return 0;

      *optimizedp = *unavailablep = 0;
      return 1;
    }
  else
    {
      internal_error (__FILE__, __LINE__,
                      _("nanomips_register_to_value: unrecognized case"));
    }
}

static void
nanomips_value_to_register (struct frame_info *frame, int regnum,
			    struct type *type, const gdb_byte *from)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);

  if (nanomips_convert_register_float_case_p (gdbarch, regnum, type))
    {
      /* single goes in low half of 64-bit register */
      if (gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG)
	put_frame_register_bytes (frame, regnum, 4, 4, from);
      else
	put_frame_register_bytes (frame, regnum, 0, 4, from);
    }
  else if (nanomips_convert_register_gpreg_case_p (gdbarch, regnum, type))
    {
      gdb_byte fill[8];
      int len = TYPE_LENGTH (type);
      
      /* Sign extend values, irrespective of type, that are stored to 
         a 64-bit general purpose register.  (32-bit unsigned values
	 are stored as signed quantities within a 64-bit register.
	 When performing an operation, in compiled code, that combines
	 a 32-bit unsigned value with a signed 64-bit value, a type
	 conversion is first performed that zeroes out the high 32 bits.)  */
      if (gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG)
	{
	  if (from[0] & 0x80)
	    store_signed_integer (fill, 8, BFD_ENDIAN_BIG, -1);
	  else
	    store_signed_integer (fill, 8, BFD_ENDIAN_BIG, 0);
	  put_frame_register_bytes (frame, regnum, 0, 8 - len, fill);
	  put_frame_register_bytes (frame, regnum, 8 - len, len, from);
	}
      else
	{
	  if (from[len-1] & 0x80)
	    store_signed_integer (fill, 8, BFD_ENDIAN_LITTLE, -1);
	  else
	    store_signed_integer (fill, 8, BFD_ENDIAN_LITTLE, 0);
	  put_frame_register_bytes (frame, regnum, 0, len, from);
	  put_frame_register_bytes (frame, regnum, len, 8 - len, fill);
	}
    }
  else
    {
      internal_error (__FILE__, __LINE__,
                      _("nanomips_value_to_register: unrecognized case"));
    }
}

/* Return the GDB type object for the "standard" data type of data in
   register REG.  */

static struct type *
nanomips_register_type (struct gdbarch *gdbarch, int regnum)
{
  gdb_assert (regnum >= 0 && regnum < 2 * gdbarch_num_regs (gdbarch));
  if (nanomips_float_register_p (gdbarch, regnum))
    return builtin_type (gdbarch)->builtin_double;	/* FP64 implied */
  else if (regnum < gdbarch_num_regs (gdbarch))
    {
      /* The raw or ISA registers.  These are all sized according to
	 the ISA regsize.  */
      if (nanomips_isa_regsize (gdbarch) == 4)
	return builtin_type (gdbarch)->builtin_int32;
      else
	return builtin_type (gdbarch)->builtin_int64;
    }
  else
    {
      int rawnum = regnum - gdbarch_num_regs (gdbarch);

      /* The cooked or ABI registers.  These are sized according to
	 the ABI (with a few complications).  */
      if (rawnum == nanomips_regnum (gdbarch)->fp_control_status
	  || rawnum == nanomips_regnum (gdbarch)->fp_implementation_revision)
	return builtin_type (gdbarch)->builtin_int32;
      else if (gdbarch_osabi (gdbarch) != GDB_OSABI_LINUX
	       && rawnum >= FIRST_EMBED_REGNUM
	       && rawnum <= LAST_EMBED_REGNUM)
	/* The pseudo/cooked view of the embedded registers is always
	   32-bit.  The raw view is handled below.  */
	return builtin_type (gdbarch)->builtin_int32;
      else if (nanomips_abi_regsize (gdbarch) == 4)
	/* The ABI is restricted to 32-bit registers (the ISA could be
	   32- or 64-bit).  */
	return builtin_type (gdbarch)->builtin_int32;
      else
	/* 64-bit ABI.  */
	return builtin_type (gdbarch)->builtin_int64;
    }
}

/* Return the GDB type for the pseudo register REGNUM, which is the
   ABI-level view.  This function is only called if there is a target
   description which includes registers, so we know precisely the
   types of hardware registers.  */

static struct type *
nanomips_pseudo_register_type (struct gdbarch *gdbarch, int regnum)
{
  const int num_regs = gdbarch_num_regs (gdbarch);
  int rawnum = regnum % num_regs;
  struct type *rawtype;

  gdb_assert (regnum >= num_regs && regnum < 2 * num_regs);

  /* Absent registers are still absent.  */
  rawtype = gdbarch_register_type (gdbarch, rawnum);
  if (TYPE_LENGTH (rawtype) == 0)
    return rawtype;

  /* Present the floating point registers however the hardware did;
     do not try to convert between FPU layouts.  */
  if (nanomips_float_register_p (gdbarch, rawnum))
    return rawtype;

  /* Floating-point control registers are always 32-bit even though for
     backwards compatibility reasons 64-bit targets will transfer them
     as 64-bit quantities even if using XML descriptions.  */
  if (rawnum == nanomips_regnum (gdbarch)->fp_control_status
      || rawnum == nanomips_regnum (gdbarch)->fp_implementation_revision)
    return builtin_type (gdbarch)->builtin_int32;

  /* Use pointer types for registers if we can.  For n32 we can not,
     since we do not have a 64-bit pointer type.  */
  if (nanomips_abi_regsize (gdbarch)
      == TYPE_LENGTH (builtin_type (gdbarch)->builtin_data_ptr))
    {
      if (rawnum == SP_REGNUM
	  || rawnum == nanomips_regnum (gdbarch)->badvaddr)
	return builtin_type (gdbarch)->builtin_data_ptr;
      else if (rawnum == nanomips_regnum (gdbarch)->pc)
	return builtin_type (gdbarch)->builtin_func_ptr;
    }

  if (nanomips_abi_regsize (gdbarch) == 4 && TYPE_LENGTH (rawtype) == 8
      && ((rawnum >= ZERO_REGNUM && rawnum <= PS_REGNUM)
	  || rawnum == nanomips_regnum (gdbarch)->badvaddr
	  || rawnum == nanomips_regnum (gdbarch)->cause
	  || rawnum == nanomips_regnum (gdbarch)->pc
	  || (nanomips_regnum (gdbarch)->dspacc != -1
	      && rawnum >= nanomips_regnum (gdbarch)->dspacc
	      && rawnum < nanomips_regnum (gdbarch)->dspacc + 8)))
    return builtin_type (gdbarch)->builtin_int32;

  /* The pseudo/cooked view of embedded registers is always
     32-bit, even if the target transfers 64-bit values for them.
     New targets relying on XML descriptions should only transfer
     the necessary 32 bits, but older versions of GDB expected 64,
     so allow the target to provide 64 bits without interfering
     with the displayed type.  */
  if (gdbarch_osabi (gdbarch) != GDB_OSABI_LINUX
      && rawnum >= FIRST_EMBED_REGNUM
      && rawnum <= LAST_EMBED_REGNUM)
    return builtin_type (gdbarch)->builtin_int32;

  /* For all other registers, pass through the hardware type.  */
  return rawtype;
}

/* Should the upper word of 64-bit addresses be zeroed?  */
static enum auto_boolean mask_address_var = AUTO_BOOLEAN_AUTO;

static int
nanomips_mask_address_p (struct gdbarch_tdep *tdep)
{
  switch (mask_address_var)
    {
    case AUTO_BOOLEAN_TRUE:
      return 1;
    case AUTO_BOOLEAN_FALSE:
      return 0;
      break;
    case AUTO_BOOLEAN_AUTO:
      return tdep->default_mask_address_p;
    default:
      internal_error (__FILE__, __LINE__,
		      _("nanomips_mask_address_p: bad switch"));
      return -1;
    }
}

static void
show_mask_address (struct ui_file *file, int from_tty,
		   struct cmd_list_element *c, const char *value)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (target_gdbarch ());

  deprecated_show_value_hack (file, from_tty, c, value);
  switch (mask_address_var)
    {
    case AUTO_BOOLEAN_TRUE:
      printf_filtered ("The 32 bit nanomips address mask is enabled\n");
      break;
    case AUTO_BOOLEAN_FALSE:
      printf_filtered ("The 32 bit nanomips address mask is disabled\n");
      break;
    case AUTO_BOOLEAN_AUTO:
      printf_filtered
	("The 32 bit address mask is set automatically.  Currently %s\n",
	 nanomips_mask_address_p (tdep) ? "enabled" : "disabled");
      break;
    default:
      internal_error (__FILE__, __LINE__, _("show_mask_address: bad switch"));
      break;
    }
}

/* nanoMIPS believes that the PC has a sign extended value.  Perhaps
   all registers should be sign extended for simplicity?  */

static CORE_ADDR
nanomips_read_pc (struct regcache *regcache)
{
  int regnum = gdbarch_pc_regnum (get_regcache_arch (regcache));
  LONGEST pc;

  regcache_cooked_read_signed (regcache, regnum, &pc);
  return pc;
}

static CORE_ADDR
nanomips_unwind_pc (struct gdbarch *gdbarch, struct frame_info *next_frame)
{
  return frame_unwind_register_signed
	   (next_frame, gdbarch_pc_regnum (gdbarch));
}

static CORE_ADDR
nanomips_unwind_sp (struct gdbarch *gdbarch, struct frame_info *next_frame)
{
  return frame_unwind_register_signed
	   (next_frame, gdbarch_num_regs (gdbarch) + SP_REGNUM);
}

/* Assuming THIS_FRAME is a dummy, return the frame ID of that
   dummy frame.  The frame ID's base needs to match the TOS value
   saved by save_dummy_frame_tos(), and the PC match the dummy frame's
   breakpoint.  */

static struct frame_id
nanomips_dummy_id (struct gdbarch *gdbarch, struct frame_info *this_frame)
{
  return frame_id_build
	   (get_frame_register_signed (this_frame,
				       gdbarch_num_regs (gdbarch)
				       + SP_REGNUM),
	    get_frame_pc (this_frame));
}

/* Implement the "write_pc" gdbarch method.  */

void
nanomips_write_pc (struct regcache *regcache, CORE_ADDR pc)
{
  int regnum = gdbarch_pc_regnum (get_regcache_arch (regcache));
  regcache_cooked_write_unsigned (regcache, regnum, pc);
}

/* Fetch and return 16-bit instruction from the specified location.  */

static ULONGEST
nanomips_fetch_instruction (struct gdbarch *gdbarch,
			    CORE_ADDR addr, int *errp)
{
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  gdb_byte buf[INSN16_SIZE];
  int err;

  err = target_read_memory (addr, buf, INSN16_SIZE);
  if (errp != NULL)
    *errp = err;
  if (err != 0)
    {
      if (errp == NULL)
	memory_error (TARGET_XFER_E_IO, addr);
      return 0;
    }
  return extract_unsigned_integer (buf, INSN16_SIZE, byte_order);
}

/* MicroMIPS instruction fields.  */
#define micromips_op(x) ((x) >> 10)

/* 16-bit/32-bit-high-part instruction formats, B and S refer to the lowest
   bit and the size respectively of the field extracted.  */
#define b0s4_imm(x) ((x) & 0xf)
#define b0s5_imm(x) ((x) & 0x1f)
#define b0s5_reg(x) ((x) & 0x1f)
#define b0s7_imm(x) ((x) & 0x7f)
#define b0s8_imm(x) ((x) & 0xff)
#define b0s10_imm(x) ((x) & 0x3ff)
#define b0u13_15s1_imm(x) (((x) & 0x1fff) | (((x) & 0x8000) >> 2))
#define b1s4_imm(x) (((x) >> 1) & 0xf)
#define b1s9_imm(x) (((x) >> 1) & 0x1ff)
#define b3s9_imm(x) (((x) >> 3) & 0x1ff)
#define b2s3_cc(x) (((x) >> 2) & 0x7)
#define b4s2_regl(x) (((x) >> 4) & 0x3)
#define b4s3_reg(x) (((x) >> 4) & 0x7)
#define b4s4_imm(x) (((x) >> 4) & 0xf)
#define b5s5_op(x) (((x) >> 5) & 0x1f)
#define b5s5_reg(x) (((x) >> 5) & 0x1f)
#define b6s4_op(x) (((x) >> 6) & 0xf)
#define b7s3_reg(x) (((x) >> 7) & 0x7)
#define b8s2_regl(x) (((x) >> 8) & 0x3)
#define b8s7_op(x) (((x) >> 8) & 0x7f)

/* 32-bit instruction formats, B and S refer to the lowest bit and the size
   respectively of the field extracted.  */
#define b0s6_op(x) ((x) & 0x3f)
#define b0s10_op(x) ((x) & 0x3ff)
#define b0s11_op(x) ((x) & 0x7ff)
#define b0s12_imm(x) ((x) & 0xfff)
#define b0u16_imm(x) ((x) & 0xffff)
#define b0s21_imm(x) ((x) & 0x1fffff)
#define b0s26_imm(x) ((x) & 0x3ffffff)
#define b6s10_ext(x) (((x) >> 6) & 0x3ff)
#define b9s3_op(x) (((x) >> 9) & 0x7)
#define b11s5_reg(x) (((x) >> 11) & 0x1f)
#define b16s5_reg(x) (((x) >> 16) & 0x1f)
#define b21s5_reg(x) (((x) >> 21) & 0x1f)
#define b11s7_imm(x) (((x) >> 11) & 0x7f)
#define b12s4_op(x) (((x) >> 12) & 0xf)
#define b12s5_op(x) (((x) >> 12) & 0x1f)
#define b14s2_op(x) (((x) >> 14) & 0x3)
#define b16s4_imm(x) (((x) >> 16) & 0xf)

/* Return the size in bytes of the instruction INSN encoded in the ISA
   instruction set.  */

static int
nanomips_insn_size (ULONGEST insn)
{
  if (micromips_op (insn) == 0x18)
    return 3 * INSN16_SIZE;
  else if ((micromips_op (insn) & 0x4) == 0x0)
    return 2 * INSN16_SIZE;
  else
    return INSN16_SIZE;
}

/* Calculate the address of the next nanoMIPS instruction to execute
   after the instruction at the address PC.  The nanomicromips_next_pc
   function supports single_step when the remote target monitor or stub
   is not developed enough to do a single_step.  It works by decoding the
   current instruction and predicting where a branch will go.  This isn't
   hard because all the data is available.  */

static CORE_ADDR
nanomicromips_next_pc (struct regcache *regcache, CORE_ADDR pc)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  ULONGEST insn;
  CORE_ADDR offset;
  int op, sreg, treg, uimm;
  LONGEST val_rs, val_rt;

  insn = nanomips_fetch_instruction (gdbarch, pc, NULL);
  pc += INSN16_SIZE;
  switch (nanomips_insn_size (insn))
    {
    /* 48-bit instructions.  */
    case 3 * INSN16_SIZE:
      /* No branch or jump instructions in this category.  */
      pc += 2 * INSN16_SIZE;
      break;

    /* 32-bit instructions.  */
    case 2 * INSN16_SIZE:
      insn <<= 16;
      insn |= nanomips_fetch_instruction (gdbarch, pc, NULL);
      pc += INSN16_SIZE;
      switch (micromips_op (insn >> 16))
	{
	case 0x2: /* MOVE.BALC */
	  offset = ((insn & 1) << 20 | ((insn >> 1) & 0xfffff)) << 1;
	  offset = (offset ^ 0x200000) - 0x200000;
	  pc += offset;
	  break;

	case 0xa: /* BALC, BC */
	  offset = ((insn & 1) << 24 | ((insn >> 1) & 0xffffff)) << 1;
	  offset = (offset ^ 0x2000000) - 0x2000000;
	  pc += offset;
	  break;

	case 0x12: /* P.J P.BREG P.BALRC P.BALRSC */
	  op = b12s4_op (insn);
	  sreg = b0s5_reg (insn >> 16);
	  treg = b5s5_reg (insn >> 16);
	  if (op == 0x8) /* BALRC, BALRSC, BRC, BRSC */
	    {
	      int bit9 = (insn >> 9) & 1;
	      val_rs = regcache_raw_get_signed (regcache, sreg);
	      pc = val_rs << bit9;
	    }
	  else if (op == 0 || op == 1) /* JALRC JALRC.HB */
	    pc = regcache_raw_get_signed (regcache, sreg);
	  break;

	case 0x20: /* P.RESTORE */
	  if (b12s5_op (insn) == 0x13) /* RESTORE.JRC */
	    pc = regcache_raw_get_signed (regcache, 31);
	  break;

	case 0x22: /* P.BR1 */
	  op = b14s2_op (insn);
	  sreg = b0s5_reg (insn >> 16);
	  treg = b5s5_reg (insn >> 16);
	  val_rs = regcache_raw_get_signed (regcache, sreg);
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 13 | ((insn >> 1) & 0x1fff)) << 1;
	  offset = (offset ^ 0x4000) - 0x4000;
	  if ((op == 0 && val_rs == val_rt) /* BEQC */
	      || (op == 2 && val_rs >= val_rt) /* BGEC */
	      || (op == 3
		  && (ULONGEST) val_rs >= (ULONGEST) val_rt)) /* BGEUC */
	    pc += offset;
	  break;

	case 0x2a: /* P.BR2 */
	  op = b14s2_op (insn);
	  sreg = b0s5_reg (insn >> 16);
	  treg = b5s5_reg (insn >> 16);
	  val_rs = regcache_raw_get_signed (regcache, sreg);
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 13 | ((insn >> 1) & 0x1fff)) << 1;
	  offset = (offset ^ 0x4000) - 0x4000;
	  if ((op == 0 && val_rs != val_rt) /* BNEC */
	      || (op == 2 && val_rs < val_rt) /* BLTC */
	      || (op == 3
		  && (ULONGEST) val_rs < (ULONGEST) val_rt)) /* BLTUC */
	    pc += offset;
	  break;

	case 0x32: /* P.BRI */
	  op = b2s3_cc (insn >> 16);
	  treg = b5s5_reg (insn >> 16);
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 10 | ((insn >> 1) & 0x3ff)) << 1;
	  offset = (offset ^ 0x800) - 0x800;
	  uimm = b11s7_imm (insn);
	  if ((op == 0 && val_rt == uimm) /* BEQIC */
	      || (op == 2 && val_rt >= uimm) /* BGEIC */
	      || (op == 3 && (ULONGEST) val_rt >= uimm) /* BGEIUC */
	      || (op == 4 && val_rt != uimm) /* BNEIC */
	      || (op == 6 && val_rt < uimm) /* BLTIC */
	      || (op == 7 && (ULONGEST) val_rt < uimm)) /* BLTIUC */
	    pc += offset;
	  break;

	case 0x3a: /* P.BZ */
	  op = (insn & 0x80000); /* 20th bit */
	  treg = b5s5_reg (insn >> 16);
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 19 | ((insn >> 1) & 0x7ffff)) << 1;
	  offset = (offset ^ 0x100000) - 0x100000;
	  if ((op == 0 && val_rt == 0) /* BEQZC */
	      || (op != 0 && val_rt != 0)) /* BNEZC */
	    pc += offset;
	  break;

	default:
	  break;
	}

    /* 16-bit instructions.  */
    case INSN16_SIZE:
      switch (micromips_op (insn))
	{
	case 0x6: /* BC[16] */
	case 0xe: /* BALC[16] */
	  offset = ((insn & 1) << 9 | ((insn >> 1) & 0x1ff)) << 1;
	  offset = (offset ^ 0x400) - 0x400;
	  pc += offset;
	  break;

	case 0x7: /* RESTORE.JRC[16] */
	  if ((insn & 1) == 0 && (insn & 0x20) == 0x20)
	    pc = regcache_raw_get_signed (regcache, 31);
	  break;

	case 0x26: /* BEQZC[16] */
	  treg = reg3_to_reg[b7s3_reg (insn)];
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 6 | ((insn >> 1) & 0x3f)) << 1;
	  offset = (offset ^ 0x80) - 0x80;
	  if (val_rt == 0)
	    pc += offset;
	  break;

	case 0x2e: /* BNEZC[16] */
	  treg = reg3_to_reg[b7s3_reg (insn)];
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = ((insn & 1) << 6 | ((insn >> 1) & 0x3f)) << 1;
	  offset = (offset ^ 0x80) - 0x80;
	  if (val_rt != 0)
	    pc += offset;
	  break;

	case 0x36: /* P16.BR P16.JRC */
	  sreg = reg3_to_reg[b4s3_reg (insn)];
	  treg = reg3_to_reg[b7s3_reg (insn)];
	  val_rs = regcache_raw_get_signed (regcache, sreg);
	  val_rt = regcache_raw_get_signed (regcache, treg);
	  offset = insn & 0xf;
	  /* BEQC[16] BEQC[16] */
	  if ((sreg < treg && offset != 0 && val_rs == val_rt)
	      || (sreg >= treg && offset != 0 && val_rs != val_rt))
	    pc += offset;
	  else if (offset == 0) /* JALRC[16] JRC */
	    pc = regcache_raw_get_signed (regcache, 31);
	  break;

	default:
	  break;
	}
      break;

    default:
      break;
    }
  return pc;
}

struct nanomips_frame_cache
{
  CORE_ADDR base;
  struct trad_frame_saved_reg *saved_regs;
};

/* Set a register's saved stack address in temp_saved_regs.  If an
   address has already been set for this register, do nothing; this
   way we will only recognize the first save of a given register in a
   function prologue.

   For simplicity, save the address in both [0 .. gdbarch_num_regs) and
   [gdbarch_num_regs .. 2*gdbarch_num_regs).
   Strictly speaking, only the second range is used as it is only second
   range (the ABI instead of ISA registers) that comes into play when finding
   saved registers in a frame.  */

static void
set_reg_offset (struct gdbarch *gdbarch, struct nanomips_frame_cache *this_cache,
		int regnum, CORE_ADDR offset)
{
  if (this_cache != NULL
      && this_cache->saved_regs[regnum].addr == -1)
    {
      this_cache->saved_regs[regnum + 0 * gdbarch_num_regs (gdbarch)].addr
        = offset;
      this_cache->saved_regs[regnum + 1 * gdbarch_num_regs (gdbarch)].addr
        = offset;
    }
}

/* Analyze the function prologue from START_PC to LIMIT_PC.  Return
   the address of the first instruction past the prologue.  */

static CORE_ADDR
nanomips_scan_prologue (struct gdbarch *gdbarch,
			CORE_ADDR start_pc, CORE_ADDR limit_pc,
			struct frame_info *this_frame,
			struct nanomips_frame_cache *this_cache)
{
  CORE_ADDR end_prologue_addr;
  int prev_non_prologue_insn = 0;
  int frame_reg = SP_REGNUM;
  int this_non_prologue_insn;
  int non_prologue_insns = 0;
  long frame_offset = 0;	/* Size of stack frame.  */
  long frame_adjust = 0;	/* Offset of FP from SP.  */
  CORE_ADDR prev_pc;
  CORE_ADDR cur_pc;
  ULONGEST insn;		/* current instruction */
  CORE_ADDR sp;
  long offset;
  long sp_adj;
  long v1_off = 0;		/* The assumption is LUI will replace it.  */
  int reglist;
  int breg;
  int dreg;
  int sreg;
  int treg;
  int loc;
  int op;
  int s;
  int i;

  /* Can be called when there's no process, and hence when there's no
     THIS_FRAME.  */
  if (this_frame != NULL)
    sp = get_frame_register_signed (this_frame,
				    gdbarch_num_regs (gdbarch)
				    + SP_REGNUM);
  else
    sp = 0;

  if (limit_pc > start_pc + 200)
    limit_pc = start_pc + 200;
  prev_pc = start_pc;

  /* Permit at most one non-prologue non-control-transfer instruction
     in the middle which may have been reordered by the compiler for
     optimisation.  */
  for (cur_pc = start_pc; cur_pc < limit_pc; cur_pc += loc)
    {
      this_non_prologue_insn = 0;
      sp_adj = 0;
      loc = 0;
      insn = nanomips_fetch_instruction (gdbarch, cur_pc, NULL);
      loc += INSN16_SIZE;
      switch (nanomips_insn_size (insn))
	{
	/* 48-bit instructions.  */
	case 3 * INSN16_SIZE:
	  if (micromips_op (insn) == 0x18)
	    {
	      op = b0s5_imm (insn);
	      treg = b5s5_reg (insn);
	      offset = nanomips_fetch_instruction (gdbarch, cur_pc + 2, NULL);
	      offset <<= 16;
	      offset |= nanomips_fetch_instruction (gdbarch, cur_pc + 4, NULL);
	      if (op == 0x0 && treg == 3) /* LI48 $v1, imm32 */
		v1_off = offset;
	      else if (op == 0x1 /* ADDIU48 $sp, imm32 */
		       && treg == SP_REGNUM)
		sp_adj = offset;
	      else
		this_non_prologue_insn = 1;
	    }
	      else
		this_non_prologue_insn = 1;
	  break;

	/* 32-bit instructions.  */
	case 2 * INSN16_SIZE:
	  insn <<= 16;
	  insn |= nanomips_fetch_instruction (gdbarch,
					  cur_pc + loc, NULL);
	  loc += INSN16_SIZE;

	  switch (micromips_op (insn >> 16))
	    {
	    case 0x0: /* PP.ADDIU bits 000000 */
	      sreg = b0s5_reg (insn >> 16);
	      treg = b5s5_reg (insn >> 16);
	      offset = b0u16_imm (insn);
	      if (sreg == treg
		  && treg == SP_REGNUM) /* ADDIU $sp, $sp, imm */
		sp_adj = offset;
	      else if (sreg == SP_REGNUM
		       && treg == FP_REGNUM) /* ADDIU $fp, $sp, imm */
		{
		  frame_adjust = offset;
		  frame_reg = FP_REGNUM;
		}
	      else if (sreg != GP_REGNUM || treg != GP_REGNUM)
		this_non_prologue_insn = 1;
	      break;

	    case 0x8: /* P32A: bits 001000 */
	      op = b0s10_op (insn);
	      sreg = b0s5_reg (insn >> 16);
	      treg = b5s5_reg (insn >> 16);
	      dreg = b11s5_reg (insn);
	      if (op == 0x1d0	/* SUBU: bits 001000 0111010000 */
		  && dreg == SP_REGNUM && sreg == SP_REGNUM
		  && treg == 3)	/* SUBU $sp, $v1 */
		sp_adj = v1_off;
	      else
		this_non_prologue_insn = 1;
	      break;

	    case 0x20: /* P.U12 bits 100000 */
	      /* SAVE: bits 100000 rt 0 count 0011 */
	      if (b12s4_op (insn) == 0x3)
		{
		  int rt, this_rt, gp, use_gp;
		  int counter = 0, count = b16s4_imm (insn);
		  long this_offset;
		  offset = b3s9_imm (insn) << 4;
		  rt = b21s5_reg (insn);
		  sp_adj = -offset;
		  gp = (insn >> 2) & 1;
		  while (counter != count)
		    {
		      use_gp = gp & (counter == count - 1);
		      if (use_gp)
			this_rt = GP_REGNUM;
		      else
			this_rt = (((rt >> 4) & 1) << 4) | (rt + counter);
		      this_offset = (counter + 1) << 2;
		      set_reg_offset (gdbarch, this_cache, this_rt,
				      sp + offset - this_offset);
		      counter++;
		    }
		}
	      else if (b12s4_op (insn) == 8) /* ADDIU[NEG]: bits 100000 1000 */
		{
		  sreg = b0s5_reg (insn >> 16);
		  treg = b5s5_reg (insn >> 16);
		  if (sreg == treg && sreg == SP_REGNUM)
			  /* ADDIU[NEG] $sp, $sp, imm */
		    {
		      offset = b0s11_op (insn);
		      sp_adj = -offset;
		    }
		}
	      else if (b12s4_op (insn) == 0) /* ORI: bits 100000 0000 */
		{
		  sreg = b0s5_reg (insn >> 16);
		  treg = b5s5_reg (insn >> 16);
		  if (sreg == treg && treg == 3) /* ORI $v1, $v1, imm */
		    v1_off |= b0s11_op (insn);
		  else
		    this_non_prologue_insn = 1;
		}
		else
		  this_non_prologue_insn = 1;
	      break;

	    case 0x21: /* P.LS.U12 bits 100001 */
	      if (b12s4_op (insn) == 0x9) /* SW 100001 1001 */
		{
		  breg = b0s5_reg (insn >> 16);
		  sreg = b5s5_reg (insn >> 16);
		  offset = b0s12_imm (insn);
		  if (breg == SP_REGNUM) /* SW reg,offset($sp) */
		    set_reg_offset (gdbarch, this_cache, sreg, sp + offset);
		  else
		    this_non_prologue_insn = 1;
		}
	      break;

	    case 0x29: /* P.LS.S9 bits 101001 */
	      if (b8s7_op (insn) == 0x48) /* SW[S9] 101001 1001 0 00 */
		{
		  breg = b0s5_reg (insn >> 16);
		  sreg = b5s5_reg (insn >> 16);
		  offset = (((insn >> 15) & 1) << 8) | b0s8_imm (insn);
		  offset = (offset ^ 0x100) - 0x100;
		  if (breg == SP_REGNUM) /* SW[S9] reg,offset($sp) */
		    set_reg_offset (gdbarch, this_cache, sreg, sp + offset);
		  else
		    this_non_prologue_insn = 1;
		}
	      break;

	    case 0x38: /* P.LUI bits 111000 */
	      treg = b5s5_reg (insn >> 16);
	      if ((insn & 2) == 0 /* LU20I bits 111000 0 */
		  && treg == 3) /* LU20I $v1, imm */
		{
		  v1_off = ((insn & 1) << 19)
			    | (((insn >> 2) & 0x3ff) << 9)
			    | (((insn >> 12) & 0x1ff));
		  v1_off = v1_off << 12;
		}
	      else
		this_non_prologue_insn = 1;
	      break;

	   default:
	     this_non_prologue_insn = 1;
	     break;
	   }

	  insn >>= 16;
	  break;

	/* 16-bit instructions.  */
	case INSN16_SIZE:
	  switch (micromips_op (insn))
	    {
	    case 0x4: /* MOVE: bits 000100 */
	      sreg = b0s5_reg (insn);
	      dreg = b5s5_reg (insn);
	      if (sreg == SP_REGNUM && dreg == FP_REGNUM)
				/* MOVE  $fp, $sp */
		frame_reg = FP_REGNUM;
	      else
		this_non_prologue_insn = 1;
	      break;

	    case 0x7: /* SAVE: bits 000111 */
	      {
		int rt, rt1, this_rt;
		int counter = 0, count = b0s4_imm (insn);
		long this_offset;
		offset = b4s4_imm (insn) << 4;
		rt1 = (insn >> 9) & 1;
		rt = 30 | rt1;
		sp_adj = -offset;
		while (counter != count)
		  {
		    this_rt = (((rt >> 4) & 1) << 4) | (rt + counter);
		    this_offset = (counter + 1) << 2;
		    set_reg_offset (gdbarch, this_cache, this_rt,
				    sp + offset - this_offset);
		    counter++;
		  }
		break;
	      }

	    case 0x35: /* SW[SP]: bits 110101 */
	      treg = b5s5_reg (insn);
	      offset = b0s5_imm (insn);
	      set_reg_offset (gdbarch, this_cache, treg, sp + offset);
	      break;

	    default:
	      this_non_prologue_insn = 1;
	      break;
	    }
	  break;
	}

      if (sp_adj < 0)
	frame_offset -= sp_adj;

      non_prologue_insns += this_non_prologue_insn;

      if (non_prologue_insns > 1 || sp_adj > 0)
  break;

      prev_non_prologue_insn = this_non_prologue_insn;
      prev_pc = cur_pc;
    }

  if (this_cache != NULL)
    {
      this_cache->base =
	(get_frame_register_signed (this_frame,
				    gdbarch_num_regs (gdbarch) + frame_reg)
	 + frame_offset - frame_adjust);
      /* FIXME: brobecker/2004-10-10: Just as in the mips32 case, we should
	 be able to get rid of the assignment below, evetually. But it's
	 still needed for now.  */
      this_cache->saved_regs[gdbarch_num_regs (gdbarch)
			     + nanomips_regnum (gdbarch)->pc]
	= this_cache->saved_regs[gdbarch_num_regs (gdbarch) + RA_REGNUM];
    }

  /* Set end_prologue_addr to the address of the instruction immediately
     after the last one we scanned.  Unless the last one looked like a
     non-prologue instruction (and we looked ahead), in which case use
     its address instead.  */
  end_prologue_addr
    = prev_non_prologue_insn ? prev_pc : cur_pc;

  return end_prologue_addr;
}

/* Heuristic unwinder for procedures using nanoMIPS instructions.
   Procedures that use the 32-bit instruction set are handled by the
   mips_insn32 unwinder.  Likewise MIPS16 and the mips_insn16 unwinder. */

static struct nanomips_frame_cache *
nanomips_frame_cache (struct frame_info *this_frame, void **this_cache)
{
  struct gdbarch *gdbarch = get_frame_arch (this_frame);
  struct nanomips_frame_cache *cache;

  if ((*this_cache) != NULL)
    return (struct nanomips_frame_cache *) (*this_cache);

  cache = FRAME_OBSTACK_ZALLOC (struct nanomips_frame_cache);
  (*this_cache) = cache;
  cache->saved_regs = trad_frame_alloc_saved_regs (this_frame);

  /* Analyze the function prologue.  */
  {
    const CORE_ADDR pc = get_frame_address_in_block (this_frame);
    CORE_ADDR start_addr;

    find_pc_partial_function (pc, NULL, &start_addr, NULL);
    if (start_addr == 0)
      start_addr = heuristic_proc_start (get_frame_arch (this_frame), pc);
    /* We can't analyze the prologue if we couldn't find the begining
       of the function.  */
    if (start_addr == 0)
      return cache;

    nanomips_scan_prologue (gdbarch, start_addr, pc, this_frame,
			    (struct nanomips_frame_cache *) *this_cache);
  }

  /* gdbarch_sp_regnum contains the value and not the address.  */
  trad_frame_set_value (cache->saved_regs,
			gdbarch_num_regs (gdbarch) + SP_REGNUM,
			cache->base);

  return (struct nanomips_frame_cache *) (*this_cache);
}

static void
nanomips_frame_this_id (struct frame_info *this_frame, void **this_cache,
			struct frame_id *this_id)
{
  struct nanomips_frame_cache *info = nanomips_frame_cache (this_frame,
							    this_cache);
  /* This marks the outermost frame.  */
  if (info->base == 0)
    return;
  (*this_id) = frame_id_build (info->base, get_frame_func (this_frame));
}

static struct value *
nanomips_frame_prev_register (struct frame_info *this_frame,
			      void **this_cache, int regnum)
{
  struct nanomips_frame_cache *info = nanomips_frame_cache (this_frame,
							    this_cache);
  return trad_frame_get_prev_register (this_frame, info->saved_regs, regnum);
}

static int
nanomips_frame_sniffer (const struct frame_unwind *self,
			struct frame_info *this_frame, void **this_cache)
{
  return 1;
}

static const struct frame_unwind nanomips_frame_unwind =
{
  NORMAL_FRAME,
  default_frame_unwind_stop_reason,
  nanomips_frame_this_id,
  nanomips_frame_prev_register,
  NULL,
  nanomips_frame_sniffer
};

static CORE_ADDR
nanomips_frame_base_address (struct frame_info *this_frame,
			     void **this_cache)
{
  struct nanomips_frame_cache *info = nanomips_frame_cache (this_frame,
							    this_cache);
  return info->base;
}

static const struct frame_base nanomips_frame_base =
{
  &nanomips_frame_unwind,
  nanomips_frame_base_address,
  nanomips_frame_base_address,
  nanomips_frame_base_address
};

static const struct frame_base *
nanomips_frame_base_sniffer (struct frame_info *this_frame)
{
  return &nanomips_frame_base;
}

/* nanomips_addr_bits_remove - remove useless address bits  */

static CORE_ADDR
nanomips_addr_bits_remove (struct gdbarch *gdbarch, CORE_ADDR addr)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);

  if (nanomips_mask_address_p (tdep)
      && (((ULONGEST) addr) >> 32 == 0xffffffffUL))
    /* This hack is a work-around for existing boards using PMON, the
       simulator, and any other 64-bit targets that doesn't have true
       64-bit addressing.  On these targets, the upper 32 bits of
       addresses are ignored by the hardware.  Thus, the PC or SP are
       likely to have been sign extended to all 1s by instruction
       sequences that load 32-bit addresses.  For example, a typical
       piece of code that loads an address is this:

       lui $r2, <upper 16 bits>
       ori $r2, <lower 16 bits>

       But the lui sign-extends the value such that the upper 32 bits
       may be all 1s.  The workaround is simply to mask off these
       bits.  In the future, gcc may be changed to support true 64-bit
       addressing, and this masking will have to be disabled.  */
    return addr &= 0xffffffffUL;
  else
    return addr;
}


/* Checks for an atomic sequence of instructions beginning with a LL/LLD
   instruction and ending with a SC/SCD instruction.  If such a sequence
   is found, attempt to step through it.  A breakpoint is placed at the end of
   the sequence.  */

static VEC (CORE_ADDR) *
nanomips_deal_with_atomic_sequence (struct gdbarch *gdbarch,
				    CORE_ADDR pc)
{
  const int atomic_sequence_length = 16; /* Instruction sequence length.  */
  int last_breakpoint = 0; /* Defaults to 0 (no breakpoints placed).  */
  CORE_ADDR breaks[2] = {-1, -1};
  CORE_ADDR branch_bp = 0; /* Breakpoint at branch instruction's
			      destination.  */
  CORE_ADDR loc = pc;
  int sc_found = 0;
  ULONGEST insn;
  int insn_count;
  int index;
  VEC (CORE_ADDR) *next_pcs = NULL;

  /* Assume all atomic sequences start with a ll/lld instruction.  */
  insn = nanomips_fetch_instruction (gdbarch, loc, NULL);
  if (micromips_op (insn) != 0x29)	/* P.LL: bits 101001 */
    return NULL;
  loc += INSN16_SIZE;
  insn <<= 16;
  insn |= nanomips_fetch_instruction (gdbarch, loc, NULL);
  if (b8s7_op (insn) != 0x51)	/* LL: bits 101001 1010 0 01 */
    return NULL;
  loc += INSN16_SIZE;

  /* Assume all atomic sequences end with an sc/scd instruction.  Assume
     that no atomic sequence is longer than "atomic_sequence_length"
     instructions.  */
  for (insn_count = 0;
       !sc_found && insn_count < atomic_sequence_length;
       ++insn_count)
    {
      int is_branch = 0, op;
      CORE_ADDR offset;

      insn = nanomips_fetch_instruction (gdbarch, loc, NULL);
      loc += INSN16_SIZE;

      /* Assume that there is at most one conditional branch in the
         atomic sequence.  If a branch is found, put a breakpoint in
         its destination address.  */
      switch (nanomips_insn_size (insn))
	{
	/* 32-bit instructions.  */
	case 2 * INSN16_SIZE:
	  insn <<= 16;
	  insn |= nanomips_fetch_instruction (gdbarch, loc, NULL);
	  loc += INSN16_SIZE;

	  switch (micromips_op (insn >> 16))
	    {
	    case 0xa: /* BALC, BC */
	      offset = ((insn & 1) << 24 | ((insn >> 1) & 0xffffff)) << 1;
	      offset = (offset ^ 0x2000000) - 0x2000000;
	      branch_bp = loc + offset;
	      is_branch = 1;
	      break;

	    case 0x12:
	      op = b12s4_op (insn);
	      if (op == 0x8) /* BALRC, BALRSC, BRC, BRSC */
		return NULL; /* Fall back to the standard single-step code. */
	      else if (op == 0 || op == 1) /* JALRC JALRC.HB */
		return NULL; /* Fall back to the standard single-step code. */
	      break;

	    case 0x20: /* P.RESTORE */
	      if (b12s5_op (insn) == 0x13) /* RESTORE.JRC */
		return NULL; /* Fall back to the standard single-step code. */
	      break;

	    case 0x22: /* P.BR1 */
	    case 0x2a: /* P.BR2 */
	      op = b14s2_op (insn);
	      offset = ((insn & 1) << 13 | ((insn >> 1) & 0x1fff)) << 1;
	      offset = (offset ^ 0x4000) - 0x4000;
	      if (op == 0 /* BEQC, BNEC */
		  || op == 2 /* BGEC, BLTC */
		  || op == 3) /* BGEUC, BLTUC */
		{
		  branch_bp = loc + offset;
		  is_branch = 1;
		}
	      break;

	    case 0x32: /* P.BRI */
	      op = b2s3_cc (insn >> 16);
	      offset = ((insn & 1) << 10 | ((insn >> 1) & 0x3ff)) << 1;
	      offset = (offset ^ 0x800) - 0x800;
	      if (op == 0 /* BEQIC */
		  || op == 2 /* BGEIC */
		  || op == 3 /* BGEIUC */
		  || op == 4 /* BNEIC */
		  || op == 6 /* BLTIC */
		  || op == 7 ) /* BLTIUC */
		{
		  branch_bp = loc + offset;
		  is_branch = 1;
		}
	      break;

	    case 0x3a: /* P.BZ */
	      op = (insn & 0x80000); /* 20th bit */
	      offset = ((insn & 1) << 19 | ((insn >> 1) & 0x7ffff)) << 1;
	      offset = (offset ^ 0x100000) - 0x100000;
	      if (op == 0 /* BEQZC */
	          || op != 0 ) /* BNEZC */
		{
		  branch_bp = loc + offset;
		  is_branch = 1;
		}
	      break;

	    case 0x29: /* P.SC: bits 101001 */
	      if (b8s7_op (insn) == 0x59) /* SC: bits 101001 1011 0 01 */
		sc_found = 1;
	      break;
	    }
	  break;

	/* 16-bit instructions.  */
	case INSN16_SIZE:
	  switch (micromips_op (insn))
	    {
	    case 0x6: /* BC[16] */
	    case 0xe: /* BALC[16] */
	      offset = ((insn & 1) << 9 | ((insn >> 1) & 0x1ff)) << 1;
	      offset = (offset ^ 0x400) - 0x400;
	      branch_bp = loc + offset;
	      is_branch = 1;
	      break;

	    case 0x7: /* RESTORE.JRC[16] */
	      if ((insn & 1) == 0 && (insn & 0x20) == 0x20)
		return NULL; /* Fall back to the standard single-step code. */
	      break;

	    case 0x26: /* BEQZC[16] */
	    case 0x2e: /* BNEZC[16] */
	      offset = ((insn & 1) << 6 | ((insn >> 1) & 0x3f)) << 1;
	      offset = (offset ^ 0x80) - 0x80;
	      branch_bp = loc + offset;
	      is_branch = 1;
	      break;

	    case 0x36: /* P16.BR P16.JRC */
	      offset = insn & 0xf;
	      /* BEQC[16] BEQC[16] */
	      if (offset != 0)
		{
		  branch_bp = loc + offset;
		  is_branch = 1;
		}
	      else if (offset == 0) /* JALRC[16] JRC */
		return NULL; /* Fall back to the standard single-step code. */
	      break;
	    }
	  break;
	}

      if (is_branch)
	{
	  if (last_breakpoint >= 1)
	    return NULL; /* More than one branch found, fallback to the
			 standard single-step code.  */
	  breaks[1] = branch_bp;
	  last_breakpoint++;
	}
    }
  if (!sc_found)
    return NULL;

  /* Insert a breakpoint right after the end of the atomic sequence.  */
  breaks[0] = loc;

  /* Check for duplicated breakpoints.  Check also for a breakpoint
     placed (branch instruction's destination) in the atomic sequence */
  if (last_breakpoint && pc <= breaks[1] && breaks[1] <= breaks[0])
    last_breakpoint = 0;

  /* Effectively inserts the breakpoints.  */
  for (index = 0; index <= last_breakpoint; index++)
    VEC_safe_push (CORE_ADDR, next_pcs, breaks[index]);

  return next_pcs;
}

/* nanomips_software_single_step() is called just before we want to resume
   the inferior, if we want to single-step it but there is no hardware
   or kernel single-step support (nanoMIPS on GNU/Linux for example).  We find
   the target of the coming instruction and breakpoint it.  */

VEC (CORE_ADDR) *
nanomips_software_single_step (struct regcache *regcache)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  CORE_ADDR pc, next_pc;
  VEC (CORE_ADDR) *next_pcs;

  pc = regcache_read_pc (regcache);
  next_pcs = nanomips_deal_with_atomic_sequence (gdbarch, pc);
  if (next_pcs != NULL)
    return next_pcs;

  next_pc = nanomicromips_next_pc (regcache, pc);

  VEC_safe_push (CORE_ADDR, next_pcs, next_pc);
  return next_pcs;
}

/* This fencepost looks highly suspicious to me.  Removing it also
   seems suspicious as it could affect remote debugging across serial
   lines.  */

static CORE_ADDR
heuristic_proc_start (struct gdbarch *gdbarch, CORE_ADDR pc)
{
  CORE_ADDR start_pc;
  CORE_ADDR fence;
  int instlen;
  int seen_adjsp = 0;
  struct inferior *inf;

  pc = gdbarch_addr_bits_remove (gdbarch, pc);
  start_pc = pc;
  fence = start_pc - heuristic_fence_post;
  if (start_pc == 0)
    return 0;

  if (heuristic_fence_post == -1 || fence < VM_MIN_ADDRESS)
    fence = VM_MIN_ADDRESS;

  instlen = INSN16_SIZE;

  inf = current_inferior ();

  /* Search back for previous return.  */
  for (start_pc -= instlen;; start_pc -= instlen)
    if (start_pc < fence)
      {
	/* It's not clear to me why we reach this point when
	   stop_soon, but with this test, at least we
	   don't print out warnings for every child forked (eg, on
	   decstation).  22apr93 rich@cygnus.com.  */
	if (inf->control.stop_soon == NO_STOP_QUIETLY)
	  {
	    static int blurb_printed = 0;

	    warning (_("GDB can't find the start of the function at %s."),
		     paddress (gdbarch, pc));

	    if (!blurb_printed)
	      {
		/* This actually happens frequently in embedded
		   development, when you first connect to a board
		   and your stack pointer and pc are nowhere in
		   particular.  This message needs to give people
		   in that situation enough information to
		   determine that it's no big deal.  */
		printf_filtered ("\n\
    GDB is unable to find the start of the function at %s\n\
and thus can't determine the size of that function's stack frame.\n\
This means that GDB may be unable to access that stack frame, or\n\
the frames below it.\n\
    This problem is most likely caused by an invalid program counter or\n\
stack pointer.\n\
    However, if you think GDB should simply search farther back\n\
from %s for code which looks like the beginning of a\n\
function, you can increase the range of the search using the `set\n\
heuristic-fence-post' command.\n",
			paddress (gdbarch, pc), paddress (gdbarch, pc));
		blurb_printed = 1;
	      }
	  }

	return 0;
      }
    else
      {
	ULONGEST insn;
	int size;

	/* On nanomips, SAVE is likely to be the start of a function.  */
	insn = nanomips_fetch_instruction (gdbarch, pc, NULL);
	size = nanomips_insn_size (insn);
	if ((size == 2 && micromips_op (insn) == 0x7) ||
	    (size == 4 && micromips_op (insn) == 0x20))
	    break;
      }

  return start_pc;
}

/* On p32, argument passing in GPRs depends on the alignment of the type being
   passed.  Return 1 if this type must be aligned to a doubleword boundary.  */

static int
type_needs_double_align (struct type *type)
{
  enum type_code typecode = TYPE_CODE (type);

  if ((typecode == TYPE_CODE_FLT || typecode == TYPE_CODE_INT)
      && TYPE_LENGTH (type) == 8)
    return 1;
  else if (typecode == TYPE_CODE_STRUCT)
    {
      if (TYPE_NFIELDS (type) > 1)
	return 0;
      return type_needs_double_align (TYPE_FIELD_TYPE (type, 0));
    }
  else if (typecode == TYPE_CODE_UNION)
    {
      int i, n;

      n = TYPE_NFIELDS (type);
      for (i = 0; i < n; i++)
	if (type_needs_double_align (TYPE_FIELD_TYPE (type, i)))
	  return 1;
      return 0;
    }
  return 0;
}

/* Adjust the address downward (direction of stack growth) so that it
   is correctly aligned for a new stack frame.  */
static CORE_ADDR
nanomips_frame_align (struct gdbarch *gdbarch, CORE_ADDR addr)
{
  return align_down (addr, 16);
}

/* Implement the "push_dummy_code" gdbarch method.  */

static CORE_ADDR
nanomips_push_dummy_code (struct gdbarch *gdbarch, CORE_ADDR sp,
			  CORE_ADDR funaddr, struct value **args,
			  int nargs, struct type *value_type,
			  CORE_ADDR *real_pc, CORE_ADDR *bp_addr,
			  struct regcache *regcache)
{
  /* Reserve enough room on the stack for our breakpoint instruction.  */
  sp = sp - 4;
  *bp_addr = sp;

  /* Inferior resumes at the function entry point.  */
  *real_pc = funaddr;

  return sp;
}

/* p32, p64 ABI stuff.  */

#define MAX_REG_ARGS	8	/* Maximum 8 arguments in registers */

/* FIXME: Complete this once we have calling conventions set for nanomips */
static CORE_ADDR
nanomips_push_dummy_call (struct gdbarch *gdbarch, struct value *function,
			  struct regcache *regcache, CORE_ADDR bp_addr,
			  int nargs, struct value **args, CORE_ADDR sp,
			  int struct_return, CORE_ADDR struct_addr)
{
  int arg_gpr = 0, arg_fpr = 0;
  int argnum;
  int stack_offset = 0, stack_size = 0;
  int seen_on_stack = 0;
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  CORE_ADDR func_addr = find_function_addr (function, NULL);
  int regsize = nanomips_abi_regsize (gdbarch);

  /* Set the return address register to point to the entry point of
     the program, where a breakpoint lies in wait.  */
  regcache_cooked_write_signed (regcache, RA_REGNUM, bp_addr);

  /* First ensure that the stack and structure return address (if any)
     are properly aligned.  The stack has to be at least 64-bit
     aligned even on 32-bit machines, because doubles must be 64-bit
     aligned.  */

  sp = align_down (sp, 16);
  struct_addr = align_down (struct_addr, 16);

  /* Calculate space required on the stack for the args.  */
  for (argnum = 0; argnum < nargs; argnum++)
    {
      struct type *arg_type = check_typedef (value_type (args[argnum]));

      /* Align to double-word if necessary.  */
      if (type_needs_double_align (arg_type))
	stack_size = align_up (stack_size, NANOMIPS32_REGSIZE * 2);

      /* Allocate space on the stack.  */
      stack_size += align_up (TYPE_LENGTH (arg_type), NANOMIPS32_REGSIZE);
    }
  stack_size = align_up (stack_size, 16);

  if (nanomips_debug)
    fprintf_unfiltered (gdb_stdlog, "nanomips_push_dummy_call (stack_size=%d)\n", stack_size);

  /* The struct_return pointer occupies the first parameter-passing reg.  */
  if (struct_return)
    {
      if (nanomips_debug)
	fprintf_unfiltered (gdb_stdlog,
			    "  struct_return reg=%d %s\n",
			    arg_gpr + A0_REGNUM,
			    paddress (gdbarch, struct_addr));

      regcache_cooked_write_unsigned (regcache, arg_gpr + A0_REGNUM,
				      struct_addr);

      /* occupy first argument reg */
      arg_gpr++;
    }

  /* Now load as many as possible of the first arguments into
     registers, and push the rest onto the stack.  Loop thru args
     from first to last.  */
  for (argnum = 0; argnum < nargs; argnum++)
    {
      const gdb_byte *val;
      gdb_byte valbuf[MAX_REGISTER_SIZE];
      struct value *arg = args[argnum];
      struct type *arg_type = check_typedef (value_type (arg));
      int len = TYPE_LENGTH (arg_type);
      enum type_code typecode = TYPE_CODE (arg_type);

      if (typecode == TYPE_CODE_STRUCT && TYPE_NFIELDS (arg_type) == 1)
      {
          if (TYPE_CODE (TYPE_FIELD_TYPE (arg_type, 0)) == TYPE_CODE_TYPEDEF)
            {
              struct type *type = check_typedef (TYPE_FIELD_TYPE (arg_type, 0));
              typecode = TYPE_CODE (type);
              len = TYPE_LENGTH (arg_type);
            }
          else if (TYPE_CODE (TYPE_FIELD_TYPE (arg_type, 0)) == TYPE_CODE_FLT)
            {
              typecode = TYPE_CODE_FLT;
            }
      }

      /* The P32 ABI passes structures larger than 8 bytes by reference. */
      if ((typecode == TYPE_CODE_ARRAY || typecode == TYPE_CODE_STRUCT
          || typecode == TYPE_CODE_UNION || typecode == TYPE_CODE_COMPLEX)
          && len > regsize * 2)
        {
          store_unsigned_integer (valbuf, regsize, byte_order,
                value_address (arg));
          typecode = TYPE_CODE_PTR;
          len = 4;
          val = valbuf;

          if (nanomips_debug)
            fprintf_unfiltered (gdb_stdlog, " push");
        }
          else
        val = value_contents (arg);


      while (len > 0)
	{
	  int partial_len = (len < NANOMIPS32_REGSIZE ? len : NANOMIPS32_REGSIZE);
	  int base_arg_reg;
	  LONGEST regval;
	  int use_stack = 0;

	  /* Align the argument register for double and long long types.  */
	  if ((arg_gpr < MAX_REG_ARGS) && (arg_gpr & 1) && (len == 8)
        && ((typecode == TYPE_CODE_FLT
        && FPU_TYPE(gdbarch) == NANOMIPS_FPU_SOFT)
        || typecode == TYPE_CODE_INT))
	    {
	      arg_gpr++;
	      stack_offset += 4;
	    }

    if (typecode == TYPE_CODE_STRUCT && (len <= 8 && len > 4) && arg_gpr == 7)
      arg_gpr ++;

	  /* double type occupies only one register.  */
	  if (typecode == TYPE_CODE_FLT && len == 8)
	    partial_len = (FPU_TYPE(gdbarch) == NANOMIPS_FPU_HARD ? 8 : 4);

	  regval = extract_unsigned_integer (val, partial_len, byte_order);

	  /* Check if any argument register is available.  */
	  if (typecode == TYPE_CODE_FLT && FPU_TYPE(gdbarch) == NANOMIPS_FPU_HARD)
	    {
        if(arg_fpr < MAX_REG_ARGS)
          {
            if (nanomips_debug)
              {
                int r_num = arg_fpr + nanomips_fp_arg_regnum (gdbarch)
                  + gdbarch_num_regs (gdbarch);
                const char *r = nanomips_register_name (gdbarch, r_num);
                fprintf_unfiltered (gdb_stdlog,
                        "  argnum=%d,reg=%s,len=%d,val=%ld\n",
                        argnum + 1, r, partial_len, regval);
              }

           /* Update the register with specified value.  */
           regcache_cooked_write_unsigned (regcache,
                    arg_fpr + nanomips_fp_arg_regnum (gdbarch),
                    regval);
            arg_fpr++;
          }
        else
          use_stack = 1;
	    }
	  else
	    {
		    if (arg_gpr < MAX_REG_ARGS)
          {
            if (nanomips_debug)
              {
                int r_num = arg_gpr + A0_REGNUM
                  + gdbarch_num_regs (gdbarch);
                const char *r = nanomips_register_name (gdbarch, r_num);
                fprintf_unfiltered (gdb_stdlog,
                        "  argnum=%d,reg=%s,len=%d,val=%ld\n",
                        argnum + 1, r, partial_len, regval);
              }

            /* Update the register with specified value.  */
            regcache_cooked_write_unsigned (regcache,
                     arg_gpr + A0_REGNUM, regval);
            arg_gpr++;

	        }
	      else
	        use_stack = 1;

	    }

	  if (use_stack)
	    {
	      CORE_ADDR addr;

	      if (nanomips_debug)
		{
		  int i;
		  LONGEST regval = extract_unsigned_integer (val, len,
							     byte_order);
		  fprintf_unfiltered (gdb_stdlog,
				      "  argnum=%d,off=%d,len=%d,val=%ld\n",
				      argnum + 1, stack_offset, partial_len,
				      regval);
		}

	      addr = (sp - stack_size) + stack_offset;
	      write_memory (addr, val, partial_len);

	      seen_on_stack = 1;
	      stack_offset += (partial_len <= NANOMIPS32_REGSIZE)
                            ? NANOMIPS32_REGSIZE : partial_len;
	      use_stack = 0;
	    } /* argument on stack */

	  val += partial_len;
	  len -= partial_len;
	}
    }

  if (seen_on_stack)
    sp -= stack_size;

  regcache_cooked_write_signed (regcache, SP_REGNUM, sp);

  /* Return adjusted stack pointer.  */
  return sp;
}

static enum return_value_convention
nanomips_return_value (struct gdbarch *gdbarch, struct value *function,
           struct type *type, struct regcache *regcache,
           gdb_byte *readbuf, const gdb_byte *writebuf)
{
  if ((TYPE_CODE (type) == TYPE_CODE_ARRAY
      ||TYPE_CODE (type) == TYPE_CODE_STRUCT
      || TYPE_CODE (type) == TYPE_CODE_COMPLEX)
      && TYPE_LENGTH (type) > 2 * NANOMIPS32_REGSIZE)
    return RETURN_VALUE_STRUCT_CONVENTION;

  else if (TYPE_CODE (type) == TYPE_CODE_COMPLEX
     && FPU_TYPE(gdbarch) == NANOMIPS_FPU_HARD)
    {
      nanomips_xfer_register (gdbarch, regcache,
        gdbarch_num_regs (gdbarch)
        + nanomips_regnum (gdbarch)->fp0,
        4,
        gdbarch_byte_order (gdbarch),
        readbuf, writebuf, 0);
      nanomips_xfer_register (gdbarch, regcache,
        gdbarch_num_regs (gdbarch)
        + nanomips_regnum (gdbarch)->fp0 + 1,
        4,
        gdbarch_byte_order (gdbarch),
        readbuf, writebuf, 4);
      return RETURN_VALUE_REGISTER_CONVENTION;
    }
  else if (TYPE_CODE (type) == TYPE_CODE_FLT
     && FPU_TYPE(gdbarch) == NANOMIPS_FPU_HARD)
    {
        nanomips_xfer_register (gdbarch, regcache,
          gdbarch_num_regs (gdbarch)
          + nanomips_regnum (gdbarch)->fp0,
          TYPE_LENGTH (type),
          gdbarch_byte_order (gdbarch),
          readbuf, writebuf, 0);
      return RETURN_VALUE_REGISTER_CONVENTION;
    }
  else
    {
      int offset;
      int regnum;
      for (offset = 0, regnum = A0_REGNUM;
     offset < TYPE_LENGTH (type);
     offset += NANOMIPS32_REGSIZE, regnum++)
  {
    int xfer = NANOMIPS32_REGSIZE;
    if (offset + xfer > TYPE_LENGTH (type))
      xfer = TYPE_LENGTH (type) - offset;
    if (nanomips_debug)
      fprintf_unfiltered (gdb_stderr, "Return scalar+%d:%d in $%d\n",
        offset, xfer, regnum);
    nanomips_xfer_register (gdbarch, regcache,
            gdbarch_num_regs (gdbarch) + regnum, xfer,
            gdbarch_byte_order (gdbarch),
            readbuf, writebuf, offset);
  }
      return RETURN_VALUE_REGISTER_CONVENTION;
    }
}

/* Copy a 32-bit single-precision value from the current frame
   into rare_buffer.  */

static void
read_fp_register_single (struct frame_info *frame, int regno,
			 gdb_byte *rare_buffer)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);
  int raw_size = register_size (gdbarch, regno);
  int offset;
  gdb_byte *raw_buffer = (gdb_byte *) alloca (raw_size);

  if (!deprecated_frame_register_read (frame, regno, raw_buffer))
    error (_("can't read register %d (%s)"),
	   regno, gdbarch_register_name (gdbarch, regno));

  /* We have a 64-bit value for this register.  Find the low-order 32 bits.  */
  if (gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG)
    offset = 4;
  else
    offset = 0;

  memcpy (rare_buffer, raw_buffer + offset, 4);
}

/* Copy a 64-bit double-precision value from the current frame into
   rare_buffer.  */

static void
read_fp_register_double (struct frame_info *frame, int regno,
			 gdb_byte *rare_buffer)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);

  /* We have a 64-bit value for this register, use all 64 bits.  */
  if (!deprecated_frame_register_read (frame, regno, rare_buffer))
      error (_("can't read register %d (%s)"),
	     regno, gdbarch_register_name (gdbarch, regno));
}

static void
print_fp_register (struct ui_file *file, struct frame_info *frame,
		   int regnum)
{		/* Do values for FP (float) regs.  */
  struct gdbarch *gdbarch = get_frame_arch (frame);
  gdb_byte *raw_buffer;
  double doub, flt1;	/* Doubles extracted from raw hex data.  */
  int inv1, inv2;
  struct value_print_options opts;

  raw_buffer
    = ((gdb_byte *)
       alloca (2 * register_size (gdbarch, nanomips_regnum (gdbarch)->fp0)));

  fprintf_filtered (file, "%s:", gdbarch_register_name (gdbarch, regnum));
  fprintf_filtered (file, "%*s",
		    4 - (int) strlen (gdbarch_register_name (gdbarch, regnum)),
		    "");

  /* Eight byte registers: print each one as hex, float and double.  */
  read_fp_register_single (frame, regnum, raw_buffer);
  flt1 = unpack_double (builtin_type (gdbarch)->builtin_float,
			raw_buffer, &inv1);

  read_fp_register_double (frame, regnum, raw_buffer);
  doub = unpack_double (builtin_type (gdbarch)->builtin_double,
			raw_buffer, &inv2);

  get_formatted_print_options (&opts, 'x');
  print_scalar_formatted (raw_buffer,
			  builtin_type (gdbarch)->builtin_uint64,
			  &opts, 'g', file);

  fprintf_filtered (file, " flt: ");
  if (inv1)
    fprintf_filtered (file, "<invalid float>");
  else
    fprintf_filtered (file, "%-17.9g", flt1);

  fprintf_filtered (file, " dbl: ");
  if (inv2)
    fprintf_filtered (file, "<invalid double>");
  else
    fprintf_filtered (file, "%-24.17g", doub);
}

static void
nanomips_print_register (struct ui_file *file, struct frame_info *frame,
			 int regnum)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);
  struct value_print_options opts;
  struct value *val;

  if (nanomips_float_register_p (gdbarch, regnum))
    {
      print_fp_register (file, frame, regnum);
      return;
    }

  val = get_frame_register_value (frame, regnum);

  fputs_filtered (gdbarch_register_name (gdbarch, regnum), file);

  /* The problem with printing numeric register names (r26, etc.) is that
     the user can't use them on input.  Probably the best solution is to
     fix it so that either the numeric or the funky (a2, etc.) names
     are accepted on input.  */
  if (regnum < NUMREGS)
    fprintf_filtered (file, "(r%d): ", regnum);
  else
    fprintf_filtered (file, ": ");

  get_formatted_print_options (&opts, 'x');
  val_print_scalar_formatted (value_type (val),
			      value_embedded_offset (val),
			      val,
			      &opts, 0, file);
}

/* Print IEEE exception condition bits in FLAGS.  */

static void
print_fpu_flags (struct ui_file *file, int flags)
{
  if (flags & (1 << 0))
    fputs_filtered (" inexact", file);
  if (flags & (1 << 1))
    fputs_filtered (" uflow", file);
  if (flags & (1 << 2))
    fputs_filtered (" oflow", file);
  if (flags & (1 << 3))
    fputs_filtered (" div0", file);
  if (flags & (1 << 4))
    fputs_filtered (" inval", file);
  if (flags & (1 << 5))
    fputs_filtered (" unimp", file);
  fputc_filtered ('\n', file);
}

/* Print interesting information about the floating point processor
   (if present) or emulator.  */

static void
nanomips_print_float_info (struct gdbarch *gdbarch, struct ui_file *file,
			   struct frame_info *frame, const char *args)
{
  int fcsr = nanomips_regnum (gdbarch)->fp_control_status;
  enum fpu_type type = FPU_TYPE (gdbarch);
  ULONGEST fcs = 0;
  int i;

  if (fcsr == -1 || !read_frame_register_unsigned (frame, fcsr, &fcs))
    type = NANOMIPS_FPU_NONE;

  fprintf_filtered (file, "fpu type: %s\n",
		    type == NANOMIPS_FPU_HARD ? "64bit hardware floating point"
		    : type == NANOMIPS_FPU_SOFT ? "Software floating point"
		    : "none / unused");

  if (type == NANOMIPS_FPU_NONE)
    return;

  fprintf_filtered (file, "reg size: %d bits\n",
		    register_size (gdbarch, nanomips_regnum (gdbarch)->fp0) * 8);

  fputs_filtered ("cond    :", file);
  if (fcs & (1 << 23))
    fputs_filtered (" 0", file);
  for (i = 1; i <= 7; i++)
    if (fcs & (1 << (24 + i)))
      fprintf_filtered (file, " %d", i);
  fputc_filtered ('\n', file);

  fputs_filtered ("cause   :", file);
  print_fpu_flags (file, (fcs >> 12) & 0x3f);
  fputs ("mask    :", stdout);
  print_fpu_flags (file, (fcs >> 7) & 0x1f);
  fputs ("flags   :", stdout);
  print_fpu_flags (file, (fcs >> 2) & 0x1f);

  fputs_filtered ("rounding: ", file);
  switch (fcs & 3)
    {
    case 0: fputs_filtered ("nearest\n", file); break;
    case 1: fputs_filtered ("zero\n", file); break;
    case 2: fputs_filtered ("+inf\n", file); break;
    case 3: fputs_filtered ("-inf\n", file); break;
    }

  fputs_filtered ("flush   :", file);
  if (fcs & (1 << 21))
    fputs_filtered (" nearest", file);
  if (fcs & (1 << 22))
    fputs_filtered (" override", file);
  if (fcs & (1 << 24))
    fputs_filtered (" zero", file);
  if ((fcs & (0xb << 21)) == 0)
    fputs_filtered (" no", file);
  fputc_filtered ('\n', file);

  fprintf_filtered (file, "nan2008 : %s\n", fcs & (1 << 18) ? "yes" : "no");
  fprintf_filtered (file, "abs2008 : %s\n", fcs & (1 << 19) ? "yes" : "no");
  fputc_filtered ('\n', file);

  default_print_float_info (gdbarch, file, frame, args);
}

/* Replacement for generic do_registers_info.
   Print regs in pretty columns.  */

static int
print_fp_register_row (struct ui_file *file, struct frame_info *frame,
		       int regnum)
{
  fprintf_filtered (file, " ");
  print_fp_register (file, frame, regnum);
  fprintf_filtered (file, "\n");
  return regnum + 1;
}


/* Print a row's worth of GP (int) registers, with name labels above.  */

static int
print_gp_register_row (struct ui_file *file, struct frame_info *frame,
		       int start_regnum)
{
  struct gdbarch *gdbarch = get_frame_arch (frame);
  /* Do values for GP (int) regs.  */
  gdb_byte raw_buffer[MAX_REGISTER_SIZE];
  int ncols = (nanomips_abi_regsize (gdbarch) == 8 ? 4 : 8);    /* display cols
							       per row.  */
  int col, byte;
  int regnum;

  /* For GP registers, we print a separate row of names above the vals.  */
  for (col = 0, regnum = start_regnum;
       col < ncols && regnum < gdbarch_num_regs (gdbarch)
			       + gdbarch_num_pseudo_regs (gdbarch);
       regnum++)
    {
      if (*gdbarch_register_name (gdbarch, regnum) == '\0')
	continue;		/* unused register */
      if (nanomips_float_register_p (gdbarch, regnum))
	break;			/* End the row: reached FP register.  */
      /* Large registers are handled separately.  */
      if (register_size (gdbarch, regnum) > nanomips_abi_regsize (gdbarch))
	{
	  if (col > 0)
	    break;		/* End the row before this register.  */

	  /* Print this register on a row by itself.  */
	  nanomips_print_register (file, frame, regnum);
	  fprintf_filtered (file, "\n");
	  return regnum + 1;
	}
      if (col == 0)
	fprintf_filtered (file, "     ");
      fprintf_filtered (file,
			nanomips_abi_regsize (gdbarch) == 8 ? "%17s" : "%9s",
			gdbarch_register_name (gdbarch, regnum));
      col++;
    }

  if (col == 0)
    return regnum;

  /* Print the R0 to R31 names.  */
  if ((start_regnum % gdbarch_num_regs (gdbarch)) < NUMREGS)
    fprintf_filtered (file, "\n R%-4d",
		      start_regnum % gdbarch_num_regs (gdbarch));
  else
    fprintf_filtered (file, "\n      ");

  /* Now print the values in hex, 4 or 8 to the row.  */
  for (col = 0, regnum = start_regnum;
       col < ncols && regnum < gdbarch_num_regs (gdbarch)
			       + gdbarch_num_pseudo_regs (gdbarch);
       regnum++)
    {
      if (*gdbarch_register_name (gdbarch, regnum) == '\0')
	continue;		/* unused register */
      if (nanomips_float_register_p (gdbarch, regnum))
	break;			/* End row: reached FP register.  */
      if (register_size (gdbarch, regnum) > nanomips_abi_regsize (gdbarch))
	break;			/* End row: large register.  */

      /* OK: get the data in raw format.  */
      if (!deprecated_frame_register_read (frame, regnum, raw_buffer))
	error (_("can't read register %d (%s)"),
	       regnum, gdbarch_register_name (gdbarch, regnum));
      /* pad small registers */
      for (byte = 0;
	   byte < (nanomips_abi_regsize (gdbarch)
		   - register_size (gdbarch, regnum)); byte++)
	printf_filtered ("  ");
      /* Now print the register value in hex, endian order.  */
      if (gdbarch_byte_order (gdbarch) == BFD_ENDIAN_BIG)
	for (byte =
	     register_size (gdbarch, regnum) - register_size (gdbarch, regnum);
	     byte < register_size (gdbarch, regnum); byte++)
	  fprintf_filtered (file, "%02x", raw_buffer[byte]);
      else
	for (byte = register_size (gdbarch, regnum) - 1;
	     byte >= 0; byte--)
	  fprintf_filtered (file, "%02x", raw_buffer[byte]);
      fprintf_filtered (file, " ");
      col++;
    }
  if (col > 0)			/* ie. if we actually printed anything...  */
    fprintf_filtered (file, "\n");

  return regnum;
}

/* MIPS_DO_REGISTERS_INFO(): called by "info register" command.  */

static void
nanomips_print_registers_info (struct gdbarch *gdbarch, struct ui_file *file,
			       struct frame_info *frame, int regnum, int all)
{
  if (regnum != -1)		/* Do one specified register.  */
    {
      gdb_assert (regnum >= gdbarch_num_regs (gdbarch));
      if (*(gdbarch_register_name (gdbarch, regnum)) == '\0')
	error (_("Not a valid register for the current processor type"));

      nanomips_print_register (file, frame, regnum);
      fprintf_filtered (file, "\n");
    }
  else
    /* Do all (or most) registers.  */
    {
      regnum = gdbarch_num_regs (gdbarch);
      while (regnum < gdbarch_num_regs (gdbarch)
		      + gdbarch_num_pseudo_regs (gdbarch))
	{
	  if (nanomips_float_register_p (gdbarch, regnum))
	    {
	      if (all)		/* True for "INFO ALL-REGISTERS" command.  */
		regnum = print_fp_register_row (file, frame, regnum);
	      else
		regnum += NUMREGS;	/* Skip floating point regs.  */
	    }
	  else
	    regnum = print_gp_register_row (file, frame, regnum);
	}
    }
}

/* To skip prologues, I use this predicate.  Returns either PC itself
   if the code at PC does not look like a function prologue; otherwise
   returns an address that (if we're lucky) follows the prologue.  If
   LENIENT, then we must skip everything which is involved in setting
   up the frame (it's OK to skip more, just so long as we don't skip
   anything which might clobber the registers which are being saved.
   We must skip more in the case where part of the prologue is in the
   delay slot of a non-prologue instruction).  */

static CORE_ADDR
nanomips_skip_prologue (struct gdbarch *gdbarch, CORE_ADDR pc)
{
  CORE_ADDR limit_pc;
  CORE_ADDR func_addr;

  /* See if we can determine the end of the prologue via the symbol table.
     If so, then return either PC, or the PC after the prologue, whichever
     is greater.  */
  if (find_pc_partial_function (pc, NULL, &func_addr, NULL))
    {
      CORE_ADDR post_prologue_pc
	= skip_prologue_using_sal (gdbarch, func_addr);
      if (post_prologue_pc != 0)
	return std::max (pc, post_prologue_pc);
    }

  /* Can't determine prologue from the symbol table, need to examine
     instructions.  */

  /* Find an upper limit on the function prologue using the debug
     information.  If the debug information could not be used to provide
     that bound, then use an arbitrary large number as the upper bound.  */
  limit_pc = skip_prologue_using_sal (gdbarch, pc);
  if (limit_pc == 0)
    limit_pc = pc + 100;          /* Magic.  */

  return nanomips_scan_prologue (gdbarch, pc, limit_pc, NULL, NULL);
}

/* Implement the stack_frame_destroyed_p gdbarch method (nanoMIPS version).
   This is a helper function for mips_stack_frame_destroyed_p.  */

static int
nanomips_stack_frame_destroyed_p (struct gdbarch *gdbarch, CORE_ADDR pc)
{
  CORE_ADDR func_addr = 0;
  CORE_ADDR func_end = 0;
  CORE_ADDR addr;
  ULONGEST insn;
  long offset;
  int dreg;
  int sreg;
  int treg, op;
  int loc;

  if (!find_pc_partial_function (pc, NULL, &func_addr, &func_end))
    return 0;

  /* The nanoMIPS epilogue is max. 12 bytes long.  */
  addr = func_end - 12;

  if (addr < func_addr + 2)
    addr = func_addr + 2;
  if (pc < addr)
    return 0;

  for (; pc < func_end; pc += loc)
    {
      loc = 0;
      insn = nanomips_fetch_instruction (gdbarch, pc, NULL);
      loc += INSN16_SIZE;
      switch (nanomips_insn_size (insn))
	{
	/* 48-bit instructions.  */
	case 3 * INSN16_SIZE:
	  if (micromips_op (insn) == 0x18)
	    {
	      op = b0s5_imm (insn);
	      treg = b5s5_reg (insn);
	      if (op == 0x0) /* LI48 xx, imm32 */
		break; /* continue scan */
	      else if (op == 0x1 /* ADDIU48 $sp, imm32 */
		       && treg == SP_REGNUM)
		return 1;
	    }
	  return 0;

	/* 32-bit instructions.  */
	case 2 * INSN16_SIZE:
	  insn <<= 16;
	  insn |= nanomips_fetch_instruction (gdbarch, pc + loc, NULL);
	  loc += INSN16_SIZE;

	  switch (micromips_op (insn >> 16))
	    {
	    case 0x0: /* PP.ADDIU bits 000000 */
	      treg = b5s5_reg (insn >> 16);
	      sreg = b0s5_reg (insn >> 16);
	      if (sreg == treg
		  && treg == SP_REGNUM) /* ADDIU $sp, $sp, imm */
		return 1;
	      else if (sreg == SP_REGNUM && treg == 30)
		break; /* continue scan */
	      return 0;

	    case 0x8: /* _POOL32A0 */
	      if ((insn & 0x1ff) == 0x150) /* ADDU */
		{
		  dreg = b11s5_reg (insn);
		  sreg = b0s5_reg (insn >> 16);
		  if ((dreg == sreg && sreg == SP_REGNUM)
		      /* ADDU $sp, $sp, xx */
		      || (dreg == SP_REGNUM && sreg == 30))
		      /* ADDU $sp, $fp, xx */
		    break; /* continue scan */
		}
	      else if (((insn & 0xffff) == 0xE37F) /* DERET */
		       || ((insn & 0x1ffff) == 0xF37F) /* ERET */
		       || ((insn & 0x1ffff) == 0x1F37F)) /* ERETNC */
		return 1;
	      return 0;

	    case 0x20: /* P.U12 bits 100000 */
	      if (b12s4_op (insn) == 0) /* ORI: bits 100000 0000 */
		{
		  sreg = b0s5_reg (insn >> 16);
		  treg = b5s5_reg (insn >> 16);
		  if (sreg == treg && treg == 3) /* ORI $v1, $v1, imm */
		    break; /* continue scan */
		}
	      else if (b12s5_op (insn) == 0x13) /* RESTORE, RESTORE.JRC */
		return 1;
	      return 0;

	    case 0x38: /* P.LUI bits 111000 */
	      treg = b5s5_reg (insn >> 16);
	      if ((insn & 2) == 0 /* LU20I bits 111000 0 */
		  && treg == 3) /* LU20I $v1, imm */
		break; /* continue scan */
	      return 0;

	    default:
	      return 0;
	    }
	  break;

	/* 16-bit instructions.  */
	case INSN16_SIZE:
	  switch (micromips_op (insn))
	    {
	    case 0x4: /* MOVE: bits 000100 */
	      sreg = b0s5_reg (insn);
	      dreg = b5s5_reg (insn);
	      if (sreg == SP_REGNUM && dreg == 30)
			/* MOVE  $fp, $sp */
		return 1;
	      return 0;

	    case 0x7: /* RESTORE[16], RESTORE.JRC[16] */
	      if ((insn & 0x20) == 0x20)
		return 1;
	      return 0;

	    case 0x36: /* JRC[16] $31 */
	      if ((insn & 0x1f) == 0 && b5s5_reg (insn) == 31)
		return 1;
	      return 0;

	    default:
		return 0;
	    }
	  break;
	}
    }

  return 1;
}

/* Root of all "set nanomips "/"show nanomips " commands.  This will eventually be
   used for all nanoMIPS-specific commands.  */

static void
show_nanomips_command (char *args, int from_tty)
{
  help_list (shownanomipscmdlist, "show nanomips ", all_commands, gdb_stdout);
}

static void
set_nanomips_command (char *args, int from_tty)
{
  printf_unfiltered
    ("\"set nanomips\" must be followed by an appropriate subcommand.\n");
  help_list (setnanomipscmdlist, "set nanomips ", all_commands, gdb_stdout);
}

/* Just like reinit_frame_cache, but with the right arguments to be
   callable as an sfunc.  */

static void
reinit_frame_cache_sfunc (char *args, int from_tty,
			  struct cmd_list_element *c)
{
  reinit_frame_cache ();
}

static int
gdb_print_insn_nanomips_p32 (bfd_vma memaddr, struct disassemble_info *info)
{
  info->mach = bfd_mach_nanomipsisa32r6;
  info->flavour = bfd_target_elf_flavour;
  info->disassembler_options = "gpr-names=p32";

  return print_insn_nanomips (memaddr, info);
}

static int
gdb_print_insn_nanomips_p64 (bfd_vma memaddr, struct disassemble_info *info)
{
  info->mach = bfd_mach_nanomipsisa64r6;
  info->flavour = bfd_target_elf_flavour;
  info->disassembler_options = "gpr-names=p64";

  return print_insn_nanomips (memaddr, info);
}

/* Implement the breakpoint_kind_from_pc gdbarch method.  */

static int
nanomips_breakpoint_kind_from_pc (struct gdbarch *gdbarch, CORE_ADDR *pcptr)
{
  CORE_ADDR pc = *pcptr;
  ULONGEST insn;
  int status;

  insn = nanomips_fetch_instruction (gdbarch, pc, &status);
  if (status || (nanomips_insn_size (insn) == 2))
    return NANOMIPS_BP_KIND_16;
  else
    return NANOMIPS_BP_KIND_32;
}

/* Implement the sw_breakpoint_from_kind gdbarch method.  */

static const gdb_byte *
nanomips_sw_breakpoint_from_kind (struct gdbarch *gdbarch, int kind, int *size)
{
  enum bfd_endian byte_order_for_code = gdbarch_byte_order_for_code (gdbarch);

  switch (kind)
    {
    case NANOMIPS_BP_KIND_16:
      {
	static gdb_byte be16_break[] = { 0x10, 0x10 };
	static gdb_byte le16_break[] = { 0x10, 0x10 };

	*size = 2;

	if (byte_order_for_code == BFD_ENDIAN_BIG)
	  return be16_break;
	else
	  return le16_break;
      }
    case NANOMIPS_BP_KIND_32:
      {
	static gdb_byte be32_break[] = { 0, 0x10, 0, 0 };
	static gdb_byte le32_break[] = { 0x10, 0, 0, 0 };

	*size = 4;
	if (byte_order_for_code == BFD_ENDIAN_BIG)
	  return be32_break;
	else
	  return le32_break;
      }
    default:
      gdb_assert_not_reached ("unexpected nanomips breakpoint kind");
    };
}

/* Convert a dbx stab register number (from `r' declaration) to a GDB
   [1 * gdbarch_num_regs .. 2 * gdbarch_num_regs) REGNUM.  */

static int
nanomips_stab_reg_to_regnum (struct gdbarch *gdbarch, int num)
{
  int regnum;
  if (num >= 0 && num < 32)
    regnum = num;
  else if (num >= 36 && num < 70)
    regnum = num + nanomips_regnum (gdbarch)->fp0 - 36;
  else if (nanomips_regnum (gdbarch)->dspacc != -1 && num >= 70 && num < 78)
    regnum = num + nanomips_regnum (gdbarch)->dspacc - 70;
  else
    return -1;
  return gdbarch_num_regs (gdbarch) + regnum;
}


/* Convert a dwarf, dwarf2, or ecoff register number to a GDB [1 *
   gdbarch_num_regs .. 2 * gdbarch_num_regs) REGNUM.  */

static int
nanomips_dwarf_dwarf2_ecoff_reg_to_regnum (struct gdbarch *gdbarch, int num)
{
  int regnum;
  if (num >= 0 && num < 32)
    regnum = num;
  else if (num >= 32 && num < 64)
    regnum = num + nanomips_regnum (gdbarch)->fp0 - 32;
  else if (nanomips_regnum (gdbarch)->dspacc != -1 && num >= 64 && num < 72)
    regnum = num + nanomips_regnum (gdbarch)->dspacc - 64;
  else
    return -1;
  return gdbarch_num_regs (gdbarch) + regnum;
}

static int
nanomips_register_sim_regno (struct gdbarch *gdbarch, int regnum)
{
  /* Only makes sense to supply raw registers.  */
  gdb_assert (regnum >= 0 && regnum < gdbarch_num_regs (gdbarch));
  /* FIXME: cagney/2002-05-13: Need to look at the pseudo register to
     decide if it is valid.  Should instead define a standard sim/gdb
     register numbering scheme.  */
  if (gdbarch_register_name (gdbarch,
			     gdbarch_num_regs (gdbarch) + regnum) != NULL
      && gdbarch_register_name (gdbarch,
			        gdbarch_num_regs (gdbarch)
				+ regnum)[0] != '\0')
    return regnum;
  else
    return LEGACY_SIM_REGNO_IGNORE;
}


/* Convert an integer into an address.  Extracting the value signed
   guarantees a correctly sign extended address.  */

static CORE_ADDR
nanomips_integer_to_address (struct gdbarch *gdbarch,
			     struct type *type, const gdb_byte *buf)
{
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  return extract_signed_integer (buf, TYPE_LENGTH (type), byte_order);
}

/* Dummy virtual frame pointer method.  This is no more or less accurate
   than most other architectures; we just need to be explicit about it,
   because the pseudo-register gdbarch_sp_regnum will otherwise lead to
   an assertion failure.  */

static void
nanomips_virtual_frame_pointer (struct gdbarch *gdbarch, 
				CORE_ADDR pc, int *reg, LONGEST *offset)
{
  *reg = SP_REGNUM;
  *offset = 0;
}

static void
nanomips_register_g_packet_guesses (struct gdbarch *gdbarch)
{
  /* If the size matches the set of 32-bit or 64-bit integer registers,
     assume that's what we've got.  */
  register_remote_g_packet_guess (gdbarch, 38 * 4, nanomips_tdesc_gp32);
  register_remote_g_packet_guess (gdbarch, 38 * 8, nanomips_tdesc_gp64);

  /* If the size matches the full set of registers GDB traditionally
     knows about, including floating point, for either 32-bit or
     64-bit, assume that's what we've got.  */
  register_remote_g_packet_guess (gdbarch, 90 * 4, nanomips_tdesc_gp32);
  register_remote_g_packet_guess (gdbarch, 90 * 8, nanomips_tdesc_gp64);

  /* Otherwise we don't have a useful guess.  */
}

static struct value *
value_of_nanomips_user_reg (struct frame_info *frame, const void *baton)
{
  const int *reg_p = (const int *) baton;
  return value_of_register (*reg_p, frame);
}

static struct gdbarch *
nanomips_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
{
  struct gdbarch *gdbarch;
  struct gdbarch_tdep *tdep;
  int elf_flags;
  enum nanomips_abi nanomips_abi, found_abi;
  int i, num_regs;
  enum fpu_type fpu_type;
  struct tdesc_arch_data *tdesc_data = NULL;
  int elf_fpu_type = Val_GNU_NANOMIPS_ABI_FP_ANY;
  const char **reg_names;
  struct nanomips_regnum nanomips_regnum, *regnum;
  int dspacc;
  int dspctl;

  /* Fill in the OS dependent register numbers and names.  */
  if (info.osabi == GDB_OSABI_LINUX)
    {
      nanomips_regnum.fp0 = 36;
      nanomips_regnum.pc = 35;
      nanomips_regnum.cause = 34;
      nanomips_regnum.badvaddr = 33;
      nanomips_regnum.fp_control_status = 68;
      nanomips_regnum.fp_implementation_revision = 69;
      nanomips_regnum.dspacc = -1;
      nanomips_regnum.dspctl = -1;
      dspacc = 70;
      dspctl = 78;
      num_regs = 79;
      reg_names = nanomips_linux_reg_names;
    }
  else
    {
      nanomips_regnum.badvaddr = EMBED_BADVADDR_REGNUM;
      nanomips_regnum.cause = EMBED_CAUSE_REGNUM;
      nanomips_regnum.pc = EMBED_PC_REGNUM;
      nanomips_regnum.fp0 = EMBED_FP0_REGNUM;
      nanomips_regnum.fp_control_status = 68;
      nanomips_regnum.fp_implementation_revision = 69;
      nanomips_regnum.dspacc = dspacc = -1;
      nanomips_regnum.dspctl = dspctl = -1;
      num_regs = LAST_EMBED_REGNUM + 1;
      reg_names = nanomips_generic_reg_names;
    }

  /* Check any target description for validity.  */
  if (tdesc_has_registers (info.target_desc))
    {
      static const char *const mips_gprs[] = {
	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
	"r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
      };
      static const char *const mips_fprs[] = {
	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
      };

      const struct tdesc_feature *feature;
      int valid_p;

      feature = tdesc_find_feature (info.target_desc,
				    "org.gnu.gdb.nanomips.cpu");
      if (feature == NULL)
	return NULL;

      tdesc_data = tdesc_data_alloc ();

      valid_p = 1;
      for (i = ZERO_REGNUM; i <= RA_REGNUM; i++)
	valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
					    mips_gprs[i]);


      valid_p &= tdesc_numbered_register (feature, tdesc_data,
					  nanomips_regnum.pc, "pc");

      if (!valid_p)
	{
	  tdesc_data_cleanup (tdesc_data);
	  return NULL;
	}

      feature = tdesc_find_feature (info.target_desc,
				    "org.gnu.gdb.nanomips.cp0");
      if (feature == NULL)
	{
	  tdesc_data_cleanup (tdesc_data);
	  return NULL;
	}

      valid_p = 1;
      valid_p &= tdesc_numbered_register (feature, tdesc_data,
					  nanomips_regnum.badvaddr, "badvaddr");
      valid_p &= tdesc_numbered_register (feature, tdesc_data,
					  PS_REGNUM, "status");
      valid_p &= tdesc_numbered_register (feature, tdesc_data,
					  nanomips_regnum.cause, "cause");

      if (!valid_p)
	{
	  tdesc_data_cleanup (tdesc_data);
	  return NULL;
	}

      /* FIXME drow/2007-05-17: The FPU should be optional.  The nanoMIPS
	 backend is not prepared for that, though.  */
      feature = tdesc_find_feature (info.target_desc,
				    "org.gnu.gdb.nanomips.fpu");
      if (feature == NULL)
	{
	  tdesc_data_cleanup (tdesc_data);
	  return NULL;
	}

      /* Only accept a description whose floating-point register size
         matches the requested size or if none was specified.  */
      valid_p = 1;
      for (i = 0; i < 32; i++)
	valid_p &= tdesc_numbered_register (feature, tdesc_data,
					    i + nanomips_regnum.fp0, mips_fprs[i]);

      valid_p &= tdesc_numbered_register (feature, tdesc_data,
					  nanomips_regnum.fp_control_status,
					  "fcsr");
      valid_p
	&= tdesc_numbered_register (feature, tdesc_data,
				    nanomips_regnum.fp_implementation_revision,
				    "fir");

      if (!valid_p)
	{
	  tdesc_data_cleanup (tdesc_data);
	  return NULL;
	}

      num_regs = nanomips_regnum.fp_implementation_revision + 1;

      if (dspacc >= 0)
	{
	  feature = tdesc_find_feature (info.target_desc,
					"org.gnu.gdb.nanomips.dsp");
	  /* The DSP registers are optional; it's OK if they are absent.  */
	  if (feature != NULL)
	    {
	      i = 0;
	      valid_p = 1;
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "hi0");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "lo0");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "hi1");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "lo1");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "hi2");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "lo2");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "hi3");
	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspacc + i++, "lo3");

	      valid_p &= tdesc_numbered_register (feature, tdesc_data,
						  dspctl, "dspctl");

	      if (!valid_p)
		{
		  tdesc_data_cleanup (tdesc_data);
		  return NULL;
		}

	      nanomips_regnum.dspacc = dspacc;
	      nanomips_regnum.dspctl = dspctl;

	      num_regs = nanomips_regnum.dspctl + 1;
	    }
	}

      /* It would be nice to detect an attempt to use a 64-bit ABI
	 when only 32-bit registers are provided.  */
      reg_names = NULL;
    }

  /* First of all, extract the elf_flags, if available.  */
  if (info.abfd && bfd_get_flavour (info.abfd) == bfd_target_elf_flavour)
    elf_flags = elf_elfheader (info.abfd)->e_flags;
  else if (arches != NULL)
    elf_flags = gdbarch_tdep (arches->gdbarch)->elf_flags;
  else
    elf_flags = 0;

  if (gdbarch_debug)
    fprintf_unfiltered (gdb_stdlog,
			"nanomips_gdbarch_init: elf_flags = 0x%08x\n",
			elf_flags);

  /* Check ELF_FLAGS to see if it specifies the ABI being used.  */
  switch ((elf_flags & EF_NANOMIPS_ABI))
    {
    case E_NANOMIPS_ABI_P32:
      found_abi = NANOMIPS_ABI_P32;
      break;
    case E_NANOMIPS_ABI_P64:
      found_abi = NANOMIPS_ABI_P64;
      break;
    default:
      found_abi = NANOMIPS_ABI_UNKNOWN;
      break;
    }

  /* If we have no useful BFD information, use the ABI from the last
     nanoMIPS architecture (if there is one).  */
  if (found_abi == NANOMIPS_ABI_UNKNOWN && info.abfd == NULL && arches != NULL)
    found_abi = gdbarch_tdep (arches->gdbarch)->found_abi;

  /* Try the architecture for any hint of the correct ABI.  */
  if (found_abi == NANOMIPS_ABI_UNKNOWN
      && info.bfd_arch_info != NULL
      && info.bfd_arch_info->arch == bfd_arch_nanomips)
    {
      switch (info.bfd_arch_info->mach)
	{
	case bfd_mach_nanomipsisa32r6:
	  found_abi = NANOMIPS_ABI_P32;
	  break;
	case bfd_mach_nanomipsisa64r6:
	  found_abi = NANOMIPS_ABI_P64;
	  break;
	}
    }

  /* Default 64-bit objects to P64 instead of P32.  */
  if (found_abi == NANOMIPS_ABI_UNKNOWN
      && info.abfd != NULL
      && bfd_get_flavour (info.abfd) == bfd_target_elf_flavour
      && elf_elfheader (info.abfd)->e_ident[EI_CLASS] == ELFCLASS64)
    found_abi = NANOMIPS_ABI_P64;

  if (gdbarch_debug)
    fprintf_unfiltered (gdb_stdlog, "nanomips_gdbarch_init: found_abi = %d\n",
			found_abi);

  /* Now that we have found what the ABI for this binary would be,
     check whether the user is overriding it.  */
  if (found_abi != NANOMIPS_ABI_UNKNOWN)
    nanomips_abi = found_abi;
  else
    nanomips_abi = NANOMIPS_ABI_P32;
  if (gdbarch_debug)
    fprintf_unfiltered (gdb_stdlog,
			"nanomips_gdbarch_init: nanomips_abi = %d\n",
			nanomips_abi);

  /* Determine the nanoMIPS FPU type.  */
  if (info.abfd
      && bfd_get_flavour (info.abfd) == bfd_target_elf_flavour)
    {
      Elf_Internal_ABIFlags_v0 *abiflags;
      abiflags = bfd_nanomips_elf_get_abiflags (info.abfd);
      if (abiflags != NULL)
	elf_fpu_type = abiflags->fp_abi;
    }

  if (elf_fpu_type != Val_GNU_NANOMIPS_ABI_FP_ANY)
    {
      switch (elf_fpu_type)
	{
	case Val_GNU_NANOMIPS_ABI_FP_SOFT:
	  fpu_type = NANOMIPS_FPU_SOFT;
	  break;
	default:
	  fpu_type = NANOMIPS_FPU_HARD;
	  break;
	}
    }
  else if (arches != NULL)
    fpu_type = gdbarch_tdep (arches->gdbarch)->fpu_type;
  else
    fpu_type = NANOMIPS_FPU_HARD;

  if (gdbarch_debug)
    fprintf_unfiltered (gdb_stdlog,
			"nanomips_gdbarch_init: fpu_type = %d\n", fpu_type);

  /* Check for blatant incompatibilities.  */

  /* If we have only 32-bit registers, then we can't debug a 64-bit
     ABI.  */
  if (info.target_desc
      && tdesc_property (info.target_desc, PROPERTY_GP32) != NULL
      && nanomips_abi != NANOMIPS_ABI_P32)
    {
      if (tdesc_data != NULL)
	tdesc_data_cleanup (tdesc_data);
      return NULL;
    }

  /* Try to find a pre-existing architecture.  */
  for (arches = gdbarch_list_lookup_by_info (arches, &info);
       arches != NULL;
       arches = gdbarch_list_lookup_by_info (arches->next, &info))
    {
      /* nanoMIPS needs to be pedantic about which ABI and the compressed
         ISA variation the object is using.  */
      if (gdbarch_tdep (arches->gdbarch)->elf_flags != elf_flags)
	continue;
      if (gdbarch_tdep (arches->gdbarch)->nanomips_abi != nanomips_abi)
	continue;
      /* Be pedantic about which FPU is selected.  */
      if (gdbarch_tdep (arches->gdbarch)->fpu_type != fpu_type)
	continue;

      if (tdesc_data != NULL)
	tdesc_data_cleanup (tdesc_data);
      return arches->gdbarch;
    }

  /* Need a new architecture.  Fill in a target specific vector.  */
  tdep = XNEW (struct gdbarch_tdep);
  gdbarch = gdbarch_alloc (&info, tdep);
  tdep->elf_flags = elf_flags;
  tdep->found_abi = found_abi;
  tdep->nanomips_abi = nanomips_abi;
  tdep->fpu_type = fpu_type;
  tdep->register_size_valid_p = 0;
  tdep->register_size = 0;

  if (info.target_desc)
    {
      /* Some useful properties can be inferred from the target.  */
      if (tdesc_property (info.target_desc, PROPERTY_GP32) != NULL)
	{
	  tdep->register_size_valid_p = 1;
	  tdep->register_size = 4;
	}
      else if (tdesc_property (info.target_desc, PROPERTY_GP64) != NULL)
	{
	  tdep->register_size_valid_p = 1;
	  tdep->register_size = 8;
	}
    }

  /* Initially set everything according to the default ABI/ISA.  */
  set_gdbarch_short_bit (gdbarch, 16);
  set_gdbarch_int_bit (gdbarch, 32);
  set_gdbarch_float_bit (gdbarch, 32);
  set_gdbarch_double_bit (gdbarch, 64);
  set_gdbarch_long_double_bit (gdbarch, 64);
  set_gdbarch_register_reggroup_p (gdbarch, nanomips_register_reggroup_p);
  set_gdbarch_pseudo_register_read (gdbarch, nanomips_pseudo_register_read);
  set_gdbarch_pseudo_register_write (gdbarch, nanomips_pseudo_register_write);
  set_gdbarch_ax_pseudo_register_collect (gdbarch,
					  nanomips_ax_pseudo_register_collect);
  set_gdbarch_ax_pseudo_register_push_stack
      (gdbarch, nanomips_ax_pseudo_register_push_stack);

  regnum = GDBARCH_OBSTACK_ZALLOC (gdbarch, struct nanomips_regnum);
  *regnum = nanomips_regnum;
  set_gdbarch_fp0_regnum (gdbarch, regnum->fp0);
  set_gdbarch_num_regs (gdbarch, num_regs);
  set_gdbarch_num_pseudo_regs (gdbarch, num_regs);
  set_gdbarch_register_name (gdbarch, nanomips_register_name);
  set_gdbarch_virtual_frame_pointer (gdbarch, nanomips_virtual_frame_pointer);
  tdep->mips_processor_reg_names = reg_names;
  tdep->regnum = regnum;

  tdep->mips_last_arg_regnum = A0_REGNUM + 8 - 1;
  tdep->mips_last_fp_arg_regnum = tdep->regnum->fp0 + 8 - 1;
  tdep->default_mask_address_p = 0;

  set_gdbarch_push_dummy_call (gdbarch, nanomips_push_dummy_call);
  set_gdbarch_return_value (gdbarch, nanomips_return_value);

  switch (nanomips_abi)
    {
    case NANOMIPS_ABI_P32:
      set_gdbarch_long_bit (gdbarch, 32);
      set_gdbarch_ptr_bit (gdbarch, 32);
      set_gdbarch_long_long_bit (gdbarch, 64);
      break;
    case NANOMIPS_ABI_P64:
      set_gdbarch_long_bit (gdbarch, 64);
      set_gdbarch_ptr_bit (gdbarch, 64);
      set_gdbarch_long_long_bit (gdbarch, 64);
      set_gdbarch_long_double_bit (gdbarch, 128);
      set_gdbarch_long_double_format (gdbarch, floatformats_ibm_long_double);
      break;
    default:
      internal_error (__FILE__, __LINE__, _("unknown ABI in switch"));
    }

  set_gdbarch_read_pc (gdbarch, nanomips_read_pc);
  set_gdbarch_write_pc (gdbarch, nanomips_write_pc);

  /* Add/remove bits from an address.  The nanoMIPS needs be careful to
     ensure that all 32 bit addresses are sign extended to 64 bits.  */
  set_gdbarch_addr_bits_remove (gdbarch, nanomips_addr_bits_remove);

  /* Unwind the frame.  */
  set_gdbarch_unwind_pc (gdbarch, nanomips_unwind_pc);
  set_gdbarch_unwind_sp (gdbarch, nanomips_unwind_sp);
  set_gdbarch_dummy_id (gdbarch, nanomips_dummy_id);

  /* Map debug register numbers onto internal register numbers.  */
  set_gdbarch_stab_reg_to_regnum (gdbarch, nanomips_stab_reg_to_regnum);
  set_gdbarch_ecoff_reg_to_regnum (gdbarch,
				   nanomips_dwarf_dwarf2_ecoff_reg_to_regnum);
  set_gdbarch_dwarf2_reg_to_regnum (gdbarch,
				    nanomips_dwarf_dwarf2_ecoff_reg_to_regnum);
  set_gdbarch_register_sim_regno (gdbarch, nanomips_register_sim_regno);

  /* nanoMIPS version of CALL_DUMMY.  */

  set_gdbarch_call_dummy_location (gdbarch, ON_STACK);
  set_gdbarch_push_dummy_code (gdbarch, nanomips_push_dummy_code);
  set_gdbarch_frame_align (gdbarch, nanomips_frame_align);

  set_gdbarch_print_float_info (gdbarch, nanomips_print_float_info);

  set_gdbarch_convert_register_p (gdbarch, nanomips_convert_register_p);
  set_gdbarch_register_to_value (gdbarch, nanomips_register_to_value);
  set_gdbarch_value_to_register (gdbarch, nanomips_value_to_register);

  set_gdbarch_inner_than (gdbarch, core_addr_lessthan);
  set_gdbarch_breakpoint_kind_from_pc (gdbarch,
				       nanomips_breakpoint_kind_from_pc);
  set_gdbarch_sw_breakpoint_from_kind (gdbarch,
				       nanomips_sw_breakpoint_from_kind);

  set_gdbarch_skip_prologue (gdbarch, nanomips_skip_prologue);

  set_gdbarch_stack_frame_destroyed_p (gdbarch,
				       nanomips_stack_frame_destroyed_p);

  set_gdbarch_pointer_to_address (gdbarch, signed_pointer_to_address);
  set_gdbarch_address_to_pointer (gdbarch, address_to_signed_pointer);
  set_gdbarch_integer_to_address (gdbarch, nanomips_integer_to_address);

  set_gdbarch_register_type (gdbarch, nanomips_register_type);

  set_gdbarch_print_registers_info (gdbarch, nanomips_print_registers_info);

  if (nanomips_abi == NANOMIPS_ABI_P64)
    set_gdbarch_print_insn (gdbarch, gdb_print_insn_nanomips_p64);
  else
    set_gdbarch_print_insn (gdbarch, gdb_print_insn_nanomips_p32);

  /* FIXME: cagney/2003-08-29: The macros target_have_steppable_watchpoint,
     HAVE_NONSTEPPABLE_WATCHPOINT, and target_have_continuable_watchpoint
     need to all be folded into the target vector.  Since they are
     being used as guards for target_stopped_by_watchpoint, why not have
     target_stopped_by_watchpoint return the type of watchpoint that the code
     is sitting on?  */
  set_gdbarch_have_nonsteppable_watchpoint (gdbarch, 1);

  /* Virtual tables.  */
  set_gdbarch_vbit_in_delta (gdbarch, 0);

  nanomips_register_g_packet_guesses (gdbarch);

  /* Hook in OS ABI-specific overrides, if they have been registered.  */
  gdbarch_init_osabi (info, gdbarch);

  /* The hook may have adjusted num_regs, fetch the final value and
     set pc_regnum and sp_regnum now that it has been fixed.  */
  num_regs = gdbarch_num_regs (gdbarch);
  set_gdbarch_pc_regnum (gdbarch, regnum->pc + num_regs);
  set_gdbarch_sp_regnum (gdbarch, SP_REGNUM + num_regs);

  /* Unwind the frame.  */
  dwarf2_append_unwinders (gdbarch);
  frame_unwind_append_unwinder (gdbarch, &nanomips_frame_unwind);
  frame_base_append_sniffer (gdbarch, dwarf2_frame_base_sniffer);
  frame_base_append_sniffer (gdbarch, nanomips_frame_base_sniffer);

  if (tdesc_data)
    {
      set_tdesc_pseudo_register_type (gdbarch, nanomips_pseudo_register_type);
      tdesc_use_registers (gdbarch, info.target_desc, tdesc_data);

      /* Override the normal target description methods to handle our
	 dual real and pseudo registers.  */
      set_gdbarch_register_name (gdbarch, nanomips_register_name);
      set_gdbarch_register_reggroup_p (gdbarch,
				       nanomips_tdesc_register_reggroup_p);

      num_regs = gdbarch_num_regs (gdbarch);
      set_gdbarch_num_pseudo_regs (gdbarch, num_regs);
      set_gdbarch_pc_regnum (gdbarch, tdep->regnum->pc + num_regs);
      set_gdbarch_sp_regnum (gdbarch, SP_REGNUM + num_regs);
    }

  /* Add some other standard aliases.  */
  for (i = 0; i < ARRAY_SIZE (nanomips_register_aliases); i++)
    user_reg_add (gdbarch, nanomips_register_aliases[i].name,
		  value_of_nanomips_user_reg,
		  &nanomips_register_aliases[i].regnum);

  return gdbarch;
}

static void
nanomips_dump_tdep (struct gdbarch *gdbarch, struct ui_file *file)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
  if (tdep != NULL)
    {
      int ef_mips_arch;
      int ef_mips_32bitmode;
      /* Determine the ISA.  */
      switch (tdep->elf_flags & EF_NANOMIPS_ARCH)
	{
	case E_NANOMIPS_ARCH_32R6:
	  ef_mips_arch = 1;
	  break;
	case E_NANOMIPS_ARCH_64R6:
	  ef_mips_arch = 2;
	  break;
	default:
	  ef_mips_arch = 0;
	  break;
	}
      /* Determine the size of a pointer.  */
      ef_mips_32bitmode = (tdep->elf_flags & EF_NANOMIPS_32BITMODE);
      fprintf_unfiltered (file,
			  "nanomips_dump_tdep: tdep->elf_flags = 0x%x\n",
			  tdep->elf_flags);
      fprintf_unfiltered (file,
			  "nanomips_dump_tdep: ef_mips_32bitmode = %d\n",
			  ef_mips_32bitmode);
      fprintf_unfiltered (file,
			  "nanomips_dump_tdep: ef_mips_arch = %d\n",
			  ef_mips_arch);
      fprintf_unfiltered (file,
			  "nanomips_dump_tdep: tdep->nanomips_abi = %d (%s)\n",
			  tdep->nanomips_abi,
			  nanomips_abi_strings[tdep->nanomips_abi]);
      fprintf_unfiltered (file,
			  "nanomips_dump_tdep: "
			  "nanomips_mask_address_p() %d (default %d)\n",
			  nanomips_mask_address_p (tdep),
			  tdep->default_mask_address_p);
    }

  fprintf_unfiltered (file,
		      "nanomips_dump_tdep: FPU_TYPE = %d (%s)\n",
		      FPU_TYPE (gdbarch),
		      (FPU_TYPE (gdbarch) == NANOMIPS_FPU_NONE ? "unknown"
		       : FPU_TYPE (gdbarch) == NANOMIPS_FPU_HARD ?
						"64bit hardware floating point"
		       : FPU_TYPE (gdbarch) == NANOMIPS_FPU_SOFT ?
						"Software floating point"
		       : "???"));
}

extern initialize_file_ftype _initialize_nanomips_tdep; /* -Wmissing-prototypes */

void
_initialize_nanomips_tdep (void)
{
  gdbarch_register (bfd_arch_nanomips, nanomips_gdbarch_init,
		    nanomips_dump_tdep);

  initialize_tdesc_nanomips ();

  nanomips_pdr_data = register_objfile_data ();

  /* Create feature sets with the appropriate properties.  The values
     are not important.  */
  nanomips_tdesc_gp32 = allocate_target_description ();
  set_tdesc_property (nanomips_tdesc_gp32, PROPERTY_GP32, "");

  nanomips_tdesc_gp64 = allocate_target_description ();
  set_tdesc_property (nanomips_tdesc_gp64, PROPERTY_GP64, "");

  /* Add root prefix command for all "set/show nanomips" commands.  */
  add_prefix_cmd ("nanomips", no_class, set_nanomips_command,
		  _("Various nanoMIPS specific commands."),
		  &setnanomipscmdlist, "set nanomips ", 0, &setlist);

  add_prefix_cmd ("nanomips", no_class, show_nanomips_command,
		  _("Various nanoMIPS specific commands."),
		  &shownanomipscmdlist, "show nanomips ", 0, &showlist);

  /* We really would like to have both "0" and "unlimited" work, but
     command.c doesn't deal with that.  So make it a var_zinteger
     because the user can always use "999999" or some such for unlimited.  */
  add_setshow_zinteger_cmd ("heuristic-fence-post", class_support,
			    &heuristic_fence_post, _("\
Set the distance searched for the start of a function."), _("\
Show the distance searched for the start of a function."), _("\
If you are debugging a stripped executable, GDB needs to search through the\n\
program for the start of a function.  This command sets the distance of the\n\
search.  The only need to set it is when debugging a stripped executable."),
			    reinit_frame_cache_sfunc,
			    NULL, /* FIXME: i18n: The distance searched for
				     the start of a function is %s.  */
			    &setlist, &showlist);

  /* Allow the user to control whether the upper bits of 64-bit
     addresses should be zeroed.  */
  add_setshow_auto_boolean_cmd ("mask-address", no_class,
				&mask_address_var, _("\
Set zeroing of upper 32 bits of 64-bit addresses."), _("\
Show zeroing of upper 32 bits of 64-bit addresses."), _("\
Use \"on\" to enable the masking, \"off\" to disable it and \"auto\" to\n\
allow GDB to determine the correct value."),
				NULL, show_mask_address,
				&setnanomipscmdlist, &shownanomipscmdlist);

  /* Debug this files internals.  */
  add_setshow_zuinteger_cmd ("nanomips", class_maintenance,
			     &nanomips_debug, _("\
Set nanomips debugging."), _("\
Show nanomips debugging."), _("\
When non-zero, nanomips specific debugging is enabled."),
			     NULL,
			     NULL, /* FIXME: i18n: Mips debugging is
				      currently %s.  */
			     &setdebuglist, &showdebuglist);
}
