/* bfd back-end for nanomips support
   Copyright (C) 2018 Free Software Foundation, Inc.
   Contributed by MIPS Tech LLC.
   Written by Faraz Shahbazker <faraz.shahbazker@mips.com>

   This file is part of BFD, the Binary File Descriptor library.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
   MA 02110-1301, USA.  */

#include "sysdep.h"
#include "bfd.h"
#include "libbfd.h"

#define N(BITS_WORD, BITS_ADDR, NUMBER, PRINT, DEFAULT, NEXT)		\
  {							\
    BITS_WORD, /*  bits in a word */			\
    BITS_ADDR, /* bits in an address */			\
    8,	/* 8 bits in a byte */				\
    bfd_arch_nanomips,					\
    NUMBER,						\
    "nanomips",						\
    PRINT,						\
    3,							\
    DEFAULT,						\
    bfd_default_compatible,				\
    bfd_default_scan,					\
    bfd_arch_default_fill,				\
    NEXT,						\
  }

enum
{
  I_nanomipsisa32r6,
  I_nanomipsisa64r6,
};

#define NN(index) (&arch_info_struct[(index) + 1])

static const bfd_arch_info_type arch_info_struct[] = {
  N (32, 32, bfd_mach_nanomipsisa32r6, "nanomips:isa32r6", FALSE,
     NN (I_nanomipsisa32r6)),
  N (64, 64, bfd_mach_nanomipsisa64r6, "nanomips:isa64r6", FALSE,
     0),
};

const bfd_arch_info_type bfd_nanomips_arch =
N (32, 32, 0, "nanomips", TRUE, &arch_info_struct[0]);
