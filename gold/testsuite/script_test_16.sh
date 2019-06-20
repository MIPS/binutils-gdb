#!/bin/sh

# script_test_16.sh -- Test GOLD and GNU ld archive selector syntax.

# Copyright (C) 2019 Free Software Foundation, Inc.
# Written by Vladimir Radosavljevic <vradosavljevic@wavecomp.com>.

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

# Test *script_test_16.a(script_test_16a.o) syntax.
check script_test_16a.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test *script_test_16.a*script_test_16a.o* syntax.
check script_test_16b.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "*script_test_16a.o*" syntax.
check script_test_16c.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "*script_test_16.a:script_test_16a.o" syntax.
check script_test_16d.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "*script_test_16.a:" syntax.
check script_test_16e.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "*script_test_16.a:*" syntax.
check script_test_16f.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "*:script_test_16a.o" syntax.
check script_test_16g.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test ":script_test_16a.o" syntax. In this case section from archive is not
# selected to be the first in the output section.
check script_test_16h.stdout "10000004     0 NOTYPE  GLOBAL DEFAULT    1 _start"

# Test "script_test_16a.o" syntax.
check script_test_16i.stdout "10000000     0 NOTYPE  GLOBAL DEFAULT    1 _start"

exit 0
