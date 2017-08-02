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
#include "script-c.h"
#include "nanomips-reloc-property.h"

namespace
{
using namespace gold;

template<int size, bool big_endian>
class Target_nanomips;

template<int size, bool big_endian>
class Nanomips_output_section_reginfo;

template<int size, bool big_endian>
class Nanomips_relobj;

template<int size, bool big_endian>
class Nanomips_relocate_functions;

class Nanomips_input_section;

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

// Utility class dealing with instructions, and it is used during
// relaxation pass.

template<bool big_endian>
class Nanomips_insn_utilities
{
 public:
  // Read nanoMIPS instruction.
  static inline uint32_t
  read_insn(const unsigned char* view, unsigned int size)
  {
    if (size == 16)
      return elfcpp::Swap<16, big_endian>::readval(view);
    else if (size == 32)
      {
        typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
        Valtype16 first = elfcpp::Swap<16, big_endian>::readval(view);
        Valtype16 second = elfcpp::Swap<16, big_endian>::readval(view + 2);
        return (first << 16 | second);
      }
    else if (size == 48 || size == 0)
     return 0;
    else
      gold_unreachable();

    return 0;
  }

  // Write nanoMIPS 32-bit instruction.
  static inline void
  put_insn_32(unsigned char* view, uint32_t insn)
  {
    elfcpp::Swap<16, big_endian>::writeval(view, (insn >> 16) & 0xffff);
    elfcpp::Swap<16, big_endian>::writeval(view + 2, insn & 0xffff);
  }

  // Return target register in nanoMIPS 32-bit instruction.
  static inline unsigned int
  treg_32(uint32_t insn)
  { return ((insn >> 21) & 0x1f); }

  // Return source register in nanoMIPS 32-bit instruction.
  static inline unsigned int
  sreg_32(uint32_t insn)
  { return ((insn >> 16) & 0x1f); }

  // Return target register in nanoMIPS 16-bit instruction.
  static inline unsigned int
  treg_16(uint32_t insn)
  { return ((insn >> 7) & 0x7); }

  // Return source register in nanoMIPS 16-bit instruction.
  static inline unsigned int
  sreg_16(uint32_t insn)
  { return ((insn >> 4) & 0x7); }

  // Convert register in 16bit instruction to register in 32 bit instruction.
  static inline unsigned int
  reg_16_to_32(unsigned int reg)
  { return ((reg <= 3) ? reg + 16 : reg); }

  // Convert register in 16bit store instruction to register in 32 bit
  // store instruction.
  static inline unsigned int
  reg_16_to_32_st(unsigned int reg)
  { return  ((1 <= reg && reg <= 3) ? reg + 16 : reg); }

  // Check if a 5-bit register index can be abbreviated to 3 bits.
  static inline bool
  valid_reg_16(unsigned int reg)
  { return ((4 <= reg && reg <= 7) || (16 <= reg && reg <= 19)); }

  // Check if a 5-bit register index can be abbreviated to 3 bits for
  // store instruction.
  static inline bool
  valid_reg_16_st(unsigned int reg)
  { return (reg == 0 || (4 <= reg && reg <= 7) || (17 <= reg && reg <= 19)); }
};

// .MIPS.abiflags section content

template<bool big_endian>
struct Mips_abiflags
{
  typedef typename elfcpp::Swap<8, big_endian>::Valtype Valtype8;
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;

  Mips_abiflags()
    : version(0), isa_level(0), isa_rev(0), gpr_size(0), cpr1_size(0),
      cpr2_size(0), fp_abi(0), isa_ext(0), ases(0), flags1(0), flags2(0)
  { }

  // Version of flags structure.
  Valtype16 version;
  // The level of the ISA: 1-5, 32, 64.
  Valtype8 isa_level;
  // The revision of ISA: 0 for MIPS V and below, 1-n otherwise.
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

// .reginfo section content

template<int size, bool big_endian>
struct Mips_reginfo
{
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;

  Mips_reginfo()
    : gprmask(0), cprmask1(0), cprmask2(0), cprmask3(0), cprmask4(0), gp(0)
  { }

  // gprmask from the .reginfo section of this object.
  Valtype gprmask;
  // cprmask1 from the .reginfo section of this object.
  Valtype cprmask1;
  // cprmask2 from the .reginfo section of this object.
  Valtype cprmask2;
  // cprmask3 from the .reginfo section of this object.
  Valtype cprmask3;
  // cprmask4 from the .reginfo section of this object.
  Valtype cprmask4;
  // gp value that was used to create this object.
  Valtype gp;
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
      input_section_ref_(), local_symbol_size_(), processor_specific_flags_(0),
      merge_processor_specific_data_(true), attributes_section_data_(NULL),
      abiflags_(NULL), reginfo_(NULL)
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

  // Scan all relocation sections for relaxations or expansions.
  bool
  scan_sections_for_relax_or_expand(Target_nanomips<size, big_endian>*,
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

  // Increase the input section reference.
  void
  add_input_section_ref(unsigned int shndx)
  {
    // In order to replace maximum number of lw[gp]/sw[gp] instructions with
    // lw[gp16]/sw[gp16],increase the input section reference only for 4 byte
    // size sections.  We are relying that user passed -fdata-sections option
    // to compiler.
    if (this->section_size(shndx) == 4)
      ++this->input_section_ref_[shndx];
  }

  // Return the number of how many times section has been referenced with
  // the lw[gp]/sw[gp] instruction.
  unsigned int
  input_section_ref(unsigned int shndx) const
  {
    typename Input_section_ref::const_iterator it =
      this->input_section_ref_.find(shndx);
    if (it != this->input_section_ref_.end())
      return it->second;
    return 0;
  }

  // Return whether we want to merge processor-specific data.
  bool
  merge_processor_specific_data() const
  { return this->merge_processor_specific_data_; }

  // This is the contents of the .MIPS.abiflags section if there is one.
  Mips_abiflags<big_endian>*
  abiflags()
  { return this->abiflags_; }

  // This is the contents of the .gnu.attribute section if there is one.
  const Attributes_section_data*
  attributes_section_data() const
  { return this->attributes_section_data_; }

  // This is the contents of the .reginfo section if there is one.
  Mips_reginfo<size, big_endian>*
  reginfo()
  { return this->reginfo_;}

 protected:
  // Count the local symbols.
  void
  do_count_local_symbols(Stringpool_template<char>*,
                         Stringpool_template<char>*);

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

  // Whether a section is a scannable for relaxations or expansions.
  bool
  section_is_scannable(const elfcpp::Shdr<size, big_endian>&, unsigned int,
                       const Output_section*, const Symbol_table*);

  // A map to track the number of how many times input section has ref
  // read with lw[gp]/sw[gp] instruction.
  Input_section_ref input_section_ref_;

  // Size of the local symbols.
  std::vector<Size_type> local_symbol_size_;

  // processor-specific flags in ELF file header.
  elfcpp::Elf_Word processor_specific_flags_;

  // Whether we merge processor-specific data of this object to output.
  bool merge_processor_specific_data_;

  // Object attributes if there is a .gnu.attributes section or NULL.
  Attributes_section_data* attributes_section_data_;

  // Object abiflags if there is a .MIPS.abiflags section or NULL.
  Mips_abiflags<big_endian>* abiflags_;

  // Contents of .reginfo section or NULL.
  Mips_reginfo<size, big_endian>* reginfo_;
};

// A class to wrap an ordinary input section.

class Nanomips_input_section : public Output_relaxed_input_section
{
 public:
  Nanomips_input_section(Relobj* relobj, unsigned int shndx,
                         Output_section* os, unsigned int reloc_size)
    : Output_relaxed_input_section(relobj, shndx, 1),
      addralign_(1), contents_(), relocs_(), reloc_size_(reloc_size)
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

  // Delete the bytes for relaxation or for alignment required at
  // R_NANOMIPS_ALIGN relocation.
  void
  delete_bytes(size_t pos, size_t size)
  {
    memmove(this->contents_.data + pos, this->contents_.data + pos + size,
            (this->contents_.len - pos - size));
    this->contents_.len -= size;
  }

  // Add the bytes for expansion or for alignment required at
  // R_NANOMIPS_ALIGN relocation.
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

  // Downcast a base pointer to a Mips_input_section pointer.  This is
  // not type-safe but we only use Mips_input_section not the base class.
  static const Nanomips_input_section*
  as_nanomips_input_section(const Output_relaxed_input_section* poris)
  { return static_cast<const Nanomips_input_section*>(poris); }

  // Downcast a base pointer to a Mips_input_section pointer.  This is
  // not type-safe but we only use Mips_input_section not the base class.
  static Nanomips_input_section*
  as_nanomips_input_section(Output_relaxed_input_section* poris)
  { return static_cast<Nanomips_input_section*>(poris); }

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
  // Contents of the text section.
  Section_contents contents_;
  // The relocations for this section.
  Section_contents relocs_;
  // The size of the one reloc in the relocation section.
  unsigned int reloc_size_;
};

// The class which implements relaxations.

template<int size, bool big_endian>
class Relax_nanomips_insn
{
  typedef Nanomips_insn_utilities<big_endian> Insn_utilities;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Relax_nanomips_insn()
  { }

  // Return matching instruction for relaxation if there is one and INSN can
  // be relaxed, otherwise return NULL.
  inline const Nanomips_insn_property*
  find(uint32_t insn,
       unsigned int r_type);

  // Return true if instruction is not marked with R_NANOMIPS_INSN32 or
  // R_NANOMIPS_FIXED relocations.
  inline bool
  can_be_changed(Address offset,
                 size_t relnum,
                 size_t reloc_count,
                 const unsigned char* prelocs);

  // Set *PINSN_PROPERTY to the correct instruction property.  This is not used
  // for relaxations.
  inline void
  find_property(uint32_t,
                const Nanomips_insn_property**,
                unsigned int)
  { }

  // Check the range of the relocation and return true if we can relax
  // instruction.
  inline bool
  check_range(Valtype value,
              unsigned int r_type);

  // Check the range of the relocation and return whether we can relax
  // instruction during relocatable link and --finalize-relocs is passed.
  inline bool
  relocatable_check_range(Valtype value,
                          unsigned int r_type,
                          size_t relnum,
                          const Relocate_info<size, big_endian>* relinfo,
                          const Symbol_value<size>*,
                          unsigned int,
                          bool);

  // Relax instruction.  We are not adding new relocations, so always return
  // false.
  inline bool
  change(uint32_t insn,
         const Nanomips_insn_property* insn_property,
         unsigned char* view,
         unsigned char* preloc,
         unsigned char*);

  // For debugging purposes.
  inline void
  print(const std::string& obj_name, const std::string& sec_name,
        unsigned long r_offset, const Nanomips_insn_property* pnip)
  {
    fprintf(stderr, "%s(%s+%#lx): %s is relaxed to %s\n",
            obj_name.c_str(), sec_name.c_str(), r_offset,
            pnip->name(), pnip->insn_name(0));
  }

 private:
  // Check relocation value for relaxations.
  template<int valsize>
  inline bool
  check_value(Valtype value, Overflow_check check)
  {
    switch (check)
      {
      case CHECK_SIGNED:
        return (size == 32 ? !Bits<valsize>::has_overflow32(value)
                           : !Bits<valsize>::has_overflow(value));
      case CHECK_UNSIGNED:
        return (size == 32 ? !Bits<valsize>::has_unsigned_overflow32(value)
                           : !Bits<valsize>::has_unsigned_overflow(value));
      default:
        gold_unreachable();
      }
  }
};

// The class which implements expansions.

template<int size, bool big_endian>
class Expand_nanomips_insn
{
  typedef Nanomips_insn_utilities<big_endian> Insn_utilities;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Swap<16, big_endian>::Valtype Valtype16;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;

 public:
  Expand_nanomips_insn()
  { this->expand_reg_ = parameters->options().expand_reg(); }

  // Return matching instructions for expansion if we have found them.
  inline const Nanomips_insn_property*
  find(uint32_t insn,
       unsigned int r_type);

  // Return true if instruction is not marked with R_NANOMIPS_FIXED relocation.
  inline bool
  can_be_changed(Address offset,
                 size_t relnum,
                 size_t reloc_count,
                 const unsigned char* prelocs);

  // Set *PINSN_PROPERTY to the correct instruction property.  This is only used
  // for beqc16 and bnec16 instructions for now, where we can't distinguish
  // them through the opcode.
  inline void
  find_property(uint32_t insn,
                const Nanomips_insn_property** pinsn_property,
                unsigned int r_type);

  // Check the range of the relocation and return true if we must expand
  // instruction.
  inline bool
  check_range(Valtype value,
              unsigned int r_type);

  // Check the range of the relocation and return true if we must expand
  // instruction during relocatable link and --finalize-relocs is passed.
  inline bool
  relocatable_check_range(Valtype value,
                          unsigned int r_type,
                          size_t relnum,
                          const Relocate_info<size, big_endian>* relinfo,
                          const Symbol_value<size>* psymval,
                          unsigned int r_sym,
                          bool global);

  // Expand instruction.  Return true if we have add new relocation.
  inline bool
  change(uint32_t insn,
         const Nanomips_insn_property* insn_property,
         unsigned char* view,
         unsigned char* preloc,
         unsigned char* preloc_new);

  // For debugging purposes.
  inline void
  print(const std::string& obj_name, const std::string& sec_name,
        unsigned long r_offset, const Nanomips_insn_property* pnip)
  {
    fprintf(stderr, "%s(%s+%#lx): %s is expanded to ",
            obj_name.c_str(), sec_name.c_str(), r_offset,
            pnip->name());

    bool need_comma = false;
    for (size_t i = 0; i < pnip->insn_num(); ++i)
      {
        if (need_comma)
          fprintf(stderr, ", ");
        fprintf(stderr, "%s", pnip->insn_name(i));
        need_comma = true;
      }
    fprintf(stderr, "\n");
  }

 private:
  // Check relocation value for expansions.
  template<int valsize>
  inline bool
  check_value(Valtype value, Overflow_check check)
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
  // Register that is used in expansions.
  unsigned int expand_reg_;
};

// This class handles Nanomips .reginfo output section.

template<int size, bool big_endian>
class Nanomips_output_section_reginfo : public Output_section_data
{
 public:
  Nanomips_output_section_reginfo(Target_nanomips<size, big_endian>* target,
                                  const Mips_reginfo<size, big_endian>& reginfo)
    : Output_section_data(24, 4, true), target_(target), reginfo_(reginfo)
  { }

 protected:
  // Write to a map file.
  void
  do_print_to_mapfile(Mapfile* mapfile) const
  { mapfile->print_output_data(this, _(".reginfo")); }

  // Write out reginfo section.
  void
  do_write(Output_file* of);

 private:
  Target_nanomips<size, big_endian>* target_;
  const Mips_reginfo<size, big_endian>& reginfo_;
};

// This class handles .MIPS.abiflags output section.

template<int size, bool big_endian>
class Nanomips_output_section_abiflags : public Output_section_data
{
 public:
  Nanomips_output_section_abiflags(const Mips_abiflags<big_endian>& abiflags)
    : Output_section_data(24, 8, true), abiflags_(abiflags)
  { }

 protected:
  // Write to a map file.
  void
  do_print_to_mapfile(Mapfile* mapfile) const
  { mapfile->print_output_data(this, _(".MIPS.abiflags")); }

  void
  do_write(Output_file* of);

 private:
  const Mips_abiflags<big_endian>& abiflags_;
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
  typedef Nanomips_insn_utilities<big_endian> Insn_utilities;
  typedef typename elfcpp::Elf_types<size>::Elf_Addr Address;
  typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype32;
  typedef typename elfcpp::Swap<size, big_endian>::Valtype Valtype;
  typedef typename elfcpp::Elf_types<size>::Elf_WXword Size_type;

 public:
  Target_nanomips(const Target::Target_info* info = &nanomips_info)
    : Sized_target<size, big_endian>(info), state_(EXPAND), gp_(NULL),
      mips_mach_extensions_(), attributes_section_data_(NULL), abiflags_(NULL),
      reginfo_(NULL), mach_(0), layout_(NULL), has_abiflags_section_(false)
  {
    this->add_machine_extensions();
  }

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

  // We don't want to do expansions or relaxations if we are doing
  // relocatable linking and --finalize-relocs is not passed.
  bool
  do_may_relax() const
  {
    return (!parameters->options().relocatable()
            || parameters->options().finalize_relocs());
  }

  // Relaxation hook.  This is where we do relaxations and expansions of
  // nanoMIPS instructions.
  bool
  do_relax(int, const Input_objects*, Symbol_table*, Layout*, const Task*);

  // This is called when keyword SORT_BY_READ is found in the linker script.
  void
  do_sort_input_sections(int, std::vector<Input_section_info>*) const;

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

  // Scan a section for relaxations or expansions.
  bool
  scan_section_for_relax_or_expand(const Relocate_info<size, big_endian>*
                                     relinfo,
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

  // Don't emit input .reginfo/.MIPS.abiflags sections to
  // output .reginfo/.MIPS.abiflags.
  bool
  do_should_include_section(elfcpp::Elf_Word sh_type) const
  {
    return ((sh_type != elfcpp::SHT_MIPS_REGINFO)
             && (sh_type != elfcpp::SHT_MIPS_ABIFLAGS));
  }

 protected:
  void
  do_select_as_default_target()
  {
    // Set the state to RELAX if a -relax option is passed.
    if (parameters->options().relax())
      this->state_ = RELAX;

    gold_assert(nanomips_reloc_property_table == NULL);
    nanomips_reloc_property_table = new Nanomips_reloc_property_table();
  }

  // do_make_elf_object to override the same function in the base class.
  Object*
  do_make_elf_object(const std::string&, Input_file*, off_t,
                     const elfcpp::Ehdr<size, big_endian>&);

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
          unsigned int data_shndx,
          Output_section* output_section,
          const elfcpp::Rela<size, big_endian>& reloc, unsigned int r_type,
          const elfcpp::Sym<size, big_endian>& lsym,
          bool is_discarded);

    inline void
    global(Symbol_table* symtab, Layout* layout, Target_nanomips* target,
           Sized_relobj_file<size, big_endian>* object,
           unsigned int data_shndx,
           Output_section* output_section,
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

    // Offset to check if that relocation is marked with INSN32
    // or FIXED relocation.
    Address ref_r_offset_;
    // Object where we want to add reference.
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

  // Check whether the given ELF header flags describe a 32-bit binary.
  bool
  mips_32bit_flags(elfcpp::Elf_Word);

  enum Mips_mach {
    mach_mips3000             = 3000,
    mach_mips3900             = 3900,
    mach_mips4000             = 4000,
    mach_mips4010             = 4010,
    mach_mips4100             = 4100,
    mach_mips4111             = 4111,
    mach_mips4120             = 4120,
    mach_mips4300             = 4300,
    mach_mips4400             = 4400,
    mach_mips4600             = 4600,
    mach_mips4650             = 4650,
    mach_mips5000             = 5000,
    mach_mips5400             = 5400,
    mach_mips5500             = 5500,
    mach_mips5900             = 5900,
    mach_mips6000             = 6000,
    mach_mips7000             = 7000,
    mach_mips8000             = 8000,
    mach_mips9000             = 9000,
    mach_mips10000            = 10000,
    mach_mips12000            = 12000,
    mach_mips14000            = 14000,
    mach_mips16000            = 16000,
    mach_mips16               = 16,
    mach_mips5                = 5,
    mach_mips_loongson_2e     = 3001,
    mach_mips_loongson_2f     = 3002,
    mach_mips_loongson_3a     = 3003,
    mach_mips_sb1             = 12310201, // octal 'SB', 01
    mach_mips_octeon          = 6501,
    mach_mips_octeonp         = 6601,
    mach_mips_octeon2         = 6502,
    mach_mips_octeon3         = 6503,
    mach_mips_xlr             = 887682,   // decimal 'XLR'
    mach_mipsisa32            = 32,
    mach_mipsisa32r2          = 33,
    mach_mipsisa32r3          = 34,
    mach_mipsisa32r5          = 36,
    mach_mipsisa32r6          = 37,
    mach_nanomipsisa32r6      = 38,
    mach_mipsisa64            = 64,
    mach_mipsisa64r2          = 65,
    mach_mipsisa64r3          = 66,
    mach_mipsisa64r5          = 68,
    mach_mipsisa64r6          = 69,
    mach_nanomipsisa64r6      = 70,
    mach_mips_micromips       = 96
  };

  // Find R_NANOMIPS_FILL and R_NANOMIPS_MAX relocations (if any) and get
  // fill value, fill size and max bytes generated by the assembler.
  void
  find_fill_max(Address, size_t, size_t, const unsigned char*,
                Nanomips_relobj<size, big_endian>*, Valtype*, Valtype*,
                Size_type*);

  // Scan a relocation section for relaxations or expansions.
  template <typename Nanomips_insn>
  bool
  scan_reloc_section_for_relax_or_expand(const Relocate_info<size, big_endian>*,
                                         const unsigned char*, size_t,
                                         Output_section*,
                                         Nanomips_input_section*,
                                         const unsigned char*,
                                         Address);

  // Make a new Nanomips_input_section object.
  Nanomips_input_section*
  new_nanomips_input_section(Nanomips_relobj<size, big_endian>*,
                             const Relocate_info<size, big_endian>*,
                             Output_section*);

  // Update content for relaxations or expansions.
  void
  update_content(Nanomips_input_section*, Nanomips_relobj<size, big_endian>*,
                 Address, int, bool, bool);

  // Return the MACH for a MIPS e_flags value.
  unsigned int
  elf_mips_mach(elfcpp::Elf_Word);

  // Return the MACH for each .MIPS.abiflags ISA Extension.
  unsigned int
  mips_isa_ext_mach(unsigned int);

  // Return the .MIPS.abiflags value representing each ISA Extension.
  unsigned int
  mips_isa_ext(unsigned int);

  // Update the isa_level, isa_rev, isa_ext fields of abiflags.
  void
  update_abiflags_isa(const std::string&, elfcpp::Elf_Word,
                      Mips_abiflags<big_endian>*);

  // Infer the content of the ABI flags based on the elf header.
  void
  infer_abiflags(Nanomips_relobj<size, big_endian>*,
                 Mips_abiflags<big_endian>*);

  // Create abiflags from elf header or from .MIPS.abiflags section.
  void
  create_abiflags(Nanomips_relobj<size, big_endian>*,
                  Mips_abiflags<big_endian>*);

  // Return the meaning of fp_abi, or "unknown" if not known.
  const char*
  fp_abi_string(int);

  // Select fp_abi.
  int
  select_fp_abi(const std::string&, int, int);

  // Merge attributes from input object.
  void
  merge_obj_attributes(const std::string&, const Attributes_section_data*);

  // Merge abiflags from input object.
  void
  merge_obj_abiflags(const std::string&, Mips_abiflags<big_endian>*);

  // Check whether machine EXTENSION is an extension of machine BASE.
  bool
  mips_mach_extends(unsigned int, unsigned int);

  // Merge file header flags from input object.
  void
  merge_obj_e_flags(const std::string&, elfcpp::Elf_Word);

  // Merge reginfo from input object.
  void
  merge_obj_reginfo(Mips_reginfo<size, big_endian>*);

  // Encode ISA level and revision as a single value.
  int
  level_rev(unsigned char isa_level, unsigned char isa_rev) const
  { return (isa_level << 3) | isa_rev; }

  // Calculate value of _gp symbol.
  void
  set_gp(Layout*, Symbol_table*);

  const char*
  elf_mips_abi_name(elfcpp::Elf_Word e_flags);
  const char*
  elf_mips_mach_name(elfcpp::Elf_Word e_flags);

  // Adds entries that describe how machines relate to one another.  The entries
  // are ordered topologically with MIPS I extensions listed last.  First
  // element is extension, second element is base.
  void
  add_machine_extensions()
  {
    // MIPS64r2 extensions.
    this->add_extension(mach_mips_octeon3, mach_mips_octeon2);
    this->add_extension(mach_mips_octeon2, mach_mips_octeonp);
    this->add_extension(mach_mips_octeonp, mach_mips_octeon);
    this->add_extension(mach_mips_octeon, mach_mipsisa64r2);
    this->add_extension(mach_mips_loongson_3a, mach_mipsisa64r2);

    // MIPS64 extensions.
    this->add_extension(mach_mipsisa64r2, mach_mipsisa64);
    this->add_extension(mach_mips_sb1, mach_mipsisa64);
    this->add_extension(mach_mips_xlr, mach_mipsisa64);

    // MIPS V extensions.
    this->add_extension(mach_mipsisa64, mach_mips5);

    // R10000 extensions.
    this->add_extension(mach_mips12000, mach_mips10000);
    this->add_extension(mach_mips14000, mach_mips10000);
    this->add_extension(mach_mips16000, mach_mips10000);

    // R5000 extensions.  Note: the vr5500 ISA is an extension of the core
    // vr5400 ISA, but doesn't include the multimedia stuff.  It seems
    // better to allow vr5400 and vr5500 code to be merged anyway, since
    // many libraries will just use the core ISA.  Perhaps we could add
    // some sort of ASE flag if this ever proves a problem.
    this->add_extension(mach_mips5500, mach_mips5400);
    this->add_extension(mach_mips5400, mach_mips5000);

    // MIPS IV extensions.
    this->add_extension(mach_mips5, mach_mips8000);
    this->add_extension(mach_mips10000, mach_mips8000);
    this->add_extension(mach_mips5000, mach_mips8000);
    this->add_extension(mach_mips7000, mach_mips8000);
    this->add_extension(mach_mips9000, mach_mips8000);

    // VR4100 extensions.
    this->add_extension(mach_mips4120, mach_mips4100);
    this->add_extension(mach_mips4111, mach_mips4100);

    // MIPS III extensions.
    this->add_extension(mach_mips_loongson_2e, mach_mips4000);
    this->add_extension(mach_mips_loongson_2f, mach_mips4000);
    this->add_extension(mach_mips8000, mach_mips4000);
    this->add_extension(mach_mips4650, mach_mips4000);
    this->add_extension(mach_mips4600, mach_mips4000);
    this->add_extension(mach_mips4400, mach_mips4000);
    this->add_extension(mach_mips4300, mach_mips4000);
    this->add_extension(mach_mips4100, mach_mips4000);
    this->add_extension(mach_mips4010, mach_mips4000);
    this->add_extension(mach_mips5900, mach_mips4000);

    // MIPS32 extensions.
    this->add_extension(mach_mipsisa32r2, mach_mipsisa32);

    // MIPS II extensions.
    this->add_extension(mach_mips4000, mach_mips6000);
    this->add_extension(mach_mipsisa32, mach_mips6000);

    // MIPS I extensions.
    this->add_extension(mach_mips6000, mach_mips3000);
    this->add_extension(mach_mips3900, mach_mips3000);
  }

  // Add value to MIPS extenstions.
  void
  add_extension(unsigned int base, unsigned int extension)
  {
    std::pair<unsigned int, unsigned int> ext(base, extension);
    this->mips_mach_extensions_.push_back(ext);
  }

  // Information about this specific target which we pass to the
  // general Target structure.
  static const Target::Target_info nanomips_info;

  typedef enum
  {
    // Instruction expansion state.
    EXPAND,
    // Instruction relaxation state.
    RELAX
  } State;

  // States used in relaxation passes.
  State state_;

  // gp symbol.
  Sized_symbol<size>* gp_;

  // Architecture extensions.
  std::vector<std::pair<unsigned int, unsigned int> > mips_mach_extensions_;

  // Attributes section data in output.
  Attributes_section_data* attributes_section_data_;

  // .MIPS.abiflags section data in output.
  Mips_abiflags<big_endian>* abiflags_;

  // .reginfo section data in output.
  Mips_reginfo<size, big_endian>* reginfo_;

  unsigned int mach_;

  Layout* layout_;

  // Whether there is an input .MIPS.abiflags section.
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
  relpc(unsigned char* view, Address value, Overflow_check check)
  {
    typedef typename elfcpp::Swap<fieldsize, big_endian>::Valtype Valtype;
    Valtype* wv = reinterpret_cast<Valtype*>(view);
    Valtype val = elfcpp::Swap<fieldsize, big_endian>::readval(wv);
    Valtype reloc = ((value & ~0x1) | ((value >> (valsize - 1)) & 0x1));
    Valtype mask = (1 << (valsize - 1)) - 1;
    val &= ~mask;
    reloc &= mask;
    elfcpp::Swap<fieldsize, big_endian>::writeval(wv, val | reloc);
    return check_overflow<valsize>(value, check);
  }

  // Do a simple gp-relative relocation.
  template<int valsize>
  static inline Status
  relgp(unsigned char* view, Address value, Address mask,
        Overflow_check check)
  {
    typedef typename elfcpp::Swap<32, big_endian>::Valtype Valtype;
    Valtype* wv = reinterpret_cast<Valtype*>(view);
    Valtype val = elfcpp::Swap<32, big_endian>::readval(wv);
    Valtype reloc = value & mask;
    val &= ~mask;
    elfcpp::Swap<32, big_endian>::writeval(wv, val | reloc);
    return check_overflow<valsize>(value, check);
  }

 public:
  static inline void
  nanomips_reloc_unshuffle(unsigned char* view,
                           const Nanomips_reloc_property* nrp)
  {
    if (!nrp->shuffle_reloc())
      return;

    // Pick up the first and second halfwords of the instruction.
    Valtype16 first = elfcpp::Swap<16, big_endian>::readval(view);
    Valtype16 second = elfcpp::Swap<16, big_endian>::readval(view + 2);
    Valtype32 val = (nrp->size() == 48 ? (second << 16 | first)
                                       : (first << 16 | second));

    elfcpp::Swap<32, big_endian>::writeval(view, val);
  }

  static inline void
  nanomips_reloc_shuffle(unsigned char* view,
                         const Nanomips_reloc_property* nrp)
  {
    if (!nrp->shuffle_reloc())
      return;

    // Write the first and second halfwords of the instruction.
    Valtype32 val = elfcpp::Swap<32, big_endian>::readval(view);
    Valtype16 first = (nrp->size() == 48 ? (val & 0xffff) : (val >> 16));
    Valtype16 second = (nrp->size() == 48 ? (val >> 16) : (val & 0xffff));

    elfcpp::Swap<16, big_endian>::writeval(view, first);
    elfcpp::Swap<16, big_endian>::writeval(view + 2, second);
  }

  // R_NANOMIPS_GPREL19_S2
  static inline Status
  relgprel19_s2(unsigned char* view, Address value,
                bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffffc, check);
  }

  // R_NANOMIPS_GPREL18_S3
  static inline Status
  relgprel18_s3(unsigned char* view, Address value,
                bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<21>(view, value, 0x1ffff8, check);
  }

  // R_NANOMIPS_GPREL18
  static inline Status
  relgprel18(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3ffff, check);
  }

  // R_NANOMIPS_GPREL17_S1
  static inline Status
  relgprel17_s1(unsigned char* view, Address value, bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffe, check);
  }

  // R_NANOMIPS_GPREL16_S2
  static inline Status
  relgprel16_s2(unsigned char* view, Address value,
                bool check_overflow)
  {
    Overflow_check check = check_overflow ? CHECK_UNSIGNED : CHECK_NONE;
    return This::template relgp<18>(view, value, 0x3fffc, check);
  }

  // R_NANOMIPS_GPREL7_S2
  static inline Status
  relgprel7_s2(unsigned char* view, Address value,
               bool should_check_overflow)
  {
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);

    val = Bits<7>::bit_select32(val, value >> 2, 0x7f);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);

    return should_check_overflow ? check_overflow<9>(value, CHECK_UNSIGNED)
                                 : STATUS_OKAY;
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
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);

    val = Bits<4>::bit_select32(val, value >> 1, 0xf);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);

    return should_check_overflow ? check_overflow<5>(value, CHECK_UNSIGNED)
                                 : STATUS_OKAY;
  }

  // R_NANOMIPS_ASHIFTR_1, R_NANOMIPS_NEG
  static inline Status
  relsize(unsigned char* view, Address value)
  { return This::template rel<size>(view, value, CHECK_NONE); }

  // R_NANOMIPS_32, R_NANOMIPS_I32, R_NANOMIPS_PC_I32, R_NANOMIPS_GPREL_I32
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

   // R_NANOMIPS_HI20, R_NANOMIPS_PC_HI20, R_NANOMIPS_GPREL_HI20
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

  // R_NANOMIPS_LO12, R_NANOMIPS_GPREL_LO12
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
            bool should_check_overflow)
  {
    Valtype16* wv = reinterpret_cast<Valtype16*>(view);
    Valtype16 val = elfcpp::Swap<16, big_endian>::readval(wv);
    value &= 0xfff;
    val = Bits<4>::bit_select32(val, value >> 2, 0xf);
    elfcpp::Swap<16, big_endian>::writeval(wv, val);
    return should_check_overflow ? check_overflow<6>(value, CHECK_UNSIGNED)
                                 : STATUS_OKAY;
  }
};

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

  // Adjust the local symbols.

  // Skip the first dummy symbol.
  psyms += sym_size;
  typename Sized_relobj_file<size, big_endian>::Local_values* plocal_values =
    this->local_values();
  for (unsigned int i = 1; i < loccount; ++i, psyms += sym_size)
    {
      Symbol_value<size>& lv((*plocal_values)[i]);
      elfcpp::Sym<size, big_endian> sym(psyms);
      Address value = lv.input_value();
      bool is_ordinary;
      unsigned int sym_shndx = lv.input_shndx(&is_ordinary);

      if (is_ordinary && shndx == sym_shndx)
        {
          // Adjust value of the symbol, if needed.
          if (value >= address)
            {
              value += count;
              lv.set_input_value(value);
            }

          // Adjust the function symbol's size, if needed.
          bool is_func = sym.get_st_type() == elfcpp::STT_FUNC;
          Size_type symsize = this->do_local_symbol_size(i);
          if (is_func
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
            {
              value += count;
              gsym->set_value(value);
            }

          // Adjust the function symbol's size, if needed.
          Size_type symsize = gsym->symsize();
          if (gsym->is_func()
              && value < address
              && value + symsize >= address)
            gsym->set_symsize(symsize + count);
        }
    }
}

// Determine if an input section is scannable for relaxations or expansions.

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

// Scan relocation section for relaxations or expansions.

template<int size, bool big_endian>
bool
Nanomips_relobj<size, big_endian>::scan_sections_for_relax_or_expand(
    Target_nanomips<size, big_endian>* target,
    const Symbol_table* symtab,
    const Layout* layout)
{
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

  // Do relocation relaxation or expansion scanning.
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
              Output_relaxed_input_section* poris =
                osections[index]->find_relaxed_input_section(this, index);
              gold_assert(poris != NULL);
              pnis = Nanomips_input_section::as_nanomips_input_section(poris);
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

          again |=
            target->scan_section_for_relax_or_expand(&relinfo, sh_type,
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

  // Initialize the local symbol size vector.
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

  // Loop over the local symbols and cache size of the symbols.

  // Skip the first dummy symbol.
  psyms += sym_size;
  for (unsigned int i = 1; i < loccount; ++i, psyms += sym_size)
    {
      elfcpp::Sym<size, big_endian> sym(psyms);
      this->local_symbol_size_[i] = sym.get_st_size();
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

      if (shdr.get_sh_type() == elfcpp::SHT_MIPS_REGINFO)
        {
          // Read the gp value that was used to create this object.  We need the
          // gp value while processing relocs.  The .reginfo section is not used
          // in the 64-bit MIPS ELF ABI.
          section_offset_type section_offset = shdr.get_sh_offset();
          section_size_type section_size =
            convert_to_section_size_type(shdr.get_sh_size());
          const unsigned char* view =
             this->get_view(section_offset, section_size, true, false);
          this->reginfo_ = new Mips_reginfo<size, big_endian>();

          this->reginfo_->gprmask =
            elfcpp::Swap<size, big_endian>::readval(view);
          this->reginfo_->cprmask1 =
            elfcpp::Swap<size, big_endian>::readval(view + 4);
          this->reginfo_->cprmask2 =
            elfcpp::Swap<size, big_endian>::readval(view + 8);
          this->reginfo_->cprmask3 =
            elfcpp::Swap<size, big_endian>::readval(view + 12);
          this->reginfo_->cprmask4 =
            elfcpp::Swap<size, big_endian>::readval(view + 16);
          this->reginfo_->gp =
            elfcpp::Swap<size, big_endian>::readval(view + 20);
        }

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

      if (shdr.get_sh_type() == elfcpp::SHT_MIPS_ABIFLAGS)
        {
          gold_assert(this->abiflags_ == NULL);
          section_offset_type section_offset = shdr.get_sh_offset();
          section_size_type section_size =
            convert_to_section_size_type(shdr.get_sh_size());
          const unsigned char* view =
            this->get_view(section_offset, section_size, true, false);
          this->abiflags_ = new Mips_abiflags<big_endian>();

          this->abiflags_->version =
            elfcpp::Swap<16, big_endian>::readval(view);
          if (this->abiflags_->version != 0)
            {
              gold_error(_("%s: .MIPS.abiflags section has "
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

// Nanomips_output_section_reginfo methods.

template<int size, bool big_endian>
void
Nanomips_output_section_reginfo<size, big_endian>::do_write(Output_file* of)
{
  off_t offset = this->offset();
  off_t data_size = this->data_size();

  unsigned char* view = of->get_output_view(offset, data_size);
  elfcpp::Swap<size, big_endian>::writeval(view, this->reginfo_.gprmask);
  elfcpp::Swap<size, big_endian>::writeval(view + 4, this->reginfo_.cprmask1);
  elfcpp::Swap<size, big_endian>::writeval(view + 8, this->reginfo_.cprmask2);
  elfcpp::Swap<size, big_endian>::writeval(view + 12, this->reginfo_.cprmask3);
  elfcpp::Swap<size, big_endian>::writeval(view + 16, this->reginfo_.cprmask4);
  // Write the gp value.
  elfcpp::Swap<size, big_endian>::writeval(view + 20,
                                           this->target_->gp_value());

  of->write_output_view(offset, data_size, view);
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
}

// Write data to output file.

void
Nanomips_input_section::do_write(Output_file* of)
{
  // Write out the section content.
  gold_assert(this->contents_.data != NULL);
  of->write(this->offset(), this->contents_.data, this->contents_.len);
}

// Relax_nanomips_insn methods.

// Return matching instruction for relaxation if there is one and INSN can
// be relaxed, otherwise return NULL.

template<int size, bool big_endian>
inline const Nanomips_insn_property*
Relax_nanomips_insn<size, big_endian>::find(
    uint32_t insn,
    unsigned int r_type)
{
  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  const Nanomips_insn_property *insn_property =
    reloc_property->find_relax_match(insn);
  if (insn_property == NULL)
    return NULL;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      return insn_property;
    case elfcpp::R_NANOMIPS_PC14_S1:
    case elfcpp::R_NANOMIPS_LO12:
      {
        unsigned int sreg32 = Insn_utilities::sreg_32(insn);
        if (!Insn_utilities::valid_reg_16(sreg32))
          return NULL;
      }
      // Fall through.
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      {
        unsigned int treg32 = Insn_utilities::treg_32(insn);
        bool valid = (insn_property->is_store()
                      ? Insn_utilities::valid_reg_16_st(treg32)
                      : Insn_utilities::valid_reg_16(treg32));
        return valid ? insn_property : NULL;
      }
    default:
      gold_unreachable();
    }

  return NULL;
}

// Return true if instruction is not marked with R_NANOMIPS_INSN32 or
// R_NANOMIPS_FIXED relocations.

template<int size, bool big_endian>
inline bool
Relax_nanomips_insn<size, big_endian>::can_be_changed(
    Address offset,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Start finding INSN32 and FIXED from the next relocation.
  prelocs += reloc_size;
  for (size_t i = relnum + 1; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      if (offset != reloc.get_r_offset())
        break;

      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      if (r_type == elfcpp::R_NANOMIPS_INSN32
          || r_type == elfcpp::R_NANOMIPS_FIXED)
        return false;
    }

  return true;
}

// Check the range of the relocation and return true if we can relax
// instruction.

template<int size, bool big_endian>
inline bool
Relax_nanomips_insn<size, big_endian>::check_range(
    Valtype value,
    unsigned int r_type)
{
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      return this->check_value<11>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_PC14_S1:
      return ((value != 0) && this->check_value<5>(value, CHECK_UNSIGNED));
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      return this->check_value<9>(value, CHECK_UNSIGNED);
    case elfcpp::R_NANOMIPS_LO12:
      return (((value & 3) == 0)
              && this->check_value<6>(value, CHECK_UNSIGNED));
    default:
      gold_unreachable();
    }
  return false;
}

// Check the range of the relocation and return whether we can relax
// instruction during relocatable link and --finalize-relocs is passed.

template<int size, bool big_endian>
inline bool
Relax_nanomips_insn<size, big_endian>::relocatable_check_range(
    Valtype value,
    unsigned int r_type,
    size_t relnum,
    const Relocate_info<size, big_endian>* relinfo,
    const Symbol_value<size>*,
    unsigned int,
    bool)
{
  Relocatable_relocs* rr = relinfo->rr;
  gold_assert(rr != NULL);

  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return false;

  return this->check_range(value, r_type);
}

// Relax instruction.  We are not adding new relocations, so always return
// false.

template<int size, bool big_endian>
inline bool
Relax_nanomips_insn<size, big_endian>::change(
    uint32_t insn,
    const Nanomips_insn_property* insn_property,
    unsigned char* view,
    unsigned char* preloc,
    unsigned char*)
{
  gold_assert(insn_property != NULL);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  Reltype reloc(preloc);
  Reltype_write reloc_write(preloc);

  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  unsigned int relax_r_type = insn_property->reloc(0);
  Valtype16 relax_insn = static_cast<Valtype16>(insn_property->insn(0));

  if (r_type != elfcpp::R_NANOMIPS_PC25_S1)
    {
      unsigned int treg32 = Insn_utilities::treg_32(insn);
      relax_insn |= ((treg32 & 7) << 7);
      if (r_type == elfcpp::R_NANOMIPS_PC14_S1
          || r_type == elfcpp::R_NANOMIPS_LO12)
        {
          unsigned int sreg32 = Insn_utilities::sreg_32(insn);
          relax_insn |= ((sreg32 & 7) << 4);
        }
    }

  // Update current relocation.
  reloc_write.put_r_info(elfcpp::elf_r_info<size>(r_sym, relax_r_type));
  // Write relaxed instruction.
  elfcpp::Swap<16, big_endian>::writeval(view, relax_insn);
  return false;
}

// Expand_nanomips_insn methods.

// Return matching instructions for expansion if we have found them.

template<int size, bool big_endian>
inline const Nanomips_insn_property*
Expand_nanomips_insn<size, big_endian>::find(
    uint32_t insn,
    unsigned int r_type)
{
  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  const Nanomips_insn_property *insn_property =
    reloc_property->find_expand_match(insn);
  return insn_property;
}

// Return true if instruction is not marked with R_NANOMIPS_FIXED relocation.

template<int size, bool big_endian>
inline bool
Expand_nanomips_insn<size, big_endian>::can_be_changed(
    Address offset,
    size_t relnum,
    size_t reloc_count,
    const unsigned char* prelocs)
{
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  // Start finding FIXED from the next relocation.
  prelocs += reloc_size;
  for (size_t i = relnum + 1; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);
      if (offset != reloc.get_r_offset())
        break;

      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());
      if (r_type == elfcpp::R_NANOMIPS_FIXED)
        return false;
    }

  return true;
}

// Set *PINSN_PROPERTY to the correct instruction property.  This is only used
// for beqc16 and bnec16 instructions for now, where we can't distinguish
// them through the opcode.

template<int size, bool big_endian>
inline void
Expand_nanomips_insn<size, big_endian>::find_property(
    uint32_t insn,
    const Nanomips_insn_property** pinsn_property,
    unsigned int r_type)
{
  const Nanomips_insn_property* insn_property = *pinsn_property;
  if (r_type == elfcpp::R_NANOMIPS_PC4_S1)
    {
      unsigned int sreg16 = Insn_utilities::sreg_16(insn);
      unsigned int treg16 = Insn_utilities::treg_16(insn);
      // If rs3>=rt3 then this is bnec[16] instruction, otherwise
      // it's beqc[16].
      unsigned int insn_type = sreg16 >= treg16 ? IT_BNEC16 : IT_BEQC16;
      insn_property = insn_property->get_insn_property(insn_type);
      gold_assert(insn_property != NULL);
      *pinsn_property = insn_property;
    }
}

// Check the range of the relocation and return true if we must expand
// instruction.

template<int size, bool big_endian>
inline bool
Expand_nanomips_insn<size, big_endian>::check_range(
    Valtype value,
    unsigned int r_type)
{
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC25_S1:
      return this->check_value<26>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_PC21_S1:
      return this->check_value<22>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_PC11_S1:
      return this->check_value<12>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      return this->check_value<21>(value, CHECK_UNSIGNED);
    case elfcpp::R_NANOMIPS_GPREL18:
    case elfcpp::R_NANOMIPS_GPREL17_S1:
      return this->check_value<18>(value, CHECK_UNSIGNED);
    case elfcpp::R_NANOMIPS_PC10_S1:
      return this->check_value<11>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_PC7_S1:
      return this->check_value<8>(value, CHECK_SIGNED);
    case elfcpp::R_NANOMIPS_PC4_S1:
      return ((value == 0) || this->check_value<5>(value, CHECK_UNSIGNED));
    case elfcpp::R_NANOMIPS_GPREL7_S2:
      return this->check_value<9>(value, CHECK_UNSIGNED);
    case elfcpp::R_NANOMIPS_LO4_S2:
      return (((value & 3) != 0)
              || this->check_value<6>(value, CHECK_UNSIGNED));
    default:
      gold_unreachable();
    }
  return false;
}

// Check the range of the relocation and return true if we must expand
// instruction during relocatable link and --finalize-relocs is passed.

template<int size, bool big_endian>
inline bool
Expand_nanomips_insn<size, big_endian>::relocatable_check_range(
    Valtype value,
    unsigned int r_type,
    size_t relnum,
    const Relocate_info<size, big_endian>* relinfo,
    const Symbol_value<size>* psymval,
    unsigned int r_sym,
    bool global)
{
  Relocatable_relocs* rr = relinfo->rr;
  gold_assert(rr != NULL);

  if (rr->strategy(relnum) != Relocatable_relocs::RELOC_RESOLVE)
    return true;

  // For RELOC_RESOLVE we need to check if we need to expand instruction.
  if (!this->check_range(value, r_type))
    return false;

  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  Relocatable_relocs::Reloc_strategy strategy;

  // We can't resolve this relocation so we need to get default strategy.
  if (global)
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
  return true;
}

// Expand instruction.  Return true if we have add new relocation.

template<int size, bool big_endian>
inline bool
Expand_nanomips_insn<size, big_endian>::change(
    uint32_t insn,
    const Nanomips_insn_property* insn_property,
    unsigned char* view,
    unsigned char* preloc,
    unsigned char* preloc_new)
{
  gold_assert(insn_property != NULL);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  Reltype reloc(preloc);
  Reltype_write reloc_write(preloc);

  typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
  unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
  unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
  Address r_offset = reloc.get_r_offset();
  typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
    reloc.get_r_addend();

  const Nanomips_reloc_property* reloc_property =
    nanomips_reloc_property_table->get_reloc_property(r_type);
  gold_assert(reloc_property != NULL);

  if (r_type == elfcpp::R_NANOMIPS_PC25_S1)
    {
      // Change existing relocation.
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(0)));

      // Add new relocation.
      Reltype_write reloc_new(preloc_new);
      reloc_new.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(1)));
      reloc_new.put_r_addend(r_addend);
      reloc_new.put_r_offset(r_offset + 4);

      // Write instructions.
      Valtype32 aluipc_insn = (insn_property->insn(0)
                               | (this->expand_reg_ << 21));
      Valtype32 addiu_insn = (insn_property->insn(1)
                              | (this->expand_reg_ << 21)
                              | (this->expand_reg_ << 16));
      Valtype16 branch_insn =
        static_cast<Valtype16>(insn_property->insn(2));
      branch_insn |= (this->expand_reg_ << 5);

      Insn_utilities::put_insn_32(view, aluipc_insn);
      Insn_utilities::put_insn_32(view + 4, addiu_insn);
      elfcpp::Swap<16, big_endian>::writeval(view + 8, branch_insn);
      return true;
    }
  else if (r_type == elfcpp::R_NANOMIPS_PC21_S1)
    {
      // Write move16 insn.
      Valtype16 move_insn =
        static_cast<Valtype16>(insn_property->insn(0));
      unsigned int rd = ((insn >> 24) & 0x1) + 4;
      unsigned int rt = (((insn >> 21) & 0x7) | ((insn >> 22) & 0x8));
      if (rt == 3)
        rt = 0;
      else if (rt < 4 || rt > 7)
        rt += 8;

      move_insn |= ((rd << 5) | rt);
      elfcpp::Swap<16, big_endian>::writeval(view, move_insn);

       // Change existing relocation.
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(1)));
      reloc_write.put_r_offset(r_offset + 2);

      // Write instruction.
      Insn_utilities::put_insn_32(view + 2, insn_property->insn(1));
      return false;
    }
  else if (r_type == elfcpp::R_NANOMIPS_PC11_S1)
    {
      // Write addiu $at, $zero, imm insn.
      Valtype32 addiu_insn = (insn_property->insn(0)
                              | (this->expand_reg_ << 21)
                              | ((insn >> 11) & 0x7f));
      Insn_utilities::put_insn_32(view, addiu_insn);

      // Change existing relocation.
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(1)));
      reloc_write.put_r_offset(r_offset + 4);

      // Write b<cc>c instruction.
      unsigned int treg32 = Insn_utilities::treg_32(insn);
      Valtype32 b_cc_c_insn = (insn_property->insn(1)
                               | (this->expand_reg_ << 21)
                               | (treg32 << 16));
      Insn_utilities::put_insn_32(view + 4, b_cc_c_insn);
      return false;
    }
  else if (r_type == elfcpp::R_NANOMIPS_GPREL19_S2
           || r_type == elfcpp::R_NANOMIPS_GPREL18
           || r_type == elfcpp::R_NANOMIPS_GPREL17_S1)
    {
      // Change existing relocation.
      reloc_write.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(0)));

      // Add new relocation.
      Reltype_write reloc_new(preloc_new);
      reloc_new.put_r_info(
        elfcpp::elf_r_info<size>(r_sym, insn_property->reloc(2)));
      reloc_new.put_r_addend(r_addend);
      reloc_new.put_r_offset(r_offset + 8);

      // Write instructions.
      Valtype32 lui_insn = (insn_property->insn(0) | (this->expand_reg_ << 21));
      Valtype32 addu_insn = (insn_property->insn(1)
                             | (this->expand_reg_ << 16)
                             | (this->expand_reg_ << 11));
      unsigned int treg32 = Insn_utilities::treg_32(insn);
      Valtype32 third_insn = (insn_property->insn(2)
                              | (treg32 << 21)
                              | (this->expand_reg_ << 16));

      Insn_utilities::put_insn_32(view, lui_insn);
      Insn_utilities::put_insn_32(view + 4, addu_insn);
      Insn_utilities::put_insn_32(view + 8, third_insn);
      return true;
    }
  else if (reloc_property->size() == 16)
    {
      // Expansion from 16 bit to 32 bit instructions.
      Valtype32 expand_insn = insn_property->insn(0);
      unsigned int expand_r_type = insn_property->reloc(0);

      if (r_type != elfcpp::R_NANOMIPS_PC10_S1)
        {
          unsigned int treg16 = Insn_utilities::treg_16(insn);
          unsigned int treg32 = (insn_property->is_store()
                                 ? Insn_utilities::reg_16_to_32_st(treg16)
                                 : Insn_utilities::reg_16_to_32(treg16));
          expand_insn |= (treg32 << 21);
          if (r_type == elfcpp::R_NANOMIPS_PC4_S1
              || r_type == elfcpp::R_NANOMIPS_LO4_S2)
            {
              unsigned int sreg16 = Insn_utilities::sreg_16(insn);
              unsigned int sreg32 = Insn_utilities::reg_16_to_32(sreg16);
              expand_insn |= (sreg32 << 16);
            }
        }

      // Update current relocation.
      reloc_write.put_r_info(elfcpp::elf_r_info<size>(r_sym, expand_r_type));
      // Write expanded instruction.
      Insn_utilities::put_insn_32(view, expand_insn);
      return false;
    }
  else
    gold_unreachable();

  return false;
}

// Target_nanomips methods.

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
      // gp should be based on .sdata.
      Output_data* gp_section = layout->find_output_section(".sdata");

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

// Relaxation hook.  This is where we do relaxations and expansions of
// nanoMIPS instructions.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::do_relax(
    int pass,
    const Input_objects* input_objects,
    Symbol_table* symtab,
    Layout* layout,
    const Task* task)
{
  // Whether we need to continue doing relaxations or expansions.
  bool again = false;
  // Whether the state is changed from RELAX to EXPAND.
  bool state_changed;

  do
    {
      state_changed = false;
      gold_debug(DEBUG_TARGET, "%d pass: %s",
                 pass, this->state_ == RELAX ? "Relaxations" : "Expansions");

      // Scan relocs for relaxations or expansions.
      for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
           p != input_objects->relobj_end();
           ++p)
        {
          Nanomips_relobj<size, big_endian>* relobj =
            Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);

          // Lock the object so we can read from it.  This is only called
          // single-threaded from Layout::finalize, so it is OK to lock.
          Task_lock_obj<Object> tl(task, relobj);
          again |=
            relobj->scan_sections_for_relax_or_expand(this, symtab, layout);
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

// A class to sort the input sections.

template<int size, bool big_endian>
class Input_section_sorter
{
 public:
  bool
  operator()(const Input_section_info& isi1,
             const Input_section_info& isi2) const
  {
    const Nanomips_relobj<size, big_endian>* isi1_relobj =
      Nanomips_relobj<size, big_endian>::as_nanomips_relobj(isi1.relobj());
    const Nanomips_relobj<size, big_endian>* isi2_relobj =
      Nanomips_relobj<size, big_endian>::as_nanomips_relobj(isi2.relobj());

    // Sort by most commonly referenced sections.
    unsigned int isi1_ref = isi1_relobj->input_section_ref(isi1.shndx());
    unsigned int isi2_ref = isi2_relobj->input_section_ref(isi2.shndx());
    if (isi1_ref != isi2_ref)
      return isi1_ref > isi2_ref;

    // Sort by ascending size.
    uint64_t isi1_size = isi1.size();
    uint64_t isi2_size = isi2.size();
    if (isi1_size != isi2_size)
      return isi1_size < isi2_size;

    // When the sections are the same size, we sort them by
    // alignment, largest alignment first.
    uint64_t isi1_align = isi1.addralign();
    uint64_t isi2_align = isi2.addralign();
    if (isi1_align != isi2_align)
      return isi1_align > isi2_align;

    // The sections seem practically identical.  Sort by name to get a
    // stable sort.
    return isi1.section_name() < isi2.section_name();
  }
};

// This is called when keyword SORT_BY_READ is found in the linker script.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::do_sort_input_sections(
    int sort,
    std::vector<Input_section_info>* input_sections) const
{
  gold_assert(sort == static_cast<int>(SORT_WILDCARD_BY_READ));
  std::sort(input_sections->begin(), input_sections->end(),
            Input_section_sorter<size, big_endian>());
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

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::mips_32bit_flags(elfcpp::Elf_Word flags)
{
  return ((flags & elfcpp::EF_MIPS_32BITMODE) != 0
          || (flags & elfcpp::EF_MIPS_ABI) == elfcpp::E_MIPS_ABI_O32
          || (flags & elfcpp::EF_MIPS_ABI) == elfcpp::E_MIPS_ABI_EABI32
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_MIPS_ARCH_1
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_MIPS_ARCH_2
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_MIPS_ARCH_32
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_MIPS_ARCH_32R2
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_MIPS_ARCH_32R6
          || (flags & elfcpp::EF_MIPS_ARCH) == elfcpp::E_NANOMIPS_ARCH_32R6);
}

// Return the MACH for a MIPS e_flags value.
template<int size, bool big_endian>
unsigned int
Target_nanomips<size, big_endian>::elf_mips_mach(elfcpp::Elf_Word flags)
{
  switch (flags & elfcpp::EF_MIPS_MACH)
    {
    case elfcpp::E_MIPS_MACH_3900:
      return mach_mips3900;

    case elfcpp::E_MIPS_MACH_4010:
      return mach_mips4010;

    case elfcpp::E_MIPS_MACH_4100:
      return mach_mips4100;

    case elfcpp::E_MIPS_MACH_4111:
      return mach_mips4111;

    case elfcpp::E_MIPS_MACH_4120:
      return mach_mips4120;

    case elfcpp::E_MIPS_MACH_4650:
      return mach_mips4650;

    case elfcpp::E_MIPS_MACH_5400:
      return mach_mips5400;

    case elfcpp::E_MIPS_MACH_5500:
      return mach_mips5500;

    case elfcpp::E_MIPS_MACH_5900:
      return mach_mips5900;

    case elfcpp::E_MIPS_MACH_9000:
      return mach_mips9000;

    case elfcpp::E_MIPS_MACH_SB1:
      return mach_mips_sb1;

    case elfcpp::E_MIPS_MACH_LS2E:
      return mach_mips_loongson_2e;

    case elfcpp::E_MIPS_MACH_LS2F:
      return mach_mips_loongson_2f;

    case elfcpp::E_MIPS_MACH_LS3A:
      return mach_mips_loongson_3a;

    case elfcpp::E_MIPS_MACH_OCTEON3:
      return mach_mips_octeon3;

    case elfcpp::E_MIPS_MACH_OCTEON2:
      return mach_mips_octeon2;

    case elfcpp::E_MIPS_MACH_OCTEON:
      return mach_mips_octeon;

    case elfcpp::E_MIPS_MACH_XLR:
      return mach_mips_xlr;

    default:
      switch (flags & elfcpp::EF_MIPS_ARCH)
        {
        default:
        case elfcpp::E_MIPS_ARCH_1:
          return mach_mips3000;

        case elfcpp::E_MIPS_ARCH_2:
          return mach_mips6000;

        case elfcpp::E_MIPS_ARCH_3:
          return mach_mips4000;

        case elfcpp::E_MIPS_ARCH_4:
          return mach_mips8000;

        case elfcpp::E_MIPS_ARCH_5:
          return mach_mips5;

        case elfcpp::E_MIPS_ARCH_32:
          return mach_mipsisa32;

        case elfcpp::E_MIPS_ARCH_64:
          return mach_mipsisa64;

        case elfcpp::E_MIPS_ARCH_32R2:
          return mach_mipsisa32r2;

        case elfcpp::E_MIPS_ARCH_32R6:
          return mach_mipsisa32r6;

        case elfcpp::E_MIPS_ARCH_64R2:
          return mach_mipsisa64r2;

        case elfcpp::E_MIPS_ARCH_64R6:
          return mach_mipsisa64r6;

        case elfcpp::E_NANOMIPS_ARCH_32R6:
          return mach_nanomipsisa32r6;

        case elfcpp::E_NANOMIPS_ARCH_64R6:
          return mach_nanomipsisa64r6;
        }
    }

  return 0;
}

// Return the MACH for each .MIPS.abiflags ISA Extension.

template<int size, bool big_endian>
unsigned int
Target_nanomips<size, big_endian>::mips_isa_ext_mach(unsigned int isa_ext)
{
  switch (isa_ext)
    {
    case elfcpp::AFL_EXT_3900:
      return mach_mips3900;

    case elfcpp::AFL_EXT_4010:
      return mach_mips4010;

    case elfcpp::AFL_EXT_4100:
      return mach_mips4100;

    case elfcpp::AFL_EXT_4111:
      return mach_mips4111;

    case elfcpp::AFL_EXT_4120:
      return mach_mips4120;

    case elfcpp::AFL_EXT_4650:
      return mach_mips4650;

    case elfcpp::AFL_EXT_5400:
      return mach_mips5400;

    case elfcpp::AFL_EXT_5500:
      return mach_mips5500;

    case elfcpp::AFL_EXT_5900:
      return mach_mips5900;

    case elfcpp::AFL_EXT_10000:
      return mach_mips10000;

    case elfcpp::AFL_EXT_LOONGSON_2E:
      return mach_mips_loongson_2e;

    case elfcpp::AFL_EXT_LOONGSON_2F:
      return mach_mips_loongson_2f;

    case elfcpp::AFL_EXT_LOONGSON_3A:
      return mach_mips_loongson_3a;

    case elfcpp::AFL_EXT_SB1:
      return mach_mips_sb1;

    case elfcpp::AFL_EXT_OCTEON:
      return mach_mips_octeon;

    case elfcpp::AFL_EXT_OCTEONP:
      return mach_mips_octeonp;

    case elfcpp::AFL_EXT_OCTEON2:
      return mach_mips_octeon2;

    case elfcpp::AFL_EXT_XLR:
      return mach_mips_xlr;

    default:
      return mach_mips3000;
    }
}

// Return the .MIPS.abiflags value representing each ISA Extension.

template<int size, bool big_endian>
unsigned int
Target_nanomips<size, big_endian>::mips_isa_ext(unsigned int mips_mach)
{
  switch (mips_mach)
    {
    case mach_mips3900:
      return elfcpp::AFL_EXT_3900;

    case mach_mips4010:
      return elfcpp::AFL_EXT_4010;

    case mach_mips4100:
      return elfcpp::AFL_EXT_4100;

    case mach_mips4111:
      return elfcpp::AFL_EXT_4111;

    case mach_mips4120:
      return elfcpp::AFL_EXT_4120;

    case mach_mips4650:
      return elfcpp::AFL_EXT_4650;

    case mach_mips5400:
      return elfcpp::AFL_EXT_5400;

    case mach_mips5500:
      return elfcpp::AFL_EXT_5500;

    case mach_mips5900:
      return elfcpp::AFL_EXT_5900;

    case mach_mips10000:
      return elfcpp::AFL_EXT_10000;

    case mach_mips_loongson_2e:
      return elfcpp::AFL_EXT_LOONGSON_2E;

    case mach_mips_loongson_2f:
      return elfcpp::AFL_EXT_LOONGSON_2F;

    case mach_mips_loongson_3a:
      return elfcpp::AFL_EXT_LOONGSON_3A;

    case mach_mips_sb1:
      return elfcpp::AFL_EXT_SB1;

    case mach_mips_octeon:
      return elfcpp::AFL_EXT_OCTEON;

    case mach_mips_octeonp:
      return elfcpp::AFL_EXT_OCTEONP;

    case mach_mips_octeon3:
      return elfcpp::AFL_EXT_OCTEON3;

    case mach_mips_octeon2:
      return elfcpp::AFL_EXT_OCTEON2;

    case mach_mips_xlr:
      return elfcpp::AFL_EXT_XLR;

    default:
      return 0;
    }
}

// Update the isa_level, isa_rev, isa_ext fields of abiflags.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::update_abiflags_isa(const std::string& name,
    elfcpp::Elf_Word e_flags, Mips_abiflags<big_endian>* abiflags)
{
  int new_isa = 0;
  switch (e_flags & elfcpp::EF_MIPS_ARCH)
    {
    case elfcpp::E_MIPS_ARCH_1:
      new_isa = this->level_rev(1, 0);
      break;
    case elfcpp::E_MIPS_ARCH_2:
      new_isa = this->level_rev(2, 0);
      break;
    case elfcpp::E_MIPS_ARCH_3:
      new_isa = this->level_rev(3, 0);
      break;
    case elfcpp::E_MIPS_ARCH_4:
      new_isa = this->level_rev(4, 0);
      break;
    case elfcpp::E_MIPS_ARCH_5:
      new_isa = this->level_rev(5, 0);
      break;
    case elfcpp::E_MIPS_ARCH_32:
      new_isa = this->level_rev(32, 1);
      break;
    case elfcpp::E_MIPS_ARCH_32R2:
      new_isa = this->level_rev(32, 2);
      break;
    case elfcpp::E_MIPS_ARCH_32R6:
      new_isa = this->level_rev(32, 6);
      break;
    case elfcpp::E_NANOMIPS_ARCH_32R6:
      new_isa = this->level_rev(32, 6);
      break;
    case elfcpp::E_MIPS_ARCH_64:
      new_isa = this->level_rev(64, 1);
      break;
    case elfcpp::E_MIPS_ARCH_64R2:
      new_isa = this->level_rev(64, 2);
      break;
    case elfcpp::E_MIPS_ARCH_64R6:
      new_isa = this->level_rev(64, 6);
      break;
    case elfcpp::E_NANOMIPS_ARCH_64R6:
      new_isa = this->level_rev(64, 6);
      break;
    default:
      gold_error(_("%s: Unknown architecture %s"), name.c_str(),
                 this->elf_mips_mach_name(e_flags));
    }

  if (new_isa > this->level_rev(abiflags->isa_level, abiflags->isa_rev))
    {
      // Decode a single value into level and revision.
      abiflags->isa_level = new_isa >> 3;
      abiflags->isa_rev = new_isa & 0x7;
    }

  // Update the isa_ext if needed.
  if (this->mips_mach_extends(this->mips_isa_ext_mach(abiflags->isa_ext),
      this->elf_mips_mach(e_flags)))
    abiflags->isa_ext = this->mips_isa_ext(this->elf_mips_mach(e_flags));
}

// Infer the content of the ABI flags based on the elf header.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::infer_abiflags(
    Nanomips_relobj<size, big_endian>* relobj,
    Mips_abiflags<big_endian>* abiflags)
{
  const Attributes_section_data* pasd = relobj->attributes_section_data();
  int attr_fp_abi = elfcpp::Val_GNU_MIPS_ABI_FP_ANY;
  elfcpp::Elf_Word e_flags = relobj->processor_specific_flags();

  this->update_abiflags_isa(relobj->name(), e_flags, abiflags);
  if (pasd != NULL)
    {
      // Read fp_abi from the .gnu.attribute section.
      const Object_attribute* attr =
        pasd->known_attributes(Object_attribute::OBJ_ATTR_GNU);
      attr_fp_abi = attr[elfcpp::Tag_GNU_MIPS_ABI_FP].int_value();
    }

  abiflags->fp_abi = attr_fp_abi;
  abiflags->cpr1_size = elfcpp::AFL_REG_NONE;
  abiflags->cpr2_size = elfcpp::AFL_REG_NONE;
  abiflags->gpr_size = this->mips_32bit_flags(e_flags) ? elfcpp::AFL_REG_32
                                                       : elfcpp::AFL_REG_64;

  if (abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_SINGLE
      || abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_XX
      || (abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_DOUBLE
      && abiflags->gpr_size == elfcpp::AFL_REG_32))
    abiflags->cpr1_size = elfcpp::AFL_REG_32;
  else if (abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_DOUBLE
           || abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_64
           || abiflags->fp_abi == elfcpp::Val_GNU_MIPS_ABI_FP_64A)
    abiflags->cpr1_size = elfcpp::AFL_REG_64;

  if (e_flags & elfcpp::EF_MIPS_ARCH_ASE_MDMX)
    abiflags->ases |= elfcpp::AFL_ASE_MDMX;
  if (e_flags & elfcpp::EF_MIPS_ARCH_ASE_M16)
    abiflags->ases |= elfcpp::AFL_ASE_MIPS16;
  if (e_flags & elfcpp::EF_MIPS_ARCH_ASE_MICROMIPS)
    abiflags->ases |= elfcpp::AFL_ASE_MICROMIPS;

  if (abiflags->fp_abi != elfcpp::Val_GNU_MIPS_ABI_FP_ANY
      && abiflags->fp_abi != elfcpp::Val_GNU_MIPS_ABI_FP_SOFT
      && abiflags->fp_abi != elfcpp::Val_GNU_MIPS_ABI_FP_64A
      && abiflags->isa_level >= 32
      && abiflags->isa_ext != elfcpp::AFL_EXT_LOONGSON_3A)
    abiflags->flags1 |= elfcpp::AFL_FLAGS1_ODDSPREG;
}

// Create abiflags from elf header or from .MIPS.abiflags section.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::create_abiflags(
    Nanomips_relobj<size, big_endian>* relobj,
    Mips_abiflags<big_endian>* abiflags)
{
  Mips_abiflags<big_endian>* sec_abiflags = relobj->abiflags();
  Mips_abiflags<big_endian> header_abiflags;

  this->infer_abiflags(relobj, &header_abiflags);

  if (sec_abiflags == NULL)
    {
      // If there is no input .MIPS.abiflags section, use abiflags created
      // from elf header.
      *abiflags = header_abiflags;
      return;
    }

  this->has_abiflags_section_ = true;

  // It is not possible to infer the correct ISA revision for R3 or R5
  // so drop down to R2 for the checks.
  unsigned char isa_rev = sec_abiflags->isa_rev;
  if (isa_rev == 3 || isa_rev == 5)
    isa_rev = 2;

  // Check compatibility between abiflags created from elf header
  // and abiflags from .MIPS.abiflags section in this object file.
  if (this->level_rev(sec_abiflags->isa_level, isa_rev)
      < this->level_rev(header_abiflags.isa_level, header_abiflags.isa_rev))
    gold_warning(_("%s: Inconsistent ISA between e_flags and .MIPS.abiflags"),
                 relobj->name().c_str());
  if (header_abiflags.fp_abi != elfcpp::Val_GNU_MIPS_ABI_FP_ANY
      && sec_abiflags->fp_abi != header_abiflags.fp_abi)
    gold_warning(_("%s: Inconsistent FP ABI between .gnu.attributes and "
                   ".MIPS.abiflags"), relobj->name().c_str());
  if ((sec_abiflags->ases & header_abiflags.ases) != header_abiflags.ases)
    gold_warning(_("%s: Inconsistent ASEs between e_flags and .MIPS.abiflags"),
                 relobj->name().c_str());
  // The isa_ext is allowed to be an extension of what can be inferred
  // from e_flags.
  if (!this->mips_mach_extends(this->mips_isa_ext_mach(header_abiflags.isa_ext),
                               this->mips_isa_ext_mach(sec_abiflags->isa_ext)))
    gold_warning(_("%s: Inconsistent ISA extensions between e_flags and "
                   ".MIPS.abiflags"), relobj->name().c_str());
  // Use abiflags from .MIPS.abiflags section.
  *abiflags = *sec_abiflags;
}

// Return the meaning of fp_abi, or "unknown" if not known.

template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::fp_abi_string(int fp)
{
  switch (fp)
    {
    case elfcpp::Val_GNU_MIPS_ABI_FP_DOUBLE:
      return "-mdouble-float";
    case elfcpp::Val_GNU_MIPS_ABI_FP_SINGLE:
      return "-msingle-float";
    case elfcpp::Val_GNU_MIPS_ABI_FP_SOFT:
      return "-msoft-float";
    case elfcpp::Val_GNU_MIPS_ABI_FP_OLD_64:
      return _("-mips32r2 -mfp64 (12 callee-saved)");
    case elfcpp::Val_GNU_MIPS_ABI_FP_XX:
      return "-mfpxx";
    case elfcpp::Val_GNU_MIPS_ABI_FP_64:
      return "-mgp32 -mfp64";
    case elfcpp::Val_GNU_MIPS_ABI_FP_64A:
      return "-mgp32 -mfp64 -mno-odd-spreg";
    default:
      return "unknown";
    }
}

// Select fp_abi.

template<int size, bool big_endian>
int
Target_nanomips<size, big_endian>::select_fp_abi(
    const std::string& name,
    int in_fp,
    int out_fp)
{
  if (in_fp == out_fp)
    return out_fp;

  if (out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_ANY)
    return in_fp;
  else if (out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_XX
           && (in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_DOUBLE
               || in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64
               || in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64A))
    return in_fp;
  else if (in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_XX
           && (out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_DOUBLE
               || out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64
               || out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64A))
    return out_fp; // Keep the current setting.
  else if (out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64A
           && in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64)
    return in_fp;
  else if (in_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64A
           && out_fp == elfcpp::Val_GNU_MIPS_ABI_FP_64)
    return out_fp; // Keep the current setting.
  else if (in_fp != elfcpp::Val_GNU_MIPS_ABI_FP_ANY)
    gold_warning(_("%s: FP ABI %s is incompatible with %s"), name.c_str(),
                 fp_abi_string(in_fp), fp_abi_string(out_fp));
  return out_fp;
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

  out_attr[elfcpp::Tag_GNU_MIPS_ABI_FP].set_type(1);
  out_attr[elfcpp::Tag_GNU_MIPS_ABI_FP].set_int_value(this->abiflags_->fp_abi);

  // Merge Tag_compatibility attributes and any common GNU ones.
  this->attributes_section_data_->merge(name.c_str(), pasd);
}

// Merge abiflags from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_abiflags(const std::string& name,
    Mips_abiflags<big_endian>* in_abiflags)
{
  // If output has no abiflags, just copy.
  if (this->abiflags_ == NULL)
  {
    this->abiflags_ = new Mips_abiflags<big_endian>(*in_abiflags);
    return;
  }

  this->abiflags_->fp_abi = this->select_fp_abi(name, in_abiflags->fp_abi,
                                                this->abiflags_->fp_abi);

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
  this->abiflags_->ases |= in_abiflags->ases;
  this->abiflags_->flags1 |= in_abiflags->flags1;
  this->abiflags_->flags2 |= in_abiflags->flags2;
}

// Merge reginfo from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_reginfo(
    Mips_reginfo<size, big_endian>* in_reginfo)
{
  // Don't do anything if there is no input .reginfo section.
  if (in_reginfo == NULL)
    return;

  // If output has no reginfo, just copy.
  if (this->reginfo_ == NULL)
  {
    this->reginfo_ = new Mips_reginfo<size, big_endian>(*in_reginfo);
    return;
  }

  this->reginfo_->gprmask |= in_reginfo->gprmask;
  this->reginfo_->cprmask1 |= in_reginfo->cprmask1;
  this->reginfo_->cprmask2 |= in_reginfo->cprmask2;
  this->reginfo_->cprmask3 |= in_reginfo->cprmask3;
  this->reginfo_->cprmask4 |= in_reginfo->cprmask4;
}

// Check whether machine EXTENSION is an extension of machine BASE.
template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::mips_mach_extends(unsigned int base,
                                                     unsigned int extension)
{
  if (extension == base)
    return true;

  if ((base == mach_mipsisa32)
      && this->mips_mach_extends(mach_mipsisa64, extension))
    return true;

  if ((base == mach_mipsisa32r2)
      && this->mips_mach_extends(mach_mipsisa64r2, extension))
    return true;

  if ((base == mach_nanomipsisa32r6)
      && this->mips_mach_extends(mach_nanomipsisa32r6, extension))
    return true;

  for (unsigned int i = 0; i < this->mips_mach_extensions_.size(); ++i)
    if (extension == this->mips_mach_extensions_[i].first)
      {
        extension = this->mips_mach_extensions_[i].second;
        if (extension == base)
          return true;
      }

  return false;
}

// Merge file header flags from input object.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::merge_obj_e_flags(const std::string& name,
                                                     elfcpp::Elf_Word in_flags)
{
  // If flags are not set yet, just copy them.
  if (!this->are_processor_specific_flags_set())
    {
      this->set_processor_specific_flags(in_flags);
      this->mach_ = this->elf_mips_mach(in_flags);
      return;
    }

  elfcpp::Elf_Word new_flags = in_flags;
  elfcpp::Elf_Word old_flags = this->processor_specific_flags();
  elfcpp::Elf_Word merged_flags = this->processor_specific_flags();
  merged_flags |= new_flags & elfcpp::EF_MIPS_NOREORDER;

  // Check flag compatibility.
  new_flags &= ~elfcpp::EF_MIPS_NOREORDER;
  old_flags &= ~elfcpp::EF_MIPS_NOREORDER;

  // Some IRIX 6 BSD-compatibility objects have this bit set.  It
  // doesn't seem to matter.
  new_flags &= ~elfcpp::EF_MIPS_XGOT;
  old_flags &= ~elfcpp::EF_MIPS_XGOT;

  // MIPSpro generates ucode info in n64 objects.  Again, we should
  // just be able to ignore this.
  new_flags &= ~elfcpp::EF_MIPS_UCODE;
  old_flags &= ~elfcpp::EF_MIPS_UCODE;

  if (new_flags == old_flags)
    {
      this->set_processor_specific_flags(merged_flags);
      return;
    }

  if (((new_flags & (elfcpp::EF_MIPS_PIC | elfcpp::EF_MIPS_CPIC)) != 0)
      != ((old_flags & (elfcpp::EF_MIPS_PIC | elfcpp::EF_MIPS_CPIC)) != 0))
    gold_warning(_("%s: linking abicalls files with non-abicalls files"),
                 name.c_str());

  if (new_flags & (elfcpp::EF_MIPS_PIC | elfcpp::EF_MIPS_CPIC))
    merged_flags |= elfcpp::EF_MIPS_CPIC;
  if (!(new_flags & elfcpp::EF_MIPS_PIC))
    merged_flags &= ~elfcpp::EF_MIPS_PIC;

  new_flags &= ~(elfcpp::EF_MIPS_PIC | elfcpp::EF_MIPS_CPIC);
  old_flags &= ~(elfcpp::EF_MIPS_PIC | elfcpp::EF_MIPS_CPIC);

  // Compare the ISAs.
  if (mips_32bit_flags(old_flags) != mips_32bit_flags(new_flags))
    gold_error(_("%s: linking 32-bit code with 64-bit code"), name.c_str());
  else if (!this->mips_mach_extends(this->elf_mips_mach(in_flags), this->mach_))
    {
      // Output ISA isn't the same as, or an extension of, input ISA.
      if (this->mips_mach_extends(this->mach_, this->elf_mips_mach(in_flags)))
        {
          // Copy the architecture info from input object to output.  Also copy
          // the 32-bit flag (if set) so that we continue to recognise
          // output as a 32-bit binary.
          this->mach_ = this->elf_mips_mach(in_flags);
          merged_flags &= ~(elfcpp::EF_MIPS_ARCH | elfcpp::EF_MIPS_MACH);
          merged_flags |= (new_flags & (elfcpp::EF_MIPS_ARCH
                           | elfcpp::EF_MIPS_MACH | elfcpp::EF_MIPS_32BITMODE));

          // Update the ABI flags isa_level, isa_rev, isa_ext fields.
          this->update_abiflags_isa(name, merged_flags, this->abiflags_);

          // Copy across the ABI flags if output doesn't use them
          // and if that was what caused us to treat input object as 32-bit.
          if ((old_flags & elfcpp::EF_MIPS_ABI) == 0
              && this->mips_32bit_flags(new_flags)
              && !this->mips_32bit_flags(new_flags & ~elfcpp::EF_MIPS_ABI))
            merged_flags |= new_flags & elfcpp::EF_MIPS_ABI;
        }
      else
        // The ISAs aren't compatible.
        gold_error(_("%s: linking %s module with previous %s modules"),
                   name.c_str(), this->elf_mips_mach_name(in_flags),
                   this->elf_mips_mach_name(merged_flags));
    }

  new_flags &= (~(elfcpp::EF_MIPS_ARCH | elfcpp::EF_MIPS_MACH
                | elfcpp::EF_MIPS_32BITMODE));
  old_flags &= (~(elfcpp::EF_MIPS_ARCH | elfcpp::EF_MIPS_MACH
                | elfcpp::EF_MIPS_32BITMODE));

  // Compare ABIs.
  if ((new_flags & elfcpp::EF_MIPS_ABI) != (old_flags & elfcpp::EF_MIPS_ABI))
    {
      // Only error if both are set (to different values).
      if ((new_flags & elfcpp::EF_MIPS_ABI)
           && (old_flags & elfcpp::EF_MIPS_ABI))
        gold_error(_("%s: ABI mismatch: linking %s module with "
                     "previous %s modules"), name.c_str(),
                   this->elf_mips_abi_name(in_flags),
                   this->elf_mips_abi_name(merged_flags));

      new_flags &= ~elfcpp::EF_MIPS_ABI;
      old_flags &= ~elfcpp::EF_MIPS_ABI;
    }

  // Compare ASEs.  Forbid linking MIPS16 and microMIPS ASE modules together
  // and allow arbitrary mixing of the remaining ASEs (retain the union).
  if ((new_flags & elfcpp::EF_MIPS_ARCH_ASE)
      != (old_flags & elfcpp::EF_MIPS_ARCH_ASE))
    {
      int old_micro = old_flags & elfcpp::EF_MIPS_ARCH_ASE_MICROMIPS;
      int new_micro = new_flags & elfcpp::EF_MIPS_ARCH_ASE_MICROMIPS;
      int old_m16 = old_flags & elfcpp::EF_MIPS_ARCH_ASE_M16;
      int new_m16 = new_flags & elfcpp::EF_MIPS_ARCH_ASE_M16;
      int micro_mis = old_m16 && new_micro;
      int m16_mis = old_micro && new_m16;

      if (m16_mis || micro_mis)
        gold_error(_("%s: ASE mismatch: linking %s module with "
                     "previous %s modules"), name.c_str(),
                   m16_mis ? "MIPS16" : "microMIPS",
                   m16_mis ? "microMIPS" : "MIPS16");

      merged_flags |= new_flags & elfcpp::EF_MIPS_ARCH_ASE;

      new_flags &= ~ elfcpp::EF_MIPS_ARCH_ASE;
      old_flags &= ~ elfcpp::EF_MIPS_ARCH_ASE;
    }

  // Compare NaN encodings.
  if ((new_flags & elfcpp::EF_MIPS_NAN2008)
      != (old_flags & elfcpp::EF_MIPS_NAN2008))
    {
      gold_error(_("%s: linking %s module with previous %s modules"),
                 name.c_str(),
                 (new_flags & elfcpp::EF_MIPS_NAN2008
                  ? "-mnan=2008" : "-mnan=legacy"),
                 (old_flags & elfcpp::EF_MIPS_NAN2008
                  ? "-mnan=2008" : "-mnan=legacy"));

      new_flags &= ~elfcpp::EF_MIPS_NAN2008;
      old_flags &= ~elfcpp::EF_MIPS_NAN2008;
    }

  // Compare FP64 state.
  if ((new_flags & elfcpp::EF_MIPS_FP64) != (old_flags & elfcpp::EF_MIPS_FP64))
    {
      gold_error(_("%s: linking %s module with previous %s modules"),
                 name.c_str(),
                 (new_flags & elfcpp::EF_MIPS_FP64
                  ? "-mfp64" : "-mfp32"),
                 (old_flags & elfcpp::EF_MIPS_FP64
                  ? "-mfp64" : "-mfp32"));

      new_flags &= ~elfcpp::EF_MIPS_FP64;
      old_flags &= ~elfcpp::EF_MIPS_FP64;
    }

  // Warn about any other mismatches.
  if (new_flags != old_flags)
    gold_error(_("%s: uses different e_flags (0x%x) fields than previous "
                 "modules (0x%x)"), name.c_str(), new_flags, old_flags);

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
  const bool relocatable = parameters->options().relocatable();

  for (Input_objects::Relobj_iterator p = input_objects->relobj_begin();
       p != input_objects->relobj_end();
       ++p)
    {
      Nanomips_relobj<size, big_endian>* relobj =
        Nanomips_relobj<size, big_endian>::as_nanomips_relobj(*p);

      if (!relobj->merge_processor_specific_data())
        continue;

      // Merge .reginfo contents of input objects.
      this->merge_obj_reginfo(relobj->reginfo());

      // Merge processor specific flags.
      Mips_abiflags<big_endian> in_abiflags;

      this->create_abiflags(relobj, &in_abiflags);
      this->merge_obj_e_flags(relobj->name(),
                              relobj->processor_specific_flags());
      this->merge_obj_abiflags(relobj->name(), &in_abiflags);
      this->merge_obj_attributes(relobj->name(),
                                 relobj->attributes_section_data());
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

  // Create .MIPS.abiflags output section if there is an input section.
  if (this->has_abiflags_section_)
    {
      Nanomips_output_section_abiflags<size, big_endian>* abiflags_section =
        new Nanomips_output_section_abiflags<size, big_endian>(*this->abiflags_);

      Output_section* os =
        layout->add_output_section_data(".MIPS.abiflags",
                                        elfcpp::SHT_MIPS_ABIFLAGS,
                                        elfcpp::SHF_ALLOC,
                                        abiflags_section, ORDER_INVALID, false);

      if (os != NULL && !relocatable)
        {
          Output_segment* abiflags_segment =
            layout->make_output_segment(elfcpp::PT_MIPS_ABIFLAGS, elfcpp::PF_R);
          abiflags_segment->add_output_section_to_nonload(os, elfcpp::PF_R);
        }
    }

  // Create a .reginfo section if we have merged any content from inputs.
  if (this->reginfo_ != NULL && !parameters->options().gc_sections())
    {
      // Create .reginfo output section.
      Nanomips_output_section_reginfo<size, big_endian>* reginfo_section =
        new Nanomips_output_section_reginfo<size, big_endian>(
            this, *this->reginfo_);

      Output_section* os =
        layout->add_output_section_data(".reginfo", elfcpp::SHT_MIPS_REGINFO,
                                        elfcpp::SHF_ALLOC, reginfo_section,
                                        ORDER_INVALID, false);

      if (os != NULL && !relocatable)
        {
          Output_segment* reginfo_segment =
            layout->make_output_segment(elfcpp::PT_MIPS_REGINFO,
                                        elfcpp::PF_R);
          reginfo_segment->add_output_section_to_nonload(os, elfcpp::PF_R);
        }
    }

  // Set _gp value.
  if (!parameters->options().relocatable())
    this->set_gp(layout, symtab);
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
  // Instruction size in bytes.
  unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
  value = psymval->value(relobj, r_addend) - (new_offset + insn_size);

  Reloc_funcs::nanomips_reloc_unshuffle(view, reloc_property);
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_PC_I32:
      reloc_status = Reloc_funcs::rel32(view, value);
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
  Reloc_funcs::nanomips_reloc_shuffle(view, reloc_property);

  // Report any errors.
  switch (reloc_status)
    {
    case Reloc_funcs::STATUS_OKAY:
      break;
    case Reloc_funcs::STATUS_OVERFLOW:
      if (sym == NULL)
        gold_error_at_location(relinfo, relnum, reloc.get_r_offset(),
                               _("relocation overflow: "
                                 "%s against local symbol %u: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(), r_sym,
                               (unsigned long long) value,
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
    default:
      gold_unreachable();
    }
}

// Scan an input section for relaxations and expansions.

template<int size, bool big_endian>
bool
Target_nanomips<size, big_endian>::scan_section_for_relax_or_expand(
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
      typedef Relax_nanomips_insn<size, big_endian> Relax;
      return this->scan_reloc_section_for_relax_or_expand<Relax>(
        relinfo,
        prelocs,
        reloc_count,
        os,
        pnis,
        view,
        view_address);
    }
  else if (this->state_ == EXPAND)
    {
      typedef Expand_nanomips_insn<size, big_endian> Expand;
      return this->scan_reloc_section_for_relax_or_expand<Expand>(
        relinfo,
        prelocs,
        reloc_count,
        os,
        pnis,
        view,
        view_address);
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
    const Relocate_info<size, big_endian>* relinfo,
    Output_section* os)
{
  const unsigned int reloc_size = elfcpp::Elf_sizes<size>::rela_size;
  Nanomips_input_section* pnis =
    new Nanomips_input_section(relobj, relinfo->data_shndx, os, reloc_size);
  pnis->init(relinfo->reloc_shndx);
  relobj->convert_input_section_to_relaxed_section(relinfo->data_shndx);
  return pnis;
}

// Update content for relaxations or expansions.

template<int size, bool big_endian>
void
Target_nanomips<size, big_endian>::update_content(
    Nanomips_input_section* pnis,
    Nanomips_relobj<size, big_endian>* relobj,
    Address address,
    int count,
    bool add_bytes,
    bool padding)
{
  gold_assert(pnis != NULL);
  typedef typename elfcpp::Rela<size, big_endian> Reltype;
  typedef typename elfcpp::Rela_write<size, big_endian> Reltype_write;
  const int reloc_size = elfcpp::Elf_sizes<size>::rela_size;

  if (add_bytes)
    // Add the bytes.
    pnis->add_bytes(address, count);
  else
    // Delete the bytes.
    pnis->delete_bytes(address, abs(count));

  size_t reloc_count = pnis->reloc_count();
  const unsigned char* prelocs_read = pnis->relocs();
  unsigned char* prelocs_write = pnis->relocs();

  // Adjust all the relocs.
  for (size_t i = 0;
       i < reloc_count;
       ++i,
       prelocs_read += reloc_size,
       prelocs_write += reloc_size)
    {
      Reltype reloc(prelocs_read);
      Reltype_write reloc_write(prelocs_write);
      Address r_offset = reloc.get_r_offset();
      unsigned int r_type = elfcpp::elf_r_type<size>(reloc.get_r_info());

      // Don't move ALIGN, FILL and MAX relocations if we are updating content
      // due to the alignment requirement.
      if (padding
          && (r_offset == address)
          && (r_type == elfcpp::R_NANOMIPS_ALIGN
              || r_type == elfcpp::R_NANOMIPS_FILL
              || r_type == elfcpp::R_NANOMIPS_MAX))
        continue;

      if (r_offset >= address)
        reloc_write.put_r_offset(r_offset + count);
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

// This function scans a relocation sections for relaxations or expansions.

template<int size, bool big_endian>
template<typename Nanomips_insn>
bool inline
Target_nanomips<size, big_endian>::scan_reloc_section_for_relax_or_expand(
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
  Nanomips_insn insn;

  // Whether we should run relaxation pass again.
  bool again = false;
  // Whether we might have disturbed the alignment required at R_NANOMIPS_ALIGN
  // relocation.
  bool do_align = false;
  // True if we have seen R_NANOMIPS_NORELAX relocation.
  bool seen_norelax = false;

  Comdat_behavior comdat_behavior = CB_UNDETERMINED;
  Relocatable_relocs* rr = relinfo->rr;
  Nanomips_relobj<size, big_endian>* relobj =
    Nanomips_relobj<size, big_endian>::as_nanomips_relobj(relinfo->object);
  const unsigned int local_count = relobj->local_symbol_count();
  const bool finalize_relocs = parameters->options().finalize_relocs();
  const bool relax_state = this->state_ == RELAX;

  for (size_t i = 0; i < reloc_count; ++i, prelocs += reloc_size)
    {
      Reltype reloc(prelocs);

      typename elfcpp::Elf_types<size>::Elf_WXword r_info = reloc.get_r_info();
      unsigned int r_sym = elfcpp::elf_r_sym<size>(r_info);
      unsigned int r_type = elfcpp::elf_r_type<size>(r_info);
      Address r_offset = reloc.get_r_offset();
      section_offset_type offset = convert_to_section_size_type(r_offset);

      // If this is a R_NANOMIPS_NORELAX relocation, set that we can't do
      // anything until we see R_NANOMIPS_RELAX.
      if (r_type == elfcpp::R_NANOMIPS_NORELAX)
        {
          seen_norelax = true;
          continue;
        }
      // If this is a R_NANOMIPS_RELAX relocation, set that we can change
      // following relocations.
      else if (r_type == elfcpp::R_NANOMIPS_RELAX)
        {
          seen_norelax = false;
          continue;
        }

      // Don't change relocations until we see R_NANOMIPS_RELAX.
      if (seen_norelax)
        continue;

      const Nanomips_reloc_property* reloc_property =
        nanomips_reloc_property_table->get_reloc_property(r_type);
      gold_assert(reloc_property != NULL);

      uint32_t input_insn =
        Insn_utilities::read_insn(view + offset, reloc_property->size());

      const Nanomips_insn_property* pnip = insn.find(input_insn, r_type);
      // If this isn't something that can be relaxed or expand, then ignore
      // this relocation.
      if ((pnip == NULL
           || !insn.can_be_changed(offset, i, reloc_count, prelocs))
          && (r_type != elfcpp::R_NANOMIPS_ALIGN || !do_align))
        continue;

      // Align first R_NANOMIPS_ALIGN found after relaxation or expansion.
      if (r_type == elfcpp::R_NANOMIPS_ALIGN)
        {
          gold_assert(do_align);
          do_align = false;

          // For R_NANOMIPS_ALIGN relocation, there is a local symbol in which
          // st_value holds the alignment requirement.
          gold_assert(r_sym < local_count);
          const Symbol_value<size>* psymval = relobj->local_symbol(r_sym);
          Valtype input_value = psymval->input_value();

          Address align = 1 << input_value;
          Address address = view_address + offset;
          Address new_address = align_address(address, align);

          // Calculate the padding required due to relaxation or expansion.
          Address new_padding = new_address - address;
          // Get the existing padding bytes.
          Address padding = relobj->do_local_symbol_size(r_sym);

          // nanoMIPS nop16 instruction.
          Valtype fill = 0x9008;
          Valtype max = static_cast<Valtype>(0) - 1;
          Size_type fill_size = 2;

          // Find fill value, fill size and max bytes generated by
          // the assembler.
          this->find_fill_max(r_offset, i, reloc_count, prelocs,
                              relobj, &fill, &max, &fill_size);

          // Set the padding required due to relaxation or expansion to 0, if
          // the padding bytes exceed max bytes.
          if (new_padding > max)
            new_padding = 0;

          // If the paddings are the same, don't do anything.
          if (new_padding == padding)
            continue;

          // If the padding required now is more/less than the existing padding,
          // then add/delete those extra bytes.
          bool add_bytes = new_padding > padding;
          int count = static_cast<int>(new_padding - padding);

          this->update_content(pnis, relobj, r_offset, count,
                               add_bytes, true);
          relobj->set_local_symbol_size(r_sym, new_padding);

          // Add required padding bytes.
          if (add_bytes)
            {
              if (fill_size > static_cast<Size_type>(count))
                {
                  fill = 0x9008;
                  fill_size = 2;
                }

              unsigned char* padding_view = pnis->section_contents() + offset;
              for (int j = 0;
                   j < count;
                   padding_view += fill_size,
                   j += fill_size)
                {
                  switch (fill_size)
                    {
                    case 1:
                      elfcpp::Swap<8, big_endian>::writeval(padding_view,
                                                            fill & 0xff);
                      break;
                    case 2:
                      elfcpp::Swap<16, big_endian>::writeval(padding_view,
                                                             fill & 0xffff);
                      break;
                    case 4:
                      Insn_utilities::put_insn_32(padding_view, fill);
                      break;
                    default:
                      gold_unreachable();
                    }
                }
            }
          continue;
        }

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
          if (!finalize_relocs && gsym->is_weak_undefined())
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
                gold_warning_at_location(relinfo, i, offset,
                                         _("relocation refers to discarded "
                                           "section"));
              symval2.set_output_value(0);
            }
          psymval = &symval2;
        }

      // Relocation value.
      Valtype value;
      typename elfcpp::Elf_types<size>::Elf_Swxword r_addend =
        reloc.get_r_addend();

      // Calculate relocation value.
      switch (r_type)
        {
        case elfcpp::R_NANOMIPS_PC25_S1:
        case elfcpp::R_NANOMIPS_PC21_S1:
        case elfcpp::R_NANOMIPS_PC14_S1:
        case elfcpp::R_NANOMIPS_PC11_S1:
        case elfcpp::R_NANOMIPS_PC10_S1:
        case elfcpp::R_NANOMIPS_PC7_S1:
        case elfcpp::R_NANOMIPS_PC4_S1:
          {
            // Instruction size in bytes.
            unsigned int insn_size = reloc_property->size() == 16 ? 2 : 4;
            // Address of the next pc.
            Address address = view_address + offset + insn_size;
            value = psymval->value(relobj, r_addend) - address;
            break;
          }
        case elfcpp::R_NANOMIPS_LO12:
        case elfcpp::R_NANOMIPS_LO4_S2:
          value = psymval->value(relobj, r_addend) & 0xfff;
          break;
        case elfcpp::R_NANOMIPS_GPREL19_S2:
        case elfcpp::R_NANOMIPS_GPREL18:
        case elfcpp::R_NANOMIPS_GPREL17_S1:
        case elfcpp::R_NANOMIPS_GPREL7_S2:
          {
            Address gp = 0;
            if (this->gp_ != NULL)
              {
                // We need to compute the would-be final value of the gp.
                const Symbol_table* symtab = relinfo->symtab;
                Symbol_table::Compute_final_value_status status;
                gp = symtab->compute_final_value<size>(this->gp_, &status);

                if (status != Symbol_table::CFVS_OK)
                  continue;
              }

            value = psymval->value(relobj, r_addend) - gp;
            break;
          }
        default:
          gold_unreachable();
        }

      // Check the range of the relocation.
      if (finalize_relocs)
        {
          if (!insn.relocatable_check_range(value, r_type, i, relinfo, psymval,
                                            r_sym, gsym != NULL))
            continue;
        }
      else if (!insn.check_range(value, r_type))
        continue;

      // That will change things, so we should relax or expand again.
      again = true;

      // We might have disturbed the alignment required at
      // R_NANOMIPS_ALIGN relocation.
      do_align = true;

      // Create a new relaxed input section if needed.
      if (pnis == NULL)
        pnis = this->new_nanomips_input_section(relobj, relinfo, os);

      // Find correct instruction property.
      insn.find_property(input_insn, &pnip, r_type);

      // Update content for relaxation or expansion.
      this->update_content(pnis, relobj, r_offset + pnip->offset(),
                           pnip->count(), !relax_state, false);

      unsigned char* input_view = pnis->section_contents() + offset;
      unsigned char* input_preloc = pnis->relocs() + i * reloc_size;
      unsigned char new_reloc[reloc_size];

      // Relax/expand instruction.
      bool reloc_added = insn.change(input_insn, pnip, input_view,
                                     input_preloc, new_reloc);

      if (reloc_added)
        {
          pnis->add_reloc(new_reloc, reloc_size);
          // For new relocation, we just use strategy from the current
          // relocation.  This is used for --emit-relocs and
          // --finalize-relocs options.
          if (rr != NULL)
            rr->set_next_reloc_strategy(rr->strategy(i));
        }

      if (is_debugging_enabled(DEBUG_TARGET))
        insn.print(relobj->name(), relobj->section_name(relinfo->data_shndx),
                   (unsigned long) r_offset, pnip);

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

      os->set_section_offsets_need_adjustment();
    }

  return again;
}

template<int size, bool big_endian>
inline void
Target_nanomips<size, big_endian>::Scan::local(
    Symbol_table*, /*symtab ,*/
    Layout*, /*layout,*/
    Target_nanomips<size, big_endian>*, /* target,*/
    Sized_relobj_file<size, big_endian>* object,
    unsigned int data_shndx,
    Output_section*, /* output_section,*/
    const elfcpp::Rela<size, big_endian>& reloc,
    unsigned int r_type,
    const elfcpp::Sym<size, big_endian>& lsym,
    bool is_discarded)
{
  Address r_offset = reloc.get_r_offset();

  // Check if section reference should be added.
  if (this->ref_relobj_ != NULL
      && ((r_type != elfcpp::R_NANOMIPS_INSN32
           && r_type != elfcpp::R_NANOMIPS_FIXED)
          || this->ref_r_offset_ != r_offset))
    {
      gold_assert(this->ref_shndx_ != invalid_index);
      this->ref_relobj_->add_input_section_ref(this->ref_shndx_);
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
      if (!this->seen_norelax_)
        {
          section_size_type view_size = 0;
          const unsigned char* view = relobj->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          view += r_offset;
          Relax_nanomips_insn<size, big_endian> relax_insn;
          uint32_t insn = Insn_utilities::read_insn(view, nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find(insn, r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              unsigned int shndx = lsym.get_st_shndx();
              bool is_ordinary;
              shndx = relobj->adjust_sym_shndx(r_sym, shndx, &is_ordinary);
              if (is_ordinary)
                {
                  // We need to check if this relocation is marked with INSN32
                  // or FIXED relocation.  In that case, we can't increase
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
    Symbol_table*, /*symtab,*/
    Layout*, /* layout,*/
    Target_nanomips<size, big_endian>*, /* target,*/
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

  // Check if section reference should be added.
  if (this->ref_relobj_ != NULL)
    {
      gold_assert(this->ref_shndx_ != invalid_index);
      gold_assert(this->ref_r_offset_ != invalid_address);
      this->ref_relobj_->add_input_section_ref(this->ref_shndx_);
    }

  this->ref_r_offset_ = invalid_address;
  this->ref_relobj_ = NULL;
  this->ref_shndx_ = invalid_index;

  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_GPREL19_S2:
      if (gsym->source() == Symbol::FROM_OBJECT
          && !this->seen_norelax_)
        {
          section_size_type view_size = 0;
          const unsigned char* view = object->section_contents(data_shndx,
                                                               &view_size,
                                                               false);
          view += r_offset;
          Relax_nanomips_insn<size, big_endian> relax_insn;
          uint32_t insn = Insn_utilities::read_insn(view, nrp->size());
          const Nanomips_insn_property* insn_property =
            relax_insn.find(insn, r_type);

          // Check if a lw[gp]/sw[gp] instruction can be relaxed into
          // lw[gp16]/sw[gp16] in a relaxation pass.
          if (insn_property != NULL)
            {
              bool is_ordinary;
              unsigned int shndx = gsym->shndx(&is_ordinary);
              Nanomips_relobj<size, big_endian>* sym_obj =
                static_cast<Nanomips_relobj<size, big_endian>*>(gsym->object());
              if (is_ordinary)
                {
                  // We need to check if this relocation is marked with INSN32
                  // or FIXED relocation.  In that case, we can't increase
                  // reference to the section.
                  this->ref_r_offset_ = r_offset;
                  this->ref_relobj_ = sym_obj;
                  this->ref_shndx_ = shndx;
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
  Output_relaxed_input_section* poris =
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
    case elfcpp::R_NANOMIPS_NONE:
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
        // Instruction size in bytes.
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

  // Apply relocation and check for errors.
  Reloc_funcs::nanomips_reloc_unshuffle(view, reloc_property);
  switch (r_type)
    {
    case elfcpp::R_NANOMIPS_NONE:
      break;
    case elfcpp::R_NANOMIPS_32:
    case elfcpp::R_NANOMIPS_I32:
    case elfcpp::R_NANOMIPS_PC_I32:
    case elfcpp::R_NANOMIPS_GPREL_I32:
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
      reloc_status = Reloc_funcs::relhi20(view, value);
      break;
    case elfcpp::R_NANOMIPS_LO12:
    case elfcpp::R_NANOMIPS_GPREL_LO12:
      reloc_status = Reloc_funcs::rello12(view, value);
      break;
    case elfcpp::R_NANOMIPS_LO4_S2:
      reloc_status = Reloc_funcs::rello4_s2(view, value, check_overflow);
      break;
    case elfcpp::R_NANOMIPS_NEG:
    case elfcpp::R_NANOMIPS_ASHIFTR_1:
      reloc_status = Reloc_funcs::relsize(view, value);
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
    default:
      gold_error_at_location(relinfo, relnum, r_offset,
                             _("unsupported reloc %s"),
                             reloc_property->name().c_str());
      break;
    }
  Reloc_funcs::nanomips_reloc_shuffle(view, reloc_property);

  // Report any errors.
  switch (reloc_status)
    {
    case Reloc_funcs::STATUS_OKAY:
      break;
    case Reloc_funcs::STATUS_OVERFLOW:
      if (gsym == NULL)
        gold_error_at_location(relinfo, relnum, r_offset,
                               _("relocation overflow: "
                                 "%s against local symbol %u: "
                                 "cannot encode a value of %#llx "
                                 "in a field of %u bits"),
                               reloc_property->name().c_str(), r_sym,
                               (unsigned long long) value,
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

// Return printable name for ABI.
template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::elf_mips_abi_name(elfcpp::Elf_Word e_flags)
{
  switch (e_flags & elfcpp::EF_MIPS_ABI)
    {
    case 0:
      if ((e_flags & elfcpp::EF_MIPS_ABI2) != 0)
        return "N32";
      else if (size == 64)
        return "64";
      else
        return "none";
    case elfcpp::E_MIPS_ABI_O32:
      return "O32";
    case elfcpp::E_MIPS_ABI_O64:
      return "O64";
    case elfcpp::E_MIPS_ABI_EABI32:
      return "EABI32";
    case elfcpp::E_MIPS_ABI_EABI64:
      return "EABI64";
    default:
      return "unknown abi";
    }
}

template<int size, bool big_endian>
const char*
Target_nanomips<size, big_endian>::elf_mips_mach_name(elfcpp::Elf_Word e_flags)
{
  switch (e_flags & elfcpp::EF_MIPS_MACH)
    {
    case elfcpp::E_MIPS_MACH_3900:
      return "mips:3900";
    case elfcpp::E_MIPS_MACH_4010:
      return "mips:4010";
    case elfcpp::E_MIPS_MACH_4100:
      return "mips:4100";
    case elfcpp::E_MIPS_MACH_4111:
      return "mips:4111";
    case elfcpp::E_MIPS_MACH_4120:
      return "mips:4120";
    case elfcpp::E_MIPS_MACH_4650:
      return "mips:4650";
    case elfcpp::E_MIPS_MACH_5400:
      return "mips:5400";
    case elfcpp::E_MIPS_MACH_5500:
      return "mips:5500";
    case elfcpp::E_MIPS_MACH_5900:
      return "mips:5900";
    case elfcpp::E_MIPS_MACH_SB1:
      return "mips:sb1";
    case elfcpp::E_MIPS_MACH_9000:
      return "mips:9000";
    case elfcpp::E_MIPS_MACH_LS2E:
      return "mips:loongson_2e";
    case elfcpp::E_MIPS_MACH_LS2F:
      return "mips:loongson_2f";
    case elfcpp::E_MIPS_MACH_LS3A:
      return "mips:loongson_3a";
    case elfcpp::E_MIPS_MACH_OCTEON:
      return "mips:octeon";
    case elfcpp::E_MIPS_MACH_OCTEON2:
      return "mips:octeon2";
    case elfcpp::E_MIPS_MACH_OCTEON3:
      return "mips:octeon3";
    case elfcpp::E_MIPS_MACH_XLR:
      return "mips:xlr";
    default:
      switch (e_flags & elfcpp::EF_MIPS_ARCH)
        {
        default:
        case elfcpp::E_MIPS_ARCH_1:
          return "mips:3000";

        case elfcpp::E_MIPS_ARCH_2:
          return "mips:6000";

        case elfcpp::E_MIPS_ARCH_3:
          return "mips:4000";

        case elfcpp::E_MIPS_ARCH_4:
          return "mips:8000";

        case elfcpp::E_MIPS_ARCH_5:
          return "mips:mips5";

        case elfcpp::E_MIPS_ARCH_32:
          return "mips:isa32";

        case elfcpp::E_MIPS_ARCH_64:
          return "mips:isa64";

        case elfcpp::E_MIPS_ARCH_32R2:
          return "mips:isa32r2";

        case elfcpp::E_MIPS_ARCH_32R6:
          return "mips:isa32r6";

        case elfcpp::E_MIPS_ARCH_64R2:
          return "mips:isa64r2";

        case elfcpp::E_MIPS_ARCH_64R6:
          return "mips:isa64r6";

        case elfcpp::E_NANOMIPS_ARCH_32R6:
          return "nanomips:isa32r6";

        case elfcpp::E_NANOMIPS_ARCH_64R6:
          return "nanomips:isa64r6";
        }
    }
    return "unknown CPU";
}

template<int size, bool big_endian>
const Target::Target_info Target_nanomips<size, big_endian>::nanomips_info =
{
  size,                 // size
  big_endian,           // is_big_endian
  elfcpp::EM_NANOMIPS,  // machine_code
  false,                // has_make_symbol
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
