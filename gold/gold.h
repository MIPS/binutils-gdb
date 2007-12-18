// gold.h -- general definitions for gold   -*- C++ -*-

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

#ifndef GOLD_GOLD_H
#define GOLD_GOLD_H

#include "config.h"
#include "ansidecl.h"

#ifdef ENABLE_NLS
# include <libintl.h>
# define _(String) gettext (String)
# ifdef gettext_noop
#  define N_(String) gettext_noop (String)
# else
#  define N_(String) (String)
# endif
#else
# define gettext(Msgid) (Msgid)
# define dgettext(Domainname, Msgid) (Msgid)
# define dcgettext(Domainname, Msgid, Category) (Msgid)
# define textdomain(Domainname) while (0) /* nothing */
# define bindtextdomain(Domainname, Dirname) while (0) /* nothing */
# define _(String) (String)
# define N_(String) (String)
#endif

// Figure out how to get a hash set and a hash map.

#if defined(HAVE_TR1_UNORDERED_SET) && defined(HAVE_TR1_UNORDERED_MAP)

#include <tr1/unordered_set>
#include <tr1/unordered_map>

// We need a template typedef here.

#define Unordered_set std::tr1::unordered_set
#define Unordered_map std::tr1::unordered_map

#elif defined(HAVE_EXT_HASH_MAP) && defined(HAVE_EXT_HASH_SET)

#include <ext/hash_map>
#include <ext/hash_set>
#include <string>

#define Unordered_set __gnu_cxx::hash_set
#define Unordered_map __gnu_cxx::hash_map

namespace __gnu_cxx
{

template<>
struct hash<std::string>
{
  size_t
  operator()(std::string s) const
  { return __stl_hash_string(s.c_str()); }
};

template<typename T>
struct hash<T*>
{
  size_t
  operator()(T* p) const
  { return reinterpret_cast<size_t>(p); }
};

}

#else

// The fallback is to just use set and map.

#include <set>
#include <map>

#define Unordered_set std::set
#define Unordered_map std::map

#endif

#ifndef HAVE_PREAD
extern "C" ssize_t pread(int, void*, size_t, off_t);
#endif

namespace gold
{
// This is a hack to work around a problem with older versions of g++.
// The problem is that they don't support calling a member template by
// specifying the template parameters.  It works to pass in an
// argument for argument dependent lookup.

// To use this, the member template method declaration should put
// ACCEPT_SIZE or ACCEPT_SIZE_ENDIAN after the last parameter.  If the
// method takes no parameters, use ACCEPT_SIZE_ONLY or
// ACCEPT_SIZE_ENDIAN_ONLY.

// When calling the method, instead of using fn<size>, use fn
// SELECT_SIZE_NAME or SELECT_SIZE_ENDIAN_NAME.  And after the last
// argument, put SELECT_SIZE(size) or SELECT_SIZE_ENDIAN(size,
// big_endian).  If there is only one argment, use the _ONLY variants.

#ifdef HAVE_MEMBER_TEMPLATE_SPECIFICATIONS

#define SELECT_SIZE_NAME(size) <size>
#define SELECT_SIZE(size)
#define SELECT_SIZE_ONLY(size)
#define ACCEPT_SIZE
#define ACCEPT_SIZE_ONLY
#define ACCEPT_SIZE_EXPLICIT(size)

#define SELECT_SIZE_ENDIAN_NAME(size, big_endian) <size, big_endian>
#define SELECT_SIZE_ENDIAN(size, big_endian)
#define SELECT_SIZE_ENDIAN_ONLY(size, big_endian)
#define ACCEPT_SIZE_ENDIAN
#define ACCEPT_SIZE_ENDIAN_ONLY
#define ACCEPT_SIZE_ENDIAN_EXPLICIT(size, big_endian)

#else // !defined(HAVE_MEMBER_TEMPLATE_SPECIFICATIONS)

template<int size>
class Select_size { };
template<int size, bool big_endian>
class Select_size_endian { };

#define SELECT_SIZE_NAME(size)
#define SELECT_SIZE(size) , Select_size<size>()
#define SELECT_SIZE_ONLY(size) Select_size<size>()
#define ACCEPT_SIZE , Select_size<size>
#define ACCEPT_SIZE_ONLY Select_size<size>
#define ACCEPT_SIZE_EXPLICIT(size) , Select_size<size>

#define SELECT_SIZE_ENDIAN_NAME(size, big_endian)
#define SELECT_SIZE_ENDIAN(size, big_endian) \
  , Select_size_endian<size, big_endian>()
#define SELECT_SIZE_ENDIAN_ONLY(size, big_endian) \
  Select_size_endian<size, big_endian>()
#define ACCEPT_SIZE_ENDIAN , Select_size_endian<size, big_endian>
#define ACCEPT_SIZE_ENDIAN_ONLY Select_size_endian<size, big_endian>
#define ACCEPT_SIZE_ENDIAN_EXPLICIT(size, big_endian) \
  , Select_size_endian<size, big_endian>

#endif // !defined(HAVE_MEMBER_TEMPLATE_SPECIFICATIONS)

// General declarations.

class General_options;
class Command_line;
class Input_argument_list;
class Dirsearch;
class Input_objects;
class Symbol;
class Symbol_table;
class Layout;
class Task;
class Workqueue;
class Output_file;
template<int size, bool big_endian>
struct Relocate_info;

// Some basic types.  For these we use lower case initial letters.

// For an offset in an input or output file, use off_t.  Note that
// this will often be a 64-bit type even for a 32-bit build.

// The size of a section if we are going to look at the contents.
typedef size_t section_size_type;

// An offset within a section when we are looking at the contents.
typedef ptrdiff_t section_offset_type;

// The name of the program as used in error messages.
extern const char* program_name;

// This function is called to exit the program.  Status is true to
// exit success (0) and false to exit failure (1).
extern void
gold_exit(bool status) ATTRIBUTE_NORETURN;

// This function is called to emit an error message and then
// immediately exit with failure.
extern void
gold_fatal(const char* format, ...) ATTRIBUTE_NORETURN ATTRIBUTE_PRINTF_1;

// This function is called to issue an error.  This will cause gold to
// eventually exit with failure.
extern void
gold_error(const char* msg, ...) ATTRIBUTE_PRINTF_1;

// This function is called to issue a warning.
extern void
gold_warning(const char* msg, ...) ATTRIBUTE_PRINTF_1;

// This function is called to issue an error at the location of a
// reloc.
template<int size, bool big_endian>
extern void
gold_error_at_location(const Relocate_info<size, big_endian>*,
		       size_t, off_t, const char* format, ...)
  ATTRIBUTE_PRINTF_4;

// This function is called to issue a warning at the location of a
// reloc.
template<int size, bool big_endian>
extern void
gold_warning_at_location(const Relocate_info<size, big_endian>*,
			 size_t, off_t, const char* format, ...)
  ATTRIBUTE_PRINTF_4;

// This function is called to report an undefined symbol.
template<int size, bool big_endian>
extern void
gold_undefined_symbol(const Symbol*,
		      const Relocate_info<size, big_endian>*,
		      size_t, off_t);

// This is function is called in some cases if we run out of memory.
extern void
gold_nomem() ATTRIBUTE_NORETURN;

// This macro and function are used in cases which can not arise if
// the code is written correctly.

#define gold_unreachable() \
  (gold::do_gold_unreachable(__FILE__, __LINE__, __FUNCTION__))

extern void do_gold_unreachable(const char*, int, const char*)
  ATTRIBUTE_NORETURN;

// Assertion check.

#define gold_assert(expr) ((void)(!(expr) ? gold_unreachable(), 0 : 0))

// Print version information.
extern void
print_version(bool print_short);

// Get the version string.
extern const char*
get_version_string();

// Convert numeric types without unnoticed loss of precision.
template<typename To, typename From>
inline To
convert_types(const From from)
{
  To to = from;
  gold_assert(to == from);
  return to;
}

// A common case of convert_types<>: convert to section_size_type.
template<typename From>
inline section_size_type
convert_to_section_size_type(const From from)
{ return convert_types<section_size_type, From>(from); }

// Queue up the first set of tasks.
extern void
queue_initial_tasks(const General_options&,
		    Dirsearch&,
		    const Command_line&,
		    Workqueue*,
		    Input_objects*,
		    Symbol_table*,
		    Layout*);

// Queue up the middle set of tasks.
extern void
queue_middle_tasks(const General_options&,
		   const Task*,
		   const Input_objects*,
		   Symbol_table*,
		   Layout*,
		   Workqueue*);

// Queue up the final set of tasks.
extern void
queue_final_tasks(const General_options&,
		  const Input_objects*,
		  const Symbol_table*,
		  Layout*,
		  Workqueue*,
		  Output_file* of);

} // End namespace gold.

#endif // !defined(GOLD_GOLD_H)
