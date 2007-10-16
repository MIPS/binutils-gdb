// parameters.cc -- general parameters for a link using gold

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

#include "gold.h"

#include "options.h"
#include "parameters.h"

namespace gold
{

// Initialize the parameters from the options.

Parameters::Parameters(const General_options* options, Errors* errors)
  : errors_(errors), output_file_name_(options->output_file_name()),
    sysroot_(options->sysroot()),
    is_doing_static_link_valid_(false), doing_static_link_(false),
    is_size_and_endian_valid_(false), size_(0), is_big_endian_(false),
    optimization_level_(options->optimization_level()),
    export_dynamic_(options->export_dynamic())
{
  if (options->is_shared())
    this->output_file_type_ = OUTPUT_SHARED;
  else if (options->is_relocatable())
    this->output_file_type_ = OUTPUT_OBJECT;
  else
    this->output_file_type_ = OUTPUT_EXECUTABLE;

  if (options->strip_all())
    this->strip_ = STRIP_ALL;
  else if (options->strip_debug())
    this->strip_ = STRIP_DEBUG;
  else
    this->strip_ = STRIP_NONE;
}

// Set whether we are doing a static link.

void
Parameters::set_doing_static_link(bool doing_static_link)
{
  this->doing_static_link_ = doing_static_link;
  this->is_doing_static_link_valid_ = true;
}

// Set the size and endianness.

void
Parameters::set_size_and_endianness(int size, bool is_big_endian)
{
  if (!this->is_size_and_endian_valid_)
    {
      this->size_ = size;
      this->is_big_endian_ = is_big_endian;
      this->is_size_and_endian_valid_ = true;
    }
  else
    {
      gold_assert(size == this->size_);
      gold_assert(is_big_endian == this->is_big_endian_);
    }
}

// Our local version of the variable, which is not const.

static Parameters* static_parameters;

// The global variable.

const Parameters* parameters;

// Initialize the global variable.

void
initialize_parameters(const General_options* options, Errors* errors)
{
  parameters = static_parameters = new Parameters(options, errors);
}

// Set whether we are doing a static link.

void
set_parameters_doing_static_link(bool doing_static_link)
{
  static_parameters->set_doing_static_link(doing_static_link);
}

// Set the size and endianness.

void
set_parameters_size_and_endianness(int size, bool is_big_endian)
{
  static_parameters->set_size_and_endianness(size, is_big_endian);
}

} // End namespace gold.
