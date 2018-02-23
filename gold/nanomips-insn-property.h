// nanomips-insn-property.h -- Nanomips instruction properties   -*- C++ -*-

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

#ifndef GOLD_NANOMIPS_INSN_PROPERTY_H
#define GOLD_NANOMIPS_INSN_PROPERTY_H

#include <string>

namespace gold
{

// Types of transformations.

enum Transform_type
{
  // No transformation.
  TT_NONE = 0,
  // Discard relocation.
  TT_DISCARD,
  // Relaxation from 32 to 16 bit instruction.
  TT_RELAX,
  // beqc[16] and bnec[16] have the same opcode, so we need to distinguish to
  // which 32bit instruction we need to transform it.
  TT_BEQC32,
  TT_BNEC32,
  // Transformation for move.balc instruction.
  TT_MOVE_BALC,
  // Absolute transformation to 32 bit instruction.
  TT_ABS32,
  // Absolute transformation where one instruction is 48 bit.
  TT_ABS_XLP,
  // Absolute long sequence transformations.
  TT_ABS16_LONG,
  TT_ABS32_LONG,
  // Transform to 16 bit gp-relative instruction.
  TT_GPREL16_WORD,
  // Transform to 32 bit gp-relative instruction.
  TT_GPREL32_WORD,
  // Transform to 32bit gp-relative instruction.
  TT_GPREL32,
  // Gp-relative transformations where one instruction is 48 bit.
  TT_GPREL32_XLP,
  TT_GPREL_XLP,
  // Gp-relative long sequence transformations.
  TT_GPREL_LONG,
  TT_GPREL_LONG_ADDRESS,
  // Transform to 16bit pc-relative instruction.
  TT_PCREL16,
  // Transform to 32bit pc-relative instruction.
  TT_PCREL32,
  // Pc-relative transformation where one instruction is 48 bit.
  TT_PCREL_XLP,
  // Pc-relative long sequence transformations.
  TT_PCREL16_LONG,
  TT_PCREL32_LONG,
  // Pc-relative GOT transformations.
  TT_GOTPCREL_XLP,
  TT_GOTPCREL_LONG
};

// The Nanomips_insn_template class is to store information about a
// particular instruction in the transformation.

class Nanomips_insn_template
{
 public:
  typedef unsigned int (*insert_reg_func)(unsigned int, unsigned int, uint32_t);

  // Factory methods to create instruction templates in different sizes.

  static const Nanomips_insn_template
  nanomips_insn16(const char* name, uint32_t data, unsigned int type,
                  insert_reg_func treg_func, insert_reg_func sreg_func)
  { return Nanomips_insn_template(name, data, type, 2, treg_func, sreg_func); }

  static const Nanomips_insn_template
  nanomips_insn32(const char* name, uint32_t data, unsigned int type,
                  insert_reg_func treg_func, insert_reg_func sreg_func)
  { return Nanomips_insn_template(name, data, type, 4, treg_func, sreg_func); }

  static const Nanomips_insn_template
  nanomips_insn48(const char* name, uint32_t data, unsigned int type,
                  insert_reg_func treg_func, insert_reg_func sreg_func)
  { return Nanomips_insn_template(name, data, type, 6, treg_func, sreg_func); }

  // Accessors.  This class is used for read-only objects so no modifiers
  // are provided.

  // Insert registers and return the instruction specific data.
  uint32_t
  data(unsigned int in_treg, unsigned int in_sreg) const
  {
    uint32_t data = this->ins_treg_func_(in_treg, in_sreg, this->data_);
    return this->ins_sreg_func_(in_treg, in_sreg, data);
  }

  // Return the relocation type of this instruction.
  unsigned int
  r_type() const
  { return this->r_type_; }

  // Return size of this instruction in bytes.
  size_t
  size() const
  { return this->size_; }

  // Return the name of this instruction.
  const std::string&
  name() const
  { return this->name_; }

 private:
  // We make the constructor private to ensure that only the factory
  // methods are used.
  inline
  Nanomips_insn_template(const char* name, uint32_t data, unsigned int type,
                         size_t size, insert_reg_func ins_treg_func,
                         insert_reg_func ins_sreg_func)
    : data_(data), r_type_(type), size_(size), name_(name),
      ins_treg_func_(ins_treg_func), ins_sreg_func_(ins_sreg_func)
  { }

  // Instruction specific data.
  uint32_t data_;
  // Relocation for this instruction.
  unsigned int r_type_;
  // Size of this instruction in bytes.
  size_t size_;
  // Instruction name for debugging.
  std::string name_;
  // Insert treg function.
  insert_reg_func ins_treg_func_;
  // Insert sreg function.
  insert_reg_func ins_sreg_func_;
};

// The Nanomips_transform_template class is to store information about a
// particular instruction transformation.

class Nanomips_transform_template
{
 public:
  // Return an array of instruction templates.
  const Nanomips_insn_template*
  insns() const
  { return this->insns_; }

  // Return the number of the instructions.
  size_t
  insn_count() const
  { return this->insn_count_; }

  // Return the size in bytes of this transformation.
  size_t
  size() const
  { return this->size_; }

 protected:
  // These are protected.  We only allow Nanomips_insn_property_table to
  // manage Nanomips_transform_template.
  Nanomips_transform_template(const Nanomips_insn_template* insns,
                              size_t insn_count);

  friend class Nanomips_insn_property_table;

 private:
  // Copying is not allowed.
  Nanomips_transform_template(const Nanomips_transform_template&);
  Nanomips_transform_template& operator=(const Nanomips_transform_template&);

  // Transform instructions.
  const Nanomips_insn_template* insns_;
  // Number of instructions.
  size_t insn_count_;
  // Size in bytes of this transformation.
  size_t size_;
};

// The Nanomips_insn_property class is to store information about a particular
// instruction that can be found in the executable section and for which we are
// doing transformations.

class Nanomips_insn_property
{
 public:
  typedef unsigned int (*extract_reg_func)(uint32_t);
  typedef unsigned int (*convert_reg_func)(unsigned int);
  typedef bool (*valid_reg_func)(unsigned int);

  // Return target register of this instruction.
  unsigned int
  treg(uint32_t insn) const
  { return this->ext_treg_func_(insn); }

  // Return source register of this instruction.
  unsigned int
  sreg(uint32_t insn) const
  { return this->ext_sreg_func_(insn); }

  // Convert target register in 16bit instruction to register
  // in 32 bit instruction.
  unsigned int
  convert_treg(uint32_t insn) const
  {
    unsigned int treg = this->treg(insn);
    return this->convert_treg_func_(treg);
  }

  // Convert source register in 16bit instruction to register
  // in 32 bit instruction.
  unsigned int
  convert_sreg(uint32_t insn) const
  {
    unsigned int sreg = this->sreg(insn);
    return this->convert_sreg_func_(sreg);
  }

  // Check if a 5-bit target register index can be abbreviated to 3 bits.
  bool
  valid_treg(uint32_t insn) const
  {
    unsigned int treg = this->treg(insn);
    return this->valid_treg_func_(treg);
  }

  // Check if a 5-bit source register index can be abbreviated to 3 bits.
  bool
  valid_sreg(uint32_t insn) const
  {
    unsigned int sreg = this->sreg(insn);
    return this->valid_sreg_func_(sreg);
  }

  // Check if a 5-bit registers can be abbreviated to 3 bits registers.
  bool
  valid_regs(uint32_t insn) const
  { return this->valid_treg(insn) && this->valid_sreg(insn); }

  // Return the name of the instruction.
  const std::string&
  name() const
  { return this->name_; }

  // Return the transform template of type TYPE.
  const Nanomips_transform_template*
  get_transform(unsigned int type) const
  {
    Nanomips_transform_map::const_iterator it = this->transforms_.find(type);
    gold_assert(it != this->transforms_.end());
    return it->second;
  }

  // Return whether there is the transform template of type TYPE.
  bool
  has_transform(unsigned int type) const
  {
    Nanomips_transform_map::const_iterator it = this->transforms_.find(type);
    return it != this->transforms_.end();
  }

 protected:
  // These are protected.  We only allow Nanomips_insn_property_table to
  // manage Nanomips_insn_property.
  Nanomips_insn_property(const unsigned int* relocs,
                         size_t reloc_num,
                         const char* name,
                         extract_reg_func treg_func,
                         convert_reg_func convert_treg_func,
                         valid_reg_func valid_treg_func,
                         extract_reg_func sreg_func,
                         convert_reg_func convert_sreg_func,
                         valid_reg_func valid_sreg_func);

  // Add the transform template of type TYPE.
  void
  add_transform(const Nanomips_transform_template* trasnform_template,
                unsigned int type)
  {
    std::pair<Nanomips_transform_map::iterator, bool> ins =
      this->transforms_.insert(std::make_pair(type, trasnform_template));

    // Make sure that we have not created another Nanomips_transform_template
    // for this instruction already.
    gold_assert(ins.second);
  }

  // Return whether relocation of type R_TYPE is against this instruction.
  bool
  reloc(unsigned int r_type) const
  {
    Unordered_set<unsigned int>::const_iterator it = this->relocs_.find(r_type);
    return it != this->relocs_.end();
  }

  friend class Nanomips_insn_property_table;

 private:
  // Copying is not allowed.
  Nanomips_insn_property(const Nanomips_insn_property&);
  Nanomips_insn_property& operator=(const Nanomips_insn_property&);

  typedef Unordered_map<unsigned int, const Nanomips_transform_template*>
      Nanomips_transform_map;

  // Instruction name.
  std::string name_;
  // Transformations for this instruction.
  Nanomips_transform_map transforms_;
  // Relocation against this instruction.
  Unordered_set<unsigned int> relocs_;
  // Extract treg function.
  extract_reg_func ext_treg_func_;
  // Convert treg function.
  convert_reg_func convert_treg_func_;
  // Valid treg function.
  valid_reg_func valid_treg_func_;
  // Extract sreg function.
  extract_reg_func ext_sreg_func_;
  // Convert sreg function.
  convert_reg_func convert_sreg_func_;
  // Valid sreg function.
  valid_reg_func valid_sreg_func_;
};

class Nanomips_insn_property_table
{
 public:
  Nanomips_insn_property_table();

  const Nanomips_insn_property*
  get_insn_property(uint32_t insn, unsigned int mask,
                    unsigned int r_type) const
  {
    Nanomips_insn_map::const_iterator p = this->insns_.find(insn & mask);
    return (p != this->insns_.end() && p->second->reloc(r_type)
            ? p->second
            : NULL);
  }

 private:
  // Copying is not allowed.
  Nanomips_insn_property_table(const Nanomips_insn_property_table&);
  Nanomips_insn_property_table& operator=(const Nanomips_insn_property_table&);

  typedef Unordered_map<uint32_t, Nanomips_insn_property*> Nanomips_insn_map;
  // Nanomips instructions.
  Nanomips_insn_map insns_;
};

} // End namespace gold.

#endif // !defined(GOLD_NANOMIPS_INSN_PROPERTY_H)
