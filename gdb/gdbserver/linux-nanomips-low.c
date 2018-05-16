/* GNU/Linux/MIPS specific low level interface, for the remote server for GDB.
   Copyright (C) 1995-2017 Free Software Foundation, Inc.

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

#include "server.h"
#include "linux-low.h"

#include "arch/nanomips-linux.h"

#include "elf/common.h"
#include "nat/gdb_ptrace.h"
#include <asm/ptrace.h>

#include <endian.h>
#include <sys/uio.h>

#include "nat/nanomips-linux-watch.h"
#include "gdb_proc_service.h"

/* Defined in auto-generated file nanomips-linux.c.  */
void init_registers_nanomips_linux (void);
extern const struct target_desc *tdesc_nanomips_linux;

/* Defined in auto-generated file nanomips-dsp-linux.c.  */
void init_registers_nanomips_dsp_linux (void);
extern const struct target_desc *tdesc_nanomips_dsp_linux;

/* Defined in auto-generated file nanomips64-linux.c.  */
void init_registers_nanomips64_linux (void);
extern const struct target_desc *tdesc_nanomips64_linux;

/* Defined in auto-generated file nanomips64-dsp-linux.c.  */
void init_registers_nanomips64_dsp_linux (void);
extern const struct target_desc *tdesc_nanomips64_dsp_linux;


#ifndef PTRACE_GET_THREAD_AREA
#define PTRACE_GET_THREAD_AREA 25
#endif

union nanomips_register
{
  gdb_byte buf[8];

  /* Deliberately signed, for proper sign extension.  */
  int reg32;
  long long reg64;
};

static int have_64bit = -1;
static int have_dsp = -1;

static const struct target_desc *
nanomips_read_description (void)
{
  gdb_byte buf[sizeof (nanomips64_elf_gregset_t)];
  int pid = lwpid_of (current_thread);
  struct iovec iovec;

  /* Trying to retrieve the amount of NT_PRSTATUS data corresponding
     to this regset's 64-bit size will fail with a 32-bit inferior.  */
  iovec.iov_base = &buf;
  iovec.iov_len = sizeof (buf);

  if (ptrace (PTRACE_GETREGSET, pid, NT_PRSTATUS, &iovec) == 0)
    have_64bit = 1;
  else if (errno == EIO)
    have_64bit = 0;
  else
    perror_with_name (_("Couldn't check inferior's register width"));

  if (have_dsp < 0)
    {
      /* FIXME: Need to implement DSP regset.  */
      have_dsp = 0;
    }

  if (have_64bit)
    return have_dsp ? tdesc_nanomips64_dsp_linux : tdesc_nanomips64_linux;
  else
    return have_dsp ? tdesc_nanomips_dsp_linux : tdesc_nanomips_linux;
}

static void
nanomips_arch_setup (void)
{
  current_process ()->tdesc = nanomips_read_description ();
}

#ifdef NANOMIPS_WATCHPOINTS
/* Per-process arch-specific data we want to keep.  */

struct arch_process_info
{
  /* -1 if the kernel and/or CPU do not support watch registers.
      1 if watch_readback is valid and we can read style, num_valid
	and the masks.
      0 if we need to read the watch_readback.  */

  int watch_readback_valid;

  /* Cached watch register read values.  */

  struct pt_watch_regs watch_readback;

  /* Current watchpoint requests for this process.  */

  struct nanomips_watchpoint *current_watches;

  /* The current set of watch register values for writing the
     registers.  */

  struct pt_watch_regs watch_mirror;
};

/* Per-thread arch-specific data we want to keep.  */

struct arch_lwp_info
{
  /* Non-zero if our copy differs from what's recorded in the thread.  */
  int watch_registers_changed;
};
#endif /* NANOMIPS_WATCHPOINTS */

static CORE_ADDR
nanomips_get_pc (struct regcache *regcache)
{
  union nanomips_register pc;
  collect_register_by_name (regcache, "pc", pc.buf);
  return register_size (regcache->tdesc, 0) == 4 ? pc.reg32 : pc.reg64;
}

static void
nanomips_set_pc (struct regcache *regcache, CORE_ADDR pc)
{
  union nanomips_register newpc;
  if (register_size (regcache->tdesc, 0) == 4)
    newpc.reg32 = pc;
  else
    newpc.reg64 = pc;

  supply_register_by_name (regcache, "pc", newpc.buf);
}

/* Correct in either endianness.  */
static const unsigned int nanomips_breakpoint = 0x0005000d;
#define nanomips_breakpoint_len 4

/* Implementation of linux_target_ops method "sw_breakpoint_from_kind".  */

static const gdb_byte *
nanomips_sw_breakpoint_from_kind (int kind, int *size)
{
  *size = nanomips_breakpoint_len;
  return (const gdb_byte *) &nanomips_breakpoint;
}

static int
nanomips_breakpoint_at (CORE_ADDR where)
{
  unsigned int insn;

  (*the_target->read_memory) (where, (unsigned char *) &insn, 4);
  if (insn == nanomips_breakpoint)
    return 1;

  /* If necessary, recognize more trap instructions here.  GDB only uses the
     one.  */
  return 0;
}

#ifdef NANOMIPS_WATCHPOINTS
/* Mark the watch registers of lwp, represented by ENTRY, as changed,
   if the lwp's process id is *PID_P.  */

static int
update_watch_registers_callback (struct inferior_list_entry *entry,
				 void *pid_p)
{
  struct thread_info *thread = (struct thread_info *) entry;
  struct lwp_info *lwp = get_thread_lwp (thread);
  int pid = *(int *) pid_p;

  /* Only update the threads of this process.  */
  if (pid_of (thread) == pid)
    {
      /* The actual update is done later just before resuming the lwp,
	 we just mark that the registers need updating.  */
      lwp->arch_private->watch_registers_changed = 1;

      /* If the lwp isn't stopped, force it to momentarily pause, so
	 we can update its watch registers.  */
      if (!lwp->stopped)
	linux_stop_lwp (lwp);
    }

  return 0;
}

/* This is the implementation of linux_target_ops method
   new_process.  */

static struct arch_process_info *
nanomips_linux_new_process (void)
{
  struct arch_process_info *info = XCNEW (struct arch_process_info);

  return info;
}

/* This is the implementation of linux_target_ops method new_thread.
   Mark the watch registers as changed, so the threads' copies will
   be updated.  */

static void
nanomips_linux_new_thread (struct lwp_info *lwp)
{
  struct arch_lwp_info *info = XCNEW (struct arch_lwp_info);

  info->watch_registers_changed = 1;

  lwp->arch_private = info;
}

/* Create a new nanomips_watchpoint and add it to the list.  */

static void
nanomips_add_watchpoint (struct arch_process_info *priv, CORE_ADDR addr, int len,
		     enum target_hw_bp_type watch_type)
{
  struct nanomips_watchpoint *new_watch;
  struct nanomips_watchpoint **pw;

  new_watch = XNEW (struct nanomips_watchpoint);
  new_watch->addr = addr;
  new_watch->len = len;
  new_watch->type = watch_type;
  new_watch->next = NULL;

  pw = &priv->current_watches;
  while (*pw != NULL)
    pw = &(*pw)->next;
  *pw = new_watch;
}

/* Hook to call when a new fork is attached.  */

static void
nanomips_linux_new_fork (struct process_info *parent,
			 struct process_info *child)
{
  struct arch_process_info *parent_private;
  struct arch_process_info *child_private;
  struct nanomips_watchpoint *wp;

  /* These are allocated by linux_add_process.  */
  gdb_assert (parent->priv != NULL
	      && parent->priv->arch_private != NULL);
  gdb_assert (child->priv != NULL
	      && child->priv->arch_private != NULL);

  /* Linux kernel before 2.6.33 commit
     72f674d203cd230426437cdcf7dd6f681dad8b0d
     will inherit hardware debug registers from parent
     on fork/vfork/clone.  Newer Linux kernels create such tasks with
     zeroed debug registers.

     GDB core assumes the child inherits the watchpoints/hw
     breakpoints of the parent, and will remove them all from the
     forked off process.  Copy the debug registers mirrors into the
     new process so that all breakpoints and watchpoints can be
     removed together.  The debug registers mirror will become zeroed
     in the end before detaching the forked off process, thus making
     this compatible with older Linux kernels too.  */

  parent_private = parent->priv->arch_private;
  child_private = child->priv->arch_private;

  child_private->watch_readback_valid = parent_private->watch_readback_valid;
  child_private->watch_readback = parent_private->watch_readback;

  for (wp = parent_private->current_watches; wp != NULL; wp = wp->next)
    nanomips_add_watchpoint (child_private, wp->addr, wp->len, wp->type);

  child_private->watch_mirror = parent_private->watch_mirror;
}
/* This is the implementation of linux_target_ops method
   prepare_to_resume.  If the watch regs have changed, update the
   thread's copies.  */

static void
nanomips_linux_prepare_to_resume (struct lwp_info *lwp)
{
  ptid_t ptid = ptid_of (get_lwp_thread (lwp));
  struct process_info *proc = find_process_pid (ptid_get_pid (ptid));
  struct arch_process_info *priv = proc->priv->arch_private;

  if (lwp->arch_private->watch_registers_changed)
    {
      /* Only update the watch registers if we have set or unset a
	 watchpoint already.  */
      if (nanomips_linux_watch_get_num_valid (&priv->watch_mirror) > 0)
	{
	  /* Write the mirrored watch register values.  */
	  int tid = ptid_get_lwp (ptid);

	  if (-1 == ptrace (PTRACE_SET_WATCH_REGS, tid,
			    &priv->watch_mirror, NULL))
	    perror_with_name ("Couldn't write watch register");
	}

      lwp->arch_private->watch_registers_changed = 0;
    }
}

static int
nanomips_supports_z_point_type (char z_type)
{
  switch (z_type)
    {
    case Z_PACKET_WRITE_WP:
    case Z_PACKET_READ_WP:
    case Z_PACKET_ACCESS_WP:
      return 1;
    default:
      return 0;
    }
}

/* This is the implementation of linux_target_ops method
   insert_point.  */

static int
nanomips_insert_point (enum raw_bkpt_type type, CORE_ADDR addr,
		   int len, struct raw_breakpoint *bp)
{
  struct process_info *proc = current_process ();
  struct arch_process_info *priv = proc->priv->arch_private;
  struct pt_watch_regs regs;
  int pid;
  long lwpid;
  enum target_hw_bp_type watch_type;
  uint32_t irw;

  lwpid = lwpid_of (current_thread);
  if (!nanomips_linux_read_watch_registers (lwpid,
					&priv->watch_readback,
					&priv->watch_readback_valid,
					0))
    return -1;

  if (len <= 0)
    return -1;

  regs = priv->watch_readback;
  /* Add the current watches.  */
  nanomips_linux_watch_populate_regs (priv->current_watches, &regs);

  /* Now try to add the new watch.  */
  watch_type = raw_bkpt_type_to_target_hw_bp_type (type);
  irw = nanomips_linux_watch_type_to_irw (watch_type);
  if (!nanomips_linux_watch_try_one_watch (&regs, addr, len, irw))
    return -1;

  /* It fit.  Stick it on the end of the list.  */
  nanomips_add_watchpoint (priv, addr, len, watch_type);

  priv->watch_mirror = regs;

  /* Only update the threads of this process.  */
  pid = pid_of (proc);
  find_inferior (&all_threads, update_watch_registers_callback, &pid);

  return 0;
}

/* This is the implementation of linux_target_ops method
   remove_point.  */

static int
nanomips_remove_point (enum raw_bkpt_type type, CORE_ADDR addr,
		   int len, struct raw_breakpoint *bp)
{
  struct process_info *proc = current_process ();
  struct arch_process_info *priv = proc->priv->arch_private;

  int deleted_one;
  int pid;
  enum target_hw_bp_type watch_type;

  struct nanomips_watchpoint **pw;
  struct nanomips_watchpoint *w;

  /* Search for a known watch that matches.  Then unlink and free it.  */
  watch_type = raw_bkpt_type_to_target_hw_bp_type (type);
  deleted_one = 0;
  pw = &priv->current_watches;
  while ((w = *pw))
    {
      if (w->addr == addr && w->len == len && w->type == watch_type)
	{
	  *pw = w->next;
	  free (w);
	  deleted_one = 1;
	  break;
	}
      pw = &(w->next);
    }

  if (!deleted_one)
    return -1;  /* We don't know about it, fail doing nothing.  */

  /* At this point watch_readback is known to be valid because we
     could not have added the watch without reading it.  */
  gdb_assert (priv->watch_readback_valid == 1);

  priv->watch_mirror = priv->watch_readback;
  nanomips_linux_watch_populate_regs (priv->current_watches,
				  &priv->watch_mirror);

  /* Only update the threads of this process.  */
  pid = pid_of (proc);
  find_inferior (&all_threads, update_watch_registers_callback, &pid);
  return 0;
}

/* This is the implementation of linux_target_ops method
   stopped_by_watchpoint.  The watchhi R and W bits indicate
   the watch register triggered. */

static int
nanomips_stopped_by_watchpoint (void)
{
  struct process_info *proc = current_process ();
  struct arch_process_info *priv = proc->priv->arch_private;
  int n;
  int num_valid;
  long lwpid = lwpid_of (current_thread);

  if (!nanomips_linux_read_watch_registers (lwpid,
					&priv->watch_readback,
					&priv->watch_readback_valid,
					1))
    return 0;

  num_valid = nanomips_linux_watch_get_num_valid (&priv->watch_readback);

  for (n = 0; n < MAX_DEBUG_REGISTER && n < num_valid; n++)
    if (nanomips_linux_watch_get_watchhi (&priv->watch_readback, n)
	& (R_MASK | W_MASK))
      return 1;

  return 0;
}

/* This is the implementation of linux_target_ops method
   stopped_data_address.  */

static CORE_ADDR
nanomips_stopped_data_address (void)
{
  struct process_info *proc = current_process ();
  struct arch_process_info *priv = proc->priv->arch_private;
  int n;
  int num_valid;
  long lwpid = lwpid_of (current_thread);

  /* On MIPS we don't know the low order 3 bits of the data address.
     GDB does not support remote targets that can't report the
     watchpoint address.  So, make our best guess; return the starting
     address of a watchpoint request which overlaps the one that
     triggered.  */

  if (!nanomips_linux_read_watch_registers (lwpid,
					&priv->watch_readback,
					&priv->watch_readback_valid,
					0))
    return 0;

  num_valid = nanomips_linux_watch_get_num_valid (&priv->watch_readback);

  for (n = 0; n < MAX_DEBUG_REGISTER && n < num_valid; n++)
    if (nanomips_linux_watch_get_watchhi (&priv->watch_readback, n)
	& (R_MASK | W_MASK))
      {
	CORE_ADDR t_low, t_hi;
	int t_irw;
	struct nanomips_watchpoint *watch;

	t_low = nanomips_linux_watch_get_watchlo (&priv->watch_readback, n);
	t_irw = t_low & IRW_MASK;
	t_hi = (nanomips_linux_watch_get_watchhi (&priv->watch_readback, n)
		| IRW_MASK);
	t_low &= ~(CORE_ADDR)t_hi;

	for (watch = priv->current_watches;
	     watch != NULL;
	     watch = watch->next)
	  {
	    CORE_ADDR addr = watch->addr;
	    CORE_ADDR last_byte = addr + watch->len - 1;

	    if ((t_irw & nanomips_linux_watch_type_to_irw (watch->type)) == 0)
	      {
		/* Different type.  */
		continue;
	      }
	    /* Check for overlap of even a single byte.  */
	    if (last_byte >= t_low && addr <= t_low + t_hi)
	      return addr;
	  }
      }

  /* Shouldn't happen.  */
  return 0;
}
#endif /* NANOMIPS_WATCHPOINTS */

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

static void
nanomips_fill_gregset (struct regcache *regcache, void *ptr)
{
  const struct target_desc *tdesc = regcache->tdesc;
  int gpr = find_regno (tdesc, "r1");
  int regsize = register_size (tdesc, gpr);
  gdb_byte *buf = (gdb_byte *) ptr;
  int i;

  collect_register_by_name (regcache, "restart", buf);
  buf += regsize;
  for (i = 1; i < 32; i++, gpr++, buf += regsize)
    collect_register (regcache, gpr, buf);
  collect_register_by_name (regcache, "pc", buf);
  buf += regsize;
  collect_register_by_name (regcache, "badvaddr", buf);
  buf += regsize;
  collect_register_by_name (regcache, "status", buf);
  buf += regsize;
  collect_register_by_name (regcache, "cause", buf);
}

static void
nanomips_store_gregset (struct regcache *regcache, const void *ptr)
{
  const struct target_desc *tdesc = regcache->tdesc;
  const gdb_byte *buf = (const gdb_byte *) ptr;
  int gpr = find_regno (tdesc, "r1");
  int regsize = register_size (tdesc, gpr);
  nanomips64_elf_greg_t zerobuf = { 0 };
  int i;

  supply_register_by_name (regcache, "restart", buf);
  buf += regsize;
  supply_register_by_name (regcache, "r0", zerobuf);
  for (i = 1; i < 32; i++, gpr++, buf += regsize)
    supply_register (regcache, gpr, buf);
  supply_register_by_name (regcache, "pc", buf);
  buf += regsize;
  supply_register_by_name (regcache, "badvaddr", buf);
  buf += regsize;
  supply_register_by_name (regcache, "status", buf);
  buf += regsize;
  supply_register_by_name (regcache, "cause", buf);
}

static void
nanomips_fill_fpregset (struct regcache *regcache, void *ptr)
{
  gdb_byte *buf = (gdb_byte *) ptr;
  int i, fpr;

  fpr = find_regno (regcache->tdesc, "f0");
  for (i = 0; i < 32; i++, fpr++, buf += 8)
    collect_register (regcache, fpr, buf);
  collect_register_by_name (regcache, "fcsr", buf);
  buf += 4;
  collect_register_by_name (regcache, "fir", buf);
}

static void
nanomips_store_fpregset (struct regcache *regcache, const void *ptr)
{
  const gdb_byte *buf = (const gdb_byte *) ptr;
  int i, fpr;

  fpr = find_regno (regcache->tdesc, "f0");
  for (i = 0; i < 32; i++, fpr++, buf += 8)
    supply_register (regcache, fpr, buf);
  supply_register_by_name (regcache, "fcsr", buf);
  buf += 4;
  supply_register_by_name (regcache, "fir", buf);
}

static struct regset_info nanomips_regsets[] = {
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_PRSTATUS,
    sizeof (nanomips_elf_gregset_t), GENERAL_REGS,
    nanomips_fill_gregset, nanomips_store_gregset },
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_FPREGSET,
    sizeof (nanomips_elf_fpregset_t), FP_REGS,
    nanomips_fill_fpregset, nanomips_store_fpregset },
  NULL_REGSET
};

static struct regset_info nanomips_dsp_regsets[] = {
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_PRSTATUS,
    sizeof (nanomips_elf_gregset_t), GENERAL_REGS,
    nanomips_fill_gregset, nanomips_store_gregset },
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_FPREGSET,
    sizeof (nanomips_elf_fpregset_t), FP_REGS,
    nanomips_fill_fpregset, nanomips_store_fpregset },
#if 0
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_NANOMIPS_DSP,
    sizeof (nanomips_elf_dspregset_t), EXTENDED_REGS,
    nanomips_fill_dspregset, nanomips_store_dspregset },
#endif
  NULL_REGSET
};

static struct regset_info nanomips64_regsets[] = {
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_PRSTATUS,
    sizeof (nanomips64_elf_gregset_t), GENERAL_REGS,
    nanomips_fill_gregset, nanomips_store_gregset },
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_FPREGSET,
    sizeof (nanomips_elf_fpregset_t), FP_REGS,
    nanomips_fill_fpregset, nanomips_store_fpregset },
  NULL_REGSET
};

static struct regset_info nanomips64_dsp_regsets[] = {
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_PRSTATUS,
    sizeof (nanomips64_elf_gregset_t), GENERAL_REGS,
    nanomips_fill_gregset, nanomips_store_gregset },
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_FPREGSET,
    sizeof (nanomips_elf_fpregset_t), FP_REGS,
    nanomips_fill_fpregset, nanomips_store_fpregset },
#if 0
  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_NANOMIPS_DSP,
    sizeof (nanomips64_elf_dspregset_t), EXTENDED_REGS,
    nanomips_fill_dspregset, nanomips_store_dspregset },
#endif
  NULL_REGSET
};

static struct regsets_info nanomips_regsets_info =
  {
    nanomips_regsets, /* regsets */
    0, /* num_regsets */
    NULL, /* disabled_regsets */
  };

static struct regsets_info nanomips_dsp_regsets_info =
  {
    nanomips_dsp_regsets, /* regsets */
    0, /* num_regsets */
    NULL, /* disabled_regsets */
  };

static struct regsets_info nanomips64_regsets_info =
  {
    nanomips64_regsets, /* regsets */
    0, /* num_regsets */
    NULL, /* disabled_regsets */
  };

static struct regsets_info nanomips64_dsp_regsets_info =
  {
    nanomips64_dsp_regsets, /* regsets */
    0, /* num_regsets */
    NULL, /* disabled_regsets */
  };

static struct regs_info nanomips_regs =
  {
    NULL, /* regset_bitmap */
    NULL, /* usrregs */
    &nanomips_regsets_info
  };

static struct regs_info nanomips_dsp_regs =
  {
    NULL, /* regset_bitmap */
    NULL, /* usrregs */
    &nanomips_dsp_regsets_info
  };

static struct regs_info nanomips64_regs =
  {
    NULL, /* regset_bitmap */
    NULL, /* usrregs */
    &nanomips64_regsets_info
  };

static struct regs_info nanomips64_dsp_regs =
  {
    NULL, /* regset_bitmap */
    NULL, /* usrregs */
    &nanomips64_dsp_regsets_info
  };

static const struct regs_info *
nanomips_regs_info (void)
{
  if (have_64bit)
    return have_dsp ? &nanomips64_dsp_regs : &nanomips64_regs;
  else
    return have_dsp ? &nanomips_dsp_regs : &nanomips_regs;
}

struct linux_target_ops the_low_target = {
  nanomips_arch_setup,
  nanomips_regs_info,
  NULL, /* cannot_fetch_register */
  NULL, /* cannot_store_register */
  NULL, /* fetch_register */
  nanomips_get_pc,
  nanomips_set_pc,
  NULL, /* breakpoint_kind_from_pc */
  nanomips_sw_breakpoint_from_kind,
  NULL, /* get_next_pcs */
  0,
  nanomips_breakpoint_at,
#ifdef NANOMIPS_WATCHPOINTS
  nanomips_supports_z_point_type,
  nanomips_insert_point,
  nanomips_remove_point,
  nanomips_stopped_by_watchpoint,
  nanomips_stopped_data_address,
  NULL,
  NULL,
  NULL, /* siginfo_fixup */
  nanomips_linux_new_process,
  nanomips_linux_new_thread,
  nanomips_linux_new_fork,
  nanomips_linux_prepare_to_resume
#endif /* NANOMIPS_WATCHPOINTS */
};

void
initialize_low_arch (void)
{
  /* Initialize the Linux target descriptions.  */
  init_registers_nanomips_linux ();
  init_registers_nanomips_dsp_linux ();
  init_registers_nanomips64_linux ();
  init_registers_nanomips64_dsp_linux ();

  initialize_regsets_info (&nanomips_regsets_info);
  initialize_regsets_info (&nanomips_dsp_regsets_info);
  initialize_regsets_info (&nanomips64_regsets_info);
  initialize_regsets_info (&nanomips64_dsp_regsets_info);
}
