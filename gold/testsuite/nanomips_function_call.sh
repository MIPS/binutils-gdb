#!/bin/sh

# nanomips_function_call.sh -- test nanoMIPS function call transformations.

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

# Test jalrc[16] transformation into balc[16].
check nanomips_function_call_16_pcrel_1.stdout " 1000:	38fe      	balc	.*"

# Test jalrc[16] transformation into balc.
check nanomips_function_call_16_pcrel_2.stdout " 1000:	2a20 001c 	balc	.*"

# Test jalrc[16] transformation into lapc[48], jalrc[16].
check nanomips_function_call_16_pcrel_3.stdout " 1000:	60e3 001a 	lapc	a3,.*"
check nanomips_function_call_16_pcrel_3.stdout " 1004:	0200"
check nanomips_function_call_16_pcrel_3.stdout " 1006:	d8f0      	jalrc	a3"

# Test jalrc[16] transformation into aluipc, ori, jalrc[16].
check nanomips_function_call_16_pcrel_4.stdout " 1000:	e0e0 0042 	aluipc	a3,.*"
check nanomips_function_call_16_pcrel_4.stdout " 1004:	80e7 0020 	ori	a3,a3,32"
check nanomips_function_call_16_pcrel_4.stdout " 1008:	d8f0      	jalrc	a3"

# Test jalrc[16] transformation into li[48], jalrc[16].
check nanomips_function_call_16_abs_1.stdout " 1000:	60e0 1020 	li	a3,.*"
check nanomips_function_call_16_abs_1.stdout " 1004:	0200"
check nanomips_function_call_16_abs_1.stdout " 1006:	d8f0      	jalrc	a3"

# Test jalrc[16] transformation into lui, ori, jalrc[16].
check nanomips_function_call_16_abs_2.stdout " 1000:	e0e0 1040 	lui	a3,.*"
check nanomips_function_call_16_abs_2.stdout " 1004:	80e7 0020 	ori	a3,a3,32"
check nanomips_function_call_16_abs_2.stdout " 1008:	d8f0      	jalrc	a3"

# Test jalrc transformation into balc.
check nanomips_function_call_32_pcrel_1.stdout " 1000:	2a20 001c 	balc	.*"

# Test jalrc transformation into aluipc, ori, jalrc.
check nanomips_function_call_32_pcrel_2.stdout " 1000:	e0e0 0042 	aluipc	a3,.*"
check nanomips_function_call_32_pcrel_2.stdout " 1004:	80e7 0020 	ori	a3,a3,32"
check nanomips_function_call_32_pcrel_2.stdout " 1008:	4be7 0000 	jalrc	a3"

# Test jalrc transformation into lui, ori, jalrc.
check nanomips_function_call_32_abs.stdout " 1000:	e0e0 1040 	lui	a3,.*"
check nanomips_function_call_32_abs.stdout " 1004:	80e7 0020 	ori	a3,a3,32"
check nanomips_function_call_32_abs.stdout " 1008:	4be7 0000 	jalrc	a3"

exit 0
