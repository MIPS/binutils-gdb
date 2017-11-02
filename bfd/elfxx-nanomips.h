/* nanoMIPS ELF specific backend routines.
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

#include "elf/mips-common.h"
#include "elf/nanomips.h"

extern bfd_boolean _bfd_nanomips_elf_mkobject
  (bfd *);
extern bfd_boolean _bfd_nanomips_elf_section_processing
  (bfd *, Elf_Internal_Shdr *);
extern bfd_boolean _bfd_nanomips_elf_section_from_shdr
  (bfd *, Elf_Internal_Shdr *, const char *, int);
extern bfd_boolean _bfd_nanomips_elf_fake_sections
  (bfd *, Elf_Internal_Shdr *, asection *);
extern void _bfd_nanomips_elf_final_write_processing
  (bfd *, bfd_boolean);
extern const char * _bfd_nanomips_fp_abi_string
  (int);
extern bfd_boolean _bfd_nanomips_elf_print_private_bfd_data
  (bfd *, void *);

extern bfd_reloc_status_type _bfd_nanomips_elf_generic_reloc
  (bfd *, arelent *, asymbol *, void *, asection *, bfd *, char **);
extern unsigned long _bfd_elf_nanomips_mach
  (flagword);
extern void _bfd_nanomips_elf_merge_symbol_attribute
  (struct elf_link_hash_entry *, const Elf_Internal_Sym *, bfd_boolean, bfd_boolean);

extern const struct bfd_elf_special_section _bfd_nanomips_elf_special_sections [];

extern bfd_boolean _bfd_nanomips_elf_common_definition (Elf_Internal_Sym *);

extern Elf_Internal_ABIFlags_v0 *_bfd_nanomips_elf_get_abiflags (bfd *abfd);

static inline bfd_boolean
gprel16_reloc_p (unsigned int r_type)
{
  return (r_type == BFD_RELOC_GPREL16
	  || r_type == BFD_RELOC_NANOMIPS_GPREL7_S2
	  || r_type == BFD_RELOC_NANOMIPS_GPREL18
	  || r_type == BFD_RELOC_NANOMIPS_GPREL19_S2
	  || r_type == BFD_RELOC_NANOMIPS_GPREL16_S2
	  || r_type == BFD_RELOC_NANOMIPS_GPREL18_S3
	  || r_type == BFD_RELOC_NANOMIPS_GPREL17_S1);
}

static inline bfd_boolean
literal_reloc_p (int r_type)
{
  return r_type == R_NANOMIPS_LITERAL;
}

#define elf_backend_common_definition   _bfd_nanomips_elf_common_definition
#define elf_backend_special_sections _bfd_nanomips_elf_special_sections
#define elf_backend_merge_symbol_attribute  _bfd_nanomips_elf_merge_symbol_attribute
