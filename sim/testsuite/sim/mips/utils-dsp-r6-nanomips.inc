# MIPS DSP ASE simulator testsuite utility functions.
# Copyright (C) 2005-2015 Free Software Foundation, Inc.
# Contributed by MIPS Technologies, Inc.  Written by Chao-ying Fu.
#
# This file is part of the GNU simulators.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

# $a0, $a1, $a2, $a3, $ac0, $ac1, $ac2, $ac3 are used as temps by the macros
# defined here.

	# If a != b, jump to _fail.
	# Otherwise, fall through.
	.macro dsp_assert a, b
	beq	\a, \b, 1f
	nop
	j	_fail
	nop
1: 
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, s, t)
	# Check if crout == dsp control register
	.macro dspck_dstio inst, d, s, t, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \s
	li	$a1, \t
	\inst	$a2, $a0, $a1
	li	$a3, \d
	dsp_assert	$a2, $a3
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# (inst s, t)
	# Check if crout == dsp control register
	.macro dspck_stio inst, s, t, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \s
	li	$a1, \t
	\inst	$a0, $a1
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, s, t)
	.macro dspck_dsti inst, d, s, t, crin
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \s
	li	$a1, \t
	\inst	$a2, $a0, $a1
	li	$a3, \d
	dsp_assert	$a2, $a3
	.endm

	# Set dsp control register <= crin
	# Check if tou == (inst tin, s)
	.macro dspck_tsi inst, tou, tin, s, crin
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \s
	li	$a1, \tin
	\inst	$a1, $a0
	li	$a2, \tou
	dsp_assert	$a1, $a2
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, imm)
	# Check if crout == dsp control register
	.macro dspck_dIio inst, d, imm, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	\inst	$a1, \imm
	li	$a2, \d
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, s)
	# Check if crout == dsp control register
	.macro dspck_dsio inst, d, s, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \s
	\inst	$a2, $a0
	li	$a3, \d
	dsp_assert	$a2, $a3
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, t, sa)
	# Check if crout == dsp control register
	.macro dspck_dtsaio inst, d, t, sa, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \t
	\inst	$a2, $a0, \sa
	li	$a3, \d
	dsp_assert	$a2, $a3
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Check if d == (inst ?, t, sa)
	.macro dspck_dtsai inst, d, t, sa, crin
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \t
	\inst	$a2, $a0, \sa
	li	$a3, \d
	dsp_assert	$a2, $a3
	.endm

	# Set dsp control register <= crin
	# Set $ac3 <= {hiin, loin}
	# (inst $ac3, s, t)
	# Check if {hiou, loou} == $ac3
	# Check if (crout & 0x80000) == (dsp control register & 0x80000)
	.macro dspck_astio inst, hiin, loin, hiou, loou, s, t, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hiin
	mthi	$a0, $ac3
	li	$a0, \loin
	mtlo	$a0, $ac3
	li	$a0, \s
	li	$a1, \t
	\inst	$ac3, $a0, $a1
	li	$a0, \hiou
	mfhi	$a1, $ac3
	dsp_assert	$a0, $a1
	li	$a0, \loou
	mflo	$a1, $ac3
	dsp_assert	$a0, $a1
	li	$a0, \crout
	and	$a0, $a0, 0x80000
	rddsp	$a1
	and	$a1, $a1, 0x80000
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Set $ac1 <= {hi, lo}
	# Check if t == (inst ? $ac1, sa)
	# Check if crout == dsp control register
	.macro dspck_atsaio inst, hi, lo, t, sa, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac1
	li	$a0, \lo
	mtlo	$a0, $ac1
	\inst	$a1, $ac1, \sa
	li	$a2, \t
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Set acc <= {hiin, loin}
	# (inst acc, s, t)
	# Check if {hiou, loou} == acc
	# Check if (crout & 0x80000) == (dsp control register & 0x80000)
	.macro dspckacc_astio inst, acc, hiin, loin, hiou, loou, s, t, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hiin
	mthi	$a0, \acc
	li	$a0, \loin
	mtlo	$a0, \acc
	li	$a0, \s
	li	$a1, \t
	\inst	\acc, $a0, $a1
	li	$a0, \hiou
	mfhi	$a1, \acc
	dsp_assert	$a0, $a1
	li	$a0, \loou
	mflo	$a1, \acc
	dsp_assert	$a0, $a1
	li	$a0, \crout
	and	$a0, $a0, 0x80000
	rddsp	$a1
	and	$a1, $a1, 0x80000
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Set $ac1 <= {hi, lo}
	# Check if t == (inst ? $ac1, s)
	# Check if crout == dsp control register
	.macro dspck_atsio inst, hi, lo, t, s, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac1
	li	$a0, \lo
	mtlo	$a0, $ac1
	li	$a0, \s
	\inst	$a1, $ac1, $a0
	li	$a2, \t
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= (crin & crinmask)
	# Set $ac2 <= {hi, lo}
	# Check if t == (inst ? $ac2, size)
	# Check if (crout & croutmask) == (dsp control register & croutmask)
	.macro dspck_tasiimom inst, hi, lo, t, size, crin, crinmask, crout, croutmask
	li	$a0, \crin
	and	$a0, \crinmask
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac2
	li	$a0, \lo
	mtlo	$a0, $ac2
	\inst	$a1, $ac2, \size
	li	$a2, \t
	dsp_assert	$a1, $a2
	li	$a0, \crout
	and	$a0, \croutmask
	rddsp	$a1
	and	$a1, \croutmask
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= (crin & crinmask)
	# Set $ac2 <= {hi, lo}
	# Check if t == (inst ? $ac2, size)
	.macro dspck_tasiim inst, hi, lo, t, size, crin, crinmask
	li	$a0, \crin
	and	$a0, \crinmask
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac2
	li	$a0, \lo
	mtlo	$a0, $ac2
	\inst	$a1, $ac2, \size
	li	$a2, \t
	dsp_assert	$a1, $a2
	.endm

	# Set dsp control register <= (crin & crinmask)
	# Set $ac2 <= {hi, lo}
	# Check if t == (inst ? $ac2, s)
	# Check if (crout & croutmask) == (dsp control register & croutmask)
	.macro dspck_tasimom inst, hi, lo, t, s, crin, crinmask, crout, croutmask
	li	$a0, \crin
	and	$a0, \crinmask
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac2
	li	$a0, \lo
	mtlo	$a0, $ac2
	li	$a0, \s
	\inst	$a1, $ac2, $a0
	li	$a2, \t
	dsp_assert	$a1, $a2
	li	$a0, \crout
	and	$a0, \croutmask
	rddsp	$a1
	and	$a1, \croutmask
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= (crin & crinmask)
	# Set $ac2 <= {hi, lo}
	# Check if t == (inst ? $ac2, s)
	.macro dspck_tasim inst, hi, lo, t, s, crin, crinmask
	li	$a0, \crin
	and	$a0, \crinmask
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac2
	li	$a0, \lo
	mtlo	$a0, $ac2
	li	$a0, \s
	\inst	$a1, $ac2, $a0
	li	$a2, \t
	dsp_assert	$a1, $a2
	.endm

	# Set dsp control register <= crin
	# Set $ac0 <= {hi, lo}
	# (inst $ac0, shift)
	# Check if $ac0 == {hio, loo}
	# Check if crout == dsp control register
	.macro dspck_asaio inst, hi, lo, hio, loo, shift, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac0
	li	$a0, \lo
	mtlo	$a0, $ac0
	\inst	$ac0, \shift
	mfhi	$a1, $ac0
	li	$a2, \hio
	dsp_assert	$a1, $a2
	mflo	$a1, $ac0
	li	$a2, \loo
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Set $ac0 <= {hi, lo}
	# (inst $ac0, s)
	# Check if $ac0 == {hio, loo}
	# Check if crout == dsp control register
	.macro dspck_asio inst, hi, lo, hio, loo, s, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac0
	li	$a0, \lo
	mtlo	$a0, $ac0
	li	$a0, \s
	\inst	$ac0, $a0
	mfhi	$a1, $ac0
	li	$a2, \hio
	dsp_assert	$a1, $a2
	mflo	$a1, $ac0
	li	$a2, \loo
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# Set $ac3 <= {hi, lo}
	# Check if s == (inst ? $ac3)
	# Check if $ac3 == {hio, loo}
	# Check if crout == dsp control register
	.macro dspck_saio inst, hi, lo, hio, loo, s, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a0, \hi
	mthi	$a0, $ac3
	li	$a0, \lo
	mtlo	$a0, $ac3
	li	$a1, \s
	\inst	$a1, $ac3
	mfhi	$a1, $ac3
	li	$a2, \hio
	dsp_assert	$a1, $a2
	mflo	$a1, $ac3
	li	$a2, \loo
	dsp_assert	$a1, $a2
	li	$a0, \crout
	rddsp	$a1
	dsp_assert	$a0, $a1
	.endm

	# Set dsp control register <= crin
	# (wrdsp s, m)
	# Check if crout == dsp control register
	.macro dspck_wrdsp s, m, crin, crout
	li	$a0, \crin
	wrdsp	$a0
	li	$a1, \s
	wrdsp	$a1, \m
	li	$a2, \crout
	rddsp	$a3
	dsp_assert	$a2, $a3
	.endm

	# Set dsp control register <= crin
	# Check if d == (rddsp ?, m)
	.macro dspck_rddsp d, m, crin
	li	$a0, \crin
	wrdsp	$a0
	rddsp	$a1, \m
	li	$a2, \d
	dsp_assert	$a1, $a2
	.endm

	# Check if d == (inst i(b))
	.macro dspck_load inst, d, i, b
	li	$a0, \i
	la	$a1, \b
	\inst	$a2, $a0($a1)
	li	$a3, \d
	dsp_assert	$a2, $a3
	.endm

	# Set dsp control register <= crin
	# Check if bposge32 is taken or not as expected in r
	# (1 => taken, 0 => not taken)
	.macro dspck_bposge32 crin, r
	li	$a0, \crin
	wrdsp	$a0
	li	$a1, 1
	bposge32	1f
	nop
	li	$a1, 0
1:
	li	$a2, \r
	dsp_assert	$a1, $a2
	.endm

	# Check if tou == (inst tin, s)
	.macro dspck_tsimm inst, tou, tin, s, sa
	li	$a0, \s
	li	$a1, \tin
	\inst	$a1, $a0, \sa
	li	$a2, \tou
	dsp_assert	$a1, $a2
	.endm
