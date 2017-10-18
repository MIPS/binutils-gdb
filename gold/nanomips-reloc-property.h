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
    RT_PLACEHOLDER      // Place-holder relocations for relaxation pass.
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

  // Return the mask to match instructions.
  unsigned int
  mask() const
  { return this->mask_; }

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
  // Copying is not allowed.
  Nanomips_reloc_property_table(const Nanomips_reloc_property_table&);
  Nanomips_reloc_property_table& operator=(const Nanomips_reloc_property_table&);

  static const unsigned int Property_table_size = 256;
  Nanomips_reloc_property* table_[Property_table_size];
};

} // End namespace gold.

#endif // !defined(GOLD_NANOMIPS_RELOC_PROPERTY_H)
