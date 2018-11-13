#!/bin/sh

# nanomips_discarded_debug.sh -- test special handling of nanoMIPS
# relocations to discarded sections for debug information.

# Copyright (C) 2018 Free Software Foundation, Inc.
# Written by Faraz Shahbazker <fshahbazker@wavecomp.com>

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

# Set symbol values to 1 for discarded sections in .debug_ranges
check nanomips_discarded_debug_ranges.stdout " 0000 01000000 01000000 .*"

# Set symbol values to 0 for discarded sections in .debug_info
check nanomips_discarded_debug_info.stdout " 0000 00000000 04000000 00000000 ."

# Retain input setction symbol values for discarded sections in .debug_info
check nanomips_discarded_debug_line.stdout " 0000 06000000 04000000 06000000 .*"

# Retain input setction symbol values for discarded sections in .debug_frame
check nanomips_discarded_debug_frame.stdout " 0000 06000000 04000000 06000000 .*"

# Retain input setction symbol values for discarded sections in .debug_loc
check nanomips_discarded_debug_loc.stdout " 0000 06000000 04000000 06000000 .*"

# Retain input setction symbol values for discarded sections in .debug_aranges
check nanomips_discarded_debug_aranges.stdout " 0000 00000000 06000000 .*"

exit 0
