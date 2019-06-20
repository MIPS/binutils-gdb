/* script_test_16a.t -- Test GOLD and GNU ld archive selector syntax.

   Copyright (C) 2019 Free Software Foundation, Inc.
   Written by Vladimir Radosavljevic <vradosavljevic@wavecomp.com>.

   This file is part of gold.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
   MA 02110-1301, USA.  */

SECTIONS
{
  . = 0x10000000;
  .text : {
    "*script_test_16.a(script_test_16a.o)" (.text*)
    *(.text)
    *(.text.*)
  }
  .data : { *(.data) }
  /* Required by the MIPS target. */
  .reginfo : { *(.reginfo) }
  .MIPS.abiflags : { *(.MIPS.abiflags) }
  /* Required by the nanoMIPS target. */
  .nanoMIPS.abiflags : { *(.nanoMIPS.abiflags) }
  .bss : { *(.bss) }
}
