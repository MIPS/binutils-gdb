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
  int fpr;		/* Floating-point unit registers.  */
  int badvaddr;		/* Bad vaddr for addressing exception.  */
  int status;		/* Status register.  */
  int cause;		/* Describes last exception.  */
  int dsp;		/* DSP registers.  */
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
  int default_mask_address_p;

  /* Indexes for various registers determined dynamically at run time.
     This contains the "public" fields.  Don't add any that do not need
     to be public.  */
  const struct nanomips_regnum *regnum;

  /* The size of register data available from the target.  */
  int register_size;

  /* Return the expected next PC if FRAME is stopped at a syscall
     instruction.  */
  CORE_ADDR (*syscall_next_pc) (struct frame_info *frame);
};

/* Register numbers of various important registers from the fixed
   GPR+PC register set that is always present.  The rest is determined
   dynamically at run time and held in `gdbarch_tdep->regnum'.  */

enum
{
  NANOMIPS_ZERO_REGNUM = 0,
  NANOMIPS_A0_REGNUM = 4,
  NANOMIPS_GP_REGNUM = 28,
  NANOMIPS_SP_REGNUM = 29,
  NANOMIPS_FP_REGNUM = 30,
  NANOMIPS_RA_REGNUM = 31,
  NANOMIPS_PC_REGNUM = 32
};

/* Floating-point register offsets relative to `gdbarch_tdep->regnum->fpr'.  */

enum
{
  NANOMIPS_FP0_REGNUM = 0,
  NANOMIPS_FCSR_REGNUM = 32,
  NANOMIPS_FIR_REGNUM = 33
};

/* DSP register offsets, relative to `gdbarch_tdep->regnum->dsp'.  */

enum
{
  NANOMIPS_DSPHI0_REGNUM = 0,
  NANOMIPS_DSPCTL_REGNUM = 8
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

#endif /* NANOMIPS_TDEP_H */
