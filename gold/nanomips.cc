// nanomips.cc -- nanomips target support for gold.

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
#include "copy-relocs.h"
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

template<int size, bool big_endian>
class Nanomips_transformations;

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
// These values are exposed to the ABI in an incremental link.
// Do not renumber existing values without changing the version
// number of the .gnu_incremental_inputs section.
enum Got_type
{
  GOT_TYPE_STANDARD = 0,      // GOT entry for a regular symbol
  GOT_TYPE_TLS_OFFSET = 1,    // GOT entry for TLS offset
  GOT_TYPE_TLS_PAIR = 2       // GOT entry for TLS module/offset pair
};

Nanomips_reloc_property_table* nanomips_reloc_property_table = NULL;
Nanomips_insn_property_table* nanomips_insn_property_table = NULL;

// Helper struct for reading and writing nanoMIPS instructions.
// The 32-bit instruction is stored as 2 16-bit values, rather
// than a single 32-bit value.  In a big-endian file, the result
// is the same; in a little-endian file, the two 16-bit halves of
// the 32-bit value are swapped.
// For 48-bit instructions, the 32-bit immediate value is also swapped.

template<int size, bool big_endian>
struct Nanomips_insn_swap;

template<bool big_endian>
struct Nanomips_insn_swap<16, big_endian>
{
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype;

  static inline Valtype
  readval(const unsigned char* wv)
  { return elfcpp::Swap<16, big_endian>::readval(wv); }

  static inline void
  writeval(unsigned char* wv, Valtype v)
  { elfcpp::Swap<16, big_endian>::writeval(wv, v); }
};

template<bool big_endian>
struct Nanomips_insn_swap<32, big_endian>
{
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype;

  static inline Valtype
  readval(const unsigned char* wv)
  {
    typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
    Valtype16 first = elfcpp::Swap<16, big_endian>::readval(wv);
    Valtype16 second = elfcpp::Swap<16, big_endian>::readval(wv + 2);
    return (first << 16 | second);
  }

  static inline void
  writeval(unsigned char* wv, Valtype v)
  {
    elfcpp::Swap<16, big_endian>::writeval(wv, v >> 16);
    elfcpp::Swap<16, big_endian>::writeval(wv + 2, v);
  }
};

template<bool big_endian>
struct Nanomips_insn_swap<48, big_endian>
{
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype;

  // Write 32-bit immediate of a 48-bit instruction.
  static inline void
  writeval(unsigned char* wv, Valtype v)
  {
    elfcpp::Swap<16, big_endian>::writeval(wv, v);
    elfcpp::Swap<16, big_endian>::writeval(wv + 2, v >> 16);
  }
};

// Read nanoMIPS instruction.

template<bool big_endian>
static inline uint32_t
read_nanomips_insn(const unsigned char* view, unsigned int size)
{
  if (size == 16 || size == 48)
    return Nanomips_insn_swap<16, big_endian>::readval(view);
  else if (size == 32)
    return Nanomips_insn_swap<32, big_endian>::readval(view);
  gold_unreachable();
}

// Return true if the length of an instruction is forced to
// an explicit size.  These instructions are marked with
// R_NANOMIPS_FIXED or R_NANOMIPS_INSN[32/16] relocations.

template<int size, bool big_endian>
static inline bool
is_forced_insn_length(typename elfcpp::Elf_types<size>::Elf_Addr offset,
                      size_t reloc_count,
                      size_t relnum,
                      const unsigned char* preloc)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Start finding FIXED and INSN[32/16] from the next relocation.
  preloc += reloc_size;
  for (size_t i = relnum + 1; i < reloc_count; ++i, preloc += reloc_size)
    {
      Reltype reloc(preloc);
      if (offset != reloc.get_r_offset())
        break;

      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      if (r_type == elfcpp::R_NANOMIPS_FIXED
          || r_type == elfcpp::R_NANOMIPS_INSN32
          || r_type == elfcpp::R_NANOMIPS_INSN16)
        return true;
    }
  return false;
}

// Return the GOT offset of the local symbol.  If the symbol does not have
// a GOT offset, return -1U.

template<int size, bool big_endian>
static inline unsigned int
local_got_offset(Target_nanomips<size, big_endian>* target,
                 const Relobj* object, unsigned int r_sym,
                 unsigned int r_type, uint64_t r_addend)
{
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
    case elfcpp::R_NANOMIPS_GOT_LO12:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      if (object->local_has_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend))
        return object->local_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend);
      break;
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
      if (object->local_has_got_offset(r_sym, GOT_TYPE_TLS_PAIR, r_addend))
        return object->local_got_offset(r_sym, GOT_TYPE_TLS_PAIR, r_addend);
      break;
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
      if (object->local_has_got_offset(r_sym, GOT_TYPE_TLS_OFFSET, r_addend))
        return object->local_got_offset(r_sym, GOT_TYPE_TLS_OFFSET, r_addend);
      break;
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
      return target->got_mod_index_entry(NULL, NULL, NULL);
    default:
      break;
    }
  return -1U;
}

// Return the GOT offset of the global symbol.  If the symbol does not have
// a GOT offset, return -1U.

template<int size, bool big_endian>
static inline unsigned int
global_got_offset(Target_nanomips<size, big_endian>* target,
                  const Symbol* sym, unsigned int r_type)
{
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
    case elfcpp::R_NANOMIPS_GOT_LO12:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      if (sym->has_got_offset(GOT_TYPE_STANDARD))
        return sym->got_offset(GOT_TYPE_STANDARD);
      break;
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
      if (sym->has_got_offset(GOT_TYPE_TLS_PAIR))
        return sym->got_offset(GOT_TYPE_TLS_PAIR);
      break;
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
      if (sym->has_got_offset(GOT_TYPE_TLS_OFFSET))
        return sym->got_offset(GOT_TYPE_TLS_OFFSET);
      break;
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
      return target->got_mod_index_entry(NULL, NULL, NULL);
    default:
      break;
    }
  return -1U;
}

// Return whether a symbol is locally resolved.

static inline bool
is_symbol_locally_resolved(const Symbol* sym)
{
  return (sym->final_value_is_known()
          || (sym->is_defined()
              && !sym->is_from_dynobj()
              && !sym->is_preemptible()));
}

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

// This class is used to hold information about one relocation
// which is used for GP-setup optimization.

template<int size>
class Nanomips_reloc
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_reloc(Nanomips_symbol<size>* sym, unsigned int r_type,
                 Address r_offset)
    : r_type_(r_type), symndx_(-1U), r_offset_(r_offset)
  { this->u_.symbol = sym; }

  Nanomips_reloc(unsigned int symndx, unsigned int r_type, Address addend,
                 Address r_offset)
    : r_type_(r_type), symndx_(symndx), r_offset_(r_offset)
  { this->u_.addend = addend; }

  // Relocation type.
  unsigned int
  r_type() const
  { return this->r_type_; }

  // Relocation offset.
  Address
  r_offset() const
  { return this->r_offset_; }

  // Whether this entry is for a local symbol.
  bool
  is_for_local_symbol() const
  { return this->symndx_ != -1U; }

  // For a relocation against a local symbol, the local symbol index.
  unsigned int
  symndx() const
  {
    gold_assert(this->is_for_local_symbol());
    return this->symndx_;
  }

  // For a relocation against a local symbol, the addend.
  Address
  addend() const
  {
    gold_assert(this->is_for_local_symbol());
    return this->u_.addend;
  }

  // For a relocation against a global symbol, the global symbol.
  Nanomips_symbol<size>*
  symbol() const
  {
    gold_assert(!this->is_for_local_symbol());
    return this->u_.symbol;
  }

  bool
  operator<(const Nanomips_reloc<size>& that) const
  { return this->r_offset_ < that.r_offset_; }

 private:
  // Type of relocation.
  unsigned int r_type_;
  // The index of the local symbol; -1 otherwise.
  unsigned int symndx_;
  // Relocation offset.
  Address r_offset_;
  // A global or local symbol.
  union
  {
    // For a global symbol, the symbol itself.
    Nanomips_symbol<size>* symbol;
    // For a local symbol, the addend.
    Address addend;
  } u_;
};

// Nanomips_output_data_got class.

template<int size, bool big_endian>
class Nanomips_output_data_got : public Output_data_got<size, big_endian>
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef Output_data_reloc<elfcpp::SHT_REL, true, size, big_endian>
      Reloc_section;
  typedef Unordered_set<Nanomips_symbol<size>*, Nanomips_symbol_hash<size> >
      Nanomips_got_call_set;

 public:
  Nanomips_output_data_got(Target_nanomips<size, big_endian>* target)
    : Output_data_got<size, big_endian>(), target_(target), got_call_()
  { }

  // Reserve GOT entry for a R_NANOMIPS_GOT_CALL relocation
  // against NANOMIPS_SYM for which we may need to create
  // a lazy-binding stub.
  void
  record_got_call_symbol(Nanomips_symbol<size>* nanomips_sym)
  {
    if (!nanomips_sym->has_got_offset(GOT_TYPE_STANDARD))
      this->got_call_.insert(nanomips_sym);
  }

  // For the entry at offset GOT_OFFSET, return its offset from the gp.
  Address
  gp_offset(unsigned int got_offset, Address gp) const
  { return (this->address() + got_offset - gp); }

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
    : no_lazy_stub_(false), is_gp_used_(false), lazy_stub_offset_(-1ULL)
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

  // Return whether this symbol has a lazy-binding stub.
  bool
  has_lazy_stub() const
  { return this->lazy_stub_offset_ != -1ULL; }

  // Set that GP register is used.
  void
  set_gp_is_used()
  { this->is_gp_used_ = true; }

  // Return whether GP register is used.
  bool
  is_gp_used() const
  { return this->is_gp_used_; }

  // Return the hash of this symbol.
  size_t
  hash() const
  { return gold::string_hash<char>(this->name()); }

 private:
  // Whether we must not create a lazy-binding stub for this symbol.
  // This is true if the symbol has relocations related to taking the
  // function's address.
  bool no_lazy_stub_;
  // Whether GP register is used.  This is true if there is at least
  // one GP-relative relocation in a function.
  bool is_gp_used_;
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
  sort_sections_by_reference(Layout* layout);

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
      gpsetup_relnums_(), input_section_ref_(), gp_is_used_(),
      transformable_sections_(NULL), gpsetup_opts_(), input_sections_(),
      local_symbol_size_(), local_symbol_is_function_(),
      attributes_section_data_(NULL), abiflags_(NULL),
      processor_specific_flags_(0), input_sections_changed_(false),
      merge_processor_specific_data_(true)
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
                              const Symbol_table*, const Layout*,
                              std::vector<Output_relaxed_input_section*>*);

  // Adjust values of the symbols.  Also adjust sizes of the function
  // symbols.  This is used in a relaxation passes.
  void
  adjust_symbols(Address address, unsigned int shndx, int count);

  // Make a new Nanomips_input_section object.
  Nanomips_input_section*
  new_nanomips_input_section(unsigned int, unsigned int, Output_section*);

  // Determine for which function we can remove GP register from
  // save/restore instruction and remove GP-setup relocation.
  void
  finalize_gpsetup_optimizations(Target_nanomips<size, big_endian>* target,
                                 const Symbol_table* symtab);

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

  // Whether a local symbol is a function.
  bool
  local_symbol_is_function(unsigned int symndx) const
  {
    gold_assert(symndx < this->local_symbol_is_function_.size());
    return this->local_symbol_is_function_[symndx];
  }

  // Return the local symbol size.
  Size_type
  local_symbol_size(unsigned int symndx) const
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

  // This is called when we are done with relaxation passes.
  void
  clear_transformable_sections()
  {
    if (this->transformable_sections_ != NULL)
      {
        delete this->transformable_sections_;
        this->transformable_sections_ = NULL;
      }

    // We no longer need the saved information.
    this->gpsetup_relnums_.clear();
  }

  // Add a SAVERESTORE relocation.
  void
  add_saveres_reloc(unsigned int shndx, const Nanomips_reloc<size>& reloc)
  {
    Gpsetup_optimization& gpopt = this->gpsetup_opts_[shndx];
    gpopt.saveres_relocs.insert(reloc);
  }

  // Add a GP-setup relocation.
  void
  add_gpsetup_reloc(unsigned int shndx, size_t relnum,
                    const Nanomips_reloc<size>& reloc)
  {
    Gpsetup_optimization& gpopt = this->gpsetup_opts_[shndx];
    gpopt.gpsetup_relocs.push_back(std::make_pair(relnum, reloc));
  }

  // Add a GP-relative relocation.
  void
  add_gprel_reloc(unsigned int shndx, const Nanomips_reloc<size>& reloc)
  {
    Gpsetup_optimization& gpopt = this->gpsetup_opts_[shndx];
    gpopt.gprel_relocs.push_back(reloc);
  }

  // Return whether we can remove GP-setup relocation.
  bool
  remove_gpsetup_reloc(unsigned int shndx, size_t relnum) const
  {
    Gpsetup_relnums::const_iterator p = this->gpsetup_relnums_.find(shndx);
    if (p == this->gpsetup_relnums_.end())
      return false;
    return p->second.find(relnum) != p->second.end();
  }

  // Return whether GP register is used for a local symbol SYMNDX.
  bool
  is_gp_used(unsigned int symndx) const
  { return this->gp_is_used_.find(symndx) != this->gp_is_used_.end(); }

  // Return whether this object is using full nanoMIPS ISA.
  bool
  nmf() const
  {
    if (this->abiflags_ == NULL)
      return false;
    return (this->abiflags_->ases & elfcpp::AFL_ASE_xNMS) != 0;
  }

  // Return whether this object contains position independent code.
  bool
  pic() const
  {
    elfcpp::Elf_Word pic_flag = elfcpp::EF_NANOMIPS_PIC;
    return (this->processor_specific_flags_ & pic_flag) != 0;
  }

  // Return whether all data access in this object is GP-relative.
  bool
  pid() const
  {
    elfcpp::Elf_Word pid_flag = elfcpp::EF_NANOMIPS_PID;
    return (this->processor_specific_flags_ & pid_flag) != 0;
  }

  // Return whether this object is safe to modify instructions.
  bool
  safe_to_modify() const
  {
    elfcpp::Elf_Word linkrelax_flag = elfcpp::EF_NANOMIPS_LINKRELAX;
    return (this->processor_specific_flags_ & linkrelax_flag) != 0;
  }

  // Return whether this object uses PC-relative addressing.
  bool
  pcrel() const
  {
    elfcpp::Elf_Word pcrel_flag = elfcpp::EF_NANOMIPS_PCREL;
    return (this->processor_specific_flags_ & pcrel_flag) != 0;
  }

 protected:
  // Write the local symbols.
  void
  do_write_local_symbols(Output_file* of,
                         const Stringpool_template<char>* sympool,
                         const Stringpool_template<char>* dynpool,
                         Output_symtab_xindex* symtab_xindex,
                         Output_symtab_xindex* dynsym_xindex,
                         off_t symtab_off);

  // Relocate sections.
  void
  do_relocate_sections(
      const Symbol_table* symtab, const Layout* layout,
      const unsigned char* pshdrs, Output_file* of,
      typename Sized_relobj_file<size, big_endian>::Views* pviews);

  // Read the symbol information.
  void
  do_read_symbols(Read_symbols_data* sd);

 private:
  // This class represents a defined symbol in a transformable section.
  class Defined_symbol
  {
    typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
    typedef typename Sized_relobj_file<size, big_endian>::Size_type Size_type;

   public:
    Defined_symbol(Symbol_value<size>* symval, unsigned int symndx)
      : symndx_(symndx)
    { this->u_.symval = symval; }

    Defined_symbol(Sized_symbol<size>* global)
      : symndx_(-1U)
    { this->u_.global = global; }

    // Return the value of this symbol.
    Address
    value() const
    {
      if (this->symndx_ != -1U)
        return this->u_.symval->input_value();
      return this->u_.global->value();
    }

    // Set the value of this symbol.
    void
    set_value(Address value)
    {
      if (this->symndx_ != -1U)
        this->u_.symval->set_input_value(value);
      else
        this->u_.global->set_value(value);
    }

    // Return the size of this symbol.
    Size_type
    symsize(Nanomips_relobj<size, big_endian>* relobj) const
    {
      if (this->symndx_ != -1U)
        return relobj->local_symbol_size(this->symndx_);
      return this->u_.global->symsize();
    }

    // Set the size of this symbol.
    void
    set_symsize(Nanomips_relobj<size, big_endian>* relobj,
                Size_type symsize)
    {
      if (this->symndx_ != -1U)
        relobj->set_local_symbol_size(this->symndx_, symsize);
      else
        this->u_.global->set_symsize(symsize);
    }

    // Return whether this is a function symbol.
    bool
    is_func(Nanomips_relobj<size, big_endian>* relobj) const
    {
      if (this->symndx_ != -1U)
        return relobj->local_symbol_is_function(this->symndx_);
      return this->u_.global->is_func();
    }

   private:
    // The index of the local symbol; -1 otherwise.
    unsigned int symndx_;
    union
    {
      // For a global symbol, the symbol itself.
      Sized_symbol<size>* global;
      // For a local symbol, the symbol value.
      Symbol_value<size>* symval;
    } u_;
  };

  // This struct represents a section which we a going to scan for
  // instruction transformations.
  struct Transformable_section
  {
    typedef std::vector<Defined_symbol> Defined_symbols;

    Transformable_section(unsigned int reloc_shndx_, unsigned int sh_type_)
      : reloc_shndx(reloc_shndx_), sh_type(sh_type_), symbols()
    { }

    // Index of reloc section.
    unsigned int reloc_shndx;
    // Reloc section type.
    unsigned int sh_type;
    // Defined symbols in this section.  This is used to speed up process
    // of symbol adjustments after instruction transformation.
    Defined_symbols symbols;
  };

  // A map of transformable sections.
  struct Transformable_sections
  {
    typedef std::map<unsigned int, Transformable_section>
        Sections_map;
    typedef typename Sections_map::iterator Iterator;

    Transformable_sections()
      : sections_map(), defined_symbols_initialized(false)
    { }

    // The map of sections.
    Sections_map sections_map;
    // Whether a defined symbols are added to their transformable sections.
    bool defined_symbols_initialized;
  };

  // This structure is used for GP-setup optimization.
  struct Gpsetup_optimization
  {
    typedef std::vector<Nanomips_reloc<size> > Gprel_relocs;
    typedef std::set<Nanomips_reloc<size> > Saveres_relocs;
    typedef std::vector<std::pair<size_t, Nanomips_reloc<size> > >
        Gpsetup_relocs;

    // R_NANOMIPS_SAVERESTORE relocations.
    Saveres_relocs saveres_relocs;
    // Relocations that will be used to determine if GP register
    // is used in a function.
    Gprel_relocs gprel_relocs;
    // GP-setup relocations.
    Gpsetup_relocs gpsetup_relocs;

    Gpsetup_optimization()
      : saveres_relocs(), gprel_relocs(), gpsetup_relocs()
    { }
  };

  // Return a Nanomips input section.
  Nanomips_input_section*
  input_section(unsigned int shndx) const
  {
    gold_assert(shndx < this->input_sections_.size());
    return this->input_sections_[shndx];
  }

  // Set a new Nanomips input section.
  void
  set_input_section(unsigned int shndx, Nanomips_input_section* section)
  {
    gold_assert(shndx < this->input_sections_.size());
    gold_assert(this->input_sections_[shndx] == NULL);
    this->input_sections_[shndx] = section;
  }

  // Initialize sections which we a going to scan for
  // instruction transformation.
  void
  initialize_transformable_sections(const Symbol_table*);

  // Initialize symbols that are defined in a transformable sections, and
  // adjust symbols defined in section with index SHNDX.
  void
  initialize_defined_symbols(Address address, unsigned int shndx, int count);

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

  typedef Unordered_set<size_t> Reloc_numbers;
  typedef Unordered_map<unsigned int, Reloc_numbers> Gpsetup_relnums;
  typedef Unordered_map<unsigned int, Gpsetup_optimization> Gpsetup_opts;

  // A map to track the GP-setup relocation numbers which we are going
  // to delete in a relaxation pass.
  Gpsetup_relnums gpsetup_relnums_;
  // A map to track the number of how many times input section has been
  // referenced with lw[gp]/sw[gp] instruction.
  Input_section_ref input_section_ref_;
  // Local symbols which contain at least one GP-relative reloc.
  // This is used only for function symbols.
  Unordered_set<unsigned int> gp_is_used_;
  // Sections which we a going to scan for instruction transformations.
  Transformable_sections* transformable_sections_;
  // A map that contains all needed information for GP-setup optimization.
  Gpsetup_opts gpsetup_opts_;
  // Nanomips input sections.
  std::vector<Nanomips_input_section*> input_sections_;
  // Size of the local symbols.
  std::vector<Size_type> local_symbol_size_;
  // Bit vector to tell if a local symbol is a function or not.
  std::vector<bool> local_symbol_is_function_;
  // Object attributes if there is a .gnu.attributes section or NULL.
  Attributes_section_data* attributes_section_data_;
  // Object abiflags if there is a .nanoMIPS.abiflags section or NULL.
  Nanomips_abiflags<big_endian>* abiflags_;
  // processor-specific flags in ELF file header.
  elfcpp::Elf_Word processor_specific_flags_;
  // Whether input sections in this object file are changed.  This can happen
  // only in a relaxation pass.
  bool input_sections_changed_;
  // Whether we merge processor-specific data of this object to output.
  bool merge_processor_specific_data_;
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

    // Relocation (PC14_S1 or PC11_S1).
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

  // Delete bytes for instruction transformation.
  void
  delete_bytes(size_t pos, size_t size)
  {
    memmove(this->contents_.data + pos - size, this->contents_.data + pos,
            (this->contents_.len - pos));
    this->contents_.len -= size;
  }

  // Add bytes for instruction transformation.
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

  // Print usage statistics.
  static void
  print_stats()
  {
    fprintf(stderr, _("%s: changed input sections: %llu\n"),
            program_name, Nanomips_input_section::section_count);
  }

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

  // Statistics.

  // Number of changed input sections.
  static unsigned long long section_count;
};

// Number of changed input sections.
unsigned long long Nanomips_input_section::section_count = 0;

// The class which implements transformations.

template<int size, bool big_endian>
class Nanomips_transformations
{
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef typename elfcpp::Elf_types<size>::Elf_WXword Size_type;

 public:
  Nanomips_transformations()
  { }

  // Handle alignment requirement.
  void
  align(const Relocate_info<size, big_endian>* relinfo,
        Target_nanomips<size, big_endian>* target,
        Nanomips_input_section* input_section,
        size_t relnum,
        size_t reloc_count,
        const unsigned char* prelocs,
        Address view_address);

  // Transform instruction.
  inline void
  transform(const Relocate_info<size, big_endian>* relinfo,
            const Nanomips_transform_template* transform_template,
            const Nanomips_insn_property* insn_property,
            Nanomips_input_section* input_section,
            unsigned int type,
            size_t relnum,
            uint32_t insn);

  // Print transformation.
  void
  print(const Relocate_info<size, big_endian>* relinfo,
        const Nanomips_transform_template* transform_template,
        const std::string& insn_name,
        const Symbol* gsym,
        unsigned int r_sym,
        Address r_offset,
        typename elfcpp::Elf_types<size>::Elf_Swxword r_addend);

  // Print usage statistics.
  static void
  print_stats()
  {
    fprintf(stderr, _("%s: transformed instructions: %llu\n"),
            program_name,
            Nanomips_transformations<size, big_endian>::instruction_count);
  }

  // Return true if VALUE has overflowed a signed value.
  template<int valsize>
  static inline bool
  has_overflow_signed(Valtype value)
  {
    return (size == 32 ? Bits<valsize>::has_overflow32(value)
                       : Bits<valsize>::has_overflow(value));
  }

  // Return true if VALUE has overflowed an unsigned value.
  template<int valsize>
  static inline bool
  has_overflow_unsigned(Valtype value)
  {
    return (size == 32 ? Bits<valsize>::has_unsigned_overflow32(value)
                       : Bits<valsize>::has_unsigned_overflow(value));
  }

 private:
  // Write nanoMIPS instruction.
  void
  write_insn(unsigned char* view, uint32_t insn, unsigned int insn_size);

  // Find R_NANOMIPS_FILL and R_NANOMIPS_MAX relocations (if any) and get
  // fill value, fill size and max bytes generated by the assembler.
  void
  find_fill_max(Nanomips_relobj<size, big_endian>* relobj,
                Address offset, size_t relnum, size_t reloc_count,
                const unsigned char* prelocs, Valtype* fill,
                Valtype* max, Size_type* fill_size);

  // Statistics.

  // Number of transformed instructions.
  static unsigned long long instruction_count;
};

// Number of transformed instructions.
template<int size, bool big_endian>
unsigned long long
Nanomips_transformations<size, big_endian>::instruction_count = 0;

// The class which implements relaxations.

template<int size, bool big_endian>
class Nanomips_relax_insn : public Nanomips_transformations<size, big_endian>
{
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_relax_insn()
    : Nanomips_transformations<size, big_endian>()
  { }

  // Return matching instruction for relaxation if there is one and INSN can
  // be relaxed, otherwise return NULL.
  const Nanomips_insn_property*
  find_insn(Nanomips_relobj<size, big_endian>* relobj, uint32_t insn,
            unsigned int mask, unsigned int r_type);

  // Return the transformation type if this instruction can be relaxed.
  unsigned int
  type(const Relocate_info<size, big_endian>* relinfo,
       Target_nanomips<size, big_endian>* target,
       const Symbol* gsym,
       const Symbol_value<size>* psymval,
       const Nanomips_insn_property* insn_property,
       const elfcpp::Rela<size, big_endian>& reloc,
       size_t relnum,
       uint32_t insn,
       Address address,
       Address gp);

 protected:
  // Return the type of the relaxation for code and data models.
  unsigned int
  relax_code_and_data_models(const Nanomips_relobj<size, big_endian>* relobj,
                             const Symbol* gsym,
                             const Symbol_value<size>* psymval,
                             const Nanomips_insn_property* insn_property,
                             const elfcpp::Rela<size, big_endian>& reloc,
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
  Nanomips_relax_insn_finalize()
    : Nanomips_relax_insn<size, big_endian>()
  { }

  // Return the transformation type if this instruction can be relaxed
  // during --finalize-relocs.
  unsigned int
  type(const Relocate_info<size, big_endian>* relinfo,
       Target_nanomips<size, big_endian>* target,
       const Symbol* gsym,
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
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_expand_insn()
    : Nanomips_transformations<size, big_endian>()
  { }

  // Return matching instruction for expansion if there is one.
  const Nanomips_insn_property*
  find_insn(Nanomips_relobj<size, big_endian>* relobj, uint32_t insn,
            unsigned int mask, unsigned int r_type);

  // Return the transformation type if instruction needs to be expanded.
  unsigned int
  type(const Relocate_info<size, big_endian>* relinfo,
       Target_nanomips<size, big_endian>* target,
       const Symbol* gsym,
       const Symbol_value<size>* psymval,
       const Nanomips_insn_property* insn_property,
       const elfcpp::Rela<size, big_endian>& reloc,
       size_t,
       uint32_t insn,
       Address address,
       Address gp);

 protected:
  // Return the type of the expansion for instruction whose
  // value is out of the range limits.
  unsigned int
  expand_type(const Nanomips_relobj<size, big_endian>* relobj,
              const Nanomips_insn_property* insn_property,
              uint32_t insn,
              unsigned int r_type);

  // Return the type of the expansion for code and data models.
  unsigned int
  expand_code_and_data_models(Target_nanomips<size, big_endian>* target,
                              const Nanomips_relobj<size, big_endian>* relobj,
                              const Symbol* gsym,
                              const elfcpp::Rela<size, big_endian>& reloc,
                              Address gp);
};

// The class which implements expansions during --finalize-relocs.

template<int size, bool big_endian>
class Nanomips_expand_insn_finalize
  : public Nanomips_expand_insn<size, big_endian>
{
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Nanomips_expand_insn_finalize()
    : Nanomips_expand_insn<size, big_endian>()
  { }

  // Return the transformation type if instruction needs to be expanded
  // during --finalize-relocs.
  unsigned int
  type(const Relocate_info<size, big_endian>* relinfo,
       Target_nanomips<size, big_endian>* target,
       const Symbol* gsym,
       const Symbol_value<size>* psymval,
       const Nanomips_insn_property* insn_property,
       const elfcpp::Rela<size, big_endian>& reloc,
       size_t relnum,
       uint32_t insn,
       Address address,
       Address gp);
};

// This class handles .nanoMIPS.abiflags output section.

template<bool big_endian>
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
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_WXword Size_type;

 public:
  Target_nanomips(const Target::Target_info* info = &nanomips_info)
    : Sized_target<size, big_endian>(info), state_(NO_TRANSFORM), got_(NULL),
      stubs_(NULL), rel_dyn_(NULL), copy_relocs_(elfcpp::R_NANOMIPS_COPY),
      gp_(NULL), attributes_section_data_(NULL), abiflags_(NULL),
      got_mod_index_offset_(-1U), has_abiflags_section_(false)
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
  // only used for the RELOC_RESOLVE relocation strategy.
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
                             Nanomips_input_section* input_section,
                             std::vector<Output_relaxed_input_section*>*
                               new_relaxed_sections,
                             const unsigned char* view,
                             Address view_address);

  // Return value of the _gp symbol.
  Address
  gp_value() const
  { return this->gp_ != NULL ? this->gp_->value() : 0; }

  // Return the _gp symbol.
  const Sized_symbol<size>*
  gp_sym() const
  { return this->gp_; }

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

  // Create a GOT entry for the TLS module index.
  unsigned int
  got_mod_index_entry(Symbol_table* symtab, Layout* layout,
                      Sized_relobj_file<size, big_endian>* object);

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

  // Update content for instruction transformation.
  void
  update_content(Nanomips_input_section*, Nanomips_relobj<size, big_endian>*,
                 Address, int, bool);

  // Relocate conditional branches.  This is only used if we have transformed
  // conditional branch into opposite branch and bc instruction in a relaxation
  // pass.
  void
  relocate_branch(unsigned int, Address, Address, unsigned char*);

  // Add a potential copy relocation.
  void
  copy_reloc(Symbol_table* symtab, Layout* layout,
             Sized_relobj_file<size, big_endian>* object,
             unsigned int shndx, Output_section* output_section,
             Symbol* sym, const elfcpp::Rela<size, big_endian>& reloc)
  {
    unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
    this->copy_relocs_.copy_reloc(symtab, layout,
                                  symtab->get_sized_symbol<size>(sym),
                                  object, shndx, output_section,
                                  r_type, reloc.get_r_offset(), 0,
                                  this->rel_dyn_section(layout));
  }

  // Get the default Nanomips target.
  static This*
  current_target()
  {
    gold_assert(parameters->target().machine_code() == elfcpp::EM_NANOMIPS
                && parameters->target().get_size() == size
                && parameters->target().is_big_endian() == big_endian);
    return static_cast<This*>(parameters->sized_target<size, big_endian>());
  }

  // Run relaxation pass to relax and expand instructions,
  // or to sort sections by reference.
  bool
  do_may_relax() const
  {
    return ((!parameters->options().relocatable()
             || parameters->options().finalize_relocs())
            && (parameters->options().relax()
                || parameters->options().expand()
                || parameters->options().any_sort_by_reference()));
  }

 protected:
  // do_make_elf_object to override the same function in the base class.
  Object*
  do_make_elf_object(const std::string&, Input_file*, off_t,
                     const elfcpp::Ehdr<size, big_endian>&);

  // Relaxation hook.  This is where we do transformations of nanoMIPS
  // instructions.
  bool
  do_relax(int, const Input_objects*, Symbol_table*, Layout*, const Task*);

  // Finalize the sections.
  void
  do_finalize_sections(Layout*, const Input_objects*, Symbol_table*);

  // Make an output section.
  Output_section*
  do_make_output_section(const char* name, elfcpp::Elf_Word type,
                         elfcpp::Elf_Xword flags)
  { return new Nanomips_output_section<size, big_endian>(name, type, flags); }

  // Return whether SYM is defined by the ABI.
  bool
  do_is_defined_by_abi(const Symbol* sym) const
  { return strcmp(sym->name(), "__tls_get_addr") == 0; }

  // Return whether a symbol name implies a local label.
  bool
  do_is_local_label_name(const char* name) const
  {
    // Check if symbol name starts with "$L".
    if (name[0] == '$' && name[1] == 'L')
      return true;
    return Target::do_is_local_label_name(name);
  }

  // Don't emit input .nanoMIPS.abiflags sections to
  // output .nanoMIPS.abiflags.
  bool
  do_should_include_section(elfcpp::Elf_Word sh_type) const
  { return sh_type != elfcpp::SHT_NANOMIPS_ABIFLAGS; }

  // Print statistical information to stderr.  This is used for --stats.
  void
  do_print_stats() const
  {
    Nanomips_input_section::print_stats();
    Nanomips_transformations<size, big_endian>::print_stats();
  }

  void
  do_select_as_default_target()
  {
    gold_assert(nanomips_reloc_property_table == NULL);
    gold_assert(nanomips_insn_property_table == NULL);
    nanomips_reloc_property_table = new Nanomips_reloc_property_table();
    nanomips_insn_property_table = new Nanomips_insn_property_table();
  }

 private:
  // The class which scans relocations.
  class Scan
  {
   public:
    Scan()
      : seen_norelax_(false)
    { }

    inline void
    local(Symbol_table* symtab, Layout* layout, Target_nanomips* target,
          Sized_relobj_file<size, big_endian>* object,
          unsigned int data_shndx, Output_section* output_section,
          unsigned int, const unsigned char* preloc, size_t reloc_count,
          size_t relnum, const elfcpp::Sym<size, big_endian>& lsym,
          bool is_discarded);

    inline void
    global(Symbol_table* symtab, Layout* layout, Target_nanomips* target,
           Sized_relobj_file<size, big_endian>* object,
           unsigned int data_shndx, Output_section* output_section,
           unsigned int, const unsigned char* preloc, size_t reloc_count,
           size_t relnum, Symbol* gsym);

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
    // Return true if a reloc is part of a composite relocations.
    inline bool
    reloc_in_composite_relocs(Address offset,
                              size_t reloc_count,
                              size_t relnum,
                              const unsigned char* preloc);

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

    // Return whether we only need to apply addend for a R_NANOMIPS_32
    // relocation.
    inline bool
    should_only_apply_addend(const Sized_symbol<size>* gsym,
                             unsigned int flags,
                             bool reloc_in_composite_relocs,
                             Output_section* output_section);

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

  class Relocate_comdat_behavior : public gold::Default_comdat_behavior
  {
   public:
    // Decide what the linker should do for relocations that refer to
    // discarded comdat sections.
    inline Comdat_behavior
    get(const char* name)
    {
      // For a range list, use 1 instead of 0 as placeholder.
      // 0 would terminate the list, hiding any later entries.
      if (strcmp(name, ".debug_ranges") == 0)
        return CB_SET_TO_ONE;
      if (Layout::is_debug_info_section(name)
	  && strcmp(name, ".debug_info") != 0)
        return CB_RETAIN;
      return gold::Default_comdat_behavior::get(name);
    }
  };

  enum Nanomips_mach {
    mach_nanomipsisa32r6 = 32,
    mach_nanomipsisa64r6 = 64
  };

  // The value to write into got[1] for SVR4 targets, to identify it is
  // a GNU object.  The dynamic linker can then use got[1] to store the
  // module pointer.
  uint64_t
  nanomips_elf_gnu_got1_mask()
  {
    if (size == 64)
      return (uint64_t)1 << 63;
    else
      return 1 << 31;
  }

  // Scan a relocation section for instruction transformation.
  template <typename Nanomips_transform>
  bool
  scan_reloc_section_for_transform(const Relocate_info<size, big_endian>*,
                                   const unsigned char*, size_t,
                                   Output_section*,
                                   Nanomips_input_section*,
                                   std::vector<Output_relaxed_input_section*>*,
                                   const unsigned char*,
                                   Address);

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

  // Instruction transformation state.
  typedef enum
  {
    // Don't transform instructions.
    NO_TRANSFORM,
    // Instruction expansion state.
    EXPAND,
    // Instruction relaxation state.
    RELAX
  } Transform_state;

  // States used in a relaxation passes.
  Transform_state state_;
  // The GOT section.
  Nanomips_output_data_got<size, big_endian>* got_;
  // The .nanoMIPS.stubs section.
  Nanomips_output_data_stubs<size, big_endian>* stubs_;
  // The dynamic reloc section.
  Reloc_section* rel_dyn_;
  // Relocs saved to avoid a COPY reloc.
  Copy_relocs<elfcpp::SHT_REL, size, big_endian> copy_relocs_;
  // The _gp symbol.
  Sized_symbol<size>* gp_;
  // Attributes section data in output.
  Attributes_section_data* attributes_section_data_;
  // .nanoMIPS.abiflags section data in output.
  Nanomips_abiflags<big_endian>* abiflags_;
  // Offset of the GOT entry for the TLS module index.
  unsigned int got_mod_index_offset_;
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

  enum Overflow_check
  {
    // No overflow checking.
    CHECK_NONE,
    // Check for overflow of a signed value.
    CHECK_SIGNED,
    // Check for overflow of an unsigned value.
    CHECK_UNSIGNED
  };

  template<int valsize>
  static inline Status
  check_overflow(Address value, Overflow_check check)
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
  relpc(unsigned char* view, Address value, Overflow_check check)
  {
    typedef typename Nanomips_insn_swap<fieldsize, big_endian>::Valtype
        Valtype;
    Valtype val = Nanomips_insn_swap<fieldsize, big_endian>::readval(view);
    Valtype reloc = ((value & ~0x1) | ((value >> (valsize - 1)) & 0x1));
    Valtype mask = (1 << (valsize - 1)) - 1;
    val &= ~mask;
    reloc &= mask;
    Nanomips_insn_swap<fieldsize, big_endian>::writeval(view, val | reloc);

    if (check == CHECK_NONE)
      return STATUS_OKAY;

    if (value & 0x1)
      return STATUS_UNALIGNED;

    return check_overflow<valsize>(value, check);
  }

  // Do a simple gp-relative relocation.
  template<int valsize>
  static inline Status
  relgp(unsigned char* view, Address value, Address mask, unsigned int align,
        Overflow_check check)
  {
    typedef typename Nanomips_insn_swap<32, big_endian>::Valtype Valtype;
    Valtype val = Nanomips_insn_swap<32, big_endian>::readval(view);
    Valtype reloc = value & mask;
    val &= ~mask;
    Nanomips_insn_swap<32, big_endian>::writeval(view, val | reloc);

    if (check == CHECK_NONE)
      return STATUS_OKAY;

    if (value & (align - 1))
      return STATUS_UNALIGNED;

    return check_overflow<valsize>(value, check);
  }

 public:
  // R_NANOMIPS_GOT_DISP, R_NANOMIPS_GOT_PAGE, R_NANOMIPS_GOT_CALL,
  // R_NANOMIPS_TLS_GD, , R_NANOMIPS_TLS_LD, R_NANOMIPS_TLS_GOTTPREL
  static inline Status
  relgot(unsigned char* view, Address value)
  {
    return This::template relgp<21>(view, value, 0x1ffffc, 4, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_GPREL19_S2
  static inline Status
  relgprel19_s2(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffffc, 4, check);
  }

  // R_NANOMIPS_GPREL18_S3
  static inline Status
  relgprel18_s3(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffff8, 8, check);
  }

  // R_NANOMIPS_GPREL18
  static inline Status
  relgprel18(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3ffff, 1, check);
  }

  // R_NANOMIPS_GPREL17_S1
  static inline Status
  relgprel17_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffe, 2, check);
  }

  // R_NANOMIPS_GPREL16_S2
  static inline Status
  relgprel16_s2(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffc, 4, check);
  }

  // R_NANOMIPS_GPREL7_S2
  static inline Status
  relgprel7_s2(unsigned char* view, Address value, bool should_check_overflow)
  {
    typedef typename Nanomips_insn_swap<16, big_endian>::Valtype Valtype16;
    Valtype16 val = Nanomips_insn_swap<16, big_endian>::readval(view);
    val = Bits<7>::bit_select32(val, value >> 2, 0x7f);
    Nanomips_insn_swap<16, big_endian>::writeval(view, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & 0x3)
      return STATUS_UNALIGNED;

    return check_overflow<9>(value, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_PC32
  static inline Status
  relpc32(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template rel<32>(view, value, check);
  }

  // R_NANOMIPS_PC25_S1
  static inline Status
  relpc25_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 26>(view, value, check);
  }

  // R_NANOMIPS_PC21_S1
  static inline Status
  relpc21_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 22>(view, value, check);
  }

  // R_NANOMIPS_PC14_S1
  static inline Status
  relpc14_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 15>(view, value, check);
  }

  // R_NANOMIPS_PC11_S1
  static inline Status
  relpc11_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<32, 12>(view, value, check);
  }

  // R_NANOMIPS_PC10_S1
  static inline Status
  relpc10_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<16, 11>(view, value, check);
  }

  // R_NANOMIPS_PC7_S1
  static inline Status
  relpc7_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_SIGNED : CHECK_NONE;
    return This::template relpc<16, 8>(view, value, check);
  }

  // R_NANOMIPS_PC4_S1
  static inline Status
  relpc4_s1(unsigned char* view, Address value, bool should_check_overflow)
  {
    typedef typename Nanomips_insn_swap<16, big_endian>::Valtype Valtype16;
    Valtype16 val = Nanomips_insn_swap<16, big_endian>::readval(view);
    val = Bits<4>::bit_select32(val, value >> 1, 0xf);
    Nanomips_insn_swap<16, big_endian>::writeval(view, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & 0x1)
      return STATUS_UNALIGNED;

    return check_overflow<5>(value, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_ASHIFTR_1, R_NANOMIPS_NEG, R_NANOMIPS_TLS_DTPMOD,
  // R_NANOMIPS_TLS_DTPREL, R_NANOMIPS_TLS_TPREL
  static inline Status
  relsize(unsigned char* view, Address value)
  { return This::template rel<size>(view, value, CHECK_NONE); }

  // R_NANOMIPS_I32, R_NANOMIPS_PC_I32, R_NANOMIPS_GPREL_I32,
  // R_NANOMIPS_GOTPC_I32, R_NANOMIPS_TLS_GD_I32, R_NANOMIPS_TLS_LD_I32,
  // R_NANOMIPS_TLS_GOTTPREL_PC_I32, R_NANOMIPS_TLS_TPREL_I32,
  // R_NANOMIPS_TLS_DTPREL_I32
  static inline Status
  rel48(unsigned char* view, Address value, bool should_check_overflow)
  {
    Nanomips_insn_swap<48, big_endian>::writeval(view, value);
    return (should_check_overflow ? check_overflow<32>(value, CHECK_SIGNED)
                                  : STATUS_OKAY);
  }

  // R_NANOMIPS_32
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
    typedef typename Nanomips_insn_swap<32, big_endian>::Valtype Valtype32;
    Valtype32 val = Nanomips_insn_swap<32, big_endian>::readval(view);
    val = ((val & 0xffe00002) | (value & 0x1ff000) | ((value >> 19) & 0xffc)
           | ((value >> 31) & 0x1));
    Nanomips_insn_swap<32, big_endian>::writeval(view, val);
    return STATUS_OKAY;
  }

  // R_NANOMIPS_LO4_S2
  static inline Status
  rello4_s2(unsigned char* view, Address value, bool should_check_overflow)
  {
    typedef typename Nanomips_insn_swap<16, big_endian>::Valtype Valtype16;
    Valtype16 val = Nanomips_insn_swap<16, big_endian>::readval(view);
    value &= 0xfff;
    val = Bits<4>::bit_select32(val, value >> 2, 0xf);
    Nanomips_insn_swap<16, big_endian>::writeval(view, val);

    if (!should_check_overflow)
      return STATUS_OKAY;

    if (value & 0x3)
      return STATUS_UNALIGNED;

    return check_overflow<6>(value, CHECK_UNSIGNED);
  }

  // R_NANOMIPS_LO12, R_NANOMIPS_GPREL_LO12, R_NANOMIPS_GOT_LO12,
  // R_NANOMIPS_GOT_OFST, R_NANOMIPS_TLS_TPREL12, R_NANOMIPS_TLS_DTPREL12
  static inline Status
  rel12(unsigned char* view, Address value, bool should_check_overflow)
  {
    typedef typename Nanomips_insn_swap<32, big_endian>::Valtype Valtype32;
    Valtype32 val = Nanomips_insn_swap<32, big_endian>::readval(view);
    val = Bits<12>::bit_select32(val, value, 0xfff);
    Nanomips_insn_swap<32, big_endian>::writeval(view, val);
    return (should_check_overflow ? check_overflow<12>(value, CHECK_UNSIGNED)
                                  : STATUS_OKAY);
  }

  // R_NANOMIPS_TLS_TPREL16, R_NANOMIPS_TLS_DTPREL16
  static inline Status
  reltls16(unsigned char* view, Address value, bool should_check_overflow)
  {
    typedef typename Nanomips_insn_swap<32, big_endian>::Valtype Valtype32;
    Valtype32 val = Nanomips_insn_swap<32, big_endian>::readval(view);
    val = Bits<12>::bit_select32(val, value, 0xffff);
    Nanomips_insn_swap<32, big_endian>::writeval(view, val);
    return (should_check_overflow ? check_overflow<16>(value, CHECK_UNSIGNED)
                                  : STATUS_OKAY);
  }

  // R_NANOMIPS_FRAME_REG
  static inline Status
  relframereg(unsigned char* view, Address value)
  { return This::template rel<8>(view, value, CHECK_NONE); }
};

// Nanomips_output_data_stubs methods.

// Entry in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_entry[] =
{
  0x03000000,         // li t8,JMPRELINDX(sym)
  0x1800              // bc[16] footer
};

// Footer in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_normal_footer[] =
{
  0x43200002,         // lw t9,NANOMIPS_GOT0($gp)
  0x11ff,             // move t3,ra
  0xdb30              // jalrc t9
};

// Big footer in the .nanoMIPS.stubs section.
template<int size, bool big_endian>
const uint32_t
Nanomips_output_data_stubs<size, big_endian>::lazy_stub_big_footer[] =
{
  0x43200002,         // lw t9,NANOMIPS_GOT0($gp)
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
  Nanomips_stubs_footer* footer = this->create_footer();

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
      Nanomips_insn_swap<32, big_endian>::writeval(pov, (lazy_stub[0]
                                                         | (indx & 0xffff)));

      // Write bc[16] instruction.
      Nanomips_insn_swap<16, big_endian>::writeval(pov + 4, lazy_stub[1]);

      // Calculate and write value for bc[16] instruction.
      uint64_t bc16_off = off + 4;
      Valtype value = static_cast<Valtype>(footer->offset - bc16_off - 2);
      reloc_status = Reloc_funcs::relpc10_s1(pov + 4, value, true);
      if (reloc_status != Reloc_funcs::STATUS_OKAY)
        {
          gold_error(_("PC10_S1 overflow in .nanoMIPS.stubs"));
          return;
        }
    }

  // Write .nanoMIPS.stubs footers.
  for (typename Nanomips_stubs_footers::const_iterator
       p = this->footers_.begin();
       p != this->footers_.end();
       ++p)
    {
      Nanomips_stubs_footer* footer = *p;
      uint64_t off = footer->offset;
      bool is_big = footer->bias > 0;

      unsigned char* pov = oview + off;
      const uint32_t* lazy_stub_footer = (is_big ? lazy_stub_big_footer
                                                 : lazy_stub_normal_footer);
      unsigned int i = 0;

      // Write lw t9,NANOMIPS_GOT0($gp) instruction.
      Nanomips_insn_swap<32, big_endian>::writeval(pov, lazy_stub_footer[i]);
      ++i;
      pov += 4;

      // Write addiu[48] t8,bias instruction if needed.
      if (is_big)
        {
          Nanomips_insn_swap<16, big_endian>::writeval(pov,
                                                       lazy_stub_footer[i]);
          Nanomips_insn_swap<48, big_endian>::writeval(pov, footer->bias);
          ++i;
          pov += 6;
        }

      // Write move t3,ra instruction.
      Nanomips_insn_swap<16, big_endian>::writeval(pov, lazy_stub_footer[i]);
      // Write jalrc t9 instruction.
      Nanomips_insn_swap<16, big_endian>::writeval(pov + 2,
                                                   lazy_stub_footer[i + 1]);
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

  const off_t offset = this->offset();
  const section_size_type oview_size =
    convert_to_section_size_type(this->data_size());
  unsigned char* const oview = of->get_output_view(offset, oview_size);

  // Write lazy stub addresses.
  Nanomips_output_data_stubs<size, big_endian>* stubs =
    this->target_->nanomips_stubs_section();

  if (stubs == NULL)
    return;

  for (typename std::vector<Nanomips_stubs_entry<size> >::iterator
       p = stubs->nanomips_stubs_entries().begin();
       p != stubs->nanomips_stubs_entries().end();
       ++p)
    {
      typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
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
Nanomips_output_section<size, big_endian>::sort_sections_by_reference(
    Layout* layout)
{
  // We don't want the relaxation loop to undo these changes, so we restore
  // and discard the current saved states and take another one after the
  // fix-up.
  this->restore_states(layout->script_options()->saw_sections_clause());
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

// Make a new Nanomips_input_section object.

template<int size, bool big_endian>
Nanomips_input_section*
Nanomips_relobj<size, big_endian>::new_nanomips_input_section(
    unsigned int data_shndx,
    unsigned int reloc_shndx,
    Output_section* os)
{
  const unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  Nanomips_input_section* input_section =
    new Nanomips_input_section(this, data_shndx, os, reloc_size);
  input_section->init(reloc_shndx);

  this->set_input_section(data_shndx, input_section);
  this->input_sections_changed_ = true;
  return input_section;
}

// Determine for which function we can remove GP register from
// save/restore instruction and remove GP-setup relocation.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::finalize_gpsetup_optimizations(
    Target_nanomips<size, big_endian>* target,
    const Symbol_table* symtab)
{
  typedef typename Gpsetup_optimization::Gprel_relocs Gprel_relocs;
  typedef typename Gpsetup_optimization::Saveres_relocs Saveres_relocs;
  typedef typename Gpsetup_optimization::Gpsetup_relocs Gpsetup_relocs;
  typedef Nanomips_transformations<size, big_endian> Transform;

  Address gp = 0;
  if (target->gp_sym() != NULL)
    {
      // We need to compute the would-be final value of the _gp.
      Symbol_table::Compute_final_value_status status;
      Address value = symtab->compute_final_value<size>(target->gp_sym(),
                                                        &status);
      if (status == Symbol_table::CFVS_OK)
        gp = value;
    }

  for (typename Gpsetup_opts::iterator it = this->gpsetup_opts_.begin();
       it != this->gpsetup_opts_.end();
       ++it)
    {
      unsigned int shndx = it->first;
      Gpsetup_optimization& gpopt = it->second;
      Gprel_relocs& gprel_relocs = gpopt.gprel_relocs;
      Saveres_relocs& saveres_relocs = gpopt.saveres_relocs;
      Gpsetup_relocs& gpsetup_relocs = gpopt.gpsetup_relocs;

      // Skip if there are no R_NANOMIPS_SAVERESTORE relocations.
      if (saveres_relocs.empty())
        continue;

      // Find relocations that need GP register and set to their corresponding
      // functions for which we have R_NANOMIPS_SAVERESTORE relocation that
      // GP can't be removed.
      for (typename Gprel_relocs::iterator it2 = gprel_relocs.begin();
           it2 != gprel_relocs.end();
           ++it2)
        {
          Nanomips_reloc<size>& gprel_reloc = *it2;
          unsigned int r_type = gprel_reloc.r_type();
          unsigned int r_offset = gprel_reloc.r_offset();
          Nanomips_symbol<size>* sym = NULL;
          unsigned int r_sym = -1U;
          bool is_gp_used = false;

          if (gprel_reloc.is_for_local_symbol())
            r_sym = gprel_reloc.symndx();
          else
            sym = gprel_reloc.symbol();

          if (r_type == elfcpp::R_NANOMIPS_GPREL_I32
              || r_type == elfcpp::R_NANOMIPS_GPREL_HI20
              || r_type == elfcpp::R_NANOMIPS_GPREL19_S2
              || r_type == elfcpp::R_NANOMIPS_GPREL18_S3
              || r_type == elfcpp::R_NANOMIPS_GPREL18
              || r_type == elfcpp::R_NANOMIPS_GPREL17_S1
              || r_type == elfcpp::R_NANOMIPS_GPREL16_S2
              || r_type == elfcpp::R_NANOMIPS_GPREL7_S2
              || r_type == elfcpp::R_NANOMIPS_TLS_GD_I32
              || r_type == elfcpp::R_NANOMIPS_TLS_GD
              || r_type == elfcpp::R_NANOMIPS_TLS_LD_I32
              || r_type == elfcpp::R_NANOMIPS_TLS_LD)
            {
              // For these relocations GP register is always used.
              is_gp_used = true;
            }
          else if (r_type == elfcpp::R_NANOMIPS_TLS_GOTTPREL
                   || (sym != NULL && !is_symbol_locally_resolved(sym)))
            {
              // GP register is used if we are not expanding instructions.
              if (!parameters->options().expand())
                is_gp_used = true;
              else
                {
                  unsigned int got_offset;
                  if (gprel_reloc.is_for_local_symbol())
                    got_offset = local_got_offset(target, this, r_sym, r_type,
                                                  gprel_reloc.addend());
                  else
                    got_offset = global_got_offset(target, sym, r_type);

                  gold_assert(got_offset != -1U);
                  Address gp_offset =
                    target->got_section()->gp_offset(got_offset, gp);

                  // Externally defined or preemptible symbols.
                  switch (r_type)
                    {
                    case elfcpp::R_NANOMIPS_GOT_CALL:
                      // GP will be used if there is a call to a
                      // lazy-binding stub.
                      if (sym->has_lazy_stub())
                        {
                          is_gp_used = true;
                          break;
                        }
                      // Fall through.

                    case elfcpp::R_NANOMIPS_GOT_PAGE:
                    case elfcpp::R_NANOMIPS_GOT_DISP:
                    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
                      // GP register will be used if this won't be
                      // transformed into a PC-relative instruction.
                      if (!Transform::template
                            has_overflow_unsigned<21>(gp_offset))
                        is_gp_used = true;
                      break;
                    default:
                      gold_unreachable();
                    }
                }
            }
          else
            {
              // Locally resolved symbols.
              switch (r_type)
                {
                case elfcpp::R_NANOMIPS_GOT_CALL:
                  break;
                case elfcpp::R_NANOMIPS_GOT_PAGE:
                  // GP register is used for GP-relative data access.
                  // Note that here R_NANOMIPS_GOT_PAGE reloc is used,
                  // rather than R_NANOMIPS_GOT_OFST.
                  if (this->pid())
                    is_gp_used = true;
                  break;
                case elfcpp::R_NANOMIPS_GOT_DISP:
                  {
                    // We don't use gp-relative transformations
                    // for function address calculations.
                    bool is_func = (sym != NULL
                                    ? sym->is_func()
                                    : this->local_symbol_is_function(r_sym));

                    if (this->pid() && !is_func)
                      is_gp_used = true;
                  }
                  break;
                default:
                  gold_unreachable();
                }
            }

          // Try to find corresponding function in which GP register is used.
          if (is_gp_used)
            {
              typename Saveres_relocs::iterator sres_it =
                saveres_relocs.upper_bound(gprel_reloc);
              if (sres_it != saveres_relocs.begin())
                {
                  --sres_it;
                  Address value = sres_it->r_offset();
                  Size_type symsize =
                    (!sres_it->is_for_local_symbol()
                     ? sres_it->symbol()->symsize()
                     : this->local_symbol_size(sres_it->symndx()));

                  if (value <= r_offset && r_offset < value + symsize)
                    {
                      // We found a function. Set that GP is used.
                      if (sres_it->is_for_local_symbol())
                        this->gp_is_used_.insert(sres_it->symndx());
                      else
                        sres_it->symbol()->set_gp_is_used();
                    }
                }
            }
        }

      // Find GP-setup relocations that can be removed.
      for (typename Gpsetup_relocs::iterator it2 = gpsetup_relocs.begin();
           it2 != gpsetup_relocs.end();
           ++it2)
        {
          size_t relnum = it2->first;
          Nanomips_reloc<size>& gpsetup_reloc = it2->second;
          Address r_offset = gpsetup_reloc.r_offset();

          typename Saveres_relocs::iterator sres_it =
            saveres_relocs.upper_bound(gpsetup_reloc);
          if (sres_it != saveres_relocs.begin())
            {
              --sres_it;
              Address value = sres_it->r_offset();
              Size_type symsize =
                (!sres_it->is_for_local_symbol()
                 ? sres_it->symbol()->symsize()
                 : this->local_symbol_size(sres_it->symndx()));

              if (value <= r_offset && r_offset < value + symsize)
                {
                  bool is_gp_used = (!sres_it->is_for_local_symbol()
                                     ? sres_it->symbol()->is_gp_used()
                                     : this->is_gp_used(sres_it->symndx()));

                  // If in this function GP register is not used, set the
                  // relocation number of the GP-setup reloc that will be
                  // removed in a relaxation pass.
                  if (!is_gp_used)
                    this->gpsetup_relnums_[shndx].insert(relnum);
                }
            }
        }
    }

  // We no longer need the saved information.
  this->gpsetup_opts_.clear();
}

// Adjust values of the symbols.  Also adjust sizes of the function
// symbols.  This is used in a relaxation passes.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::adjust_symbols(
    Address address,
    unsigned int shndx,
    int count)
{
  Transformable_sections* sections = this->transformable_sections_;

  // If this is called for the first time in this object file, go through
  // the symbol table and add defined symbols to their transformable sections.
  // This is used to speed up symbol adjustment after instruction
  // transformations.
  if (!sections->defined_symbols_initialized)
    {
      this->initialize_defined_symbols(address, shndx, count);
      return;
    }

  typename Transformable_sections::Iterator it =
    sections->sections_map.find(shndx);
  gold_assert(it != sections->sections_map.end());

  // Adjust all symbols that are defined in this section.
  typedef typename Transformable_section::Defined_symbols Defined_symbols;
  Defined_symbols& defined_symbols = it->second.symbols;
  for (typename Defined_symbols::iterator p = defined_symbols.begin();
       p != defined_symbols.end();
       ++p)
    {
      Defined_symbol& symbol = *p;
      Address value = symbol.value();

      // Adjust value of the symbol, if needed.
      if (value >= address)
        symbol.set_value(value + count);

      // Adjust the function symbol's size, if needed.
      if (symbol.is_func(this))
        {
          Size_type symsize = symbol.symsize(this);
          if (value < address
              && value + symsize >= address)
            symbol.set_symsize(this, symsize + count);
        }
    }
}

// Initialize symbols that are defined in a transformable sections, and
// adjust symbols defined in section with index SHNDX.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::initialize_defined_symbols(
    Address address,
    unsigned int shndx,
    int count)
{
  Transformable_sections* sections = this->transformable_sections_;
  gold_assert(!sections->defined_symbols_initialized);
  sections->defined_symbols_initialized = true;

  const unsigned int loccount = this->local_symbol_count();
  typename Sized_relobj_file<size, big_endian>::Local_values* plocal_values =
    this->local_values();
  for (unsigned int i = 1; i < loccount; ++i)
    {
      Symbol_value<size>* lv = &(*plocal_values)[i];
      bool is_ordinary;
      unsigned int sym_shndx = lv->input_shndx(&is_ordinary);

      // Skip non-ordinary and section symbols.
      if (!is_ordinary || lv->is_section_symbol())
        continue;

      // Skip this symbol if it is not defined in a
      // transformable section.
      typename Transformable_sections::Iterator it =
        sections->sections_map.find(sym_shndx);
      if (it == sections->sections_map.end())
        continue;

      // Add this symbol to its transformable section.
      it->second.symbols.push_back(Defined_symbol(lv, i));

      // Don't adjust this symbol if it is not defined in a section
      // that are we currently transforming.
      if (sym_shndx != shndx)
        continue;

      Address value = lv->input_value();

      // Adjust value of the symbol, if needed.
      if (value >= address)
        lv->set_input_value(value + count);

      // Adjust the function symbol's size, if needed.
      if (this->local_symbol_is_function(i))
        {
          Size_type symsize = this->local_symbol_size(i);
          if (value < address
              && value + symsize >= address)
            this->set_local_symbol_size(i, symsize + count);
        }
    }

  Unordered_set<Symbol*> added_syms;
  const Object::Symbols* syms = this->get_global_symbols();
  unsigned int nsyms = syms->size();
  for (unsigned int i = 0; i < nsyms; ++i)
    {
      Sized_symbol<size>* gsym = static_cast<Sized_symbol<size>*>((*syms)[i]);
      if (gsym->source() != Symbol::FROM_OBJECT
          || gsym->object() != this
          || !gsym->is_defined())
        continue;

        bool is_ordinary;
        unsigned int sym_shndx = gsym->shndx(&is_ordinary);

        // Skip non-ordinary symbols.
        if (!is_ordinary)
          continue;

        // Skip this symbol if it is not defined in a transformable
        // section.
        typename Transformable_sections::Iterator it =
          sections->sections_map.find(sym_shndx);
        if (it == sections->sections_map.end())
          continue;

        // Skip this symbol if it is already added to its transformable
        // section.  This can happen for the '--wrap SYMBOL' option where
        // object file contains the definition of a __wrap_SYMBOL and
        // includes a direct call to a SYMBOL.  In this case, both symbols
        // will reference the same symbol (which is __wrap_SYMBOL) and we
        // don't want to adjust __wrap_SYMBOL twice.
        if (added_syms.find(gsym) != added_syms.end())
          continue;

        // Keep track of symbols that are already added.
        added_syms.insert(gsym);

        // Add this symbol to its transformable section.
        it->second.symbols.push_back(Defined_symbol(gsym));

        // Don't adjust this symbol if it is not defined in a section
        // that are we currently transforming.
        if (sym_shndx != shndx)
          continue;

        Address value = gsym->value();

        // Adjust value of the symbol, if needed.
        if (value >= address)
          gsym->set_value(value + count);

        // Adjust the function symbol's size, if needed.
        if (gsym->is_func())
          {
            Size_type symsize = gsym->symsize();
            if (value < address
                && value + symsize >= address)
              gsym->set_symsize(symsize + count);
          }
    }
}

// Initialize sections which we a going to scan for
// instruction transformation.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::initialize_transformable_sections(
    const Symbol_table* symtab)
{
  if (this->transformable_sections_ != NULL)
    return;

  Transformable_sections* sections = new Transformable_sections();
  this->transformable_sections_ = sections;

  unsigned int shnum = this->shnum();
  const unsigned int shdr_size = elfcpp::Elf_sizes<size>::shdr_size;

  // Read the section headers.
  const unsigned char* pshdrs = this->get_view(this->elf_file()->shoff(),
                                               shnum * shdr_size,
                                               true, false);

  const Relobj::Output_sections& osections(this->output_sections());

  // Find transformable sections.
  const unsigned char* p = pshdrs + shdr_size;
  for (unsigned int i = 1; i < shnum; ++i, p += shdr_size)
    {
      const elfcpp::Shdr<size, big_endian> shdr(p);
      if (this->section_needs_reloc_scanning(shdr, osections, symtab, pshdrs))
        {
          unsigned int sh_type = shdr.get_sh_type();
          unsigned int data_shndx = this->adjust_shndx(shdr.get_sh_info());
          Transformable_section section(i, sh_type);
          sections->sections_map.insert(std::make_pair(data_shndx, section));
        }
    }

  if (!sections->sections_map.empty())
    this->input_sections_.resize(shnum);
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
  gold_assert(loccount == symtabshdr.get_sh_info());

  // Read the local symbols.
  const int sym_size = elfcpp::Elf_sizes<size>::sym_size;
  off_t locsize = loccount * sym_size;
  const unsigned char* psyms = this->get_view(symtabshdr.get_sh_offset(),
                                              locsize, true, true);

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

  // Read the symbol names.
  const unsigned int strtab_shndx =
    this->adjust_shndx(symtabshdr.get_sh_link());
  section_size_type strtab_size;
  const unsigned char* pnamesu = this->section_contents(strtab_shndx,
                                                        &strtab_size,
                                                        true);
  const char* pnames = reinterpret_cast<const char*>(pnamesu);
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

  // Skip sections that requires special offset handling.
  if (this->is_output_section_offset_invalid(shndx))
    return false;

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
    const Layout* layout,
    std::vector<Output_relaxed_input_section*>* new_relaxed_sections)
{
  // Don't do anything if this object file is not safe to modify.
  if (!this->safe_to_modify())
    return false;

  const Address invalid_address = static_cast<Address>(0) - 1;
  const bool emit_relocs = (parameters->options().emit_relocs()
                            || parameters->options().relocatable());
  bool again = false;

  this->initialize_transformable_sections(symtab);

  const Relobj::Output_sections& osections(this->output_sections());

  Relocate_info<size, big_endian> relinfo;
  relinfo.symtab = symtab;
  relinfo.layout = layout;
  relinfo.object = this;
  relinfo.rr = NULL;

  // Go through transformable sections and do relocation scanning.
  Transformable_sections* sections = this->transformable_sections_;
  for (typename Transformable_sections::Iterator
       p = sections->sections_map.begin();
       p != sections->sections_map.end();
       ++p)
    {
      Transformable_section& section = p->second;
      unsigned int data_shndx = p->first;
      unsigned int reloc_shndx = section.reloc_shndx;
      unsigned int sh_type = section.sh_type;
      Nanomips_input_section* input_section = this->input_section(data_shndx);
      Output_section* os = osections[data_shndx];
      Address output_address;
      const unsigned char* prelocs;
      const unsigned char* view;
      size_t reloc_count;

      if (input_section == NULL)
        {
          // Get the relocations.
          unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
          section_size_type relocs_size;
          prelocs = this->section_contents(reloc_shndx, &relocs_size, false);
          reloc_count = relocs_size / reloc_size;
          // Get the section contents.  This does work for the case in which
          // we modify the contents of an input section. We need to pass the
          // output view under such circumstances.
          Address output_offset = this->get_output_section_offset(data_shndx);
          gold_assert(output_offset != invalid_address);
          section_size_type view_size;
          view = this->section_contents(data_shndx, &view_size, false);
          output_address = os->address() + output_offset;
        }
      else
        {
          output_address = input_section->address();
          prelocs = input_section->relocs();
          reloc_count = input_section->reloc_count();
          view = input_section->section_contents();
        }

      relinfo.reloc_shndx = reloc_shndx;
      relinfo.data_shndx = data_shndx;
      if (emit_relocs)
        relinfo.rr = this->relocatable_relocs(reloc_shndx);

      again |= target->scan_section_for_transform(&relinfo, sh_type,
                                                  prelocs, reloc_count,
                                                  os, input_section,
                                                  new_relaxed_sections,
                                                  view, output_address);
    }

  return again;
}

// For nanoMIPS target we need to update local symbol size in case they are
// changed during relaxation pass.  This is not the most efficient way but we
// do not want to slow down other ports by calling a per symbol target hook
// inside Sized_relobj_file::do_write_local_symbols.

template<int size, bool big_endian>
void
Nanomips_relobj<size, big_endian>::do_write_local_symbols(
    Output_file* of,
    const Stringpool_template<char>* sympool,
    const Stringpool_template<char>* dynpool,
    Output_symtab_xindex* symtab_xindex,
    Output_symtab_xindex* dynsym_xindex,
    off_t symtab_off)
{
  // Ask parent to write the local symbols.
  Sized_relobj_file<size, big_endian>::do_write_local_symbols(of, sympool,
                                                              dynpool,
                                                              symtab_xindex,
                                                              dynsym_xindex,
                                                              symtab_off);

  // Don't do anything if we didn't change input sections
  // during relaxation pass.
  if (!this->input_sections_changed_)
    return;

  if (parameters->options().strip_all()
      && this->output_local_dynsym_count() == 0)
    return;

  const unsigned int loccount = this->local_symbol_count();
  if (loccount == 0)
    return;

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

  // Get views into the output file for the portions of the symbol table
  // and the dynamic symbol table that we will be writing.
  off_t output_size = this->output_local_symbol_count() * sym_size;
  unsigned char* oview = NULL;
  if (output_size > 0)
    oview = of->get_output_view(symtab_off + this->local_symbol_offset(),
                                output_size);

  off_t dyn_output_size = this->output_local_dynsym_count() * sym_size;
  unsigned char* dyn_oview = NULL;
  if (dyn_output_size > 0)
    dyn_oview = of->get_output_view(this->local_dynsym_offset(),
                                    dyn_output_size);

  const Relobj::Output_sections& out_sections(this->output_sections());
  typename Sized_relobj_file<size, big_endian>::Local_values* plocal_values =
    this->local_values();

  unsigned char* ov = oview;
  unsigned char* dyn_ov = dyn_oview;
  psyms += sym_size;
  for (unsigned int i = 1; i < loccount; ++i, psyms += sym_size)
    {
      elfcpp::Sym<size, big_endian> isym(psyms);
      Symbol_value<size>& lv((*plocal_values)[i]);

      bool is_ordinary;
      unsigned int st_shndx = this->adjust_sym_shndx(i, isym.get_st_shndx(),
                                                     &is_ordinary);
      if (is_ordinary)
        {
          gold_assert(st_shndx < out_sections.size());
          if (out_sections[st_shndx] == NULL)
            continue;
        }

      // Update the size of the symbol in the output symbol table.
      if (lv.has_output_symtab_entry())
        {
          elfcpp::Sym_write<size, big_endian> osym(ov);
          osym.put_st_size(this->local_symbol_size(i));
          ov += sym_size;
        }

      // Update the size of the symbol in the output dynamic symbol table.
      if (lv.has_output_dynsym_entry())
        {
          gold_assert(dyn_ov < dyn_oview + dyn_output_size);

          elfcpp::Sym_write<size, big_endian> osym(dyn_ov);
          osym.put_st_size(this->local_symbol_size(i));
          dyn_ov += sym_size;
        }
    }

  if (output_size > 0)
    {
      gold_assert(ov - oview == output_size);
      of->write_output_view(symtab_off + this->local_symbol_offset(),
                            output_size, oview);
    }

  if (dyn_output_size > 0)
    {
      gold_assert(dyn_ov - dyn_oview == dyn_output_size);
      of->write_output_view(this->local_dynsym_offset(), dyn_output_size,
                            dyn_oview);
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

  // Don't do anything if we didn't expand instructions in this object file.
  if (!parameters->options().expand() || !this->input_sections_changed_)
    return;

  gold_assert(!this->input_sections_.empty());

  // Relocate conditional branches.
  unsigned int shnum = this->shnum();
  for (unsigned int i = 1; i < shnum; ++i)
    {
      Nanomips_input_section* nanomips_input_section = this->input_section(i);

      if (nanomips_input_section == NULL
          || nanomips_input_section->branches()->empty())
        continue;

      typename Sized_relobj_file<size, big_endian>::View_size& view_struct =
        (*pviews)[i];

      // This can only happen if user marked this section as NOLOAD
      // in the linker script, and now this section is NOBITS.
      if (view_struct.view == NULL)
        {
          Output_section* os = this->output_section(i);
          gold_assert(os->type() == elfcpp::SHT_NOBITS);
          continue;
        }

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
      else if (shdr.get_sh_type() == elfcpp::SHT_NANOMIPS_ABIFLAGS)
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

  const unsigned int loccount = this->local_symbol_count();

  // Don't set up vectors if there are no local symbols, or this object
  // is not safe to modify, or we won't transform instructions.
  if (loccount == 0
      || !this->safe_to_modify()
      || (!parameters->options().expand()
          && !parameters->options().relax()))
    return;

  // Initialize vectors.
  this->local_symbol_is_function_.resize(loccount);
  this->local_symbol_size_.resize(loccount);

  // Read the symbol table section header.
  const unsigned int symtab_shndx = this->symtab_shndx();
  const unsigned char *psymtab = pshdrs + symtab_shndx * shdr_size;
  elfcpp::Shdr<size, big_endian> symtabshdr(psymtab);
  gold_assert(symtabshdr.get_sh_type() == elfcpp::SHT_SYMTAB);

  // Read the local symbols.
  const int sym_size = elfcpp::Elf_sizes<size>::sym_size;
  gold_assert(loccount == symtabshdr.get_sh_info());
  off_t locsize = loccount * sym_size;
  const unsigned char* psyms = this->get_view(symtabshdr.get_sh_offset(),
                                              locsize, true, false);

  // Loop over the local symbols and cache information.

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

// Nanomips_output_section_abiflags methods.

template<bool big_endian>
void
Nanomips_output_section_abiflags<big_endian>::do_write(Output_file* of)
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
  ++Nanomips_input_section::section_count;
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
  gold_assert(os != NULL
              && !relobj->is_output_section_offset_invalid(data_shndx));
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

// Write nanoMIPS instruction.

template<int size, bool big_endian>
void
Nanomips_transformations<size, big_endian>::write_insn(
    unsigned char* view,
    uint32_t insn,
    unsigned int insn_size)
{
  if (insn_size == 2)
    Nanomips_insn_swap<16, big_endian>::writeval(view, insn);
  else if (insn_size == 4)
    Nanomips_insn_swap<32, big_endian>::writeval(view, insn);
  else if (insn_size == 6)
    {
      // Write first 16-bit of 48-bit instruction and clear immediate.
      Nanomips_insn_swap<16, big_endian>::writeval(view, insn);
      memset(view + 2, 0, 4);
    }
  else
    gold_unreachable();
}

// Print transformation.

template<int size, bool big_endian>
void
Nanomips_transformations<size, big_endian>::print(
    const Relocate_info<size, big_endian>* relinfo,
    const Nanomips_transform_template* transform_template,
    const std::string& insn_name,
    const Symbol* gsym,
    unsigned int r_sym,
    Address r_offset,
    typename elfcpp::Elf_types<size>::Elf_Swxword r_addend)
{
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const std::string& obj_name = relobj->name();
  const std::string sec_name = relobj->section_name(relinfo->data_shndx);
  const Nanomips_insn_template* insns = transform_template->insns();
  size_t insn_count = transform_template->insn_count();

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
            relobj->local_symbol_name(r_sym, r_addend).c_str(), r_sym);
  else
    fprintf(stderr, " for global symbol '%s'\n", gsym->name());
}

// Find R_NANOMIPS_FILL and R_NANOMIPS_MAX relocations (if any) and get
// fill value, fill size and max bytes generated by the assembler.

template<int size, bool big_endian>
void
Nanomips_transformations<size, big_endian>::find_fill_max(
    Nanomips_relobj<size, big_endian>* relobj,
    Address offset,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs,
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

      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
      if (r_type == elfcpp::R_NANOMIPS_FILL)
        {
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          *fill = psymval->input_value();
          *fill_size = relobj->local_symbol_size(r_sym);
        }
      else if (r_type == elfcpp::R_NANOMIPS_MAX)
        {
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          *max = psymval->input_value();
        }
    }
}

// Handle alignment requirement.

template<int size, bool big_endian>
void
Nanomips_transformations<size, big_endian>::align(
    const Relocate_info<size, big_endian>* relinfo,
    Target_nanomips<size, big_endian>* target,
    Nanomips_input_section* input_section,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs,
    Address view_address)
{
  gold_assert(input_section != NULL);

  // nanoMIPS nop instructions.
  const uint32_t nop32 = 0x8000c000;
  const uint32_t nop16 = 0x9008;

  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  Reltype reloc(prelocs);
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  Address r_offset = reloc.get_r_offset();
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);

  // For R_NANOMIPS_ALIGN relocation, there is a local symbol in which
  // st_value holds the alignment requirement.
  gold_assert(r_sym < relobj->local_symbol_count());
  const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
  Valtype input_value = psymval->input_value();

  Address align = 1 << input_value;
  Address address = view_address + r_offset;
  Address new_address = align_address(address, align);

  // Calculate the padding required due to instruction transformation.
  Address new_padding = new_address - address;
  // Get the existing padding bytes.
  Address old_padding = relobj->local_symbol_size(r_sym);

  Valtype fill = nop16;
  Valtype max = static_cast<Valtype>(0) - 1;
  Size_type fill_size = 2;

  // Find fill value, fill size and max bytes generated by
  // the assembler.
  this->find_fill_max(relobj, r_offset, relnum, reloc_count,
                      prelocs, &fill, &max, &fill_size);

  // Set the padding required due to instruction transformation to 0, if
  // the padding bytes exceed max bytes.
  if (new_padding > max)
    new_padding = 0;

  // If the paddings are the same, don't do anything.
  if (new_padding == old_padding)
    return;

  // If the padding required now is more/less than the existing padding,
  // then add/delete those bytes.
  int count = static_cast<int>(new_padding - old_padding);

  // Check the case where we might end up removing half of a
  // nop[32] instruction.
  if (count < 0 && new_padding >= 2)
    {
      unsigned char* view = (input_section->section_contents()
                             + r_offset + new_padding - 2);
      uint32_t insn = read_nanomips_insn<big_endian>(view, 32);

      // Check if we need to replace nop[32] with nop[16] instruction.
      if (insn == nop32)
        {
          Nanomips_insn_swap<16, big_endian>::writeval(view, nop16);
          gold_debug(DEBUG_TARGET,
                     "%s(%s+%#lx): nop[32] is replaced with nop[16]",
                     relobj->name().c_str(),
                     relobj->section_name(relinfo->data_shndx).c_str(),
                     (unsigned long) (r_offset + new_padding - 2));
        }
    }

  target->update_content(input_section, relobj, r_offset + old_padding,
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
      unsigned char* view = (input_section->section_contents()
                             + r_offset + old_padding);
      for (int j = 0; j < count; view += fill_size, j += fill_size)
        {
          if (fill_size == 1)
            elfcpp::Swap<8, big_endian>::writeval(view, fill);
          else
            this->write_insn(view, fill, fill_size);
        }
    }
}

// Transform instruction.

template<int size, bool big_endian>
inline void
Nanomips_transformations<size, big_endian>::transform(
    const Relocate_info<size, big_endian>* relinfo,
    const Nanomips_transform_template* transform_template,
    const Nanomips_insn_property* insn_property,
    Nanomips_input_section* input_section,
    unsigned int type,
    size_t relnum,
    uint32_t insn)
{
  ++Nanomips_transformations<size, big_endian>::instruction_count;
  gold_assert(transform_template != NULL);
  gold_assert(insn_property != NULL);
  gold_assert(input_section != NULL);

  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  const unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  unsigned char* preloc = input_section->relocs() + relnum * reloc_size;
  Relocatable_relocs* rr = relinfo->rr;

  Reltype reloc(preloc);
  Reltype_write reloc_write(preloc);
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();

  // Extract registers from an input instruction and adjust r_offset
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
      if (insn_property->name()[0] == 'm')
        sreg = insn_property->sreg(insn);
      else
        sreg = treg;
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      treg = insn_property->treg(insn);
      sreg = insn_property->sreg(insn);
      // Check if we need to swap registers.
      if (type == TT_PCREL16)
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
    case elfcpp::R_NANOMIPS_PC10_S1:
      treg = 0;
      sreg = 0;
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
    case elfcpp::R_NANOMIPS_PC7_S1:
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      treg = insn_property->convert_treg(insn);
      sreg = 0;
      break;
    case elfcpp::R_NANOMIPS_PC4_S1:
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
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      treg = insn_property->treg(insn);
      sreg = 0;
      break;
    case elfcpp::R_NANOMIPS_SAVERESTORE:
      // We are removing GP register from save/restore instruction,
      // so we need to decrement count field.
      treg = insn_property->treg(insn) - 1;
      // SREG contains rt and u[11:3] fields.
      sreg = insn_property->sreg(insn);
      break;
    default:
      gold_unreachable();
    }

  // Add conditional branch relocation.  In this case, we are transforming
  // conditional branch into the opposite conditional branch and bc instruction.
  // This cover cases where for bc instruction we need to do expansion.
  if ((r_type == elfcpp::R_NANOMIPS_PC14_S1
       || r_type == elfcpp::R_NANOMIPS_PC11_S1)
      && (type != TT_PCREL16))
    input_section->add_branch_reloc(r_type, r_offset);

  // Discard relocation for TT_DISCARD type.
  if (type == TT_DISCARD)
    {
      reloc_write.put_r_offset(0);
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(0, elfcpp::R_NANOMIPS_NONE));
      reloc_write.put_r_addend(0);
      if (rr != NULL)
        rr->discard_reloc(relnum);
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

          // For 48-bit instructions, r_offset is pointing to the immediate.
          Address new_r_offset = (new_insn_size == 6 ? offset + 2 : offset);
          if (!new_reloc)
            {
              // Change existing relocation, and set that we
              // need to add new relocations.
              reloc_write.put_r_info(
                elfcpp::elf_r_info<size>(r_sym, new_r_type));
              reloc_write.put_r_offset(new_r_offset);
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
              if (rr != NULL)
                rr->set_next_reloc_strategy(rr->strategy(relnum));
            }
        }

      // Write instruction.
      this->write_insn(pov, new_insn, new_insn_size);

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
const Nanomips_insn_property*
Nanomips_relax_insn<size, big_endian>::find_insn(
    Nanomips_relobj<size, big_endian>* relobj,
    uint32_t insn,
    unsigned int mask,
    unsigned int r_type)
{
  // We can't relax 32-bit to 16-bit instructions if
  // --insn32 option is passed.
  if (parameters->options().insn32())
    {
      switch (r_type)
        {
        case elfcpp::R_NANOMIPS_GPREL_I32:
        case elfcpp::R_NANOMIPS_PC_I32:
        case elfcpp::R_NANOMIPS_PC21_S1:
        case elfcpp::R_NANOMIPS_GOT_CALL:
        case elfcpp::R_NANOMIPS_GOT_DISP:
        case elfcpp::R_NANOMIPS_GOT_PAGE:
        case elfcpp::R_NANOMIPS_GOT_OFST:
        case elfcpp::R_NANOMIPS_JALR32:
        case elfcpp::R_NANOMIPS_JALR16:
        case elfcpp::R_NANOMIPS_SAVERESTORE:
          break;
        default:
          return NULL;
        }
    }

  const Nanomips_insn_property* insn_property =
    nanomips_insn_property_table->get_insn_property(insn, mask, r_type);
  if (insn_property == NULL)
    return NULL;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL_I32:
      if (!insn_property->has_transform(TT_GPREL32, r_type)
          && !insn_property->has_transform(TT_GPREL32_WORD, r_type))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_PC_I32:
      if (!insn_property->has_transform(TT_PCREL32, r_type))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_PC25_S1:
      if (!insn_property->has_transform(TT_PCREL16, r_type))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_PC21_S1:
      if (!relobj->pic()
          || !insn_property->has_transform(TT_DISCARD, r_type))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        if (!insn_property->has_transform(TT_PCREL16, r_type)
            || !relobj->nmf()
            || !insn_property->valid_regs(insn))
          return NULL;

        unsigned int treg = insn_property->treg(insn);
        unsigned int sreg = insn_property->sreg(insn);
        const char* name = insn_property->name().c_str();

        // We can't relax beqc to beqc[16] instruction if
        // registers are the same.
        if ((strncmp(name, "beqc", 4) == 0) && (treg == sreg))
          return NULL;
        else
          return insn_property;
      }
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      if (!insn_property->has_transform(TT_GPREL16, r_type)
          || !insn_property->valid_treg(insn))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_LO12:
      if (!parameters->options().relax_lo12()
          || !insn_property->has_transform(TT_ABS16, r_type)
          || !insn_property->valid_regs(insn))
        return NULL;
      else
        return insn_property;
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
    case elfcpp::R_NANOMIPS_SAVERESTORE:
      return insn_property;
    default:
      break;
    }
  return NULL;
}

// Return the type of the relaxation for code and data models.

template<int size, bool big_endian>
unsigned int
Nanomips_relax_insn<size, big_endian>::relax_code_and_data_models(
    const Nanomips_relobj<size, big_endian>* relobj,
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    uint32_t insn,
    Address address,
    Address gp)
{
  const Address invalid_address = static_cast<Address>(0) - 1;
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();
  const bool pid = relobj->pid();
  const bool nmf = relobj->nmf();
  const bool pcrel = relobj->pcrel();
  const bool insn32 = parameters->options().insn32();

  if (gsym != NULL && !is_symbol_locally_resolved(gsym))
    {
      // Relaxations for GOT-dependent addressing.
      switch (r_type)
        {
        case elfcpp::R_NANOMIPS_GOT_CALL:
        case elfcpp::R_NANOMIPS_GOT_DISP:
        case elfcpp::R_NANOMIPS_GOT_PAGE:
        case elfcpp::R_NANOMIPS_JALR32:
        case elfcpp::R_NANOMIPS_JALR16:
          return TT_NONE;
        case elfcpp::R_NANOMIPS_GOT_OFST:
          // Transform into [ls]x[16] and discard relocation
          // or don't do anything.
          // TODO: Allow non-zero addends.
          return ((r_addend == 0) && !insn32 && insn_property->valid_regs(insn)
                  ? TT_DISCARD
                  : TT_NONE);
        default:
          gold_unreachable();
        }
    }
  else
    {
      // Relaxations for locally resolved symbols.
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
                            : relobj->local_symbol_is_function(r_sym));

            if (!is_func && pid && (gp != invalid_address))
              {
                Valtype value = psymval->value(relobj, r_addend) - gp;
                if ((value & 0x3) != 0
                    && !this->template has_overflow_unsigned<18>(value))
                  // Transform into addiu[gp.b].
                  return TT_GPREL32;
                else if ((value & 0x3) == 0
                         && !this->template has_overflow_unsigned<21>(value))
                  // Transform into addiu[gp.w].
                  return TT_GPREL32_WORD;
                else
                  // Transform into addiugp[48] or lui, ori, addu.
                  return nmf ? TT_GPREL_NMF : TT_GPREL_LONG;
              }
            else
              {
                Valtype value = psymval->value(relobj, r_addend) - address - 4;
                if ((value & 0x1) == 0
                    && !this->template has_overflow_signed<22>(value))
                  // Transform into lapc.
                  return TT_PCREL32;
                else if (nmf)
                  // Transform into lapc[48]/li[48].
                  return pcrel ? TT_PCREL_NMF : TT_ABS_NMF;
                else
                  // Transform into aluipc/lui, ori.
                  return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
              }
          }
        case elfcpp::R_NANOMIPS_GOT_OFST:
          {
            if (pid && (gp != invalid_address))
              {
                Valtype value = psymval->value(relobj, r_addend) - gp;
                if (!insn32
                    && insn_property->has_transform(TT_GPREL16, r_type)
                    && insn_property->valid_treg(insn)
                    && !this->template has_overflow_unsigned<9>(value))
                  // Transform into [ls]w[gp][16].
                  return TT_GPREL16;
                else if (insn_property->has_transform(TT_GPREL32, r_type)
                         && !this->template has_overflow_unsigned<18>(value))
                  // Transform into [ls][bh][gp].
                  return TT_GPREL32;
                else if (insn_property->has_transform(TT_GPREL32_WORD, r_type)
                         && !this->template has_overflow_unsigned<21>(value))
                  // Transform into [ls]w[gp].
                  return TT_GPREL32_WORD;
                else if (!nmf)
                  // Transform into lui, addu, [ls]x.
                  return TT_GPREL_LONG;
                else
                  // Transform into addiu[gp48], [ls]x[16]
                  // or addiu[gp48], [ls]x.
                  return (insn_property->valid_regs(insn)
                          ? TT_GPREL_NMF
                          : TT_GPREL32_NMF);
              }
            else if (nmf && insn_property->has_transform(TT_PCREL_NMF, r_type))
              // Transform into [ls]wpc.
              return TT_PCREL_NMF;
            else
              {
                Valtype value = psymval->value(relobj, r_addend) - address - 4;
                if (!insn32
                    && insn_property->valid_regs(insn)
                    && (value & 0x1) == 0
                    && !this->template has_overflow_signed<22>(value))
                  // Transform into lapc, [ls]x[16].
                  return TT_PCREL16_LONG;
                else
                  // Transform into aluipc/lui, [ls]x.
                  return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
              }
          }
        case elfcpp::R_NANOMIPS_JALR32:
          {
            Valtype value = psymval->value(relobj, r_addend) - address - 4;
            if (!this->template has_overflow_signed<26>(value))
              // Transform into balc.
              return TT_PCREL32;
            else
              // Transform into aluipc/lui, ori, jalrc.
              return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
          }
        case elfcpp::R_NANOMIPS_JALR16:
          {
            Valtype value = psymval->value(relobj, r_addend) - address - 2;
            if (!insn32 && !this->template has_overflow_signed<11>(value))
              // Transform into balc[16].
              return TT_PCREL16;
            else if (!this->template has_overflow_signed<26>(value))
              // Transform into balc.
              return TT_PCREL32;
            else if (nmf)
              // Transform into lapc[48]/li[48], jalrc[16].
              return pcrel ? TT_PCREL_NMF : TT_ABS_NMF;
            else
              // Transform into aluipc/lui, ori, jalrc[16].
              return pcrel ? TT_PCREL16_LONG : TT_ABS16_LONG;
          }
        default:
          gold_unreachable();
        }
    }
}

// Return the transformation type if this instruction can be relaxed.

template<int size, bool big_endian>
unsigned int
Nanomips_relax_insn<size, big_endian>::type(
    const Relocate_info<size, big_endian>* relinfo,
    Target_nanomips<size, big_endian>* target,
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
  const Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL_I32:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address)
          return TT_NONE;
        else if ((value & 0x3) != 0
                 && !this->template has_overflow_unsigned<18>(value))
          // Transform into addiu[gp.b].
          return TT_GPREL32;
        else if ((value & 0x3) == 0
                 && !this->template has_overflow_unsigned<21>(value))
          // Transform into addiu[gp.w].
          return TT_GPREL32_WORD;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC_I32:
      {
        // Here, the PC adjustment for 48-bit instructions is 6,
        // because address is pointing to the start of the instruction.
        typedef typename elfcpp::Elf_types<size>::Elf_Swxword Signed_valtype;
        Valtype value = psymval->value(relobj, r_addend) - address - 6;

        // Adjust value if this is a backward branch.
        if (static_cast<Signed_valtype>(value) < 0)
          value += 2;

        if ((value & 0x1) == 0
            && !this->template has_overflow_signed<22>(value))
          // Transform into lapc.
          return TT_PCREL32;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC25_S1:
      {
        typedef typename elfcpp::Elf_types<size>::Elf_Swxword Signed_valtype;
        Valtype value = psymval->value(relobj, r_addend) - address - 4;

        // Adjust value if this is a backward branch.
        if (static_cast<Signed_valtype>(value) < 0)
          value += 2;

        if (!this->template has_overflow_signed<11>(value))
          return TT_PCREL16;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC21_S1:
      {
        // Check whether we need to remove GP-setup instruction.
        if (gsym != NULL
            && gsym == target->gp_sym()
            && relobj->remove_gpsetup_reloc(relinfo->data_shndx, relnum))
          return TT_DISCARD;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (value != 0
            && !this->template has_overflow_unsigned<5>(value))
          return TT_PCREL16;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp != invalid_address
            && !this->template has_overflow_unsigned<9>(value))
          return TT_GPREL16;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_LO12:
      {
        Valtype value = psymval->value(relobj, r_addend) & 0xfff;
        if (((value & 0x3) == 0)
            && !this->template has_overflow_unsigned<6>(value))
          return TT_ABS16;
        else
          return TT_NONE;
      }
    case elfcpp::R_NANOMIPS_SAVERESTORE:
      {
        const Nanomips_symbol<size>* nanomips_sym =
          Nanomips_symbol<size>::as_nanomips_sym(gsym);
        bool is_gp_used = (nanomips_sym == NULL
                           ? relobj->is_gp_used(r_sym)
                           : nanomips_sym->is_gp_used());

        // If gp is not used, transform save[gp]/restore[gp]
        // into save/restore.
        return !is_gp_used ? TT_DISCARD : TT_NONE;
      }
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      return this->relax_code_and_data_models(relobj, gsym, psymval,
                                              insn_property, reloc,
                                              insn, address, gp);
    default:
      gold_unreachable();
    }
  return TT_NONE;
}

// Nanomips_relax_insn_finalize methods.

// Return the transformation type if this instruction can be relaxed
// during --finalize-relocs.

template<int size, bool big_endian>
unsigned int
Nanomips_relax_insn_finalize<size, big_endian>::type(
    const Relocate_info<size, big_endian>* relinfo,
    Target_nanomips<size, big_endian>* target,
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  Relocatable_relocs* rr = relinfo->rr;
  gold_assert(rr != NULL);

  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return TT_NONE;

  return Nanomips_relax_insn<size, big_endian>::type(relinfo, target, gsym,
                                                     psymval, insn_property,
                                                     reloc, relnum, insn,
                                                     address, gp);
}

// Nanomips_expand_insn methods.

// Return matching instruction for expansion if there is one.

template<int size, bool big_endian>
const Nanomips_insn_property*
Nanomips_expand_insn<size, big_endian>::find_insn(
    Nanomips_relobj<size, big_endian>*,
    uint32_t insn,
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
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      return nanomips_insn_property_table->get_insn_property(insn, mask,
                                                             r_type);
    default:
      break;
    }
  return NULL;
}

// Return the type of the expansion for instruction whose
// value is out of the range limits.

template<int size, bool big_endian>
unsigned int
Nanomips_expand_insn<size, big_endian>::expand_type(
    const Nanomips_relobj<size, big_endian>* relobj,
    const Nanomips_insn_property* insn_property,
    uint32_t insn,
    unsigned int r_type)
{
  const bool nmf = relobj->nmf();
  const bool pcrel = relobj->pcrel();
  const bool insn32 = parameters->options().insn32();

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      if (nmf)
        // Transform balc/bc into lapc[48], jalrc[16]/jrc[16]
        // or into into li[48], jalrc[16]/jrc[16].
        return pcrel ? TT_PCREL_NMF : TT_ABS_NMF;
      else if (!pcrel)
        // Transform balc/bc into lui, ori, jalrc/jrc.
        return insn32 ? TT_ABS32_LONG : TT_ABS16_LONG;
      else
        // Transform balc/bc into aluipc, ori, jalrc/jrc.
        return insn32 ? TT_PCREL32_LONG : TT_PCREL16_LONG;
    case elfcpp::R_NANOMIPS_PC21_S1:
      if (insn_property->name()[0] == 'm')
        // Transform move.balc into move[16], balc.
        return TT_PCREL32_LONG;
      else if (nmf)
        // Transform lapc into lapc[48]/li[48].
        return pcrel ? TT_PCREL_NMF : TT_ABS_NMF;
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
      if (insn_property->name()[0] == 'a')
        {
          // Transformations for addiu[gp.w] and addiu[gp.b] instructions.
          if (nmf)
            // Transform into addiu[gp48].
            return TT_GPREL_NMF;
          else if (parameters->options().strict_address_modes())
            // Transform into lui, ori, addu.
            return TT_GPREL_LONG;
          else
            // Transform into aluipc/lui, ori.
            return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
        }
      else
        {
          // Transformations for load and store instructions.
          if (parameters->options().strict_address_modes())
            // Transform into addiu[gp48], [ls]x or lui, addu, [ls]x.
            return nmf ? TT_GPREL32_NMF : TT_GPREL_LONG;
          else if (nmf && insn_property->has_transform(TT_PCREL_NMF, r_type))
            // Transform [ls]w[gp] into [ls]wpc.
            return TT_PCREL_NMF;
          else
            // Transform into aluipc/lui, [ls]x.
            return pcrel ? TT_PCREL32_LONG : TT_ABS32_LONG;
        }
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

// Return the type of the expansion for code and data models.

template<int size, bool big_endian>
unsigned int
Nanomips_expand_insn<size, big_endian>::expand_code_and_data_models(
    Target_nanomips<size, big_endian>* target,
    const Nanomips_relobj<size, big_endian>* relobj,
    const Symbol* gsym,
    const elfcpp::Rela<size, big_endian>& reloc,
    Address gp)
{
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();
  const bool nmf = relobj->nmf();
  unsigned int got_offset;

  if (gsym == NULL)
    got_offset = local_got_offset(target, relobj, r_sym, r_type, r_addend);
  else
    got_offset = global_got_offset(target, gsym, r_type);

  gold_assert(got_offset != -1U);
  Address gp_offset = target->got_section()->gp_offset(got_offset, gp);

  // Expansions for GOT-dependent addressing.
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_LD:
      if (this->template has_overflow_unsigned<21>(gp_offset))
        // Transform into addiu[gp48].
        return TT_GPREL_NMF;
      else
        return TT_NONE;
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      if (this->template has_overflow_unsigned<21>(gp_offset))
        // Transform into lwpc[48].
        return TT_GOTPCREL_NMF;
      else
        return TT_NONE;
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
      if (this->template has_overflow_unsigned<21>(gp_offset))
        // Transform into lwpc[48] or aluipc, lw.
        return nmf ? TT_GOTPCREL_NMF : TT_GOTPCREL_LONG;
      else
        return TT_NONE;
    default:
      gold_unreachable();
    }
}

// Return the transformation type if instruction needs to be expanded.

template<int size, bool big_endian>
unsigned int
Nanomips_expand_insn<size, big_endian>::type(
    const Relocate_info<size, big_endian>* relinfo,
    Target_nanomips<size, big_endian>* target,
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
  const Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template has_overflow_signed<26>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC21_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (((value & 0x1) == 0)
            && !this->template has_overflow_signed<22>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC14_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template has_overflow_signed<15>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC11_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 4;
        if (!this->template has_overflow_signed<12>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template has_overflow_unsigned<21>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template has_overflow_unsigned<18>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC10_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if (!this->template has_overflow_signed<11>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC7_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if (!this->template has_overflow_signed<8>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_PC4_S1:
      {
        Valtype value = psymval->value(relobj, r_addend) - address - 2;
        if ((value != 0)
            && !this->template has_overflow_unsigned<5>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) - gp;
        if (gp == invalid_address
            || !this->template has_overflow_unsigned<9>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_LO4_S2:
      {
        Valtype value = psymval->value(relobj, r_addend) & 0xfff;
        if (((value & 0x3) == 0)
            && !this->template has_overflow_unsigned<6>(value))
          return TT_NONE;
        break;
      }
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      return this->expand_code_and_data_models(target, relobj, gsym, reloc, gp);
    default:
      gold_unreachable();
    }
  return this->expand_type(relobj, insn_property, insn, r_type);
}

// Nanomips_expand_insn_finalize methods.

// Return the transformation type if instruction needs to be expanded
// during --finalize-relocs.

template<int size, bool big_endian>
unsigned int
Nanomips_expand_insn_finalize<size, big_endian>::type(
    const Relocate_info<size, big_endian>* relinfo,
    Target_nanomips<size, big_endian>* target,
    const Symbol* gsym,
    const Symbol_value<size>* psymval,
    const Nanomips_insn_property* insn_property,
    const elfcpp::Rela<size, big_endian>& reloc,
    size_t relnum,
    uint32_t insn,
    Address address,
    Address gp)
{
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  Relocatable_relocs* rr = relinfo->rr;
  gold_assert(rr != NULL);

  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());

  // TODO: Allow code and data model transformations.
  if (r_type == elfcpp::R_NANOMIPS_GOT_CALL
      || r_type == elfcpp::R_NANOMIPS_GOT_DISP
      || r_type == elfcpp::R_NANOMIPS_GOT_PAGE
      || r_type == elfcpp::R_NANOMIPS_TLS_GD
      || r_type == elfcpp::R_NANOMIPS_TLS_LD
      || r_type == elfcpp::R_NANOMIPS_TLS_GOTTPREL)
    return TT_NONE;

  // Expand all non-RELOC_RESOLVE relocations.
  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return this->expand_type(relobj, insn_property, insn, r_type);

  // For RELOC_RESOLVE we need to check if we need to expand instruction.
  unsigned int type =
    Nanomips_expand_insn<size, big_endian>::type(relinfo, target, gsym,
                                                 psymval, insn_property,
                                                 reloc, relnum, insn,
                                                 address, gp);
  if (type == TT_NONE)
    return TT_NONE;

  Relocatable_relocs::Reloc_strategy strategy;

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
      this->stubs_ = new Nanomips_output_data_stubs<size, big_endian>(this,
                                                                      layout);
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

      // First two GOT entries are reserved.  The first entry will be filled at
      // runtime.  The second entry will be used by some runtime loaders.
      this->got_->add_constant(0);
      this->got_->add_constant(this->nanomips_elf_gnu_got1_mask());

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

// Create a GOT entry for the TLS module index.

template<int size, bool big_endian>
unsigned int
Target_nanomips<size, big_endian>::got_mod_index_entry(
    Symbol_table* symtab,
    Layout* layout,
    Sized_relobj_file<size, big_endian>* object)
{
  if (this->got_mod_index_offset_ == -1U)
    {
      gold_assert(symtab != NULL && layout != NULL && object != NULL);
      Nanomips_output_data_got<size, big_endian>* got =
        this->got_section(symtab, layout);
      unsigned int got_offset;
      if (!parameters->doing_static_link())
        {
          got_offset = got->add_constant(0);
          Reloc_section* rel_dyn = this->rel_dyn_section(layout);
          rel_dyn->add_local(object, 0, elfcpp::R_NANOMIPS_TLS_DTPMOD,
                             got, got_offset);
        }
      else
        {
          // We are doing a static link.  Just mark it as belong to module 1,
          // the executable.
          got_offset = got->add_constant(1);
        }

      got->add_constant(0);
      this->got_mod_index_offset_ = got_offset;
    }
  return this->got_mod_index_offset_;
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
  typedef std::vector<Output_relaxed_input_section*> Relaxed_sections;
  typedef Unordered_map<Output_section*, Relaxed_sections>
      Grouped_relaxed_sections;

  // Whether we need to continue with relaxation pass.
  bool again = false;
  // Any newly created relaxed sections are stored here.
  Relaxed_sections new_relaxed_sections;
  // Any newly created relaxed sections grouped by output section.
  Grouped_relaxed_sections grouped_relaxed_sections;

  if (pass == 1)
    {
      // Set transformation state.
      if (parameters->options().relax())
        this->state_ = RELAX;
      else if (parameters->options().expand())
        this->state_ = EXPAND;

      // Go through all input objects and determine for which function
      // we can remove GP register from save/restore instruction and
      // remove GP-setup relocation
      for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
           p != input_objects->relobj_end();
           ++p)
        {
          Nanomips_relobj<size, big_endian>* relobj =
            Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);
          relobj->finalize_gpsetup_optimizations(this, symtab);
        }

      // Sort sections by reference, if any.
      if (parameters->options().any_sort_by_reference())
        {
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

              Nanomips_output_section<size, big_endian>* pnos =
                static_cast<Nanomips_output_section<size, big_endian>*>(os);
              pnos->sort_sections_by_reference(layout);
              again = true;
            }
        }

      if (again)
        return true;
    }

  // This can happen only if we are using relaxation
  // pass to sort sections by reference.
  if (this->state_ == NO_TRANSFORM)
    return false;

  while (1)
    {
      gold_debug(DEBUG_TARGET, "%d pass: %s", pass,
                 (this->state_ == RELAX ? "Relaxations" : "Expansions"));

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
          again |= relobj->scan_sections_for_transform(this, symtab, layout,
                                                       &new_relaxed_sections);
        }

      // Change the state to EXPAND if we are done with relaxations.
      if (!again && (this->state_ == RELAX) && parameters->options().expand())
        this->state_ = EXPAND;
      else
        break;
    }

  for (Relaxed_sections::iterator p = new_relaxed_sections.begin();
       p != new_relaxed_sections.end();
       ++p)
    {
      Nanomips_relobj<size, big_endian>* relobj =
        Nanomips_relobj<size, big_endian>::as_nanomips_relobj((*p)->relobj());
      unsigned int shndx = (*p)->shndx();
      Output_section* os = (*p)->output_section();

      // Tell Nanomips_relobj that this input section is converted.
      relobj->convert_input_section_to_relaxed_section(shndx);
      grouped_relaxed_sections[os].push_back(*p);
    }

  for (Grouped_relaxed_sections::iterator p = grouped_relaxed_sections.begin();
       p != grouped_relaxed_sections.end();
       ++p)
    {
      Output_section* os = p->first;
      Relaxed_sections& relaxed_sections = p->second;

      // Convert input section into relaxed input section in a batch.
      os->convert_input_sections_to_relaxed_sections(relaxed_sections);
    }

  // Clear transformable sections if we are done.
  if (!again)
    {
      for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
           p != input_objects->relobj_end();
           ++p)
        {
          Nanomips_relobj<size, big_endian>* relobj =
            Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);
          relobj->clear_transformable_sections();
        }
    }

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
  typedef Nanomips_relocate_functions<size, big_endian> Reloc_funcs;
  typename Reloc_funcs::Status reloc_status = Reloc_funcs::STATUS_OKAY;

  Valtype value = destination - (address + 4);
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, true);
      break;
    default:
      gold_unreachable();
      break;
    }
  gold_assert(reloc_status == Reloc_funcs::STATUS_OKAY);
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
  // Issue an error if there is a non-PIC object in dynamic link.
  if ((new_flags & elfcpp::EF_NANOMIPS_PIC) == 0
      && !parameters->doing_static_link()
      && !parameters->options().relocatable())
    gold_error(_("%s: non-PIC object found in dynamic link; "
                 "recompile with -fpic"), name.c_str());

  // If flags are not set yet, just copy them.
  if (!this->are_processor_specific_flags_set())
    {
      this->set_processor_specific_flags(new_flags);
      return;
    }

  elfcpp::Elf_Word old_flags = this->processor_specific_flags();
  elfcpp::Elf_Word merged_flags = this->processor_specific_flags();

  if (new_flags == old_flags)
    {
      this->set_processor_specific_flags(merged_flags);
      return;
    }

  if ((new_flags & elfcpp::EF_NANOMIPS_PID) == 0)
    merged_flags &= ~elfcpp::EF_NANOMIPS_PID;

  if ((new_flags & elfcpp::EF_NANOMIPS_PCREL) == 0)
    merged_flags &= ~elfcpp::EF_NANOMIPS_PCREL;

  if ((new_flags & elfcpp::EF_NANOMIPS_LINKRELAX) == 0)
    merged_flags &= ~elfcpp::EF_NANOMIPS_LINKRELAX;

  if ((new_flags & elfcpp::EF_NANOMIPS_PIC) == 0)
    merged_flags &= ~elfcpp::EF_NANOMIPS_PIC;

  new_flags &= ~(elfcpp::EF_NANOMIPS_PID
                 | elfcpp::EF_NANOMIPS_PCREL
                 | elfcpp::EF_NANOMIPS_LINKRELAX
                 | elfcpp::EF_NANOMIPS_PIC);

  old_flags &= ~(elfcpp::EF_NANOMIPS_PID
                 | elfcpp::EF_NANOMIPS_PCREL
                 | elfcpp::EF_NANOMIPS_LINKRELAX
                 | elfcpp::EF_NANOMIPS_PIC);

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

  new_flags &= ~(elfcpp::EF_NANOMIPS_ARCH
                 | elfcpp::EF_NANOMIPS_MACH
                 | elfcpp::EF_NANOMIPS_32BITMODE);

  old_flags &= ~(elfcpp::EF_NANOMIPS_ARCH
                 | elfcpp::EF_NANOMIPS_MACH
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
  // Pointer to the first object file that has .nanoMIPS.abiflags section.
  Nanomips_relobj<size, big_endian>* first_relobj = NULL;

  // Merge processor specific flags.
  for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
       p != input_objects->relobj_end();
       ++p)
    {
      Nanomips_relobj<size, big_endian>* relobj =
        Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);

      if (!relobj->merge_processor_specific_data())
        continue;

      // Record the first object file that has .nanoMIPS.abiflags section.
      if (first_relobj == NULL && relobj->abiflags() != NULL)
        first_relobj = relobj;

      Nanomips_abiflags<big_endian> in_abiflags;

      this->create_abiflags(relobj, &in_abiflags);
      this->merge_obj_e_flags(relobj->name(),
                              relobj->processor_specific_flags());
      this->merge_obj_abiflags(relobj->name(), &in_abiflags);
      this->merge_obj_attributes(relobj->name(),
                                 relobj->attributes_section_data());
    }

  // Clear some processor specific flags.
  if (this->are_processor_specific_flags_set())
    {
      elfcpp::Elf_Word flags = this->processor_specific_flags();
      if (parameters->options().relocatable())
        {
          // Mark this output file as not safe to relax
          // if we are finalizing relocs.
          if (parameters->options().finalize_relocs())
            flags &= ~elfcpp::EF_NANOMIPS_LINKRELAX;
        }
      else
        {
          flags &= ~(elfcpp::EF_NANOMIPS_PID
                     | elfcpp::EF_NANOMIPS_PCREL
                     | elfcpp::EF_NANOMIPS_LINKRELAX);

          // Keep PIC bit only for position independent output.
          if (!parameters->options().output_is_position_independent())
            flags &= ~elfcpp::EF_NANOMIPS_PIC;
        }
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
      Nanomips_output_section_abiflags<big_endian>* abiflags_section =
        new Nanomips_output_section_abiflags<big_endian>(*this->abiflags_);

      // Record the name of the input section and the first object file.
      // This is used for script processing.
      if (first_relobj != NULL)
        {
          abiflags_section->set_relobj(first_relobj);
          abiflags_section->set_section_name(".nanoMIPS.abiflags");
        }

      Output_section* os =
        layout->add_output_section_data(".nanoMIPS.abiflags",
                                        elfcpp::SHT_NANOMIPS_ABIFLAGS,
                                        elfcpp::SHF_ALLOC,
                                        abiflags_section, ORDER_INVALID, false);

      if (!layout->script_options()->saw_phdrs_clause()
          && os != NULL && !parameters->options().relocatable())
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

  // Emit any relocs we saved in an attempt to avoid generating COPY
  // relocs.
  if (this->copy_relocs_.any_saved_relocs())
    this->copy_relocs_.emit(this->rel_dyn_section(layout));

  const Reloc_section* rel_stubs = (this->stubs_ == NULL
                                    ? NULL
                                    : this->stubs_->rel_stubs());
  layout->add_target_dynamic_tags(true, this->got_, rel_stubs,
                                  this->rel_dyn_, true, false);
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
  typedef typename Target_nanomips<size, big_endian>::Relocate_comdat_behavior
    Nanomips_comdat_behavior;

  gold_assert(sh_type == elfcpp::SHT_RELA);

  // See if we are relocating a relaxed input section.  If so, the view
  // covers the whole output section and we need to adjust accordingly.
  if (needs_special_offset_handling)
    {
      const Output_relaxed_input_section* poris =
        output_section->find_relaxed_input_section(relinfo->object,
                                                   relinfo->data_shndx);
      const Nanomips_input_section* input_section =
        Nanomips_input_section::as_nanomips_input_section(poris);

      if (input_section != NULL)
        {
          Address section_address = input_section->address();
          section_size_type section_size = input_section->data_size();

          gold_assert((section_address >= address)
                      && ((section_address + section_size)
                          <= (address + view_size)));

          off_t offset = section_address - address;
          view += offset;
          address += offset;
          view_size = section_size;
          prelocs = input_section->relocs();
          reloc_count = input_section->reloc_count();
        }
    }

  gold::relocate_section<size, big_endian, Nanomips, Nanomips_relocate,
                         Nanomips_comdat_behavior, Classify_reloc>(
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
      const Nanomips_input_section* input_section =
        Nanomips_input_section::as_nanomips_input_section(poris);

      if (input_section != NULL)
        {
          Address section_address = input_section->address();
          section_size_type section_size = input_section->data_size();

          gold_assert((section_address >= view_address)
                      && ((section_address + section_size)
                          <= (view_address + view_size)));

          off_t offset = section_address - view_address;
          view += offset;
          view_address += offset;
          view_size = section_size;
          prelocs = input_section->relocs();
          reloc_count = input_section->reloc_count();
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
  const unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  const unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
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

  // Instruction size in bytes.  The PC adjustment for 48-bit
  // instructions is 4 because the reloc applies to an offset
  // of 2 from the opcode.
  unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
  Valtype value = psymval->value(relobj, r_addend) - (new_offset + insn_size);

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC_I32:
      reloc_status = Reloc_funcs::rel48(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC25_S1:
      reloc_status = Reloc_funcs::relpc25_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC21_S1:
      reloc_status = Reloc_funcs::relpc21_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC10_S1:
      reloc_status = Reloc_funcs::relpc10_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC7_S1:
      reloc_status = Reloc_funcs::relpc7_s1(view, value, true);
      break;
    case elfcpp::R_NANOMIPS_PC4_S1:
      reloc_status = Reloc_funcs::relpc4_s1(view, value, true);
      break;
    default:
      gold_unreachable();
    }

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
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               relobj->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value);
      else if (sym->is_defined() && sym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("unaligned relocation value: "
                                 "%s against '%s' defined in %s: "
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               sym->object()->name().c_str(),
                               (unsigned long long) value);
      else
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("unaligned relocation value: "
                                 "%s against '%s': "
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               sym->demangled_name().c_str(),
                               (unsigned long long) value);
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
    Nanomips_input_section* input_section,
    std::vector<Output_relaxed_input_section*>* new_relaxed_sections,
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
            input_section,
            new_relaxed_sections,
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
            input_section,
            new_relaxed_sections,
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
            input_section,
            new_relaxed_sections,
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
            input_section,
            new_relaxed_sections,
            view,
            view_address);
        }
    }
  else
    gold_unreachable();

  return false;
}

// Update content for instruction transformation.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::update_content(
    Nanomips_input_section* input_section,
    Nanomips_relobj<size, big_endian>* relobj,
    Address address,
    int count,
    bool no_old_padding)
{
  gold_assert(input_section != NULL);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  if (count > 0)
    // Add bytes.
    input_section->add_bytes(address, count);
  else
    // Delete bytes.
    input_section->delete_bytes(address, abs(count));

  size_t reloc_count = input_section->reloc_count();
  unsigned char* prelocs = input_section->relocs();

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
  Conditional_branches* cond_branches = input_section->branches();
  for (size_t i = 0; i < cond_branches->size(); ++i)
    {
      if ((*cond_branches)[i].offset >= address)
        (*cond_branches)[i].offset += count;

      if ((*cond_branches)[i].destination >= address)
        (*cond_branches)[i].destination += count;
    }

  // Adjust the local and global symbols defined in this section.
  relobj->adjust_symbols(address, input_section->shndx(), count);
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
    Nanomips_input_section* input_section,
    std::vector<Output_relaxed_input_section*>* new_relaxed_sections,
    const unsigned char* view,
    Address view_address)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  Relocate_comdat_behavior default_comdat_behavior;

  // Whether we should run relaxation pass again.
  bool again = false;
  // Whether we might have disturbed the alignment required
  // at R_NANOMIPS_ALIGN relocation.
  bool do_align = false;
  // True if we have seen R_NANOMIPS_NORELAX relocation.
  bool seen_norelax = false;

  Comdat_behavior comdat_behavior = CB_UNDETERMINED;
  Address gp = static_cast<Address>(0) - 1;
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const Symbol_table* symtab = relinfo->symtab;
  const unsigned int local_count = relobj->local_symbol_count();
  Nanomips_transform transform;

  if (this->gp_ != NULL)
    {
      // We need to compute the would-be final value of the _gp.
      Symbol_table::Compute_final_value_status status;
      Address value = symtab->compute_final_value<size>(this->gp_, &status);
      if (status == Symbol_table::CFVS_OK)
        gp = value;
    }

  for (size_t i = 0; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      Address r_offset = reloc.get_r_offset();
      typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
        reloc.get_r_addend();

      // If this is a R_NANOMIPS_NORELAX relocation, set that we can't do
      // anything until we see R_NANOMIPS_RELAX.
      if (r_type == elfcpp::R_NANOMIPS_NORELAX)
        {
          seen_norelax = true;
          continue;
        }

      // If this is a R_NANOMIPS_RELAX relocation, set that we can transform
      // following instructions.
      if (r_type == elfcpp::R_NANOMIPS_RELAX)
        {
          seen_norelax = false;
          continue;
        }

      // Don't transform instructions until we see R_NANOMIPS_RELAX.
      if (seen_norelax)
        continue;

      // Align first R_NANOMIPS_ALIGN found after instruction transformation.
      if (r_type == elfcpp::R_NANOMIPS_ALIGN)
        {
          if (do_align)
            {
              transform.align(relinfo, this, input_section, i,
                              reloc_count, prelocs, view_address);
              do_align = false;

              // Update view in case it is changed.
              view = input_section->section_contents();
            }
          continue;
        }

      const Nanomips_reloc_property* reloc_property =
        nanomips_reloc_property_table->get_reloc_property(r_type);
      gold_assert(reloc_property != NULL);

      // Instruction size in bits.
      unsigned int insn_size = reloc_property->size();

      // Skip the placeholder relocations.
      if (insn_size == 0)
        continue;

      // Adjust r_offset for 48-bit instructions.
      if (insn_size == 48)
        r_offset -= 2;

      uint32_t insn = read_nanomips_insn<big_endian>(view + r_offset,
                                                     insn_size);
      const Nanomips_insn_property* insn_property =
        transform.find_insn(relobj, insn, reloc_property->mask(), r_type);

      // If this isn't something that can be transformed, then ignore this
      // relocation.
      if (insn_property == NULL)
        continue;

      // Don't do anything if the length of this instruction is forced to
      // an explicit size.
      if (is_forced_insn_length<size, big_endian>(r_offset, reloc_count,
                                                  i, prelocs))
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
             && !symtab->is_section_folded(relobj, shndx));

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
                                                  symtab);
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
            gsym = symtab->resolve_forwards(gsym);

          // Ignore reference to weak undefined symbols.
          if (gsym->is_weak_undefined())
            continue;

          // We need to compute the would-be final value of this global
          // symbol.
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
          std::string name = relobj->section_name(relinfo->data_shndx);

          if (comdat_behavior == CB_UNDETERMINED)
            comdat_behavior = default_comdat_behavior.get(name.c_str());

          if (comdat_behavior == CB_PRETEND || comdat_behavior == CB_RETAIN)
            {
              // FIXME: This case does not work for global symbols.
              // We have no place to store the original section index.
              // Fortunately this does not matter for comdat sections,
              // only for sections explicitly discarded by a linker
              // script.
              bool found;
              typename elfcpp::Elf_types<size>::Elf_Addr value =
                relobj->map_to_kept_section(shndx, name, &found);
              if (found)
                symval2.set_output_value(value + psymval->input_value());
              else if (comdat_behavior == CB_RETAIN)
                symval2.set_output_value(psymval->input_value());
              else
                symval2.set_output_value(0);
            }
          else if (comdat_behavior == CB_SET_TO_ONE)
            {
              symval2.set_output_value(1);
            }
          else
            {
              if (comdat_behavior == CB_ERROR)
                issue_discarded_error(relinfo, i, r_offset, r_sym, gsym);
              symval2.set_output_value(0);
            }
          psymval = &symval2;
        }

      // Get the type of the transformation.
      Address address = view_address + r_offset;
      unsigned int type = transform.type(relinfo, this, gsym, psymval,
                                         insn_property, reloc, i, insn,
                                         address, gp);
      if (type == TT_NONE)
        continue;

      const Nanomips_transform_template* transform_template =
        insn_property->get_transform(type, r_type);

      // Create a new relaxed input section if needed.
      if (input_section == NULL)
        {
          input_section =
            relobj->new_nanomips_input_section(relinfo->data_shndx,
                                               relinfo->reloc_shndx,
                                               os);
          new_relaxed_sections->push_back(input_section);
        }

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
          this->update_content(input_section, relobj, r_offset + insn_size / 8,
                               count, false);
        }

      // Transform instruction.
      transform.transform(relinfo, transform_template, insn_property,
                          input_section, type, i, insn);

      if (is_debugging_enabled(DEBUG_TARGET))
        transform.print(relinfo, transform_template, insn_property->name(),
                        gsym, r_sym, r_offset, r_addend);

      // Update pointers in case they are changed.
      prelocs = input_section->relocs() + i * reloc_size;
      view = input_section->section_contents();
    }

  if (again)
    {
      gold_assert(input_section != NULL);

      // Update size of the section.
      input_section->reset_data_size();
      input_section->finalize_data_size();

      // Set that section offsets need to be adjusted.
      os->set_section_offsets_need_adjustment();
    }

  return again;
}

// Return true if a reloc is part of a composite relocations.

template<int size, bool big_endian>
inline bool
Target_nanomips<size, big_endian>::Scan::reloc_in_composite_relocs(
    Address offset,
    size_t reloc_count,
    size_t relnum,
    const unsigned char* preloc)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Return true if this and previous relocation have the same offset.
  if (relnum != 0)
    {
      Reltype prev_reloc(preloc - reloc_size);
      if (offset == prev_reloc.get_r_offset())
        return true;
    }

  // Return true if this and next relocation have the same offset.
  if (relnum + 1 < reloc_count)
    {
      Reltype next_reloc(preloc + reloc_size);
      if (offset == next_reloc.get_r_offset())
        return true;
    }

  // Otherwise, return false.
  return false;
}

template<int size, bool big_endian>
inline void
Target_nanomips<size, big_endian>::Scan::local(
    Symbol_table* symtab,
    Layout* layout,
    Target_nanomips<size, big_endian>* target,
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    Output_section* output_section,
    unsigned int,
    const unsigned char* preloc,
    size_t reloc_count,
    size_t relnum,
    const elfcpp::Sym<size, big_endian>& lsym,
    bool is_discarded)
{
  if (is_discarded)
    return;

  const elfcpp::Rela<size, big_endian> reloc(preloc);
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();
  const Nanomips_reloc_property* nrp =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(nrp != NULL);

  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(object);

  // Check if we need to add reference for the input section.
  // This is needed if --sort-by-reference options is passed
  // and we may relax instructions in a relaxation loop,
  // or for --reference-counts option.
  if (r_type == elfcpp::R_NANOMIPS_GPREL19_S2
      && relobj->safe_to_modify()
      && !this->seen_norelax_
      && relobj->output_section(lsym.get_st_shndx()) != NULL)
    {
      unsigned int shndx = lsym.get_st_shndx();
      Output_section* sym_os = relobj->output_section(shndx);
      bool sort_by_reference =
        parameters->options().is_sort_by_reference(sym_os->name());
      bool reference_counts =
        parameters->options().is_reference_counts(sym_os->name());

      if ((sort_by_reference
           && parameters->options().relax()
           && !parameters->options().insn32())
          || reference_counts)
        {
          section_size_type view_size = 0;
          const unsigned char* view = relobj->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          Nanomips_relax_insn<size, big_endian> relax_insn;
          uint32_t insn = read_nanomips_insn<big_endian>(view + r_offset,
                                                         nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find_insn(relobj, insn, nrp->mask(), r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              bool is_ordinary;
              shndx = relobj->adjust_sym_shndx(r_sym, shndx, &is_ordinary);
              bool forced_insn_length =
                is_forced_insn_length<size, big_endian>(r_offset, reloc_count,
                                                        relnum, preloc);
              // Don't add reference to an input section if this instruction
              // is forced to an explicit size.
              if (is_ordinary && !forced_insn_length)
                relobj->add_input_section_ref(shndx);
            }
        }
    }

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_32:
      // If building a shared library (or a position-independent
      // executable), we need to create a dynamic relocation for
      // this location.  The relocation applied at link time will
      // apply the link-time value, so we flag the location with
      // an R_NANOMIPS_RELATIVE relocation so the dynamic loader
      // can relocate it easily.
      if (parameters->options().output_is_position_independent())
        {
          // Don't add dynamic relocation if this reloc is
          // part of a composite relocations.
          if (this->reloc_in_composite_relocs(r_offset, reloc_count,
                                              relnum, preloc))
            break;

          Reloc_section* rel_dyn = target->rel_dyn_section(layout);
          rel_dyn->add_local_relative(relobj, r_sym,
                                      elfcpp::R_NANOMIPS_RELATIVE,
                                      output_section, data_shndx,
                                      r_offset);
        }
      break;
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_DISP:
      // TODO: If building a shared library, create GOT entry if refcount>=2.

      // Don't add a GOT entry for a symbol if this relocation will be
      // transformed in a relaxation loop.
      if (parameters->options().relax()
          && relobj->safe_to_modify()
          && !this->seen_norelax_)
        break;
      // Fall through.

    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      {
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        if (got->add_local(relobj, r_sym, GOT_TYPE_STANDARD, r_addend))
          {
            // If we are generating a shared object (or a position-independent
            // executable), we need to add a dynamic RELATIVE relocation for
            // this symbol's GOT entry.
            if (parameters->options().output_is_position_independent())
              {
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                unsigned int got_offset =
                  relobj->local_got_offset(r_sym, GOT_TYPE_STANDARD, r_addend);
                rel_dyn->add_local_relative(relobj, r_sym,
                                            elfcpp::R_NANOMIPS_RELATIVE,
                                            got, got_offset);
              }
          }
      }
      break;
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
      {
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        if (!relobj->local_has_got_offset(r_sym, GOT_TYPE_TLS_PAIR, r_addend))
          {
            // Add a GOT pair for TLS_GD relocs.  If building a shared library
            // (or a position-independent executable) create a dynamic
            // relocation for module index, otherwise mark it as belong to
            // module 1, the executable.  The second reloc will be applied
            // by gold.
            unsigned int got_offset;
            if (!parameters->options().output_is_position_independent())
              got_offset = got->add_constant(1);
            else
              {
                got_offset = got->add_constant(0);
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                unsigned int tls_type = elfcpp::R_NANOMIPS_TLS_DTPMOD;
                rel_dyn->add_symbolless_local_addend(relobj, r_sym,
                                                     tls_type, got,
                                                     got_offset);
              }
            got->add_local(relobj, r_sym, GOT_TYPE_TLS_PAIR, r_addend);
            relobj->set_local_got_offset(r_sym, GOT_TYPE_TLS_PAIR,
                                         got_offset, r_addend);
          }
      }
      break;
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
      // Create a GOT entry for the module index.
      target->got_mod_index_entry(symtab, layout, relobj);
      break;
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
      {
        layout->set_has_static_tls();
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        if (got->add_local(relobj, r_sym, GOT_TYPE_TLS_OFFSET, r_addend))
          {
            // If building a shared library (or a position-independent
            // executable) create a dynamic relocation.
            if (parameters->options().output_is_position_independent())
              {
                unsigned int tls_type = elfcpp::R_NANOMIPS_TLS_TPREL;
                unsigned int got_type = GOT_TYPE_TLS_OFFSET;
                unsigned int got_offset =
                  relobj->local_got_offset(r_sym, got_type, r_addend);
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                rel_dyn->add_symbolless_local_addend(relobj, r_sym,
                                                     tls_type, got,
                                                     got_offset);
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
    case elfcpp::R_NANOMIPS_INSN32:
    case elfcpp::R_NANOMIPS_FIXED:
      break;
    case elfcpp::R_NANOMIPS_COPY:
    case elfcpp::R_NANOMIPS_GLOBAL:
    case elfcpp::R_NANOMIPS_JUMP_SLOT:
    case elfcpp::R_NANOMIPS_RELATIVE:
      // These are relocations which should only be seen by the
      // dynamic linker, and should never be seen here.
      gold_error(_("%s: unexpected reloc %s in object file"),
                 relobj->name().c_str(), nrp->name().c_str());
      break;
    default:
      break;
    }

  if (parameters->options().relax()
      && relobj->safe_to_modify()
      && relobj->pic())
    {
      switch (r_type)
        {
        case elfcpp::R_NANOMIPS_SAVERESTORE:
          {
            Address value = lsym.get_st_value();
            Nanomips_reloc<size> saveres(r_sym, r_type, r_addend, value);
            relobj->add_saveres_reloc(data_shndx, saveres);
            break;
          }
        case elfcpp::R_NANOMIPS_GOT_CALL:
        case elfcpp::R_NANOMIPS_GOT_PAGE:
        case elfcpp::R_NANOMIPS_GOT_DISP:
        case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
        case elfcpp::R_NANOMIPS_GPREL_I32:
        case elfcpp::R_NANOMIPS_GPREL_HI20:
        case elfcpp::R_NANOMIPS_GPREL19_S2:
        case elfcpp::R_NANOMIPS_GPREL18_S3:
        case elfcpp::R_NANOMIPS_GPREL18:
        case elfcpp::R_NANOMIPS_GPREL17_S1:
        case elfcpp::R_NANOMIPS_GPREL16_S2:
        case elfcpp::R_NANOMIPS_GPREL7_S2:
        case elfcpp::R_NANOMIPS_TLS_GD_I32:
        case elfcpp::R_NANOMIPS_TLS_GD:
        case elfcpp::R_NANOMIPS_TLS_LD_I32:
        case elfcpp::R_NANOMIPS_TLS_LD:
          {
            Nanomips_reloc<size> reloc(r_sym, r_type, r_addend, r_offset);
            relobj->add_gprel_reloc(data_shndx, reloc);
            break;
          }
        default:
          break;
        }
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
    Output_section* output_section,
    unsigned int,
    const unsigned char* preloc,
    size_t reloc_count,
    size_t relnum,
    Symbol* gsym)
{
  const elfcpp::Rela<size, big_endian> reloc(preloc);
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  Address r_offset = reloc.get_r_offset();
  const Nanomips_reloc_property* nrp =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(nrp != NULL);

  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(object);
  Nanomips_symbol<size>* nanomips_sym =
    Nanomips_symbol<size>::as_nanomips_sym(gsym);

  // Check if we need to add reference for the input section.
  // This is needed if --sort-by-reference options is passed
  // and we may relax instructions in a relaxation loop,
  // or for --reference-counts option.
  if (r_type == elfcpp::R_NANOMIPS_GPREL19_S2
      && relobj->safe_to_modify()
      && !this->seen_norelax_
      && gsym->source() == Symbol::FROM_OBJECT
      && gsym->output_section() != NULL)
    {
      Output_section* sym_os = gsym->output_section();
      bool sort_by_reference =
        parameters->options().is_sort_by_reference(sym_os->name());
      bool reference_counts =
        parameters->options().is_reference_counts(sym_os->name());

      if ((sort_by_reference
           && parameters->options().relax()
           && !parameters->options().insn32())
          || reference_counts)
        {
          section_size_type view_size = 0;
          const unsigned char* view = relobj->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          Nanomips_relax_insn<size, big_endian> relax_insn;
          uint32_t insn = read_nanomips_insn<big_endian>(view + r_offset,
                                                         nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find_insn(relobj, insn, nrp->mask(), r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              bool is_ordinary;
              unsigned int sym_shndx = gsym->shndx(&is_ordinary);
              Nanomips_relobj<size, big_endian>* sym_obj =
                static_cast<Nanomips_relobj<size, big_endian>*>(gsym->object());
              bool forced_insn_length =
                is_forced_insn_length<size, big_endian>(r_offset, reloc_count,
                                                        relnum, preloc);
              // Don't add reference to an input section if this instruction
              // is forced to an explicit size.
              if (is_ordinary && !forced_insn_length)
                sym_obj->add_input_section_ref(sym_shndx);
            }
        }
    }

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_32:
      {
        // Make a dynamic relocation if necessary.
        if (gsym->needs_dynamic_reloc(nrp->reference_flags()))
          {
            // Don't add dynamic relocation if this reloc is
            // part of a composite relocations.
            if (this->reloc_in_composite_relocs(r_offset, reloc_count,
                                                relnum, preloc))
              break;

            if (!parameters->options().output_is_position_independent()
                && gsym->may_need_copy_reloc())
              target->copy_reloc(symtab, layout, relobj, data_shndx,
                                 output_section, gsym, reloc);
            else if (gsym->can_use_relative_reloc(false))
              {
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                rel_dyn->add_global_relative(gsym, elfcpp::R_NANOMIPS_RELATIVE,
                                             output_section, relobj,
                                             data_shndx, r_offset);
              }
            else
              {
                Reloc_section* rel_dyn = target->rel_dyn_section(layout);
                rel_dyn->add_global(gsym, r_type, output_section, relobj,
                                    data_shndx, r_offset);
              }
          }
      }
      break;
    case elfcpp::R_NANOMIPS_PC_I32:
    case elfcpp::R_NANOMIPS_PC21_S1:
    case elfcpp::R_NANOMIPS_GPREL_I32:
    case elfcpp::R_NANOMIPS_GPREL19_S2:
    case elfcpp::R_NANOMIPS_GPREL18_S3:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
    case elfcpp::R_NANOMIPS_GPREL16_S2:
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      // Relative addressing relocations.  Skip the reference to the
      // _gp symbol, because it will be set in do_finalize_sections.
      if (strcmp(gsym->name(), "_gp") != 0
          && gsym->needs_dynamic_reloc(nrp->reference_flags()))
        {
          // Make a copy relocation if necessary.
          if (parameters->options().output_is_executable()
              && gsym->may_need_copy_reloc())
            target->copy_reloc(symtab, layout, relobj, data_shndx,
                               output_section, gsym, reloc);
          else
            relobj->error(_("requires unsupported dynamic reloc %s "
                            "against '%s'; recompile with -fPIC"),
                          nrp->name().c_str(), gsym->name());
        }
      break;
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_DISP:
      // TODO: If building a shared library, create GOT entry if refcount>=2.

      // Don't add a GOT entry for a symbol if it is fully resolved,
      // and this relocation will be transformed in a relaxation loop.
      if ((parameters->options().relax()
           && relobj->safe_to_modify()
           && !this->seen_norelax_)
          && is_symbol_locally_resolved(gsym))
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
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
      {
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        if (!gsym->has_got_offset(GOT_TYPE_TLS_PAIR))
          {
            if (!parameters->doing_static_link())
              got->add_global_pair_with_rel(gsym, GOT_TYPE_TLS_PAIR,
                                            target->rel_dyn_section(layout),
                                            elfcpp::R_NANOMIPS_TLS_DTPMOD,
                                            elfcpp::R_NANOMIPS_TLS_DTPREL);
            else
              {
                // Add a GOT pair for for TLS_GD relocs.  This creates a pair of
                // GOT entries.  The first one is initialized to be 1, which is the
                // module index for the main executable and the second one will be
                // applied by gold.
                unsigned int got_offset = got->add_constant(1);
                got->add_global(gsym, GOT_TYPE_TLS_PAIR);
                gsym->set_got_offset(GOT_TYPE_TLS_PAIR, got_offset);
              }
          }
      }
      break;
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
      // Create a GOT entry for the module index.
      target->got_mod_index_entry(symtab, layout, object);
      break;
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
      {
        layout->set_has_static_tls();
        // The symbol requires a GOT entry.
        Nanomips_output_data_got<size, big_endian>* got =
          target->got_section(symtab, layout);
        if (!parameters->doing_static_link())
          got->add_global_with_rel(gsym, GOT_TYPE_TLS_OFFSET,
                                   target->rel_dyn_section(layout),
                                   elfcpp::R_NANOMIPS_TLS_TPREL);
        else
          got->add_global(gsym, GOT_TYPE_TLS_OFFSET);
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
    case elfcpp::R_NANOMIPS_COPY:
    case elfcpp::R_NANOMIPS_GLOBAL:
    case elfcpp::R_NANOMIPS_JUMP_SLOT:
    case elfcpp::R_NANOMIPS_RELATIVE:
      // These are relocations which should only be seen by the
      // dynamic linker, and should never be seen here.
      gold_error(_("%s: unexpected reloc %s in object file"),
                 relobj->name().c_str(), nrp->name().c_str());
      break;
    default:
      break;
    }

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_GOT_LO12:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
    case elfcpp::R_NANOMIPS_SAVERESTORE:
      break;
    default:
      // We must not create a nanoMIPS lazy-binding stub for
      // a symbol that has relocations related to taking the
      // function's address.
      nanomips_sym->set_no_lazy_stub();
      break;
    }

  if (parameters->options().relax()
      && relobj->safe_to_modify()
      && relobj->pic())
    {
      switch (r_type)
        {
        case elfcpp::R_NANOMIPS_SAVERESTORE:
          {
            Address value = nanomips_sym->value();
            Nanomips_reloc<size> saveres(nanomips_sym, r_type, value);
            relobj->add_saveres_reloc(data_shndx, saveres);
            break;
          }
        case elfcpp::R_NANOMIPS_PC21_S1:
          if (strcmp(gsym->name(), "_gp") == 0)
            {
              Nanomips_reloc<size> reloc(nanomips_sym, r_type, r_offset);
              relobj->add_gpsetup_reloc(data_shndx, relnum, reloc);
            }
          break;
        case elfcpp::R_NANOMIPS_GOT_CALL:
        case elfcpp::R_NANOMIPS_GOT_PAGE:
        case elfcpp::R_NANOMIPS_GOT_DISP:
        case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
        case elfcpp::R_NANOMIPS_GPREL_I32:
        case elfcpp::R_NANOMIPS_GPREL_HI20:
        case elfcpp::R_NANOMIPS_GPREL19_S2:
        case elfcpp::R_NANOMIPS_GPREL18_S3:
        case elfcpp::R_NANOMIPS_GPREL18:
        case elfcpp::R_NANOMIPS_GPREL17_S1:
        case elfcpp::R_NANOMIPS_GPREL16_S2:
        case elfcpp::R_NANOMIPS_GPREL7_S2:
        case elfcpp::R_NANOMIPS_TLS_GD_I32:
        case elfcpp::R_NANOMIPS_TLS_GD:
        case elfcpp::R_NANOMIPS_TLS_LD_I32:
        case elfcpp::R_NANOMIPS_TLS_LD:
          {
            Nanomips_reloc<size> reloc(nanomips_sym, r_type, r_offset);
            relobj->add_gprel_reloc(data_shndx, reloc);
            break;
          }
        default:
          break;
        }
    }
}

// Return whether we only need to apply addend for a R_NANOMIPS_32
// relocation.

template<int size, bool big_endian>
inline bool
Target_nanomips<size, big_endian>::Relocate::should_only_apply_addend(
    const Sized_symbol<size>* gsym,
    unsigned int flags,
    bool reloc_in_composite_relocs,
    Output_section* output_section)
{
  // If this reloc is part of a composite relocations, then we didn't
  // create a dynamic reloc, and we must apply the reloc here.
  if (reloc_in_composite_relocs)
    return false;

  // If the output section is not allocated, then we didn't call
  // scan_relocs, we didn't create a dynamic reloc, and we must apply
  // the reloc here.
  if ((output_section->flags() & elfcpp::SHF_ALLOC) == 0)
    return false;

  // For local symbols we always need to apply static relocation.
  if (gsym == NULL)
    return false;

  // For global symbols, we use the same helper routines used in the
  // scan pass.  If we created non-RELATIVE dynamic relocation,
  // we should only apply the addend.
  bool has_dyn = gsym->needs_dynamic_reloc(flags);
  bool is_rel = gsym->can_use_relative_reloc(false);
  return has_dyn && !is_rel;
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
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  unsigned int r_sym = elfcpp::elf_r_sym<size>(reloc.get_r_info());
  unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();

  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  // We are checking these relocations here because we don't want to
  // break support for resolving multiple consecutive relocations.
  // These relocations are handled during relaxation pass.
  if (reloc_property->placeholder())
    return false;

  // r_offset and r_type of the next relocation is needed for resolving
  // multiple consecutive relocations with the same offset.
  Address next_r_offset = static_cast<Address>(0) - 1;
  unsigned int next_r_type = elfcpp::R_NANOMIPS_NONE;

  bool old_calculate_only = this->calculate_only_;
  Nanomips_relobj<size, big_endian>* object =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const Output_relaxed_input_section* poris =
    output_section->find_relaxed_input_section(object, relinfo->data_shndx);

  // TODO: Put reloc_count into Relocate_info.
  // Get the relocation count.
  size_t reloc_count;
  if (poris != NULL)
    {
      // Get the relocation count for the relaxed section.
      const Nanomips_input_section* input_section =
        Nanomips_input_section::as_nanomips_input_section(poris);
      reloc_count = input_section->reloc_count();
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
      next_r_type = elfcpp::elf_r_type<size>(next_reloc.get_r_info());
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
                           && (next_r_type != elfcpp::R_NANOMIPS_NONE)
                           && !next_reloc_property->placeholder());

  unsigned int got_offset;
  if (gsym == NULL)
    got_offset = local_got_offset(target, object, r_sym, r_type, r_addend);
  else
    got_offset = global_got_offset(target, gsym, r_type);

  Valtype value = 0;
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_NONE:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      break;
    case elfcpp::R_NANOMIPS_FRAME_REG:
      value = 0;
      break;
    case elfcpp::R_NANOMIPS_GOT_OFST:
      value = r_addend;
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      gold_assert(got_offset != -1U);
      value = target->got_section()->gp_offset(got_offset, target->gp_value());
      break;
    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
      gold_assert(got_offset != -1U);
      value = target->got_section()->address() + got_offset - (address + 4);
      break;
    case elfcpp::R_NANOMIPS_GOTPC_HI20:
      gold_assert(got_offset != -1U);
      value = (target->got_section()->address() + got_offset
               - ((address + 4) & ~0xfff));
      break;
    case elfcpp::R_NANOMIPS_GOT_LO12:
      gold_assert(got_offset != -1U);
      value = target->got_section()->address() + got_offset;
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
    case elfcpp::R_NANOMIPS_TLS_DTPMOD:
    case elfcpp::R_NANOMIPS_TLS_DTPREL:
    case elfcpp::R_NANOMIPS_TLS_TPREL:
    case elfcpp::R_NANOMIPS_TLS_DTPREL12:
    case elfcpp::R_NANOMIPS_TLS_DTPREL16:
    case elfcpp::R_NANOMIPS_TLS_DTPREL_I32:
    case elfcpp::R_NANOMIPS_TLS_TPREL12:
    case elfcpp::R_NANOMIPS_TLS_TPREL16:
    case elfcpp::R_NANOMIPS_TLS_TPREL_I32:
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
    case elfcpp::R_NANOMIPS_PC_HI20:
      value = psymval->value(object, r_addend) - ((address + 4) & ~0xfff);
      break;
    case elfcpp::R_NANOMIPS_PC32:
      value = psymval->value(object, r_addend) - address;
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
        // Instruction size in bytes.  The PC adjustment for 48-bit
        // instructions is 4 because the reloc applies to an offset
        // of 2 from the opcode.
        unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
        value = psymval->value(object, r_addend) - (address + insn_size);
        break;
      }
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

  // Apply relocation and check for errors.
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_NONE:
    case elfcpp::R_NANOMIPS_JALR32:
    case elfcpp::R_NANOMIPS_JALR16:
      break;
    case elfcpp::R_NANOMIPS_I32:
    case elfcpp::R_NANOMIPS_PC_I32:
    case elfcpp::R_NANOMIPS_GPREL_I32:
    case elfcpp::R_NANOMIPS_GOTPC_I32:
    case elfcpp::R_NANOMIPS_TLS_GD_I32:
    case elfcpp::R_NANOMIPS_TLS_LD_I32:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL_PC_I32:
    case elfcpp::R_NANOMIPS_TLS_TPREL_I32:
    case elfcpp::R_NANOMIPS_TLS_DTPREL_I32:
      reloc_status = Reloc_funcs::rel48(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_32:
      {
        // If we created non-RELATIVE dynamic relocation, we only need to
        // apply addend because dynamic relocation is SHT_REL and static
        // relocation is SHT_RELA.
        unsigned int flags = reloc_property->reference_flags();
        if (this->should_only_apply_addend(gsym, flags, old_calculate_only,
                                           output_section))
          value = r_addend;

        reloc_status = Reloc_funcs::rel32(view, value);
      }
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
      reloc_status = Reloc_funcs::rel12(view, value, false);
      break;
    case elfcpp::R_NANOMIPS_LO4_S2:
      reloc_status = Reloc_funcs::rello4_s2(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_NEG:
    case elfcpp::R_NANOMIPS_ASHIFTR_1:
    case elfcpp::R_NANOMIPS_TLS_DTPMOD:
    case elfcpp::R_NANOMIPS_TLS_DTPREL:
    case elfcpp::R_NANOMIPS_TLS_TPREL:
      reloc_status = Reloc_funcs::relsize(view, value);
      break;
    case elfcpp::R_NANOMIPS_PC32:
      reloc_status = Reloc_funcs::relpc32(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC25_S1:
      reloc_status = Reloc_funcs::relpc25_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC21_S1:
      reloc_status = Reloc_funcs::relpc21_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC14_S1:
      reloc_status = Reloc_funcs::relpc14_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC11_S1:
      reloc_status = Reloc_funcs::relpc11_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC10_S1:
      reloc_status = Reloc_funcs::relpc10_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC7_S1:
      reloc_status = Reloc_funcs::relpc7_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_PC4_S1:
      reloc_status = Reloc_funcs::relpc4_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      reloc_status = Reloc_funcs::relgprel19_s2(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL18_S3:
      reloc_status = Reloc_funcs::relgprel18_s3(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL18:
      reloc_status = Reloc_funcs::relgprel18(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      reloc_status = Reloc_funcs::relgprel17_s1(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL16_S2:
      reloc_status = Reloc_funcs::relgprel16_s2(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      reloc_status = Reloc_funcs::relgprel7_s2(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GOT_DISP:
    case elfcpp::R_NANOMIPS_GOT_PAGE:
    case elfcpp::R_NANOMIPS_GOT_CALL:
    case elfcpp::R_NANOMIPS_TLS_GD:
    case elfcpp::R_NANOMIPS_TLS_LD:
    case elfcpp::R_NANOMIPS_TLS_GOTTPREL:
      reloc_status = Reloc_funcs::relgot(view, value);
      break;
    case elfcpp::R_NANOMIPS_TLS_TPREL16:
    case elfcpp::R_NANOMIPS_TLS_DTPREL16:
      reloc_status = Reloc_funcs::reltls16(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_GOT_OFST:
    case elfcpp::R_NANOMIPS_TLS_TPREL12:
    case elfcpp::R_NANOMIPS_TLS_DTPREL12:
      reloc_status = Reloc_funcs::rel12(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_FRAME_REG:
      {
        reloc_status = Reloc_funcs::STATUS_OKAY;
        if (parameters->options().relax())
          {
            const Nanomips_symbol<size>* nanomips_sym =
              Nanomips_symbol<size>::as_nanomips_sym(gsym);
            bool is_gp_used = (nanomips_sym == NULL
                               ? object->is_gp_used(r_sym)
                               : nanomips_sym->is_gp_used());

            // Zero out byte of memory at r_offset, if GP is not used.
            if (!is_gp_used)
              reloc_status = Reloc_funcs::relframereg(view, value);
          }
        break;
      }
    default:
      gold_error_at_location(relinfo, relnum, r_offset,
                             _("unsupported reloc %s"),
                             reloc_property->name().c_str());
      break;
    }

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
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               object->
                                 local_symbol_name(r_sym, r_addend).c_str(),
                               r_sym, (unsigned long long) value);
      else if (gsym->is_defined() && gsym->source() == Symbol::FROM_OBJECT)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("unaligned relocation value: "
                                 "%s against '%s' defined in %s: "
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               gsym->object()->name().c_str(),
                               (unsigned long long) value);
      else
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("unaligned relocation value: "
                                 "%s against '%s': "
                                 "value %#llx is not aligned"),
                               reloc_property->name().c_str(),
                               gsym->demangled_name().c_str(),
                               (unsigned long long) value);
      break;
    default:
      gold_unreachable();
    }

  return true;
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
  elfcpp::SHT_PROGBITS, // unwind_section_type
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
