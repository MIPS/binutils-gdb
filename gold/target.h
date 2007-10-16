// target.h -- target support for gold   -*- C++ -*-

// Copyright 2006, 2007 Free Software Foundation, Inc.
// Written by Ian Lance Taylor <iant@google.com>.

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

// The abstract class Target is the interface for target specific
// support.  It defines abstract methods which each target must
// implement.  Typically there will be one target per processor, but
// in some cases it may be necessary to have subclasses.

// For speed and consistency we want to use inline functions to handle
// relocation processing.  So besides implementations of the abstract
// methods, each target is expected to define a template
// specialization of the relocation functions.

#ifndef GOLD_TARGET_H
#define GOLD_TARGET_H

#include "elfcpp.h"

namespace gold
{

class General_options;
class Object;
template<int size, bool big_endian>
class Sized_relobj;
template<int size, bool big_endian>
struct Relocate_info;
class Symbol;
template<int size>
class Sized_symbol;
class Symbol_table;

// The abstract class for target specific handling.

class Target
{
 public:
  virtual ~Target()
  { }

  // Return the bit size that this target implements.  This should
  // return 32 or 64.
  int
  get_size() const
  { return this->pti_->size; }

  // Return whether this target is big-endian.
  bool
  is_big_endian() const
  { return this->pti_->is_big_endian; }

  // Machine code to store in e_machine field of ELF header.
  elfcpp::EM
  machine_code() const
  { return this->pti_->machine_code; }

  // Whether this target has a specific make_symbol function.
  bool
  has_make_symbol() const
  { return this->pti_->has_make_symbol; }

  // Whether this target has a specific resolve function.
  bool
  has_resolve() const
  { return this->pti_->has_resolve; }

  // Whether this target has a specific code fill function.
  bool
  has_code_fill() const
  { return this->pti_->has_code_fill; }

  // Return the default name of the dynamic linker.
  const char*
  dynamic_linker() const
  { return this->pti_->dynamic_linker; }

  // Return the default address to use for the text segment.
  uint64_t
  default_text_segment_address() const
  { return this->pti_->default_text_segment_address; }

  // Return the ABI specified page size.
  uint64_t
  abi_pagesize() const
  { return this->pti_->abi_pagesize; }

  // Return the common page size used on actual systems.
  uint64_t
  common_pagesize() const
  { return this->pti_->common_pagesize; }

  // This is called to tell the target to complete any sections it is
  // handling.  After this all sections must have their final size.
  void
  finalize_sections(Layout* layout)
  { return this->do_finalize_sections(layout); }

  // Return the value to use for a global symbol which needs a special
  // value in the dynamic symbol table.  This will only be called if
  // the backend first calls symbol->set_needs_dynsym_value().
  uint64_t
  dynsym_value(const Symbol* sym) const
  { return this->do_dynsym_value(sym); }

  // Return a string to use to fill out a code section.  This is
  // basically one or more NOPS which must fill out the specified
  // length in bytes.
  std::string
  code_fill(off_t length)
  { return this->do_code_fill(length); }

 protected:
  // This struct holds the constant information for a child class.  We
  // use a struct to avoid the overhead of virtual function calls for
  // simple information.
  struct Target_info
  {
    // Address size (32 or 64).
    int size;
    // Whether the target is big endian.
    bool is_big_endian;
    // The code to store in the e_machine field of the ELF header.
    elfcpp::EM machine_code;
    // Whether this target has a specific make_symbol function.
    bool has_make_symbol;
    // Whether this target has a specific resolve function.
    bool has_resolve;
    // Whether this target has a specific code fill function.
    bool has_code_fill;
    // The default dynamic linker name.
    const char* dynamic_linker;
    // The default text segment address.
    uint64_t default_text_segment_address;
    // The ABI specified page size.
    uint64_t abi_pagesize;
    // The common page size used by actual implementations.
    uint64_t common_pagesize;
  };

  Target(const Target_info* pti)
    : pti_(pti)
  { }

  // Virtual function which may be implemented by the child class.
  virtual void
  do_finalize_sections(Layout*)
  { }

  // Virtual function which may be implemented by the child class.
  virtual uint64_t
  do_dynsym_value(const Symbol*) const
  { gold_unreachable(); }

  // Virtual function which must be implemented by the child class if
  // needed.
  virtual std::string
  do_code_fill(off_t)
  { gold_unreachable(); }

 private:
  Target(const Target&);
  Target& operator=(const Target&);

  // The target information.
  const Target_info* pti_;
};

// The abstract class for a specific size and endianness of target.
// Each actual target implementation class should derive from an
// instantiation of Sized_target.

template<int size, bool big_endian>
class Sized_target : public Target
{
 public:
  // Make a new symbol table entry for the target.  This should be
  // overridden by a target which needs additional information in the
  // symbol table.  This will only be called if has_make_symbol()
  // returns true.
  virtual Sized_symbol<size>*
  make_symbol() const
  { gold_unreachable(); }

  // Resolve a symbol for the target.  This should be overridden by a
  // target which needs to take special action.  TO is the
  // pre-existing symbol.  SYM is the new symbol, seen in OBJECT.
  // VERSION is the version of SYM.  This will only be called if
  // has_resolve() returns true.
  virtual void
  resolve(Symbol*, const elfcpp::Sym<size, big_endian>&, Object*,
	  const char*)
  { gold_unreachable(); }

  // Scan the relocs for a section, and record any information
  // required for the symbol.  OPTIONS is the command line options.
  // SYMTAB is the symbol table.  OBJECT is the object in which the
  // section appears.  DATA_SHNDX is the section index that these
  // relocs apply to.  SH_TYPE is the type of the relocation section,
  // SHT_REL or SHT_RELA.  PRELOCS points to the relocation data.
  // RELOC_COUNT is the number of relocs.  LOCAL_SYMBOL_COUNT is the
  // number of local symbols.  PLOCAL_SYMBOLS points to the local
  // symbol data from OBJECT.  GLOBAL_SYMBOLS is the array of pointers
  // to the global symbol table from OBJECT.
  virtual void
  scan_relocs(const General_options& options,
	      Symbol_table* symtab,
	      Layout* layout,
	      Sized_relobj<size, big_endian>* object,
	      unsigned int data_shndx,
	      unsigned int sh_type,
	      const unsigned char* prelocs,
	      size_t reloc_count,
	      size_t local_symbol_count,
	      const unsigned char* plocal_symbols,
	      Symbol** global_symbols) = 0;

  // Relocate section data.  SH_TYPE is the type of the relocation
  // section, SHT_REL or SHT_RELA.  PRELOCS points to the relocation
  // information.  RELOC_COUNT is the number of relocs.  VIEW is a
  // view into the output file holding the section contents,
  // VIEW_ADDRESS is the virtual address of the view, and VIEW_SIZE is
  // the size of the view.
  virtual void
  relocate_section(const Relocate_info<size, big_endian>*,
		   unsigned int sh_type,
		   const unsigned char* prelocs,
		   size_t reloc_count,
		   unsigned char* view,
		   typename elfcpp::Elf_types<size>::Elf_Addr view_address,
		   off_t view_size) = 0;

 protected:
  Sized_target(const Target::Target_info* pti)
    : Target(pti)
  {
    gold_assert(pti->size == size);
    gold_assert(pti->is_big_endian ? big_endian : !big_endian);
  }
};

} // End namespace gold.

#endif // !defined(GOLD_TARGET_H)
