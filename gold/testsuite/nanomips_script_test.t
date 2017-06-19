/* nanomips_script_test.t -- test sorting small data section.

   Copyright (C) 2017 Free Software Foundation, Inc.
   Written by Vladimir Radosavljevic <vladimir.radosavljevic@imgtec.com>.

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
  . = 0x400000;
  .text : { *(.text) }
  .MIPS.abiflags : { *(.MIPS.abiflags) }
  .reginfo : { *(.reginfo) }
  .data : { *(.data) }
  .sdata : {
    *(.sdata)
    *(SORT_BY_READ(.sdata.*))
  }
  .bss : { *(.bss) }
}
