/* MIPS ELF support for BFD.
   Copyright (C) 2018 Free Software Foundation, Inc.
   Contributed by MIPSTech LLC.

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

/* This file holds definitions common to the MIPS and nanoMIPS ELF ABIs.  */

#ifndef _ELF_MIPS_COMMON_H
#define _ELF_MIPS_COMMON_H

#ifdef __cplusplus
extern "C" {
#endif

/* ABI Flags structure version 0.  */

typedef struct
{
  /* Version of flags structure.  */
  unsigned char version[2];
  /* The level of the ISA: 1-5, 32, 64.  */
  unsigned char isa_level[1];
  /* The revision of ISA: 0 for MIPS V and below, 1-n otherwise.  */
  unsigned char isa_rev[1];
  /* The size of general purpose registers.  */
  unsigned char gpr_size[1];
  /* The size of co-processor 1 registers.  */
  unsigned char cpr1_size[1];
  /* The size of co-processor 2 registers.  */
  unsigned char cpr2_size[1];
  /* The floating-point ABI.  */
  unsigned char fp_abi[1];
  /* Processor-specific extension.  */
  unsigned char isa_ext[4];
  /* Mask of ASEs used.  */
  unsigned char ases[4];
  /* Mask of general flags.  */
  unsigned char flags1[4];
  unsigned char flags2[4];
} Elf_External_ABIFlags_v0;

typedef struct
{
  /* Version of flags structure.  */
  unsigned short version;
  /* The level of the ISA: 1-5, 32, 64.  */
  unsigned char isa_level;
  /* The revision of ISA: 0 for MIPS V and below, 1-n otherwise.  */
  unsigned char isa_rev;
  /* The size of general purpose registers.  */
  unsigned char gpr_size;
  /* The size of co-processor 1 registers.  */
  unsigned char cpr1_size;
  /* The size of co-processor 2 registers.  */
  unsigned char cpr2_size;
  /* The floating-point ABI.  */
  unsigned char fp_abi;
  /* Processor-specific extension.  */
  unsigned long isa_ext;
  /* Mask of ASEs used.  */
  unsigned long ases;
  /* Mask of general flags.  */
  unsigned long flags1;
  unsigned long flags2;
} Elf_Internal_ABIFlags_v0;

/* MIPS ELF flags swapping routines.  */
extern void bfd_mips_elf_swap_abiflags_v0_in
  (bfd *, const Elf_External_ABIFlags_v0 *, Elf_Internal_ABIFlags_v0 *);
extern void bfd_mips_elf_swap_abiflags_v0_out
  (bfd *, const Elf_Internal_ABIFlags_v0 *, Elf_External_ABIFlags_v0 *);

/* Values for the xxx_size bytes of an ABI flags structure.  */

#define AFL_REG_NONE	     0x00	/* No registers.  */
#define AFL_REG_32	     0x01	/* 32-bit registers.  */
#define AFL_REG_64	     0x02	/* 64-bit registers.  */
#define AFL_REG_128	     0x03	/* 128-bit registers.  */

#ifdef __cplusplus
}
#endif

#endif /* _ELF_MIPS_COMMON_H */
