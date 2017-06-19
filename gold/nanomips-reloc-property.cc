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
#include "nanomips.h"
#include "symtab.h"

#include <stdio.h>

namespace gold
{

Nanomips_insn_property::Nanomips_insn_property(
    const uint32_t* insns,
    size_t insn_num,
    const char* msg,
    int count,
    unsigned int offset,
    unsigned int insn_type,
    bool is_store)
  : insns_(insns), insn_num_(insn_num), msg_(msg), next_insn_(NULL),
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
  // Expand insn array definitions.
  static const unsigned int BC_EXPAND[] =
    {
      0xe0000002,           // aluipc  $expandreg, %pcrel_hi(sym)
      0x00000000,           // addiu   $expandreg, $expandreg, %pcrel_lo(sym)
      0xd800,               // jrc[16] $expandreg
    };
  static const char* BC_EXPAND_MSG =
    "bc is expanded to aluipc, addiu, jrc[16]";

  static const unsigned int BALC_EXPAND[] =
    {
      0xe0000002,           // aluipc    $expandreg, %pcrel_hi(sym)
      0x00000000,           // addiu     $expandreg, $expandreg, %pcrel_lo(sym)
      0xd810,               // jalrc[16] $expandreg
    };
  static const char* BALC_EXPAND_MSG =
    "balc is expanded to aluipc, addiu, jalrc[16]";

  static const unsigned int MOVE_BALC_EXPAND[] =
    {
      0x1000,               // move $reg, $reg
      0x2a000000,           // balc sym
    };
  static const char* MOVE_BALC_EXPAND_MSG =
    "move.balc is expanded to move16, balc";

  static const unsigned int BEQIC_EXPAND[] =
    {
      0x00000000,           // li   $expandreg, imm
      0x88000000,           // beqc $reg, $expandreg, sym
    };
  static const char* BEQIC_EXPAND_MSG =
    "beqic is expanded to li, beqc";

  static const unsigned int BGEIC_EXPAND[] =
    {
      0x00000000,           // li    $expandreg, imm
      0x88008000,           // bgec  $reg, $expandreg, sym
    };
  static const char* BGEIC_EXPAND_MSG =
    "bgeic is expanded to li, bgec";

  static const unsigned int BGEIUC_EXPAND[] =
    {
      0x00000000,           // li     $expandreg, imm
      0x8800c000,           // bgeuc  $reg, $expandreg, sym
    };
  static const char* BGEIUC_EXPAND_MSG =
    "bgeiuc is expanded to li, bgeuc";

  static const unsigned int BLTIC_EXPAND[] =
    {
      0x00000000,           // li    $expandreg, imm
      0xa8008000,           // bltc  $reg, $expandreg, sym
    };
  static const char* BLTIC_EXPAND_MSG =
    "bltic is expanded to addiu, bltc";

  static const unsigned int BLTIUC_EXPAND[] =
    {
      0x00000000,           // li    $expandreg, imm
      0xa800c000,           // bltuc $reg, $expandreg, sym
    };
  static const char* BLTIUC_EXPAND_MSG =
    "bltiuc is expanded to addiu, bltuc";

  static const unsigned int BNEIC_EXPAND[] =
    {
      0x00000000,           // li    $expandreg, imm
      0xa8000000,           // bnec  $reg, $expandreg, sym
    };
  static const char* BNEIC_EXPAND_MSG =
    "bneic is expanded to addiu, bnec";

  static const unsigned int LWGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84008000,           // lw   $reg, %lo(sym)($expandreg)
    };
  static const char* LWGP_EXPAND_MSG =
    "lw[gp] is expanded to lui, addu, lw";

  static const unsigned int SWGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84009000,           // sw   $reg, %lo(sym)($expandreg)
    };
  static const char* SWGP_EXPAND_MSG =
    "sw[gp] is expanded to lui, addu, sw";

  static const unsigned int ADDIUGP_W_EXPAND[] =
    {
      0xe0000000,           // lui   $expandreg, %hi(sym)
      0x23800150,           // addu  $expandreg, $expandreg, $gp
      0x00000000,           // addiu $reg, $expandreg, %lo(sym)
    };
  static const char* ADDIUGP_W_EXPAND_MSG =
    "addiu[gp.w] is expanded to lui, addu, addiu";

  static const unsigned int LBGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84000000,           // lb   $reg, %lo(sym)($expandreg)
    };
  static const char* LBGP_EXPAND_MSG =
    "lb[gp] is expanded to lui, addu, lb";

  static const unsigned int LBUGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84002000,           // lbu  $reg, %lo(sym)($expandreg)
    };
  static const char* LBUGP_EXPAND_MSG =
    "lbu[gp] is expanded to lui, addu, lbu";

  static const unsigned int SBGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84001000,           // sb   $reg, %lo(sym)($expandreg)
    };
  static const char* SBGP_EXPAND_MSG =
    "sb[gp] is expanded to lui, addu, sb";

  static const unsigned int ADDIUGP_B_EXPAND[] =
    {
      0xe0000000,           // lui   $expandreg, %hi(sym)
      0x23800150,           // addu  $expandreg, $expandreg, $gp
      0x00000000,           // addiu $reg, $expandreg, %lo(sym)
    };
  static const char* ADDIUGP_B_EXPAND_MSG =
    "addiu[gp.b] is expanded to lui, addu, addiu";

  static const unsigned int LHGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84004000,           // lh   $reg, %lo(sym)($expandreg)
    };
  static const char* LHGP_EXPAND_MSG =
    "lh[gp] is expanded to lui, addu, lh";

  static const unsigned int LHUGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84006000,           // lhu  $reg, %lo(sym)($expandreg)
    };
  static const char* LHUGP_EXPAND_MSG =
    "lhu[gp] is expanded to lui, addu, lhu";

  static const unsigned int SHGP_EXPAND[] =
    {
      0xe0000000,           // lui  $expandreg, %hi(sym)
      0x23800150,           // addu $expandreg, $expandreg, $gp
      0x84005000,           // sh   $reg, %lo(sym)($expandreg)
    };
  static const char* SHGP_EXPAND_MSG =
    "sh[gp] is expanded to lui, addu, sh";

  static const unsigned int BC16_EXPAND[] =
    {
      0x28000000,           // bc sym
    };
  static const char* BC16_EXPAND_MSG =
    "bc[16] is expanded to bc";

  static const unsigned int BALC16_EXPAND[] =
    {
      0x2a000000,           // balc sym
    };
  static const char* BALC16_EXPAND_MSG =
    "balc[16] is expanded to balc";

  static const unsigned int BEQC16_EXPAND[] =
    {
      0x88000000,           // beqc $reg, $reg, sym
    };
  static const char* BEQC16_EXPAND_MSG =
    "beqc[16] is expanded to beqc";

  static const unsigned int BNEC16_EXPAND[] =
    {
      0xa8000000,           // bnec $reg, $reg, sym
    };
  static const char* BNEC16_EXPAND_MSG =
    "bnec[16] is expanded to bnec";

  static const unsigned int LWGP16_EXPAND[] =
    {
      0x40000002,           // lw $reg, %gp_rel(sym)($gp)
    };
  static const char* LWGP16_EXPAND_MSG =
    "lw[gp16] is expanded to lw[gp]";

  static const unsigned int SWGP16_EXPAND[] =
    {
      0x40000003,           // sw $reg, %gp_rel(sym)($gp)
    };
  static const char* SWGP16_EXPAND_MSG =
    "sw[gp16] is expanded to sw[gp]";

  static const unsigned int LW16_EXPAND[] =
    {
      0x84008000,           // lw $reg, %gp_rel(sym)($reg)
    };
  static const char* LW16_EXPAND_MSG =
    "lw[16] is expanded to lw";

  static const unsigned int SW16_EXPAND[] =
    {
      0x84009000,           // sw $reg, %gp_rel(sym)($reg)
    };
  static const char* SW16_EXPAND_MSG =
    "sw[16] is expanded to sw";

  // Relax insn array definitions.
  static const unsigned int BC_RELAX[] =
    {
      0x1800,               // bc16 sym
    };
  static const char* BC_RELAX_MSG =
    "bc is relaxed to bc[16]";

  static const unsigned int BALC_RELAX[] =
    {
      0x3800,               // balc16 sym
    };
  static const char* BALC_RELAX_MSG =
    "balc is relaxed to balc[16]";

  static const unsigned int BEQC_RELAX[] =
    {
      0xd800,               // beqc16 $reg, $reg, sym
    };
  static const char* BEQC_RELAX_MSG =
    "beqc is relaxed to beqc[16]";

  static const unsigned int BNEC_RELAX[] =
    {
      0xd800,               // bnec16 $reg, $reg, sym
    };
  static const char* BNEC_RELAX_MSG =
    "bnec is relaxed to bnec[16]";

  static const unsigned int LWGP_RELAX[] =
    {
      0x5400,               // lw16 $reg, %gp_rel(sym)($gp)
    };
  static const char* LWGP_RELAX_MSG =
    "lw[gp] is relaxed to lw[gp16]";

  static const unsigned int SWGP_RELAX[] =
    {
      0xd400,               // sw16 $reg, %gp_rel(sym)($gp)
    };
  static const char* SWGP_RELAX_MSG =
    "sw[gp] is relaxed to sw[gp16]";

  static const unsigned int LW_RELAX[] =
    {
      0x1400,               // lw16 $reg, %gp_rel(sym)($reg)
    };
  static const char* LW_RELAX_MSG =
    "lw is relaxed to lw[16]";

  static const unsigned int SW_RELAX[] =
    {
      0x9400,               // sw16 $reg, %gp_rel(sym)($reg)
    };
  static const char* SW_RELAX_MSG =
    "sw is relaxed to sw[16]";

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

#define NIE(rname, iname, opcode, count, offset, store, type) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      size_t array_size = \
        sizeof(iname##_EXPAND) / sizeof(iname##_EXPAND[0]); \
      Nanomips_insn_property* iname_expand_property = \
        new Nanomips_insn_property(iname##_EXPAND, \
                                   array_size, \
                                   iname##_EXPAND_MSG, \
                                   count, \
                                   offset, \
                                   type, \
                                   store); \
      Nanomips_insn_map::const_iterator p = \
        this->table_[code]->expansions_.find(opcode); \
      if (p != this->table_[code]->expansions_.end()) \
        p->second->set_insn_property(iname_expand_property, type); \
      else \
        { \
          std::pair<Nanomips_insn_map::iterator, bool> ins = \
            this->table_[code]->expansions_.insert( \
              std::make_pair(opcode, iname_expand_property)); \
          gold_assert(ins.second); \
        } \
    } \
  while (0);

#define NIR(rname, iname, opcode, count, offset, store, type) \
  do \
    { \
      unsigned int code = elfcpp::R_NANOMIPS_##rname; \
      gold_assert(code < Property_table_size); \
      gold_assert(this->table_[code] != NULL); \
      size_t array_size = \
        sizeof(iname##_RELAX) / sizeof(iname##_RELAX[0]); \
      Nanomips_insn_property* iname_relax_property = \
        new Nanomips_insn_property(iname##_RELAX, \
                                   array_size, \
                                   iname##_RELAX_MSG, \
                                   count, \
                                   offset, \
                                   type, \
                                   store); \
      std::pair<Nanomips_insn_map::iterator, bool> ins = \
      this->table_[code]->relaxations_.insert( \
        std::make_pair(opcode, iname_relax_property)); \
      gold_assert(ins.second); \
    } \
  while (0);

#include "nanomips-reloc.def"
#undef NRD
#undef NIE
#undef NIR
}
} // End namespace gold.
