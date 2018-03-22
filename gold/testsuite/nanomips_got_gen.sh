#!/bin/sh

# nanomips_got_gen.sh -- test nanoMIPS GOT entries and relocations.

# Copyright (C) 2018 Free Software Foundation, Inc.
# Contributed by MIPS Tech LLC.

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

# Test generated dynamic relocations with readelf.
check nanomips_got_gen.stdout "Relocation section '.rel.dyn' at offset 0x208 contains 3 entries:"
check nanomips_got_gen.stdout "00020010  00000009 R_NANOMIPS_RELATI"
check nanomips_got_gen.stdout "00020018  0000010a R_NANOMIPS_GLOBAL 00000000   an_extra_ordinarily_lo"
check nanomips_got_gen.stdout "00020014  0000030a R_NANOMIPS_GLOBAL 00000000   strcmp"
check nanomips_got_gen.stdout "Relocation section '.rel.nanoMIPS.stubs' at offset 0x220 contains 1 entries:"
check nanomips_got_gen.stdout "0002001c  0000020b R_NANOMIPS_JUMP_S 00000000   memcpy"

check nanomips_got_gen_wide.stdout "00020010  00000009 R_NANOMIPS_RELATIVE"
check nanomips_got_gen_wide.stdout "00020018  0000010a R_NANOMIPS_GLOBAL      00000000   an_extra_ordinarily_long_function_name_for_testing_readelf_output_width_control"
check nanomips_got_gen_wide.stdout "0002001c  0000020b R_NANOMIPS_JUMP_SLOT   00000000   memcpy"

# Test generated GOT entries with readelf.
check nanomips_got_gen.stdout "GOT:"
check nanomips_got_gen.stdout "GP value: 00020008"
check nanomips_got_gen.stdout "Reserved entries:"
check nanomips_got_gen.stdout "Address       Access   Initial   Purpose"
check nanomips_got_gen.stdout "00020008        0(gp)  00000000  Lazy stub resolver"
check nanomips_got_gen.stdout "Entries:"
check nanomips_got_gen.stdout "Address       Access   Value     Type        Name"
check nanomips_got_gen.stdout "0002000c        4(gp)  00000000"
check nanomips_got_gen.stdout "00020010        8(gp)  00000238  Local"
check nanomips_got_gen.stdout "00020014       12(gp)  00000000  Global      strcmp"
check nanomips_got_gen.stdout "00020018       16(gp)  00000000  Global      an_extra_ordinarily_long_functio"
check nanomips_got_gen.stdout "0002001c       20(gp)  00000228  Lazy-stub   memcpy"

check nanomips_got_gen_wide.stdout "00020018       16(gp)  00000000  Global      an_extra_ordinarily_long_function_name_for_testing_readelf_output_width_control"

# Test generated dynamic tags
check nanomips_got_gen.stdout "0x00000011 (REL)                        0x208"
check nanomips_got_gen.stdout "0x00000012 (RELSZ)                      24 (bytes)"
check nanomips_got_gen.stdout "0x00000013 (RELENT)                     8 (bytes)"

check nanomips_got_gen.stdout "0x00000003 (PLTGOT)                     0x20008"
check nanomips_got_gen.stdout "0x00000002 (PLTRELSZ)                   8 (bytes)"
check nanomips_got_gen.stdout "0x00000017 (JMPREL)                     0x220"
check nanomips_got_gen.stdout "0x00000014 (PLTREL)                     REL"
