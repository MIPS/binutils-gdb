/* Target-dependent code for GNU/Linux on nanoMIPS processors.

   Copyright (C) 2018 Free Software Foundation, Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include "arch/nanomips-linux.h"

void nanomips_linux_supply_gregset
  (struct regcache *regcache, const gdb_byte *buf);
void nanomips_linux_collect_gregset
  (const struct regcache *regcache, gdb_byte *buf);
void nanomips_linux_supply_fpregset
  (struct regcache *regcache, const gdb_byte *buf);
void nanomips_linux_collect_fpregset
  (const struct regcache *regcache, gdb_byte *buf);

extern struct target_desc *tdesc_nanomips_linux;
extern struct target_desc *tdesc_nanomips64_linux;
extern struct target_desc *tdesc_nanomips_dsp_linux;
extern struct target_desc *tdesc_nanomips64_dsp_linux;
