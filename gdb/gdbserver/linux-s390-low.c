/* GNU/Linux S/390 specific low level interface, for the remote server
   for GDB.
   Copyright 2001, 2002
   Free Software Foundation, Inc.

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

/* This file is used for both 31-bit and 64-bit S/390 systems.  */

#include "server.h"
#include "linux-low.h"

#include <asm/ptrace.h>

int num_regs = 67;

int regmap[] = {
  PT_PSWMASK, PT_PSWADDR,

  PT_GPR0, PT_GPR1, PT_GPR2, PT_GPR3,
  PT_GPR4, PT_GPR5, PT_GPR6, PT_GPR7,
  PT_GPR8, PT_GPR9, PT_GPR10, PT_GPR11,
  PT_GPR12, PT_GPR13, PT_GPR14, PT_GPR15,

  PT_ACR0, PT_ACR1, PT_ACR2, PT_ACR3,
  PT_ACR4, PT_ACR5, PT_ACR6, PT_ACR7,
  PT_ACR8, PT_ACR9, PT_ACR10, PT_ACR11,
  PT_ACR12, PT_ACR13, PT_ACR14, PT_ACR15,

  -1, -1, -1, -1,
  -1, -1, -1, -1,
  -1, PT_CR_9, PT_CR_10, PT_CR_11,
  -1, -1, -1, -1,
  
  PT_FPC,

#ifdef PT_FPR0_HI
  PT_FPR0_HI, PT_FPR1_HI, PT_FPR2_HI, PT_FPR3_HI,
  PT_FPR4_HI, PT_FPR5_HI, PT_FPR6_HI, PT_FPR7_HI,
  PT_FPR8_HI, PT_FPR9_HI, PT_FPR10_HI, PT_FPR11_HI,
  PT_FPR12_HI, PT_FPR13_HI, PT_FPR14_HI, PT_FPR15_HI,
#else
  PT_FPR0, PT_FPR1, PT_FPR2, PT_FPR3,
  PT_FPR4, PT_FPR5, PT_FPR6, PT_FPR7,
  PT_FPR8, PT_FPR9, PT_FPR10, PT_FPR11,
  PT_FPR12, PT_FPR13, PT_FPR14, PT_FPR15,
#endif
};

int
cannot_fetch_register (int regno)
{
  if (regmap[regno] == -1)
    return 1;

  return 0;
}

int
cannot_store_register (int regno)
{
  if (regmap[regno] == -1)
    return 1;

  return 0;
}
