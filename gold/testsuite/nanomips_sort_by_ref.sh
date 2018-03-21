#!/bin/sh

# nanomips_sort_by_ref.sh -- test sorting small data section.

# Copyright (C) 2018 Free Software Foundation, Inc.
# Written by Vladimir Radosavljevic <vladimir.radosavljevic@mips.com>.

# This file is part of gold.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
# MA 02110-1301, USA.

# This file goes with nanomips_sort_by_ref.t and with nanomips_sort_by_ref.s.

check()
{
    if ! grep -q "$2" "$1"
    then
	echo "Did not find expected section in $1:"
	echo "   $2"
	echo ""
	echo "Actual output below:"
	cat "$1"
	exit 1
    fi
}

# Symbol d must be at the beginning of the section because it has been
# referenced with lw[gp] instruction 2 times and 2 times with sw[gp]
# instruction.
check nanomips_sort_by_ref.stdout "00410000 <d>"
# Sumbol c has been referenced 2 times with lw[gp] instruction.
# Note that we don't take into account instruction where 5-bit
# register index can't be abbreviated to 3 bits.
check nanomips_sort_by_ref.stdout "00410004 <c>"
# Symbol b has been referenced 1 time.
check nanomips_sort_by_ref.stdout "00410008 <b>"
# After most commonly referenced symbols, we place bytes, halfwords
# and words.
check nanomips_sort_by_ref.stdout "0041000c <a>"
check nanomips_sort_by_ref.stdout "0041000e <e>"
