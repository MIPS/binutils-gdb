// nanomips.cc -- nanomips target support for gold.

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

#include <algorithm>
#include <set>
#include <sstream>
#include "demangle.h"

#include "elfcpp.h"
#include "parameters.h"
#include "reloc.h"
#include "nanomips.h"
#include "object.h"
#include "symtab.h"
#include "layout.h"
#include "output.h"
#include "target.h"
#include "target-reloc.h"
#include "target-select.h"
#include "errors.h"
#include "gc.h"
#include "attributes.h"
#include "nanomips-reloc-property.h"
#include "nanomips-insn-property.h"

namespace
{
using namespace gold;

template<int size, bool big_endian>
class Target_nanomips;

template<int size, bool big_endian>
class Nanomips_relobj;

template<int size, bool big_endian>
class Nanomips_relocate_functions;

template<int size>
class Nanomips_symbol_hash;

template<int size>
class Nanomips_symbol;

template<int size, bool big_endian>
class Nanomips_output_data_got;

template<int size, bool big_endian>
class Nanomips_output_data_stubs;

class Nanomips_input_section;

// The types of GOT entries needed for this platform.
enum Got_type
{
  GOT_TYPE_STANDARD = 0,      // GOT entry for a regular symbol
};

enum Overflow_check
{
  // No overflow checking.
  CHECK_NONE,
  // Check for overflow of a signed value.
  CHECK_SIGNED,
  // Check for overflow of an unsigned value.
  CHECK_UNSIGNED
};

Nanomips_reloc_property_table* nanomips_reloc_property_table = NULL;
Nanomips_insn_property_table* nanomips_insn_property_table = NULL;

// .nanoMIPS.abiflags section content

template<bool big_endian>
struct Nanomips_abiflags
{
  typedef typename elfcpp::Swap<8, big_endian>::Valtype Valtype8;
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;

  Nanomips_abiflags()
    : version(0), isa_level(0), isa_rev(0), gpr_size(0), cpr1_size(0),
      cpr2_size(0), fp_abi(0), isa_ext(0), ases(0), flags1(0), flags2(0)
  { }

  // Version of flags structure.
  Valtype16 version;
  // The level of the ISA.
  Valtype8 isa_level;
  // The revision of the ISA.
  Valtype8 isa_rev;
  // The size of general purpose registers.
  Valtype8 gpr_size;
  // The size of co-processor 1 registers.
  Valtype8 cpr1_size;
  // The size of co-processor 2 registers.
  Valtype8 cpr2_size;
  // The floating-point ABI.
  Valtype8 fp_abi;
  // Processor-specific extension.
  Valtype32 isa_ext;
  // Mask of ASEs used.
  Valtype32 ases;
  // Mask of general flags.
  Valtype32 flags1;
  Valtype32 flags2;
};

// This struct represents a .nanoMIPS.stubs footer.

struct Nanomips_stubs_footer
{
  Nanomips_stubs_footer()
    : offset(-1ULL), bias(0)
  { }

  // Offset within the section of this footer.
  uint64_t offset;
  // Bias for the group of entries.
  size_t bias;
};

// This struct represents a .nanoMIPS.stubs entry.

template<int size>
struct Nanomips_stubs_entry
{
  Nanomips_stubs_entry(Nanomips_symbol<size>* _sym)
    : sym(_sym), footer(NULL), indx(0)
  { }

  // The global symbol corresponding to this entry.
  Nanomips_symbol<size>* sym;
  // Footer for this entry.
  Nanomips_stubs_footer* footer;
  // JMPREL index of this entry.
  size_t indx;
};

// A class to handle the .nanoMIPS.stubs data.

template<int size, bool big_endian>
class Nanomips_output_data_stubs : public Output_section_data
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef std::vector<Nanomips_stubs_entry<size> >
      Nanomips_stubs_entries;
  typedef std::vector<Nanomips_stubs_footer*> Nanomips_stubs_footers;
  typedef Output_data_reloc<elfcpp::SHT_REL, true, size, big_endian>
      Reloc_section;

 public:
  Nanomips_output_data_stubs(Target_nanomips<size, big_endian>* target,
                             Layout* layout)
    : Output_section_data(size == 32 ? 4 : 8), target_(target), entries_(),
      footers_()
  {
    this->rel_ = new Reloc_section(false);
    layout->add_output_section_data(".rel.nanoMIPS.stubs", elfcpp::SHT_REL,
                                    elfcpp::SHF_ALLOC, this->rel_,
                                    ORDER_DYNAMIC_PLT_RELOCS, false);
  }

  // Add an entry to the .nanoMIPS.stubs.
  void
  add_entry(Nanomips_symbol<size>* nanomips_sym)
  {
    Nanomips_stubs_entry<size> entry(nanomips_sym);
    this->entries_.push_back(entry);
  }

  // Return the .rel.nanoMIPS.stubs section data.
  Reloc_section*
  rel_stubs() const
  { return this->rel_; }

  // Return output address of a stub.
  Address
  stub_address(const Nanomips_symbol<size>* sym) const
  { return this->address() + sym->lazy_stub_offset(); }

  // Return .nanoMIPS.stubs entries.
  Nanomips_stubs_entries&
  nanomips_stubs_entries()
  { return this->entries_; }

  // Set stub offsets for symbols.
  void
  set_lazy_stub_offsets();

 protected:
  // Write to a map file.
  void
  do_print_to_mapfile(Mapfile* mapfile) const
  { mapfile->print_output_data(this, _(".nanoMIPS.stubs")); }

  void
  do_adjust_output_section(Output_section* os)
  { os->set_entsize(0); }

  // Write out the .nanoMIPS.stubs data.
  void
  do_write(Output_file*);

 private:
  // Set offset and bias for footer if needed, and return new offset.
  uint64_t
  set_footer_offset_and_bias(Nanomips_stubs_footer* footer,
                             uint64_t offset, size_t bias)
  {
    if (footer->offset != -1ULL)
      return offset;

    footer->offset = offset;
    footer->bias = bias;
    return offset + this->footer_size(bias > 0);
  }

  // Create a new footer.
  Nanomips_stubs_footer*
  create_footer()
  {
    Nanomips_stubs_footer* footer = new Nanomips_stubs_footer();
    this->footers_.push_back(footer);
    return footer;
  }

  // Return the size of the stub.
  unsigned int
  stub_size() const
  { return 6; }

  // Return the size of the footer.
  unsigned int
  footer_size(bool is_big) const
  { return is_big ? 14 : 8; }

  static const uint32_t lazy_stub_entry[];
  static const uint32_t lazy_stub_normal_footer[];
  static const uint32_t lazy_stub_big_footer[];

  // The target.
  Target_nanomips<size, big_endian>* target_;
  // The reloc section.
  Reloc_section* rel_;
  // .nanoMIPS.stubs entries.
  Nanomips_stubs_entries entries_;
  // .nanoMIPS.stubs footers.
  Nanomips_stubs_footers footers_;
};

// Nanomips_output_data_got class.

template<int size, bool big_endian>
class Nanomips_output_data_got
  : public Output_data_got<size, big_endian>
{
  typedef Output_data_reloc<elfcpp::SHT_REL, true, size, big_endian>
      Reloc_section;
  typedef Unordered_set<Nanomips_symbol<size>*, Nanomips_symbol_hash<size> >
      Nanomips_got_call_set;

 public:
  Nanomips_output_data_got(Target_nanomips<size, big_endian>* target)
    : Output_data_got<size, big_endian>(), target_(target), got_call_()
  {
    this->set_addralign(4096);
  }

  // Reserve GOT entry for a R_NANOMIPS_GOT_CALL relocation
  // against NANOMIPS_SYM for which we may need to create
  // a lazy-binding stub.
  void
  record_got_call_symbol(Nanomips_symbol<size>* nanomips_sym)
  {
    if (!nanomips_sym->has_got_offset(GOT_TYPE_STANDARD))
      this->got_call_.insert(nanomips_sym);
  }

  // Finalize symbols against R_NANOMIPS_GOT_CALL relocation.
  void
  finalize_got_call_symbols(Layout* layout);

 protected:
  // Write out the GOT table.
  void
  do_write(Output_file*);

 private:
  // The target.
  Target_nanomips<size, big_endian>* target_;
  // R_NANOMIPS_GOT_CALL symbols for which we may need to
  // create a lazy-binding stubs.
  Nanomips_got_call_set got_call_;
};

// Hash for Nanomips_symbol.

template<int size>
class Nanomips_symbol_hash
{
 public:
  size_t
  operator()(Nanomips_symbol<size>* sym) const
  { return sym->hash(); }
};

// Nanomips_symbol class.  Holds additional symbol information
// needed for Nanomips.

template<int size>
class Nanomips_symbol : public Sized_symbol<size>
{
 public:
  Nanomips_symbol()
    : no_lazy_stub_(false), lazy_stub_offset_(-1ULL)
  { }

  // Downcast a base pointer to a Nanomips_symbol pointer.
  static Nanomips_symbol<size>*
  as_nanomips_sym(Symbol* sym)
  { return static_cast<Nanomips_symbol<size>*>(sym); }

  // Downcast a base pointer to a Nanomips_symbol pointer.
  static const Nanomips_symbol<size>*
  as_nanomips_sym(const Symbol* sym)
  { return static_cast<const Nanomips_symbol<size>*>(sym); }

  // Return whether we must not create a lazy-binding stub for this symbol.
  bool
  no_lazy_stub() const
  { return this->no_lazy_stub_; }

  // Set that we must not create a lazy-binding stub for this symbol.
  void
  set_no_lazy_stub()
  { this->no_lazy_stub_ = true; }

  // Return the offset of the lazy-binding stub for this symbol from the start
  // of .nanoMIPS.stubs section.
  uint64_t
  lazy_stub_offset() const
  {
    gold_assert(this->lazy_stub_offset_ != -1ULL);
    return this->lazy_stub_offset_;
  }

  // Set the offset of the lazy-binding stub for this symbol from the start
  // of .nanoMIPS.stubs section.
  void
  set_lazy_stub_offset(uint64_t offset)
  {
    gold_assert(this->lazy_stub_offset_ == -1ULL);
    this->lazy_stub_offset_ = offset;
  }

  // Return the hash of this symbol.
  size_t
  hash() const
  { return gold::string_hash<char>(this->name()); }

 private:
  // Whether we must not create a lazy-binding stub for this symbol.
  // This is true if the symbol has relocations related to taking the
  // function's address.
  bool no_lazy_stub_;

  // The offset of the lazy-binding stub for this symbol from the start of
  // .nanoMIPS.stubs section.
  uint64_t lazy_stub_offset_;
};

// Nanomips output section class.  This is defined mainly to sort
// sections by reference.

template<int size, bool big_endian>
class Nanomips_output_section : public Output_section
{
 public:
  Nanomips_output_section(const char* name, elfcpp::Elf_Word type,
                          elfcpp::Elf_Xword flags)
    : Output_section(name, type, flags)
  { }

  ~Nanomips_output_section()
  { }

  // Go over all input sections and sort them by reference.
  void
  sort_sections_by_reference();

 protected:
  // Write to a map file.
  void
  do_print_to_mapfile(Mapfile* mapfile) const;

 private:
  // For convenience.
  typedef Output_section::Input_section Input_section;
  typedef Output_section::Input_section_list Input_section_list;

  // This class is used to sort sections by reference.
  class Nanomips_sort_entry
  {
   public:
    Nanomips_sort_entry(const Input_section& input_section, size_t index)
      : input_section_(input_section), ref_count_(0), index_(index),
        section_size_(0), addralign_(1)
    { }

    // Return the simple input section.
    const Output_section::Input_section&
    input_section() const
    { return this->input_section_; }

    // Return the reference count.
    unsigned int
    ref_count() const
    { return this->ref_count_; }

    // Set the reference count.
    void
    set_ref_count(unsigned int ref_count)
    { this->ref_count_ = ref_count; }

    // The index of this entry in the original list.  This is used to
    // make the sort stable.
    size_t
    index() const
    { return this->index_; }

    // Return the section size.
    uint64_t
    section_size() const
    { return this->section_size_; }

    // Set the section size.
    void
    set_section_size(uint64_t section_size)
    { this->section_size_ = section_size; }

    // Return the address alignment.
    uint64_t
    addralign() const
    { return this->addralign_; }

    // Return the address alignment.
    void
    set_addralign(uint64_t addralign)
    { this->addralign_ = addralign; }

   private:
    // The Input_section we are sorting.
    Input_section input_section_;
    // Reference count.
    unsigned int ref_count_;
    // The index of this Input_section in the original list.
    size_t index_;
    // Section size.
    uint64_t section_size_;
    // Address alignment.
    uint64_t addralign_;
  };

  // This is the sort comparison function for sorting sections
  // by reference.
  struct Nanomips_sort_by_reference
  {
    bool
    operator()(const Nanomips_sort_entry& s1,
               const Nanomips_sort_entry& s2) const
    {
      // Sort by most commonly referenced sections.
      if (s1.ref_count() != s2.ref_count())
        return s1.ref_count() > s2.ref_count();

      // Otherwise we keep the input order.
      return s1.index() < s2.index();
    }
  };

  // This is the sort comparison function for sorting sections
  // by size and alignment.
  struct Nanomips_sort_by_size_and_alignment
  {
    bool
    operator()(const Nanomips_sort_entry& s1,
               const Nanomips_sort_entry& s2) const
    {
      // Sort by ascending size.
      if (s1.section_size() != s2.section_size())
        return s1.section_size() < s2.section_size();

      // When the sections are the same size, we sort them by
      // alignment, largest alignment first.
      if (s1.addralign() != s2.addralign())
        return s1.addralign() > s2.addralign();

      // Otherwise we keep the input order.
      return s1.index() < s2.index();
    }
  };

  // Get the input sections that are referenced.  If NON_REF_SECTIONS is
  // not NULL, add sections that are not referenced.
  template<typename Input_sections>
  void
  get_ref_sections(const Input_sections& sections,
                   std::vector<Nanomips_sort_entry>* ref_sections,
                   std::vector<Nanomips_sort_entry>* non_ref_sections) const;
};

// Nanomips_relobj class.

template<int size, bool big_endian>
class Nanomips_relobj : public Sized_relobj_file<size, big_endian>
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename Sized_relobj_file<size, big_endian>::Size_type Size_type;
  typedef Unordered_map<unsigned int, unsigned int> Input_section_ref;

 public:
  Nanomips_relobj(const std::string& name, Input_file* input_file, off_t offset,
                  const typename elfcpp::Ehdr<size, big_endian>& ehdr)
    : Sized_relobj_file<size, big_endian>(name, input_file, offset, ehdr),
      input_section_ref_(), local_symbol_size_(), local_symbol_is_function_(),
      processor_specific_flags_(0), merge_processor_specific_data_(true),
      attributes_section_data_(NULL), abiflags_(NULL)
  { }

  ~Nanomips_relobj()
  { delete this->attributes_section_data_; }

  // Downcast a base pointer to a Nanomips_relobj pointer.  This is
  // not type-safe but we only use Nanomips_relobj not the base class.
  static Nanomips_relobj<size, big_endian>*
  as_nanomips_relobj(Relobj* relobj)
  { return static_cast<Nanomips_relobj<size, big_endian>*>(relobj); }

  // Downcast a base pointer to a Nanomips_relobj pointer.  This is
  // not type-safe but we only use Nanomips_relobj not the base class.
  static const Nanomips_relobj<size, big_endian>*
  as_nanomips_relobj(const Relobj* relobj)
  { return static_cast<const Nanomips_relobj<size, big_endian>*>(relobj); }

  // Scan all relocation sections for instruction transformation.
  bool
  scan_sections_for_transform(Target_nanomips<size, big_endian>*,
                              const Symbol_table*, const Layout*);

  // Adjust values of the local symbols.  Also adjust sizes of the function
  // symbols.  This is used in a relaxation passes.
  void
  adjust_local_symbols(Address, unsigned int, int);

  // Adjust values of the global symbols.  Also adjust sizes of the function
  // symbols.  This is used in a relaxation passes.
  void
  adjust_global_symbols(Address, unsigned int, int);

  // Convert regular input section with index SHNDX to a relaxed section.
  void
  convert_input_section_to_relaxed_section(unsigned shndx)
  {
    this->set_section_offset(shndx, -1ULL);
    this->set_relocs_must_follow_section_writes();
  }

  // Processor-specific flags in ELF file header.  This is valid only after
  // reading symbols.
  elfcpp::Elf_Word
  processor_specific_flags() const
  { return this->processor_specific_flags_; }

  // Whether a local symbol is a function.  This is only valid after
  // do_count_local_symbol is called.
  bool
  local_symbol_is_function(unsigned int symndx) const
  {
    gold_assert(symndx < this->local_symbol_is_function_.size());
    return this->local_symbol_is_function_[symndx];
  }

  bool
  do_local_symbol_size_changed() const
  { return true; }

  // Return the local symbol size.  This is only valid after
  // do_count_local_symbol is called.
  Size_type
  do_local_symbol_size(unsigned int symndx) const
  {
    gold_assert(symndx < this->local_symbol_size_.size());
    return this->local_symbol_size_[symndx];
  }

  // Set the local symbol size.
  void
  set_local_symbol_size(unsigned int symndx, Size_type symsize)
  {
    gold_assert(symndx < this->local_symbol_size_.size());
    this->local_symbol_size_[symndx] = symsize;
  }

  // Return the name of the local symbol.  For section symbols, return the
  // section name with addend.
  std::string
  local_symbol_name(unsigned symndx,
                    typename elfcpp::Elf_types<size>::Elf_Swxword r_addend);

  // Increase the input section reference.
  void
  add_input_section_ref(unsigned int shndx)
  { ++this->input_section_ref_[shndx]; }

  // Decrease the input section reference.
  void
  remove_input_section_ref(unsigned int shndx)
  {
    gold_assert(this->input_section_ref_[shndx] != 0);
    --this->input_section_ref_[shndx];
  }

  // Return the number of how many times section has been referenced with
  // the lw[gp]/sw[gp] instruction.
  unsigned int
  input_section_ref(unsigned int shndx) const
  {
    typename Input_section_ref::const_iterator it =
      this->input_section_ref_.find(shndx);
    return it != this->input_section_ref_.end() ? it->second : 0;
  }

  // Return whether we want to merge processor-specific data.
  bool
  merge_processor_specific_data() const
  { return this->merge_processor_specific_data_; }

  // This is the contents of the .nanoMIPS.abiflags section if there is one.
  Nanomips_abiflags<big_endian>*
  abiflags()
  { return this->abiflags_; }

  // This is the contents of the .gnu.attribute section if there is one.
  const Attributes_section_data*
  attributes_section_data() const
  { return this->attributes_section_data_; }

  // Return whether this object is not using nanoMIPS Subset.
  bool
  xlp() const
  {
    if (this->abiflags_ == NULL)
      return false;

    return (this->abiflags_->ases & elfcpp::AFL_ASE_xNMS) != 0;
  }

  // Return whether all data access in this object is GP-relative.
  bool
  pid() const
  { return (this->processor_specific_flags_ & elfcpp::EF_NANOMIPS_PID) != 0; }

  // Return whether this object is safe to relax instructions.
  bool
  safe_to_relax() const
  {
    elfcpp::Elf_Word linkrelax = elfcpp::EF_NANOMIPS_LINKRELAX;
    return (this->processor_specific_flags_ & linkrelax) != 0;
  }

  // Return whether this object uses PC-relative addressing.
  bool
  pcrel() const
  { return (this->processor_specific_flags_ & elfcpp::EF_NANOMIPS_PCREL) != 0; }

 protected:
  // Count the local symbols.
  void
  do_count_local_symbols(Stringpool_template<char>*,
                         Stringpool_template<char>*);

  virtual void
  do_relocate_sections(
      const Symbol_table* symtab, const Layout* layout,
      const unsigned char* pshdrs, Output_file* of,
      typename Sized_relobj_file<size, big_endian>::Views* pviews);

  // Read the symbol information.
  void
  do_read_symbols(Read_symbols_data* sd);

 private:
  // Whether a section needs to be scanned for relocation relaxations
  // or expansions.
  bool
  section_needs_reloc_scanning(const elfcpp::Shdr<size, big_endian>&,
                               const Relobj::Output_sections&,
                               const Symbol_table*, const unsigned char*);

  // Whether a section is a scannable for instruction transformations.
  bool
  section_is_scannable(const elfcpp::Shdr<size, big_endian>&, unsigned int,
                       const Output_section*, const Symbol_table*);

  // A map to track the number of how many times input section has been
  // referenced with lw[gp]/sw[gp] instruction.
  Input_section_ref input_section_ref_;

  // Size of the local symbols.
  std::vector<Size_type> local_symbol_size_;

  // Bit vector to tell if a local symbol is a function or not.
  std::vector<bool> local_symbol_is_function_;

  // processor-specific flags in ELF file header.
  elfcpp::Elf_Word processor_specific_flags_;

  // Whether we merge processor-specific data of this object to output.
  bool merge_processor_specific_data_;

  // Object attributes if there is a .gnu.attributes section or NULL.
  Attributes_section_data* attributes_section_data_;

  // Object abiflags if there is a .nanoMIPS.abiflags section or NULL.
  Nanomips_abiflags<big_endian>* abiflags_;
};

// A class to wrap an ordinary input section.

class Nanomips_input_section : public Output_relaxed_input_section
{
 public:
  Nanomips_input_section(Relobj* relobj, unsigned int shndx,
                         Output_section* os, unsigned int reloc_size)
    : Output_relaxed_input_section(relobj, shndx, 1),
      addralign_(1), cond_branches_(), contents_(), relocs_(),
      reloc_size_(reloc_size)
  {
    this->set_output_section(os);

    std::vector<Output_relaxed_input_section*> new_relaxed;
    new_relaxed.push_back(this);
    os->convert_input_sections_to_relaxed_sections(new_relaxed);
  }

  ~Nanomips_input_section()
  {
    delete[] this->contents_.data;
    delete[] this->relocs_.data;
  }

  struct Cond_branch
  {
    Cond_branch(unsigned int reloc_, uint64_t offset_, uint64_t destination_)
      : reloc(reloc_), offset(offset_), destination(destination_)
    { }

    // Relocation (this can only be PC14_S1 or PC11_S1).
    unsigned int reloc;
    // Offset to the conditional branch within the section.
    uint64_t offset;
    // Destination address.
    uint64_t destination;
  };

  typedef std::vector<Cond_branch> Conditional_branches;

  // Initialize.
  void
  init(unsigned int reloc_shndx);

  // Return the contents of the text section.
  unsigned char*
  section_contents()
  { return this->contents_.data; }

  // Return the relocations for this section.
  const unsigned char*
  relocs() const
  { return this->relocs_.data; }

  // Return the relocations for this section.
  unsigned char*
  relocs()
  { return this->relocs_.data; }

  // Delete the bytes for instruction transformation.
  void
  delete_bytes(size_t pos, size_t size)
  {
    memmove(this->contents_.data + pos - size, this->contents_.data + pos,
            (this->contents_.len - pos));
    this->contents_.len -= size;
  }

  // Add the bytes for instruction transformation.
  void
  add_bytes(size_t pos, size_t size)
  {
    if (this->contents_.len + size > this->contents_.alc)
      {
        this->contents_.alc *= 2;
        this->contents_.data =
          static_cast<unsigned char*>(realloc(this->contents_.data,
                                              this->contents_.alc));
        if (this->contents_.data == NULL)
          gold_nomem();
      }
    memmove(this->contents_.data + pos + size, this->contents_.data + pos,
            (this->contents_.len - pos));
    this->contents_.len += size;
  }

  // Add new relocation.
  void
  add_reloc(unsigned char* new_reloc, unsigned int reloc_size)
  {
    gold_assert(this->reloc_size_ == reloc_size);
    if (this->relocs_.len + reloc_size > this->relocs_.alc)
      {
        this->relocs_.alc *= 2;
        this->relocs_.data =
          static_cast<unsigned char*>(realloc(this->relocs_.data,
                                              this->relocs_.alc));
        if (this->relocs_.data == NULL)
          gold_nomem();
      }
    memcpy(this->relocs_.data + this->relocs_.len, new_reloc, reloc_size);
    this->relocs_.len += reloc_size;
  }

  // Return the number of relocations.
  size_t
  reloc_count() const
  { return this->relocs_.len / this->reloc_size_; }

  // Add relocation for conditional branch.  Set the destination address to
  // point to location after bc instruction.
  void
  add_branch_reloc(unsigned int reloc, uint64_t address)
  { this->cond_branches_.push_back(Cond_branch(reloc, address, address + 8)); }

  // Return the conditional branch relocations.
  Conditional_branches*
  branches()
  { return &this->cond_branches_; }

  // Downcast a base pointer to a Mips_input_section pointer.  This is
  // not type-safe but we only use Mips_input_section not the base class.
  static const Nanomips_input_section*
  as_nanomips_input_section(const Output_relaxed_input_section* poris)
  { return static_cast<const Nanomips_input_section*>(poris); }

 protected:
  // Write out this input section.
  void
  do_write(Output_file*);

  // Set the final size.
  void
  set_final_data_size()
  {
    off_t off = convert_types<off_t, size_t>(this->contents_.len);
    this->set_data_size(off);
  }

  // Output offset.
  bool
  do_output_offset(const Relobj* object, unsigned int shndx,
                   section_offset_type offset,
                   section_offset_type* poutput) const
  {
    if ((object == this->relobj())
        && (shndx == this->shndx())
        && (offset >= 0)
        && (offset <=
            convert_types<section_offset_type, size_t>(this->contents_.len)))
      {
        *poutput = offset;
         return true;
      }
    else
      return false;
  }

  // Return required alignment of this.
  uint64_t
  do_addralign() const
  { return this->addralign_; }

 private:
  // Copying is not allowed.
  Nanomips_input_section(const Nanomips_input_section&);
  Nanomips_input_section& operator=(const Nanomips_input_section&);

  struct Section_contents
  {
    Section_contents()
      : len(0), alc(0), data(NULL)
    { }

    // Length of data in buffer.
    size_t len;
    // Allocated size of buffer.
    size_t alc;
    // Buffer.
    unsigned char *data;
  };

  // Address alignment.
  uint64_t addralign_;
  // Conditional branches whose targets are out of the range limits.
  Conditional_branches cond_branches_;
  // Contents of the text section.
  Section_contents contents_;
  // The relocations for this section.
  Section_contents relocs_;
  // The size of the one reloc in the relocation section.
  unsigned int reloc_size_;
};

// The class which implements transformations.

template<int size, bool big_endian>
class Nanomips_transformations
{
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_transformations(Nanomips_relobj<size, big_endian>* relobj,
                           Relocatable_relocs* rr, bool is_relax,
                           unsigned int insn_reloc)
    : relobj_(relobj), rr_(rr), insn_reloc_(insn_reloc), is_relax_(is_relax)
  { }

  // Return true if the length of this instruction is forced to an explicit
  // size.  These instructions are marked with R_NANOMIPS_FIXED or
  // R_NANOMIPS_INSN[32/16] relocations.
  inline bool
  fixed_insn(Address offset, size_t relnum, size_t reloc_count,
             const unsigned char* prelocs);

  // Transform instruction.
  inline void
  transform(const Nanomips_transform_template* transform_template,
            const Nanomips_insn_property* insn_property,
            Nanomips_input_section* input_section,
            unsigned int type,
            size_t relnum,
            uint32_t insn);

  // Read nanoMIPS instruction.
  uint32_t
  read_insn(const unsigned char* view, unsigned int insn_size)
  {
    switch (insn_size)
      {
      case 32:
        {
          typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
          Valtype16 first = elfcpp::Swap<16, big_endian>::readval(view);
          Valtype16 second = elfcpp::Swap<16, big_endian>::readval(view + 2);
          return (first << 16 | second);
        }
      case 16:
      case 48:
        return elfcpp::Swap<16, big_endian>::readval(view);
      default:
        gold_unreachable();
      }
  }

  // For debugging purposes.
  void
  print(const Nanomips_transform_template* trasnform_template,
        const std::string& insn_name,
        const Symbol* gsym,
        unsigned int r_sym,
        Address r_offset,
        typename elfcpp::Elf_types<size>::Elf_Swxword r_addend,
        unsigned int shndx)
  {
    const std::string& obj_name = this->relobj_->name();
    const std::string sec_name = this->relobj_->section_name(shndx);
    const Nanomips_insn_template* insns = trasnform_template->insns();
    size_t insn_count = trasnform_template->insn_count();

    fprintf(stderr, "%s: %s(%s+%#lx): %s is %s",
            program_name, obj_name.c_str(), sec_name.c_str(),
            (unsigned long) r_offset, insn_name.c_str(),
            insn_count == 0 ? "removed" : "transformed into");

    bool need_comma = false;
    for (size_t i = 0; i < insn_count; ++i)
      {
        if (need_comma)
          fprintf(stderr, ",");
        fprintf(stderr, " %s", insns[i].name().c_str());
        need_comma = true;
      }

    if (gsym == NULL)
      fprintf(stderr, " for local symbol '%s' with index %u\n",
              this->relobj_->local_symbol_name(r_sym, r_addend).c_str(),
              r_sym);
    else
      fprintf(stderr, " for global symbol '%s'\n", gsym->name());
  }

 protected:
  // Return the type of the transformation for code and data models.
  inline unsigned int
  get_type(const Symbol* gsym,
           const Symbol_value<size>* psymval,
           const Nanomips_insn_property* insn_property,
           const elfcpp::Rela<size, big_endian>& reloc,
           size_t,
           uint32_t insn,
           Address address,
           Address gp);

  // Check for the relocation overflow.
  template<int valsize>
  inline bool
  check_overflow(Valtype value, Overflow_check check)
  {
    switch (check)
      {
      case CHECK_SIGNED:
        return (size == 32 ? Bits<valsize>::has_overflow32(value)
                           : Bits<valsize>::has_overflow(value));
      case CHECK_UNSIGNED:
        return (size == 32 ? Bits<valsize>::has_unsigned_overflow32(value)
                           : Bits<valsize>::has_unsigned_overflow(value));
      default:
        gold_unreachable();
      }
  }

  // Return relocatable relocs.
  Relocatable_relocs*
  rr()
  { return this->rr_; }

  // Return the object file.
  Nanomips_relobj<size, big_endian>*
  relobj()
  { return this->relobj_; }

 private:
  // Object file of the input section in which we are transforming instructions.
  Nanomips_relobj<size, big_endian>* relobj_;
  // Info about how relocs should be handled.  This is only used for
  // --emit-relocs and --finalize-relocs options.
  Relocatable_relocs* rr_;
  // R_NANOMIPS_INSN32 or R_NANOMIPS_INSN16 relocation.
  unsigned int insn_reloc_;
  // Is instruction relaxation state.
  bool is_relax_;
};

// The class which implements relaxations.

template<int size, bool big_endian>
class Nanomips_relax_insn : public Nanomips_transformations<size, big_endian>
{
  typedef Nanomips_transformations<size, big_endian> Base;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_relax_insn(Nanomips_relobj<size, big_endian>* relobj)
    : Nanomips_transformations<size, big_endian>(relobj, NULL, true,
                                                 elfcpp::R_NANOMIPS_INSN32)
  { }

  Nanomips_relax_insn(Nanomips_relobj<size, big_endian>* relobj,
                      Relocatable_relocs* rr)
    : Nanomips_transformations<size, big_endian>(relobj, rr, true,
                                                 elfcpp::R_NANOMIPS_INSN32)
  { }

  // Return matching instruction for relaxation if there is one and INSN can
  // be relaxed, otherwise return NULL.
  inline const Nanomips_insn_property*
  find_insn(uint32_t insn, unsigned int mask, unsigned int r_type);

  // Return the TT_RELAX transformation type if this instruction can be relaxed.
  inline unsigned int
  get_type(const Symbol* gsym,
           const Symbol_value<size>* psymval,
           const Nanomips_insn_property* insn_property,
           const elfcpp::Rela<size, big_endian>& reloc,
           size_t relnum,
           uint32_t insn,
           Address address,
           Address gp);
};

// The class which implements relaxations during --finalize-relocs.

template<int size, bool big_endian>
class Nanomips_relax_insn_finalize
  : public Nanomips_relax_insn<size, big_endian>
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_relax_insn_finalize(Nanomips_relobj<size, big_endian>* relobj,
                               Relocatable_relocs* rr)
    : Nanomips_relax_insn<size, big_endian>(relobj, rr)
  { }

  // Return the TT_RELAX transformation type if this instruction can be relaxed
  // during --finalize-relocs.
  inline unsigned int
  get_type(const Symbol* gsym,
           const Symbol_value<size>* psymval,
           const Nanomips_insn_property* insn_property,
           const elfcpp::Rela<size, big_endian>& reloc,
           size_t relnum,
           uint32_t insn,
           Address address,
           Address gp);
};

// The class which implements expansions.

template<int size, bool big_endian>
class Nanomips_expand_insn : public Nanomips_transformations<size, big_endian>
{
  typedef Nanomips_transformations<size, big_endian> Base;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_expand_insn(Nanomips_relobj<size, big_endian>* relobj,
                       Relocatable_relocs* rr)
    : Nanomips_transformations<size, big_endian>(relobj, rr, false,
                                                 elfcpp::R_NANOMIPS_INSN16)
  { }

  // Return matching instruction for expansion if there is one.
  inline const Nanomips_insn_property*
  find_insn(uint32_t insn, unsigned int mask, unsigned int r_type);

  // Return the transformation type if instruction needs to be expanded.
  inline unsigned int
  get_type(const Symbol* gsym,
           const Symbol_value<size>* psymval,
           const Nanomips_insn_property* insn_property,
           const elfcpp::Rela<size, big_endian>& reloc,
           size_t relnum,
           uint32_t insn,
           Address address,
           Address gp);

 protected:
  // Return the type of the expansion.
  inline unsigned int
  get_expand_type(const Nanomips_insn_property* insn_property,
                  uint32_t insn,
                  unsigned int r_type);
};

// The class which implements expansions during --finalize-relocs.

template<int size, bool big_endian>
class Nanomips_expand_insn_finalize
  : public Nanomips_expand_insn<size, big_endian>
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_expand_insn_finalize(Nanomips_relobj<size, big_endian>* relobj,
                               Relocatable_relocs* rr)
    : Nanomips_expand_insn<size, big_endian>(relobj, rr)
  { }

  // Return the transformation type if instruction needs to be expanded
  // during --finalize-relocs.
  inline unsigned int
  get_type(const Symbol* gsym,
           const Symbol_value<size>* psymval,
           const Nanomips_insn_property* insn_property,
           const elfcpp::Rela<size, big_endian>& reloc,
           size_t relnum,
           uint32_t insn,
           Address address,
           Address gp);
};

// This class handles .nanoMIPS.abiflags output section.

template<int size, bool big_endian>
class Nanomips_output_section_abiflags : public Output_section_data
{
 public:
  Nanomips_output_section_abiflags(const Nanomips_abiflags<big_endian>& flags)
    : Output_section_data(24, 8, true), abiflags_(flags)
  { }

 protected:
  // Write to a map file.
  void
  do_print_to_mapfile(Mapfile* mapfile) const
  { mapfile->print_output_data(this, _(".nanoMIPS.abiflags")); }

  void
  do_write(Output_file* of);

 private:
  const Nanomips_abiflags<big_endian>& abiflags_;
};

// The Nanomips target has relocation types which default handling of
// relocatable relocation cannot process.  So we have to extend the default
// code.

template<typename Classify_reloc>
class Nanomips_scan_relocatable_relocs :
  public Default_scan_relocatable_relocs<Classify_reloc>
{
 public:
  // Return the strategy to use for a local symbol which is a section symbol,
  // given the relocation type.  IN_SAME_SECTION is true if the section being
  // relocated and the section where symbol is defined are in the same output
  // section.
  inline Relocatable_relocs::Reloc_strategy
  local_section_strategy(unsigned int r_type, bool in_same_section)
  {
    switch (r_type)
      {
      case elfcpp::R_NANOMIPS_PC_I32:
      case elfcpp::R_NANOMIPS_PC25_S1:
      case elfcpp::R_NANOMIPS_PC21_S1:
      case elfcpp::R_NANOMIPS_PC14_S1:
      case elfcpp::R_NANOMIPS_PC11_S1:
      case elfcpp::R_NANOMIPS_PC10_S1:
      case elfcpp::R_NANOMIPS_PC7_S1:
      case elfcpp::R_NANOMIPS_PC4_S1:
        if (in_same_section
            && parameters->options().finalize_pcrel_relocs())
          return Relocatable_relocs::RELOC_RESOLVE;
        // Fall through.

      default:
        return Relocatable_relocs::RELOC_ADJUST_FOR_SECTION_RELA;
      }
  }

  // Return the strategy to use for a local symbol which is not a section
  // symbol, given the relocation type.  IN_SAME_SECTION is true if the section
  // being relocated and the section where symbol is defined are in the same
  // output section.
  inline Relocatable_relocs::Reloc_strategy
  local_non_section_strategy(unsigned int r_type, bool in_same_section)
  {
    switch (r_type)
      {
      case elfcpp::R_NANOMIPS_ALIGN:
      case elfcpp::R_NANOMIPS_FILL:
      case elfcpp::R_NANOMIPS_MAX:
      case elfcpp::R_NANOMIPS_INSN32:
      case elfcpp::R_NANOMIPS_INSN16:
      case elfcpp::R_NANOMIPS_FIXED:
      case elfcpp::R_NANOMIPS_RELAX:
      case elfcpp::R_NANOMIPS_NORELAX:
        return (parameters->options().finalize_relocs()
                ? Relocatable_relocs::RELOC_DISCARD
                : Relocatable_relocs::RELOC_COPY);
      case elfcpp::R_NANOMIPS_PC_I32:
      case elfcpp::R_NANOMIPS_PC25_S1:
      case elfcpp::R_NANOMIPS_PC21_S1:
      case elfcpp::R_NANOMIPS_PC14_S1:
      case elfcpp::R_NANOMIPS_PC11_S1:
      case elfcpp::R_NANOMIPS_PC10_S1:
      case elfcpp::R_NANOMIPS_PC7_S1:
      case elfcpp::R_NANOMIPS_PC4_S1:
        if (in_same_section
            && parameters->options().finalize_pcrel_relocs())
          return Relocatable_relocs::RELOC_RESOLVE;
        // Fall through.

      default:
        return Relocatable_relocs::RELOC_COPY;
      }
  }

  // Return the strategy to use for a global symbol, given the relocation type.
  // IN_SAME_SECTION is true if the section being relocated and the section
  // where symbol is defined are in the same output section.
  inline Relocatable_relocs::Reloc_strategy
  global_strategy(unsigned int r_type, bool in_same_section)
  {
    switch (r_type)
      {
      case elfcpp::R_NANOMIPS_PC_I32:
      case elfcpp::R_NANOMIPS_PC25_S1:
      case elfcpp::R_NANOMIPS_PC21_S1:
      case elfcpp::R_NANOMIPS_PC14_S1:
      case elfcpp::R_NANOMIPS_PC11_S1:
      case elfcpp::R_NANOMIPS_PC10_S1:
      case elfcpp::R_NANOMIPS_PC7_S1:
      case elfcpp::R_NANOMIPS_PC4_S1:
        if (in_same_section
            && parameters->options().finalize_pcrel_relocs())
          return Relocatable_relocs::RELOC_RESOLVE;
        // Fall through.

      default:
        return Relocatable_relocs::RELOC_COPY;
      }
  }
};

template<int size, bool big_endian>
class Target_nanomips : public Sized_target<size, big_endian>
{
  typedef Target_nanomips<size, big_endian> This;
  typedef Output_data_reloc<elfcpp::SHT_REL, true, size, big_endian>
      Reloc_section;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_WXword Size_type;

 public:
  Target_nanomips(const Target::Target_info* info = &nanomips_info)
    : Sized_target<size, big_endian>(info), state_(EXPAND), got_(NULL),
      stubs_(NULL), rel_dyn_(NULL), nanomips_input_section_map_(), gp_(NULL),
      attributes_section_data_(NULL), abiflags_(NULL), layout_(NULL),
      has_abiflags_section_(false)
  { }

  // Make a new symbol table entry for the Nanomips target.
  Sized_symbol<size>*
  make_symbol(const char*, elfcpp::STT, Object*, unsigned int, uint64_t)
  { return new Nanomips_symbol<size>(); }

  // Process the relocations to determine unreferenced sections for
  // garbage collection.
  void
  gc_process_relocs(Symbol_table* symtab,
                    Layout* layout,
                    Sized_relobj_file<size, big_endian>* object,
                    unsigned int data_shndx,
                    unsigned int sh_type,
                    const unsigned char* prelocs,
                    size_t reloc_count,
                    Output_section* output_section,
                    bool needs_special_offset_handling,
                    size_t local_symbol_count,
                    const unsigned char* plocal_symbols);

  // Scan the relocations to look for symbol adjustments.
  void
  scan_relocs(Symbol_table* symtab,
              Layout* layout,
              Sized_relobj_file<size, big_endian>* object,
              unsigned int data_shndx,
              unsigned int sh_type,
              const unsigned char* prelocs,
              size_t reloc_count,
              Output_section* output_section,
              bool needs_special_offset_handling,
              size_t local_symbol_count,
              const unsigned char* plocal_symbols);

  // Find the Nanomips_input_section object corresponding to the SHNDX-th input
  // section of RELOBJ.
  Nanomips_input_section*
  find_nanomips_input_section(Relobj* relobj, unsigned int shndx) const;

  // Return whether we may relax instructions.
  bool
  may_relax_instructions() const
  { return this->may_relax() && this->state_ == RELAX; }

  // We don't want to do instruction transformations if we are doing
  // relocatable linking and --finalize-relocs is not passed.
  bool
  do_may_relax() const
  {
    if (parameters->options().user_set_relax()
        && !parameters->options().relax())
      return false;
    return (!parameters->options().relocatable()
            || parameters->options().finalize_relocs());
  }

  // Relaxation hook.  This is where we do transformations of nanoMIPS
  // instructions.
  bool
  do_relax(int, const Input_objects*, Symbol_table*, Layout*, const Task*);

  // Relocate conditional branches.  This is only used if we have transformed
  // conditional branch into opposite branch and bc instruction in a relaxation
  // pass.
  void
  relocate_branch(unsigned int, Address, Address, unsigned char*);

  // Finalize the sections.
  void
  do_finalize_sections(Layout*, const Input_objects*, Symbol_table*);

  // Relocate a section.
  void
  relocate_section(const Relocate_info<size, big_endian>*,
                   unsigned int sh_type,
                   const unsigned char* prelocs,
                   size_t reloc_count,
                   Output_section* output_section,
                   bool needs_special_offset_handling,
                   unsigned char* view,
                   Address view_address,
                   section_size_type view_size,
                   const Reloc_symbol_changes*);

  // Scan the relocs during a relocatable link.
  void
  scan_relocatable_relocs(Symbol_table* symtab,
                          Layout* layout,
                          Sized_relobj_file<size, big_endian>* object,
                          unsigned int data_shndx,
                          unsigned int sh_type,
                          const unsigned char* prelocs,
                          size_t reloc_count,
                          Output_section* output_section,
                          bool needs_special_offset_handling,
                          size_t local_symbol_count,
                          const unsigned char* plocal_syms,
                          Relocatable_relocs* rr);

  // Scan the relocs for --emit-relocs.
  void
  emit_relocs_scan(Symbol_table* symtab,
                   Layout* layout,
                   Sized_relobj_file<size, big_endian>* object,
                   unsigned int data_shndx,
                   unsigned int sh_type,
                   const unsigned char* prelocs,
                   size_t reloc_count,
                   Output_section* output_section,
                   bool needs_special_offset_handling,
                   size_t local_symbol_count,
                   const unsigned char* plocal_syms,
                   Relocatable_relocs* rr);

  // Emit relocations for a section.
  void
  relocate_relocs(const Relocate_info<size, big_endian>*,
                  unsigned int sh_type,
                  const unsigned char* prelocs,
                  size_t reloc_count,
                  Output_section* output_section,
                  typename elfcpp::Elf_types<size>::Elf_Off
                    offset_in_output_section,
                  unsigned char* view,
                  Address view_address,
                  section_size_type view_size,
                  unsigned char* reloc_view,
                  section_size_type reloc_view_size);

  // Perform target-specific processing in a relocatable link.  This is
  // only used if we use the relocation strategy RELOC_RESOLVE.

  void
  resolve_pcrel_relocatable(const Relocate_info<size, big_endian>* relinfo,
                            unsigned int sh_type,
                            const unsigned char* preloc_in,
                            size_t relnum,
                            Output_section* output_section,
                            typename elfcpp::Elf_types<size>::Elf_Off
                              offset_in_output_section,
                            unsigned char* view,
                            Address view_address,
                            section_size_type view_size);

  // Scan a section for instruction transformation.
  bool
  scan_section_for_transform(const Relocate_info<size, big_endian>* relinfo,
                             unsigned int sh_type,
                             const unsigned char* prelocs,
                             size_t reloc_count,
                             Output_section* os,
                             Nanomips_input_section* pnis,
                             const unsigned char* view,
                             Address view_address);

  // Return whether SYM is defined by the ABI.
  bool
  do_is_defined_by_abi(const Symbol* sym) const
  { return strcmp(sym->name(), "___tls_get_addr") == 0; }

  // Get gp value.
  Address
  gp_value() const
  { return this->gp_ != NULL ? this->gp_->value() : 0; }

  // Don't emit input .nanoMIPS.abiflags sections to
  // output .nanoMIPS.abiflags.
  bool
  do_should_include_section(elfcpp::Elf_Word sh_type) const
  { return (sh_type != elfcpp::SHT_NANOMIPS_ABIFLAGS); }

  // Get the GOT section, creating it if necessary.
  Nanomips_output_data_got<size, big_endian>*
  got_section(Symbol_table*, Layout*);

  // Get the GOT section.
  Nanomips_output_data_got<size, big_endian>*
  got_section() const
  {
    gold_assert(this->got_ != NULL);
    return this->got_;
  }

  // Get the dynamic reloc section, creating it if necessary.
  Reloc_section*
  rel_dyn_section(Layout*);

  // Create a .nanoMIPS.stubs entry for a global symbol.
  void
  make_stubs_entry(Layout*, Nanomips_symbol<size>*);

  // Get the .nanoMIPS.stubs section.
  Nanomips_output_data_stubs<size, big_endian>*
  nanomips_stubs_section() const
  { return this->stubs_; }

  // Get the default Nanomips target.
  static This*
  current_target()
  {
    gold_assert(parameters->target().machine_code() == elfcpp::EM_NANOMIPS
                && parameters->target().get_size() == size
                && parameters->target().is_big_endian() == big_endian);
    return static_cast<This*>(parameters->sized_target<size, big_endian>());
  }

 protected:
  void
  do_select_as_default_target()
  {
    // Set the state to RELAX if a -relax option is passed.
    // For --insn32 we can't do relaxations from 32bit to 16bit instructions.
    if (parameters->options().relax() && !parameters->options().insn32())
      this->state_ = RELAX;

    gold_assert(nanomips_reloc_property_table == NULL);
    gold_assert(nanomips_insn_property_table == NULL);
    nanomips_reloc_property_table = new Nanomips_reloc_property_table();
    if (this->may_relax())
      nanomips_insn_property_table = new Nanomips_insn_property_table();
  }

  // do_make_elf_object to override the same function in the base class.
  Object*
  do_make_elf_object(const std::string&, Input_file*, off_t,
                     const elfcpp::Ehdr<size, big_endian>&);

  // Make an output section.
  Output_section*
  do_make_output_section(const char* name, elfcpp::Elf_Word type,
                         elfcpp::Elf_Xword flags)
  { return new Nanomips_output_section<size, big_endian>(name, type, flags); }

 private:
  // The class which scans relocations.
  class Scan
  {
    static const unsigned int invalid_index = static_cast<unsigned int>(-1);
    static const Address invalid_address = static_cast<Address>(-1);

   public:
    Scan()
      : ref_r_offset_(invalid_address), ref_relobj_(NULL),
        ref_shndx_(invalid_index), seen_norelax_(false)
    { }

    inline void
    local(Symbol_table* symtab, Layout* layout, Target_nanomips* target,
          Sized_relobj_file<size, big_endian>* object,
          unsigned int data_shndx, Output_section* output_section,
          const elfcpp::Rela<size, big_endian>& reloc, unsigned int r_type,
          const elfcpp::Sym<size, big_endian>& lsym,
          bool is_discarded);

    inline void
    global(Symbol_table* symtab, Layout* layout, Target_nanomips* target,
           Sized_relobj_file<size, big_endian>* object,
           unsigned int data_shndx, Output_section* output_section,
           const elfcpp::Rela<size, big_endian>& reloc, unsigned int r_type,
           Symbol* gsym);

    inline bool
    local_reloc_may_be_function_pointer(Symbol_table*, Layout*,
                                        Target_nanomips*,
                                        Sized_relobj_file<size, big_endian>*,
                                        unsigned int,
                                        Output_section*,
                                        const elfcpp::Rela<size, big_endian>&,
                                        unsigned int,
                                        const elfcpp::Sym<size, big_endian>&)
    { return false; }

    inline bool
    global_reloc_may_be_function_pointer(Symbol_table*, Layout*,
                                         Target_nanomips*,
                                         Sized_relobj_file<size, big_endian>*,
                                         unsigned int,
                                         Output_section*,
                                         const elfcpp::Rela<size, big_endian>&,
                                         unsigned int, Symbol*)
    { return false; }
   private:
    static void
    unsupported_reloc_local(Sized_relobj_file<size, big_endian>*,
                            unsigned int r_type);

    static void
    unsupported_reloc_global(Sized_relobj_file<size, big_endian>*,
                             unsigned int r_type, Symbol*);

    // Offset to check if a relocation is marked with INSN32
    // or FIXED relocation.
    Address ref_r_offset_;
    // Object where we added reference.
    Nanomips_relobj<size, big_endian>* ref_relobj_;
    // Section index of section being referenced with sw[gp]/lw[gp] instruction.
    unsigned int ref_shndx_;
    // True if we have seen R_NANOMIPS_NORELAX relocation.
    bool seen_norelax_;
  };

  // The class which implements relocation.
  class Relocate
  {
   public:
    Relocate()
      : calculated_value_(0), calculate_only_(false)
    { }

    ~Relocate()
    { }

    // Do a relocation.  Return false if the caller should not issue
    // any warnings about this relocation.
    inline bool
    relocate(const Relocate_info<size, big_endian>*, unsigned int,
	     Target_nanomips*, Output_section*, size_t, const unsigned char*,
	     const Sized_symbol<size>*, const Symbol_value<size>*,
	     unsigned char*, Address, section_size_type);

   private:
    // Result of the relocation.
    Valtype calculated_value_;
    // Whether we have to calculate relocation instead of applying it.
    bool calculate_only_;
  };

  enum Nanomips_mach {
    mach_nanomipsisa32r6 = 32,
    mach_nanomipsisa64r6 = 64
  };

  // Find R_NANOMIPS_FILL and R_NANOMIPS_MAX relocations (if any) and get
  // fill value, fill size and max bytes generated by the assembler.
  void
  find_fill_max(Address, size_t, size_t, const unsigned char*,
                Nanomips_relobj<size, big_endian>*, Valtype*, Valtype*,
                Size_type*);

  // Scan a relocation section for instruction transformation.
  template <typename Nanomips_trasnform>
  bool
  scan_reloc_section_for_transform(const Relocate_info<size, big_endian>*,
                                   const unsigned char*, size_t,
                                   Output_section*,
                                   Nanomips_input_section*,
                                   const unsigned char*,
                                   Address);

  // Make a new Nanomips_input_section object.
  Nanomips_input_section*
  new_nanomips_input_section(Nanomips_relobj<size, big_endian>*,
                             unsigned int,
                             unsigned int,
                             Output_section*);

  // Update content for instruction transformation.
  void
  update_content(Nanomips_input_section*, Nanomips_relobj<size, big_endian>*,
                 Address, int, bool);

  // Check whether the given ELF header flags describe a 32-bit binary.
  bool
  nanomips_32bit_flags(elfcpp::Elf_Word);

  // Update the isa_level and isa_rev fields of abiflags.
  void
  update_abiflags_isa(const Nanomips_relobj<size, big_endian>*,
                      Nanomips_abiflags<big_endian>*);

  // Infer the content of the ABI flags based on the elf header.
  void
  infer_abiflags(const Nanomips_relobj<size, big_endian>*,
                 Nanomips_abiflags<big_endian>*);

  // Create abiflags from elf header or from .nanoMIPS.abiflags section.
  void
  create_abiflags(Nanomips_relobj<size, big_endian>*,
                  Nanomips_abiflags<big_endian>*);

  // Return printable name for ABI.
  const char*
  nanomips_abi_name(elfcpp::Elf_Word e_flags);

  // Return printable name for MACH.
  const char*
  nanomips_mach_name(elfcpp::Elf_Word e_flags);

  // Return the meaning of fp_abi, or "unknown" if not known.
  const char*
  fp_abi_string(int);

  // Select fp_abi.
  int
  select_fp_abi(const std::string&, int, int);

  // Select isa_ext.
  int
  select_isa_ext(const std::string&, int, int);

  // Merge file header flags from input object.
  void
  merge_obj_e_flags(const std::string&, elfcpp::Elf_Word);

  // Merge abiflags from input object.
  void
  merge_obj_abiflags(const std::string&, Nanomips_abiflags<big_endian>*);

  // Merge attributes from input object.
  void
  merge_obj_attributes(const std::string&, const Attributes_section_data*);

  // Check whether machine EXTENSION is an extension of machine BASE.
  bool
  nanomips_mach_extends(unsigned int, unsigned int);

  // Return the MACH for a nanoMIPS e_flags value.
  unsigned int
  nanomips_mach(elfcpp::Elf_Word);

  // Calculate value of _gp symbol.
  void
  set_gp(Layout*, Symbol_table*);

  // Information about this specific target which we pass to the
  // general Target structure.
  static const Target::Target_info nanomips_info;

  // Map input section to Nanomips_input_section.
  typedef Unordered_map<Section_id, Nanomips_input_section*, Section_id_hash>
      Nanomips_input_section_map;

  typedef enum
  {
    // Instruction expansion state.
    EXPAND,
    // Instruction relaxation state.
    RELAX
  } State;

  // States used in relaxation passes.
  State state_;
  // The GOT section.
  Nanomips_output_data_got<size, big_endian>* got_;
  // The .nanoMIPS.stubs section.
  Nanomips_output_data_stubs<size, big_endian>* stubs_;
  // The dynamic reloc section.
  Reloc_section* rel_dyn_;
  // Map for locating Nanomips_input_sections.
  Nanomips_input_section_map nanomips_input_section_map_;
  // gp symbol.
  Sized_symbol<size>* gp_;
  // Attributes section data in output.
  Attributes_section_data* attributes_section_data_;
  // .nanoMIPS.abiflags section data in output.
  Nanomips_abiflags<big_endian>* abiflags_;
  // The layout.
  Layout* layout_;
  // Whether there is an input .nanoMIPS.abiflags section.
  bool has_abiflags_section_;
};

template<int size, bool big_endian>
class Nanomips_relocate_functions
{
 public:
  typedef enum
  {
    STATUS_OKAY,            // No error during relocation.
    STATUS_OVERFLOW,        // Relocation overflow.
    STATUS_UNALIGNED        // Unaligned relocation value.
  } Status;

 private:
  typedef Nanomips_relocate_functions<size, big_endian> This;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;

  template<int valsize>
  static inline Status
  check_overflow(Valtype value, Overflow_check check)
  {
    switch (check)
      {
      case CHECK_SIGNED:
        if (size == 32)
          return (Bits<valsize>::has_overflow32(value)
                  ? STATUS_OVERFLOW
                  : STATUS_OKAY);
        else
          return (Bits<valsize>::has_overflow(value)
                  ? STATUS_OVERFLOW
                  : STATUS_OKAY);
      case CHECK_UNSIGNED:
        if (size == 32)
          return (Bits<valsize>::has_unsigned_overflow32(value)
                  ? STATUS_OVERFLOW
                  : STATUS_OKAY);
        else
          return (Bits<valsize>::has_unsigned_overflow(value)
                  ? STATUS_OVERFLOW
                  : STATUS_OKAY);
      case CHECK_NONE:
        return STATUS_OKAY;
      default:
        gold_unreachable();
      }
  }

  // Do a simple relocation.
  template<int valsize>
  static inline Status
  rel(unsigned char* view, Address value, Overflow_check check)
  {
    typedef typename elfcpp::Swap<valsize, big_endian>::Valtype Valtype;
    Valtype* wv = reinterpret_cast<Valtype*>(view);
    elfcpp::Swap<valsize, big_endian>::writeval(wv, value);
    return check_overflow<valsize>(value, check);
  }

  // Do a simple pc-relative relocation.
  template<int fieldsize, int valsize>
  static inline Status
  relpc(unsigned char* view, Address value,
        unsigned int align, Overflow_check check)
  {
    typedef typename elfcpp::Swap<fieldsize, big_endian>::Valtype Valtype;
    Valtype* wv = reinterpret_cast<Valtype*>(view);
    Valtype val = elfcpp::Swap<fieldsize, big_endian>::readval(wv);
    Valtype reloc = ((value & ~0x1) | ((value >> (valsize - 1)) & 0x1));
    Valtype mask = (1 << (valsize - 1)) - 1;
    val &= ~mask;
    reloc &= mask;
    elfcpp::Swap<fieldsize, big_endian>::writeval(wv, val | reloc);

    if (check == CHECK_NONE)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<valsize>(value, check);
  }

  // Do a simple gp-relative relocation.
  template<int valsize>
  static inline Status
  relgp(unsigned char* view, Address value, Address mask,
        unsigned int align, Overflow_check check)
  {
    typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype;
    Valtype* wv = reinterpret_cast<Valtype*>(view);
    Valtype val = elfcpp::Swap<32, big_endian>::readval(wv);
    Valtype reloc = value & mask;
    val &= ~mask;
    elfcpp::Swap<32, big_endian>::writeval(wv, val | reloc);

    if (check == CHECK_NONE)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<valsize>(value, check);
  }

 public:
  static inline void
  nanomips_reloc_unshuffle(unsigned char* view, unsigned int insn_size)
  {
    // Pick up the first and second halfwords of the instruction.
    Valtype16 first = elfcpp::Swap<16, big_endian>::readval(view);
    Valtype16 second = elfcpp::Swap<16, big_endian>::readval(view + 2);
    Valtype32 val = (insn_size == 48 ? (second << 16 | first)
                                     : (first << 16 | second));

    elfcpp::Swap<32, big_endian>::writeval(view, val);
  }

  static inline void
  nanomips_reloc_shuffle(unsigned char* view, unsigned int insn_size)
  {
    // Write the first and second halfwords of the instruction.
    Valtype32 val = elfcpp::Swap<32, big_endian>::readval(view);
    Valtype16 first = (insn_size == 48 ? (val & 0xffff) : (val >> 16));
    Valtype16 second = (insn_size == 48 ? (val >> 16) : (val & 0xffff));

    elfcpp::Swap<16, big_endian>::writeval(view, first);
    elfcpp::Swap<16, big_endian>::writeval(view + 2, second);
  }

  // R_NANOMIPS_GOT_DISP, R_NANOMIPS_GOT_PAGE, R_NANOMIPS_GOT_CALL
  static inline Status
  relgot(unsigned char* view, Address value, unsigned int align)
  {
    return This::template relgp<21>(view, value, 0x1ffffc,
                                    align, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_GPREL19_S2
  static inline Status
  relgprel19_s2(unsigned char* view, Address value,
                unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffffc, align, check);
  }

  // R_NANOMIPS_GPREL18_S3
  static inline Status
  relgprel18_s3(unsigned char* view, Address value,
                unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffff8, align, check);
  }

  // R_NANOMIPS_GPREL18
  static inline Status
  relgprel18(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3ffff, align, check);
  }

  // R_NANOMIPS_GPREL17_S1
  static inline Status
  relgprel17_s1(unsigned char* view, Address value,
                unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffe, align, check);
  }

  // R_NANOMIPS_GPREL16_S2
  static inline Status
  relgprel16_s2(unsigned char* view, Address value,
                unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffc, align, check);
  }

  // R_NANOMIPS_GPREL7_S2
  static inline Status
  relgprel7_s2(unsigned char* view, Address value,
               unsigned int align, bool should_check_overflow)
  {
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);

    val = Bits<7>::bit_select32(val, value >> 2, 0x7f);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<9>(value, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_PC25_S1
  static inline Status
  relpc25_s1(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 26>(view, value, align, check);
  }

  // R_NANOMIPS_PC21_S1
  static inline Status
  relpc21_s1(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 22>(view, value, align, check);
  }

  // R_NANOMIPS_PC14_S1
  static inline Status
  relpc14_s1(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 15>(view, value, align, check);
  }

  // R_NANOMIPS_PC11_S1
  static inline Status
  relpc11_s1(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 12>(view, value, align, check);
  }

  // R_NANOMIPS_PC10_S1
  static inline Status
  relpc10_s1(unsigned char* view, Address value,
             unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<16, 11>(view, value, align, check);
  }

  // R_NANOMIPS_PC7_S1
  static inline Status
  relpc7_s1(unsigned char* view, Address value,
            unsigned int align, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<16, 8>(view, value, align, check);
  }

  // R_NANOMIPS_PC4_S1
  static inline Status
  relpc4_s1(unsigned char* view, Address value,
            unsigned int align, bool should_check_overflow)
  {
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);

    val = Bits<4>::bit_select32(val, value >> 1, 0xf);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<5>(value, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_ASHIFTR_1, R_NANOMIPS_NEG
  static inline Status
  relsize(unsigned char* view, Address value)
  { return This::template rel<size>(view, value, CHECK_NONE); }

  // R_NANOMIPS_32, R_NANOMIPS_I32, R_NANOMIPS_PC_I32, R_NANOMIPS_GPREL_I32,
  // R_NANOMIPS_GOTPC_I32
  static inline Status
  rel32(unsigned char* view, Address value)
  { return This::template rel<32>(view, value, CHECK_NONE); }

  // R_NANOMIPS_UNSIGNED_16
  static inline Status
  relu16(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template rel<16>(view, value, check);
  }

  // R_NANOMIPS_UNSIGNED_8
  static inline Status
  relu8(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template rel<8>(view, value, check);
  }

  // R_NANOMIPS_SIGNED_16
  static inline Status
  rels16(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template rel<16>(view, value, check);
  }

  // R_NANOMIPS_SIGNED_8
  static inline Status
  rels8(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template rel<8>(view, value, check);
  }

  // R_NANOMIPS_HI20, R_NANOMIPS_PC_HI20, R_NANOMIPS_GPREL_HI20,
  // R_NANOMIPS_GOTPC_HI20
  static inline Status
  relhi20(unsigned char* view, Address value)
  {
    Valtype32* wv = reinterpret_cast<Valtype32*>(view);
    Valtype32 val = elfcpp::Swap<32, big_endian>::readval(wv);
    val = ((val & 0xffe00002) | (value & 0x1ff000) | ((value >> 19) & 0xffc)
           | ((value >> 31) & 0x1));
    elfcpp::Swap<32, big_endian>::writeval(wv, val);
    return STATUS_OKAY;
  }

  // R_NANOMIPS_LO12, R_NANOMIPS_GPREL_LO12, R_NANOMIPS_GOT_LO12
  static inline Status
  rello12(unsigned char* view, Address value)
  {
    Valtype32* wv = reinterpret_cast<Valtype32*>(view);
    Valtype32 val = elfcpp::Swap<32, big_endian>::readval(wv);
    val = Bits<12>::bit_select32(val, value, 0xfff);
    elfcpp::Swap<32, big_endian>::writeval(wv, val);
    return STATUS_OKAY;
  }

  // R_NANOMIPS_LO4_S2
  static inline Status
  rello4_s2(unsigned char* view, Address value,
            unsigned int align, bool should_check_overflow)
  {
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);
    value &= 0xfff;
    val = Bits<4>::bit_select32(val, value >> 2, 0xf);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<6>(value, CHECK_UNSIGNED);
  }
};

// Nanomips_output_data_stubs methods.

// Entry in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_entry[] =
{
  0x0300, 0x0000,     // li t8,JMPRELINDX(sym)
  0x1800              // bc[16] footer
};

// Footer in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_normal_footer[] =
{
  0x4320, 0x0002,     // lw t9,NANOMIPS_GOT0($gp)
  0x11ff,             // move t3,ra
  0xdb30              // jalrc t9
};

// Big footer in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_big_footer[] =
{
  0x4320, 0x0002,     // lw t9,NANOMIPS_GOT0($gp)
  0x6301,             // addiu[48] t8,bias
  0x11ff,             // move t3,ra
  0xdb30              // jalrc t9
};

// Set stub offsets for symbols.

template<int size, bool big_endian>
void
Nanomips_output_data_stubs<size, big_endian>::set_lazy_stub_offsets()
{
  // Maximum number of stubs that may precede footer.
  const size_t max_precede_elem = 170;
  // Maximum number of stubs that may succeed footer.
  const size_t max_succeed_elem = 169;
  // Maximum number of stub group that can use same bias.
  const size_t max_stub_group_size = 65536;
  // Index of the first entry that can't use same bias.
  size_t max_stub_group_index = max_stub_group_size;

  // Create a new footer.
  Nanomips_stubs_footer* footer = new Nanomips_stubs_footer();
  this->footers_.push_back(footer);

  // States for adding entries.
  enum
  {
    // Entries are preceding footer.
    PRECEDE_FOOTER,
    // Entries are succeeding footer.
    SUCCEED_FOOTER
  } state = PRECEDE_FOOTER;

  // Bias for the current stub group.
  size_t bias = 0;
  // Offset within the section.
  uint64_t offset = 0;

  // Set stub offsets and create dynamic relocation for the symbols.
  // Also create footers for the stub entries.
  for (size_t i = 0, cnt = 0; i < this->entries_.size(); ++i, ++cnt)
    {
      // Check if we have reached the maximum number of
      // elements that can use same bias.
      if (i == max_stub_group_index)
        {
          offset = this->set_footer_offset_and_bias(footer, offset, bias);
          footer = this->create_footer();
          max_stub_group_index += max_stub_group_size;
          bias += max_stub_group_size;
          state = PRECEDE_FOOTER;
          cnt = 0;
        }
      else if (state == PRECEDE_FOOTER)
        {
          // Check if we have reached the maximum number of
          // elements that can precede footer.
          if (cnt == max_precede_elem)
            {
              // Set footer offset and bias.
              offset = this->set_footer_offset_and_bias(footer, offset, bias);
              state = SUCCEED_FOOTER;
              cnt = 0;
            }
        }
      else if (state == SUCCEED_FOOTER)
        {
          // Check if we have reached the maximum number of
          // elements that can succeed footer.
          if (cnt == max_succeed_elem)
            {
              // Create a new footer.
              footer = this->create_footer();
              state = PRECEDE_FOOTER;
              cnt = 0;
            }
        }

      Nanomips_stubs_entry<size>& entry(this->entries_[i]);
      entry.footer = footer;
      entry.indx = i - bias;

      // Set stub offset and create dynamic relocation for the symbol.
      Nanomips_symbol<size>* sym = entry.sym;
      this->rel_->add_global(sym, elfcpp::R_NANOMIPS_JUMP_SLOT,
                             this->target_->got_section(),
                             sym->got_offset(GOT_TYPE_STANDARD));
      sym->set_lazy_stub_offset(offset);
      offset += this->stub_size();
    }

  // Set offset and bias for the last footer, if needed.
  offset = this->set_footer_offset_and_bias(footer, offset, bias);

  this->set_data_size(offset);
  this->fix_data_size();
}

// Write out the .nanoMIPS.stubs data.

template<int size, bool big_endian>
void
Nanomips_output_data_stubs<size, big_endian>::do_write(Output_file* of)
{
  const off_t offset = this->offset();
  const section_size_type oview_size =
    convert_to_section_size_type(this->data_size());
  unsigned char* const oview = of->get_output_view(offset, oview_size);

  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef Nanomips_relocate_functions<size, big_endian> Reloc_funcs;

  // Write .nanoMIPS.stubs entries.
  for (size_t i = 0; i < this->entries_.size(); ++i)
    {
      Nanomips_stubs_entry<size>& entry(this->entries_[i]);
      Nanomips_stubs_footer* footer = entry.footer;
      uint64_t off = entry.sym->lazy_stub_offset();

      typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;
      unsigned char* pov = oview + off;
      const uint32_t* lazy_stub = lazy_stub_entry;

      // Write li t8,JMPRELINDX(sym) instruction.
      size_t indx = entry.indx;
      elfcpp::Swap<16, big_endian>::writeval(pov, lazy_stub[0]);
      elfcpp::Swap<16, big_endian>::writeval(pov + 2, lazy_stub[1] | indx);

      // Write bc[16] instruction.
      elfcpp::Swap<16, big_endian>::writeval(pov + 4, lazy_stub[2]);

      // Calculate and write value for bc[16] instruction.
      uint64_t bc16_off = off + 4;
      Valtype value = static_cast<Valtype>(footer->offset - bc16_off - 2);
      reloc_status = Reloc_funcs::relpc10_s1(pov + 4, value, 2, true);
      gold_assert(reloc_status == Reloc_funcs::STATUS_OKAY);
    }

  Valtype gp_off =
    this->target_->gp_value() - this->target_->got_section()->address();

  // Write .nanoMIPS.stubs footers.
  for (typename Nanomips_stubs_footers::const_iterator
       p = this->footers_.begin();
       p != this->footers_.end();
       ++p)
    {
      Nanomips_stubs_footer* footer = *p;
      uint64_t off = footer->offset;
      bool is_big = footer->bias > 0;

      typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;
      unsigned char* pov = oview + off;
      const uint32_t* lazy_stub_footer = (is_big ? lazy_stub_big_footer
                                                 : lazy_stub_normal_footer);

      unsigned int i = 0;

      // Write lw t9,NANOMIPS_GOT0($gp) instruction.
      elfcpp::Swap<16, big_endian>::writeval(pov, lazy_stub_footer[i]);
      elfcpp::Swap<16, big_endian>::writeval(pov + 2, lazy_stub_footer[i + 1]);

      // Apply NANOMIPS_GOT0 offset.
      Reloc_funcs::nanomips_reloc_unshuffle(pov, 32);
      reloc_status = Reloc_funcs::relgprel19_s2(pov, gp_off, 4, true);
      Reloc_funcs::nanomips_reloc_shuffle(pov, 32);
      if (reloc_status != Reloc_funcs::STATUS_OKAY)
        {
          gold_error(_("GPREL19_S2 overflow in .nanoMIPS.stubs footer"));
          return;
        }
      i += 2;
      pov += 4;

      // Write addiu[48] t8,bias instruction if needed.
      if (is_big)
        {
          elfcpp::Swap<16, big_endian>::writeval(pov, lazy_stub_footer[i]);
          elfcpp::Swap<16, big_endian>::writeval(pov + 2,
                                                 (footer->bias & 0xffff));
          elfcpp::Swap<16, big_endian>::writeval(pov + 4,
                                                 (footer->bias >> 16));
          ++i;
          pov += 6;
        }

      // Write move t3,ra instruction.
      elfcpp::Swap<16, big_endian>::writeval(pov, lazy_stub_footer[i]);
      // Write jalrc t9 instruction.
      elfcpp::Swap<16, big_endian>::writeval(pov + 2, lazy_stub_footer[i + 1]);
    }

  of->write_output_view(offset, oview_size, oview);
}

// Nanomips_output_data_got methods.

// Finalize symbols against R_NANOMIPS_GOT_CALL relocation.

template<int size, bool big_endian>
void
Nanomips_output_data_got<size, big_endian>::finalize_got_call_symbols(
    Layout* layout)
{
  for (typename Nanomips_got_call_set::iterator
       p = this->got_call_.begin();
       p != this->got_call_.end();
       ++p)
    {
      Nanomips_symbol<size>* nanomips_sym = *p;
      if (nanomips_sym->has_got_offset(GOT_TYPE_STANDARD))
        continue;

      // Check if we can create a lazy-binding stub for this symbol.
      if (nanomips_sym->no_lazy_stub())
        {
          Reloc_section* rel_dyn = this->target_->rel_dyn_section(layout);
          this->add_global_with_rel(nanomips_sym, GOT_TYPE_STANDARD,
                                    rel_dyn, elfcpp::R_NANOMIPS_GLOBAL);
        }
      else
        {
          this->add_global(nanomips_sym, GOT_TYPE_STANDARD);
          this->target_->make_stubs_entry(layout, nanomips_sym);
        }
    }

  // We no longer need the saved information.
  this->got_call_.clear();
}

// Write out the GOT table.

template<int size, bool big_endian>
void
Nanomips_output_data_got<size, big_endian>::do_write(Output_file* of)
{
  // Call parent to write out GOT.
  Output_data_got<size, big_endian>::do_write(of);

  // Write lazy stub addresses.
  Nanomips_output_data_stubs<size, big_endian>* stubs =
    this->target_->nanomips_stubs_section();

  if (stubs == NULL)
    return;

  const off_t offset = this->offset();
  const section_size_type oview_size =
    convert_to_section_size_type(this->data_size());
  unsigned char* const oview = of->get_output_view(offset, oview_size);

  typedef std::vector<Nanomips_stubs_entry<size> >
        Nanomips_stubs_entries;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  for (typename Nanomips_stubs_entries::iterator
       p = stubs->nanomips_stubs_entries().begin();
       p != stubs->nanomips_stubs_entries().end();
       ++p)
    {
      Nanomips_symbol<size>* nanomips_sym = p->sym;
      Valtype* wv = reinterpret_cast<Valtype*>(
          oview + nanomips_sym->got_offset(GOT_TYPE_STANDARD));
      Valtype value = stubs->stub_address(nanomips_sym);
      elfcpp::Swap<size, big_endian>::writeval(wv, value);
    }

  of->write_output_view(offset, oview_size, oview);
}

// Nanomips_output_section methods.

// Get the input sections that are referenced.  If NON_REF_SECTIONS is
// not NULL, add sections that are not referenced.

template<int size, bool big_endian>
template<typename Input_sections>
void
Nanomips_output_section<size, big_endian>::get_ref_sections(
    const Input_sections& sections,
    std::vector<Nanomips_sort_entry>* ref_sections,
    std::vector<Nanomips_sort_entry>* non_ref_sections) const
{
  size_t i = 0;
  for (typename Input_sections::const_iterator p = sections.begin();
       p != sections.end();
       ++p, ++i)
    {
      Nanomips_sort_entry entry(*p, i);
      if (p->is_input_section() || p->is_relaxed_input_section())
        {
          Nanomips_relobj<size, big_endian>* relobj =
            Nanomips_relobj<size, big_endian>::as_nanomips_relobj(p->relobj());
          unsigned int shndx = p->shndx();

          uint64_t section_size;
          uint64_t addralign;
          if (p->is_relaxed_input_section())
            {
              section_size = p->relaxed_input_section()->current_data_size();
              addralign = p->relaxed_input_section()->addralign();
            }
          else
            {
              section_size = relobj->section_size(shndx);
              addralign = relobj->section_addralign(shndx);
            }

          // For reference count, only take into account 4byte size sections.
          unsigned int ref_count = (section_size == 4
                                    ? relobj->input_section_ref(shndx)
                                    : 0);
          entry.set_section_size(section_size);
          entry.set_addralign(addralign);
          entry.set_ref_count(ref_count);

          if (ref_count > 0)
            ref_sections->push_back(entry);
          else if (non_ref_sections != NULL)
            non_ref_sections->push_back(entry);
        }
      else if (non_ref_sections != NULL)
        {
          Output_section_data* posd = p->output_section_data();
          entry.set_section_size(posd->current_data_size());
          entry.set_addralign(posd->addralign());
          non_ref_sections->push_back(entry);
      }
    }
}

// Write to a map file.

template<int size, bool big_endian>
void
Nanomips_output_section<size, big_endian>::do_print_to_mapfile(
    Mapfile* mapfile) const
{
  // Check if we need to print reference count for this section.
  if (parameters->options().is_reference_counts(this->name()))
    {
      std::vector<Nanomips_sort_entry> ref_sections;
      this->get_ref_sections(this->input_sections(), &ref_sections, NULL);

      // Sort sections by reference and print them in map file.
      if (!ref_sections.empty())
        {
          std::sort(ref_sections.begin(), ref_sections.end(),
                    Nanomips_sort_by_reference());

          fprintf(mapfile->file(), "\nReference count for %s section\n",
                  this->name());

          // Only print first 128 sections that are referenced.
          const size_t access_count = 128;
          size_t count = (ref_sections.size() < access_count
                          ? ref_sections.size()
                          : access_count);
          for (size_t i = 0; i < count; ++i)
            {
              Nanomips_sort_entry& entry(ref_sections[i]);
              const Input_section& is = entry.input_section();
              unsigned long long ref_count =
                static_cast<unsigned long long>(entry.ref_count());

              std::string section_name = is.relobj()->section_name(is.shndx());
              std::string name = (is.relobj()->name()
                                  + "(" + section_name + ")");
              fprintf(mapfile->file(), " %lld %s\n", ref_count, name.c_str());
            }
        }
    }

  Output_section::do_print_to_mapfile(mapfile);
}

// Go over all input sections and sort them by reference.

template<int size, bool big_endian>
void
Nanomips_output_section<size, big_endian>::sort_sections_by_reference()
{
  // We don't want the relaxation loop to undo these changes, so we discard
  // the current saved states and take another one after the fix-up.
  this->discard_states();

  // Remove all input sections.
  uint64_t address = this->address();
  typedef std::list<Input_section> Input_section_list;
  Input_section_list input_sections;
  this->reset_address_and_file_offset();
  this->get_input_sections(address, std::string(""), &input_sections);

  std::vector<Nanomips_sort_entry> ref_sections;
  std::vector<Nanomips_sort_entry> non_ref_sections;
  this->get_ref_sections(input_sections, &ref_sections, &non_ref_sections);

  // Sort sections by reference.
  if (!ref_sections.empty())
    {
      std::sort(ref_sections.begin(), ref_sections.end(),
                Nanomips_sort_by_reference());

      // With lw[gp16] and sw[gp16] instructions we can only access to
      // first 128 sections from the $gp.
      const size_t access_count = 128;
      size_t count = (ref_sections.size() < access_count
                      ? ref_sections.size()
                      : access_count);

      // Place input sections at the beginning of this output section.
      for (size_t i = 0; i < count; ++i)
        this->add_script_input_section(ref_sections[i].input_section());

      // Remaining sections add to non_ref_sections vector so we can
      // sort them by size and alignment.
      if (ref_sections.size() >= access_count)
        non_ref_sections.insert(non_ref_sections.end(),
                                ref_sections.begin() + (access_count - 1),
                                ref_sections.end());
    }

  // Sort remaining sections by size and alignment.
  if (!non_ref_sections.empty())
    {
      std::sort(non_ref_sections.begin(), non_ref_sections.end(),
                Nanomips_sort_by_size_and_alignment());

      for (size_t i = 0; i < non_ref_sections.size(); ++i)
        {
          const Input_section& is = non_ref_sections[i].input_section();
          if (!is.is_input_section())
            is.output_section_data()->finalize_data_size();
          this->add_script_input_section(is);
        }
    }

  // Make changes permanent.
  this->save_states();
  this->set_section_offsets_need_adjustment();
}

// Nanomips_relobj methods.

// Adjust values of the local symbols.  Also adjust sizes of the function
// symbols.  This is used in a relaxation passes.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::adjust_local_symbols(
    Address address,
    unsigned int shndx,
    int count)
{
  const unsigned int loccount = this->local_symbol_count();
  if (loccount == 0)
    return;

  // Adjust the local symbols.

  typename Sized_relobj_file<size, big_endian>::Local_values* plocal_values =
    this->local_values();
  for (unsigned int i = 1; i < loccount; ++i)
    {
      Symbol_value<size>& lv((*plocal_values)[i]);
      Address value = lv.input_value();
      bool is_ordinary;
      unsigned int sym_shndx = lv.input_shndx(&is_ordinary);

      if (is_ordinary && shndx == sym_shndx)
        {
          // Adjust value of the symbol, if needed.
          if (value >= address)
            lv.set_input_value(value + count);

          // Adjust the function symbol's size, if needed.
          Size_type symsize = this->do_local_symbol_size(i);
          if (this->local_symbol_is_function_[i]
              && value < address
              && value + symsize >= address)
            this->set_local_symbol_size(i, symsize + count);
        }
    }
}

// Adjust values of the global symbols.  Also adjust sizes of the function
// symbols.  This is used in a relaxation passes.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::adjust_global_symbols(
    Address address,
    unsigned int shndx,
    int count)
{
  const Object::Symbols* syms = this->get_global_symbols();
  unsigned int nsyms = syms->size();
  if (nsyms == 0)
    return;

  // Adjust the global symbols.
  for (unsigned int i = 0; i < nsyms; ++i)
    {
      Sized_symbol<size>* gsym = static_cast<Sized_symbol<size>*>((*syms)[i]);
      Address value = gsym->value();
      bool is_ordinary;

      if (gsym->source() == Symbol::FROM_OBJECT
          && gsym->object() == this
          && shndx == gsym->shndx(&is_ordinary)
          && is_ordinary
          && gsym->is_defined())
        {
          // Adjust value of the symbol, if needed.
          if (value >= address)
            gsym->set_value(value + count);

          // Adjust the function symbol's size, if needed.
          Size_type symsize = gsym->symsize();
          if (gsym->is_func()
              && value < address
              && value + symsize >= address)
            gsym->set_symsize(symsize + count);
        }
    }
}

// Return the name of the local symbol.  For section symbols, return the
// section name with addend.

template<int size, bool big_endian>
std::string
Nanomips_relobj<size, big_endian>::local_symbol_name(
    unsigned symndx,
    typename elfcpp::Elf_types<size>::Elf_Swxword r_addend)
{
  const unsigned int loccount = this->local_symbol_count();
  gold_assert(symndx < loccount);

  // Read the symbol table section header.
  const unsigned int symtab_shndx = this->symtab_shndx();
  elfcpp::Shdr<size, big_endian>
    symtabshdr(this, this->elf_file()->section_header(symtab_shndx));
  gold_assert(symtabshdr.get_sh_type() == elfcpp::SHT_SYMTAB);

  // Read the local symbols.
  const int sym_size = elfcpp::Elf_sizes<size>::sym_size;
  gold_assert(loccount == symtabshdr.get_sh_info());
  off_t locsize = loccount * sym_size;
  const unsigned char* psyms = this->get_view(symtabshdr.get_sh_offset(),
                                              locsize, true, true);

  // Read the symbol names.
  const unsigned int strtab_shndx =
    this->adjust_shndx(symtabshdr.get_sh_link());
  section_size_type strtab_size;
  const unsigned char* pnamesu = this->section_contents(strtab_shndx,
                                                        &strtab_size,
                                                        true);
  const char* pnames = reinterpret_cast<const char*>(pnamesu);

  elfcpp::Sym<size, big_endian> sym(psyms + symndx * sym_size);
  if (sym.get_st_type() == elfcpp::STT_SECTION)
    {
      bool is_ordinary;
      unsigned int sym_shndx = this->adjust_sym_shndx(symndx,
                                                      sym.get_st_shndx(),
                                                      &is_ordinary);
      std::string name = this->section_name(sym_shndx);
      char buf[100];
      snprintf(buf, sizeof buf, "+0x%llx",
               static_cast<unsigned long long>(r_addend));
      name += buf;
      return name;
    }
  return std::string(pnames + sym.get_st_name());
}

// Whether a section is a scannable for instruction transformations.

template<int size, bool big_endian>
bool
Nanomips_relobj<size, big_endian>::section_is_scannable(
    const elfcpp::Shdr<size, big_endian>& shdr,
    unsigned int shndx,
    const Output_section* os,
    const Symbol_table* symtab)
{
  // Skip empty and non-executable sections.
  if (shdr.get_sh_size() == 0
      || ((shdr.get_sh_flags() & (elfcpp::SHF_ALLOC | elfcpp::SHF_EXECINSTR))
          != (elfcpp::SHF_ALLOC | elfcpp::SHF_EXECINSTR))
      || shdr.get_sh_type() != elfcpp::SHT_PROGBITS)
    return false;

  // Skip any discarded or ICF'ed sections.
  if (os == NULL || symtab->is_section_folded(this, shndx))
    return false;

  // If this requires special offset handling, check to see if it is
  // a relaxed section.  If this is not, then it is a merged section that
  // we cannot handle.
  if (this->is_output_section_offset_invalid(shndx))
    {
      const Output_relaxed_input_section* poris =
        os->find_relaxed_input_section(this, shndx);
      if (poris == NULL)
        return false;
    }

  return true;
}

// Determine whether a section needs to be scanned for relaxations
// or expansions.

template<int size, bool big_endian>
bool
Nanomips_relobj<size, big_endian>::section_needs_reloc_scanning(
    const elfcpp::Shdr<size, big_endian>& shdr,
    const Relobj::Output_sections& osections,
    const Symbol_table* symtab,
    const unsigned char* pshdrs)
{
  unsigned int sh_type = shdr.get_sh_type();
  if (sh_type != elfcpp::SHT_RELA)
    return false;

  // Ignore empty section.
  off_t sh_size = shdr.get_sh_size();
  if (sh_size == 0)
    return false;

  // Ignore reloc section with unexpected symbol table.  The
  // error will be reported in the final link.
  if (this->adjust_shndx(shdr.get_sh_link()) != this->symtab_shndx())
    return false;

  unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Ignore reloc section with unexpected entsize or uneven size.
  // The error will be reported in the final link.
  if (reloc_size != shdr.get_sh_entsize() || sh_size % reloc_size != 0)
    return false;

  // Ignore reloc section with bad info.  This error will be
  // reported in the final link.
  unsigned int index = this->adjust_shndx(shdr.get_sh_info());
  if (index >= this->shnum())
    return false;

  const unsigned int shdr_size = elfcpp::Elf_sizes<size>::shdr_size;
  const elfcpp::Shdr<size, big_endian> text_shdr(pshdrs + index * shdr_size);
  return this->section_is_scannable(text_shdr, index, osections[index], symtab);
}

// Scan all relocation sections for instruction transformation.

template<int size, bool big_endian>
bool
Nanomips_relobj<size, big_endian>::scan_sections_for_transform(
    Target_nanomips<size, big_endian>* target,
    const Symbol_table* symtab,
    const Layout* layout)
{
  // Don't do anything if this object file is not safe to relax.
  if (!this->safe_to_relax())
    return false;

  unsigned int shnum = this->shnum();
  const unsigned int shdr_size = elfcpp::Elf_sizes<size>::shdr_size;
  const Address invalid_address = static_cast<Address>(0) - 1;
  const bool emit_relocs = parameters->options().emit_relocs()
                           || parameters->options().relocatable();
  bool again = false;

  // Read the section headers.
  const unsigned char* pshdrs = this->get_view(this->elf_file()->shoff(),
                                               shnum * shdr_size,
                                               true, true);

  // To speed up processing, we set up hash tables for fast lookup of
  // input offsets to output addresses.
  this->initialize_input_to_output_maps();

  const Relobj::Output_sections& osections(this->output_sections());

  Relocate_info<size, big_endian> relinfo;
  relinfo.symtab = symtab;
  relinfo.layout = layout;
  relinfo.object = this;
  relinfo.rr = NULL;

  // Do relocation scanning.
  const unsigned char* p = pshdrs + shdr_size;
  for (unsigned int i = 1; i < shnum; ++i, p += shdr_size)
    {
      const elfcpp::Shdr<size, big_endian> shdr(p);
      if (this->section_needs_reloc_scanning(shdr, osections, symtab, pshdrs))
        {
          unsigned int index = this->adjust_shndx(shdr.get_sh_info());
          Address output_offset = this->get_output_section_offset(index);
          Nanomips_input_section* pnis = NULL;
          unsigned int sh_type = shdr.get_sh_type();
          Address output_address;
          const unsigned char* prelocs;
          const unsigned char* input_view;
          size_t reloc_count;

          if (output_offset != invalid_address)
            {
              output_address = osections[index]->address() + output_offset;
              // Get the relocations.
              prelocs = this->get_view(shdr.get_sh_offset(), shdr.get_sh_size(),
                                       true, false);
              // Get the section contents.  This does work for the case in which
              // we modify the contents of an input section. We need to pass the
              // output view under such circumstances.
              section_size_type input_view_size;
              input_view =
                this->section_contents(index, &input_view_size, false);
              unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
              reloc_count = shdr.get_sh_size() / reloc_size;
            }
          else
            {
              // Currently this only happens for a relaxed section.
              pnis = target->find_nanomips_input_section(this, index);
              gold_assert(pnis != NULL);
              output_address = pnis->address();
              prelocs = pnis->relocs();
              reloc_count = pnis->reloc_count();
              input_view = pnis->section_contents();
            }

          relinfo.reloc_shndx = i;
          relinfo.data_shndx = index;
          Output_section* os = osections[index];
          if (emit_relocs)
            relinfo.rr = this->relocatable_relocs(i);

          again |= target->scan_section_for_transform(&relinfo, sh_type,
                                                      prelocs, reloc_count,
                                                      os, pnis, input_view,
                                                      output_address);
        }
    }

  // After we've done the relocations, we release the hash tables,
  // since we no longer need them.
  this->free_input_to_output_maps();
  return again;
}

// TODO: Move size of the local symbols to the Symbol_value class.
template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::do_count_local_symbols(
    Stringpool_template<char>* pool,
    Stringpool_template<char>* dynpool)
{
  // Ask parent to count the local symbols.
  Sized_relobj_file<size, big_endian>::do_count_local_symbols(pool, dynpool);
  const unsigned int loccount = this->local_symbol_count();
  if (loccount == 0)
    return;

  // Initialize vectors.
  this->local_symbol_is_function_.resize(loccount, false);
  this->local_symbol_size_.resize(loccount);

  // Read the symbol table section header.
  const unsigned int symtab_shndx = this->symtab_shndx();
  elfcpp::Shdr<size, big_endian>
    symtabshdr(this, this->elf_file()->section_header(symtab_shndx));
  gold_assert(symtabshdr.get_sh_type() == elfcpp::SHT_SYMTAB);

  // Read the local symbols.
  const int sym_size = elfcpp::Elf_sizes<size>::sym_size;
  gold_assert(loccount == symtabshdr.get_sh_info());
  off_t locsize = loccount * sym_size;
  const unsigned char* psyms = this->get_view(symtabshdr.get_sh_offset(),
                                              locsize, true, true);

  // Loop over the local symbols and cache informations.

  // Skip the first dummy symbol.
  psyms += sym_size;
  for (unsigned int i = 1; i < loccount; ++i, psyms += sym_size)
    {
      elfcpp::Sym<size, big_endian> sym(psyms);
      this->local_symbol_size_[i] = sym.get_st_size();
      this->local_symbol_is_function_[i] =
        sym.get_st_type() == elfcpp::STT_FUNC;
    }
}

// Relocate sections.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::do_relocate_sections(
    const Symbol_table* symtab,
    const Layout* layout,
    const unsigned char* pshdrs,
    Output_file* of,
    typename Sized_relobj_file<size, big_endian>::Views* pviews)
{
  // Relocate the section data.
  this->relocate_section_range(symtab, layout, pshdrs, of, pviews,
                               1, this->shnum() - 1);

  Target_nanomips<size, big_endian>* target =
    Target_nanomips<size, big_endian>::current_target();

  // If we are not performing relaxations, don't do anything.
  if (!target->may_relax())
    return;

  // Relocate conditional branches.
  unsigned int shnum = this->shnum();

  for (unsigned int i = 1; i < shnum; ++i)
    {
      Nanomips_input_section* nanomips_input_section =
        target->find_nanomips_input_section(this, i);

      if (nanomips_input_section == NULL
          || nanomips_input_section->branches()->empty())
        continue;

      typename Sized_relobj_file<size, big_endian>::View_size& view_struct =
        (*pviews)[i];
      gold_assert(view_struct.view != NULL);

      Address section_address = nanomips_input_section->address();
      unsigned char* view =
        view_struct.view + (section_address - view_struct.address);
      section_size_type view_size = nanomips_input_section->data_size();

      // Get conditional branches.
      typedef typename Nanomips_input_section::Conditional_branches
        Conditional_branches;
      const Conditional_branches* branches = nanomips_input_section->branches();

      for (size_t j = 0; j < branches->size(); ++j)
        {
          Address offset = (*branches)[j].offset;
          Address destination = (*branches)[j].destination;
          unsigned int r_type = (*branches)[j].reloc;
          gold_assert(destination > offset);
          gold_assert(destination <= view_size);
          target->relocate_branch(r_type, section_address + destination,
                                  section_address + offset, view + offset);
        }
    }
}

// Read the symbol information.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::do_read_symbols(Read_symbols_data* sd)
{
  // Call parent class to read symbol information.
  this->base_read_symbols(sd);

  // If this input file is a binary file, it has no processor
  // specific data.
  Input_file::Format format = this->input_file()->format();
  if (format != Input_file::FORMAT_ELF)
    {
      gold_assert(format == Input_file::FORMAT_BINARY);
      this->merge_processor_specific_data_ = false;
      return;
    }

  // Read processor-specific flags in ELF file header.
  const unsigned char* pehdr = this->get_view(elfcpp::file_header_offset,
                                            elfcpp::Elf_sizes<size>::ehdr_size,
                                            true, false);
  elfcpp::Ehdr<size, big_endian> ehdr(pehdr);
  this->processor_specific_flags_ = ehdr.get_e_flags();

  const size_t shdr_size = elfcpp::Elf_sizes<size>::shdr_size;
  const unsigned char* pshdrs = sd->section_headers->data();
  const unsigned char* ps = pshdrs + shdr_size;
  bool must_merge_processor_specific_data = false;

  for (unsigned int i = 1; i < this->shnum(); ++i, ps += shdr_size)
    {
      elfcpp::Shdr<size, big_endian> shdr(ps);

      // Sometimes an object has no contents except the section name string
      // table and an empty symbol table with the undefined symbol.  We
      // don't want to merge processor-specific data from such an object.
      if (shdr.get_sh_type() == elfcpp::SHT_SYMTAB)
        {
          // Symbol table is not empty.
          const typename elfcpp::Elf_types<size>::Elf_WXword sym_size =
            elfcpp::Elf_sizes<size>::sym_size;
          if (shdr.get_sh_size() > sym_size)
            must_merge_processor_specific_data = true;
        }
      else if (shdr.get_sh_type() != elfcpp::SHT_STRTAB)
        // If this is neither an empty symbol table nor a string table,
        // be conservative.
        must_merge_processor_specific_data = true;

      if (shdr.get_sh_type() == elfcpp::SHT_GNU_ATTRIBUTES)
        {
          gold_assert(this->attributes_section_data_ == NULL);
          section_offset_type section_offset = shdr.get_sh_offset();
          section_size_type section_size =
            convert_to_section_size_type(shdr.get_sh_size());
          const unsigned char* view =
            this->get_view(section_offset, section_size, true, false);
          this->attributes_section_data_ =
            new Attributes_section_data(view, section_size);
        }

      if (shdr.get_sh_type() == elfcpp::SHT_NANOMIPS_ABIFLAGS)
        {
          gold_assert(this->abiflags_ == NULL);
          section_offset_type section_offset = shdr.get_sh_offset();
          section_size_type section_size =
            convert_to_section_size_type(shdr.get_sh_size());
          const unsigned char* view =
            this->get_view(section_offset, section_size, true, false);
          this->abiflags_ = new Nanomips_abiflags<big_endian>();

          this->abiflags_->version =
            elfcpp::Swap<16, big_endian>::readval(view);
          if (this->abiflags_->version != 0)
            {
              gold_error(_("%s: .nanoMIPS.abiflags section has "
                           "unsupported version %u"),
                         this->name().c_str(),
                         this->abiflags_->version);
              break;
            }
          this->abiflags_->isa_level =
            elfcpp::Swap<8, big_endian>::readval(view + 2);
          this->abiflags_->isa_rev =
            elfcpp::Swap<8, big_endian>::readval(view + 3);
          this->abiflags_->gpr_size =
            elfcpp::Swap<8, big_endian>::readval(view + 4);
          this->abiflags_->cpr1_size =
            elfcpp::Swap<8, big_endian>::readval(view + 5);
          this->abiflags_->cpr2_size =
            elfcpp::Swap<8, big_endian>::readval(view + 6);
          this->abiflags_->fp_abi =
            elfcpp::Swap<8, big_endian>::readval(view + 7);
          this->abiflags_->isa_ext =
            elfcpp::Swap<32, big_endian>::readval(view + 8);
          this->abiflags_->ases =
            elfcpp::Swap<32, big_endian>::readval(view + 12);
          this->abiflags_->flags1 =
            elfcpp::Swap<32, big_endian>::readval(view + 16);
          this->abiflags_->flags2 =
            elfcpp::Swap<32, big_endian>::readval(view + 20);
        }
    }

  // This is rare.
  if (!must_merge_processor_specific_data)
    this->merge_processor_specific_data_ = false;
}

// Nanomips_output_section_abiflags methods.

template<int size, bool big_endian>
void
Nanomips_output_section_abiflags<size, big_endian>::do_write(Output_file* of)
{
  off_t offset = this->offset();
  off_t data_size = this->data_size();

  unsigned char* view = of->get_output_view(offset, data_size);
  elfcpp::Swap<16, big_endian>::writeval(view, this->abiflags_.version);
  elfcpp::Swap<8, big_endian>::writeval(view + 2, this->abiflags_.isa_level);
  elfcpp::Swap<8, big_endian>::writeval(view + 3, this->abiflags_.isa_rev);
  elfcpp::Swap<8, big_endian>::writeval(view + 4, this->abiflags_.gpr_size);
  elfcpp::Swap<8, big_endian>::writeval(view + 5, this->abiflags_.cpr1_size);
  elfcpp::Swap<8, big_endian>::writeval(view + 6, this->abiflags_.cpr2_size);
  elfcpp::Swap<8, big_endian>::writeval(view + 7, this->abiflags_.fp_abi);
  elfcpp::Swap<32, big_endian>::writeval(view + 8, this->abiflags_.isa_ext);
  elfcpp::Swap<32, big_endian>::writeval(view + 12, this->abiflags_.ases);
  elfcpp::Swap<32, big_endian>::writeval(view + 16, this->abiflags_.flags1);
  elfcpp::Swap<32, big_endian>::writeval(view + 20, this->abiflags_.flags2);

  of->write_output_view(offset, data_size, view);
}

// Nanomips_input_section methods.

// Initialize a Nanomips_input_section.

void
Nanomips_input_section::init(unsigned int reloc_shndx)
{
  Relobj* relobj = this->relobj();
  unsigned int data_shndx = this->shndx();

  // Cache alignment of the original file.
  this->addralign_ = relobj->section_addralign(data_shndx);

  // TODO: Maybe increase additional size!?
  const size_t additional_size = 100;
  const size_t insn_size = 4;

  // Copy content from input section.
  section_size_type section_size;
  const unsigned char* section_contents =
    relobj->section_contents(data_shndx, &section_size, false);
  gold_assert(this->contents_.data == NULL);

  this->contents_.len = section_size;
  this->contents_.alc = section_size + additional_size * insn_size;
  this->contents_.data = new unsigned char[this->contents_.alc];
  memcpy(this->contents_.data, section_contents, section_size);

  // Copy relocations for this section.
  section_size_type relocs_size;
  const unsigned char* relocs =
    relobj->section_contents(reloc_shndx, &relocs_size, false);
  gold_assert(this->relocs_.data == NULL);
  gold_assert(relocs_size % this->reloc_size_ == 0);

  this->relocs_.len = relocs_size;
  this->relocs_.alc = relocs_size + additional_size * this->reloc_size_;
  this->relocs_.data = new unsigned char[this->relocs_.alc];
  memcpy(this->relocs_.data, relocs, relocs_size);

  // Set address and offset.
  Output_section* os = this->output_section();
  off_t offset = relobj->output_section_offset(data_shndx);
  gold_assert(!relobj->is_output_section_offset_invalid(data_shndx));
  this->set_address(os->address() + offset);
  this->set_file_offset(os->offset() + offset);

  this->set_current_data_size(this->contents_.len);
  this->finalize_data_size();
}

// Write data to output file.

void
Nanomips_input_section::do_write(Output_file* of)
{
  // Write out the section content.
  gold_assert(this->contents_.data != NULL);
  of->write(this->offset(), this->contents_.data, this->contents_.len);
}

// Nanomips_transformations methods.

// Return true if the length of this instruction is forced to an explicit size.
// These instructions are marked with R_NANOMIPS_FIXED or R_NANOMIPS_INSN[32/16]
// relocations.

template<int size, bool big_endian>
inline bool
Nanomips_transformations<size, big_endian>::fixed_insn(
    Address offset,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Start finding FIXED and INSN[32/16] from the next relocation.
  prelocs += reloc_size;
  for (size_t i = relnum + 1; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      if (offset != reloc.get_r_offset())
        break;

      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      if (r_type == elfcpp::R_NANOMIPS_FIXED
          || r_type == this->insn_reloc_)
        return false;
    }
  return true;
}

// Return the type of the transformation for code and data models.

template<int size, bool big_endian>
inline unsigned int
Nanomips_transformations<size, big_endian>::get_type(
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t,
    uint32_t insn,
    Address address,
    Address gp)
{
  const Address invalid_address = static_cast<Address>(0) - 1;
  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend = reloc.get_r_addend();

  const bool pid = this->relobj_->pid();
  const bool xlp = this->relobj_->xlp();
  const bool pcrel = this->relobj_->pcrel();
  const bool insn32 = parameters->options().insn32();
  bool got_entry =
    (gsym != NULL
     ? gsym->has_got_offset(GOT_TYPE_STANDARD)
     : this->relobj_->local_has_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend));

  // Transformations for externally defined or preemptible symbols.
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_DISP:
      if (got_entry)
        {
          unsigned int got_offset =
            (gsym != NULL
             ? gsym->got_offset(GOT_TYPE_STANDARD)
             : this->relobj_->local_got_offset(r_sym, GOT_TYPE_STANDARD,
                                               r_addend));
          if (this->check_overflow<21>(got_offset, CHECK_UNSIGNED))
            // Transform into lwpc[48] or aluipc, lw.
            return xlp ? TT_GOTPCREL_XLP : TT_GOTPCREL_LONG;
          else
            // Don't do anything.
            return TT_NONE;
        }
      break;
    case elfcpp::R_NANOMIPS_GOT_OFST:
      if (got_entry)
        // Transform into [ls]x[16] and discard relocation or don't do anything.
        return (!insn32 && insn_property->valid_regs(insn)
                ? TT_DISCARD
                : TT_NONE);
      break;
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      if (got_entry)
        // Don't do anything.
        return TT_NONE;
      break;
    default:
      gold_unreachable();
    }

  // Transformations for locally resolved symbols.
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      // Remove this instruction and discard relocation.
      return TT_DISCARD;
    case elfcpp::R_NANOMIPS_GOT_DISP:
      {
        // Don't use gp-relative transformations for function address
        // calculations.
        bool is_func = (gsym != NULL
                        ? gsym->is_func()
                        : this->relobj_->local_symbol_is_function(r_sym));

        if (!is_func && pid && (gp != invalid_address))
          {
            Valtype value = psymval->value(this->relobj_, r_addend) - gp;
            if ((value & 0x3) != 0
                && !this->check_overflow<18>(value, CHECK_UNSIGNED))
              // Transform into addiu[gp.b].
              return TT_GPREL32;
            else if ((value & 0x3) == 0
                     && !this->check_overflow<21>(value, CHECK_UNSIGNED))
              // Transform into addiu[gp.w].
              return TT_GPREL32_WORD;
            else
              // Transform into addiugp[48] or lui, ori, addu.
              return xlp ? TT_GPREL_XLP : TT_GPREL_LONG_ADDRESS;
          }
        else
          {
            Valtype value =
              psymval->value(this->relobj_, r_addend) - address - 4;
            if ((value & 0x1) == 0
                && (!this->check_overflow<21>(value, CHECK_SIGNED)
                    || this->is_relax_))
              // Transform into lapc.
              return TT_PCREL32;
            else if (xlp)
              // Transform into lapc[48]/li[48].
              return pcrel ? TT_PCREL_XLP : TT_ABS_XLP;
            else
              // Transform into aluipc/lui, ori.
              return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
          }
      }
    case elfcpp::R_NANOMIPS_GOT_OFST:
      {
        if (pid && (gp != invalid_address))
          {
            Valtype value = psymval->value(this->relobj_, r_addend) - gp;
            if (insn_property->has_transform(TT_GPREL32)
                && !this->check_overflow<18>(value, CHECK_UNSIGNED))
              // Transform into [ls][bh][gp].
              return TT_GPREL32;
            else if (insn_property->has_transform(TT_GPREL32_WORD)
                     && !this->check_overflow<21>(value, CHECK_UNSIGNED))
              {
                bool valid = insn_property->valid_treg(insn);
                bool overflow = this->check_overflow<9>(value, CHECK_UNSIGNED);
                // Transform into [ls]w[gp][16] or [ls]w[gp].
                return (valid && !overflow && !insn32
                        ? TT_GPREL16_WORD
                        : TT_GPREL32_WORD);
              }
            else if (!xlp)
              // Transform into lui, addu, [ls]x.
              return TT_GPREL_LONG;
            else
              // Transform into addiu[gp48], [ls]x[16] or addiu[gp48], [ls]x.
              return (insn_property->valid_regs(insn)
                      ? TT_GPREL_XLP
                      : TT_GPREL32_XLP);
          }
        else if (xlp && insn_property->has_transform(TT_PCREL_XLP))
          // Transform into [ls]wpc.
          return TT_PCREL_XLP;
        else
          {
            Valtype value =
              psymval->value(this->relobj_, r_addend) - address - 4;
            bool valid = insn_property->valid_regs(insn);
            bool overflow = this->check_overflow<21>(value, CHECK_SIGNED);

            if (valid && (value & 0x1) == 0 && !overflow && !insn32)
              // Transform into lapc, [ls]x[16].
              return TT_PCREL16_LONG;
            else
              // Transform into aluipc/lui, [ls]x.
              return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
          }
      }
    case elfcpp::R_NANOMIPS_JALR32:
      {
        Valtype value = psymval->value(this->relobj_, r_addend) - address - 4;
        if (!this->check_overflow<26>(value, CHECK_SIGNED))
          // Transform into balc.
          return TT_PCREL32;
        else
          // Transform into aluipc/lui, ori, jalrc.
          return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
      }
    case elfcpp::R_NANOMIPS_JALR16:
      {
        Valtype value = psymval->value(this->relobj_, r_addend) - address - 2;
        if (!this->check_overflow<11>(value, CHECK_SIGNED))
          // Transform into balc[16].
          return TT_PCREL16;
        else if (!this->check_overflow<26>(value, CHECK_SIGNED)
                 || this->is_relax_)
          // Transform into balc.
          return TT_PCREL32;
        else if (xlp)
          // Transform into lapc[48]/li[48], jalrc[16].
          return pcrel ? TT_PCREL_XLP : TT_ABS_XLP;
        else
          // Transform into aluipc/lui, ori, jalrc[16].
          return pcrel ? TT_PCREL16_LONG : TT_ABS16_LONG;
      }
    default:
      gold_unreachable();
    }
}

// Transform instruction.

template<int size, bool big_endian>
inline void
Nanomips_transformations<size, big_endian>::transform(
    const Nanomips_transform_template* transform_template,
    const Nanomips_insn_property* insn_property,
    Nanomips_input_section* input_section,
    unsigned int type,
    size_t relnum,
    uint32_t insn)
{
  gold_assert(transform_template != NULL);
  gold_assert(insn_property != NULL);
  gold_assert(input_section != NULL);

  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  const unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  unsigned char* preloc = input_section->relocs() + relnum * reloc_size;

  Reltype reloc(preloc);
  Reltype_write reloc_write(preloc);
  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend = reloc.get_r_addend();

  // Extract register from input instruction and adjust r_offset
  // for 48-bit instructions.
  unsigned int treg;
  unsigned int sreg;
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL_I32:
    case elfcpp::R_NANOMIPS_PC_I32:
      r_offset -= 2;
      treg = insn_property->treg(insn);
      sreg = 0;
      break;
    case elfcpp::R_NANOMIPS_PC25_S1:
      treg = parameters->options().expand_reg();
      sreg = parameters->options().expand_reg();
      break;
    case elfcpp::R_NANOMIPS_PC21_S1:
      treg = insn_property->treg(insn);
      sreg = (type == TT_MOVE_BALC ? insn_property->sreg(insn) : treg);
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      treg = insn_property->treg(insn);
      sreg = insn_property->sreg(insn);
      // Check if we need to swap registers.
      if (type == TT_RELAX)
        {
          unsigned int treg16 = treg & 0x7;
          unsigned int sreg16 = sreg & 0x7;
          const char* name = insn_property->name().c_str();
          if (strncmp(name, "beqc", 4) == 0)
            {
              gold_assert(treg != sreg);
              // If rs3 > rt3 then we need to swap registers.
              if (sreg16 > treg16)
                {
                  unsigned int tmp = treg;
                  treg = sreg;
                  sreg = tmp;
                }
            }
          else if (strncmp(name, "bnec", 4) == 0)
            {
              // If rs3 < rt3 then we need to swap registers.
              if (sreg16 < treg16)
                {
                  unsigned int tmp = treg;
                  treg = sreg;
                  sreg = tmp;
                }
            }
          else
            gold_unreachable();
        }
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_LO12:
      treg = insn_property->treg(insn);
      sreg = insn_property->sreg(insn);
      break;
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      treg = insn_property->treg(insn);
      sreg = parameters->options().expand_reg();
      break;
    case elfcpp::R_NANOMIPS_PC10_S1:
    case elfcpp::R_NANOMIPS_PC7_S1:
    case elfcpp::R_NANOMIPS_PC4_S1:
    case elfcpp::R_NANOMIPS_GPREL7_S2:
    case elfcpp::R_NANOMIPS_LO4_S2:
      treg = insn_property->convert_treg(insn);
      sreg = insn_property->convert_sreg(insn);
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
      treg = insn_property->treg(insn);
      sreg = insn_property->treg(insn);
      break;
    case elfcpp::R_NANOMIPS_JALR32:
      treg = 0;
      sreg = insn_property->sreg(insn);
      break;
    case elfcpp::R_NANOMIPS_JALR16:
      treg = insn_property->treg(insn);
      sreg = 0;
      break;
    default:
      gold_unreachable();
    }

  // Add conditional branch relocation.  In this case, we are transforming
  // conditional branch into the opposite conditional branch and bc instruction.
  // This cover cases where for bc instruction we need to do expansion.
  if ((r_type == elfcpp::R_NANOMIPS_PC14_S1
       || r_type == elfcpp::R_NANOMIPS_PC11_S1)
      && (type != TT_RELAX))
    input_section->add_branch_reloc(r_type, r_offset);

  // Discard relocation for TT_DISCARD type.
  if (type == TT_DISCARD)
    {
      reloc_write.put_r_offset(0);
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(0, elfcpp::R_NANOMIPS_NONE));
      reloc_write.put_r_addend(0);
      if (this->rr_ != NULL)
        this->rr_->discard_reloc(relnum);
    }

  // Transform instructions.
  const Nanomips_insn_template* insns = transform_template->insns();
  // True if we need to add new reloc.
  bool new_reloc = false;
  // r_offset to the current instruction in array.
  Address offset = r_offset;

  unsigned char* view = input_section->section_contents() + r_offset;
  unsigned char* pov = view;
  for (size_t i = 0; i < transform_template->insn_count(); ++i)
    {
      size_t new_insn_size = insns[i].size();
      uint32_t new_insn = insns[i].data(treg, sreg);
      unsigned int new_r_type = insns[i].r_type();

      if (new_r_type != elfcpp::R_NANOMIPS_NONE)
        {
          gold_assert(type != TT_DISCARD);
          // For 48bit instructions, r_offset is pointing to the immediate.
          Address new_r_offset = (new_insn_size == 6 ? offset + 2 : offset);
          if (!new_reloc)
            {
              // Change existing relocation.
              reloc_write.put_r_info(
                elfcpp::elf_r_info<size>(r_sym, new_r_type));
              reloc_write.put_r_offset(new_r_offset);
              // Set that we need to add new relocations.
              new_reloc = true;
            }
          else
            {
              // Add new relocation
              unsigned char relbuf[reloc_size];
              Reltype_write orel(relbuf);
              orel.put_r_offset(new_r_offset);
              orel.put_r_info(elfcpp::elf_r_info<size>(r_sym, new_r_type));
              orel.put_r_addend(r_addend);
              input_section->add_reloc(relbuf, reloc_size);
              // For new relocation, we just use strategy from the current
              // relocation.
              if (this->rr_ != NULL)
                this->rr_->set_next_reloc_strategy(this->rr_->strategy(relnum));
            }
        }

      // Write instruction.
      if (new_insn_size == 2)
        elfcpp::Swap<16, big_endian>::writeval(pov, new_insn & 0xffff);
      else if (new_insn_size == 4)
        {
          uint32_t hi = (new_insn >> 16) & 0xffff;
          uint32_t lo = new_insn & 0xffff;
          elfcpp::Swap<16, big_endian>::writeval(pov, hi);
          elfcpp::Swap<16, big_endian>::writeval(pov + 2, lo);
        }
      else if (new_insn_size == 6)
        {
          elfcpp::Swap<16, big_endian>::writeval(pov, new_insn & 0xffff);
          // Clear immediate.
          memset(pov + 2, 0, 4);
        }
      else
        gold_unreachable();

      pov += new_insn_size;
      offset += new_insn_size;
    }

  section_size_type view_size =
    static_cast<section_size_type>(transform_template->size());
  gold_assert(static_cast<section_size_type>(pov - view) == view_size);
}

// Nanomips_relax_insn methods.

// Return matching instruction for relaxation if there is one and INSN can
// be relaxed, otherwise return NULL.

template<int size, bool big_endian>
inline const Nanomips_insn_property*
Nanomips_relax_insn<size, big_endian>::find_insn(uint32_t insn,
                                                 unsigned int mask,
                                                 unsigned int r_type)
{
  const Nanomips_insn_property* insn_property =
    nanomips_insn_property_table->get_insn_property(insn, mask, r_type);
  if (insn_property == NULL)
    return NULL;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        if (!insn_property->has_transform(TT_RELAX)
            || !this->relobj()->xlp()
            || !insn_property->valid_regs(insn))
          return NULL;

        unsigned int treg = insn_property->treg(insn);
        unsigned int sreg = insn_property->sreg(insn);
        const char* name = insn_property->name().c_str();
        // We can't relax beqc to beqc[16] instruction if
        // registers are the same.
        if ((strncmp(name, "beqc", 4) == 0) && (treg == sreg))
          return NULL;
        return insn_property;
      }
    case elfcpp::R_NANOMIPS_PC25_S1:
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_LO12:
      if (!insn_property->has_transform(TT_RELAX)
          || !insn_property->valid_regs(insn))
        return NULL;
      return insn_property;
    case elfcpp::R_NANOMIPS_GPREL_I32:
      if (!insn_property->has_transform(TT_GPREL32)
          && !insn_property->has_transform(TT_GPREL32_WORD))
        return NULL;
      return insn_property;
    case elfcpp::R_NANOMIPS_PC_I32:
      if (!insn_property->has_transform(TT_PCREL32))
        return NULL;
      return insn_property;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      return insn_property;
    default:
      break;
    }
  return NULL;
}

// Return the TT_RELAX transformation type if this instruction can be relaxed.

template<int size, bool big_endian>
inline unsigned int
Nanomips_relax_insn<size, big_endian>::get_type(
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  const Address invalid_address = static_cast<Address>(0) - 1;
  const Nanomips_relobj<size, big_endian>* relobj = this->relobj();

  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend = reloc.get_r_addend();
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL_I32:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address)
          return TT_NONE;
        else if ((value & 0x3) != 0
                 && !this->template check_overflow<18>(value, CHECK_UNSIGNED))
          // Transform into addiu[gp.b].
          return TT_GPREL32;
        else if ((value & 0x3) == 0
                 && !this->template check_overflow<21>(value, CHECK_UNSIGNED))
          // Transform into addiu[gp.w].
          return TT_GPREL32_WORD;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC_I32:
      {
        // Here, the PC adjustment for 48bit instructions is 6, because address
        // is pointing to the start of the instruction.
        typedef typename elfcpp::Elf_types<size>::Elf_Swxword Signed_valtype;
        Valtype value = psymval->value(relobj, r_addend) - address - 6;

        // Correct value if this is a backward branch.
        if (static_cast<Signed_valtype>(value) < 0)
          value += 2;

        if ((value & 0x1) == 0
            && !this->template check_overflow<21>(value, CHECK_SIGNED))
          // Transform into lapc.
          return TT_PCREL32;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC25_S1:
      {
        typedef typename elfcpp::Elf_types<size>::Elf_Swxword Signed_valtype;
        Valtype value = psymval->value(relobj, r_addend) - address - 4;

        // Correct value if this is a backward branch.
        if (static_cast<Signed_valtype>(value) < 0)
          value += 2;

        if (!this->template check_overflow<11>(value, CHECK_SIGNED))
          return TT_RELAX;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (value != 0
            && !this->template check_overflow<5>(value, CHECK_UNSIGNED))
          return TT_RELAX;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp != invalid_address
            && !this->template check_overflow<9>(value, CHECK_UNSIGNED))
          return TT_RELAX;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_LO12:
      {
        Valtype value = psymval->value(relobj, r_addend) & 0xfff;
        if (((value & 0x3) == 0)
            && !this->template check_overflow<6>(value, CHECK_UNSIGNED))
          return TT_RELAX;

        return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      return Base::get_type(gsym, psymval, insn_property,
                            reloc, relnum, insn, address, gp);
    default:
      gold_unreachable();
    }
  return TT_NONE;
}

// Nanomips_relax_insn_finalize methods.

// Return the TT_RELAX transformation type if this instruction can be relaxed
// during --finalize-relocs.

template<int size, bool big_endian>
inline unsigned int
Nanomips_relax_insn_finalize<size, big_endian>::get_type(
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  Relocatable_relocs* rr = this->rr();
  gold_assert(rr != NULL);

  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return TT_NONE;

  return Nanomips_relax_insn<size, big_endian>::get_type(gsym, psymval,
                                                         insn_property, reloc,
                                                         relnum, insn,
                                                         address, gp);
}

// Nanomips_expand_insn methods.

// Return matching instruction for expansion if there is one.

template<int size, bool big_endian>
inline const Nanomips_insn_property*
Nanomips_expand_insn<size, big_endian>::find_insn(uint32_t insn,
                                                  unsigned int mask,
                                                  unsigned int r_type)
{
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
    case elfcpp::R_NANOMIPS_PC21_S1:
    case elfcpp::R_NANOMIPS_PC14_S1:
    case elfcpp::R_NANOMIPS_PC11_S1:
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
    case elfcpp::R_NANOMIPS_PC10_S1:
    case elfcpp::R_NANOMIPS_PC7_S1:
    case elfcpp::R_NANOMIPS_PC4_S1:
    case elfcpp::R_NANOMIPS_GPREL7_S2:
    case elfcpp::R_NANOMIPS_LO4_S2:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      return nanomips_insn_property_table->get_insn_property(insn, mask,
                                                             r_type);
    default:
      break;
    }
  return NULL;
}

// Return the type of the expansion.

template<int size, bool big_endian>
inline unsigned int
Nanomips_expand_insn<size, big_endian>::get_expand_type(
    const Nanomips_insn_property* insn_property,
    uint32_t insn,
    unsigned int r_type)
{
  const bool xlp = this->relobj()->xlp();
  const bool insn32 = parameters->options().insn32();
  const bool pcrel = this->relobj()->pcrel();
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      if (xlp)
        // Transform balc/bc into lapc[48], jalrc[16]/jrc[16]
        // or into into li[48], jalrc[16]/jrc[16].
        return pcrel ? TT_PCREL_XLP : TT_ABS_XLP;
      else if (!pcrel)
        // Transform balc/bc into lui, ori, jalrc/jrc.
        return insn32 ? TT_ABS32_LONG : TT_ABS16_LONG;
      else
        // Transform balc/bc into aluipc, ori, jalrc/jrc.
        return insn32 ? TT_PCREL32_LONG : TT_PCREL16_LONG;
    case elfcpp::R_NANOMIPS_PC21_S1:
      if (insn_property->has_transform(TT_MOVE_BALC))
        // Transform move.balc into move[16], balc.
        return TT_MOVE_BALC;
      else if (xlp)
        // Transform lapc into lapc[48]/li[48].
        return pcrel ? TT_PCREL_XLP : TT_ABS_XLP;
      else
        // Transform lapc into aluipc/lui, ori.
        return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
    case elfcpp::R_NANOMIPS_PC14_S1:
    case elfcpp::R_NANOMIPS_PC11_S1:
      // Transform into opposite branch and bc instruction.
      return TT_PCREL32_LONG;
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      // Transform addiu[gp.[wb]] to lui, ori, addu or into addiu[gp48],
      // or transform [ls]x[gp] into lui, addu, [ls]x or addiu[gp48], [ls]x.
      return xlp ? TT_GPREL32_XLP : TT_GPREL_LONG;
    case elfcpp::R_NANOMIPS_PC10_S1:
    case elfcpp::R_NANOMIPS_PC7_S1:
      // Transform bc16/balc16 to bc/balc for PC10_S1 reloc,
      // or transform beqzc16/bnezc16 to beqc/bnec for PC7_S1 reloc.
      return TT_PCREL32;
    case elfcpp::R_NANOMIPS_PC4_S1:
      // If rs3>=rt3 then this is bnec[16] instruction, otherwise
      // it's beqc[16].
      return (insn_property->sreg(insn) >= insn_property->treg(insn)
              ? TT_BNEC32
              : TT_BEQC32);
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      // Transform [ls]w[gp16] into [ls]w[gp].
      return TT_GPREL32_WORD;
    case elfcpp::R_NANOMIPS_LO4_S2:
      // Transform [ls]w[16] into [ls]w.
      return TT_ABS32;
    default:
      gold_unreachable();
    }
}

// Return the transformation type if instruction needs to be expanded.

template<int size, bool big_endian>
inline unsigned int
Nanomips_expand_insn<size, big_endian>::get_type(
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  const Address invalid_address = static_cast<Address>(0) - 1;
  const Nanomips_relobj<size, big_endian>* relobj = this->relobj();
  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend = reloc.get_r_addend();
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template check_overflow<26>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC21_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (((value & 0x1) == 0)
            && !this->template check_overflow<22>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template check_overflow<15>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC11_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template check_overflow<12>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template check_overflow<21>(value, CHECK_UNSIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template check_overflow<18>(value, CHECK_UNSIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC10_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if (!this->template check_overflow<11>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC7_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if (!this->template check_overflow<8>(value, CHECK_SIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC4_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if ((value != 0)
            && !this->template check_overflow<5>(value, CHECK_UNSIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template check_overflow<9>(value, CHECK_UNSIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_LO4_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) & 0xfff;
        if (((value & 0x3) == 0)
            && !this->template check_overflow<6>(value, CHECK_UNSIGNED))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      return Base::get_type(gsym, psymval, insn_property,
                            reloc, relnum, insn, address, gp);
    default:
      gold_unreachable();
    }
  return this->get_expand_type(insn_property, insn, r_type);
}

// Nanomips_expand_insn_finalize methods.

// Return the transformation type if instruction needs to be expanded
// during --finalize-relocs.

template<int size, bool big_endian>
inline unsigned int
Nanomips_expand_insn_finalize<size, big_endian>::get_type(
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  Relocatable_relocs* rr = this->rr();
  gold_assert(rr != NULL);

  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);

  // TODO: Allow code and data model transformations.
  if (r_type == elfcpp::R_NANOMIPS_GOT_DISP
      || r_type == elfcpp::R_NANOMIPS_GOT_PAGE
      || r_type == elfcpp::R_NANOMIPS_GOT_OFST
      || r_type == elfcpp::R_NANOMIPS_GOT_CALL
      || r_type == elfcpp::R_NANOMIPS_JALR32
      || r_type == elfcpp::R_NANOMIPS_JALR16)
    return TT_NONE;

  // Expand all non-RELOC_RESOLVE relocations.
  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return this->get_expand_type(insn_property, insn, r_type);

  // For RELOC_RESOLVE we need to check if we need to expand instruction.
  unsigned int type =
    Nanomips_expand_insn<size, big_endian>::get_type(gsym, psymval,
                                                     insn_property, reloc,
                                                     relnum, insn, address,
                                                     gp);
  if (type == TT_NONE)
    return TT_NONE;

  Relocatable_relocs::Reloc_strategy strategy;
  Nanomips_relobj<size, big_endian>* relobj = this->relobj();

  // We can't resolve this relocation so we need to get default strategy.
  if (gsym != NULL)
    strategy = Relocatable_relocs::RELOC_COPY;
  else if (!psymval->is_section_symbol())
    {
      relobj->set_must_have_output_symtab_entry(r_sym);
      strategy = Relocatable_relocs::RELOC_COPY;
    }
  else
    {
      bool is_ordinary;
      unsigned int shndx = psymval->input_shndx(&is_ordinary);
      relobj->output_section(shndx)->set_needs_symtab_index();
      strategy = Relocatable_relocs::RELOC_ADJUST_FOR_SECTION_RELA;
    }

  rr->set_strategy(relnum, strategy);
  rr->increase_output_reloc_count();
  return type;
}

// Target_nanomips methods.

// Create a .nanoMIPS.stubs entry for a global symbol.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::make_stubs_entry(
    Layout* layout,
    Nanomips_symbol<size>* nanomips_sym)
{
  if (this->stubs_ == NULL)
    {
      gold_assert(this->got_ != NULL);

      this->stubs_ =
        new Nanomips_output_data_stubs<size, big_endian>(this, layout);
      layout->add_output_section_data(".nanoMIPS.stubs", elfcpp::SHT_PROGBITS,
                                      (elfcpp::SHF_ALLOC
                                       | elfcpp::SHF_EXECINSTR),
                                      this->stubs_, ORDER_PLT, false);

      // Make the sh_info field of .rel.nanoMIPS.stubs
      // point to .nanoMIPS.stubs.
      Output_section* rel_stubs_os =
        this->stubs_->rel_stubs()->output_section();
      rel_stubs_os->set_info_section(this->stubs_->output_section());
    }

  this->stubs_->add_entry(nanomips_sym);
}

// Get the dynamic reloc section, creating it if necessary.

template<int size, bool big_endian>
typename Target_nanomips<size, big_endian>::Reloc_section*
Target_nanomips<size, big_endian>::rel_dyn_section(Layout* layout)
{
  if (this->rel_dyn_ == NULL)
    {
      gold_assert(layout != NULL);
      this->rel_dyn_ = new Reloc_section(parameters->options().combreloc());
      layout->add_output_section_data(".rel.dyn", elfcpp::SHT_REL,
                                      elfcpp::SHF_ALLOC, this->rel_dyn_,
                                      ORDER_DYNAMIC_RELOCS, false);
    }

  return this->rel_dyn_;
}

// Get the GOT section, creating it if necessary.

template<int size, bool big_endian>
Nanomips_output_data_got<size, big_endian>*
Target_nanomips<size, big_endian>::got_section(Symbol_table* symtab,
                                               Layout* layout)
{
  if (this->got_ == NULL)
    {
      gold_assert(symtab != NULL && layout != NULL);
      this->got_ = new Nanomips_output_data_got<size, big_endian>(this);
      layout->add_output_section_data(".got", elfcpp::SHT_PROGBITS,
                                      (elfcpp::SHF_ALLOC | elfcpp::SHF_WRITE |
                                      elfcpp::SHF_NANOMIPS_GPREL),
                                      this->got_, ORDER_DATA, false);

      // First two GOT entries are reserved.
      this->got_->add_constant(0);
      this->got_->add_constant(0);

      // Define _GLOBAL_OFFSET_TABLE_ at the start of the .got section.
      symtab->define_in_output_data("_GLOBAL_OFFSET_TABLE_", NULL,
                                    Symbol_table::PREDEFINED,
                                    this->got_,
                                    0, 0, elfcpp::STT_OBJECT,
                                    elfcpp::STB_GLOBAL,
                                    elfcpp::STV_HIDDEN, 0,
                                    false, false);
    }

  return this->got_;
}
// Calculate value of _gp symbol.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::set_gp(Layout* layout, Symbol_table* symtab)
{
  gold_assert(this->gp_ == NULL);

  Sized_symbol<size>* gp =
    static_cast<Sized_symbol<size>*>(symtab->lookup("_gp"));

  // Set _gp symbol if the linker script hasn't created it.
  if (gp == NULL || gp->source() != Symbol::IS_CONSTANT)
    {
      // If there is no .got section, gp should be based on .sdata.
      Output_data* gp_section = (this->got_ != NULL
                                 ? this->got_->output_section()
                                 : layout->find_output_section(".sdata"));

      if (gp_section != NULL)
        gp = static_cast<Sized_symbol<size>*>(symtab->define_in_output_data(
                                              "_gp", NULL,
                                              Symbol_table::PREDEFINED,
                                              gp_section, 0, 0,
                                              elfcpp::STT_NOTYPE,
                                              elfcpp::STB_LOCAL,
                                              elfcpp::STV_DEFAULT,
                                              0, false, false));
    }

  this->gp_ = gp;
}

// Relaxation hook.  This is where we do transformations of nanoMIPS
// instructions.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::do_relax(
    int pass,
    const Input_objects* input_objects,
    Symbol_table* symtab,
    Layout* layout,
    const Task* task)
{
  if (pass == 1 && parameters->options().any_sort_by_reference())
    {
      bool sorted = false;

      // Sort sections by reference.
      for (options::String_set::const_iterator p =
             parameters->options().sort_by_reference_begin();
           p != parameters->options().sort_by_reference_end();
           ++p)
        {
          const char* name = p->c_str();
          Output_section* os = layout->find_output_section(name);
          if (os == NULL)
            continue;

          gold_debug(DEBUG_TARGET,
                     "%d pass: Sorting %s section by reference",
                     pass, name);

          Nanomips_output_section<size, big_endian>* nanomips_output_section =
              static_cast<Nanomips_output_section<size, big_endian>*>(os);
          nanomips_output_section->sort_sections_by_reference();
          sorted = true;
        }

      if (sorted)
        return true;
    }

  // Whether we need to continue doing instruction transformations.
  bool again = false;
  // Whether the state is changed from RELAX to EXPAND.
  bool state_changed;

  do
    {
      state_changed = false;
      gold_debug(DEBUG_TARGET, "%d pass: %s",
                 pass, this->state_ == RELAX ? "Relaxations" : "Expansions");

      // Scan relocs for instruction transformations.
      for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
           p != input_objects->relobj_end();
           ++p)
        {
          Nanomips_relobj<size, big_endian>* relobj =
            Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);

          // Lock the object so we can read from it.  This is only called
          // single-threaded from Layout::finalize, so it is OK to lock.
          Task_lock_obj<Object> tl(task, relobj);
          again |= relobj->scan_sections_for_transform(this, symtab, layout);
        }

      // Change the state to EXPAND if we are done with relaxations.
      if (!again
          && this->state_ == RELAX)
        {
          this->state_ = EXPAND;
          state_changed = true;
        }
    }
  // If the state is changed, we don't want to call relaxation pass because
  // there is no changes in previous state.
  while (state_changed);

  return again;
}

// Relocate conditional branches.  This is only used if we have transformed
// conditional branch into opposite branch and bc instruction in a relaxation
// pass.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::relocate_branch(
    unsigned int r_type,
    Address destination,
    Address address,
    unsigned char* view)
{
  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  unsigned int align = reloc_property->align();
  Valtype value = destination - (address + 4);

  typedef Nanomips_relocate_functions<size, big_endian> Reloc_funcs;
  typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;
  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_unshuffle(view, reloc_property->size());
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, align, true);
      break;
    default:
      gold_unreachable();
      break;
    }
  gold_assert(reloc_status == Reloc_funcs::STATUS_OKAY);
  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_shuffle(view, reloc_property->size());
}

// Process the relocations to determine unreferenced sections for
// garbage collection.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::gc_process_relocs(
    Symbol_table* symtab,
    Layout* layout,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* output_section,
    bool needs_special_offset_handling,
    size_t local_symbol_count,
    const unsigned char* plocal_symbols)
{
  typedef Target_nanomips<size, big_endian> Nanomips;
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  gold::gc_process_relocs<size, big_endian, Nanomips, Scan, Classify_reloc>(
    symtab,
    layout,
    this,
    object,
    data_shndx,
    prelocs,
    reloc_count,
    output_section,
    needs_special_offset_handling,
    local_symbol_count,
    plocal_symbols);
}

// Scan relocations for a section.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::scan_relocs(
    Symbol_table* symtab,
    Layout* layout,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* output_section,
    bool needs_special_offset_handling,
    size_t local_symbol_count,
    const unsigned char* plocal_symbols)
{
  typedef Target_nanomips<size, big_endian> Nanomips;
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  gold::scan_relocs<size, big_endian, Nanomips, Scan, Classify_reloc>(
    symtab,
    layout,
    this,
    object,
    data_shndx,
    prelocs,
    reloc_count,
    output_section,
    needs_special_offset_handling,
    local_symbol_count,
    plocal_symbols);
}

// Check whether the given ELF header flags describe a 32-bit binary.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::nanomips_32bit_flags(elfcpp::Elf_Word flags)
{
  return ((flags & elfcpp::EF_NANOMIPS_32BITMODE) != 0
          || ((flags & elfcpp::EF_NANOMIPS_ARCH)
              == elfcpp::E_NANOMIPS_ARCH_32R6));
}

// Update the isa_level and isa_rev fields of abiflags.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::update_abiflags_isa(
    const Nanomips_relobj<size, big_endian>* relobj,
    Nanomips_abiflags<big_endian>* abiflags)
{
  elfcpp::Elf_Word e_flags = relobj->processor_specific_flags();
  switch (e_flags & elfcpp::EF_NANOMIPS_ARCH)
    {
    case elfcpp::E_NANOMIPS_ARCH_32R6:
      abiflags->isa_level = 32;
      abiflags->isa_rev = 6;
      break;
    case elfcpp::E_NANOMIPS_ARCH_64R6:
      abiflags->isa_level = 64;
      abiflags->isa_rev = 6;
      break;
    default:
      gold_error(_("%s: Unknown architecture"), relobj->name().c_str());
    }
}

// Infer the content of the ABI flags based on the elf header.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::infer_abiflags(
    const Nanomips_relobj<size, big_endian>* relobj,
    Nanomips_abiflags<big_endian>* abiflags)
{
  const Attributes_section_data* pasd = relobj->attributes_section_data();
  int attr_fp_abi = elfcpp::Val_GNU_NANOMIPS_ABI_FP_ANY;
  elfcpp::Elf_Word e_flags = relobj->processor_specific_flags();

  this->update_abiflags_isa(relobj, abiflags);

  if (pasd != NULL)
    {
      // Read fp_abi from the .gnu.attribute section.
      const Object_attribute* attr =
        pasd->known_attributes(Object_attribute::OBJ_ATTR_GNU);
      attr_fp_abi = attr[elfcpp::Tag_GNU_NANOMIPS_ABI_FP].int_value();
    }

  abiflags->fp_abi = attr_fp_abi;
  abiflags->cpr1_size = elfcpp::AFL_REG_NONE;
  abiflags->cpr2_size = elfcpp::AFL_REG_NONE;
  abiflags->gpr_size = (this->nanomips_32bit_flags(e_flags)
                        ? elfcpp::AFL_REG_32
                        : elfcpp::AFL_REG_64);

  if (abiflags->fp_abi == elfcpp::Val_GNU_NANOMIPS_ABI_FP_SINGLE
      || (abiflags->fp_abi == elfcpp::Val_GNU_NANOMIPS_ABI_FP_DOUBLE
          && abiflags->gpr_size == elfcpp::AFL_REG_32))
    abiflags->cpr1_size = elfcpp::AFL_REG_32;
  else if (abiflags->fp_abi == elfcpp::Val_GNU_NANOMIPS_ABI_FP_DOUBLE)
    abiflags->cpr1_size = elfcpp::AFL_REG_64;
}

// Create abiflags from elf header or from .nanoMIPS.abiflags section.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::create_abiflags(
    Nanomips_relobj<size, big_endian>* relobj,
    Nanomips_abiflags<big_endian>* abiflags)
{
  Nanomips_abiflags<big_endian>* sec_abiflags = relobj->abiflags();
  Nanomips_abiflags<big_endian> header_abiflags;

  this->infer_abiflags(relobj, &header_abiflags);

  if (sec_abiflags == NULL)
    {
      // If there is no input .nanoMIPS.abiflags section, use abiflags created
      // from elf header.
      *abiflags = header_abiflags;
      return;
    }

  this->has_abiflags_section_ = true;

  // Check compatibility between abiflags created from elf header
  // and abiflags from .nanoMIPS.abiflags section in this object file.
  if (sec_abiflags->isa_level != header_abiflags.isa_level
      || sec_abiflags->isa_rev != header_abiflags.isa_rev)
    gold_warning(_("%s: Inconsistent ISA between e_flags and "
                   ".nanoMIPS.abiflags"), relobj->name().c_str());
  if (header_abiflags.fp_abi != elfcpp::Val_GNU_NANOMIPS_ABI_FP_ANY
      && sec_abiflags->fp_abi != header_abiflags.fp_abi)
    gold_warning(_("%s: Inconsistent FP ABI between .gnu.attributes and "
                   ".nanoMIPS.abiflags"), relobj->name().c_str());
  if ((sec_abiflags->ases & header_abiflags.ases) != header_abiflags.ases)
    gold_warning(_("%s: Inconsistent ASEs between e_flags and "
                   ".nanoMIPS.abiflags"), relobj->name().c_str());
  // Use abiflags from .nanoMIPS.abiflags section.
  *abiflags = *sec_abiflags;
}

// Return the meaning of fp_abi, or "unknown" if not known.

template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::fp_abi_string(int fp)
{
  switch (fp)
    {
    case elfcpp::Val_GNU_NANOMIPS_ABI_FP_DOUBLE:
      return "-mdouble-float";
    case elfcpp::Val_GNU_NANOMIPS_ABI_FP_SINGLE:
      return "-msingle-float";
    case elfcpp::Val_GNU_NANOMIPS_ABI_FP_SOFT:
      return "-msoft-float";
    default:
      return "unknown";
    }
}

// Select fp_abi field of abiflags.

template<int size, bool big_endian>
int
Target_nanomips<size, big_endian>::select_fp_abi(const std::string& name,
                                                 int in_fp, int out_fp)
{
  if (out_fp == elfcpp::Val_GNU_NANOMIPS_ABI_FP_ANY
      || in_fp == out_fp)
    return in_fp;

  if (in_fp != elfcpp::Val_GNU_NANOMIPS_ABI_FP_ANY)
    gold_warning(_("%s: FP ABI %s is incompatible with %s"),
                 name.c_str(), this->fp_abi_string(in_fp),
                 this->fp_abi_string(out_fp));

  return out_fp;
}

// Select isa_ext field of abiflags.

template<int size, bool big_endian>
int
Target_nanomips<size, big_endian>::select_isa_ext(const std::string& name,
                                                  int in_isa_ext,
                                                  int out_isa_ext)
{
  if (out_isa_ext == elfcpp::AFL_EXT_NONE
      || in_isa_ext == out_isa_ext)
    return in_isa_ext;

  if (in_isa_ext != elfcpp::AFL_EXT_NONE)
    gold_warning(_("%s: processor specific extension (%#x) is "
                   "incompatible with (%#x)"),
                 name.c_str(), in_isa_ext, out_isa_ext);

  return out_isa_ext;
}

// Check whether machine EXTENSION is an extension of machine BASE.
// This method is implemented like Target_mips::mips_mach_extends
// for the future reference.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::nanomips_mach_extends(unsigned int base,
                                                         unsigned int extension)
{
  if (extension == base)
    return true;

  if ((base == mach_nanomipsisa32r6)
      && this->nanomips_mach_extends(mach_nanomipsisa64r6, extension))
    return true;

  return false;
}

// Return the MACH for a nanoMIPS e_flags value.

template<int size, bool big_endian>
unsigned int
Target_nanomips<size, big_endian>::nanomips_mach(elfcpp::Elf_Word flags)
{
  switch (flags & elfcpp::EF_NANOMIPS_ARCH)
    {
    default:
    case elfcpp::E_NANOMIPS_ARCH_32R6:
      return mach_nanomipsisa32r6;
    case elfcpp::E_NANOMIPS_ARCH_64R6:
      return mach_nanomipsisa64r6;
    }
}

// Return printable name for ABI.

template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::nanomips_abi_name(elfcpp::Elf_Word e_flags)
{
  switch (e_flags & elfcpp::EF_NANOMIPS_ABI)
    {
    case 0:
      return "none";
    case elfcpp::E_NANOMIPS_ABI_P32:
      return "P32";
    case elfcpp::E_NANOMIPS_ABI_P64:
      return "P64";
    default:
      return "unknown abi";
    }
}

// Return printable name for MACH.

template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::nanomips_mach_name(elfcpp::Elf_Word e_flags)
{
  switch (e_flags & elfcpp::EF_NANOMIPS_ARCH)
    {
    case elfcpp::E_NANOMIPS_ARCH_32R6:
      return "nanomips:isa32r6";
    case elfcpp::E_NANOMIPS_ARCH_64R6:
      return "nanomips:isa64r6";
    default:
      return "unknown CPU";
    }
}

// Merge attributes from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_attributes(
    const std::string& name,
    const Attributes_section_data* pasd)
{
  // Return if there is no attributes section data.
  if (pasd == NULL)
    return;

  // If output has no object attributes, just copy.
  if (this->attributes_section_data_ == NULL)
    {
      this->attributes_section_data_ = new Attributes_section_data(*pasd);
      return;
    }

  Object_attribute* out_attr = this->attributes_section_data_->known_attributes(
      Object_attribute::OBJ_ATTR_GNU);

  out_attr[elfcpp::Tag_GNU_NANOMIPS_ABI_FP].set_type(1);
  out_attr[elfcpp::Tag_GNU_NANOMIPS_ABI_FP].set_int_value(
      this->abiflags_->fp_abi);

  // Merge Tag_compatibility attributes and any common GNU ones.
  this->attributes_section_data_->merge(name.c_str(), pasd);
}

// Merge abiflags from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_abiflags(
    const std::string& name,
    Nanomips_abiflags<big_endian>* in_abiflags)
{
  // If output has no abiflags, just copy.
  if (this->abiflags_ == NULL)
    {
      this->abiflags_ = new Nanomips_abiflags<big_endian>(*in_abiflags);
      return;
    }

  // Merge abiflags.
  this->abiflags_->isa_level = std::max(this->abiflags_->isa_level,
                                        in_abiflags->isa_level);
  this->abiflags_->isa_rev = std::max(this->abiflags_->isa_rev,
                                      in_abiflags->isa_rev);
  this->abiflags_->gpr_size = std::max(this->abiflags_->gpr_size,
                                       in_abiflags->gpr_size);
  this->abiflags_->cpr1_size = std::max(this->abiflags_->cpr1_size,
                                        in_abiflags->cpr1_size);
  this->abiflags_->cpr2_size = std::max(this->abiflags_->cpr2_size,
                                        in_abiflags->cpr2_size);
  this->abiflags_->fp_abi = this->select_fp_abi(name, in_abiflags->fp_abi,
                                                this->abiflags_->fp_abi);
  this->abiflags_->isa_ext = this->select_isa_ext(name, in_abiflags->isa_ext,
                                                  this->abiflags_->isa_ext);
  this->abiflags_->ases |= in_abiflags->ases;
  this->abiflags_->flags1 |= in_abiflags->flags1;
  this->abiflags_->flags2 |= in_abiflags->flags2;
}

// Merge file header flags from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_e_flags(const std::string& name,
                                                     elfcpp::Elf_Word new_flags)
{
  // If flags are not set yet, just copy them.
  if (!this->are_processor_specific_flags_set())
    {
      this->set_processor_specific_flags(new_flags);
      return;
    }

  elfcpp::Elf_Word old_flags = this->processor_specific_flags();
  elfcpp::Elf_Word merged_flags = this->processor_specific_flags();
  merged_flags |= new_flags & elfcpp::EF_NANOMIPS_LINKRELAX;

  new_flags &= ~(elfcpp::EF_NANOMIPS_PID | elfcpp::EF_NANOMIPS_PCREL
                 | elfcpp::EF_NANOMIPS_LINKRELAX);
  old_flags &= ~(elfcpp::EF_NANOMIPS_PID | elfcpp::EF_NANOMIPS_PCREL
                 | elfcpp::EF_NANOMIPS_LINKRELAX);

  if (new_flags == old_flags)
    {
      this->set_processor_specific_flags(merged_flags);
      return;
    }

  if ((new_flags & elfcpp::EF_NANOMIPS_PIC)
      != (old_flags & elfcpp::EF_NANOMIPS_PIC))
    gold_warning(_("%s: linking abicalls files with non-abicalls files"),
                 name.c_str());

  if ((new_flags & elfcpp::EF_NANOMIPS_PIC) == 0)
    merged_flags &= ~elfcpp::EF_NANOMIPS_PIC;

  new_flags &= ~elfcpp::EF_NANOMIPS_PIC;
  old_flags &= ~elfcpp::EF_NANOMIPS_PIC;

  // Compare the ISAs.
  if (this->nanomips_32bit_flags(old_flags)
      != this->nanomips_32bit_flags(new_flags))
    gold_error(_("%s: linking 32-bit code with 64-bit code"), name.c_str());
  else if (!this->nanomips_mach_extends(this->nanomips_mach(new_flags),
                                        this->nanomips_mach(old_flags)))
    {
      // Output ISA isn't the same as input ISA.
      if (this->nanomips_mach_extends(this->nanomips_mach(old_flags),
                                      this->nanomips_mach(new_flags)))
        {
          // Copy the architecture info from input object to output.  Also copy
          // the 32-bit flag (if set) so that we continue to recognise
          // output as a 32-bit binary.
          merged_flags &= ~(elfcpp::EF_NANOMIPS_ARCH
                            | elfcpp::EF_NANOMIPS_MACH);
          merged_flags |= (new_flags & (elfcpp::EF_NANOMIPS_ARCH
                                        | elfcpp::EF_NANOMIPS_MACH
                                        | elfcpp::EF_NANOMIPS_32BITMODE));
        }
      else
        // The ISAs aren't compatible.
        gold_error(_("%s: linking %s module with previous %s modules"),
                   name.c_str(), this->nanomips_mach_name(new_flags),
                   this->nanomips_mach_name(old_flags));
    }

  new_flags &= ~(elfcpp::EF_NANOMIPS_ARCH | elfcpp::EF_NANOMIPS_MACH
                 | elfcpp::EF_NANOMIPS_32BITMODE);
  old_flags &= ~(elfcpp::EF_NANOMIPS_ARCH | elfcpp::EF_NANOMIPS_MACH
                 | elfcpp::EF_NANOMIPS_32BITMODE);

  // Compare ABIs.
  if ((new_flags & elfcpp::EF_NANOMIPS_ABI)
      != (old_flags & elfcpp::EF_NANOMIPS_ABI))
    {
      // Only error if both are set (to different values).
      if ((new_flags & elfcpp::EF_NANOMIPS_ABI) != 0
           && (old_flags & elfcpp::EF_NANOMIPS_ABI) != 0)
        gold_error(_("%s: ABI mismatch: linking %s module with "
                     "previous %s modules"),
                   name.c_str(), this->nanomips_abi_name(new_flags),
                   this->nanomips_abi_name(old_flags));

      new_flags &= ~elfcpp::EF_NANOMIPS_ABI;
      old_flags &= ~elfcpp::EF_NANOMIPS_ABI;
    }

  // Warn about any other mismatches.
  if (new_flags != old_flags)
    gold_error(_("%s: uses different e_flags (%#x) fields than previous "
                 "modules (%#x)"), name.c_str(), new_flags, old_flags);

  this->set_processor_specific_flags(merged_flags);
}

// do_make_elf_object to override the same function in the base class.
// We need to use a target-specific sub-class of
// Sized_relobj_file<size, big_endian> to store Nanomips specific information.
// Hence we need to have our own ELF object creation.

template<int size, bool big_endian>
Object*
Target_nanomips<size, big_endian>::do_make_elf_object(
    const std::string& name,
    Input_file* input_file,
    off_t offset, const elfcpp::Ehdr<size, big_endian>& ehdr)
{
  int et = ehdr.get_e_type();
  // ET_EXEC files are valid input for --just-symbols/-R,
  // and we treat them as relocatable objects.
  if (et == elfcpp::ET_REL
      || (et == elfcpp::ET_EXEC && input_file->just_symbols()))
    {
      Nanomips_relobj<size, big_endian>* obj =
        new Nanomips_relobj<size, big_endian>(name, input_file, offset, ehdr);
      obj->setup();
      return obj;
    }
  else if (et == elfcpp::ET_DYN)
    return Target::do_make_elf_object(name, input_file, offset, ehdr);
  else
    {
      gold_error(_("%s: unsupported ELF file type %d"),
                 name.c_str(), et);
      return NULL;
    }
}

// Finalize the sections.

template <int size, bool big_endian>
void
Target_nanomips<size, big_endian>::do_finalize_sections(
    Layout* layout,
    const Input_objects* input_objects,
    Symbol_table* symtab)
{
  // Merge processor specific flags.
  for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
       p != input_objects->relobj_end();
       ++p)
    {
      Nanomips_relobj<size, big_endian>* relobj =
        Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);

      if (!relobj->merge_processor_specific_data())
        continue;

      Nanomips_abiflags<big_endian> in_abiflags;

      this->create_abiflags(relobj, &in_abiflags);
      this->merge_obj_e_flags(relobj->name(),
                              relobj->processor_specific_flags());
      this->merge_obj_abiflags(relobj->name(), &in_abiflags);
      this->merge_obj_attributes(relobj->name(),
                                 relobj->attributes_section_data());
    }

  // Mark this output file as not safe to relax if we are finalizing relocs
  // during relocatable linking.
  if (parameters->options().finalize_relocs()
      && this->are_processor_specific_flags_set())
    {
      elfcpp::Elf_Word flags = this->processor_specific_flags();
      flags &= ~elfcpp::EF_NANOMIPS_LINKRELAX;
      this->set_processor_specific_flags(flags);
    }

  // Create a .gnu.attributes section if we have merged any attributes
  // from inputs.
  if (this->attributes_section_data_ != NULL)
    {
      Output_attributes_section_data* attributes_section =
        new Output_attributes_section_data(*this->attributes_section_data_);
      layout->add_output_section_data(".gnu.attributes",
                                      elfcpp::SHT_GNU_ATTRIBUTES, 0,
                                      attributes_section, ORDER_INVALID, false);
    }

  // Create .nanoMIPS.abiflags output section if there is an input section.
  if (this->has_abiflags_section_)
    {
      Nanomips_output_section_abiflags<size, big_endian>* abiflags_section =
        new Nanomips_output_section_abiflags<size, big_endian>(
          *this->abiflags_);

      Output_section* os =
        layout->add_output_section_data(".nanoMIPS.abiflags",
                                        elfcpp::SHT_NANOMIPS_ABIFLAGS,
                                        elfcpp::SHF_ALLOC,
                                        abiflags_section, ORDER_INVALID, false);

      if (os != NULL && !parameters->options().relocatable())
        {
          Output_segment* abiflags_segment =
            layout->make_output_segment(elfcpp::PT_NANOMIPS_ABIFLAGS,
                                        elfcpp::PF_R);
          abiflags_segment->add_output_section_to_nonload(os, elfcpp::PF_R);
        }
    }

  // Set _gp value.
  if (!parameters->options().relocatable())
    this->set_gp(layout, symtab);

  if (this->got_ != NULL)
    this->got_->finalize_got_call_symbols(layout);

  if (this->stubs_ != NULL)
    this->stubs_->set_lazy_stub_offsets();

  layout->add_target_dynamic_tags(true, NULL, NULL, this->rel_dyn_,
                                  true, false);
}

// Relocate section data.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::relocate_section(
    const Relocate_info<size, big_endian>* relinfo,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* output_section,
    bool needs_special_offset_handling,
    unsigned char* view,
    Address address,
    section_size_type view_size,
    const Reloc_symbol_changes* reloc_symbol_changes)
{
  typedef Target_nanomips<size, big_endian> Nanomips;
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;
  typedef typename Target_nanomips<size, big_endian>::Relocate
      Nanomips_relocate;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  // See if we are relocating a relaxed input section.  If so, the view
  // covers the whole output section and we need to adjust accordingly.
  if (needs_special_offset_handling)
    {
      const Output_relaxed_input_section* poris =
        output_section->find_relaxed_input_section(relinfo->object,
                                                   relinfo->data_shndx);
      const Nanomips_input_section* pnis =
        Nanomips_input_section::as_nanomips_input_section(poris);

      if (pnis != NULL)
        {
          Address section_address = pnis->address();
          section_size_type section_size = pnis->data_size();

          gold_assert((section_address >= address)
                      && ((section_address + section_size)
                          <= (address + view_size)));

          off_t offset = section_address - address;
          view += offset;
          address += offset;
          view_size = section_size;
          prelocs = pnis->relocs();
          reloc_count = pnis->reloc_count();
        }
    }

  gold::relocate_section<size, big_endian, Nanomips, Nanomips_relocate,
                         gold::Default_comdat_behavior, Classify_reloc>(
    relinfo,
    this,
    prelocs,
    reloc_count,
    output_section,
    needs_special_offset_handling,
    view,
    address,
    view_size,
    reloc_symbol_changes);
}

// This is the same version of the function by the same name in target-reloc.h,
// just with a check if the section being relocated and the section where symbol
// is defined are in the same output section.  This is need for resolving pc-rel
// relocations for relocatable output.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::scan_relocatable_relocs(
    Symbol_table*,
    Layout*,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* output_section,
    bool needs_special_offset_handling,
    size_t local_symbol_count,
    const unsigned char* plocal_syms,
    Relocatable_relocs* rr)
{
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;
  typedef Nanomips_scan_relocatable_relocs<Classify_reloc>
      Scan_relocatable_reloc;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  typedef typename Scan_relocatable_reloc::Reltype Reltype;
  const int reloc_size = Scan_relocatable_reloc::reloc_size;
  const int sym_size = elfcpp::Elf_sizes<size>::sym_size;
  Scan_relocatable_reloc scan;

  for (size_t i = 0; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      Relocatable_relocs::Reloc_strategy strategy;

      if (needs_special_offset_handling
          && !output_section->is_input_address_mapped(object, data_shndx,
                                                      reloc.get_r_offset()))
        strategy = Relocatable_relocs::RELOC_DISCARD;
      else
        {
          const unsigned int r_sym = Scan_relocatable_reloc::get_r_sym(&reloc);
          const unsigned int r_type =
            Scan_relocatable_reloc::get_r_type(&reloc);

          if (r_sym >= local_symbol_count)
            {
              const Symbol* gsym = object->global_symbol(r_sym);
              // Whether the section being relocated and the section where symbol
              // is defined are in the same output section.
              bool in_same_section = output_section == gsym->output_section();
              strategy = scan.global_strategy(r_type, in_same_section);
            }
          else
            {
              gold_assert(plocal_syms != NULL);
              typename elfcpp::Sym<size, big_endian> lsym(plocal_syms
                                                          + r_sym * sym_size);
              unsigned int shndx = lsym.get_st_shndx();
              bool is_ordinary;
              shndx = object->adjust_sym_shndx(r_sym, shndx, &is_ordinary);
              // Whether the section being relocated and the section where symbol
              // is defined are in the same output section.
              bool in_same_section =
                (is_ordinary
                 && shndx != elfcpp::SHN_UNDEF
                 && (object->output_section(shndx) == output_section));

              if (is_ordinary
                  && shndx != elfcpp::SHN_UNDEF
                  && !object->is_section_included(shndx))
                {
                  // RELOC is a relocation against a local symbol
                  // defined in a section we are discarding.  Discard
                  // the reloc.  FIXME: Should we issue a warning?
                  strategy = Relocatable_relocs::RELOC_DISCARD;
                }
              else if (lsym.get_st_type() != elfcpp::STT_SECTION)
                strategy = scan.local_non_section_strategy(r_type,
                                                           in_same_section);
              else
                {
                  strategy = scan.local_section_strategy(r_type,
                                                         in_same_section);
                  if (strategy != Relocatable_relocs::RELOC_DISCARD
                      && strategy != Relocatable_relocs::RELOC_RESOLVE)
                    object->output_section(shndx)->set_needs_symtab_index();
                }

              if (strategy == Relocatable_relocs::RELOC_COPY)
                object->set_must_have_output_symtab_entry(r_sym);
            }
        }

      rr->set_next_reloc_strategy(strategy);
    }
}

// Scan the relocs for --emit-relocs.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::emit_relocs_scan(
    Symbol_table* symtab,
    Layout* layout,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* output_section,
    bool needs_special_offset_handling,
    size_t local_symbol_count,
    const unsigned char* plocal_syms,
    Relocatable_relocs* rr)
{
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;
  typedef gold::Default_emit_relocs_strategy<Classify_reloc>
      Emit_relocs_strategy;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  gold::scan_relocatable_relocs<size, big_endian, Emit_relocs_strategy>(
    symtab,
    layout,
    object,
    data_shndx,
    prelocs,
    reloc_count,
    output_section,
    needs_special_offset_handling,
    local_symbol_count,
    plocal_syms,
    rr);
}

// Emit relocations for a section.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::relocate_relocs(
                        const Relocate_info<size, big_endian>* relinfo,
                        unsigned int sh_type,
                        const unsigned char* prelocs,
                        size_t reloc_count,
                        Output_section* output_section,
                        typename elfcpp::Elf_types<size>::Elf_Off
                          offset_in_output_section,
                        unsigned char* view,
                        Address view_address,
                        section_size_type view_size,
                        unsigned char* reloc_view,
                        section_size_type reloc_view_size)
{
  typedef gold::Default_classify_reloc<elfcpp::SHT_RELA, size, big_endian>
      Classify_reloc;
  const Address invalid_address = static_cast<Address>(0) - 1;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  // See if we are relocating relocs for a relaxed input section.  If so,
  // the view covers the whole output section and we need to adjust accordingly.
  if (offset_in_output_section == invalid_address)
    {
      const Output_relaxed_input_section* poris =
        output_section->find_relaxed_input_section(relinfo->object,
                                                   relinfo->data_shndx);
      const Nanomips_input_section* pnis =
        Nanomips_input_section::as_nanomips_input_section(poris);

      if (pnis != NULL)
        {
          Address section_address = pnis->address();
          section_size_type section_size = pnis->data_size();

          gold_assert((section_address >= view_address)
                      && ((section_address + section_size)
                          <= (view_address + view_size)));

          off_t offset = section_address - view_address;
          view += offset;
          view_address += offset;
          view_size = section_size;
          prelocs = pnis->relocs();
          reloc_count = pnis->reloc_count();
        }
    }

  gold::relocate_relocs<size, big_endian, Classify_reloc>(
    relinfo,
    prelocs,
    reloc_count,
    output_section,
    offset_in_output_section,
    view,
    view_address,
    view_size,
    reloc_view,
    reloc_view_size);
}

// Perform target-specific processing in a relocatable link.  This is
// only used if we use the relocation strategy RELOC_RESOLVE.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::resolve_pcrel_relocatable(
    const Relocate_info<size, big_endian>* relinfo,
    unsigned int sh_type,
    const unsigned char* preloc,
    size_t relnum,
    Output_section* output_section,
    typename elfcpp::Elf_types<size>::Elf_Off offset_in_output_section,
    unsigned char* view,
    Address,
    section_size_type)
{
  gold_assert(sh_type == elfcpp::SHT_RELA);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef Nanomips_relocate_functions<size, big_endian> Reloc_funcs;
  const Address invalid_address = static_cast<Address>(0) - 1;

  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const unsigned int local_count = relobj->local_symbol_count();
  Reltype reloc(preloc);

  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  const unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  const unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  Address r_addend = reloc.get_r_addend();

  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  const Sized_symbol<size>* sym;
  Symbol_value<size> symval;
  const Symbol_value<size> *psymval;
  if (r_sym < local_count)
    {
      sym = NULL;
      psymval = relobj->local_symbol(r_sym);
    }
  else
    {
      const Symbol* gsym = relobj->global_symbol(r_sym);
      gold_assert(gsym != NULL);
      if (gsym->is_forwarder())
        gsym = relinfo->symtab->resolve_forwards(gsym);

      sym = static_cast<const Sized_symbol<size>*>(gsym);
      symval.set_output_value(sym->value());
      psymval = &symval;
    }

  // Get the new offset--the location in the output section where
  // this relocation should be applied.
  Address offset = reloc.get_r_offset();
  Address new_offset;
  if (offset_in_output_section != invalid_address)
    new_offset = offset + offset_in_output_section;
  else
    {
      section_offset_type sot_offset =
        convert_types<section_offset_type, Address>(offset);
      section_offset_type new_sot_offset =
        output_section->output_offset(relobj, relinfo->data_shndx,
                                      sot_offset);
      gold_assert(new_sot_offset != -1);
      new_offset = new_sot_offset;
    }

  typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;
  view += offset;

  Valtype value = 0;
  unsigned int align = reloc_property->align();
  // Instruction size in bytes.  The PC adjustment for 48bit instructions is 4
  // because the reloc applies to an offset of 2 from the opcode.
  unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
  value = psymval->value(relobj, r_addend) - (new_offset + insn_size);

  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_unshuffle(view, reloc_property->size());
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC_I32:
      reloc_status = Reloc_funcs::rel32(view, value);
      break;
    case elfcpp::R_NANOMIPS_PC25_S1:
      reloc_status = Reloc_funcs::relpc25_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC21_S1:
      reloc_status = Reloc_funcs::relpc21_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC10_S1:
      reloc_status = Reloc_funcs::relpc10_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC7_S1:
      reloc_status = Reloc_funcs::relpc7_s1(view, value, align, true);
      break;
    case elfcpp::R_NANOMIPS_PC4_S1:
      reloc_status = Reloc_funcs::relpc4_s1(view, value, align, true);
      break;
    default:
      gold_unreachable();
    }
  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_shuffle(view, reloc_property->size());

  // Report any errors.
  switch (reloc_status)
    {
    case Reloc_funcs::STATUS_OKAY:
      break;
    case Reloc_funcs::STATUS_OVERFLOW:
      if (sym == NULL)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("relocation overflow: "
                                 "%s against local symbol '%s' with index %u: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               relobj->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value,
                               reloc_property->bitsize());
      else if (sym->is_defined() && sym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("relocation overflow: "
                                 "%s against '%s' defined in %s: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               sym->object()->name().c_str(),
                               (unsigned long long) value,
                               reloc_property->bitsize());
      else
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("relocation overflow: "
                                 "%s against '%s': "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               (unsigned long long) value,
                               reloc_property->bitsize());
      break;
    case Reloc_funcs::STATUS_UNALIGNED:
      if (sym == NULL)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("unaligned relocation value: "
                                 "%s against local symbol '%s' with index %u: "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               relobj->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value, align);
      else if (sym->is_defined() && sym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("unaligned relocation value: "
                                 "%s against '%s' defined in %s: "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               sym->object()->name().c_str(),
                               (unsigned long long) value, align);
      else
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("unaligned relocation value: "
                                 "%s against '%s': "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               (unsigned long long) value, align);
      break;
    default:
      gold_unreachable();
    }
}

// Scan a section for instruction transformation.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::scan_section_for_transform(
    const Relocate_info<size, big_endian>* relinfo,
    unsigned int sh_type,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* os,
    Nanomips_input_section* pnis,
    const unsigned char* view,
    Address view_address)
{
  gold_assert(sh_type == elfcpp::SHT_RELA);

  if (this->state_ == RELAX)
    {
      if (parameters->options().finalize_relocs())
        {
          typedef Nanomips_relax_insn_finalize<size, big_endian> Relax;
          return this->scan_reloc_section_for_transform<Relax>(
            relinfo,
            prelocs,
            reloc_count,
            os,
            pnis,
            view,
            view_address);
        }
      else
        {
          typedef Nanomips_relax_insn<size, big_endian> Relax;
          return this->scan_reloc_section_for_transform<Relax>(
            relinfo,
            prelocs,
            reloc_count,
            os,
            pnis,
            view,
            view_address);
        }
    }
  else if (this->state_ == EXPAND)
    {
      if (parameters->options().finalize_relocs())
        {
          typedef Nanomips_expand_insn_finalize<size, big_endian> Expand;
          return this->scan_reloc_section_for_transform<Expand>(
            relinfo,
            prelocs,
            reloc_count,
            os,
            pnis,
            view,
            view_address);
        }
      else
        {
          typedef Nanomips_expand_insn<size, big_endian> Expand;
          return this->scan_reloc_section_for_transform<Expand>(
            relinfo,
            prelocs,
            reloc_count,
            os,
            pnis,
            view,
            view_address);
        }
    }
  else
    gold_unreachable();

  return false;
}

// Make a new Nanomips_input_section object.

template<int size, bool big_endian>
Nanomips_input_section*
Target_nanomips<size, big_endian>::new_nanomips_input_section(
    Nanomips_relobj<size, big_endian>* relobj,
    unsigned int data_shndx,
    unsigned int reloc_shndx,
    Output_section* os)
{
  Section_id sid(relobj, data_shndx);
  const unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  Nanomips_input_section* pnis =
    new Nanomips_input_section(relobj, data_shndx, os, reloc_size);
  pnis->init(reloc_shndx);

  // Register new Nanomips_input_section in map for look-up.
  std::pair<typename Nanomips_input_section_map::iterator, bool> ins =
    this->nanomips_input_section_map_.insert(std::make_pair(sid, pnis));

  // Make sure that it we have not created another Nanomips_input_section
  // for this input section already.
  gold_assert(ins.second);

  relobj->convert_input_section_to_relaxed_section(data_shndx);
  return pnis;
}

// Find the Nanomips_input_section object corresponding to the SHNDX-th input
// section of RELOBJ.

template<int size, bool big_endian>
Nanomips_input_section*
Target_nanomips<size, big_endian>::find_nanomips_input_section(
    Relobj* relobj,
    unsigned int shndx) const
{
  Section_id sid(relobj, shndx);
  typename Nanomips_input_section_map::const_iterator p =
    this->nanomips_input_section_map_.find(sid);
  return (p != this->nanomips_input_section_map_.end() ? p->second : NULL);
}

// Update content for instruction transformation.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::update_content(
    Nanomips_input_section* pnis,
    Nanomips_relobj<size, big_endian>* relobj,
    Address address,
    int count,
    bool no_old_padding)
{
  gold_assert(pnis != NULL);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  if (count > 0)
    // Add the bytes.
    pnis->add_bytes(address, count);
  else
    // Delete the bytes.
    pnis->delete_bytes(address, abs(count));

  size_t reloc_count = pnis->reloc_count();
  unsigned char* prelocs = pnis->relocs();

  // Adjust all the relocs.
  for (size_t i = 0; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      Reltype_write reloc_write(prelocs);

      Address r_offset = reloc.get_r_offset();
      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());

      // Don't move ALIGN, FILL and MAX relocations if we are updating content
      // due to the alignment requirement and there is no existing padding
      // bytes.  These relocs must be at the start of the padding bytes.
      if (no_old_padding
          && (r_offset == address)
          && (r_type == elfcpp::R_NANOMIPS_ALIGN
              || r_type == elfcpp::R_NANOMIPS_FILL
              || r_type == elfcpp::R_NANOMIPS_MAX))
        continue;

      if (r_offset >= address)
        reloc_write.put_r_offset(r_offset + count);
    }

  // Adjust conditional branch relocs.
  typedef typename Nanomips_input_section::Conditional_branches
    Conditional_branches;
  Conditional_branches* cond_branches = pnis->branches();
  for (size_t i = 0; i < cond_branches->size(); ++i)
    {
      if ((*cond_branches)[i].offset >= address)
        (*cond_branches)[i].offset += count;

      if ((*cond_branches)[i].destination >= address)
        (*cond_branches)[i].destination += count;
    }

  // Adjust the local and global symbols defined in this section.
  unsigned int shndx = pnis->shndx();
  relobj->adjust_local_symbols(address, shndx, count);
  relobj->adjust_global_symbols(address, shndx, count);
}

// Find R_NANOMIPS_FILL and R_NANOMIPS_MAX relocations (if any) and get
// fill value, fill size and max bytes generated by the assembler.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::find_fill_max(
    Address offset,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs,
    Nanomips_relobj<size, big_endian>* relobj,
    Valtype* fill,
    Valtype* max,
    Size_type* fill_size)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  const unsigned int local_count = relobj->local_symbol_count();

  // Start finding FILL and MAX from the next relocation.
  prelocs += reloc_size;
  for (size_t i = relnum + 1; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      if (offset != reloc.get_r_offset())
        return;

      typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());

      if (r_type == elfcpp::R_NANOMIPS_FILL)
        {
          unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          *fill = psymval->input_value();
          *fill_size = relobj->do_local_symbol_size(r_sym);
        }
      else if (r_type == elfcpp::R_NANOMIPS_MAX)
        {
          unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          *max = psymval->input_value();
        }
    }
}

// Scan a relocation section for instruction transformation.

template<int size, bool big_endian>
template<typename Nanomips_transform>
bool inline
Target_nanomips<size, big_endian>::scan_reloc_section_for_transform(
    const Relocate_info<size, big_endian>* relinfo,
    const unsigned char* prelocs,
    size_t reloc_count,
    Output_section* os,
    Nanomips_input_section* pnis,
    const unsigned char* view,
    Address view_address)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  gold::Default_comdat_behavior default_comdat_behavior;

  // Whether we should run relaxation pass again.
  bool again = false;
  // Whether we might have disturbed the alignment required at R_NANOMIPS_ALIGN
  // relocation.
  bool do_align = false;
  // True if we have seen R_NANOMIPS_NORELAX relocation.
  bool seen_norelax = false;

  Comdat_behavior comdat_behavior = CB_UNDETERMINED;
  Address gp = static_cast<Address>(0) - 1;
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const unsigned int local_count = relobj->local_symbol_count();
  Nanomips_transform transform(relobj, relinfo->rr);

  if (this->gp_ != NULL)
    {
      // We need to compute the would-be final value of the _gp.
      const Symbol_table* symtab = relinfo->symtab;
      Symbol_table::Compute_final_value_status status;
      Address value = symtab->compute_final_value<size>(this->gp_, &status);
      if (status == Symbol_table::CFVS_OK)
        gp = value;
    }

  for (size_t i = 0; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);

      typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
      unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
      unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
      Address r_offset = reloc.get_r_offset();
      typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
        reloc.get_r_addend();

      if (r_type == elfcpp::R_NANOMIPS_NORELAX)
        {
          // If this is a R_NANOMIPS_NORELAX relocation, set that we can't do
          // anything until we see R_NANOMIPS_RELAX.
          seen_norelax = true;
          continue;
        }
      else if (r_type == elfcpp::R_NANOMIPS_RELAX)
        {
          // If this is a R_NANOMIPS_RELAX relocation, set that we can transform
          // following instructions.
          seen_norelax = false;
          continue;
        }

      // Don't transform instructions until we see R_NANOMIPS_RELAX.
      if (seen_norelax)
        continue;

      // Align first R_NANOMIPS_ALIGN found after instruction transformation.
      if (r_type == elfcpp::R_NANOMIPS_ALIGN)
        {
          if (!do_align)
            continue;

          do_align = false;

          // For R_NANOMIPS_ALIGN relocation, there is a local symbol in which
          // st_value holds the alignment requirement.
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          Valtype input_value = psymval->input_value();

          Address align = 1 << input_value;
          Address address = view_address + r_offset;
          Address new_address = align_address(address, align);

          // Calculate the padding required due to instruction transformation.
          Address new_padding = new_address - address;
          // Get the existing padding bytes.
          Address old_padding = relobj->do_local_symbol_size(r_sym);

          // nanoMIPS nop16 instruction.
          const uint32_t nop16 = 0x9008;
          Valtype fill = nop16;
          Valtype max = static_cast<Valtype>(0) - 1;
          Size_type fill_size = 2;

          // Find fill value, fill size and max bytes generated by
          // the assembler.
          this->find_fill_max(r_offset, i, reloc_count, prelocs,
                              relobj, &fill, &max, &fill_size);

          // Set the padding required due to instruction transformation to 0, if
          // the padding bytes exceed max bytes.
          if (new_padding > max)
            new_padding = 0;

          // If the paddings are the same, don't do anything.
          if (new_padding == old_padding)
            continue;

          // If the padding required now is more/less than the existing padding,
          // then add/delete those extra bytes.
          int count = static_cast<int>(new_padding - old_padding);

          // Check the case where we might end up removing half of a
          // nop[32] instruction.
          if (count < 0 && new_padding >= 2)
            {
              const uint32_t nop32 = 0x8000c000;
              unsigned char* pview =
                pnis->section_contents() + r_offset + new_padding - 2;
              uint32_t insn = transform.read_insn(pview, 32);

              // Check if we need to replace nop[32] with nop[16] instruction.
              if (insn == nop32)
                {
                  elfcpp::Swap<16, big_endian>::writeval(pview, nop16);
                  gold_debug(DEBUG_TARGET,
                             "%s(%s+%#lx): nop[32] is replaced with nop[16]",
                             relobj->name().c_str(),
                             relobj->section_name(relinfo->data_shndx).c_str(),
                             (unsigned long) (r_offset + new_padding - 2));
                }
            }

          this->update_content(pnis, relobj, r_offset + old_padding,
                               count, old_padding == 0);
          relobj->set_local_symbol_size(r_sym, new_padding);

          gold_debug(DEBUG_TARGET,
                     "%s(%s+%#lx): %d bytes are %s due to the alignment "
                     "requirement",
                     relobj->name().c_str(),
                     relobj->section_name(relinfo->data_shndx).c_str(),
                     (unsigned long) (r_offset + old_padding),
                     abs(count),
                     count > 0 ? "added" : "removed");

          // Add required padding bytes.
          if (count > 0)
            {
              if (fill_size > static_cast<Size_type>(count))
                {
                  fill = nop16;
                  fill_size = 2;
                }

              unsigned char* pview =
                pnis->section_contents() + r_offset + old_padding;
              for (int j = 0;
                   j < count;
                   pview += fill_size,
                   j += fill_size)
                {
                  switch (fill_size)
                    {
                    case 1:
                      elfcpp::Swap<8, big_endian>::writeval(pview,
                                                            fill & 0xff);
                      break;
                    case 2:
                      elfcpp::Swap<16, big_endian>::writeval(pview,
                                                             fill & 0xffff);
                      break;
                    case 4:
                      {
                        uint32_t hi = (fill >> 16) & 0xffff;
                        uint32_t lo = fill & 0xffff;
                        elfcpp::Swap<16, big_endian>::writeval(pview, hi);
                        elfcpp::Swap<16, big_endian>::writeval(pview + 2, lo);
                      }
                      break;
                    default:
                      gold_unreachable();
                    }
                }
            }
          continue;
        }

      const Nanomips_reloc_property* reloc_property =
        nanomips_reloc_property_table->get_reloc_property(r_type);
      gold_assert(reloc_property != NULL);

      // Instruction size in bits.
      unsigned int insn_size = reloc_property->size();

      // Don't do anything for some of the placeholder relocations (almost all
      // of them have size 0).
      if (insn_size == 0)
        continue;

      // Adjust r_offset for 48-bit instructions.
      if (insn_size == 48)
        r_offset -= 2;

      uint32_t insn = transform.read_insn(view + r_offset, insn_size);
      const Nanomips_insn_property* insn_property =
        transform.find_insn(insn, reloc_property->mask(), r_type);

      // If this isn't something that can be transformed, then ignore this
      // relocation.
      if (insn_property == NULL
          || !transform.fixed_insn(r_offset, i, reloc_count, prelocs))
        continue;

      const Symbol* gsym;
      Symbol_value<size> symval;
      const Symbol_value<size>* psymval;
      bool is_defined_in_discarded_section;
      unsigned int shndx;
      if (r_sym < local_count)
        {
          psymval = relobj->local_symbol(r_sym);
          gsym = NULL;
          // If the local symbol belongs to a section we are discarding,
          // and that section is a debug section, try to find the
          // corresponding kept section and map this symbol to its
          // counterpart in the kept section.  The symbol must not
          // correspond to a section we are folding.
          bool is_ordinary;
          shndx = psymval->input_shndx(&is_ordinary);
          is_defined_in_discarded_section =
            (is_ordinary
             && shndx != elfcpp::SHN_UNDEF
             && !relobj->is_section_included(shndx)
             && !relinfo->symtab->is_section_folded(relobj, shndx));

          // We need to compute the would-be final value of this local
          // symbol.
          if (!is_defined_in_discarded_section)
            {
              typedef Sized_relobj_file<size, big_endian> ObjType;
              if (psymval->is_section_symbol())
                {
                  symval.set_input_shndx(shndx, is_ordinary);
                  symval.set_is_section_symbol();
                }

              typename ObjType::Compute_final_local_value_status status =
                relobj->compute_final_local_value(r_sym, psymval, &symval,
                                                  relinfo->symtab);
              if (status != ObjType::CFLV_OK)
                continue;
              psymval = &symval;
            }
        }
      else
        {
          gsym = relobj->global_symbol(r_sym);
          gold_assert(gsym != NULL);
          if (gsym->is_forwarder())
            gsym = relinfo->symtab->resolve_forwards(gsym);

          // Ignore reference to weak undefined symbols.
          if (gsym->is_weak_undefined())
            continue;

          // We need to compute the would-be final value of this global
          // symbol.
          const Symbol_table* symtab = relinfo->symtab;
          const Sized_symbol<size>* sized_symbol =
            symtab->get_sized_symbol<size>(gsym);
          Symbol_table::Compute_final_value_status status;
          Address value =
            symtab->compute_final_value<size>(sized_symbol, &status);
          if (status != Symbol_table::CFVS_OK)
            continue;

          symval.set_output_value(value);
          psymval = &symval;

          is_defined_in_discarded_section =
            (gsym->is_defined_in_discarded_section()
             && gsym->is_undefined());
          shndx = 0;
        }

      Symbol_value<size> symval2;
      if (is_defined_in_discarded_section)
        {
          if (comdat_behavior == CB_UNDETERMINED)
            {
              std::string name = relobj->section_name(relinfo->data_shndx);
              comdat_behavior = default_comdat_behavior.get(name.c_str());
            }
          if (comdat_behavior == CB_PRETEND)
            {
              // FIXME: This case does not work for global symbols.
              // We have no place to store the original section index.
              // Fortunately this does not matter for comdat sections,
              // only for sections explicitly discarded by a linker
              // script.
              bool found;
              typename elfcpp::Elf_types<size>::Elf_Addr value =
                relobj->map_to_kept_section(shndx, &found);
              if (found)
                symval2.set_output_value(value + psymval->input_value());
              else
                symval2.set_output_value(0);
            }
          else
            {
              if (comdat_behavior == CB_WARNING)
                gold_warning_at_location(relinfo, i, r_offset,
                                         _("relocation refers to discarded "
                                           "section"));
              symval2.set_output_value(0);
            }
          psymval = &symval2;
        }

      // Get the type of the transformation.
      unsigned int type =
        transform.get_type(gsym, psymval, insn_property, reloc, i, insn,
                           view_address + r_offset, gp);

      if (type == TT_NONE)
        continue;

      const Nanomips_transform_template* transform_template =
        insn_property->get_transform(type);

      // Create a new relaxed input section if needed.
      if (pnis == NULL)
        pnis = this->new_nanomips_input_section(relobj, relinfo->data_shndx,
                                                relinfo->reloc_shndx, os);

      // Number of bytes to add/delete for this transformation.
      int count = static_cast<int>(transform_template->size() - insn_size / 8);

      if (count != 0)
        {
          // That will change things so we should run relaxation pass again.
          again = true;

          // We might have disturbed the alignment required at
          // R_NANOMIPS_ALIGN relocation.
          do_align = true;

          // Update content for the instruction transformation.
          this->update_content(pnis, relobj, r_offset + insn_size / 8,
                               count, false);
        }

      // Transform instruction.
      transform.transform(transform_template, insn_property, pnis,
                          type, i, insn);

      if (is_debugging_enabled(DEBUG_TARGET))
        transform.print(transform_template, insn_property->name(),
                        gsym, r_sym, r_offset, r_addend,
                        relinfo->data_shndx);

      // Update pointers in case they are changed.
      prelocs = pnis->relocs() + i * reloc_size;
      view = pnis->section_contents();
    }

  if (again)
    {
      gold_assert(pnis != NULL);
      // Update size of the section.
      pnis->reset_data_size();
      pnis->finalize_data_size();
      // Set that section offsets need to be adjusted.
      os->set_section_offsets_need_adjustment();
    }

  return again;
}

template<int size, bool big_endian>
inline void
Target_nanomips<size, big_endian>::Scan::local(
    Symbol_table* symtab ,
    Layout* layout,
    Target_nanomips<size, big_endian>* target,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    Output_section*, /* output_section,*/
    const elfcpp::Rela<size, big_endian>& reloc,
    unsigned int r_type,
    const elfcpp::Sym<size, big_endian>& lsym,
    bool is_discarded)
{
  Address r_offset = reloc.get_r_offset();

  // Check if section reference should be removed.
  if (this->ref_relobj_ != NULL
      && ((r_type == elfcpp::R_NANOMIPS_INSN32
           || r_type == elfcpp::R_NANOMIPS_FIXED)
          && this->ref_r_offset_ == r_offset))
    {
      gold_assert(this->ref_shndx_ != invalid_index);
      this->ref_relobj_->remove_input_section_ref(this->ref_shndx_);
    }

  this->ref_r_offset_ = invalid_address;
  this->ref_relobj_ = NULL;
  this->ref_shndx_ = invalid_index;

  if (is_discarded)
    return;

  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(object);
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  const Nanomips_reloc_property* nrp =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(nrp != NULL);

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      if (relobj->safe_to_relax() && !this->seen_norelax_)
        {
          unsigned int shndx = lsym.get_st_shndx();
          Output_section* sym_os = relobj->output_section(shndx);
          if (sym_os == NULL)
            break;

          bool sort_by_reference =
            parameters->options().is_sort_by_reference(sym_os->name());
          bool reference_counts =
            parameters->options().is_reference_counts(sym_os->name());
          if ((!sort_by_reference || !target->may_relax_instructions())
              && !reference_counts)
            break;

          section_size_type view_size = 0;
          const unsigned char* view = relobj->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          Nanomips_relax_insn<size, big_endian> relax_insn(relobj);
          uint32_t insn = relax_insn.read_insn(view + r_offset, nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find_insn(insn, nrp->mask(), r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              bool is_ordinary;
              shndx = relobj->adjust_sym_shndx(r_sym, shndx, &is_ordinary);

              if (is_ordinary)
                {
                  relobj->add_input_section_ref(shndx);
                  // We need to check if this relocation is marked with INSN32
                  // or FIXED relocation.  In that case, we need to decrease
                  // reference to the section.
                  this->ref_r_offset_ = r_offset;
                  this->ref_relobj_ = relobj;
                  this->ref_shndx_ = shndx;
                }
            }
        }
      break;
    case elfcpp::R_NANOMIPS_NORELAX:
      this->seen_norelax_ = true;
      break;
    case elfcpp::R_NANOMIPS_RELAX:
      this->seen_norelax_ = false;
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      // TODO: If building a shared library, create GOT entry if refcount>=2.

      // Don't add a GOT entry for a symbol if this relocation will be
      // transformed in a relaxation loop.
      if (target->may_relax() && relobj->safe_to_relax()
          && !this->seen_norelax_)
        break;
      // Fall through.

    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      {
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
        typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
           reloc.get_r_addend();
        if (got->add_local(relobj, r_sym, GOT_TYPE_STANDARD, r_addend))
          {
            // If we are generating a shared object, we need to add a
            // dynamic RELATIVE relocation for this symbol's GOT entry.
            if (parameters->options().output_is_position_independent())
              {
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                unsigned int got_offset =
                  object->local_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend);
                rel_dyn->add_local_relative(object, r_sym,
                                            elfcpp::R_NANOMIPS_RELATIVE,
                                            got, got_offset);
              }
          }
      }
      break;
    case elfcpp::R_NANOMIPS_INSN32:
    case elfcpp::R_NANOMIPS_FIXED:
      break;
    default:
      break;
    }
}

// Scan a relocation for a global symbol.

template<int size, bool big_endian>
inline void
Target_nanomips<size, big_endian>::Scan::global(
    Symbol_table* symtab,
    Layout* layout,
    Target_nanomips<size, big_endian>* target,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    Output_section*, /* output_section,*/
    const elfcpp::Rela<size, big_endian>& reloc,
    unsigned int r_type,
    Symbol* gsym)
{
  const Nanomips_reloc_property* nrp =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(nrp != NULL);

  Address r_offset = reloc.get_r_offset();
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(object);
  Nanomips_symbol<size>* nanomips_sym =
    Nanomips_symbol<size>::as_nanomips_sym(gsym);

  this->ref_r_offset_ = invalid_address;
  this->ref_relobj_ = NULL;
  this->ref_shndx_ = invalid_index;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      if (relobj->safe_to_relax()
          && gsym->source() == Symbol::FROM_OBJECT
          && !this->seen_norelax_)
        {
          Output_section* sym_os = gsym->output_section();
          if (sym_os == NULL)
            break;

          bool sort_by_reference =
            parameters->options().is_sort_by_reference(sym_os->name());
          bool reference_counts =
            parameters->options().is_reference_counts(sym_os->name());
          if ((!sort_by_reference || !target->may_relax_instructions())
              && !reference_counts)
            break;

          section_size_type view_size = 0;
          const unsigned char* view = object->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          Nanomips_relax_insn<size, big_endian> relax_insn(relobj);
          uint32_t insn = relax_insn.read_insn(view + r_offset, nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find_insn(insn, nrp->mask(), r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              bool is_ordinary;
              unsigned int sym_shndx = gsym->shndx(&is_ordinary);
              Nanomips_relobj<size, big_endian>* sym_obj =
                static_cast<Nanomips_relobj<size, big_endian>*>(gsym->object());

              if (is_ordinary)
                {
                  sym_obj->add_input_section_ref(sym_shndx);
                  // We need to check if this relocation is marked with INSN32
                  // or FIXED relocation.  In that case, we need to decrease
                  // reference to the section.
                  this->ref_r_offset_ = r_offset;
                  this->ref_relobj_ = sym_obj;
                  this->ref_shndx_ = sym_shndx;
                }
            }
        }
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      // TODO: If building a shared library, create GOT entry if refcount>=2.

      // Don't add a GOT entry for a symbol if it is fully resolved,
      // and this relocation will be transformed in a relaxation loop.
      if ((target->may_relax() && relobj->safe_to_relax()
           && !this->seen_norelax_)
          && (gsym->final_value_is_known()
              || (gsym->is_defined()
                  && !gsym->is_from_dynobj()
                  && !gsym->is_preemptible())))
        break;
      // Fall through.

    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      {
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);

        if (gsym->final_value_is_known())
          got->add_global(gsym, GOT_TYPE_STANDARD);
        else
          {
            // If this symbol is not fully resolved, we need to add a
            // GOT entry with a dynamic relocation.
            if (gsym->is_from_dynobj()
                || gsym->is_undefined()
                || gsym->is_preemptible())
              {
                if (r_type != elfcpp::R_NANOMIPS_GOT_CALL
                    || nanomips_sym->no_lazy_stub())
                  {
                    Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                    got->add_global_with_rel(gsym, GOT_TYPE_STANDARD, rel_dyn,
                                             elfcpp::R_NANOMIPS_GLOBAL);
                  }
                else
                  got->record_got_call_symbol(nanomips_sym);
              }
            else
              {
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                bool is_new = got->add_global(gsym, GOT_TYPE_STANDARD);
                if (is_new)
                  rel_dyn->add_global_relative(
                      gsym, elfcpp::R_NANOMIPS_RELATIVE, got,
                      gsym->got_offset(GOT_TYPE_STANDARD));
              }
          }
      }
      break;
    case elfcpp::R_NANOMIPS_ALIGN:
    case elfcpp::R_NANOMIPS_FILL:
    case elfcpp::R_NANOMIPS_MAX:
    case elfcpp::R_NANOMIPS_INSN32:
    case elfcpp::R_NANOMIPS_INSN16:
    case elfcpp::R_NANOMIPS_FIXED:
    case elfcpp::R_NANOMIPS_NORELAX:
    case elfcpp::R_NANOMIPS_RELAX:
      gold_error(_("%s not against local symbol"), nrp->name().c_str());
      break;
    default:
      break;
    }

  // We must not create a nanoMIPS lazy-binding stub for a symbol that
  // has relocations related to taking the function's address.
  if (r_type != elfcpp::R_NANOMIPS_GOT_CALL
      && r_type != elfcpp::R_NANOMIPS_GOT_LO12
      && r_type != elfcpp::R_NANOMIPS_JALR32
      && r_type != elfcpp::R_NANOMIPS_JALR16)
    nanomips_sym->set_no_lazy_stub();
}

// Perform a relocation.

template<int size, bool big_endian>
inline bool
Target_nanomips<size, big_endian>::Relocate::relocate(
    const Relocate_info<size, big_endian>* relinfo,
    unsigned int,
    Target_nanomips* target,
    Output_section* output_section,
    size_t relnum,
    const unsigned char* preloc,
    const Sized_symbol<size>* gsym,
    const Symbol_value<size>* psymval,
    unsigned char* view,
    Address address,
    section_size_type)
{
  const elfcpp::Rela<size, big_endian> reloc(preloc);
  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend = reloc.get_r_addend();

  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  // We are checking these relocations here because we don't want to
  // break support for resolving multiple consecutive relocations.
  // These relocations are handled during relaxation pass.
  if (reloc_property->placeholder())
    return false;

  // r_offset and r_type of the next relocation is needed for resolving multiple
  // consecutive relocations with the same offset.
  Address next_r_offset = static_cast<Address>(0) - 1;
  unsigned int next_r_type = elfcpp::R_NANOMIPS_NONE;

  Nanomips_relobj<size, big_endian>* object =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  const Output_relaxed_input_section* poris =
    output_section->find_relaxed_input_section(object, relinfo->data_shndx);

  // TODO: Put reloc_count into Relocate_info.
  // Get the relocation count.
  size_t reloc_count;
  if (poris != NULL)
    {
      // Get the relocation count for the relaxed section.
      const Nanomips_input_section* pnis =
        Nanomips_input_section::as_nanomips_input_section(poris);
      reloc_count = pnis->reloc_count();
    }
  else
    {
      // Calculate relocation count for section from the object file.
      elfcpp::Shdr<size, big_endian> shdr(relinfo->reloc_shdr);
      reloc_count = shdr.get_sh_size() / reloc_size;
    }

  // Get the type and offset of the next relocation.
  if (relnum + 1 < reloc_count)
    {
      const elfcpp::Rela<size, big_endian> next_reloc(preloc + reloc_size);
      typename elfcpp::Elf_types<size>::Elf_WXword next_r_info =
        next_reloc.get_r_info();
      next_r_type = elfcpp::elf_r_type<size>(next_r_info);
      next_r_offset = next_reloc.get_r_offset();
    }

  // If we didn't apply previous relocation, use its result as addend
  // for the current.
  if (this->calculate_only_)
    r_addend = this->calculated_value_;

  const Nanomips_reloc_property* next_reloc_property =
    nanomips_reloc_property_table->get_reloc_property(next_r_type);
  gold_assert(next_reloc_property != NULL);

  // Set whether we have to calculate relocation instead of applying it.
  this->calculate_only_ = ((r_offset == next_r_offset)
                           && (next_r_type != elfcpp::R_NANOMIPS_NONE
                               && !next_reloc_property->placeholder()));

  Valtype value = 0;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
    case elfcpp::R_NANOMIPS_GOT_LO12:
      if (gsym != NULL)
        {
          gold_assert(gsym->has_got_offset(GOT_TYPE_STANDARD));
          value = gsym->got_offset(GOT_TYPE_STANDARD);
        }
      else
        {
          gold_assert(object->local_has_got_offset(r_sym, GOT_TYPE_STANDARD,
                                                   r_addend));
          value = object->local_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend);
        }
      break;
    default:
      break;
    }

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_NONE:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_OFST:
      break;
    case elfcpp::R_NANOMIPS_GOTPC_I32:
      value += target->got_section()->address() - (address + 4);
      break;
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      value += target->got_section()->address() - ((address + 4) & ~0xfff);
      break;
    case elfcpp::R_NANOMIPS_GOT_LO12:
      value += target->got_section()->address();
      break;
    case elfcpp::R_NANOMIPS_32:
    case elfcpp::R_NANOMIPS_UNSIGNED_8:
    case elfcpp::R_NANOMIPS_UNSIGNED_16:
    case elfcpp::R_NANOMIPS_SIGNED_8:
    case elfcpp::R_NANOMIPS_SIGNED_16:
    case elfcpp::R_NANOMIPS_I32:
    case elfcpp::R_NANOMIPS_HI20:
    case elfcpp::R_NANOMIPS_LO12:
    case elfcpp::R_NANOMIPS_LO4_S2:
      value = psymval->value(object, r_addend);
      break;
    case elfcpp::R_NANOMIPS_ASHIFTR_1:
      typedef typename elfcpp::Elf_types<size>::Elf_Swxword Signed_valtype;
      value = psymval->value(object, r_addend);
      value = static_cast<Signed_valtype>(value) >> 1;
      break;
    case elfcpp::R_NANOMIPS_NEG:
      value = r_addend - psymval->value(object, 0);
      break;
    // Calculate pc-relative relocations.
    case elfcpp::R_NANOMIPS_PC_HI20:
      value = psymval->value(object, r_addend) - ((address + 4) & ~0xfff);
      break;
    case elfcpp::R_NANOMIPS_PC_I32:
    case elfcpp::R_NANOMIPS_PC25_S1:
    case elfcpp::R_NANOMIPS_PC21_S1:
    case elfcpp::R_NANOMIPS_PC14_S1:
    case elfcpp::R_NANOMIPS_PC11_S1:
    case elfcpp::R_NANOMIPS_PC10_S1:
    case elfcpp::R_NANOMIPS_PC7_S1:
    case elfcpp::R_NANOMIPS_PC4_S1:
      {
        // Instruction size in bytes.  The PC adjustment for 48bit instructions
        // is 4 because the reloc applies to an offset of 2 from the opcode.
        unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
        value = psymval->value(object, r_addend) - (address + insn_size);
        break;
      }
    // Calculate gp-relative relocations.
    case elfcpp::R_NANOMIPS_GPREL_I32:
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_GPREL18_S3:
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
    case elfcpp::R_NANOMIPS_GPREL16_S2:
    case elfcpp::R_NANOMIPS_GPREL7_S2:
    case elfcpp::R_NANOMIPS_GPREL_HI20:
    case elfcpp::R_NANOMIPS_GPREL_LO12:
      value = psymval->value(object, r_addend) - target->gp_value();
      break;
    default:
      break;
    }

  // If we are calculating relocation, save the result for the next relocation.
  if (this->calculate_only_)
    {
      this->calculated_value_ = value;
      return true;
    }

  typedef Nanomips_relocate_functions<size, big_endian> Reloc_funcs;
  typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;

  // Don't check overflow for weak undefined symbols.
  bool check_overflow = gsym == NULL || !gsym->is_weak_undefined();

  unsigned int align = reloc_property->align();

  // Apply relocation and check for errors.
  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_unshuffle(view, reloc_property->size());
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_NONE:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
    case elfcpp::R_NANOMIPS_GOT_OFST:
      break;
    case elfcpp::R_NANOMIPS_32:
    case elfcpp::R_NANOMIPS_I32:
    case elfcpp::R_NANOMIPS_PC_I32:
    case elfcpp::R_NANOMIPS_GPREL_I32:
    case elfcpp::R_NANOMIPS_GOTPC_I32:
      reloc_status = Reloc_funcs::rel32(view, value);
      break;
    case elfcpp::R_NANOMIPS_UNSIGNED_8:
      reloc_status = Reloc_funcs::relu8(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_UNSIGNED_16:
      reloc_status = Reloc_funcs::relu16(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_SIGNED_8:
      reloc_status = Reloc_funcs::rels8(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_SIGNED_16:
      reloc_status = Reloc_funcs::rels16(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_HI20:
    case elfcpp::R_NANOMIPS_PC_HI20:
    case elfcpp::R_NANOMIPS_GPREL_HI20:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      reloc_status = Reloc_funcs::relhi20(view, value);
      break;
    case elfcpp::R_NANOMIPS_LO12:
    case elfcpp::R_NANOMIPS_GPREL_LO12:
    case elfcpp::R_NANOMIPS_GOT_LO12:
      reloc_status = Reloc_funcs::rello12(view, value);
      break;
    case elfcpp::R_NANOMIPS_LO4_S2:
      reloc_status = Reloc_funcs::rello4_s2(view, value, align, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_NEG:
    case elfcpp::R_NANOMIPS_ASHIFTR_1:
      reloc_status = Reloc_funcs::relsize(view, value);
      break;
    case elfcpp::R_NANOMIPS_PC25_S1:
      reloc_status = Reloc_funcs::relpc25_s1(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC21_S1:
      reloc_status = Reloc_funcs::relpc21_s1(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC10_S1:
      reloc_status = Reloc_funcs::relpc10_s1(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC7_S1:
      reloc_status = Reloc_funcs::relpc7_s1(view, value, align, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC4_S1:
      reloc_status = Reloc_funcs::relpc4_s1(view, value, align, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      reloc_status = Reloc_funcs::relgprel19_s2(view, value, align,
                                                check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL18_S3:
      reloc_status = Reloc_funcs::relgprel18_s3(view, value, align,
                                                check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL18:
      reloc_status = Reloc_funcs::relgprel18(view, value, align,
                                             check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      reloc_status = Reloc_funcs::relgprel17_s1(view, value, align,
                                                check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL16_S2:
      reloc_status = Reloc_funcs::relgprel16_s2(view, value, align,
                                                check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      reloc_status = Reloc_funcs::relgprel7_s2(view, value, align,
                                               check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
      reloc_status = Reloc_funcs::relgot(view, value, align);
      break;
    default:
      gold_error_at_location(relinfo, relnum, r_offset,
                             _("unsupported reloc %s"),
                             reloc_property->name().c_str());
      break;
    }
  if (reloc_property->shuffle_reloc())
    Reloc_funcs::nanomips_reloc_shuffle(view, reloc_property->size());

  // Report any errors.
  switch (reloc_status)
    {
    case Reloc_funcs::STATUS_OKAY:
      break;
    case Reloc_funcs::STATUS_OVERFLOW:
      if (gsym == NULL)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("relocation overflow: "
                                 "%s against local symbol '%s' with index %u: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               object->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value,
                               reloc_property->bitsize());
      else if (gsym->is_defined() && gsym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("relocation overflow: "
                                 "%s against '%s' defined in %s: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               gsym->object()->name().c_str(),
                               (unsigned long long) value,
                               reloc_property->bitsize());
      else
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("relocation overflow: "
                                 "%s against '%s': "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               (unsigned long long) value,
                               reloc_property->bitsize());
      break;
    case Reloc_funcs::STATUS_UNALIGNED:
      if (gsym == NULL)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("unaligned relocation value: "
                                 "%s against local symbol '%s' with index %u: "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               object->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value, align);
      else if (gsym->is_defined() && gsym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("unaligned relocation value: "
                                 "%s against '%s' defined in %s: "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               gsym->object()->name().c_str(),
                               (unsigned long long) value, align);
      else
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("unaligned relocation value: "
                                 "%s against '%s': "
                                 "value %#llx is not aligned to %d"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               (unsigned long long) value, align);
      break;
    default:
      gold_unreachable();
    }

  return true;
}

// Report an unsupported relocation against a local symbol.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::Scan::unsupported_reloc_local(
    Sized_relobj_file<size, big_endian>* object,
    unsigned int r_type)
{
  gold_error(_("%s: unsupported reloc %u against local symbol"),
             object->name().c_str(), r_type);
}

// Report an unsupported relocation against a global symbol.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::Scan::unsupported_reloc_global(
    Sized_relobj_file<size, big_endian>* object,
    unsigned int r_type,
    Symbol* gsym)
{
  gold_error(_("%s: unsupported reloc %u against global symbol %s"),
             object->name().c_str(), r_type, gsym->demangled_name().c_str());
}

template<int size, bool big_endian>
const Target::Target_info Target_nanomips<size, big_endian>::nanomips_info =
{
  size,                 // size
  big_endian,           // is_big_endian
  elfcpp::EM_NANOMIPS,  // machine_code
  true,                 // has_make_symbol
  false,                // has_resolve
  false,                // has_code_fill
  true,                 // is_default_stack_executable
  false,                // can_icf_inline_merge_sections
  '\0',                 // wrap_char
  size == 32 ? "/lib/ld.so.1" : "/lib64/ld.so.1",      // dynamic_linker
  0x400000,             // default_text_segment_address
  64 * 1024,            // abi_pagesize (overridable by -z max-page-size)
  4 * 1024,             // common_pagesize (overridable by -z common-page-size)
  false,                // isolate_execinstr
  0,                    // rosegment_gap
  elfcpp::SHN_UNDEF,    // small_common_shndx
  elfcpp::SHN_UNDEF,    // large_common_shndx
  0,                    // small_common_section_flags
  0,                    // large_common_section_flags
  NULL,                 // attributes_section
  NULL,                 // attributes_vendor
  "__start",            // entry_symbol_name
  32,                   // hash_entry_size
};

// Target selector for Nanomips.

template<int size, bool big_endian>
class Target_selector_nanomips : public Target_selector
{
public:
  Target_selector_nanomips()
    : Target_selector(elfcpp::EM_NANOMIPS, size, big_endian,
                (size == 64 ?
                  (big_endian ? "elf64-bignanomips" : "elf64-littlenanomips") :
                  (big_endian ? "elf32-bignanomips" : "elf32-littlenanomips")),
                (size == 64 ?
                  (big_endian ? "elf64btsmip" : "elf64ltsmip") :
                  (big_endian ? "elf32btsmip" : "elf32ltsmip")))
  { }

  Target* do_instantiate_target()
  { return new Target_nanomips<size, big_endian>(); }
};


Target_selector_nanomips<32, true> target_selector_nanomips32;
Target_selector_nanomips<32, false> target_selector_nanomips32el;
Target_selector_nanomips<64, true> target_selector_nanomips64;
Target_selector_nanomips<64, false> target_selector_nanomips64el;

} // End anonymous namespace.
