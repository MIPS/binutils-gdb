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

#include <stdio.h>

namespace gold
{
// Mapping registers from input to output instruction.
enum Reg_mapping
{
  // No register.
  RM_NONE = 0,
  // Maps to treg register from the input instruction.
  RM_TREG,
  // Maps to sreg register from the input instruction.
  RM_SREG
};

template<int P, int B>
class Extract_reg_impl
{
public:
  static unsigned int
  get(uint32_t insn)
  { return (insn >> P) & ((1U << B) - 1); }
};

template<>
class Extract_reg_impl<0, 0>
{
public:
  static unsigned int
  get(uint32_t)
  { return 0; }
};

template<int LB, int RB>
class Convert_reg_impl
{
public:
  static unsigned int
  convert(unsigned int reg)
  { return ((LB <= reg && reg <= RB) ? reg + 16 : reg); }
};

template<>
class Convert_reg_impl<0, 0>
{
public:
  static unsigned int
  convert(unsigned int reg)
  { return reg; }
};

template<int Reg_num>
class Valid_reg_impl
{
public:
  static bool
  valid(unsigned reg)
  {
    return (reg == Reg_num || (4 <= reg && reg <= 7)
            || (17 <= reg && reg <= 19));
  }
};

template<>
class Valid_reg_impl<32>
{
public:
  static bool
  valid(unsigned int)
  { return true; }
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
class Insert_reg_impl<P, B, RM_NONE>
{
public:
  static uint32_t
  put(unsigned int, unsigned int, uint32_t data)
  { return data; }
};

// Return target register in move.balc nanoMIPS instruction.
unsigned int
move_balc_treg_32(uint32_t insn)
{
  unsigned int rt = (((insn >> 21) & 0x7) | ((insn >> 22) & 0x8));
  if (rt == 3)
    rt = 0;
  else if (rt < 4 || rt > 7)
    rt += 8;
  return rt;
}

// Return destination register in move.balc nanoMIPS instruction.
unsigned int
move_balc_dreg_32(uint32_t insn)
{ return ((insn >> 24) & 0x1) + 4; }

// Extract register from nanoMIPS instruction.
template<int P, int B>
unsigned int
extract_reg(uint32_t insn)
{ return Extract_reg_impl<P, B>::get(insn); }

// Convert 16bit to 32bit nanoMIPS register.
template<int LB, int RB>
unsigned int
convert_reg(unsigned int reg)
{ return Convert_reg_impl<LB, RB>::convert(reg); }

// Check if a 5-bit register index can be abbreviated to 3 bits.
template<int Reg_num>
bool
valid_reg(unsigned int reg)
{ return Valid_reg_impl<Reg_num>::valid(reg); }

// Insert register in nanoMIPS instruction.
template<int P, int B, int Reg_mapping>
uint32_t
insert_reg(unsigned int in_treg, unsigned int in_sreg, uint32_t data)
{ return Insert_reg_impl<P, B, Reg_mapping>::put(in_treg, in_sreg, data); }

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
