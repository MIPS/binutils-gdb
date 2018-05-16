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

/* Copied from <asm/elf.h>.  */
#define NANOMIPS_ELF_NGREG	45	/* FIXME: Need to dump padding.  */
#define NANOMIPS_ELF_NFPREG	33

#define NANOMIPS_EF_PAD		6	/* FIXME: Need to dump padding.  */
#define NANOMIPS64_EF_PAD	0

typedef unsigned char nanomips_elf_greg_t[4];
typedef nanomips_elf_greg_t nanomips_elf_gregset_t[NANOMIPS_ELF_NGREG];

typedef unsigned char nanomips64_elf_greg_t[8];
typedef nanomips64_elf_greg_t nanomips64_elf_gregset_t[NANOMIPS_ELF_NGREG];

typedef unsigned char nanomips_elf_fpreg_t[8];
typedef nanomips_elf_fpreg_t nanomips_elf_fpregset_t[NANOMIPS_ELF_NFPREG];
