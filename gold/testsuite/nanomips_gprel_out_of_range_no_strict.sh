#!/bin/sh

# nanomips_gprel_out_of_range.sh -- test nanoMIPS lw[gp] and sw[gp]
# instructions whose targets are out of the range limits, with
# --no-strict-address-modes option.

# Copyright (C) 2018 Free Software Foundation, Inc.
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

# Test lw[gp] expansion to lwpc.
check nanomips_gprel_out_of_range_no_strict.stdout " 1000:	604b effa 	lwpc	t4,2000000 <var>"
check nanomips_gprel_out_of_range_no_strict.stdout " 1004:	01ff"

# Test sw[gp] expansion to swpc.
check nanomips_gprel_out_of_range_no_strict.stdout " 1006:	606f eff4 	swpc	t5,2000000 <var>"
check nanomips_gprel_out_of_range_no_strict.stdout " 100a:	01ff"

exit 0
