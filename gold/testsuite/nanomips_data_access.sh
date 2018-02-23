#!/bin/sh

# nanomips_data_access.sh -- test nanoMIPS data access transformations.

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

# Test ls[X] %got_ofst transformation into aluipc, ls[X].
check nanomips_data_access_pcrel_1.stdout " 1000:	e080 0042 	aluipc	a0,.*"
check nanomips_data_access_pcrel_1.stdout " 1004:	84a4 8024 	lw	a1,36(a0)"
check nanomips_data_access_pcrel_1.stdout " 1008:	e080 0042 	aluipc	a0,.*"
check nanomips_data_access_pcrel_1.stdout " 100c:	84c4 9024 	sw	a2,36(a0)"
check nanomips_data_access_pcrel_1.stdout " 1010:	e0a0 0042 	aluipc	a1,.*"
check nanomips_data_access_pcrel_1.stdout " 1014:	8585 4022 	lh	t0,34(a1)"
check nanomips_data_access_pcrel_1.stdout " 1018:	e0a0 0042 	aluipc	a1,.*"
check nanomips_data_access_pcrel_1.stdout " 101c:	85a5 6022 	lhu	t1,34(a1)"
check nanomips_data_access_pcrel_1.stdout " 1020:	e0a0 0042 	aluipc	a1,.*"
check nanomips_data_access_pcrel_1.stdout " 1024:	85c5 5022 	sh	t2,34(a1)"
check nanomips_data_access_pcrel_1.stdout " 1028:	e0c0 0042 	aluipc	a2,.*"
check nanomips_data_access_pcrel_1.stdout " 102c:	8606 0020 	lb	s0,32(a2)"
check nanomips_data_access_pcrel_1.stdout " 1030:	e0c0 0042 	aluipc	a2,.*"
check nanomips_data_access_pcrel_1.stdout " 1034:	8626 2020 	lbu	s1,32(a2)"
check nanomips_data_access_pcrel_1.stdout " 1038:	e0c0 0042 	aluipc	a2,.*"
check nanomips_data_access_pcrel_1.stdout " 103c:	8646 1020 	sb	s2,32(a2)"

# Test ls[w] %got_ofst transformation into lapc, ls[w][16].
check nanomips_data_access_pcrel_2.stdout " 1000:	0482 0020 	lapc	a0,21024 <w>"
check nanomips_data_access_pcrel_2.stdout " 1004:	16c0      	lw	a1,0(a0)"
check nanomips_data_access_pcrel_2.stdout " 1006:	0482 001a 	lapc	a0,21024 <w>"
check nanomips_data_access_pcrel_2.stdout " 100a:	9740      	sw	a2,0(a0)"

# Test ls[w] %got_ofst transformation into [ls]wpc.
check nanomips_data_access_pcrel_3.stdout " 1000:	60ab 001e 	lwpc	a1,2001024 <w>"
check nanomips_data_access_pcrel_3.stdout " 1004:	0200"
check nanomips_data_access_pcrel_3.stdout " 1006:	60cf 0018 	swpc	a2,2001024 <w>"
check nanomips_data_access_pcrel_3.stdout " 100a:	0200"

# Test ls[X] %got_ofst transformation into lui, ls[X].
check nanomips_data_access_abs.stdout " 1000:	e080 1040 	lui	a0,.*"
check nanomips_data_access_abs.stdout " 1004:	84a4 8024 	lw	a1,36(a0)"
check nanomips_data_access_abs.stdout " 1008:	e080 1040 	lui	a0,.*"
check nanomips_data_access_abs.stdout " 100c:	84c4 9024 	sw	a2,36(a0)"
check nanomips_data_access_abs.stdout " 1010:	e0a0 1040 	lui	a1,.*"
check nanomips_data_access_abs.stdout " 1014:	8585 4022 	lh	t0,34(a1)"
check nanomips_data_access_abs.stdout " 1018:	e0a0 1040 	lui	a1,.*"
check nanomips_data_access_abs.stdout " 101c:	85a5 6022 	lhu	t1,34(a1)"
check nanomips_data_access_abs.stdout " 1020:	e0a0 1040 	lui	a1,.*"
check nanomips_data_access_abs.stdout " 1024:	85c5 5022 	sh	t2,34(a1)"
check nanomips_data_access_abs.stdout " 1028:	e0c0 1040 	lui	a2,.*"
check nanomips_data_access_abs.stdout " 102c:	8606 0020 	lb	s0,32(a2)"
check nanomips_data_access_abs.stdout " 1030:	e0c0 1040 	lui	a2,.*"
check nanomips_data_access_abs.stdout " 1034:	8626 2020 	lbu	s1,32(a2)"
check nanomips_data_access_abs.stdout " 1038:	e0c0 1040 	lui	a2,.*"
check nanomips_data_access_abs.stdout " 103c:	8646 1020 	sb	s2,32(a2)"

# Test ls[w] %got_ofst transformation into [ls][bh]/[ls]w.
check nanomips_data_access_pid_1.stdout " 400094:	5681      	lw	a1,4(gp)"
check nanomips_data_access_pid_1.stdout " 400096:	d701      	sw	a2,4(gp)"
check nanomips_data_access_pid_1.stdout " 400098:	4590 0002 	lh	t0,2(gp)"
check nanomips_data_access_pid_1.stdout " 40009c:	45b0 0003 	lhu	t1,2(gp)"
check nanomips_data_access_pid_1.stdout " 4000a0:	45d4 0002 	sh	t2,2(gp)"
check nanomips_data_access_pid_1.stdout " 4000a4:	4600 0000 	lb	s0,0(gp)"
check nanomips_data_access_pid_1.stdout " 4000a8:	4628 0000 	lbu	s1,0(gp)"
check nanomips_data_access_pid_1.stdout " 4000ac:	4644 0000 	sb	s2,0(gp)"

# Test ls[w] %got_ofst transformation into lui, addu, ls[X].
check nanomips_data_access_pid_2.stdout " 1000:	e090 003c 	lui	a0,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1004:	2384 2150 	addu	a0,a0,gp"
check nanomips_data_access_pid_2.stdout " 1008:	84a4 8004 	lw	a1,4(a0)"
check nanomips_data_access_pid_2.stdout " 100c:	e090 003c 	lui	a0,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1010:	2384 2150 	addu	a0,a0,gp"
check nanomips_data_access_pid_2.stdout " 1014:	84c4 9004 	sw	a2,4(a0)"
check nanomips_data_access_pid_2.stdout " 1018:	e0b0 003c 	lui	a1,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 101c:	2385 2950 	addu	a1,a1,gp"
check nanomips_data_access_pid_2.stdout " 1020:	8585 4002 	lh	t0,2(a1)"
check nanomips_data_access_pid_2.stdout " 1024:	e0b0 003c 	lui	a1,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1028:	2385 2950 	addu	a1,a1,gp"
check nanomips_data_access_pid_2.stdout " 102c:	85a5 6002 	lhu	t1,2(a1)"
check nanomips_data_access_pid_2.stdout " 1030:	e0b0 003c 	lui	a1,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1034:	2385 2950 	addu	a1,a1,gp"
check nanomips_data_access_pid_2.stdout " 1038:	85c5 5002 	sh	t2,2(a1)"
check nanomips_data_access_pid_2.stdout " 103c:	e0d0 003c 	lui	a2,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1040:	2386 3150 	addu	a2,a2,gp"
check nanomips_data_access_pid_2.stdout " 1044:	8606 0000 	lb	s0,0(a2)"
check nanomips_data_access_pid_2.stdout " 1048:	e0d0 003c 	lui	a2,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 104c:	2386 3150 	addu	a2,a2,gp"
check nanomips_data_access_pid_2.stdout " 1050:	8626 2000 	lbu	s1,0(a2)"
check nanomips_data_access_pid_2.stdout " 1054:	e0d0 003c 	lui	a2,%hi(0x1f00000)"
check nanomips_data_access_pid_2.stdout " 1058:	2386 3150 	addu	a2,a2,gp"
check nanomips_data_access_pid_2.stdout " 105c:	8646 1000 	sb	s2,0(a2)"

# Test ls[w] %got_ofst transformation into addiu[gp48], [ls]X.
check nanomips_data_access_pid_3.stdout " 1000:	6082 0004 	addiu	a0,gp,32505860"
check nanomips_data_access_pid_3.stdout " 1004:	01f0"
check nanomips_data_access_pid_3.stdout " 1006:	16c0      	lw	a1,0(a0)"
check nanomips_data_access_pid_3.stdout " 1008:	6082 0004 	addiu	a0,gp,32505860"
check nanomips_data_access_pid_3.stdout " 100c:	01f0"
check nanomips_data_access_pid_3.stdout " 100e:	9740      	sw	a2,0(a0)"
check nanomips_data_access_pid_3.stdout " 1010:	60a2 0002 	addiu	a1,gp,32505858"
check nanomips_data_access_pid_3.stdout " 1014:	01f0"
check nanomips_data_access_pid_3.stdout " 1016:	8585 4000 	lh	t0,0(a1)"
check nanomips_data_access_pid_3.stdout " 101a:	60a2 0002 	addiu	a1,gp,32505858"
check nanomips_data_access_pid_3.stdout " 101e:	01f0"
check nanomips_data_access_pid_3.stdout " 1020:	85a5 6000 	lhu	t1,0(a1)"
check nanomips_data_access_pid_3.stdout " 1024:	60a2 0002 	addiu	a1,gp,32505858"
check nanomips_data_access_pid_3.stdout " 1028:	01f0"
check nanomips_data_access_pid_3.stdout " 102a:	85c5 5000 	sh	t2,0(a1)"
check nanomips_data_access_pid_3.stdout " 102e:	60c2 0000 	addiu	a2,gp,32505856"
check nanomips_data_access_pid_3.stdout " 1032:	01f0"
check nanomips_data_access_pid_3.stdout " 1034:	5c60      	lb	s0,0(a2)"
check nanomips_data_access_pid_3.stdout " 1036:	60c2 0000 	addiu	a2,gp,32505856"
check nanomips_data_access_pid_3.stdout " 103a:	01f0"
check nanomips_data_access_pid_3.stdout " 103c:	5ce8      	lbu	s1,0(a2)"
check nanomips_data_access_pid_3.stdout " 103e:	60c2 0000 	addiu	a2,gp,32505856"
check nanomips_data_access_pid_3.stdout " 1042:	01f0"
check nanomips_data_access_pid_3.stdout " 1044:	5d64      	sb	s2,0(a2)"

exit 0
