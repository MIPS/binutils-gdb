/* GNU/Linux on ARM native support.
   Copyright 1999, 2000 Free Software Foundation, Inc.

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
#include "inferior.h"
#include "gdbcore.h"
#include "gdb_string.h"

#include <sys/user.h>
#include <sys/ptrace.h>
#include <sys/utsname.h>

extern int arm_apcs_32;

#define		typeNone		0x00
#define		typeSingle		0x01
#define		typeDouble		0x02
#define		typeExtended		0x03
#define 	FPWORDS			28
#define		CPSR_REGNUM		16

typedef union tagFPREG
  {
    unsigned int fSingle;
    unsigned int fDouble[2];
    unsigned int fExtended[3];
  }
FPREG;

typedef struct tagFPA11
  {
    FPREG fpreg[8];		/* 8 floating point registers */
    unsigned int fpsr;		/* floating point status register */
    unsigned int fpcr;		/* floating point control register */
    unsigned char fType[8];	/* type of floating point value held in
				   floating point registers.  */
    int initflag;		/* NWFPE initialization flag.  */
  }
FPA11;

/* The following variables are used to determine the version of the
   underlying Linux operating system.  Examples:

   Linux 2.0.35                 Linux 2.2.12
   os_version = 0x00020023      os_version = 0x0002020c
   os_major = 2                 os_major = 2
   os_minor = 0                 os_minor = 2
   os_release = 35              os_release = 12

   Note: os_version = (os_major << 16) | (os_minor << 8) | os_release

   These are initialized using get_linux_version() from
   _initialize_arm_linux_nat().  */

static unsigned int os_version, os_major, os_minor, os_release;

static void
fetch_nwfpe_single (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  mem[0] = fpa11->fpreg[fn].fSingle;
  mem[1] = 0;
  mem[2] = 0;
  supply_register (F0_REGNUM + fn, (char *) &mem[0]);
}

static void
fetch_nwfpe_double (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  mem[0] = fpa11->fpreg[fn].fDouble[1];
  mem[1] = fpa11->fpreg[fn].fDouble[0];
  mem[2] = 0;
  supply_register (F0_REGNUM + fn, (char *) &mem[0]);
}

static void
fetch_nwfpe_none (unsigned int fn)
{
  unsigned int mem[3] =
  {0, 0, 0};

  supply_register (F0_REGNUM + fn, (char *) &mem[0]);
}

static void
fetch_nwfpe_extended (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  mem[0] = fpa11->fpreg[fn].fExtended[0];	/* sign & exponent */
  mem[1] = fpa11->fpreg[fn].fExtended[2];	/* ls bits */
  mem[2] = fpa11->fpreg[fn].fExtended[1];	/* ms bits */
  supply_register (F0_REGNUM + fn, (char *) &mem[0]);
}

static void
store_nwfpe_single (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  read_register_gen (F0_REGNUM + fn, (char *) &mem[0]);
  fpa11->fpreg[fn].fSingle = mem[0];
  fpa11->fType[fn] = typeSingle;
}

static void
store_nwfpe_double (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  read_register_gen (F0_REGNUM + fn, (char *) &mem[0]);
  fpa11->fpreg[fn].fDouble[1] = mem[0];
  fpa11->fpreg[fn].fDouble[0] = mem[1];
  fpa11->fType[fn] = typeDouble;
}

void
store_nwfpe_extended (unsigned int fn, FPA11 * fpa11)
{
  unsigned int mem[3];

  read_register_gen (F0_REGNUM + fn, (char *) &mem[0]);
  fpa11->fpreg[fn].fExtended[0] = mem[0];	/* sign & exponent */
  fpa11->fpreg[fn].fExtended[2] = mem[1];	/* ls bits */
  fpa11->fpreg[fn].fExtended[1] = mem[2];	/* ms bits */
  fpa11->fType[fn] = typeDouble;
}

/* Get the whole floating point state of the process and store the
   floating point stack into registers[].  */

static void
fetch_fpregs (void)
{
  int ret, regno;
  FPA11 fp;

  /* Read the floating point state.  */
  ret = ptrace (PT_GETFPREGS, inferior_pid, 0, &fp);
  if (ret < 0)
    {
      warning ("Unable to fetch the floating point state.");
      return;
    }

  /* Fetch fpsr.  */
  supply_register (FPS_REGNUM, (char *) &fp.fpsr);

  /* Fetch the floating point registers.  */
  for (regno = F0_REGNUM; regno <= F7_REGNUM; regno++)
    {
      int fn = regno - F0_REGNUM;

      switch (fp.fType[fn])
	{
	case typeSingle:
	  fetch_nwfpe_single (fn, &fp);
	  break;

	case typeDouble:
	  fetch_nwfpe_double (fn, &fp);
	  break;

	case typeExtended:
	  fetch_nwfpe_extended (fn, &fp);
	  break;

	default:
	  fetch_nwfpe_none (fn);
	}
    }
}

/* Save the whole floating point state of the process using
   the contents from registers[].  */

static void
store_fpregs (void)
{
  int ret, regno;
  FPA11 fp;

  /* Store fpsr.  */
  if (register_valid[FPS_REGNUM])
    read_register_gen (FPS_REGNUM, (char *) &fp.fpsr);

  /* Store the floating point registers.  */
  for (regno = F0_REGNUM; regno <= F7_REGNUM; regno++)
    {
      if (register_valid[regno])
	{
	  unsigned int fn = regno - F0_REGNUM;
	  switch (fp.fType[fn])
	    {
	    case typeSingle:
	      store_nwfpe_single (fn, &fp);
	      break;

	    case typeDouble:
	      store_nwfpe_double (fn, &fp);
	      break;

	    case typeExtended:
	      store_nwfpe_extended (fn, &fp);
	      break;
	    }
	}
    }

  ret = ptrace (PTRACE_SETFPREGS, inferior_pid, 0, &fp);
  if (ret < 0)
    {
      warning ("Unable to store floating point state.");
      return;
    }
}

/* Fetch all general registers of the process and store into
   registers[].  */

static void
fetch_regs (void)
{
  int ret, regno;
  struct pt_regs regs;

  ret = ptrace (PTRACE_GETREGS, inferior_pid, 0, &regs);
  if (ret < 0)
    {
      warning ("Unable to fetch general registers.");
      return;
    }

  for (regno = A1_REGNUM; regno < PC_REGNUM; regno++)
    supply_register (regno, (char *) &regs.uregs[regno]);

  if (arm_apcs_32)
    supply_register (PS_REGNUM, (char *) &regs.uregs[CPSR_REGNUM]);
  else
    supply_register (PS_REGNUM, (char *) &regs.uregs[PC_REGNUM]);

  regs.uregs[PC_REGNUM] = ADDR_BITS_REMOVE (regs.uregs[PC_REGNUM]);
  supply_register (PC_REGNUM, (char *) &regs.uregs[PC_REGNUM]);
}

/* Store all general registers of the process from the values in
   registers[].  */

static void
store_regs (void)
{
  int ret, regno;
  struct pt_regs regs;

  ret = ptrace (PTRACE_GETREGS, inferior_pid, 0, &regs);
  if (ret < 0)
    {
      warning ("Unable to fetch general registers.");
      return;
    }

  for (regno = A1_REGNUM; regno <= PC_REGNUM; regno++)
    {
      if (register_valid[regno])
	read_register_gen (regno, (char *) &regs.uregs[regno]);
    }

  ret = ptrace (PTRACE_SETREGS, inferior_pid, 0, &regs);

  if (ret < 0)
    {
      warning ("Unable to store general registers.");
      return;
    }
}

/* Fetch registers from the child process.  Fetch all registers if
   regno == -1, otherwise fetch all general registers or all floating
   point registers depending upon the value of regno.  */

void
fetch_inferior_registers (int regno)
{
  if ((regno < F0_REGNUM) || (regno > FPS_REGNUM))
    fetch_regs ();

  if (((regno >= F0_REGNUM) && (regno <= FPS_REGNUM)) || (regno == -1))
    fetch_fpregs ();
}

/* Store registers back into the inferior.  Store all registers if
   regno == -1, otherwise store all general registers or all floating
   point registers depending upon the value of regno.  */

void
store_inferior_registers (int regno)
{
  if ((regno < F0_REGNUM) || (regno > FPS_REGNUM))
    store_regs ();

  if (((regno >= F0_REGNUM) && (regno <= FPS_REGNUM)) || (regno == -1))
    store_fpregs ();
}

int
arm_linux_register_u_addr (int blockend, int regnum)
{
  return blockend + REGISTER_BYTE (regnum);
}

int
arm_linux_kernel_u_size (void)
{
  return (sizeof (struct user));
}

static unsigned int
get_linux_version (unsigned int *vmajor,
		   unsigned int *vminor,
		   unsigned int *vrelease)
{
  struct utsname info;
  char *pmajor, *pminor, *prelease, *tail;

  if (-1 == uname (&info))
    {
      warning ("Unable to determine Linux version.");
      return -1;
    }

  pmajor = strtok (info.release, ".");
  pminor = strtok (NULL, ".");
  prelease = strtok (NULL, ".");

  *vmajor = (unsigned int) strtoul (pmajor, &tail, 0);
  *vminor = (unsigned int) strtoul (pminor, &tail, 0);
  *vrelease = (unsigned int) strtoul (prelease, &tail, 0);

  return ((*vmajor << 16) | (*vminor << 8) | *vrelease);
}

void
_initialize_arm_linux_nat (void)
{
  os_version = get_linux_version (&os_major, &os_minor, &os_release);
}
