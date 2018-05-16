/* Target-dependent header for the nanoMIPS architecture, for GDB,
   the GNU Debugger.

   Copyright (C) 2002-2017 Free Software Foundation, Inc.

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

#ifndef NANOMIPS_TDEP_H
#define NANOMIPS_TDEP_H

#include "objfiles.h"

struct gdbarch;

/* All the possible nanoMIPS ABIs.  */
enum nanomips_abi
  {
    NANOMIPS_ABI_UNKNOWN = 0,
    NANOMIPS_ABI_P32,
    NANOMIPS_ABI_P64,
  };

/* Return the nanoMIPS ABI associated with GDBARCH.  */
enum nanomips_abi nanomips_abi (struct gdbarch *gdbarch);

/* Return the current index for various nanoMIPS registers.  */
struct nanomips_regnum
{
  int pc;
  int fp0;
  int fp_implementation_revision;
  int fp_control_status;
  int badvaddr;		/* Bad vaddr for addressing exception.  */
  int cause;		/* Describes last exception.  */
  int dspacc;		/* SmartMIPS/DSP accumulators.  */
  int dspctl;		/* DSP control.  */
};

extern const struct nanomips_regnum *nanomips_regnum (struct gdbarch *gdbarch);

/* nanoMIPS floating-point operations.  */

enum fpu_type
{
  NANOMIPS_FPU_NONE,	/* Unknown floating point.  */
  NANOMIPS_FPU_HARD,	/* Double precision floating point.  */
  NANOMIPS_FPU_SOFT	/* Software floating point.  */
};

/* nanoMIPS specific per-architecture information.  */
struct gdbarch_tdep
{
  /* from the elf header */
  int elf_flags;

  /* nanomips options */
  enum nanomips_abi nanomips_abi;
  enum nanomips_abi found_abi;
  enum fpu_type fpu_type;
  int mips_last_arg_regnum;
  int mips_last_fp_arg_regnum;
  int default_mask_address_p;
  /* Indexes for various registers.  IRIX and embedded have
     different values.  This contains the "public" fields.  Don't
     add any that do not need to be public.  */
  const struct nanomips_regnum *regnum;
  /* Register names table for the current register set.  */
  const char **mips_processor_reg_names;

  /* The size of register data available from the target, if known.  */
  int register_size_valid_p;
  int register_size;

  /* Return the expected next PC if FRAME is stopped at a syscall
     instruction.  */
  CORE_ADDR (*syscall_next_pc) (struct frame_info *frame);
};

/* Register numbers of various important registers.  */

enum
{
  NANOMIPS_ZERO_REGNUM = 0,	/* Read-only register, always 0.  */
  NANOMIPS_A0_REGNUM = 4,	/* Loc of first arg during a subr call.  */
  NANOMIPS_GP_REGNUM = 28,
  NANOMIPS_SP_REGNUM = 29,
  NANOMIPS_FP_REGNUM = 30,
  NANOMIPS_RA_REGNUM = 31,
  NANOMIPS_PS_REGNUM = 32,	/* Contains processor status.  */
  NANOMIPS_EMBED_BADVADDR_REGNUM = 33,
  NANOMIPS_EMBED_CAUSE_REGNUM = 34,
  NANOMIPS_EMBED_PC_REGNUM = 35,
  NANOMIPS_EMBED_FP0_REGNUM = 36,
  NANOMIPS_FIRST_EMBED_REGNUM = 74, /* First CP0 register for embedded use.  */
  NANOMIPS_LAST_EMBED_REGNUM = 89   /* Last one.  */
};

/* Instruction sizes and other useful constants.  */
enum
{
  INSN16_SIZE = 2,
  INSN32_SIZE = 4,
  /* The number of floating-point or integer registers.  */
  NUMREGS = 32
};

/* Single step based on where the current instruction will take us.  */
extern VEC (CORE_ADDR) *nanomips_software_single_step (struct regcache *regcache);

/* Return the currently configured (or set) saved register size.  */
extern unsigned int nanomips_abi_regsize (struct gdbarch *gdbarch);

/* Make PC the address of the next instruction to execute.  */
extern void nanomips_write_pc (struct regcache *regcache, CORE_ADDR pc);

/* Target descriptions which only indicate the size of general
   registers.  */
extern struct target_desc *nanomips_tdesc_gp32;
extern struct target_desc *nanomips_tdesc_gp64;

#endif /* NANOMIPS_TDEP_H */
