// parameters.h -- general parameters for a link using gold  -*- C++ -*-

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

#ifndef GOLD_PARAMETERS_H
#define GOLD_PARAMETERS_H

namespace gold
{

class General_options;
class Errors;

// Here we define the Parameters class which simply holds simple
// general parameters which apply to the entire link.  We use a global
// variable for this.  This is in contrast to the General_options
// class, which holds the complete state of position independent
// command line options.  The hope is that Parameters will stay fairly
// simple, so that if this turns into a library it will be clear how
// these parameters should be set.

class Parameters
{
 public:
  Parameters(Errors*);

  // Return the error object.
  Errors*
  errors() const
  { return this->errors_; }

  // Return the output file name.
  const char*
  output_file_name() const
  {
    gold_assert(this->options_valid_);
    return this->output_file_name_;
  }

  // Whether we are generating a regular executable.
  bool
  output_is_executable() const
  {
    gold_assert(this->output_file_type_ != OUTPUT_INVALID);
    return this->output_file_type_ == OUTPUT_EXECUTABLE;
  }

  // Whether we are generating a shared library.
  bool
  output_is_shared() const
  {
    gold_assert(this->output_file_type_ != OUTPUT_INVALID);
    return this->output_file_type_ == OUTPUT_SHARED;
  }

  // Whether we are generating an object file.
  bool
  output_is_object() const
  {
    gold_assert(this->output_file_type_ != OUTPUT_INVALID);
    return this->output_file_type_ == OUTPUT_OBJECT;
  }

  // Whether we are generating position-independent output.
  // This is the case when generating either a shared library
  // or a regular executable with the --pic-executable option.
  // FIXME: support --pic-executable
  bool
  output_is_position_independent() const
  { return output_is_shared(); }

  // The target system root directory.  This is NULL if there isn't
  // one.
  const std::string&
  sysroot() const
  {
    gold_assert(this->options_valid_);
    return this->sysroot_;
  }

  // Whether to strip all symbols.
  bool
  strip_all() const
  {
    gold_assert(this->strip_ != STRIP_INVALID);
    return this->strip_ == STRIP_ALL;
  }

  // Whether to strip debugging information.
  bool
  strip_debug() const
  {
    gold_assert(this->strip_ != STRIP_INVALID);
    return this->strip_ == STRIP_ALL || this->strip_ == STRIP_DEBUG;
  }

  // Whether we are doing a symbolic link, in which all defined
  // symbols are bound locally.
  bool
  symbolic() const
  {
    gold_assert(this->options_valid_);
    return this->symbolic_;
  }

  // The general linker optimization level.
  int
  optimization_level() const
  {
    gold_assert(this->options_valid_);
    return this->optimization_level_;
  }

  // Whether the -E/--export-dynamic flag is set.
  bool
  export_dynamic() const
  {
    gold_assert(this->options_valid_);
    return this->export_dynamic_;
  }

  // Whether we are doing a static link--a link in which none of the
  // input files are shared libraries.  This is only known after we
  // have seen all the input files.
  bool
  doing_static_link() const
  {
    gold_assert(this->is_doing_static_link_valid_);
    return this->doing_static_link_;
  }

  // The size of the output file we are generating.  This should
  // return 32 or 64.
  int
  get_size() const
  {
    gold_assert(this->is_size_and_endian_valid_);
    return this->size_;
  }

  // Whether the output is big endian.
  bool
  is_big_endian() const
  {
    gold_assert(this->is_size_and_endian_valid_);
    return this->is_big_endian_;
  }

  // Set values recorded from options.
  void
  set_from_options(const General_options*);

  // Set whether we are doing a static link.
  void
  set_doing_static_link(bool doing_static_link);

  // Set the size and endianness.
  void
  set_size_and_endianness(int size, bool is_big_endian);

 private:
  // The types of output files.
  enum Output_file_type
    {
      // Uninitialized.
      OUTPUT_INVALID,
      // Generating executable.
      OUTPUT_EXECUTABLE,
      // Generating shared library.
      OUTPUT_SHARED,
      // Generating object file.
      OUTPUT_OBJECT
    };

  // Which symbols to strip.
  enum Strip
  {
    // Uninitialize.
    STRIP_INVALID,
    // Don't strip any symbols.
    STRIP_NONE,
    // Strip all symbols.
    STRIP_ALL,
    // Strip debugging information.
    STRIP_DEBUG
  };

  // A pointer to the error handling object.
  Errors* errors_;

  // Whether the fields set from the options are valid.
  bool options_valid_;
  // The output file name.
  const char* output_file_name_;
  // The type of the output file.
  Output_file_type output_file_type_;
  // The target system root directory.
  std::string sysroot_;
  // Which symbols to strip.
  Strip strip_;
  // Whether we are doing a symbolic link.
  bool symbolic_;
  // The optimization level.
  int optimization_level_;
  // Whether the -E/--export-dynamic flag is set.
  bool export_dynamic_;

  // Whether the doing_static_link_ field is valid.
  bool is_doing_static_link_valid_;
  // Whether we are doing a static link.
  bool doing_static_link_;
  // Whether the size_ and is_big_endian_ fields are valid.
  bool is_size_and_endian_valid_;
  // The size of the output file--32 or 64.
  int size_;
  // Whether the output file is big endian.
  bool is_big_endian_;
};

// This is a global variable.
extern const Parameters* parameters;

// Initialize the global variable.
extern void initialize_parameters(Errors*);

// Set the options.
extern void set_parameters_from_options(const General_options*);

// Set the size and endianness of the global parameters variable.
extern void set_parameters_size_and_endianness(int size, bool is_big_endian);

// Set whether we are doing a static link.
extern void set_parameters_doing_static_link(bool doing_static_link);

} // End namespace gold.

#endif // !defined(GOLD_PARAMETERS_H)
