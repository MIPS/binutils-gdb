#!/bin/sh

# nanomips_finalize_pcrel.sh -- test --finalize-pcrel-relocs option.

# Copyright (C) 2017 Free Software Foundation, Inc.
# Written by Vladimir Radosavljevic <vladimir.radosavljevic@imgtec.com>.

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
check nanomips_finalize_pcrel.stdout "  0:	2a00 0030 	balc	.*"
check nanomips_finalize_pcrel.stdout "  4:	2800 002c 	bc	.*"
check nanomips_finalize_pcrel.stdout "  8:	0a00 0028 	move.balc	a0,s0,.*"
check nanomips_finalize_pcrel.stdout "  c:	a885 0024 	bnec	a1,a0,.*"
check nanomips_finalize_pcrel.stdout " 10:	c882 d020 	beqic	a0,90,.*"
check nanomips_finalize_pcrel.stdout " 14:	ca28 081c 	bgeic	s1,1,.*"
check nanomips_finalize_pcrel.stdout " 18:	c86f f818 	bgeiuc	t5,127,.*"
check nanomips_finalize_pcrel.stdout " 1c:	c858 2014 	bltic	t4,4,.*"
check nanomips_finalize_pcrel.stdout " 20:	cb1c 3010 	bltiuc	t8,6,.*"
check nanomips_finalize_pcrel.stdout " 24:	caf0 100c 	bneic	s7,2,.*"
check nanomips_finalize_pcrel.stdout " 28:	380a      	balc	.*"
check nanomips_finalize_pcrel.stdout " 2a:	1808      	bc	.*"
check nanomips_finalize_pcrel.stdout " 2c:	da53      	bnec	a1,a0,.*"
check nanomips_finalize_pcrel.stdout " 2e:	dac2      	beqc	a0,a1,.*"
exit 0
