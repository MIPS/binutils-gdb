/* nanoMIPS ELF support for BFD.
   Copyright (C) 2017 Free Software Foundation, Inc.
   Contributed by Imagination Technologies Ltd.

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

/* This file holds definitions specific to the MIPS ELF ABI.  Note
   that most of this is not actually implemented by BFD.  */

#ifndef _ELF_NANOMIPS_H
#define _ELF_NANOMIPS_H

#include "elf/reloc-macros.h"

/* nanoMIPS numbers partially overlap MIPS.  */
START_RELOC_NUMBERS (elf_nanomips_reloc_type)
  RELOC_NUMBER (R_NANOMIPS_NONE, 0)
  RELOC_NUMBER (R_NANOMIPS_32, 1)
  RELOC_NUMBER (R_NANOMIPS_64, 2)
  RELOC_NUMBER (R_NANOMIPS_NEG, 3)
  RELOC_NUMBER (R_NANOMIPS_ASHIFTR_1, 4)
  RELOC_NUMBER (R_NANOMIPS_UNSIGNED_8, 5)
  RELOC_NUMBER (R_NANOMIPS_SIGNED_8, 6)
  RELOC_NUMBER (R_NANOMIPS_UNSIGNED_16, 7)
  RELOC_NUMBER (R_NANOMIPS_SIGNED_16, 8)
  RELOC_NUMBER (R_NANOMIPS_RELATIVE, 9)
  RELOC_NUMBER (R_NANOMIPS_GLOBAL, 10)
  RELOC_NUMBER (R_NANOMIPS_JUMP_SLOT, 11)
  RELOC_NUMBER (R_NANOMIPS_IRELATIVE, 12)

  RELOC_NUMBER (R_NANOMIPS_PC25_S1, 13)
  RELOC_NUMBER (R_NANOMIPS_PC21_S1, 14)
  RELOC_NUMBER (R_NANOMIPS_PC14_S1, 15)
  RELOC_NUMBER (R_NANOMIPS_PC11_S1, 16)
  RELOC_NUMBER (R_NANOMIPS_PC10_S1, 17)
  RELOC_NUMBER (R_NANOMIPS_PC7_S1, 18)
  RELOC_NUMBER (R_NANOMIPS_PC4_S1, 19)

  RELOC_NUMBER (R_NANOMIPS_GPREL19_S2, 20)
  RELOC_NUMBER (R_NANOMIPS_GPREL18_S3, 21)
  RELOC_NUMBER (R_NANOMIPS_GPREL18, 22)
  RELOC_NUMBER (R_NANOMIPS_GPREL17_S1, 23)
  RELOC_NUMBER (R_NANOMIPS_GPREL16_S2, 24)
  RELOC_NUMBER (R_NANOMIPS_GPREL7_S2, 25)
  RELOC_NUMBER (R_NANOMIPS_GPREL_HI20, 26)
  RELOC_NUMBER (R_NANOMIPS_PCHI20, 27)

  RELOC_NUMBER (R_NANOMIPS_HI20, 28)
  RELOC_NUMBER (R_NANOMIPS_LO12, 29)
  RELOC_NUMBER (R_NANOMIPS_GPREL_I32, 30)
  RELOC_NUMBER (R_NANOMIPS_PC_I32, 31)
  RELOC_NUMBER (R_NANOMIPS_I32, 32)
  RELOC_NUMBER (R_NANOMIPS_GOT_DISP, 33)
  RELOC_NUMBER (R_NANOMIPS_GOTPC_I32, 34)
  RELOC_NUMBER (R_NANOMIPS_GOTPC_HI20, 35)
  RELOC_NUMBER (R_NANOMIPS_GOT_LO12, 36)
  RELOC_NUMBER (R_NANOMIPS_CALL, 37)
  RELOC_NUMBER (R_NANOMIPS_GOT_PAGE, 38)
  RELOC_NUMBER (R_NANOMIPS_GOT_OFST, 39)

  RELOC_NUMBER (R_NANOMIPS_SCN_DISP, 40)
  RELOC_NUMBER (R_NANOMIPS_HI32, 41)
 
  RELOC_NUMBER (R_NANOMIPS_ALIGN, 64)
  RELOC_NUMBER (R_NANOMIPS_FILL, 65)
  RELOC_NUMBER (R_NANOMIPS_MAX, 66)
  RELOC_NUMBER (R_NANOMIPS_INSN32, 67)
  RELOC_NUMBER (R_NANOMIPS_FIXED, 68)
  RELOC_NUMBER (R_NANOMIPS_NORELAX, 69)
  RELOC_NUMBER (R_NANOMIPS_RELAX, 70)
  RELOC_NUMBER (R_NANOMIPS_SAVERESTORE, 71)
  RELOC_NUMBER (R_NANOMIPS_INSN16, 72)

  /* TLS relocations.  */
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPMOD32, 80)
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPREL32, 81)
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPMOD64, 82)
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPREL64, 83)
  RELOC_NUMBER (R_NANOMIPS_TLS_TPREL32, 84)
  RELOC_NUMBER (R_NANOMIPS_TLS_TPREL64, 85)
  RELOC_NUMBER (R_NANOMIPS_TLS_GD, 86)
  RELOC_NUMBER (R_NANOMIPS_TLS_LDM, 87)
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPREL_HI20, 88)
  RELOC_NUMBER (R_NANOMIPS_TLS_DTPREL_LO12, 89)
  RELOC_NUMBER (R_NANOMIPS_TLS_GOTTPREL, 90)
  RELOC_NUMBER (R_NANOMIPS_TLS_TPREL_HI20, 91)
  RELOC_NUMBER (R_NANOMIPS_TLS_TPREL_LO12, 92)
  RELOC_NUMBER (R_NANOMIPS_LITERAL, 93)

  FAKE_RELOC (R_NANOMIPS_max, 93)
  /* This was a GNU extension used by embedded-PIC.  It was co-opted by
     mips-linux for exception-handling data.  GCC stopped using it in
     May, 2004, then started using it again for compact unwind tables.  */
  RELOC_NUMBER (R_NANOMIPS_EH, 249)
  /* FIXME: this relocation is used internally by gas.  */
  RELOC_NUMBER (R_NANOMIPS_GNU_REL16_S2, 250)
  /* These are GNU extensions to enable C++ vtable garbage collection.  */
  RELOC_NUMBER (R_NANOMIPS_GNU_VTINHERIT, 253)
  RELOC_NUMBER (R_NANOMIPS_GNU_VTENTRY, 254)
END_RELOC_NUMBERS (R_NANOMIPS_maxext)

/* Processor specific flags for the ELF header e_flags field.  */

/* File contains position independent code.  */
#define EF_NANOMIPS_PIC		0x00000002

/* Indicates code compiled for a 64-bit machine in 32-bit mode
   (regs are 32-bits wide).  */
#define EF_NANOMIPS_32BITMODE	0x00000100

/* 32-bit machine but FP registers are 64 bit (-mfp64).  */
#define EF_NANOMIPS_FP64		0x00000200

/* Code in file uses the IEEE 754-2008 NaN encoding convention.  */
#define EF_NANOMIPS_NAN2008		0x00000400

/* Architectural Extensions used by this file */
#define EF_NANOMIPS_ARCH_ASE	0x0f000000

/* Four bit MIPS architecture field.  */
#define EF_NANOMIPS_ARCH		0xf0000000

/* -mnanomips32r6 code.  */
#define E_NANOMIPS_ARCH_32R6        0xb0000000

/* -mnanomips64r6 code.  */
#define E_NANOMIPS_ARCH_64R6        0xc0000000

/* The ABI of the file.  Also see EF_NANOMIPS_ABI2 above. */
#define EF_NANOMIPS_ABI		0x0000F000

/* nanoMIPS ABI in 32 bit mode */
#define E_NANOMIPS_ABI_P32       0x00005000

/* nanoMIPS ABI in 64 bit mode */
#define E_NANOMIPS_ABI_P64       0x00006000

/* Machine variant if we know it.  This field was invented at Cygnus,
   but it is hoped that other vendors will adopt it.  If some standard
   is developed, this code should be changed to follow it. */

#define EF_NANOMIPS_MACH		0x00FF0000

/* Cygnus is choosing values between 80 and 9F;
   00 - 7F should be left for a future standard;
   the rest are open. */


/* Processor specific section types.  */

/* Section contains the global pointer table.  */
#define SHT_NANOMIPS_GPTAB		0x70000003

/* Section contains register usage information.  */
#define SHT_NANOMIPS_REGINFO	0x70000006
/* Section contains miscellaneous options.  */
#define SHT_NANOMIPS_OPTIONS	0x7000000d

/* DWARF debugging section.  */
#define SHT_NANOMIPS_DWARF		0x7000001e

/* ABI related flags section.  */
#define SHT_NANOMIPS_ABIFLAGS	0x7000002a

/* Processor specific section flags.  */

/* This section must be in the global data area.  */
#define SHF_NANOMIPS_GPREL		0x10000000

/* This section contains address data of size implied by section
   element size.  */
#define SHF_NANOMIPS_ADDR		0x40000000

/* This section may not be stripped.  */
#define SHF_NANOMIPS_NOSTRIP	0x08000000


/* Processor specific program header types.  */

/* .MIPS.options section.  */
#define PT_NANOMIPS_OPTIONS		0x70000002

/* Records ABI related flags.  */
#define PT_NANOMIPS_ABIFLAGS	0x70000003

/* Processor specific dynamic array tags.  */

/* Time stamp.  */
#define DT_NANOMIPS_TIME_STAMP	0x70000002

/* Number of local global offset table entries.  */
#define DT_NANOMIPS_LOCAL_GOTNO	0x7000000a

/* Number of entries in the .dynsym section.  */
#define DT_NANOMIPS_SYMTABNO	0x70000011

/* Index of first dynamic symbol in global offset table.  */
#define DT_NANOMIPS_GOTSYM		0x70000013

/* Address of `.MIPS.options'.  */
#define DT_NANOMIPS_OPTIONS		0x70000029

/* Address of the base of the PLTGOT.  */
#define DT_NANOMIPS_PLTGOT         0x70000032


/* The 64-bit MIPS ELF ABI uses an unusual reloc format.  Each
   relocation entry specifies up to three actual relocations, all at
   the same address.  The first relocation which required a symbol
   uses the symbol in the r_sym field.  The second relocation which
   requires a symbol uses the symbol in the r_ssym field.  If all
   three relocations require a symbol, the third one uses a zero
   value.  */

/* MIPS ELF 64 relocation info access macros.  */
#define ELF64_NANOMIPS_R_SSYM(i) (((i) >> 24) & 0xff)
#define ELF64_NANOMIPS_R_TYPE(i) ((i) & 0xff)



/* Object attribute tags.  */
enum
{
  /* 0-3 are generic.  */

  /* Floating-point ABI used by this object file.  */
  Tag_GNU_NANOMIPS_ABI_FP = 4,

  /* MSA ABI used by this object file.  */
  Tag_GNU_NANOMIPS_ABI_MSA = 8,
};

/* Object attribute values.  */
enum
{
  /* Values defined for Tag_GNU_NANOMIPS_ABI_FP.  */

  /* Not tagged or not using any ABIs affected by the differences.  */
  Val_GNU_NANOMIPS_ABI_FP_ANY = 0,

  /* Using hard-float -mdouble-float.  */
  Val_GNU_NANOMIPS_ABI_FP_DOUBLE = 1,

  /* Using hard-float -msingle-float.  */
  Val_GNU_NANOMIPS_ABI_FP_SINGLE = 2,

  /* Using soft-float.  */
  Val_GNU_NANOMIPS_ABI_FP_SOFT = 3,

  /* Using -mips32r2 -mfp64.  */
  Val_GNU_NANOMIPS_ABI_FP_OLD_64 = 4,

  /* Using -mfpxx */
  Val_GNU_NANOMIPS_ABI_FP_XX = 5,

  /* Using -mips32r2 -mfp64.  */
  Val_GNU_NANOMIPS_ABI_FP_64 = 6,

  /* Using -mips32r2 -mfp64 -mno-odd-spreg.  */
  Val_GNU_NANOMIPS_ABI_FP_64A = 7,

  /* Values defined for Tag_GNU_NANOMIPS_ABI_MSA.  */

  /* Not tagged or not using any ABIs affected by the differences.  */
  Val_GNU_NANOMIPS_ABI_MSA_ANY = 0,

  /* Using 128-bit MSA.  */
  Val_GNU_NANOMIPS_ABI_MSA_128 = 1,
};

#define BFD_RELOC_NANOMIPS_ALIGN 	BFD_RELOC_MICROMIPS_ALIGN
#define BFD_RELOC_NANOMIPS_FILL 	BFD_RELOC_MICROMIPS_FILL
#define BFD_RELOC_NANOMIPS_MAX 		BFD_RELOC_MICROMIPS_MAX
#define BFD_RELOC_NANOMIPS_INSN32 	BFD_RELOC_MICROMIPS_INSN32
#define BFD_RELOC_NANOMIPS_INSN16 	BFD_RELOC_MICROMIPS_INSN16
#define BFD_RELOC_NANOMIPS_FIXED 	BFD_RELOC_MICROMIPS_FIXED
#define BFD_RELOC_NANOMIPS_RELAX 	BFD_RELOC_MICROMIPS_RELAX
#define BFD_RELOC_NANOMIPS_NORELAX 	BFD_RELOC_MICROMIPS_NORELAX
#endif /* _ELF_NANOMIPS_H */
