// version.c -- print gold version information

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

#include "../bfd/bfdver.h"

namespace gold
{

// The version of gold.

// FIXME: This should eventually be PACKAGE_VERSION, and get the
// version number from configure.ac.  But it's easier to just change
// this file for now.

static const char* version_string = "0.1";

// Report version information.

void
print_version(bool print_short)
{
  /* xgettext:c-format */
  printf("GNU gold (GNU binutils %s) version %s\n",
	 BFD_VERSION_STRING, version_string);

  if (!print_short)
    {
      // This output is intended to follow the GNU standards.
      printf (_("Copyright 2007 Free Software Foundation, Inc.\n"));
      printf (_("\
This program is free software; you may redistribute it under the terms of\n\
the GNU General Public License version 3 or (at your option) a later version.\n\
This program has absolutely no warranty.\n"));
    }
}

} // End namespace gold.
