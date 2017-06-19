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

// Types of instructions.

enum Insn_type {
  IT_STANDARD = 0,            // Regular instruction.
  IT_BEQC16 = 1,              // Special type for beqc16 instruction.
  IT_BNEC16 = 2,              // Special type for bnec16 instruction.
};

// The Nanomips_insn_property class is to store information about a particular
// relaxation or expansion.

class Nanomips_insn_property
{
 public:
  // Return the I-th instruction from the array.
  uint32_t
  insn(size_t i) const
  {
    gold_assert(i < this->insn_num_);
    return this->insns_[i];
  }

  // Return the debug message.
  const char*
  msg() const
  { return this->msg_; }

  // Return the number of bytes to add/delete.
  int
  count() const
  { return this->count_; }

  // Return the offset where to add/delete bytes starting at r_offset.
  unsigned int
  offset() const
  { return this->offset_; }

  // Return whether this is a store instruction.
  bool
  is_store() const
  { return this->is_store_; }

  // Return the instruction property of type INSN_TYPE, if there is one.
  const Nanomips_insn_property*
  get_insn_property(unsigned int insn_type) const
  {
    for (const Nanomips_insn_property* i = this; i != NULL; i = i->next_insn_)
      {
        if (i->insn_type_ == insn_type)
          return i;
      }
    return NULL;
  }

 protected:
  // These are protected.  We only allow Nanomips_reloc_property_table to
  // manage Nanomips_insn_property.
  Nanomips_insn_property(const uint32_t* insns,
                         size_t insn_num,
                         const char* msg,
                         int count,
                         unsigned int offset,
                         unsigned int insn_type,
                         bool is_store);

  // Set the instruction property of type INSN_TYPE.
  void set_insn_property(Nanomips_insn_property* pnip, unsigned int insn_type)
  {
    // Instructions with the same type are not allowed.
    for (Nanomips_insn_property* i = this; i != NULL; i = i->next_insn_)
      gold_assert(i->insn_type_ != insn_type);

    pnip->next_insn_ = this->next_insn_;
    this->next_insn_ = pnip;
  }

  friend class Nanomips_reloc_property_table;

 private:
  // Copying is not allowed.
  Nanomips_insn_property(const Nanomips_insn_property&);
  Nanomips_insn_property& operator=(const Nanomips_insn_property&);

  // Relax/expand instruction/instructions.
  const uint32_t* insns_;
  // Number of instructions.
  size_t insn_num_;
  // Debug message;
  const char* msg_;
  // Pointer to the next instruction.
  Nanomips_insn_property* next_insn_;
  // The number of bytes to add/delete.
  int count_;
  // The offset where to add/delete bytes starting at r_offset.
  unsigned int offset_;
  // The type of the instruction.
  unsigned int insn_type_;
  // Whether this is a store instruction.
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
  };

  // Relocation code represented by this.
  unsigned int
  code() const
  { return this->code_; }

  // Name of the relocation code.
  const std::string&
  name() const
  { return this->name_; }

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
  const Nanomips_insn_property*
  find_relax_match(uint32_t insn) const
  {
    if (this->relaxations_.empty())
      return NULL;

    insn &= this->mask_;
    typename Nanomips_insn_map::const_iterator p =
      this->relaxations_.find(insn);
    return (p != this->relaxations_.end() ? p->second : NULL);
  }

  // Find matching instructions for expansion.
  const Nanomips_insn_property*
  find_expand_match(uint32_t insn) const
  {
    if (this->expansions_.empty())
      return NULL;

    insn &= this->mask_;
    typename Nanomips_insn_map::const_iterator p =
      this->expansions_.find(insn);
    return (p != this->expansions_.end() ? p->second : NULL);
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

  typedef Unordered_map<uint32_t, Nanomips_insn_property*> Nanomips_insn_map;

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
  // Mask to match instructions for relaxations and expansions.
  unsigned int mask_;
  // Reference flags for this relocation.
  int reference_flags_;
  // Instruction relaxations.
  Nanomips_insn_map relaxations_;
  // Instruction expansions.
  Nanomips_insn_map expansions_;
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
  typedef Unordered_map<uint32_t, Nanomips_insn_property*> Nanomips_insn_map;

  // Copying is not allowed.
  Nanomips_reloc_property_table(const Nanomips_reloc_property_table&);
  Nanomips_reloc_property_table& operator=(const Nanomips_reloc_property_table&);

  static const unsigned int Property_table_size = 256;
  Nanomips_reloc_property* table_[Property_table_size];
};

} // End namespace gold.

#endif // !defined(GOLD_NANOMIPS_RELOC_PROPERTY_H)
