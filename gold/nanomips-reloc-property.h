// nanomips-reloc-property.h -- Nanomips relocation properties   -*- C++ -*-

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

#ifndef GOLD_NANOMIPS_RELOC_PROPERTY_H
#define GOLD_NANOMIPS_RELOC_PROPERTY_H

#include <string>

namespace gold
{

// Types of transformations.

enum Transform_type
{
  TT_STANDARD = 0,             // Regular transformation.
  TT_DELETE = 1,               // Delete instruction.
  TT_BEQC16 = 2,               // Special type for beqc16 instruction.
  TT_BNEC16 = 3,               // Special type for bnec16 instruction.
  TT_GPREL16_NMS = 4,          // Special type for gprel transformation.
  TT_GPREL16_WORD = 5,         // Special type for gprel transformation.
  TT_GPREL32 = 6,              // Special type for gprel transformation.
  TT_GPREL32_WORD = 7,         // Special type for gprel transformation.
  TT_GPREL_NMS = 8,            // Special type for gprel transformation.
  TT_PCREL16 = 9,              // Special type for pcrel transformation.
  TT_PCREL32 = 10,             // Special type for pcrel transformation.
  TT_PCREL_NMS = 11,           // Special type for pcrel transformation.
  TT_GOTPCREL_NMS = 12,        // Special type for pcrel GOT transformation.
  TT_GPREL_LONG = 13,          // Special type for gprel transformation.
  TT_PCREL_LONG = 14,          // Special type for pcrel transformation.
  TT_GOTPCREL_LONG = 15        // Special type for pcrel GOT transformation.
};

// Instruction information structure.

struct Insn_info
{
  // The instruction.
  uint32_t insn;
  // Relocation for instruction.
  unsigned int reloc;
  // Instruction name for debugging.
  const char* name;
};

// The Nanomips_transform_property class is to store information about a
// particular instruction transformation.

class Nanomips_transform_property
{
 public:
  // Return the I-th instruction from the array.
  uint32_t
  insn(size_t i) const
  {
    gold_assert(i < this->insn_num_);
    return this->insns_[i].insn;
  }

  // Return the I-th relocation from the array.
  unsigned int
  reloc(size_t i) const
  {
    gold_assert(i < this->insn_num_);
    return this->insns_[i].reloc;
  }

  // Return the I-th instruction name from the array.
  const char*
  insn_name(size_t i) const
  {
    gold_assert(i < this->insn_num_);
    return this->insns_[i].name;
  }

  // Return the name of the instruction for which we are doing transformation.
  const char*
  name() const
  { return this->name_; }

  // Return the number of the instructions.
  size_t
  insn_num() const
  { return this->insn_num_; }

  // Return the number of bytes to add/delete.
  int
  count() const
  { return this->count_; }

  // Return whether this is a store instruction.
  bool
  is_store() const
  { return this->is_store_; }

  // Return type of the transformation.
  unsigned int
  type() const
  { return this->type_; }

  // Return the transformation property of type TYPE, if there is one.
  const Nanomips_transform_property*
  get_transform_property(unsigned int type) const
  {
    for (const Nanomips_transform_property* i = this;
         i != NULL;
         i = i->next_transform_)
      {
        if (i->type_ == type)
          return i;
      }
    gold_unreachable();
  }

  // Return whether there is the transform property of type TYPE.
  bool
  has_transform_property(unsigned int type) const
  {
    for (const Nanomips_transform_property* i = this;
         i != NULL;
         i = i->next_transform_)
      {
        if (i->type_ == type)
          return true;
      }
    return false;
  }

 protected:
  // These are protected.  We only allow Nanomips_reloc_property_table to
  // manage Nanomips_transform_property.
  Nanomips_transform_property(const Insn_info* insns,
                              size_t insn_num,
                              const char* name,
                              int count,
                              unsigned int type,
                              bool is_store);

  // Set the transform property of type TYPE.
  void set_transform_property(Nanomips_transform_property* pntp,
                              unsigned int type)
  {
    // Transformations with the same type are not allowed.
    for (Nanomips_transform_property* i = this;
         i != NULL;
         i = i->next_transform_)
      gold_assert(i->type_ != type);

    pntp->next_transform_ = this->next_transform_;
    this->next_transform_ = pntp;
  }

  friend class Nanomips_reloc_property_table;

 private:
  // Copying is not allowed.
  Nanomips_transform_property(const Nanomips_transform_property&);
  Nanomips_transform_property& operator=(const Nanomips_transform_property&);

  // Transform instructions.
  const Insn_info* insns_;
  // Number of instructions.
  size_t insn_num_;
  // Instruction name.
  const char* name_;
  // Pointer to the next transformation.
  Nanomips_transform_property* next_transform_;
  // The number of bytes to add/delete.
  int count_;
  // The type of the transformation.
  unsigned int type_;
  // Whether this is a store instruction for which we are doing transformation.
  bool is_store_;
};

// The Nanomips_reloc_property class is to store information about a particular
// relocation code.

class Nanomips_reloc_property
{
 public:
  // Types of relocation codes.
  enum Reloc_type
  {
    RT_NONE,            // No relocation type.
    RT_STATIC,          // Relocations processed by static linkers.
    RT_DYNAMIC,         // Relocations processed by dynamic linkers.
    RT_PLACEHOLDER,     // Place-holder relocations for relaxation pass.
    RT_GOT,             // GOT relocation.
  };

  // Relocation code represented by this.
  unsigned int
  code() const
  { return this->code_; }

  // Name of the relocation code.
  const std::string&
  name() const
  { return this->name_; }

  // Return whether this is a GOT relocation.
  bool
  got() const
  { return this->reloc_type_ == RT_GOT; }

  // Return whether this is a placeholder relocation.
  bool
  placeholder() const
  { return this->reloc_type_ == RT_PLACEHOLDER; }

  // The size of instruction for which we are doing relocation.
  unsigned int
  size() const
  { return this->size_; }

  // Return the number of bits in the instruction to be relocated.
  unsigned int
  bitsize() const
  { return this->bitsize_;}

  // Return reference flags for this relocation.
  int
  reference_flags() const
  { return this->reference_flags_; }

  // Return whether we need to shuffle the bits for this relocation.
  bool
  shuffle_reloc() const
  { return this->size_ == 32 || this->size_ == 48;}

  // Find matching instruction for relaxation.
  const Nanomips_transform_property*
  find_relax_match(uint32_t insn) const
  {
    Nanomips_transform_map::const_iterator p =
      this->relaxations_.find(insn & this->mask_);
    return (p != this->relaxations_.end() ? p->second : NULL);
  }

  // Find matching instructions for expansion.
  const Nanomips_transform_property*
  find_expand_match(uint32_t insn) const
  {
    Nanomips_transform_map::const_iterator p =
      this->expansions_.find(insn & this->mask_);
    return (p != this->expansions_.end() ? p->second : NULL);
  }

  // Find matching instructions for GOT reloc transformations.
  const Nanomips_transform_property*
  find_got_transform_match(uint32_t insn) const
  {
    Nanomips_transform_map::const_iterator p =
      this->got_transform_.find(insn & this->mask_);
    return (p != this->got_transform_.end() ? p->second : NULL);
  }

 protected:
  // These are protected.  We only allow Nanomips_reloc_property_table to
  // manage Nanomips_reloc_property.
  Nanomips_reloc_property(unsigned int code,
                          const char* name,
                          Reloc_type reloc_type,
                          unsigned int size,
                          unsigned int bitsize,
                          unsigned int mask,
                          int reference_flags);

  friend class Nanomips_reloc_property_table;

 private:
  // Copying is not allowed.
  Nanomips_reloc_property(const Nanomips_reloc_property&);
  Nanomips_reloc_property& operator=(const Nanomips_reloc_property&);

  typedef Unordered_map<uint32_t, Nanomips_transform_property*>
        Nanomips_transform_map;

  // Relocation code.
  unsigned int code_;
  // Relocation name.
  std::string name_;
  // Type of the relocation.
  Reloc_type reloc_type_;
  // The size of the instruction for which we are doing relocation.
  unsigned int size_;
  // The number of bits in the instruction to be relocated.
  unsigned int bitsize_;
  // Mask to match instructions.
  unsigned int mask_;
  // Reference flags for this relocation.
  int reference_flags_;
  // Instruction relaxations.
  Nanomips_transform_map relaxations_;
  // Instruction expansions.
  Nanomips_transform_map expansions_;
  // GOT reloc transformations.
  Nanomips_transform_map got_transform_;
};

class Nanomips_reloc_property_table
{
 public:
  Nanomips_reloc_property_table();

  const Nanomips_reloc_property*
  get_reloc_property(unsigned int code) const
  {
    gold_assert(code < Property_table_size);
    return this->table_[code];
  }

 private:
  typedef Unordered_map<uint32_t, Nanomips_transform_property*>
      Nanomips_transform_map;

  // Copying is not allowed.
  Nanomips_reloc_property_table(const Nanomips_reloc_property_table&);
  Nanomips_reloc_property_table& operator=(const Nanomips_reloc_property_table&);

  static const unsigned int Property_table_size = 256;
  Nanomips_reloc_property* table_[Property_table_size];
};

} // End namespace gold.

#endif // !defined(GOLD_NANOMIPS_RELOC_PROPERTY_H)
