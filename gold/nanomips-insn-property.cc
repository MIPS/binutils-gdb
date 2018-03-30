// nanomips-insn-property.cc -- Nanomips instruction properties   -*- C++ -*-

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
#include "nanomips-insn-property.h"

namespace gold
{
// Mapping registers from input to output instruction.
enum Reg_mapping
{
  // Maps to treg register from the input instruction.
  RM_TREG,
  // Maps to sreg register from the input instruction.
  RM_SREG
};

template<int P, int B, int Reg_mapping>
class Insert_reg_impl;

template<int P, int B>
class Insert_reg_impl<P, B, RM_TREG>
{
public:
  static uint32_t
  put(unsigned int treg, unsigned int, uint32_t data)
  { return data | ((treg & ((1U << B) - 1)) << P); }
};

template<int P, int B>
class Insert_reg_impl<P, B, RM_SREG>
{
public:
  static uint32_t
  put(unsigned int, unsigned int sreg, uint32_t data)
  { return data | ((sreg & ((1U << B) - 1)) << P); }
};

template<int P, int B>
class Extract_reg_impl
{
public:
  static unsigned int
  get(uint32_t insn)
  { return (insn >> P) & ((1U << B) - 1); }
};

// Insert register in nanoMIPS instruction.
template<int P, int B, int Reg_mapping>
uint32_t
insert_reg(unsigned int in_treg, unsigned int in_sreg, uint32_t data)
{ return Insert_reg_impl<P, B, Reg_mapping>::put(in_treg, in_sreg, data); }

// Extract register from nanoMIPS instruction.
template<int P, int B>
unsigned int
extract_reg(uint32_t insn)
{ return Extract_reg_impl<P, B>::get(insn); }

// Return target register in move.balc nanoMIPS instruction.
unsigned int
move_balc_treg_32(uint32_t insn)
{
  unsigned int reg = (((insn >> 21) & 0x7) | ((insn >> 22) & 0x8));
  static unsigned int gpr4_zero_map[] = { 8, 9, 10, 0, 4, 5, 6, 7, 16,
                                          17, 18, 19, 20, 21, 22, 23 };
  gold_assert(reg < sizeof(gpr4_zero_map) / sizeof(gpr4_zero_map[0]));
  return gpr4_zero_map[reg];
}

// Return destination register in move.balc nanoMIPS instruction.
unsigned int
move_balc_dreg_32(uint32_t insn)
{ return ((insn >> 24) & 0x1) + 4; }

// Check if a 5-bit register index can be abbreviated to 3 bits.
bool
valid_reg(unsigned int reg)
{ return ((4 <= reg && reg <= 7) || (16 <= reg && reg <= 19)); }

// Check if a 5-bit source register index in store instruction
// can be abbreviated to 3 bits.
bool
valid_st_src_reg(unsigned int reg)
{ return (reg == 0 || (4 <= reg && reg <= 7) || (17 <= reg && reg <= 19)); }

// Convert 3-bit to 5-bit register index.
unsigned int
convert_reg(unsigned int reg)
{
  static unsigned int gpr3_map[] = { 16, 17, 18, 19, 4, 5, 6, 7 };
  gold_assert(reg < sizeof(gpr3_map) / sizeof(gpr3_map[0]));
  return gpr3_map[reg];
}

// Convert 3-bit to 5-bit source register index in store instruction.
unsigned int
convert_st_src_reg(unsigned int reg)
{
  static unsigned int gpr3_src_store_map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
  gold_assert(reg < sizeof(gpr3_src_store_map) / sizeof(gpr3_src_store_map[0]));
  return gpr3_src_store_map[reg];
}

Nanomips_insn_property::Nanomips_insn_property(
    const unsigned int* relocs,
    size_t reloc_num,
    const char* name,
    extract_reg_func treg_func,
    convert_reg_func convert_treg_func,
    valid_reg_func valid_treg_func,
    extract_reg_func sreg_func,
    convert_reg_func convert_sreg_func,
    valid_reg_func valid_sreg_func)
  : name_(name), transforms_(), ext_treg_func_(treg_func),
    convert_treg_func_(convert_treg_func), valid_treg_func_(valid_treg_func),
    ext_sreg_func_(sreg_func), convert_sreg_func_(convert_sreg_func),
    valid_sreg_func_(valid_sreg_func)
{
  gold_assert(reloc_num != 0);
  for (size_t i = 0; i < reloc_num; ++i)
    this->relocs_.insert(relocs[i]);
}

Nanomips_transform_template::Nanomips_transform_template(
    const Nanomips_insn_template* insns,
    size_t insn_count)
  : insns_(insns), insn_count_(insn_count)
{
  off_t offset = 0;
  // Compute byte size of transformation template.
  for (size_t i = 0; i < insn_count; i++)
    offset += insns[i].size();

  this->size_ = offset;
}

Nanomips_insn_property_table::Nanomips_insn_property_table()
{
  // Iterator of the instruction for which we are adding transformations.
  Nanomips_insn_map::iterator insn_it;

#undef NIP
#undef NTT
#define NIP(name, opcode, extract_treg_func, convert_treg_func, \
            valid_treg_func, extract_sreg_func, convert_sreg_func, \
            valid_sreg_func, ...) \
  do \
    { \
      unsigned int relocs[] = __VA_ARGS__; \
      size_t array_size = sizeof(relocs) / sizeof(*relocs); \
      Nanomips_insn_property* insn_property = \
        new Nanomips_insn_property(relocs, \
                                   array_size, \
                                   name, \
                                   extract_treg_func, \
                                   convert_treg_func, \
                                   valid_treg_func, \
                                   extract_sreg_func, \
                                   convert_sreg_func, \
                                   valid_sreg_func); \
      std::pair<Nanomips_insn_map::iterator, bool> ins = \
        this->insns_.insert(std::make_pair(opcode, insn_property)); \
      gold_assert(ins.second); \
      insn_it = ins.first; \
    } \
  while (0);

#define NTT(type, ...) \
  do \
    { \
      static const Nanomips_insn_template insns[] = __VA_ARGS__; \
      size_t array_size = sizeof(insns) / sizeof(*insns); \
      Nanomips_transform_template* transform_template = \
        new Nanomips_transform_template(insns, array_size); \
      insn_it->second->add_transform(transform_template, type); \
    } \
  while (0);

#include "nanomips-insn.def"
#undef NIP
#undef NTT
}
} // End namespace gold.
