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

#include "nanomips-reloc-property.h"
#include "symtab.h"

#include <stdio.h>

namespace gold
{

Nanomips_insn_property::Nanomips_insn_property(
    const Insn_info* insns,
    size_t insn_num,
    const char* name,
    int count,
    unsigned int offset,
    unsigned int insn_type,
    bool is_store)
  : insns_(insns), insn_num_(insn_num), name_(name), next_insn_(NULL),
    count_(count), offset_(offset), insn_type_(insn_type), is_store_(is_store)
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
    relaxations_(), expansions_()
{ }

Nanomips_reloc_property_table::Nanomips_reloc_property_table()
{
  // Insn array definitions.
  static const Insn_info BC_LONG[] =
    {
      // aluipc $reg, %pcrel_hi(sym)
      { 0xe0000002, elfcpp::R_NANOMIPS_PC_HI20, "aluipc" },
      // addiu $reg, $reg, %lo(sym)
      { 0x00000000, elfcpp::R_NANOMIPS_LO12, "addiu" },
      // jrc[16] $reg
      { 0xd800, elfcpp::R_NANOMIPS_NONE, "jrc[16]" }
    };

  static const Insn_info BALC_LONG[] =
    {
      // aluipc $reg, %pcrel_hi(sym)
      { 0xe0000002, elfcpp::R_NANOMIPS_PC_HI20, "aluipc" },
      // addiu $reg, $reg, %lo(sym)
      { 0x00000000, elfcpp::R_NANOMIPS_LO12, "addiu" },
      // jalrc[16] $reg
      { 0xd810, elfcpp::R_NANOMIPS_NONE, "jalrc[16]" }
    };

  static const Insn_info MOVE_BALC[] =
    {
      // move $reg, $reg
      { 0x1000, elfcpp::R_NANOMIPS_NONE, "move16" },
      // balc sym
      { 0x2a000000, elfcpp::R_NANOMIPS_PC25_S1, "balc" }
    };

  static const Insn_info BEQIC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // beqc $reg, $expandreg, sym
      { 0x88000000, elfcpp::R_NANOMIPS_PC14_S1, "beqc" }
    };

  static const Insn_info BGEIC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // bgec $reg, $expandreg, sym
      { 0x88008000, elfcpp::R_NANOMIPS_PC14_S1, "bgec" }
    };

  static const Insn_info BGEIUC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // bgeuc $reg, $expandreg, sym
      { 0x8800c000, elfcpp::R_NANOMIPS_PC14_S1, "bgeuc" }
    };

  static const Insn_info BLTIC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // bltc $reg, $expandreg, sym
      { 0xa8008000, elfcpp::R_NANOMIPS_PC14_S1, "bltc" }
    };

  static const Insn_info BLTIUC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // bltuc $reg, $expandreg, sym
      { 0xa800c000, elfcpp::R_NANOMIPS_PC14_S1, "bltuc" }
    };

  static const Insn_info BNEIC[] =
    {
      // li $expandreg, imm
      { 0x00000000, elfcpp::R_NANOMIPS_NONE, "li" },
      // bnec $reg, $expandreg, sym
      { 0xa8000000, elfcpp::R_NANOMIPS_PC14_S1, "bnec" }
    };

  static const Insn_info LWGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // lw $reg, %lo(sym)($expandreg)
      { 0x84008000, elfcpp::R_NANOMIPS_GPREL_LO12, "lw" }
    };

  static const Insn_info SWGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // sw $reg, %lo(sym)($expandreg)
      { 0x84009000, elfcpp::R_NANOMIPS_GPREL_LO12, "sw" }
    };

  static const Insn_info ADDIUGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // addiu $reg, $expandreg, %lo(sym)
      { 0x00000000, elfcpp::R_NANOMIPS_GPREL_LO12, "addiu" }
    };

  static const Insn_info LBGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // lb   $reg, %lo(sym)($expandreg)
      { 0x84000000, elfcpp::R_NANOMIPS_GPREL_LO12, "lb" }
    };

  static const Insn_info LBUGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // lbu $reg, %lo(sym)($expandreg)
      { 0x84002000, elfcpp::R_NANOMIPS_GPREL_LO12, "lbu" }
    };

  static const Insn_info SBGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // sb $reg, %lo(sym)($expandreg)
      { 0x84001000, elfcpp::R_NANOMIPS_GPREL_LO12, "sb" }
    };

  static const Insn_info LHGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // lh $reg, %lo(sym)($expandreg)
      { 0x84004000, elfcpp::R_NANOMIPS_GPREL_LO12, "lh" }
    };

  static const Insn_info LHUGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // lhu $reg, %lo(sym)($expandreg)
      { 0x84006000, elfcpp::R_NANOMIPS_GPREL_LO12, "lhu" }
    };

  static const Insn_info SHGP_LONG[] =
    {
      // lui $expandreg, %gprel_hi(sym)
      { 0xe0000000, elfcpp::R_NANOMIPS_GPREL_HI20, "lui" },
      // addu $expandreg, $expandreg, $gp
      { 0x23800150, elfcpp::R_NANOMIPS_NONE, "addu" },
      // sh $reg, %lo(sym)($expandreg)
      { 0x84005000, elfcpp::R_NANOMIPS_GPREL_LO12, "sh" }
    };

  static const Insn_info BC32[] =
    {
      // bc sym
      { 0x28000000, elfcpp::R_NANOMIPS_PC25_S1, "bc" }
    };

  static const Insn_info BALC32[] =
    {
      // balc sym
      { 0x2a000000, elfcpp::R_NANOMIPS_PC25_S1, "balc" }
    };

  static const Insn_info BEQC32[] =
    {
      // beqc $reg, $reg, sym
      { 0x88000000, elfcpp::R_NANOMIPS_PC14_S1, "beqc" }
    };

  static const Insn_info BNEC32[] =
    {
      // bnec $reg, $reg, sym
      { 0xa8000000, elfcpp::R_NANOMIPS_PC14_S1, "bnec" }
    };

  static const Insn_info LWGP32[] =
    {
      // lw $reg, %gp_rel(sym)($gp)
      { 0x40000002, elfcpp::R_NANOMIPS_GPREL19_S2, "lw[gp]" }
    };

  static const Insn_info SWGP32[] =
    {
      // sw $reg, %gp_rel(sym)($gp)
      { 0x40000003, elfcpp::R_NANOMIPS_GPREL19_S2, "sw[gp]" }
    };

  static const Insn_info LW32[] =
    {
      // lw $reg, %gp_rel(sym)($reg)
      { 0x84008000, elfcpp::R_NANOMIPS_LO12, "lw" }
    };

  static const Insn_info SW32[] =
    {
      // sw $reg, %gp_rel(sym)($reg)
      { 0x84009000, elfcpp::R_NANOMIPS_LO12, "sw" }
    };

  static const Insn_info BC16[] =
    {
      // bc16 sym
      { 0x1800, elfcpp::R_NANOMIPS_PC10_S1, "bc[16]" }
    };

  static const Insn_info BALC16[] =
    {
      // balc16 sym
      { 0x3800, elfcpp::R_NANOMIPS_PC10_S1, "balc[16]" }
    };

  static const Insn_info BEQC16[] =
    {
      // beqc16 $reg, $reg, sym
      { 0xd800, elfcpp::R_NANOMIPS_PC4_S1, "beqc[16]" }
    };

  static const Insn_info BNEC16[] =
    {
      // bnec16 $reg, $reg, sym
      { 0xd800, elfcpp::R_NANOMIPS_PC4_S1, "bnec[16]" }
    };

  static const Insn_info LWGP16[] =
    {
      // lw16 $reg, %gp_rel(sym)($gp)
      { 0x5400, elfcpp::R_NANOMIPS_GPREL7_S2, "lw[gp16]" }
    };

  static const Insn_info SWGP16[] =
    {
      // sw16 $reg, %gp_rel(sym)($gp)
      { 0xd400, elfcpp::R_NANOMIPS_GPREL7_S2, "sw[gp16]" }
    };

  static const Insn_info LW16[] =
    {
      // lw16 $reg, %gp_rel(sym)($reg)
      { 0x1400, elfcpp::R_NANOMIPS_LO4_S2, "lw[16]" }
    };

  static const Insn_info SW16[] =
    {
      // sw16 $reg, %gp_rel(sym)($reg)
      { 0x9400, elfcpp::R_NANOMIPS_LO4_S2, "sw[16]" }
    };

  static const Insn_info ADDIUGPB32[] =
    {
      // addiu.b $reg, $gp, %gprel(sym)
      { 0x440c0000, elfcpp::R_NANOMIPS_GPREL18, "addiu[gp.b]" }
    };

  static const Insn_info ADDIUGPW32[] =
    {
      // addiu.w $reg, $gp, %gprel(sym)
      { 0x40000000, elfcpp::R_NANOMIPS_GPREL19_S2, "addiu[gp.w]" }
    };

  static const Insn_info LAPC32[] =
    {
      // lapc $reg, sym
      { 0x04000000, elfcpp::R_NANOMIPS_PC21_S1, "lapc" }
    };

  static const Insn_info LAPC48[] =
    {
      // lapc[48] $reg, sym
      { 0x6003, elfcpp::R_NANOMIPS_PC_I32, "lapc[48]" }
    };

  static const Insn_info ADDIUGP48[] =
    {
      // addiugp[48] $reg, %gprel32(sym)
      { 0x6002, elfcpp::R_NANOMIPS_GPREL_I32, "addiugp[48]" }
    };

  static const Insn_info LWPC48_GOT[] =
    {
      // lwpc[48] $reg, %got_pcrel32(sym)
      { 0x600b, elfcpp::R_NANOMIPS_GOTPC_I32, "lwpc[48]" }
    };

  static const Insn_info PCREL_GOT[] =
    {
      // aluipc $reg, %got_pcrel_hi(sym)
      { 0xe0000002, elfcpp::R_NANOMIPS_GOTPC_HI20, "aluipc" },
      // lw $reg, %got_lo(sym)($reg)
      { 0x84008000, elfcpp::R_NANOMIPS_GOT_LO12, "lw" }
    };

  static const Insn_info ALUIPC32[] =
    {
      // aluipc $reg, %pcrel_hi(sym)
      { 0xe0000002, elfcpp::R_NANOMIPS_PC_HI20, "aluipc" },
    };

  const bool Y(true), N(false);
  for (unsigned int i = 0; i < Property_table_size; ++i)
    table_[i] = NULL;

#undef NRD
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

#define NIE(rname, aname, opcode, iname, count, offset, store, type) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      gold_assert(this->table_[code]->mask_ != 0); \
      size_t array_size = sizeof(aname) / sizeof(aname[0]); \
      Nanomips_insn_property* aname##_expand_property = \
        new Nanomips_insn_property(aname, \
                                   array_size, \
                                   iname, \
                                   count, \
                                   offset, \
                                   IT_##type, \
                                   store); \
      Nanomips_insn_map::const_iterator p = \
        this->table_[code]->expansions_.find(opcode); \
      if (p != this->table_[code]->expansions_.end()) \
        p->second->set_insn_property(aname##_expand_property, IT_##type); \
      else \
        { \
          std::pair<Nanomips_insn_map::iterator, bool> ins = \
            this->table_[code]->expansions_.insert( \
              std::make_pair(opcode, aname##_expand_property)); \
          gold_assert(ins.second); \
        } \
    } \
  while (0);

#define NIR(rname, aname, opcode, iname, count, offset, store, type) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      gold_assert(this->table_[code]->mask_ != 0); \
      size_t array_size = sizeof(aname) / sizeof(aname[0]); \
      Nanomips_insn_property* aname##_relax_property = \
        new Nanomips_insn_property(aname, \
                                   array_size, \
                                   iname, \
                                   count, \
                                   offset, \
                                   IT_##type, \
                                   store); \
      std::pair<Nanomips_insn_map::iterator, bool> ins = \
        this->table_[code]->relaxations_.insert( \
          std::make_pair(opcode, aname##_relax_property)); \
      gold_assert(ins.second); \
    } \
  while (0);

#include "nanomips-reloc.def"
#undef NRD
#undef NIE
#undef NIR
}
} // End namespace gold.
