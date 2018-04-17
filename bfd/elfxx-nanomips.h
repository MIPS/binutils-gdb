/* nanoMIPS ELF specific backend routines.
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

#include "elf/mips-common.h"
#include "elf/nanomips.h"

extern bfd_boolean _bfd_nanomips_elf_mkobject (bfd *);
extern bfd_boolean _bfd_nanomips_elf_section_processing
  (bfd *, Elf_Internal_Shdr *);
extern bfd_boolean _bfd_nanomips_elf_section_from_shdr
  (bfd *, Elf_Internal_Shdr *, const char *, int);
extern bfd_boolean _bfd_nanomips_elf_fake_sections
  (bfd *, Elf_Internal_Shdr *, asection *);
extern void _bfd_nanomips_elf_final_write_processing (bfd *, bfd_boolean);
extern const char *_bfd_nanomips_fp_abi_string (int);
extern bfd_boolean _bfd_nanomips_elf_print_private_bfd_data (bfd *, void *);

extern bfd_reloc_status_type _bfd_nanomips_elf_generic_reloc
  (bfd *, arelent *, asymbol *, void *, asection *, bfd *, char **);
extern bfd_reloc_status_type _bfd_nanomips_elf_negative_reloc
  (bfd *, arelent *, asymbol *, void *, asection *, bfd *, char **);

extern unsigned long _bfd_elf_nanomips_mach (flagword);
extern void _bfd_nanomips_elf_merge_symbol_attribute
  (struct elf_link_hash_entry *, const Elf_Internal_Sym *, bfd_boolean,
   bfd_boolean);

extern const struct bfd_elf_special_section
  _bfd_nanomips_elf_special_sections[];

extern bfd_byte *_bfd_elf_nanomips_get_relocated_section_contents
  (bfd *, struct bfd_link_info *, struct bfd_link_order *,
   bfd_byte *, bfd_boolean, asymbol **);

#define elf_backend_special_sections _bfd_nanomips_elf_special_sections
#define elf_backend_merge_symbol_attribute	\
  _bfd_nanomips_elf_merge_symbol_attribute
