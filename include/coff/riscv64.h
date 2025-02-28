/* RISC-V 64-bit COFF support for BFD.
   Copyright (C) 2023-2025 Free Software Foundation, Inc.

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
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */

#ifndef COFF_RISCV64_H
#define COFF_RISCV64_H

#define COFFRISCV64 1

#define L_LNNO_SIZE 2
#define INCLUDE_COMDAT_FIELDS_IN_AUXENT
#include "coff/external.h"

#define	RISCV64MAGIC	0x5064  /* From Microsoft specification. */

#undef  BADMAG
#define BADMAG(x) ((x).f_magic != RISCV64MAGIC)
#define RISCV64         1                 /* Customize coffcode.h.  */

#define IMAGE_NT_OPTIONAL_HDR64_MAGIC      0x20b

#define OMAGIC          0404    /* Object files, eg as output.  */
#define ZMAGIC          IMAGE_NT_OPTIONAL_HDR64_MAGIC    /* Demand load format, eg normal ld output 0x10b.  */
#define STMAGIC		0401	/* Target shlib.  */
#define SHMAGIC		0443	/* Host   shlib.  */

/* define some NT default values */
/*  #define NT_IMAGE_BASE        0x400000 moved to internal.h */
#define NT_SECTION_ALIGNMENT 0x1000
#define NT_FILE_ALIGNMENT    0x200
#define NT_DEF_RESERVE       0x100000
#define NT_DEF_COMMIT        0x1000

/* We use the .rdata section to hold read only data.  */
#define _LIT	".rdata"

/********************** RELOCATION DIRECTIVES **********************/
struct external_reloc
{
  char r_vaddr[4];
  char r_symndx[4];
  char r_type[2];
  char r_offset[4];
};

#define RELOC struct external_reloc
#define RELSZ 14
#define SWAP_IN_RELOC_OFFSET	H_GET_32
#define SWAP_OUT_RELOC_OFFSET	H_PUT_32

#endif /* COFF_RISCV64_H */
