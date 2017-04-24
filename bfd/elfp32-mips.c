/* MIPS-specific support for 32-bit ELF
   Copyright (C) 1993-2014 Free Software Foundation, Inc.

   Most of the information added by Ian Lance Taylor, Cygnus Support,
   <ian@cygnus.com>.
   N32/64 ABI support added by Mark Mitchell, CodeSourcery, LLC.
   <mark@codesourcery.com>
   Traditional MIPS targets support added by Koundinya.K, Dansk Data
   Elektronik & Operations Research Group. <kk@ddeorg.soft.net>

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


/* This file handles MIPS ELF targets.  SGI Irix 5 uses a slightly
   different MIPS ELF from other targets.  This matters when linking.
   This file supports both, switching at runtime.  */

#include "sysdep.h"
#include "bfd.h"
#include "libbfd.h"
#include "bfdlink.h"
#include "genlink.h"
#include "elf-bfd.h"
#include "elfxx-mips.h"
#include "elf/mips.h"
#include "elf-vxworks.h"

/* Get the ECOFF swapping routines.  */
#include "coff/sym.h"
#include "coff/symconst.h"
#include "coff/internal.h"
#include "coff/ecoff.h"
#include "coff/mips.h"
#define ECOFF_SIGNED_32
#include "ecoffswap.h"

static bfd_reloc_status_type gprel32_with_gp
  (bfd *, asymbol *, arelent *, asection *, bfd_boolean, void *, bfd_vma);
static bfd_reloc_status_type mips_elf_gprel32_reloc
  (bfd *, arelent *, asymbol *, void *, asection *, bfd *, char **);
static bfd_reloc_status_type mips32_64bit_reloc
  (bfd *, arelent *, asymbol *, void *, asection *, bfd *, char **);
static reloc_howto_type *bfd_elf32_bfd_reloc_type_lookup
  (bfd *, bfd_reloc_code_real_type);
static reloc_howto_type *mips_elf32_rtype_to_howto
  (unsigned int, bfd_boolean);
static void mips_info_to_howto_rel
  (bfd *, arelent *, Elf_Internal_Rela *);
static void mips_info_to_howto_rela
  (bfd *, arelent *, Elf_Internal_Rela *);
static bfd_boolean mips_elf_sym_is_global
  (bfd *, asymbol *);
static bfd_boolean mips_elf_p32_object_p
  (bfd *);
static bfd_boolean mips_elf_is_local_label_name
  (bfd *, const char *);
static bfd_reloc_status_type mips_elf_final_gp
  (bfd *, asymbol *, bfd_boolean, char **, bfd_vma *);
static bfd_boolean mips_elf_assign_gp
  (bfd *, bfd_vma *);
static bfd_boolean elf32_mips_grok_prstatus
  (bfd *, Elf_Internal_Note *);
static bfd_boolean elf32_mips_grok_psinfo
  (bfd *, Elf_Internal_Note *);
static irix_compat_t elf32_mips_irix_compat
  (bfd *);

/* Nonzero if ABFD is using the P32 ABI.  */
#define ABI_P32_P(abfd) \
  ((elf_elfheader (abfd)->e_flags & E_MIPS_ABI_P32) == E_MIPS_ABI_P32)

/* Whether we are trying to be compatible with IRIX at all.  */
#define SGI_COMPAT(abfd) \
  (elf32_mips_irix_compat (abfd) != ict_none)

/* The number of local .got entries we reserve.  */
#define MIPS_RESERVED_GOTNO (2)

/* In case we're on a 32-bit machine, construct a 64-bit "-1" value
   from smaller values.  Start with zero, widen, *then* decrement.  */
#define MINUS_ONE	(((bfd_vma)0) - 1)

/* The relocation table used for SHT_RELA sections.  */

static reloc_howto_type elf_mips_howto_table_rela[] =
{
  /* No relocation.  */
  HOWTO (R_MIPS_NONE,		/* type */
	 0,			/* rightshift */
	 0,			/* size (0 = byte, 1 = short, 2 = long) */
	 0,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_NONE",		/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0,			/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* 16 bit relocation.  */
  HOWTO (R_MIPS_16,		/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 16,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_16",		/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* 32 bit relocation.  */
  HOWTO (R_MIPS_32,		/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_32",		/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (3),
  EMPTY_HOWTO (4),
  EMPTY_HOWTO (5),
  EMPTY_HOWTO (6),
  EMPTY_HOWTO (7),
  EMPTY_HOWTO (8),
  EMPTY_HOWTO (9),
  EMPTY_HOWTO (10),
  EMPTY_HOWTO (11),
  EMPTY_HOWTO (12),
  EMPTY_HOWTO (13),
  EMPTY_HOWTO (14),
  EMPTY_HOWTO (15),
  EMPTY_HOWTO (16),
  EMPTY_HOWTO (17),

  /* 64 bit relocation.  */
  HOWTO (R_MIPS_64,		/* type */
	 0,			/* rightshift */
	 4,			/* size (0 = byte, 1 = short, 2 = long) */
	 64,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc,	/* special_function */
	 "R_MIPS_64",		/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 MINUS_ONE,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (19),
  EMPTY_HOWTO (20),
  EMPTY_HOWTO (21),
  EMPTY_HOWTO (22),
  EMPTY_HOWTO (23),

  /* 64 bit subtraction.  */
  HOWTO (R_MIPS_SUB,		/* type */
	 0,			/* rightshift */
	 4,			/* size (0 = byte, 1 = short, 2 = long) */
	 64,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_SUB",		/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 MINUS_ONE,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (25),
  EMPTY_HOWTO (26),
  EMPTY_HOWTO (27),
  EMPTY_HOWTO (28),
  EMPTY_HOWTO (29),
  EMPTY_HOWTO (30),
  EMPTY_HOWTO (31),
  EMPTY_HOWTO (32),
  EMPTY_HOWTO (33),
  EMPTY_HOWTO (34),
  EMPTY_HOWTO (35),
  EMPTY_HOWTO (36),
  EMPTY_HOWTO (37),

  /* TLS GD/LD dynamic relocations.  */
  HOWTO (R_MIPS_TLS_DTPMOD32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_TLS_DTPMOD32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MIPS_TLS_DTPREL32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_TLS_DTPREL32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (R_MIPS_TLS_DTPMOD64),
  EMPTY_HOWTO (R_MIPS_TLS_DTPREL64),
  EMPTY_HOWTO (42),
  EMPTY_HOWTO (43),
  EMPTY_HOWTO (44),
  EMPTY_HOWTO (45),
  EMPTY_HOWTO (46),

  /* TLS IE dynamic relocations.  */
  HOWTO (R_MIPS_TLS_TPREL32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_TLS_TPREL32",	/* name */
	 TRUE,			/* partial_inplace */
	 0xffffffff,		/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (R_MIPS_TLS_TPREL64),
  EMPTY_HOWTO (49),
  EMPTY_HOWTO (50),
  EMPTY_HOWTO (51),
  EMPTY_HOWTO (52),
  EMPTY_HOWTO (53),
  EMPTY_HOWTO (54),
  EMPTY_HOWTO (55),
  EMPTY_HOWTO (56),
  EMPTY_HOWTO (57),
  EMPTY_HOWTO (58),
  EMPTY_HOWTO (59),
  EMPTY_HOWTO (60),
  EMPTY_HOWTO (61),
  EMPTY_HOWTO (62),
  EMPTY_HOWTO (63),
  EMPTY_HOWTO (64),
  EMPTY_HOWTO (65),

  /* A 5 bit shift field.  */
  HOWTO (R_MIPS_ASHIFTR_1,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_ASHIFTR_1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MIPS_UNSIGNED_8,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 8,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_UNSIGNED_8",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xff,			/* dst_mask */
	 FALSE),		/* pcrel_offset */


  HOWTO (R_MIPS_UNSIGNED_16,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 16,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_UNSIGNED_16",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MIPS_SIGNED_8,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 8,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_SIGNED_8",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xff,			/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MIPS_SIGNED_16,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 16,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_SIGNED_16",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */
};

static reloc_howto_type elf_micromips_howto_table_rela[] =
{
#ifdef RELOC_REUSE_MICROMIPSPP
  EMPTY_HOWTO (130),
  EMPTY_HOWTO (131),
  EMPTY_HOWTO (132),
  EMPTY_HOWTO (133),
#endif /* RELOC_REUSE_MICROMIPSPP */

  /* High 20 bits of symbol value.  */
  HOWTO (R_MICROMIPSPP_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_HI20",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Low 12 bits of symbol value.  */
  HOWTO (R_MICROMIPSPP_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_LO12",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (184),

#ifdef RELOC_REUSE_MICROMIPSPP
  /* Reference to literal section.  */
  HOWTO (R_MICROMIPSPP_LITERAL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf32_generic_reloc, /* special_function */
	 "R_MICROMIPS_LITERAL",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Refers to low 32-bits of 48-bit instruction. The 32-bit value
     is encoded as microMIPS instruction stream - so it will be
     half-word swapped on little endian targets.  */
  HOWTO (R_MICROMIPSPP_32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_32",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

#endif /* RELOC_REUSE_MICROMIPSPP */

  /* This is for microMIPS branches.  */
  HOWTO (R_MICROMIPSPP_PC7_S1,	/* type */
	 1,			/* rightshift */
	 1,			/* size (0 = byte, 1 = short, 2 = long) */
	 7,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC7_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0000007f,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC10_S1,	/* type */
	 1,			/* rightshift */
	 1,			/* size (0 = byte, 1 = short, 2 = long) */
	 10,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC10_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x000003ff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PCHI20_M12, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PCHI20_M12", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

#ifdef RELOC_REUSE_MICROMIPSPP
  /* 19 bit call through global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_got16_reloc, /* special_function */
	 "R_MICROMIPS_CALL",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (143),
  EMPTY_HOWTO (144),

  /* Displacement in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_DISP, /* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_DISP", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Displacement to page pointer in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_PAGE, /* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_PAGE", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Offset from page pointer in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_OFST, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_OFST", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* High 20 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_HI20, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_HI20" , /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* Low 12 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_LO12, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 TRUE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  EMPTY_HOWTO (150),

  /* High 20 bits of GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL_HI20",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Low 12 bits of GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL_LO12",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* High 20 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL_HI20, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_CALL_HI20", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* Low 12 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL_LO12, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 TRUE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_CALL_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  EMPTY_HOWTO (155),
  EMPTY_HOWTO (156),
  EMPTY_HOWTO (157),
#endif

  HOWTO (R_MICROMIPSPP_PCHI20, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PCHI20", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PCLO12, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PCLO12", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

#ifdef RELOC_REUSE_MICROMIPSPP
  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL16_S2,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 16,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL16_S2",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0003fffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL18_S3,	/* type */
	 3,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 18,			/* bitsize */
	 FALSE,			/* pc_relative */
	 3,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL18_S3",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffff8,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS general dynamic variable reference.  */
  HOWTO (R_MICROMIPSPP_TLS_GD,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_GD",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic variable reference.  */
  HOWTO (R_MICROMIPSPP_TLS_LDM,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_LDM",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic offset.  */
  HOWTO (R_MICROMIPSPP_TLS_DTPREL_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_DTPREL_HI20",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic offset.  */
  HOWTO (R_MICROMIPSPP_TLS_DTPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_DTPREL_LO12",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_GOTTPREL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_GOTTPREL",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (167),
  EMPTY_HOWTO (168),

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_TPREL_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_TPREL_HI20", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_TPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_TPREL_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (171),
#endif /* RELOC_REUSE_MICROMIPSPP */

    /* GP- and PC-relative relocations.  */
  HOWTO (R_MICROMIPSPP_GPREL7_S2,	/* type */
	 2,			/* rightshift */
	 1,			/* size (0 = byte, 1 = short, 2 = long) */
	 7,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL7_S2",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0000007f,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC11_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 11,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC11_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x000007ff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC21_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 21,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC21_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0001ffff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC25_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 25,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC25_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x01ffffff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC14_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 14,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC14_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00003fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC20_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC20_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x000fffff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL18,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 18,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL18",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0003ffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

#ifdef RELOC_REUSE_MICROMIPSPP
  EMPTY_HOWTO (179),
#endif /* RELOC_REUSE_MICROMIPSPP */

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL19_S2,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL19_S2",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  HOWTO (R_MICROMIPSPP_PC4_S1,	/* type */
	 1,			/* rightshift */
	 1,			/* size (0 = byte, 1 = short, 2 = long) */
	 4,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC4_S1",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0000000f,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

#ifdef RELOC_REUSE_MICROMIPSPP

  /* High 32 bits of 64-bit address.  */
  HOWTO (R_MICROMIPSPP_HI32,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_HI32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

#else

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL16_S2,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 16,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL16_S2",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0003fffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL18_S3,	/* type */
	 3,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 18,			/* bitsize */
	 FALSE,			/* pc_relative */
	 3,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL18_S3",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffff8,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Reference to literal section.  */
  HOWTO (R_MICROMIPSPP_LITERAL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_LITERAL",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* 19 bit call through global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_got16_reloc, /* special_function */
	 "R_MICROMIPS_CALL",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Displacement in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_DISP, /* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_DISP", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Displacement to page pointer in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_PAGE, /* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_PAGE", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Offset from page pointer in the global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_OFST, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_OFST", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */


  /* High 20 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_HI20, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_HI20" , /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* Low 12 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_GOT_LO12, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 TRUE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GOT_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* High 20 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL_HI20, /* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_CALL_HI20", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* Low 12 bits of displacement in global offset table.  */
  HOWTO (R_MICROMIPSPP_CALL_LO12, /* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 TRUE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_CALL_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 TRUE),			/* pcrel_offset */

  /* Refers to low 32-bits of 48-bit instruction. The 32-bit value
     is encoded as microMIPS instruction stream - so it will be
     half-word swapped on little endian targets.  */
  HOWTO (R_MICROMIPSPP_32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_32",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* High 32 bits of 64-bit address.  */
  HOWTO (R_MICROMIPSPP_HI32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_HI32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* High 20 bits of GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL_HI20,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL_HI20",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* Low 12 bits of GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL_LO12",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS general dynamic variable reference.  */
  HOWTO (R_MICROMIPSPP_TLS_GD,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_GD",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic variable reference.  */
  HOWTO (R_MICROMIPSPP_TLS_LDM,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_LDM",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic offset.  */
  HOWTO (R_MICROMIPSPP_TLS_DTPREL_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_DTPREL_HI20",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS local dynamic offset.  */
  HOWTO (R_MICROMIPSPP_TLS_DTPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_DTPREL_LO12",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_GOTTPREL,	/* type */
	 2,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 19,			/* bitsize */
	 FALSE,			/* pc_relative */
	 2,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_GOTTPREL",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffc,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_TPREL_HI20,	/* type */
	 12,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 20,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_TPREL_HI20", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x001ffffd,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* TLS thread pointer offset.  */
  HOWTO (R_MICROMIPSPP_TLS_TPREL_LO12,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 12,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_TLS_TPREL_LO12", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x00000fff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  EMPTY_HOWTO (221),
  EMPTY_HOWTO (222),
  EMPTY_HOWTO (223),
  EMPTY_HOWTO (224),
  EMPTY_HOWTO (225),
  EMPTY_HOWTO (226),
  EMPTY_HOWTO (227),
  EMPTY_HOWTO (228),

  /* High 32 bits of 64-bit address.  */
  HOWTO (R_MICROMIPSPP_PC32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_PC32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* High 32 bits of 64-bit address.  */
  HOWTO (R_MICROMIPSPP_GPREL32,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL32",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0xffffffff,		/* dst_mask */
	 FALSE),		/* pcrel_offset */

  /* GP relative reference.  */
  HOWTO (R_MICROMIPSPP_GPREL17_S1,	/* type */
	 1,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 17,			/* bitsize */
	 FALSE,			/* pc_relative */
	 1,			/* bitpos */
	 complain_overflow_unsigned, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MICROMIPS_GPREL18_S3",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0x0003fffe,		/* dst_mask */
	 FALSE),		/* pcrel_offset */
#endif /* !RELOC_REUSE_MICROMIPSPP */
};

/* 32 bit pc-relative.  This was a GNU extension used by embedded-PIC.
   It was co-opted by mips-linux for exception-handling data.  It is no
   longer used, but should continue to be supported by the linker for
   backward compatibility.  (GCC stopped using it in May, 2004.)  */
static reloc_howto_type elf_mips_gnu_pcrel32 =
  HOWTO (R_MIPS_PC32,		/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 TRUE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_PC32",		/* name */
	 TRUE,			/* partial_inplace */
	 0xffffffff,		/* src_mask */
	 0xffffffff,		/* dst_mask */
	 TRUE);			/* pcrel_offset */

/* GNU extension to record C++ vtable hierarchy */
static reloc_howto_type elf_mips_gnu_vtinherit_howto =
  HOWTO (R_MIPS_GNU_VTINHERIT,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 0,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 NULL,			/* special_function */
	 "R_MIPS_GNU_VTINHERIT", /* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0,			/* dst_mask */
	 FALSE);		/* pcrel_offset */

/* GNU extension to record C++ vtable member usage */
static reloc_howto_type elf_mips_gnu_vtentry_howto =
  HOWTO (R_MIPS_GNU_VTENTRY,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 0,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_dont, /* complain_on_overflow */
	 _bfd_elf_rel_vtable_reloc_fn, /* special_function */
	 "R_MIPS_GNU_VTENTRY",	/* name */
	 FALSE,			/* partial_inplace */
	 0,			/* src_mask */
	 0,			/* dst_mask */
	 FALSE);		/* pcrel_offset */

/* Originally a VxWorks extension, but now used for other systems too.  */
static reloc_howto_type elf_mips_copy_howto =
  HOWTO (R_MIPS_COPY,		/* type */
	 0,			/* rightshift */
	 0,			/* this one is variable size */
	 0,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_bitfield, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_COPY",		/* name */
	 FALSE,			/* partial_inplace */
	 0x0,         		/* src_mask */
	 0x0,		        /* dst_mask */
	 FALSE);		/* pcrel_offset */

/* Originally a VxWorks extension, but now used for other systems too.  */
static reloc_howto_type elf_mips_jump_slot_howto =
  HOWTO (R_MIPS_JUMP_SLOT,	/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_bitfield, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_JUMP_SLOT",	/* name */
	 FALSE,			/* partial_inplace */
	 0x0,         		/* src_mask */
	 0x0,		        /* dst_mask */
	 FALSE);		/* pcrel_offset */

/* Used in EH tables.  */
static reloc_howto_type elf_mips_eh_howto =
  HOWTO (R_MIPS_EH,		/* type */
	 0,			/* rightshift */
	 2,			/* size (0 = byte, 1 = short, 2 = long) */
	 32,			/* bitsize */
	 FALSE,			/* pc_relative */
	 0,			/* bitpos */
	 complain_overflow_signed, /* complain_on_overflow */
	 _bfd_mips_elf_generic_reloc, /* special_function */
	 "R_MIPS_EH",		/* name */
	 TRUE,			/* partial_inplace */
	 0xffffffff,		/* src_mask */
	 0xffffffff,	        /* dst_mask */
	 FALSE);		/* pcrel_offset */

/* Set the GP value for OUTPUT_BFD.  Returns FALSE if this is a
   dangerous relocation.  */

static bfd_boolean
mips_elf_assign_gp (bfd *output_bfd, bfd_vma *pgp)
{
  unsigned int count;
  asymbol **sym;
  unsigned int i;

  /* If we've already figured out what GP will be, just return it.  */
  *pgp = _bfd_get_gp_value (output_bfd);
  if (*pgp)
    return TRUE;

  count = bfd_get_symcount (output_bfd);
  sym = bfd_get_outsymbols (output_bfd);

  /* The linker script will have created a symbol named `_gp' with the
     appropriate value.  */
  if (sym == NULL)
    i = count;
  else
    {
      for (i = 0; i < count; i++, sym++)
	{
	  register const char *name;

	  name = bfd_asymbol_name (*sym);
	  if (*name == '_' && strcmp (name, "_gp") == 0)
	    {
	      *pgp = bfd_asymbol_value (*sym);
	      _bfd_set_gp_value (output_bfd, *pgp);
	      break;
	    }
	}
    }

  if (i >= count)
    {
      /* Only get the error once.  */
      *pgp = 4;
      _bfd_set_gp_value (output_bfd, *pgp);
      return FALSE;
    }

  return TRUE;
}

/* We have to figure out the gp value, so that we can adjust the
   symbol value correctly.  We look up the symbol _gp in the output
   BFD.  If we can't find it, we're stuck.  We cache it in the ELF
   target data.  We don't need to adjust the symbol value for an
   external symbol if we are producing relocatable output.  */

static bfd_reloc_status_type
mips_elf_final_gp (bfd *output_bfd, asymbol *symbol, bfd_boolean relocatable,
		   char **error_message, bfd_vma *pgp)
{
  if (bfd_is_und_section (symbol->section)
      && ! relocatable)
    {
      *pgp = 0;
      return bfd_reloc_undefined;
    }

  *pgp = _bfd_get_gp_value (output_bfd);
  if (*pgp == 0
      && (! relocatable
	  || (symbol->flags & BSF_SECTION_SYM) != 0))
    {
      if (relocatable)
	{
	  /* Make up a value.  */
	  *pgp = symbol->section->output_section->vma /*+ 0x4000*/;
	  _bfd_set_gp_value (output_bfd, *pgp);
	}
      else if (!mips_elf_assign_gp (output_bfd, pgp))
	{
	  *error_message =
	    (char *) _("GP relative relocation when _gp not defined");
	  return bfd_reloc_dangerous;
	}
    }

  return bfd_reloc_ok;
}

/* Do a R_MIPS_GPREL16 relocation.  This is a 16 bit value which must
   become the offset from the gp register.  This function also handles
   R_MIPS_LITERAL relocations, although those can be handled more
   cleverly because the entries in the .lit8 and .lit4 sections can be
   merged.  */

bfd_reloc_status_type
_bfd_mips_elf32_gprel16_reloc (bfd *abfd, arelent *reloc_entry,
			       asymbol *symbol, void *data,
			       asection *input_section, bfd *output_bfd,
			       char **error_message)
{
  bfd_boolean relocatable;
  bfd_reloc_status_type ret;
  bfd_byte *location;
  bfd_vma gp;

  /* R_MIPS_LITERAL/R_MICROMIPS_LITERAL relocations are defined for local
     symbols only.  */
  if (literal_reloc_p (reloc_entry->howto->type)
      && output_bfd != NULL
      && (symbol->flags & BSF_SECTION_SYM) == 0
      && (symbol->flags & BSF_LOCAL) != 0)
    {
      *error_message = (char *)
	_("literal relocation occurs for an external symbol");
      return bfd_reloc_outofrange;
    }

  if (output_bfd != NULL)
    relocatable = TRUE;
  else
    {
      relocatable = FALSE;
      output_bfd = symbol->section->output_section->owner;
    }

  ret = mips_elf_final_gp (output_bfd, symbol, relocatable, error_message,
			   &gp);
  if (ret != bfd_reloc_ok)
    return ret;

  location = (bfd_byte *) data + reloc_entry->address;
  _bfd_mips_elf_reloc_unshuffle (abfd, reloc_entry->howto->type, FALSE,
				 location);
  ret = _bfd_mips_elf_gprel16_with_gp (abfd, symbol, reloc_entry,
				       input_section, relocatable,
				       data, gp);
  _bfd_mips_elf_reloc_shuffle (abfd, reloc_entry->howto->type, !relocatable,
			       location);

  return ret;
}

/* Do a R_MIPS_GPREL32 relocation.  This is a 32 bit value which must
   become the offset from the gp register.  */

static bfd_reloc_status_type
mips_elf_gprel32_reloc (bfd *abfd, arelent *reloc_entry, asymbol *symbol,
			void *data, asection *input_section, bfd *output_bfd,
			char **error_message)
{
  bfd_boolean relocatable;
  bfd_reloc_status_type ret;
  bfd_vma gp;

  /* R_MIPS_GPREL32 relocations are defined for local symbols only.  */
  if (output_bfd != NULL
      && (symbol->flags & BSF_SECTION_SYM) == 0
      && (symbol->flags & BSF_LOCAL) != 0)
    {
      *error_message = (char *)
	_("32bits gp relative relocation occurs for an external symbol");
      return bfd_reloc_outofrange;
    }

  if (output_bfd != NULL)
    relocatable = TRUE;
  else
    {
      relocatable = FALSE;
      output_bfd = symbol->section->output_section->owner;
    }

  ret = mips_elf_final_gp (output_bfd, symbol, relocatable,
			   error_message, &gp);
  if (ret != bfd_reloc_ok)
    return ret;

  return gprel32_with_gp (abfd, symbol, reloc_entry, input_section,
			  relocatable, data, gp);
}

static bfd_reloc_status_type
gprel32_with_gp (bfd *abfd, asymbol *symbol, arelent *reloc_entry,
		 asection *input_section, bfd_boolean relocatable,
		 void *data, bfd_vma gp)
{
  bfd_vma relocation;
  bfd_vma val;

  if (bfd_is_com_section (symbol->section))
    relocation = 0;
  else
    relocation = symbol->value;

  relocation += symbol->section->output_section->vma;
  relocation += symbol->section->output_offset;

  if (reloc_entry->address > bfd_get_section_limit (abfd, input_section))
    return bfd_reloc_outofrange;

  /* Set val to the offset into the section or symbol.  */
  val = reloc_entry->addend;

  if (reloc_entry->howto->partial_inplace)
    val += bfd_get_32 (abfd, (bfd_byte *) data + reloc_entry->address);

  /* Adjust val for the final section location and GP value.  If we
     are producing relocatable output, we don't want to do this for
     an external symbol.  */
  if (! relocatable
      || (symbol->flags & BSF_SECTION_SYM) != 0)
    val += relocation - gp;

  if (reloc_entry->howto->partial_inplace)
    bfd_put_32 (abfd, val, (bfd_byte *) data + reloc_entry->address);
  else
    reloc_entry->addend = val;

  if (relocatable)
    reloc_entry->address += input_section->output_offset;

  return bfd_reloc_ok;
}

/* Handle a 64 bit reloc in a 32 bit MIPS ELF file.  These are
   generated when addresses are 64 bits.  The upper 32 bits are a simple
   sign extension.  */

static bfd_reloc_status_type
mips32_64bit_reloc (bfd *abfd, arelent *reloc_entry,
		    asymbol *symbol ATTRIBUTE_UNUSED,
		    void *data, asection *input_section,
		    bfd *output_bfd, char **error_message)
{
  bfd_reloc_status_type r;
  arelent reloc32;
  unsigned long val;
  bfd_size_type addr;

  /* Do a normal 32 bit relocation on the lower 32 bits.  */
  reloc32 = *reloc_entry;
  if (bfd_big_endian (abfd))
    reloc32.address += 4;
  reloc32.howto = &elf_mips_howto_table_rela[R_MIPS_32];
  r = bfd_perform_relocation (abfd, &reloc32, data, input_section,
			      output_bfd, error_message);

  /* Sign extend into the upper 32 bits.  */
  val = bfd_get_32 (abfd, (bfd_byte *) data + reloc32.address);
  if ((val & 0x80000000) != 0)
    val = 0xffffffff;
  else
    val = 0;
  addr = reloc_entry->address;
  if (bfd_little_endian (abfd))
    addr += 4;
  bfd_put_32 (abfd, val, (bfd_byte *) data + addr);

  return r;
}

/* A mapping from BFD reloc types to MIPS ELF reloc types.  */

struct elf_reloc_map {
  bfd_reloc_code_real_type bfd_val;
  enum elf_mips_reloc_type elf_val;
};

static const struct elf_reloc_map mips_reloc_map[] =
{
  { BFD_RELOC_NONE, R_MIPS_NONE },
  { BFD_RELOC_16, R_MIPS_16 },
  { BFD_RELOC_32, R_MIPS_32 },
  { BFD_RELOC_64, R_MIPS_64 },
  { BFD_RELOC_MIPS_SUB, R_MIPS_SUB },
  { BFD_RELOC_MIPS_TLS_DTPMOD32, R_MIPS_TLS_DTPMOD32 },
  { BFD_RELOC_MIPS_TLS_DTPREL32, R_MIPS_TLS_DTPREL32 },
  { BFD_RELOC_MIPS_TLS_DTPMOD64, R_MIPS_TLS_DTPMOD64 },
  { BFD_RELOC_MIPS_TLS_DTPREL64, R_MIPS_TLS_DTPREL64 },
  { BFD_RELOC_MIPS_TLS_TPREL32, R_MIPS_TLS_TPREL32 },
  { BFD_RELOC_MIPS_TLS_TPREL64, R_MIPS_TLS_TPREL64 },
  { BFD_RELOC_MIPS_UNSIGNED_8, R_MIPS_UNSIGNED_8 },
  { BFD_RELOC_MIPS_UNSIGNED_16, R_MIPS_UNSIGNED_16 },
  { BFD_RELOC_MIPS_ASHIFTR_1, R_MIPS_ASHIFTR_1 },
  { BFD_RELOC_MIPS_SIGNED_8, R_MIPS_SIGNED_8 },
  { BFD_RELOC_MIPS_SIGNED_16, R_MIPS_SIGNED_16 },
};

static const struct elf_reloc_map micromipspp_reloc_map[] =
{
  { BFD_RELOC_MICROMIPSPP_HI20, R_MICROMIPSPP_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_LO12, R_MICROMIPSPP_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_IMM16, R_MICROMIPSPP_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_7_PCREL_S1,
    R_MICROMIPSPP_PC7_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_10_PCREL_S1,
    R_MICROMIPSPP_PC10_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_21_PCREL_S1,
    R_MICROMIPSPP_PC21_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_25_PCREL_S1,
    R_MICROMIPSPP_PC25_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_14_PCREL_S1,
    R_MICROMIPSPP_PC14_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_20_PCREL_S1,
    R_MICROMIPSPP_PC20_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL7_S2,
    R_MICROMIPSPP_GPREL7_S2 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_11_PCREL_S1,
    R_MICROMIPSPP_PC11_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL18, R_MICROMIPSPP_GPREL18 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL19_S2,
    R_MICROMIPSPP_GPREL19_S2 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_4_PCREL_S1,
    R_MICROMIPSPP_PC4_S1 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_HI20_PCREL_M12,
    R_MICROMIPSPP_PCHI20_M12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_HI20_PCREL,
    R_MICROMIPSPP_PCHI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_LO12_PCREL,
    R_MICROMIPSPP_PCLO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL16_S2,
    R_MICROMIPSPP_GPREL16_S2 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL18_S3,
    R_MICROMIPSPP_GPREL18_S3 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_CALL,
    R_MICROMIPSPP_CALL - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GOT_DISP,
    R_MICROMIPSPP_GOT_DISP - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GOT_PAGE,
    R_MICROMIPSPP_GOT_PAGE - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GOT_OFST,
    R_MICROMIPSPP_GOT_OFST - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GOT_HI20,
    R_MICROMIPSPP_GOT_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GOT_LO12,
    R_MICROMIPSPP_GOT_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_CALL_HI20,
    R_MICROMIPSPP_CALL_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_CALL_LO12,
    R_MICROMIPSPP_CALL_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_LITERAL,
    R_MICROMIPSPP_LITERAL - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_32,
    R_MICROMIPSPP_32 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL_HI20,
    R_MICROMIPSPP_GPREL_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL_LO12,
    R_MICROMIPSPP_GPREL_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_GD, R_MICROMIPSPP_TLS_GD - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_LDM, R_MICROMIPSPP_TLS_LDM - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_DTPREL_HI20,
    R_MICROMIPSPP_TLS_DTPREL_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_DTPREL_LO12,
    R_MICROMIPSPP_TLS_DTPREL_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_GOTTPREL,
    R_MICROMIPSPP_TLS_GOTTPREL - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_TPREL_HI20,
    R_MICROMIPSPP_TLS_TPREL_HI20 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_TLS_TPREL_LO12,
    R_MICROMIPSPP_TLS_TPREL_LO12 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_HI32, R_MICROMIPSPP_HI32 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_PC32, R_MICROMIPSPP_PC32 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL32, R_MICROMIPSPP_GPREL32 - R_MICROMIPSPP_min },
  { BFD_RELOC_MICROMIPSPP_GPREL17_S1,
    R_MICROMIPSPP_GPREL17_S1 - R_MICROMIPSPP_min },
};

/* Given a BFD reloc type, return a howto structure.  */

static reloc_howto_type *
bfd_elf32_bfd_reloc_type_lookup (bfd *abfd ATTRIBUTE_UNUSED,
				 bfd_reloc_code_real_type code)
{
  unsigned int i;
  reloc_howto_type *howto_table;
  reloc_howto_type *howto_micromips_table;

  howto_table = elf_mips_howto_table_rela;
  howto_micromips_table = elf_micromips_howto_table_rela;

  for (i = 0; i < sizeof (mips_reloc_map) / sizeof (struct elf_reloc_map);
       i++)
    {
      if (mips_reloc_map[i].bfd_val == code)
	return &howto_table[(int) mips_reloc_map[i].elf_val];
    }

  for (i = 0; i < sizeof (micromipspp_reloc_map) / sizeof (struct elf_reloc_map);
       i++)
    {
      if (micromipspp_reloc_map[i].bfd_val == code)
	return &howto_micromips_table[(int) micromipspp_reloc_map[i].elf_val];
    }

  switch (code)
    {
    default:
      bfd_set_error (bfd_error_bad_value);
      return NULL;

    case BFD_RELOC_CTOR:
      return &howto_table[(int) R_MIPS_32];

    case BFD_RELOC_VTABLE_INHERIT:
      return &elf_mips_gnu_vtinherit_howto;
    case BFD_RELOC_VTABLE_ENTRY:
      return &elf_mips_gnu_vtentry_howto;
    case BFD_RELOC_32_PCREL:
      return &elf_mips_gnu_pcrel32;
    case BFD_RELOC_MIPS_COPY:
      return &elf_mips_copy_howto;
    case BFD_RELOC_MIPS_JUMP_SLOT:
      return &elf_mips_jump_slot_howto;
    case BFD_RELOC_MIPS_EH:
      return &elf_mips_eh_howto;
    }
}

static reloc_howto_type *
bfd_elf32_bfd_reloc_name_lookup (bfd *abfd ATTRIBUTE_UNUSED,
				 const char *r_name)
{
  unsigned int i;

  for (i = 0;
       i < (sizeof (elf_mips_howto_table_rela)
	    / sizeof (elf_mips_howto_table_rela[0]));
       i++)
    if (elf_mips_howto_table_rela[i].name != NULL
	&& strcasecmp (elf_mips_howto_table_rela[i].name, r_name) == 0)
      return &elf_mips_howto_table_rela[i];

  for (i = 0;
       i < (sizeof (elf_micromips_howto_table_rela)
	    / sizeof (elf_micromips_howto_table_rela[0]));
       i++)
    if (elf_micromips_howto_table_rela[i].name != NULL
	&& strcasecmp (elf_micromips_howto_table_rela[i].name, r_name) == 0)
      return &elf_micromips_howto_table_rela[i];

  if (strcasecmp (elf_mips_gnu_pcrel32.name, r_name) == 0)
    return &elf_mips_gnu_pcrel32;
  if (strcasecmp (elf_mips_gnu_vtinherit_howto.name, r_name) == 0)
    return &elf_mips_gnu_vtinherit_howto;
  if (strcasecmp (elf_mips_gnu_vtentry_howto.name, r_name) == 0)
    return &elf_mips_gnu_vtentry_howto;
  if (strcasecmp (elf_mips_copy_howto.name, r_name) == 0)
    return &elf_mips_copy_howto;
  if (strcasecmp (elf_mips_jump_slot_howto.name, r_name) == 0)
    return &elf_mips_jump_slot_howto;
  if (strcasecmp (elf_mips_eh_howto.name, r_name) == 0)
    return &elf_mips_eh_howto;

  return NULL;
}

/* Given a MIPS Elf_Internal_Rel, fill in an arelent structure.  */

static reloc_howto_type *
mips_elf32_rtype_to_howto (unsigned int r_type,
			   bfd_boolean rela_p ATTRIBUTE_UNUSED)
{
  switch (r_type)
    {
    case R_MIPS_GNU_VTINHERIT:
      return &elf_mips_gnu_vtinherit_howto;
    case R_MIPS_GNU_VTENTRY:
      return &elf_mips_gnu_vtentry_howto;
    case R_MIPS_PC32:
      return &elf_mips_gnu_pcrel32;
    case R_MIPS_COPY:
      return &elf_mips_copy_howto;
    case R_MIPS_JUMP_SLOT:
      return &elf_mips_jump_slot_howto;
    case R_MIPS_EH:
      return &elf_mips_eh_howto;
    default:
      if (r_type >= R_MICROMIPSPP_min && r_type < R_MICROMIPSPP_max)
	return &elf_micromips_howto_table_rela[r_type - R_MICROMIPSPP_min];
      BFD_ASSERT (r_type < (unsigned int) R_MIPS_max);
      return &elf_mips_howto_table_rela[r_type];
    }
}

/* Given a MIPS Elf_Internal_Rel, fill in an arelent structure.  */

static void
mips_info_to_howto_rel (bfd *abfd, arelent *cache_ptr, Elf_Internal_Rela *dst)
{
  const struct elf_backend_data *bed;
  unsigned int r_type;

  r_type = ELF32_R_TYPE (dst->r_info);
  bed = get_elf_backend_data (abfd);
  cache_ptr->howto = bed->elf_backend_mips_rtype_to_howto (r_type, FALSE);

  /* The addend for a GPREL16 or LITERAL relocation comes from the GP
     value for the object file.  We get the addend now, rather than
     when we do the relocation, because the symbol manipulations done
     by the linker may cause us to lose track of the input BFD.  */
  if (((*cache_ptr->sym_ptr_ptr)->flags & BSF_SECTION_SYM) != 0
      && (gprel16_reloc_p (r_type) || literal_reloc_p (r_type)))
    cache_ptr->addend = elf_gp (abfd);
}

/* Given a MIPS Elf_Internal_Rela, fill in an arelent structure.  */

static void
mips_info_to_howto_rela (bfd *abfd, arelent *cache_ptr, Elf_Internal_Rela *dst)
{
  const struct elf_backend_data *bed;
  unsigned int r_type;

  r_type = ELF32_R_TYPE (dst->r_info);
  bed = get_elf_backend_data (abfd);
  cache_ptr->howto = bed->elf_backend_mips_rtype_to_howto (r_type, TRUE);
  cache_ptr->addend = dst->r_addend;

  /* If we ever need to do any extra processing with dst->r_addend
     (the field omitted in an Elf_Internal_Rel) we can do it here.  */
}

/* Determine whether a symbol is global for the purposes of splitting
   the symbol table into global symbols and local symbols.  At least
   on Irix 5, this split must be between section symbols and all other
   symbols.  On most ELF targets the split is between static symbols
   and externally visible symbols.  */

static bfd_boolean
mips_elf_sym_is_global (bfd *abfd ATTRIBUTE_UNUSED, asymbol *sym)
{
  return ((sym->flags & (BSF_GLOBAL | BSF_WEAK | BSF_GNU_UNIQUE)) != 0
	  || bfd_is_und_section (bfd_get_section (sym))
	  || bfd_is_com_section (bfd_get_section (sym)));
}

/* Set the right machine number for a MIPS ELF file.  */

static bfd_boolean
mips_elf_p32_object_p (bfd *abfd)
{
  unsigned long mach;

  if (!ABI_P32_P (abfd))
    return FALSE;

  mach = _bfd_elf_mips_mach (elf_elfheader (abfd)->e_flags);
  bfd_default_set_arch_mach (abfd, bfd_arch_mips, mach);
  return TRUE;
}

/* MIPS ELF local labels start with '$', not 'L'.  */

static bfd_boolean
mips_elf_is_local_label_name (bfd *abfd, const char *name)
{
  if (name[0] == '$')
    return TRUE;

  /* On Irix 6, the labels go back to starting with '.', so we accept
     the generic ELF local label syntax as well.  */
  return _bfd_elf_is_local_label_name (abfd, name);
}

/* Support for core dump NOTE sections.  */
static bfd_boolean
elf32_mips_grok_prstatus (bfd *abfd, Elf_Internal_Note *note)
{
  int offset;
  unsigned int size;

  switch (note->descsz)
    {
      default:
	return FALSE;

      case 256:		/* Linux/MIPS */
	/* pr_cursig */
	elf_tdata (abfd)->core->signal = bfd_get_16 (abfd, note->descdata + 12);

	/* pr_pid */
	elf_tdata (abfd)->core->lwpid = bfd_get_32 (abfd, note->descdata + 24);

	/* pr_reg */
	offset = 72;
	size = 180;

	break;
    }

  /* Make a ".reg/999" section.  */
  return _bfd_elfcore_make_pseudosection (abfd, ".reg",
					  size, note->descpos + offset);
}

static bfd_boolean
elf32_mips_grok_psinfo (bfd *abfd, Elf_Internal_Note *note)
{
  switch (note->descsz)
    {
      default:
	return FALSE;

      case 128:		/* Linux/MIPS elf_prpsinfo */
	elf_tdata (abfd)->core->program
	 = _bfd_elfcore_strndup (abfd, note->descdata + 32, 16);
	elf_tdata (abfd)->core->command
	 = _bfd_elfcore_strndup (abfd, note->descdata + 48, 80);
    }

  /* Note that for some reason, a spurious space is tacked
     onto the end of the args in some (at least one anyway)
     implementations, so strip it off if it exists.  */

  {
    char *command = elf_tdata (abfd)->core->command;
    int n = strlen (command);

    if (0 < n && command[n - 1] == ' ')
      command[n - 1] = '\0';
  }

  return TRUE;
}

/* Depending on the target vector we generate some version of Irix
   executables or "normal" MIPS ELF ABI executables.  */
static irix_compat_t
elf32_mips_irix_compat (bfd *abfd ATTRIBUTE_UNUSED)
{
  return ict_none;
}


/* ECOFF swapping routines.  These are used when dealing with the
   .mdebug section, which is in the ECOFF debugging format.  */
static const struct ecoff_debug_swap mips_elf32_ecoff_debug_swap = {
  /* Symbol table magic number.  */
  magicSym,
  /* Alignment of debugging information.  E.g., 4.  */
  4,
  /* Sizes of external symbolic information.  */
  sizeof (struct hdr_ext),
  sizeof (struct dnr_ext),
  sizeof (struct pdr_ext),
  sizeof (struct sym_ext),
  sizeof (struct opt_ext),
  sizeof (struct fdr_ext),
  sizeof (struct rfd_ext),
  sizeof (struct ext_ext),
  /* Functions to swap in external symbolic data.  */
  ecoff_swap_hdr_in,
  ecoff_swap_dnr_in,
  ecoff_swap_pdr_in,
  ecoff_swap_sym_in,
  ecoff_swap_opt_in,
  ecoff_swap_fdr_in,
  ecoff_swap_rfd_in,
  ecoff_swap_ext_in,
  _bfd_ecoff_swap_tir_in,
  _bfd_ecoff_swap_rndx_in,
  /* Functions to swap out external symbolic data.  */
  ecoff_swap_hdr_out,
  ecoff_swap_dnr_out,
  ecoff_swap_pdr_out,
  ecoff_swap_sym_out,
  ecoff_swap_opt_out,
  ecoff_swap_fdr_out,
  ecoff_swap_rfd_out,
  ecoff_swap_ext_out,
  _bfd_ecoff_swap_tir_out,
  _bfd_ecoff_swap_rndx_out,
  /* Function to read in symbolic data.  */
  _bfd_mips_elf_read_ecoff_info
};

#define ELF_ARCH			bfd_arch_mips
#define ELF_TARGET_ID			MIPS_ELF_DATA
#define ELF_MACHINE_CODE		EM_MIPS

#define elf_backend_collect		TRUE
#define elf_backend_type_change_ok	TRUE
#define elf_backend_can_gc_sections	TRUE
#define elf_backend_gc_mark_extra_sections \
					_bfd_mips_elf_gc_mark_extra_sections
#define elf_info_to_howto		mips_info_to_howto_rela
#define elf_info_to_howto_rel		mips_info_to_howto_rel
#define elf_backend_sym_is_global	mips_elf_sym_is_global
#define elf_backend_object_p		mips_elf_p32_object_p
#define elf_backend_symbol_processing	_bfd_mips_elf_symbol_processing
#define elf_backend_section_processing	_bfd_mips_elf_section_processing
#define elf_backend_section_from_shdr	_bfd_mips_elf_section_from_shdr
#define elf_backend_fake_sections	_bfd_mips_elf_fake_sections
#define elf_backend_section_from_bfd_section \
					_bfd_mips_elf_section_from_bfd_section
#define elf_backend_add_symbol_hook	_bfd_mips_elf_add_symbol_hook
#define elf_backend_link_output_symbol_hook \
					_bfd_mips_elf_link_output_symbol_hook
#define elf_backend_create_dynamic_sections \
					_bfd_mips_elf_create_dynamic_sections
#define elf_backend_check_relocs	_bfd_mips_elf_check_relocs
#define elf_backend_merge_symbol_attribute \
					_bfd_mips_elf_merge_symbol_attribute
#define elf_backend_get_target_dtag	_bfd_mips_elf_get_target_dtag
#define elf_backend_adjust_dynamic_symbol \
					_bfd_mips_elf_adjust_dynamic_symbol
#define elf_backend_always_size_sections \
					_bfd_mips_elf_always_size_sections
#define elf_backend_size_dynamic_sections \
					_bfd_mips_elf_size_dynamic_sections
#define elf_backend_init_index_section	_bfd_elf_init_1_index_section
#define elf_backend_relocate_section	_bfd_mips_elf_relocate_section
#define elf_backend_finish_dynamic_symbol \
					_bfd_mips_elf_finish_dynamic_symbol
#define elf_backend_finish_dynamic_sections \
					_bfd_mips_elf_finish_dynamic_sections
#define elf_backend_final_write_processing \
					_bfd_mips_elf_final_write_processing
#define elf_backend_additional_program_headers \
					_bfd_mips_elf_additional_program_headers
#define elf_backend_modify_segment_map	_bfd_mips_elf_modify_segment_map
#define elf_backend_gc_mark_hook	_bfd_mips_elf_gc_mark_hook
#define elf_backend_gc_sweep_hook	_bfd_mips_elf_gc_sweep_hook
#define elf_backend_copy_indirect_symbol \
					_bfd_mips_elf_copy_indirect_symbol
#define elf_backend_grok_prstatus	elf32_mips_grok_prstatus
#define elf_backend_grok_psinfo		elf32_mips_grok_psinfo
#define elf_backend_ecoff_debug_swap	&mips_elf32_ecoff_debug_swap

#define elf_backend_got_header_size	(4 * MIPS_RESERVED_GOTNO)
#define elf_backend_may_use_rela_p	1
#define elf_backend_default_use_rela_p	1
#define elf_backend_sign_extend_vma	TRUE
#define elf_backend_plt_readonly	1

#define elf_backend_discard_info	_bfd_mips_elf_discard_info
#define elf_backend_ignore_discarded_relocs \
					_bfd_mips_elf_ignore_discarded_relocs
#define elf_backend_write_section	_bfd_mips_elf_write_section
#define elf_backend_mips_irix_compat	elf32_mips_irix_compat
#define elf_backend_mips_rtype_to_howto	mips_elf32_rtype_to_howto
#define bfd_elf32_bfd_is_local_label_name \
					mips_elf_is_local_label_name
#define bfd_elf32_bfd_is_target_special_symbol \
					_bfd_mips_elf_is_target_special_symbol
#define bfd_elf32_get_synthetic_symtab	_bfd_mips_elf_get_synthetic_symtab
#define bfd_elf32_find_nearest_line	_bfd_mips_elf_find_nearest_line
#define bfd_elf32_find_inliner_info	_bfd_mips_elf_find_inliner_info
#define bfd_elf32_new_section_hook	_bfd_mips_elf_new_section_hook
#define bfd_elf32_set_section_contents	_bfd_mips_elf_set_section_contents
#define bfd_elf32_bfd_get_relocated_section_contents \
				_bfd_elf_mips_get_relocated_section_contents
#define bfd_elf32_bfd_link_hash_table_create \
					_bfd_mips_elf_link_hash_table_create
#define bfd_elf32_bfd_final_link	_bfd_mips_elf_final_link
#define bfd_elf32_bfd_merge_private_bfd_data \
					_bfd_mips_elf_merge_private_bfd_data
#define bfd_elf32_bfd_set_private_flags	_bfd_mips_elf_set_private_flags
#define bfd_elf32_bfd_print_private_bfd_data \
					_bfd_mips_elf_print_private_bfd_data
#define bfd_elf32_bfd_relax_section	_bfd_mips_elf_relax_section
#define bfd_elf32_mkobject		_bfd_mips_elf_mkobject

/* The SVR4 MIPS ABI says that this should be 0x10000, but Irix 5 uses
   a value of 0x1000, and we are compatible.  */
#define ELF_MAXPAGESIZE			0x1000
#define ELF_COMMONPAGESIZE		0x1000

/* Support for mips32 ISAR7 target.  */

#define TARGET_LITTLE_SYM               mips_elf32_ptrad_le_vec
#define TARGET_LITTLE_NAME              "elf32-ptradlittlemips"
#define TARGET_BIG_SYM                  mips_elf32_ptrad_be_vec
#define TARGET_BIG_NAME                 "elf32-ptradbigmips"

#define elf32_bed			elf32_ptradbed

/* Include the target file again for this target.  */
#include "elf32-target.h"
