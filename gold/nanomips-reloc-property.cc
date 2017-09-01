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

#include <stdio.h>

namespace gold
{

Nanomips_transform_property::Nanomips_transform_property(
    const Insn_info* insns,
    size_t insn_num,
    const char* name,
    int count,
    unsigned int type,
    bool is_store)
  : insns_(insns), insn_num_(insn_num), name_(name), next_transform_(NULL),
    count_(count), type_(type), is_store_(is_store)
{ }

Nanomips_reloc_property::Nanomips_reloc_property(
    unsigned int code,
    const char* name,
    Reloc_type reloc_type,
    unsigned int size,
    unsigned int bitsize,
    unsigned int mask,
    int reference_flags)
  : code_(code), name_(name), reloc_type_(reloc_type), size_(size),
    bitsize_(bitsize), mask_(mask), reference_flags_(reference_flags),
    relaxations_(), expansions_(), got_transform_()
{ }

Nanomips_reloc_property_table::Nanomips_reloc_property_table()
{
  const bool Y(true), N(false);
  for (unsigned int i = 0; i < Property_table_size; ++i)
    table_[i] = NULL;

#undef NRD
#undef NGT
#undef NIE
#undef NIR
#define NRD(rname, type, size, bitsize, mask, rflags) \
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
                                    mask, \
                                    (rflags)); \
    } \
  while(0);

#define NIE(rname, opcode, iname, count, store, type, ...) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      gold_assert(this->table_[code]->mask_ != 0); \
      static const Insn_info insns[] = __VA_ARGS__; \
      size_t array_size = sizeof(insns) / sizeof(*insns); \
      Nanomips_transform_property* expand_property = \
        new Nanomips_transform_property(insns, \
                                        array_size, \
                                        iname, \
                                        count, \
                                        TT_##type, \
                                        store); \
      Nanomips_transform_map::const_iterator p = \
        this->table_[code]->expansions_.find(opcode); \
      if (p != this->table_[code]->expansions_.end()) \
        p->second->set_transform_property(expand_property, TT_##type); \
      else \
        { \
          std::pair<Nanomips_transform_map::iterator, bool> ins = \
            this->table_[code]->expansions_.insert( \
              std::make_pair(opcode, expand_property)); \
          gold_assert(ins.second); \
        } \
    } \
  while (0);

#define NGT(rname, opcode, iname, count, store, type, ...) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      gold_assert(this->table_[code]->mask_ != 0); \
      static const Insn_info insns[] = __VA_ARGS__; \
      size_t array_size = sizeof(insns) / sizeof(*insns); \
      Nanomips_transform_property* got_transform = \
        new Nanomips_transform_property(insns, \
                                        array_size, \
                                        iname, \
                                        count, \
                                        TT_##type, \
                                        store); \
      Nanomips_transform_map::const_iterator p = \
        this->table_[code]->got_transform_.find(opcode); \
      if (p != this->table_[code]->got_transform_.end()) \
        p->second->set_transform_property(got_transform, TT_##type); \
      else \
        { \
          std::pair<Nanomips_transform_map::iterator, bool> ins = \
            this->table_[code]->got_transform_.insert( \
              std::make_pair(opcode, got_transform)); \
          gold_assert(ins.second); \
        } \
    } \
  while (0);

#define NIR(rname, opcode, iname, count, store, type, ...) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      gold_assert(this->table_[code]->mask_ != 0); \
      static const Insn_info insns[] = __VA_ARGS__; \
      size_t array_size = sizeof(insns) / sizeof(*insns); \
      Nanomips_transform_property* relax_property = \
        new Nanomips_transform_property(insns, \
                                        array_size, \
                                        iname, \
                                        count, \
                                        TT_##type, \
                                        store); \
      std::pair<Nanomips_transform_map::iterator, bool> ins = \
        this->table_[code]->relaxations_.insert( \
          std::make_pair(opcode, relax_property)); \
      gold_assert(ins.second); \
    } \
  while (0);

#include "nanomips-reloc.def"
#undef NRD
#undef NGT
#undef NIE
#undef NIR
}
} // End namespace gold.
