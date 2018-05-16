/* Target-dependent code for GNU/Linux on nanoMIPS processors.

   Copyright (C) 2018 Free Software Foundation, Inc.

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
#include "gdbarch.h"
#include "gdbcore.h"
#include "linux-tdep.h"
#include "osabi.h"
#include "regset.h"
#include "solib-svr4.h"
#include "trad-frame.h"
#include "tramp-frame.h"
#include "xml-syscall.h"

#include "nanomips-linux-tdep.h"
#include "nanomips-tdep.h"

#include "features/nanomips-linux.c"
#include "features/nanomips-dsp-linux.c"
#include "features/nanomips64-linux.c"
#include "features/nanomips64-dsp-linux.c"

/* Fetch general purpose registers of REGSIZE width from an NT_PRSTATUS
   regset in BUF into REGCACHE.  */

void
nanomips_linux_supply_gregset (struct regcache *regcache, const gdb_byte *buf)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);
  int regsize = nanomips_isa_regsize (gdbarch);
  nanomips64_elf_greg_t zerobuf = { 0 };
  int i;

  /* FIXME: Remove padding.  */
  if (regsize == 4)
    buf += NANOMIPS_EF_PAD * regsize;
  else
    buf += NANOMIPS64_EF_PAD * regsize;

  regcache_raw_supply (regcache, NANOMIPS_ZERO_REGNUM, zerobuf);

  if (regs->restart != -1)
    regcache_raw_supply (regcache, regs->restart, buf);
  buf += regsize;

  for (i = 0; i < 31; i++, buf += regsize)
    regcache_raw_supply (regcache, NANOMIPS_AT_REGNUM + i, buf);

  /* FIXME: Remove padding.  */
  buf += 2 * regsize;

  regcache_raw_supply (regcache, NANOMIPS_PC_REGNUM, buf);
  buf += regsize;

  if (regs->badvaddr != -1)
    regcache_raw_supply (regcache, regs->badvaddr, buf);
  buf += regsize;
  if (regs->status != -1)
    regcache_raw_supply (regcache, regs->status, buf);
  buf += regsize;
  if (regs->cause != -1)
    regcache_raw_supply (regcache, regs->cause, buf);
}

/* Wrapper for the above for the core file regset iterator.  */

static void
nanomips_linux_supply_gregset_wrapper (const struct regset *regset,
				       struct regcache *regcache, int regnum,
				       const void *gregs, size_t len)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  int regsize = nanomips_isa_regsize (gdbarch);

  gdb_assert (len >= (regsize == 4 ? sizeof (nanomips_elf_gregset_t)
		      : sizeof (nanomips64_elf_gregset_t)));

  nanomips_linux_supply_gregset (regcache, (const gdb_byte *) gregs);
}

/* Store general purpose registers of REGSIZE width from REGCACHE
   into an NT_PRSTATUS regset in BUF.  */

void
nanomips_linux_collect_gregset (const struct regcache *regcache, gdb_byte *buf)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);
  int regsize = nanomips_isa_regsize (gdbarch);
  int i;

  memset (buf, 0, NANOMIPS_ELF_NGREG * regsize);

  /* FIXME: Remove padding.  */
  if (regsize == 4)
    buf += NANOMIPS_EF_PAD * regsize;
  else
    buf += NANOMIPS64_EF_PAD * regsize;

  if (regs->restart != -1)
    regcache_raw_collect (regcache, regs->restart, buf);
  buf += regsize;

  for (i = 0; i < 31; i++, buf += regsize)
    regcache_raw_collect (regcache, NANOMIPS_AT_REGNUM + i, buf);

  /* FIXME: Remove padding.  */
  buf += 2 * regsize;

  regcache_raw_collect (regcache, NANOMIPS_PC_REGNUM, buf);
  buf += regsize;

  if (regs->badvaddr != -1)
    regcache_raw_collect (regcache, regs->badvaddr, buf);
  buf += regsize;
  if (regs->status != -1)
    regcache_raw_collect (regcache, regs->status, buf);
  buf += regsize;
  if (regs->cause != -1)
    regcache_raw_collect (regcache, regs->cause, buf);
}

/* Wrapper for the above for the core file regset iterator.  */

static void
nanomips_linux_collect_gregset_wrapper (const struct regset *regset,
					const struct regcache *regcache,
					int regnum, void *gregs, size_t len)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  int regsize = nanomips_isa_regsize (gdbarch);

  gdb_assert (len >= (regsize == 4 ? sizeof (nanomips_elf_gregset_t)
		      : sizeof (nanomips64_elf_gregset_t)));

  nanomips_linux_collect_gregset (regcache, (gdb_byte *) gregs);
}

/* Fetch floating-point registers from an NT_FPREGSET (aka NT_PRFPREG)
   regset in BUF into REGCACHE.  */

void
nanomips_linux_supply_fpregset (struct regcache *regcache,
				const gdb_byte *buf)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);
  int i;

  gdb_assert (regs->fpr != -1);

  for (i = 0; i < 32; i++, buf += 8)
    regcache_raw_supply (regcache, regs->fpr + i, buf);
  regcache_raw_supply (regcache, regs->fpr + NANOMIPS_FCSR_REGNUM, buf);
  buf += 4;
  regcache_raw_supply (regcache, regs->fpr + NANOMIPS_FIR_REGNUM, buf);
}

/* Wrapper for the above for the core file regset iterator.  */

static void
nanomips_linux_supply_fpregset_wrapper (const struct regset *regset,
					struct regcache *regcache, int regnum,
					const void *fpregs, size_t len)
{
  gdb_assert (len >= sizeof (nanomips_elf_fpregset_t));

  nanomips_linux_supply_fpregset (regcache, (const gdb_byte *) fpregs);
}

/* Store floating-point registers from REGCACHE into an NT_FPREGSET
   (aka NT_PRFPREG) regset in BUF.  */

void
nanomips_linux_collect_fpregset (const struct regcache *regcache,
				 gdb_byte *buf)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);
  int i;

  gdb_assert (regs->fpr != -1);

  for (i = 0; i < 32; i++, buf += 8)
    regcache_raw_collect (regcache, regs->fpr + i, buf);
  regcache_raw_collect (regcache, regs->fpr + NANOMIPS_FCSR_REGNUM, buf);
  buf += 4;
  regcache_raw_collect (regcache, regs->fpr + NANOMIPS_FIR_REGNUM, buf);
}

/* Wrapper for the above for the core file regset iterator.  */

static void
nanomips_linux_collect_fpregset_wrapper (const struct regset *regset,
					 const struct regcache *regcache,
					 int regnum, void *fpregs, size_t len)
{
  gdb_assert (len >= sizeof (nanomips_elf_fpregset_t));

  nanomips_linux_collect_fpregset (regcache, (gdb_byte *) fpregs);
}

static const struct regset nanomips_linux_gregset =
  {
    NULL,
    nanomips_linux_supply_gregset_wrapper,
    nanomips_linux_collect_gregset_wrapper
  };

static const struct regset nanomips_linux_fpregset =
  {
    NULL,
     nanomips_linux_supply_fpregset_wrapper,
     nanomips_linux_collect_fpregset_wrapper
  };

static void
nanomips_linux_iterate_over_regset_sections
  (struct gdbarch *gdbarch, iterate_over_regset_sections_cb *cb,
   void *cb_data, const struct regcache *regcache)
{
  if (nanomips_isa_regsize (gdbarch) == 4)
    {
      cb (".reg",
	  sizeof (nanomips_elf_gregset_t), &nanomips_linux_gregset,
	  NULL, cb_data);
      cb (".reg2",
	  sizeof (nanomips_elf_fpregset_t), &nanomips_linux_fpregset,
	  NULL, cb_data);
#if 0
      cb (".reg-nanomips-dsp",
	  sizeof (nanomips_elf_dspregset_t), &nanomips_linux_dspregset,
	  NULL, cb_data);
#endif
    }
  else
    {
      cb (".reg",
	  sizeof (nanomips64_elf_gregset_t), &nanomips_linux_gregset,
	  NULL, cb_data);
      cb (".reg2",
	  sizeof (nanomips_elf_fpregset_t), &nanomips_linux_fpregset,
	  NULL, cb_data);
#if 0
      cb (".reg-nanomips-dsp",
	  sizeof (nanomips64_elf_dspregset_t), &nanomips_linux_dspregset,
	  NULL, cb_data);
#endif
    }
}

static const struct target_desc *
nanomips_linux_core_read_description (struct gdbarch *gdbarch,
				      struct target_ops *target,
				      bfd *abfd)
{
  asection *section;
  int have_64bit;
  int have_dsp;

  section = bfd_get_section_by_name (abfd, ".reg");
  if (!section)
    return NULL;

  switch (bfd_section_size (abfd, section))
    {
    case sizeof (nanomips_elf_gregset_t):
      have_64bit = 0;
      break;

    case sizeof (nanomips64_elf_gregset_t):
      have_64bit = 1;
      break;

    default:
      return NULL;
    }

  section = bfd_get_section_by_name (abfd, ".reg-nanomips-dsp");
  have_dsp = section != NULL;

  if (have_64bit)
    return have_dsp ? tdesc_nanomips64_dsp_linux : tdesc_nanomips64_linux;
  else
    return have_dsp ? tdesc_nanomips_dsp_linux : tdesc_nanomips_linux;
}

static void nanomips_linux_sigframe_init (const struct tramp_frame *self,
					  struct frame_info *this_frame,
					  struct trad_frame_cache *this_cache,
					  CORE_ADDR func);

#define NANOMIPS_NR_rt_sigreturn 139

#define NANOMIPS_INST_LI_A4 0x0040
#define NANOMIPS_INST_SYSCALL32 0x0008

static const struct tramp_frame nanomips_linux_p32_rt_sigframe = {
  SIGTRAMP_FRAME,
  2,
  {
    { NANOMIPS_INST_LI_A4, -1 },
    { NANOMIPS_NR_rt_sigreturn, -1 },
    { NANOMIPS_INST_SYSCALL32, -1 },
    { 0, -1 },
    { TRAMP_SENTINEL_INSN, -1 }
  },
  nanomips_linux_sigframe_init
};

static const struct tramp_frame nanomips_linux_p64_rt_sigframe = {
  SIGTRAMP_FRAME,
  2,
  {
    { NANOMIPS_INST_LI_A4, -1 },
    { NANOMIPS_NR_rt_sigreturn, -1 },
    { NANOMIPS_INST_SYSCALL32, -1 },
    { 0, -1 },
    { TRAMP_SENTINEL_INSN, -1 }
  },
  nanomips_linux_sigframe_init
};

/*
  struct rt_sigframe_p32 {
    u32 rs_ass[4];
    u32 rs_code[2];
    struct siginfo rs_info;
    struct ucontext_p32 rs_uc;
  };

  struct ucontext_p32 {
    u32               uc_flags;
    s32               uc_link;
    stack32_t         uc_stack;
    struct sigcontext uc_mcontext;
    sigset_t          uc_sigmask;
    u64               uc_extcontext[0];
  };

  struct rt_sigframe_p64 {
    u32 rs_ass[4];
    u32 rs_code[2];
    struct siginfo rs_info;
    struct ucontext_p64 rs_uc;
  };

  struct ucontext_p64 {
    u64               uc_flags;
    struct ucontext  *uc_link;
    stack64_t         uc_stack;
    struct sigcontext uc_mcontext;
    sigset_t          uc_sigmask;
    u64               uc_extcontext[0];
  };

  struct sigcontext {
    u64 sc_regs[32];
    u64 sc_pc;
    u32 sc_used_math;
    u32 sc_reserved;
  };

struct extcontext {
    u32 magic;
    u32 size;
};

struct dsp_extcontext_p32 {
  struct extcontext ext;
  u32               hi[4];
  u32               lo[4];
  u32               dsp;
};

struct dsp_extcontext_p64 {
  struct extcontext ext;
  u64               hi[4];
  u64               lo[4];
  u32               dsp;
};

struct fpu_extcontext {
  struct extcontext ext;
  u32               fcsr;
  u32               width;
  u64               r[0];
};
*/

#define RTSIGFRAME_SIGCONTEXT_OFFSET	(6 * 4)
#define RTSIGFRAME_SIGINFO_SIZE		128
#define P32_STACK_T_SIZE		(3 * 4)
#define P64_STACK_T_SIZE		(3 * 8)
#define P32_UCONTEXT_SIGCONTEXT_OFFSET	(2 * 4 + P32_STACK_T_SIZE + 4)
#define P64_UCONTEXT_SIGCONTEXT_OFFSET	(2 * 8 + P64_STACK_T_SIZE)
#define P32_SIGFRAME_SIGCONTEXT_OFFSET	(RTSIGFRAME_SIGCONTEXT_OFFSET \
					 + RTSIGFRAME_SIGINFO_SIZE \
					 + P32_UCONTEXT_SIGCONTEXT_OFFSET)
#define P64_SIGFRAME_SIGCONTEXT_OFFSET	(RTSIGFRAME_SIGCONTEXT_OFFSET \
					 + RTSIGFRAME_SIGINFO_SIZE \
					 + P64_UCONTEXT_SIGCONTEXT_OFFSET)
#define SIGCONTEXT_REG_SIZE		8

#define SIGCONTEXT_RESTART		(0 * SIGCONTEXT_REG_SIZE)
#define SIGCONTEXT_REGS			(1 * SIGCONTEXT_REG_SIZE)
#define SIGCONTEXT_PC			(32 * SIGCONTEXT_REG_SIZE)
#define SIGCONTEXT_USED_MATH		(33 * SIGCONTEXT_REG_SIZE)
#define SIGCONTEXT_SIZE			(34 * SIGCONTEXT_REG_SIZE)

#define SIGCONTEXT_USED_MATH_EXTCONTEXT	(1 << 3)

#define SIGMASK_SIZE			8

#define SIGCONTEXT_EXTCONTEXT_OFFSET	(SIGCONTEXT_SIZE + SIGMASK_SIZE)

#define EXTCONTEXT_ENTRY_MAGIC		0
#define EXTCONTEXT_ENTRY_SIZE		(EXTCONTEXT_ENTRY_MAGIC + 4)
#define EXTCONTEXT_SIZE			(EXTCONTEXT_ENTRY_SIZE + 4)

#define DSP_EXTCONTEXT_MAGIC		0x78445350
#define FPU_EXTCONTEXT_MAGIC		0x78465055
#define MSA_EXTCONTEXT_MAGIC		0x784d5341
#define END_EXTCONTEXT_MAGIC		0x78454e44

#define P32_DSP_EXTCONTEXT_REG_SIZE	4
#define P64_DSP_EXTCONTEXT_REG_SIZE	8

#define DSP_EXTCONTEXT_HI0		EXTCONTEXT_SIZE
#define DSP_EXTCONTEXT_HI0_INDEX	0
#define DSP_EXTCONTEXT_LO0_INDEX	4
#define DSP_EXTCONTEXT_CTL_INDEX	8

#define FPU_EXTCONTEXT_FCSR		(EXTCONTEXT_SIZE + 0)
#define FPU_EXTCONTEXT_WIDTH		(EXTCONTEXT_SIZE + 4)
#define FPU_EXTCONTEXT_R0		(EXTCONTEXT_SIZE + 8)

static void
nanomips_linux_sigframe_init (const struct tramp_frame *self,
			      struct frame_info *this_frame,
			      struct trad_frame_cache *this_cache,
			      CORE_ADDR func)
{
  struct gdbarch *gdbarch = get_frame_arch (this_frame);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  CORE_ADDR frame_sp = get_frame_sp (this_frame);
  int num_regs = gdbarch_num_regs (gdbarch);
  CORE_ADDR sigcontext_base;
  CORE_ADDR regs_base;
  ULONGEST used_math;
  int ireg;

  if (self == &nanomips_linux_p32_rt_sigframe)
    sigcontext_base = P32_SIGFRAME_SIGCONTEXT_OFFSET;
  else if (self == &nanomips_linux_p32_rt_sigframe)
    sigcontext_base = P64_SIGFRAME_SIGCONTEXT_OFFSET;
  else
    internal_error (__FILE__, __LINE__, _("unknown trampoline frame type"));
  sigcontext_base += frame_sp;

  if (byte_order == BFD_ENDIAN_BIG)
    regs_base = sigcontext_base + 4;
  else
    regs_base = sigcontext_base;

  if (regs->restart != -1)
    trad_frame_set_reg_addr (this_cache, num_regs + regs->restart,
                             regs_base + SIGCONTEXT_RESTART);
  for (ireg = 0; ireg < 31; ireg++)
    trad_frame_set_reg_addr (this_cache, num_regs + NANOMIPS_AT_REGNUM + ireg,
                             (regs_base + SIGCONTEXT_REGS
                              + ireg * SIGCONTEXT_REG_SIZE));
  trad_frame_set_reg_addr (this_cache, num_regs + NANOMIPS_PC_REGNUM,
                           regs_base + SIGCONTEXT_PC);

  used_math = read_memory_unsigned_integer (sigcontext_base
					    + SIGCONTEXT_USED_MATH, 4,
					    byte_order);
  if ((used_math & SIGCONTEXT_USED_MATH_EXTCONTEXT) != 0)
    {
      CORE_ADDR ext = sigcontext_base + SIGCONTEXT_EXTCONTEXT_OFFSET;
      ULONGEST ext_magic;
      ULONGEST ext_size;

      while (1)
	{
	  ext_magic
	    = read_memory_unsigned_integer (ext + EXTCONTEXT_ENTRY_MAGIC,
					    4, byte_order);
	  if (ext_magic == END_EXTCONTEXT_MAGIC)
	    break;
	  ext_size
	    = read_memory_unsigned_integer (ext + EXTCONTEXT_ENTRY_SIZE,
					    4, byte_order);
	  switch (ext_magic)
	    {
	    case FPU_EXTCONTEXT_MAGIC:
	      if (regs->fpr != -1)
		{
		  ULONGEST ext_reg_width;
		  ULONGEST fpu_reg_size;

		  fpu_reg_size = register_size (gdbarch, regs->fpr);
		  ext_reg_width
		    = read_memory_unsigned_integer (ext + FPU_EXTCONTEXT_WIDTH,
						    4, byte_order);
		  if (ext_reg_width < fpu_reg_size)
		    internal_error
		      (__FILE__, __LINE__,
		       _("unhandled sigcontext FPU register size"));
		  if (byte_order == BFD_ENDIAN_BIG)
		    regs_base = (ext + FPU_EXTCONTEXT_R0
				 + ext_reg_width - fpu_reg_size);
		  else
		    regs_base = ext + FPU_EXTCONTEXT_R0;

		  trad_frame_set_reg_addr (this_cache,
					   regs->fpr + NANOMIPS_FCSR_REGNUM,
					   ext + FPU_EXTCONTEXT_FCSR);
		  for (ireg = 0; ireg < 32; ireg++)
		    trad_frame_set_reg_addr (this_cache,
					     (regs->fpr
					      + NANOMIPS_FP0_REGNUM + ireg),
					     (regs_base
					      + ireg * ext_reg_width));
		}
	      break;
	    case DSP_EXTCONTEXT_MAGIC:
	      if (regs->dsp != -1)
		{
		  ULONGEST ext_reg_size;
		  ULONGEST dsp_reg_size;

		  dsp_reg_size = register_size (gdbarch, regs->fpr);
		  ext_reg_size = (self == &nanomips_linux_p32_rt_sigframe
				  ? P32_DSP_EXTCONTEXT_REG_SIZE
				  : P64_DSP_EXTCONTEXT_REG_SIZE);
		  if (ext_reg_size != dsp_reg_size)
		    internal_error
		      (__FILE__, __LINE__,
		       _("unhandled sigcontext DSP register size"));
		  regs_base = ext + DSP_EXTCONTEXT_HI0;

		  for (ireg = 0; ireg < 4; ireg++)
		    {
		      trad_frame_set_reg_addr (this_cache,
					       (regs->dsp
						+ NANOMIPS_DSPHI0_REGNUM
						+ 2 * ireg),
					       (regs_base
						+ (DSP_EXTCONTEXT_HI0_INDEX
						   * ext_reg_size)
						+ ireg * ext_reg_size));
		      trad_frame_set_reg_addr (this_cache,
					       (regs->dsp
						+ NANOMIPS_DSPLO0_REGNUM
						+ 2 * ireg),
					       (regs_base
						+ DSP_EXTCONTEXT_LO0_INDEX
						* ext_reg_size
						+ ireg * ext_reg_size));
		    }
		  trad_frame_set_reg_addr (this_cache,
					   regs->dsp + NANOMIPS_DSPCTL_REGNUM,
					   (regs_base
					    + DSP_EXTCONTEXT_CTL_INDEX
					    * ext_reg_size));
		}
	      break;
	    }

	  ext += ext_size;
	}
    }

  trad_frame_set_id (this_cache, frame_id_build (frame_sp, func));
}

static void
nanomips_linux_write_pc (struct regcache *regcache, CORE_ADDR pc)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);

  nanomips_write_pc (regcache, pc);

  /* Clear the syscall restart flag.  */
  if (regs->restart != -1)
    regcache_cooked_write_unsigned (regcache, regs->restart, 0);
}

/* When FRAME is at a syscall instruction and PC points immediately
   after it, return the PC of the next instruction to be executed.  */

static CORE_ADDR
nanomips_linux_syscall_next_pc (struct frame_info *frame, CORE_ADDR pc)
{
  ULONGEST t4 = get_frame_register_unsigned (frame, NANOMIPS_T4_REGNUM);

  /* If we are about to make a sigreturn syscall, use the unwinder to
     decode the signal frame.  */
  if (t4 == NANOMIPS_NR_rt_sigreturn)
    return frame_unwind_caller_pc (frame);

  return pc;
}

/* Return the current system call's number present in the
   t4 register.  When the function fails, it returns -1.  */

static LONGEST
nanomips_linux_get_syscall_number (struct gdbarch *gdbarch,
				   ptid_t ptid)
{
  struct regcache *regcache = get_thread_regcache (ptid);
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
  int regsize = register_size (gdbarch, NANOMIPS_T4_REGNUM);
  /* The content of a register */
  gdb_byte buf[8];
  /* The result */
  LONGEST ret;

  /* Make sure we're in a known ABI */
  gdb_assert (tdep->nanomips_abi == NANOMIPS_ABI_P32
              || tdep->nanomips_abi == NANOMIPS_ABI_P64);

  gdb_assert (regsize <= sizeof (buf));

  /* Getting the system call number from the register.
     syscall number is in t4 or $2.  */
  regcache_cooked_read (regcache, NANOMIPS_T4_REGNUM, buf);

  ret = extract_signed_integer (buf, regsize, byte_order);

  return ret;
}

/* Initialize one of the GNU/Linux OS ABIs.  */

static void
nanomips_linux_init_abi (struct gdbarch_info info, struct gdbarch *gdbarch)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (gdbarch);
  enum nanomips_abi abi = nanomips_abi (gdbarch);

  linux_init_abi (info, gdbarch);

  switch (abi)
    {
    case NANOMIPS_ABI_P32:
      set_solib_svr4_fetch_link_map_offsets
	(gdbarch, svr4_ilp32_fetch_link_map_offsets);
      tramp_frame_prepend_unwinder (gdbarch, &nanomips_linux_p32_rt_sigframe);
      break;
    case NANOMIPS_ABI_P64:
      set_solib_svr4_fetch_link_map_offsets
	(gdbarch, svr4_lp64_fetch_link_map_offsets);
      tramp_frame_prepend_unwinder (gdbarch, &nanomips_linux_p64_rt_sigframe);
      break;
    default:
      internal_error (__FILE__, __LINE__, _("unknown ABI in switch"));
    }

  set_xml_syscall_file_name (gdbarch, "syscalls/nanomips-linux.xml");

  /* Get the syscall number from the arch's register.  */
  set_gdbarch_get_syscall_number (gdbarch, nanomips_linux_get_syscall_number);

#if 0
  set_gdbarch_skip_solib_resolver (gdbarch, mips_linux_skip_resolver);
#endif

  set_gdbarch_software_single_step (gdbarch, nanomips_software_single_step);

  /* Enable TLS support.  */
  set_gdbarch_fetch_tls_load_module_address (gdbarch,
					     svr4_fetch_objfile_link_map);

  set_gdbarch_write_pc (gdbarch, nanomips_linux_write_pc);

  set_gdbarch_iterate_over_regset_sections
    (gdbarch, nanomips_linux_iterate_over_regset_sections);
  set_gdbarch_core_read_description
    (gdbarch, nanomips_linux_core_read_description);

  tdep->syscall_next_pc = nanomips_linux_syscall_next_pc;
}

void
_initialize_nanomips_linux_tdep (void)
{
  const struct bfd_arch_info *arch_info;

  for (arch_info = bfd_lookup_arch (bfd_arch_nanomips, 0);
       arch_info != NULL;
       arch_info = arch_info->next)
    gdbarch_register_osabi (bfd_arch_nanomips, arch_info->mach,
                            GDB_OSABI_LINUX,
                            nanomips_linux_init_abi);

  /* Initialize the standard target descriptions.  */
  initialize_tdesc_nanomips_linux ();
  initialize_tdesc_nanomips_dsp_linux ();
  initialize_tdesc_nanomips64_linux ();
  initialize_tdesc_nanomips64_dsp_linux ();
}
