// nanomips-reloc-property.cc -- Nanomips relocation properties   -*- C++ -*-

// Copyright (C) 2017 Free Software Foundation, Inc.
// Written by Vladimir Radosavljevic <vladimir.radosavljevic@imgtec.com>

// This file is part of gold.

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
// MA 02110-1301, USA.

#include "gold.h"

#include "nanomips.h"
#include "nanomips-reloc-property.h"
#include "symtab.h"

namespace gold
{
Nanomips_reloc_property::Nanomips_reloc_property(
    unsigned int code,
    const char* name,
    Reloc_type reloc_type,
    unsigned int size,
    unsigned int bitsize,
    unsigned int align,
    unsigned int mask,
    int reference_flags)
  : code_(code), name_(name), reloc_type_(reloc_type), size_(size),
    bitsize_(bitsize), align_(align), mask_(mask),
    reference_flags_(reference_flags)
{ }

Nanomips_reloc_property_table::Nanomips_reloc_property_table()
{
  for (unsigned int i = 0; i < Property_table_size; ++i)
    table_[i] = NULL;

#undef NRD
#define NRD(rname, type, size, bitsize, align, mask, rflags) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      this->table_[code] = \
        new Nanomips_reloc_property(elfcpp::R_NANOMIPS_##rname, \
                                    "R_NANOMIPS_" #rname, \
                                    Nanomips_reloc_property::RT_##type, \
                                    size, \
                                    bitsize, \
                                    align, \
                                    mask, \
                                    (rflags)); \
    } \
  while (0);

#include "nanomips-reloc.def"
#undef NRD
}

} // End namespace gold.
