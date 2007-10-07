// tls_test.h -- test TLS variables for gold, header file  -*- C++ -*-

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

// This is the header file for the TLS test.  See tls_test.cc for more
// information.

extern bool t1();
extern bool t2();
extern bool t3();
extern bool t4();

extern int* f5a();
extern void f5b(int*);
extern bool t5();

extern int* f6a();
extern void f6b(int*);
extern bool t6();

extern bool t7();
