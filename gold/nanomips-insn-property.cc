// nanomips-insn-property.cc -- Nanomips instruction properties   -*- C++ -*-

// Copyright (C) 2018 Free Software Foundation, Inc.
// Written by Vladimir Radosavljevic <vladimir.radosavljevic@mips.com>

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

// Return target register from nanoMIPS move.balc instruction.

unsigned int
move_balc_treg_32(uint32_t insn)
{
  unsigned int reg = (((insn >> 21) & 0x7) | ((insn >> 22) & 0x8));
  static unsigned int gpr4_zero_map[] = { 8, 9, 10, 0, 4, 5, 6, 7, 16,
                                          17, 18, 19, 20, 21, 22, 23 };
  gold_assert(reg < sizeof(gpr4_zero_map) / sizeof(gpr4_zero_map[0]));
  return gpr4_zero_map[reg];
}

// Return destination register from nanoMIPS move.balc instruction.

unsigned int
move_balc_dreg_32(uint32_t insn)
{ return ((insn >> 24) & 0x1) + 4; }

// Return rt and u[11:3] fields from nanoMIPS save/restore instruction.

unsigned int
ext_sres_fields(uint32_t insn)
{ return (((insn >> 3) & 0x1ff) | ((insn >> 12) & 0x3e00)); }

// Insert rt and u[11:3] fields in nanoMIPS save/restore instruction.

unsigned int
ins_sres_fields(unsigned int, unsigned int fields, uint32_t data)
{
  unsigned int u = ((fields & 0x1ff) << 3);
  unsigned int rt = ((fields & 0x3e00) << 12);
  return (data | rt | u);
}

// Insert rt and u[7:4] fields in nanoMIPS save[16]/restore.jrc[16] instruction.

unsigned int
ins_sres16_fields(unsigned int, unsigned int fields, uint32_t data)
{
  unsigned int u = ((fields & 0x1ff) << 3);
  unsigned int rt = ((fields & 0x3e00) >> 9);
  unsigned int rt1 = (rt == 30) ? 0 : (1U << 9);
  return (data | rt1 | u);
}

Nanomips_insn_property::Nanomips_insn_property(
    const char* name,
    extract_reg_func treg_func,
    convert_reg_func convert_treg_func,
    valid_reg_func valid_treg_func,
    extract_reg_func sreg_func,
    convert_reg_func convert_sreg_func,
    valid_reg_func valid_sreg_func)
  : name_(name), transform_map_(), relocs_(), ext_treg_func_(treg_func),
    convert_treg_func_(convert_treg_func), valid_treg_func_(valid_treg_func),
    ext_sreg_func_(sreg_func), convert_sreg_func_(convert_sreg_func),
    valid_sreg_func_(valid_sreg_func)
{ }

Nanomips_transform_template::Nanomips_transform_template(
    const Nanomips_insn_template* insns,
    size_t insn_count,
    const unsigned int* relocs,
    size_t reloc_num)
  : insns_(insns), insn_count_(insn_count)
{
  // Add relocations for which this transformation is used.
  for (size_t i = 0; i < reloc_num; ++i)
    this->relocs_.insert(relocs[i]);

  // Compute byte size of transformation template.
  off_t offset = 0;
  for (size_t i = 0; i < insn_count; i++)
    offset += insns[i].size();

  this->size_ = offset;
}

Nanomips_insn_property_table::Nanomips_insn_property_table()
{
  Nanomips_insn_property* insn_property = NULL;

#undef NIP
#undef NTT
#define NIP(name, opcode, extract_treg_func, convert_treg_func,          \
            valid_treg_func, extract_sreg_func, convert_sreg_func,       \
            valid_sreg_func)                                             \
  do                                                                     \
    {                                                                    \
      insn_property = new Nanomips_insn_property(name,                   \
                                                 extract_treg_func,      \
                                                 convert_treg_func,      \
                                                 valid_treg_func,        \
                                                 extract_sreg_func,      \
                                                 convert_sreg_func,      \
                                                 valid_sreg_func);       \
      std::pair<Nanomips_insn_map::iterator, bool> ins =                 \
        this->insns_.insert(std::make_pair(opcode, insn_property));      \
      gold_assert(ins.second);                                           \
    }                                                                    \
  while (0);

#define NTT(type, relocs, insns)                                         \
  do                                                                     \
    {                                                                    \
      unsigned int transform_type = TT_##type;                           \
      static const Nanomips_insn_template insn_array[] = insns;          \
      size_t insn_size = sizeof(insn_array) / sizeof(*insn_array);       \
      const unsigned int reloc_array[] = relocs;                         \
      size_t reloc_size = sizeof(reloc_array) / sizeof(*reloc_array);    \
      Nanomips_transform_template* transform_template =                  \
        new Nanomips_transform_template(insn_array, insn_size,           \
                                        reloc_array, reloc_size);        \
      gold_assert(insn_property != NULL);                                \
      insn_property->add_transform(transform_template, transform_type,   \
                                   reloc_array, reloc_size);             \
    }                                                                    \
  while (0);

#include "nanomips-insn.def"
#undef NIP
#undef NTT
}
} // End namespace gold.
