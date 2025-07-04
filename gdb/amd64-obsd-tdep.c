/* Target-dependent code for OpenBSD/amd64.

   Copyright (C) 2003-2025 Free Software Foundation, Inc.

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

#include "extract-store-integer.h"
#include "frame.h"
#include "frame-unwind.h"
#include "gdbcore.h"
#include "symtab.h"
#include "objfiles.h"
#include "osabi.h"
#include "regcache.h"
#include "regset.h"
#include "target.h"
#include "trad-frame.h"

#include "obsd-tdep.h"
#include "amd64-tdep.h"
#include "i387-tdep.h"
#include "gdbsupport/x86-xstate.h"
#include "solib-svr4.h"
#include "bsd-uthread.h"

/* Support for signal handlers.  */

/* Default page size.  */
static const int amd64obsd_page_size = 4096;

/* Return whether THIS_FRAME corresponds to an OpenBSD sigtramp
   routine.  */

static int
amd64obsd_sigtramp_p (const frame_info_ptr &this_frame)
{
  CORE_ADDR pc = get_frame_pc (this_frame);
  CORE_ADDR start_pc = (pc & ~(amd64obsd_page_size - 1));
  const gdb_byte osigreturn[] =
  {
    0x48, 0xc7, 0xc0,
    0x67, 0x00, 0x00, 0x00,	/* movq $SYS_sigreturn, %rax */
    0xcd, 0x80			/* int $0x80 */
  };
  const gdb_byte sigreturn[] =
  {
    0x48, 0xc7, 0xc0,
    0x67, 0x00, 0x00, 0x00,	/* movq $SYS_sigreturn, %rax */
    0x0f, 0x05			/* syscall */
  };
  size_t buflen = (sizeof sigreturn) + 1;
  gdb_byte *buf;
  const char *name;

  /* If the function has a valid symbol name, it isn't a
     trampoline.  */
  find_pc_partial_function (pc, &name, NULL, NULL);
  if (name != NULL)
    return 0;

  /* If the function lives in a valid section (even without a starting
     point) it isn't a trampoline.  */
  if (find_pc_section (pc) != NULL)
    return 0;

  /* If we can't read the instructions at START_PC, return zero.  */
  buf = (gdb_byte *) alloca ((sizeof sigreturn) + 1);
  if (!safe_frame_unwind_memory (this_frame, start_pc + 6, {buf, buflen}))
    return 0;

  /* Check for sigreturn(2).  Depending on how the assembler encoded
     the `movq %rsp, %rdi' instruction, the code starts at offset 6 or
     7.  OpenBSD 5.0 and later use the `syscall' instruction.  Older
     versions use `int $0x80'.  Check for both.  */
  if (memcmp (buf, sigreturn, sizeof sigreturn)
      && memcmp (buf + 1, sigreturn, sizeof sigreturn)
      && memcmp (buf, osigreturn, sizeof osigreturn)
      && memcmp (buf + 1, osigreturn, sizeof osigreturn))
    return 0;

  return 1;
}

/* Assuming THIS_FRAME is for a BSD sigtramp routine, return the
   address of the associated sigcontext structure.  */

static CORE_ADDR
amd64obsd_sigcontext_addr (const frame_info_ptr &this_frame)
{
  CORE_ADDR pc = get_frame_pc (this_frame);
  ULONGEST offset = (pc & (amd64obsd_page_size - 1));

  /* The %rsp register points at `struct sigcontext' upon entry of a
     signal trampoline.  The relevant part of the trampoline is

	call    *%rax
	movq    %rsp, %rdi
	pushq   %rdi
	movq    $SYS_sigreturn,%rax
	int     $0x80

     (see /usr/src/sys/arch/amd64/amd64/locore.S).  The `pushq'
     instruction clobbers %rsp, but its value is saved in `%rdi'.  */

  if (offset > 5)
    return get_frame_register_unsigned (this_frame, AMD64_RDI_REGNUM);
  else
    return get_frame_register_unsigned (this_frame, AMD64_RSP_REGNUM);
}

/* OpenBSD 3.5 or later.  */

/* Mapping between the general-purpose registers in `struct reg'
   format and GDB's register cache layout.  */

/* From <machine/reg.h>.  */
int amd64obsd_r_reg_offset[] =
{
  14 * 8,			/* %rax */
  13 * 8,			/* %rbx */
  3 * 8,			/* %rcx */
  2 * 8,			/* %rdx */
  1 * 8,			/* %rsi */
  0 * 8,			/* %rdi */
  12 * 8,			/* %rbp */
  15 * 8,			/* %rsp */
  4 * 8,			/* %r8 ..  */
  5 * 8,
  6 * 8,
  7 * 8,
  8 * 8,
  9 * 8,
  10 * 8,
  11 * 8,			/* ... %r15 */
  16 * 8,			/* %rip */
  17 * 8,			/* %eflags */
  18 * 8,			/* %cs */
  19 * 8,			/* %ss */
  20 * 8,			/* %ds */
  21 * 8,			/* %es */
  22 * 8,			/* %fs */
  23 * 8			/* %gs */
};

/* From <machine/signal.h>.  */
static int amd64obsd_sc_reg_offset[] =
{
  14 * 8,			/* %rax */
  13 * 8,			/* %rbx */
  3 * 8,			/* %rcx */
  2 * 8,			/* %rdx */
  1 * 8,			/* %rsi */
  0 * 8,			/* %rdi */
  12 * 8,			/* %rbp */
  24 * 8,			/* %rsp */
  4 * 8,			/* %r8 ...  */
  5 * 8,
  6 * 8,
  7 * 8,
  8 * 8,
  9 * 8,
  10 * 8,
  11 * 8,			/* ... %r15 */
  21 * 8,			/* %rip */
  23 * 8,			/* %eflags */
  22 * 8,			/* %cs */
  25 * 8,			/* %ss */
  18 * 8,			/* %ds */
  17 * 8,			/* %es */
  16 * 8,			/* %fs */
  15 * 8			/* %gs */
};

/* From /usr/src/lib/libpthread/arch/amd64/uthread_machdep.c.  */
static int amd64obsd_uthread_reg_offset[] =
{
  19 * 8,			/* %rax */
  16 * 8,			/* %rbx */
  18 * 8,			/* %rcx */
  17 * 8,			/* %rdx */
  14 * 8,			/* %rsi */
  13 * 8,			/* %rdi */
  15 * 8,			/* %rbp */
  -1,				/* %rsp */
  12 * 8,			/* %r8 ...  */
  11 * 8,
  10 * 8,
  9 * 8,
  8 * 8,
  7 * 8,
  6 * 8,
  5 * 8,			/* ... %r15 */
  20 * 8,			/* %rip */
  4 * 8,			/* %eflags */
  21 * 8,			/* %cs */
  -1,				/* %ss */
  3 * 8,			/* %ds */
  2 * 8,			/* %es */
  1 * 8,			/* %fs */
  0 * 8				/* %gs */
};

/* Offset within the thread structure where we can find the saved
   stack pointer (%esp).  */
#define AMD64OBSD_UTHREAD_RSP_OFFSET	400

static void
amd64obsd_supply_uthread (struct regcache *regcache,
			  int regnum, CORE_ADDR addr)
{
  struct gdbarch *gdbarch = regcache->arch ();
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  CORE_ADDR sp_addr = addr + AMD64OBSD_UTHREAD_RSP_OFFSET;
  CORE_ADDR sp = 0;
  gdb_byte buf[8];
  int i;

  gdb_assert (regnum >= -1);

  if (regnum == -1 || regnum == AMD64_RSP_REGNUM)
    {
      int offset;

      /* Fetch stack pointer from thread structure.  */
      sp = read_memory_unsigned_integer (sp_addr, 8, byte_order);

      /* Adjust the stack pointer such that it looks as if we just
	 returned from _thread_machdep_switch.  */
      offset = amd64obsd_uthread_reg_offset[AMD64_RIP_REGNUM] + 8;
      store_unsigned_integer (buf, 8, byte_order, sp + offset);
      regcache->raw_supply (AMD64_RSP_REGNUM, buf);
    }

  for (i = 0; i < ARRAY_SIZE (amd64obsd_uthread_reg_offset); i++)
    {
      if (amd64obsd_uthread_reg_offset[i] != -1
	  && (regnum == -1 || regnum == i))
	{
	  /* Fetch stack pointer from thread structure (if we didn't
	     do so already).  */
	  if (sp == 0)
	    sp = read_memory_unsigned_integer (sp_addr, 8, byte_order);

	  /* Read the saved register from the stack frame.  */
	  read_memory (sp + amd64obsd_uthread_reg_offset[i], buf, 8);
	  regcache->raw_supply (i, buf);
	}
    }
}

static void
amd64obsd_collect_uthread (const struct regcache *regcache,
			   int regnum, CORE_ADDR addr)
{
  struct gdbarch *gdbarch = regcache->arch ();
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  CORE_ADDR sp_addr = addr + AMD64OBSD_UTHREAD_RSP_OFFSET;
  CORE_ADDR sp = 0;
  gdb_byte buf[8];
  int i;

  gdb_assert (regnum >= -1);

  if (regnum == -1 || regnum == AMD64_RSP_REGNUM)
    {
      int offset;

      /* Calculate the stack pointer (frame pointer) that will be
	 stored into the thread structure.  */
      offset = amd64obsd_uthread_reg_offset[AMD64_RIP_REGNUM] + 8;
      regcache->raw_collect (AMD64_RSP_REGNUM, buf);
      sp = extract_unsigned_integer (buf, 8, byte_order) - offset;

      /* Store the stack pointer.  */
      write_memory_unsigned_integer (sp_addr, 8, byte_order, sp);

      /* The stack pointer was (potentially) modified.  Make sure we
	 build a proper stack frame.  */
      regnum = -1;
    }

  for (i = 0; i < ARRAY_SIZE (amd64obsd_uthread_reg_offset); i++)
    {
      if (amd64obsd_uthread_reg_offset[i] != -1
	  && (regnum == -1 || regnum == i))
	{
	  /* Fetch stack pointer from thread structure (if we didn't
	     calculate it already).  */
	  if (sp == 0)
	    sp = read_memory_unsigned_integer (sp_addr, 8, byte_order);

	  /* Write the register into the stack frame.  */
	  regcache->raw_collect (i, buf);
	  write_memory (sp + amd64obsd_uthread_reg_offset[i], buf, 8);
	}
    }
}
/* Kernel debugging support.  */

/* From <machine/frame.h>.  Easy since `struct trapframe' matches
   `struct sigcontext'.  */
#define amd64obsd_tf_reg_offset amd64obsd_sc_reg_offset

static struct trad_frame_cache *
amd64obsd_trapframe_cache (const frame_info_ptr &this_frame, void **this_cache)
{
  struct gdbarch *gdbarch = get_frame_arch (this_frame);
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  struct trad_frame_cache *cache;
  CORE_ADDR func, sp, addr;
  ULONGEST cs;
  const char *name;
  int i;

  if (*this_cache)
    return (struct trad_frame_cache *) *this_cache;

  cache = trad_frame_cache_zalloc (this_frame);
  *this_cache = cache;

  func = get_frame_func (this_frame);
  sp = get_frame_register_unsigned (this_frame, AMD64_RSP_REGNUM);

  find_pc_partial_function (func, &name, NULL, NULL);
  if (name && startswith (name, "Xintr"))
    addr = sp + 8;		/* It's an interrupt frame.  */
  else
    addr = sp;

  for (i = 0; i < ARRAY_SIZE (amd64obsd_tf_reg_offset); i++)
    if (amd64obsd_tf_reg_offset[i] != -1)
      trad_frame_set_reg_addr (cache, i, addr + amd64obsd_tf_reg_offset[i]);

  /* Read %cs from trap frame.  */
  addr += amd64obsd_tf_reg_offset[AMD64_CS_REGNUM];
  cs = read_memory_unsigned_integer (addr, 8, byte_order);
  if ((cs & I386_SEL_RPL) == I386_SEL_UPL)
    {
      /* Trap from user space; terminate backtrace.  */
      trad_frame_set_id (cache, outer_frame_id);
    }
  else
    {
      /* Construct the frame ID using the function start.  */
      trad_frame_set_id (cache, frame_id_build (sp + 16, func));
    }

  return cache;
}

static void
amd64obsd_trapframe_this_id (const frame_info_ptr &this_frame,
			     void **this_cache, struct frame_id *this_id)
{
  struct trad_frame_cache *cache =
    amd64obsd_trapframe_cache (this_frame, this_cache);
  
  trad_frame_get_id (cache, this_id);
}

static struct value *
amd64obsd_trapframe_prev_register (const frame_info_ptr &this_frame,
				   void **this_cache, int regnum)
{
  struct trad_frame_cache *cache =
    amd64obsd_trapframe_cache (this_frame, this_cache);

  return trad_frame_get_register (cache, this_frame, regnum);
}

static int
amd64obsd_trapframe_sniffer (const struct frame_unwind *self,
			     const frame_info_ptr &this_frame,
			     void **this_prologue_cache)
{
  ULONGEST cs;
  const char *name;

  /* Check Current Privilege Level and bail out if we're not executing
     in kernel space.  */
  cs = get_frame_register_unsigned (this_frame, AMD64_CS_REGNUM);
  if ((cs & I386_SEL_RPL) == I386_SEL_UPL)
    return 0;

  find_pc_partial_function (get_frame_pc (this_frame), &name, NULL, NULL);
  return (name && ((strcmp (name, "calltrap") == 0)
		   || (strcmp (name, "osyscall1") == 0)
		   || (strcmp (name, "Xsyscall") == 0)
		   || (startswith (name, "Xintr"))));
}

static const struct frame_unwind_legacy amd64obsd_trapframe_unwind (
  /* FIXME: kettenis/20051219: This really is more like an interrupt
     frame, but SIGTRAMP_FRAME would print <signal handler called>,
     which really is not what we want here.  */
  "amd64 openbsd trap",
  NORMAL_FRAME,
  FRAME_UNWIND_ARCH,
  default_frame_unwind_stop_reason,
  amd64obsd_trapframe_this_id,
  amd64obsd_trapframe_prev_register,
  NULL,
  amd64obsd_trapframe_sniffer
);


static void
amd64obsd_init_abi (struct gdbarch_info info, struct gdbarch *gdbarch)
{
  i386_gdbarch_tdep *tdep = gdbarch_tdep<i386_gdbarch_tdep> (gdbarch);

  amd64_init_abi (info, gdbarch,
		  amd64_target_description (X86_XSTATE_SSE_MASK, true));
  obsd_init_abi (info, gdbarch);

  /* Initialize general-purpose register set details.  */
  tdep->gregset_reg_offset = amd64obsd_r_reg_offset;
  tdep->gregset_num_regs = ARRAY_SIZE (amd64obsd_r_reg_offset);
  tdep->sizeof_gregset = 24 * 8;

  tdep->jb_pc_offset = 7 * 8;

  tdep->sigtramp_p = amd64obsd_sigtramp_p;
  tdep->sigcontext_addr = amd64obsd_sigcontext_addr;
  tdep->sc_reg_offset = amd64obsd_sc_reg_offset;
  tdep->sc_num_regs = ARRAY_SIZE (amd64obsd_sc_reg_offset);

  /* OpenBSD provides a user-level threads implementation.  */
  bsd_uthread_set_supply_uthread (gdbarch, amd64obsd_supply_uthread);
  bsd_uthread_set_collect_uthread (gdbarch, amd64obsd_collect_uthread);

  /* OpenBSD uses SVR4-style shared libraries.  */
  set_solib_svr4_ops (gdbarch, make_svr4_lp64_solib_ops);

  /* Unwind kernel trap frames correctly.  */
  frame_unwind_prepend_unwinder (gdbarch, &amd64obsd_trapframe_unwind);
}

INIT_GDB_FILE (amd64obsd_tdep)
{
  /* The OpenBSD/amd64 native dependent code makes this assumption.  */
  gdb_assert (ARRAY_SIZE (amd64obsd_r_reg_offset) == AMD64_NUM_GREGS);

  gdbarch_register_osabi (bfd_arch_i386, bfd_mach_x86_64,
			  GDB_OSABI_OPENBSD, amd64obsd_init_abi);
}
