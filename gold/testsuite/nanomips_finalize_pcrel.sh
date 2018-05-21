#!/bin/sh

# nanomips_finalize_pcrel.sh -- test --finalize-pcrel-relocs option.

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

check()
{
    file=$1
    pattern=$2

    found=`grep "$pattern" $file`
    if test -z "$found"; then
	echo "pattern \"$pattern\" not found in file $file."
	exit 1
    fi
}

# Test that all relocations are resolved.
check nanomips_finalize_pcrel.stdout "  0:	0480 003c 	lapc	a0,.*"
check nanomips_finalize_pcrel.stdout "  4:	2a00 0038 	balc	.*"
check nanomips_finalize_pcrel.stdout "  8:	2800 0034 	bc	.*"
check nanomips_finalize_pcrel.stdout "  c:	0a00 0030 	move.balc	a0,s0,.*"
check nanomips_finalize_pcrel.stdout " 10:	a885 002c 	bnec	a1,a0,.*"
check nanomips_finalize_pcrel.stdout " 14:	c882 d028 	beqic	a0,90,.*"
check nanomips_finalize_pcrel.stdout " 18:	ca28 0824 	bgeic	s1,1,.*"
check nanomips_finalize_pcrel.stdout " 1c:	c86f f820 	bgeiuc	t5,127,.*"
check nanomips_finalize_pcrel.stdout " 20:	c858 201c 	bltic	t4,4,.*"
check nanomips_finalize_pcrel.stdout " 24:	cb1c 3018 	bltiuc	t8,6,.*"
check nanomips_finalize_pcrel.stdout " 28:	caf0 1014 	bneic	s7,2,.*"
check nanomips_finalize_pcrel.stdout " 2c:	3812      	balc	.*"
check nanomips_finalize_pcrel.stdout " 2e:	1810      	bc	.*"
check nanomips_finalize_pcrel.stdout " 30:	da57      	bnec	a1,a0,.*"
check nanomips_finalize_pcrel.stdout " 32:	dac6      	beqc	a0,a1,.*"
exit 0
