/* Miscellaneous routines making it easier to use GMP within GDB's framework.

   Copyright (C) 2019-2023 Free Software Foundation, Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#ifndef GMP_UTILS_H
#define GMP_UTILS_H

/* Include <stdio.h> and <stdarg.h> ahead of <gmp.h>, so as to get
   access to GMP's various formatting functions.  */
#include <stdio.h>
#include <stdarg.h>
#include <gmp.h>
#include "gdbsupport/traits.h"

/* Same as gmp_asprintf, but returning an std::string.  */

std::string gmp_string_printf (const char *fmt, ...);

struct gdb_mpq;
struct gdb_mpf;

/* A class to make it easier to use GMP's mpz_t values within GDB.  */

struct gdb_mpz
{
  /* Constructors.  */
  gdb_mpz () { mpz_init (m_val); }

  explicit gdb_mpz (const mpz_t &from_val)
  {
    mpz_init (m_val);
    mpz_set (m_val, from_val);
  }

  gdb_mpz (const gdb_mpz &from)
  {
    mpz_init (m_val);
    mpz_set (m_val, from.m_val);
  }

  /* Initialize using the given integral value.

     The main advantage of this method is that it handles both signed
     and unsigned types, with no size restriction.  */
  template<typename T, typename = gdb::Requires<std::is_integral<T>>>
  explicit gdb_mpz (T src)
  {
    mpz_init (m_val);
    set (src);
  }

  explicit gdb_mpz (gdb_mpz &&from)
  {
    mpz_init (m_val);
    mpz_swap (m_val, from.m_val);
  }

  
  gdb_mpz &operator= (const gdb_mpz &from)
  {
    mpz_set (m_val, from.m_val);
    return *this;
  }

  gdb_mpz &operator= (gdb_mpz &&other)
  {
    mpz_swap (m_val, other.m_val);
    return *this;
  }

  template<typename T, typename = gdb::Requires<std::is_integral<T>>>
  gdb_mpz &operator= (T src)
  {
    set (src);
    return *this;
  }

  /* Initialize this value from a string and a base.  Returns true if
     the string was parsed successfully, false otherwise.  */
  bool set (const char *str, int base)
  {
    return mpz_set_str (m_val, str, base) != -1;
  }

  /* Return a new value that is BASE**EXP.  */
  static gdb_mpz pow (unsigned long base, unsigned long exp)
  {
    gdb_mpz result;
    mpz_ui_pow_ui (result.m_val, base, exp);
    return result;
  }

  /* Convert VAL to an integer of the given type.

     The return type can signed or unsigned, with no size restriction.  */
  template<typename T> T as_integer () const;

  /* Set VAL by importing the number stored in the byte array (BUF),
     using the given BYTE_ORDER.  The size of the data to read is
     the byte array's size.

     UNSIGNED_P indicates whether the number has an unsigned type.  */
  void read (gdb::array_view<const gdb_byte> buf, enum bfd_endian byte_order,
	     bool unsigned_p);

  /* Write VAL into BUF as a number whose byte size is the size of BUF,
     using the given BYTE_ORDER.

     UNSIGNED_P indicates whether the number has an unsigned type.  */
  void write (gdb::array_view<gdb_byte> buf, enum bfd_endian byte_order,
	      bool unsigned_p) const;

  /* Return a string containing VAL.  */
  std::string str () const { return gmp_string_printf ("%Zd", m_val); }

  /* The destructor.  */
  ~gdb_mpz () { mpz_clear (m_val); }

  /* Negate this value in place.  */
  void negate ()
  {
    mpz_neg (m_val, m_val);
  }

  gdb_mpz &operator*= (long other)
  {
    mpz_mul_si (m_val, m_val, other);
    return *this;
  }

  gdb_mpz &operator+= (unsigned long other)
  {
    mpz_add_ui (m_val, m_val, other);
    return *this;
  }

  gdb_mpz &operator-= (unsigned long other)
  {
    mpz_sub_ui (m_val, m_val, other);
    return *this;
  }

  gdb_mpz &operator<<= (unsigned long nbits)
  {
    mpz_mul_2exp (m_val, m_val, nbits);
    return *this;
  }

  bool operator> (const gdb_mpz &other) const
  {
    return mpz_cmp (m_val, other.m_val) > 0;
  }

  bool operator< (int other) const
  {
    return mpz_cmp_si (m_val, other) < 0;
  }

  bool operator== (int other) const
  {
    return mpz_cmp_si (m_val, other) == 0;
  }

  bool operator== (const gdb_mpz &other) const
  {
    return mpz_cmp (m_val, other.m_val) == 0;
  }

private:

  /* Helper template for constructor and operator=.  */
  template<typename T> void set (T src);

  /* Low-level function to export VAL into BUF as a number whose byte size
     is the size of BUF.

     If UNSIGNED_P is true, then export VAL into BUF as an unsigned value.
     Otherwise, export it as a signed value.

     The API is inspired from GMP's mpz_export, hence the naming and types
     of the following parameter:
       - ENDIAN should be:
	   . 1 for most significant byte first; or
	   . -1 for least significant byte first; or
	   . 0 for native endianness.

    An error is raised if BUF is not large enough to contain the value
    being exported.  */
  void safe_export (gdb::array_view<gdb_byte> buf,
		    int endian, bool unsigned_p) const;

  friend struct gdb_mpq;
  friend struct gdb_mpf;

  mpz_t m_val;
};

/* A class to make it easier to use GMP's mpq_t values within GDB.  */

struct gdb_mpq
{
  /* Constructors.  */
  gdb_mpq () { mpq_init (m_val); }

  explicit gdb_mpq (const mpq_t &from_val)
  {
    mpq_init (m_val);
    mpq_set (m_val, from_val);
  }

  gdb_mpq (const gdb_mpq &from)
  {
    mpq_init (m_val);
    mpq_set (m_val, from.m_val);
  }

  explicit gdb_mpq (gdb_mpq &&from)
  {
    mpq_init (m_val);
    mpq_swap (m_val, from.m_val);
  }

  gdb_mpq (const gdb_mpz &num, const gdb_mpz &denom)
  {
    mpq_init (m_val);
    mpz_set (mpq_numref (m_val), num.m_val);
    mpz_set (mpq_denref (m_val), denom.m_val);
    mpq_canonicalize (m_val);
  }

  gdb_mpq (long num, long denom)
  {
    mpq_init (m_val);
    mpq_set_si (m_val, num, denom);
    mpq_canonicalize (m_val);
  }

  /* Copy assignment operator.  */
  gdb_mpq &operator= (const gdb_mpq &from)
  {
    mpq_set (m_val, from.m_val);
    return *this;
  }

  gdb_mpq &operator= (gdb_mpq &&from)
  {
    mpq_swap (m_val, from.m_val);
    return *this;
  }

  gdb_mpq &operator= (const gdb_mpz &from)
  {
    mpq_set_z (m_val, from.m_val);
    return *this;
  }

  gdb_mpq &operator= (double d)
  {
    mpq_set_d (m_val, d);
    return *this;
  }

  /* Return the sign of this value.  This returns -1 for a negative
     value, 0 if the value is 0, and 1 for a positive value.  */
  int sgn () const
  { return mpq_sgn (m_val); }

  gdb_mpq operator+ (const gdb_mpq &other) const
  {
    gdb_mpq result;
    mpq_add (result.m_val, m_val, other.m_val);
    return result;
  }

  gdb_mpq operator- (const gdb_mpq &other) const
  {
    gdb_mpq result;
    mpq_sub (result.m_val, m_val, other.m_val);
    return result;
  }

  gdb_mpq operator* (const gdb_mpq &other) const
  {
    gdb_mpq result;
    mpq_mul (result.m_val, m_val, other.m_val);
    return result;
  }

  gdb_mpq operator/ (const gdb_mpq &other) const
  {
    gdb_mpq result;
    mpq_div (result.m_val, m_val, other.m_val);
    return result;
  }

  gdb_mpq &operator*= (const gdb_mpq &other)
  {
    mpq_mul (m_val, m_val, other.m_val);
    return *this;
  }

  gdb_mpq &operator/= (const gdb_mpq &other)
  {
    mpq_div (m_val, m_val, other.m_val);
    return *this;
  }

  bool operator== (const gdb_mpq &other) const
  {
    return mpq_cmp (m_val, other.m_val) == 0;
  }

  bool operator< (const gdb_mpq &other) const
  {
    return mpq_cmp (m_val, other.m_val) < 0;
  }

  /* Return a string representing VAL as "<numerator> / <denominator>".  */
  std::string str () const { return gmp_string_printf ("%Qd", m_val); }

  /* Return VAL rounded to the nearest integer.  */
  gdb_mpz get_rounded () const;

  /* Return this value as an integer, rounded toward zero.  */
  gdb_mpz as_integer () const
  {
    gdb_mpz result;
    mpz_tdiv_q (result.m_val, mpq_numref (m_val), mpq_denref (m_val));
    return result;
  }

  /* Return this value converted to a host double.  */
  double as_double () const
  { return mpq_get_d (m_val); }

  /* Set VAL from the contents of the given byte array (BUF), which
     contains the unscaled value of a fixed point type object.
     The byte size of the data is the size of BUF.

     BYTE_ORDER provides the byte_order to use when reading the data.

     UNSIGNED_P indicates whether the number has an unsigned type.
     SCALING_FACTOR is the scaling factor to apply after having
     read the unscaled value from our buffer.  */
  void read_fixed_point (gdb::array_view<const gdb_byte> buf,
			 enum bfd_endian byte_order, bool unsigned_p,
			 const gdb_mpq &scaling_factor);

  /* Write VAL into BUF as fixed point value following the given BYTE_ORDER.
     The size of BUF is used as the length to write the value into.

     UNSIGNED_P indicates whether the number has an unsigned type.
     SCALING_FACTOR is the scaling factor to apply before writing
     the unscaled value to our buffer.  */
  void write_fixed_point (gdb::array_view<gdb_byte> buf,
			  enum bfd_endian byte_order, bool unsigned_p,
			  const gdb_mpq &scaling_factor) const;

  /* The destructor.  */
  ~gdb_mpq () { mpq_clear (m_val); }

private:

  friend struct gdb_mpf;

  mpq_t m_val;
};

/* A class to make it easier to use GMP's mpf_t values within GDB.

   Should MPFR become a required dependency, we should probably
   drop this class in favor of using MPFR.  */

struct gdb_mpf
{
  /* Constructors.  */
  gdb_mpf () { mpf_init (m_val); }

  DISABLE_COPY_AND_ASSIGN (gdb_mpf);

  /* Set VAL from the contents of the given buffer (BUF), which
     contains the unscaled value of a fixed point type object
     with the given size (LEN) and byte order (BYTE_ORDER).

     UNSIGNED_P indicates whether the number has an unsigned type.
     SCALING_FACTOR is the scaling factor to apply after having
     read the unscaled value from our buffer.  */
  void read_fixed_point (gdb::array_view<const gdb_byte> buf,
			 enum bfd_endian byte_order, bool unsigned_p,
			 const gdb_mpq &scaling_factor)
  {
    gdb_mpq tmp_q;

    tmp_q.read_fixed_point (buf, byte_order, unsigned_p, scaling_factor);
    mpf_set_q (m_val, tmp_q.m_val);
  }

  /* Convert this value to a string.  FMT is the format to use, and
     should have a single '%' substitution.  */
  std::string str (const char *fmt) const
  { return gmp_string_printf (fmt, m_val); }

  /* The destructor.  */
  ~gdb_mpf () { mpf_clear (m_val); }

private:

  mpf_t m_val;
};

/* See declaration above.  */

template<typename T>
void
gdb_mpz::set (T src)
{
  mpz_import (m_val, 1 /* count */, -1 /* order */,
	      sizeof (T) /* size */, 0 /* endian (0 = native) */,
	      0 /* nails */, &src /* op */);
  if (std::is_signed<T>::value && src < 0)
    {
      /* mpz_import does not handle the sign, so our value was imported
	 as an unsigned. Adjust that imported value so as to make it
	 the correct negative value.  */
      gdb_mpz neg_offset;

      mpz_ui_pow_ui (neg_offset.m_val, 2, sizeof (T) * HOST_CHAR_BIT);
      mpz_sub (m_val, m_val, neg_offset.m_val);
    }
}

/* See declaration above.  */

template<typename T>
T
gdb_mpz::as_integer () const
{
  T result;

  this->safe_export ({(gdb_byte *) &result, sizeof (result)},
		     0 /* endian (0 = native) */,
		     !std::is_signed<T>::value /* unsigned_p */);

  return result;
}

#endif
