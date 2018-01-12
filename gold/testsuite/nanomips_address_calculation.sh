#!/bin/sh

# nanomips_address_calculation.sh -- test nanoMIPS address calculation
# transformations.

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

# Test lw %got_disp transformation into lapc.
check nanomips_address_calculation_pcrel_1.stdout " 1000:	04e0 0100 	lapc	a3,.*"

# Test lw %got_disp transformation into lapc[48].
check nanomips_address_calculation_pcrel_2.stdout " 1000:	60e3 001e 	lapc	a3,.*"
check nanomips_address_calculation_pcrel_2.stdout " 1004:	0200"

# Test lw %got_disp transformation into aluipc, ori.
check nanomips_address_calculation_pcrel_3.stdout " 1000:	e0e0 0042 	aluipc	a3,.*"
check nanomips_address_calculation_pcrel_3.stdout " 1004:	80e7 0024 	ori	a3,a3,36"

# Test lw %got_disp transformation into li[48].
check nanomips_address_calculation_abs_1.stdout " 1000:	60e0 1024 	li	a3,.*"
check nanomips_address_calculation_abs_1.stdout " 1004:	0200"

# Test lw %got_disp transformation into lui, ori.
check nanomips_address_calculation_abs_2.stdout " 1000:	e0e0 1040 	lui	a3,.*"
check nanomips_address_calculation_abs_2.stdout " 1004:	80e7 0024 	ori	a3,a3,36"

# Test lw %got_disp transformation into addiu[gp.w]/addiu[gp.b].
check nanomips_address_calculation_pid_1.stdout " 400094:	40e0 0004 	addiu	a3,gp,4"
check nanomips_address_calculation_pid_1.stdout " 400098:	44ec 0002 	addiu	a3,gp,2"

# Test lw %got_disp transformation into lui, ori, addu.
check nanomips_address_calculation_pid_2.stdout " 1000:	e0f0 003c 	lui	a3,%hi(0x1f00000)"
check nanomips_address_calculation_pid_2.stdout " 1004:	80e7 0004 	ori	a3,a3,4"
check nanomips_address_calculation_pid_2.stdout " 1008:	2387 3950 	addu	a3,a3,gp"

# Test lw %got_disp transformation into addiu[gp48].
check nanomips_address_calculation_pid_3.stdout " 1000:	60e2 0004 	addiu	a3,gp,32505860"
check nanomips_address_calculation_pid_3.stdout " 1004:	01f0"

exit 0
