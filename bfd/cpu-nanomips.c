/* bfd back-end for mips support
   Copyright (C) 1990-2014 Free Software Foundation, Inc.
   Written by Steve Chamberlain of Cygnus Support.

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

static const bfd_arch_info_type *nanomips_compatible
  (const bfd_arch_info_type *, const bfd_arch_info_type *);

/* The default routine tests bits_per_word, which is wrong on mips as
   mips word size doesn't correlate with reloc size.  */

static const bfd_arch_info_type *
nanomips_compatible (const bfd_arch_info_type *a, const bfd_arch_info_type *b)
{
  if (a->arch != b->arch)
    return NULL;

  /* Machine compatibility is checked in
     _bfd_nanomips_elf_merge_private_bfd_data.  */

  return a;
}

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
    nanomips_compatible,					\
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

static const bfd_arch_info_type arch_info_struct[] =
{
  N (32, 32, bfd_mach_nanomipsisa32r6,"nanomips:isa32r6", FALSE,
     NN(I_nanomipsisa32r6)),
  N (64, 64, bfd_mach_nanomipsisa64r6,"nanomips:isa64r6", FALSE,
     NN(I_nanomipsisa64r6)),
};

/* The default architecture is mips:3000, but with a machine number of
   zero.  This lets the linker distinguish between a default setting
   of mips, and an explicit setting of mips:3000.  */

const bfd_arch_info_type bfd_nanomips_arch =
N (32, 32, 0, "nanomips", TRUE, &arch_info_struct[0]);

