/* Native-dependent code for GNU/Linux on nanoMIPS processors.

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
#include "gdb_proc_service.h"
#include "gdbarch.h"
#include "inferior.h"
#include "linux-nat.h"
#include "regcache.h"
#include "target-descriptions.h"
#include "target.h"
#include "utils.h"

#include "nanomips-linux-tdep.h"
#include "nanomips-tdep.h"

#include "elf/common.h"
#include "nat/gdb_ptrace.h"
#include <asm/ptrace.h>

#include <sys/uio.h>

/* Fetch the thread-local storage pointer for libthread_db.  */

ps_err_e
ps_get_thread_area (struct ps_prochandle *ph,
		    lwpid_t lwpid, int idx, void **base)
{
  if (ptrace (PTRACE_GET_THREAD_AREA, lwpid, NULL, base) != 0)
    return PS_ERR;

  /* IDX is the bias from the thread pointer to the beginning of the
     thread descriptor.  It has to be subtracted due to implementation
     quirks in libthread_db.  */
  *base = (void *) ((char *)*base - idx);

  return PS_OK;
}

/* Wrapper functions.  These are only used by libthread_db.  */

void
supply_gregset (struct regcache *regcache, const gdb_gregset_t *gregsetp)
{
  union
    {
      const gdb_gregset_t *g;
      const gdb_byte *b;
    }
  regs;

  regs.g = gregsetp;
  nanomips_linux_supply_gregset (regcache, regs.b);
}

void
fill_gregset (const struct regcache *regcache, gdb_gregset_t *gregsetp,
	      int regno)
{
  union
    {
      gdb_gregset_t *g;
      gdb_byte *b;
    }
  regs;

  regs.g = gregsetp;
  nanomips_linux_collect_gregset (regcache, regs.b);
}

void
supply_fpregset (struct regcache *regcache, const gdb_fpregset_t *fpregsetp)
{
  union
    {
      const gdb_fpregset_t *f;
      const gdb_byte *b;
    }
  regs;

  regs.f = fpregsetp;
  nanomips_linux_supply_fpregset (regcache, regs.b);
}

void
fill_fpregset (const struct regcache *regcache, gdb_fpregset_t *fpregsetp,
	       int regno)
{
  union
    {
      gdb_fpregset_t *f;
      gdb_byte *b;
    }
  regs;

  regs.f = fpregsetp;
  nanomips_linux_collect_fpregset (regcache, regs.b);
}

/* Figure out which regset to use for register number REGNUM.  */

static LONGEST
nanomips_linux_ptrace_regset (struct gdbarch* gdbarch, int regnum)
{
  const struct nanomips_regnum *regs = nanomips_regnum (gdbarch);

  if (regnum >= NANOMIPS_ZERO_REGNUM && regnum <= NANOMIPS_PC_REGNUM)
    return NT_PRSTATUS;
  if (regs->restart != -1 && regnum == regs->restart)
    return NT_PRSTATUS;
  if (regs->badvaddr != -1 && regnum == regs->badvaddr)
    return NT_PRSTATUS;
  if (regs->status != -1 && regnum == regs->status)
    return NT_PRSTATUS;
  if (regs->cause != -1 && regnum == regs->cause)
    return NT_PRSTATUS;
  if (regs->fpr != -1
      && regnum >= regs->fpr + NANOMIPS_FP0_REGNUM
      && regnum <= regs->fpr + NANOMIPS_FIR_REGNUM)
    return NT_FPREGSET;
#if 0
  /* FIXME: Need to implement DSP regset.  */
  if (regs->dsp != -1
      && regnum >= regs->dsp + NANOMIPS_DSPHI0_REGNUM
      && regnum <= regs->dsp + NANOMIPS_DSPCTL_REGNUM)
    return NT_NANOMIPS_DSP;
#endif

  return 0;
}

static void
nanomips_linux_fetch_registers (struct target_ops *ops,
				struct regcache *regcache, int regnum)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  LONGEST regset = nanomips_linux_ptrace_regset (gdbarch, regnum);
  int tid;

  tid = ptid_get_lwp (inferior_ptid);
  if (tid == 0)
    tid = ptid_get_pid (inferior_ptid);

  if (regnum == -1 || regset == NT_PRSTATUS)
    {
      gdb_byte buf[sizeof (nanomips64_elf_gregset_t)];
      struct iovec iovec;

      iovec.iov_base = &buf;
      if (nanomips_isa_regsize (gdbarch) == 8)
	iovec.iov_len = sizeof (nanomips64_elf_gregset_t);
      else
	iovec.iov_len = sizeof (nanomips_elf_gregset_t);

      gdb_assert (iovec.iov_len <= sizeof (buf));

      if (ptrace (PTRACE_GETREGSET, tid, NT_PRSTATUS, &iovec) != 0)
	perror_with_name (_("Couldn't get general registers"));

      nanomips_linux_supply_gregset (regcache, buf);
    }

  if (regnum == -1 || regset == NT_FPREGSET)
    {
      gdb_byte buf[sizeof (nanomips_elf_fpregset_t)];
      struct iovec iovec;

      iovec.iov_base = &buf;
      iovec.iov_len = sizeof (buf);

      if (ptrace (PTRACE_GETREGSET, tid, NT_FPREGSET, &iovec) != 0)
	perror_with_name (_("Couldn't get FP registers"));

      nanomips_linux_supply_fpregset (regcache, buf);
    }

  if (regnum == -1 /*|| regset == NT_NANOMIPS_DSP*/)
    {
      /* FIXME: Need to implement DSP regset.  */
    }
}

static void
nanomips_linux_store_registers (struct target_ops *ops,
				struct regcache *regcache, int regnum)
{
  struct gdbarch *gdbarch = get_regcache_arch (regcache);
  LONGEST regset = nanomips_linux_ptrace_regset (gdbarch, regnum);
  int tid;

  tid = ptid_get_lwp (inferior_ptid);
  if (tid == 0)
    tid = ptid_get_pid (inferior_ptid);

  if (regnum == -1 || regset == NT_PRSTATUS)
    {
      gdb_byte buf[sizeof (nanomips64_elf_gregset_t)];
      struct iovec iovec;

      iovec.iov_base = &buf;
      if (nanomips_isa_regsize (gdbarch) == 8)
	iovec.iov_len = sizeof (nanomips64_elf_gregset_t);
      else
	iovec.iov_len = sizeof (nanomips_elf_gregset_t);

      gdb_assert (iovec.iov_len <= sizeof (buf));

      nanomips_linux_collect_gregset (regcache, buf);

      if (ptrace (PTRACE_SETREGSET, tid, NT_PRSTATUS, &iovec) != 0)
	perror_with_name (_("Couldn't set general registers"));
    }

  if (regnum == -1 || regset == NT_FPREGSET)
    {
      gdb_byte buf[sizeof (nanomips_elf_fpregset_t)];
      struct iovec iovec;

      iovec.iov_base = &buf;
      iovec.iov_len = sizeof (buf);

      nanomips_linux_collect_fpregset (regcache, buf);

      if (ptrace (PTRACE_SETREGSET, tid, NT_FPREGSET, &iovec) != 0)
	perror_with_name (_("Couldn't set FP registers"));
    }

  if (regnum == -1 /*|| regset == NT_NANOMIPS_DSP*/)
    {
      /* FIXME: Need to implement DSP regset.  */
    }
}

static const struct target_desc *
nanomips_linux_read_description (struct target_ops *ops)
{
  gdb_byte buf[sizeof (nanomips64_elf_gregset_t)];
  int have_64bit = -1;
  struct iovec iovec;
  int have_dsp = -1;
  int tid;

  tid = ptid_get_lwp (inferior_ptid);
  if (tid == 0)
    tid = ptid_get_pid (inferior_ptid);

  /* Trying to retrieve the amount of NT_PRSTATUS data corresponding
     to this regset's 64-bit size will fail with a 32-bit inferior.  */
  iovec.iov_base = &buf;
  iovec.iov_len = sizeof (buf);

  if (ptrace (PTRACE_GETREGSET, tid, NT_PRSTATUS, &iovec) == 0)
    have_64bit = 1;
  else if (errno == EIO)
    have_64bit = 0;
  else
    perror_with_name (_("Couldn't check inferior's register width"));

  /* FIXME: Need to implement DSP regset.  */
  have_dsp = 0;

  if (have_64bit)
    return have_dsp ? tdesc_nanomips64_dsp_linux : tdesc_nanomips64_linux;
  else
    return have_dsp ? tdesc_nanomips_dsp_linux : tdesc_nanomips_linux;
}

void _initialize_nanomips_linux_nat (void);

void
_initialize_nanomips_linux_nat (void)
{
  struct target_ops *t;

  t = linux_target ();

  t->to_fetch_registers = nanomips_linux_fetch_registers;
  t->to_store_registers = nanomips_linux_store_registers;

  t->to_read_description = nanomips_linux_read_description;

  linux_nat_add_target (t);
}
