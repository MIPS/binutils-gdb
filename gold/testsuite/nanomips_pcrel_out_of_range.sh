#!/bin/sh

# nanomips_pcrel_out_of_range.sh -- test nanoMIPS pc-relative instructions whose
# targets are out of the range limits.

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

# Test balc expansion to aluipc, ori and jalrc[16].
check nanomips_b_out_of_range.stdout " 1000:	e020 0042 	aluipc	at,.*"
check nanomips_b_out_of_range.stdout " 1004:	8021 0020 	ori	at,at,32"
check nanomips_b_out_of_range.stdout " 1008:	d830      	jalrc	at"

# Test bc expansion to aluipc, ori and jrc[16].
check nanomips_b_out_of_range.stdout " 100a:	e020 0042 	aluipc	at,.*"
check nanomips_b_out_of_range.stdout " 100e:	8021 0020 	ori	at,at,32"
check nanomips_b_out_of_range.stdout " 1012:	d820      	jrc	at"

# Test balc expansion to aluipc, ori and jalrc.
check nanomips_b_insn32_out_of_range.stdout " 1000:	e020 0042 	aluipc	at,.*"
check nanomips_b_insn32_out_of_range.stdout " 1004:	8021 0020 	ori	at,at,32"
check nanomips_b_insn32_out_of_range.stdout " 1008:	4be1 0000 	jalrc	at"

# Test bc expansion to aluipc, ori and jrc.
check nanomips_b_insn32_out_of_range.stdout " 100c:	e020 0042 	aluipc	at,.*"
check nanomips_b_insn32_out_of_range.stdout " 1010:	8021 0020 	ori	at,at,32"
check nanomips_b_insn32_out_of_range.stdout " 1014:	4801 0000 	jrc	at"

# Test balc expansion to lapc[48] and jalrc.
check nanomips_b_nms_out_of_range.stdout " 1000:	6023 001a 	lapc	at,.*"
check nanomips_b_nms_out_of_range.stdout " 1004:	0200"
check nanomips_b_nms_out_of_range.stdout " 1006:	d830      	jalrc	at"

# Test bc expansion to lapc[48] and jrc.
check nanomips_b_nms_out_of_range.stdout " 1008:	6023 0012 	lapc	at,.*"
check nanomips_b_nms_out_of_range.stdout " 100c:	0200"
check nanomips_b_nms_out_of_range.stdout " 100e:	d820      	jrc	at"

# Test move.balc expansion to move and balc.
check nanomips_move_balc_1_out_of_range.stdout " 1000:	1090      	move	a0,s0"
check nanomips_move_balc_1_out_of_range.stdout " 1002:	2a20 001a 	balc	.*"

# Test move.balc expansion to move, lapc[48] and jalrc.
check nanomips_move_balc_2_out_of_range.stdout " 1000:	1090      	move	a0,s0"
check nanomips_move_balc_2_out_of_range.stdout " 1002:	6023 0018 	lapc	at,.*"
check nanomips_move_balc_2_out_of_range.stdout " 1006:	0200"
check nanomips_move_balc_2_out_of_range.stdout " 1008:	d830      	jalrc	at"

# Test lapc expansion to aluipc and ori.
check nanomips_lapc_out_of_range.stdout " 1000:	e080 0042 	aluipc	a0,.*"
check nanomips_lapc_out_of_range.stdout " 1004:	8084 0020 	ori	a0,a0,32"

# Test lapc expansion to lapc[48].
check nanomips_lapc_nms_out_of_range.stdout " 1000:	6083 001a 	lapc	a0,.*"
check nanomips_lapc_nms_out_of_range.stdout " 1004:	0200"

# Test conditional branch expansions.  They are expanding to their opposite
# branch and bc instruction.
check nanomips_b_cond_out_of_range.stdout "  1000:	a883 0004 	bnec	t5,a0,.*"
check nanomips_b_cond_out_of_range.stdout "  1004:	2820 0018 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1008:	88a6 0004 	beqc	a2,a1,.*"
check nanomips_b_cond_out_of_range.stdout "  100c:	2820 0010 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1010:	a907 8004 	bltc	a3,a4,.*"
check nanomips_b_cond_out_of_range.stdout "  1014:	2820 0008 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1018:	88e8 8004 	bgec	a4,a3,.*"
check nanomips_b_cond_out_of_range.stdout "  101c:	2820 0000 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1020:	aae6 c004 	bltuc	a2,s7,.*"
check nanomips_b_cond_out_of_range.stdout "  1024:	281f fff8 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1028:	8a79 c004 	bgeuc	t9,s3,.*"
check nanomips_b_cond_out_of_range.stdout "  102c:	281f fff0 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1030:	c854 f804 	bbnezc	t4,0x1f,.*"
check nanomips_b_cond_out_of_range.stdout "  1034:	281f ffe8 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1038:	c9e4 0804 	bbeqzc	t3,0x1,.*"
check nanomips_b_cond_out_of_range.stdout "  103c:	281f ffe0 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1040:	c892 d004 	bneic	a0,90,.*"
check nanomips_b_cond_out_of_range.stdout "  1044:	281f ffd8 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1048:	cae0 1004 	beqic	s7,2,.*"
check nanomips_b_cond_out_of_range.stdout "  104c:	281f ffd0 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1050:	ca38 0804 	bltic	s1,1,.*"
check nanomips_b_cond_out_of_range.stdout "  1054:	281f ffc8 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1058:	c848 2004 	bgeic	t4,4,.*"
check nanomips_b_cond_out_of_range.stdout "  105c:	281f ffc0 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1060:	c87f f804 	bltiuc	t5,127,.*"
check nanomips_b_cond_out_of_range.stdout "  1064:	281f ffb8 	bc	201020 <foo>"
check nanomips_b_cond_out_of_range.stdout "  1068:	cb0c 3004 	bgeiuc	t8,6,.*"
check nanomips_b_cond_out_of_range.stdout "  106c:	281f ffb0 	bc	201020 <foo>"

exit 0
