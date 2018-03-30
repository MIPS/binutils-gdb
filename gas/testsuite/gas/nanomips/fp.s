	.text
	.ent	fp_test
fp_test:
	abs.s	$f0, $f1
	abs.s	$f30, $f31
	abs.s	$f2, $f2
	abs.s	$f2
	abs.d	$f0, $f1
	abs.d	$f30, $f31
	abs.d	$f2, $f2
	abs.d	$f2

	add.s	$f0, $f1, $f2
	add.s	$f29, $f30, $f31
	add.s	$f29, $f29, $f30
	add.s	$f29, $f30
	add.d	$f0, $f1, $f2
	add.d	$f29, $f30, $f31
	add.d	$f29, $f29, $f30
	add.d	$f29, $f30

	ceil.l.d	$f0, $f1
	ceil.l.d	$f30, $f31
	ceil.l.d	$f2, $f2

	ceil.l.s	$f0, $f1
	ceil.l.s	$f30, $f31
	ceil.l.s	$f2, $f2

	ceil.w.d	$f0, $f1
	ceil.w.d	$f30, $f31
	ceil.w.d	$f2, $f2

	ceil.w.s	$f0, $f1
	ceil.w.s	$f30, $f31
	ceil.w.s	$f2, $f2

	cfc1	$a1, $0
	cfc1	$a1, $1
	cfc1	$a1, $2
	cfc1	$a1, $3
	cfc1	$a1, $4
	cfc1	$a1, $5
	cfc1	$a1, $6
	cfc1	$a1, $7
	cfc1	$a1, $8
	cfc1	$a1, $9
	cfc1	$a1, $10
	cfc1	$a1, $11
	cfc1	$a1, $12
	cfc1	$a1, $13
	cfc1	$a1, $14
	cfc1	$a1, $15
	cfc1	$a1, $16
	cfc1	$a1, $17
	cfc1	$a1, $18
	cfc1	$a1, $19
	cfc1	$a1, $20
	cfc1	$a1, $21
	cfc1	$a1, $22
	cfc1	$a1, $23
	cfc1	$a1, $24
	cfc1	$a1, $25
	cfc1	$a1, $26
	cfc1	$a1, $27
	cfc1	$a1, $28
	cfc1	$a1, $29
	cfc1	$a1, $30
	cfc1	$a1, $31

	cfc1	$a1, $f0
	cfc1	$a1, $f1
	cfc1	$a1, $f2
	cfc1	$a1, $f3
	cfc1	$a1, $f4
	cfc1	$a1, $f5
	cfc1	$a1, $f6
	cfc1	$a1, $f7
	cfc1	$a1, $f8
	cfc1	$a1, $f9
	cfc1	$a1, $f10
	cfc1	$a1, $f11
	cfc1	$a1, $f12
	cfc1	$a1, $f13
	cfc1	$a1, $f14
	cfc1	$a1, $f15
	cfc1	$a1, $f16
	cfc1	$a1, $f17
	cfc1	$a1, $f18
	cfc1	$a1, $f19
	cfc1	$a1, $f20
	cfc1	$a1, $f21
	cfc1	$a1, $f22
	cfc1	$a1, $f23
	cfc1	$a1, $f24
	cfc1	$a1, $f25
	cfc1	$a1, $f26
	cfc1	$a1, $f27
	cfc1	$a1, $f28
	cfc1	$a1, $f29
	cfc1	$a1, $f30
	cfc1	$a1, $f31

	cfc2	$a1, $0
	cfc2	$a1, $1
	cfc2	$a1, $2
	cfc2	$a1, $3
	cfc2	$a1, $4
	cfc2	$a1, $5
	cfc2	$a1, $6
	cfc2	$a1, $7
	cfc2	$a1, $8
	cfc2	$a1, $9
	cfc2	$a1, $10
	cfc2	$a1, $11
	cfc2	$a1, $12
	cfc2	$a1, $13
	cfc2	$a1, $14
	cfc2	$a1, $15
	cfc2	$a1, $16
	cfc2	$a1, $17
	cfc2	$a1, $18
	cfc2	$a1, $19
	cfc2	$a1, $20
	cfc2	$a1, $21
	cfc2	$a1, $22
	cfc2	$a1, $23
	cfc2	$a1, $24
	cfc2	$a1, $25
	cfc2	$a1, $26
	cfc2	$a1, $27
	cfc2	$a1, $28
	cfc2	$a1, $29
	cfc2	$a1, $30
	cfc2	$a1, $31
 	ctc1	$a1, $0
	ctc1	$a1, $1
	ctc1	$a1, $2
	ctc1	$a1, $3
	ctc1	$a1, $4
	ctc1	$a1, $5
	ctc1	$a1, $6
	ctc1	$a1, $7
	ctc1	$a1, $8
	ctc1	$a1, $9
	ctc1	$a1, $10
	ctc1	$a1, $11
	ctc1	$a1, $12
	ctc1	$a1, $13
	ctc1	$a1, $14
	ctc1	$a1, $15
	ctc1	$a1, $16
	ctc1	$a1, $17
	ctc1	$a1, $18
	ctc1	$a1, $19
	ctc1	$a1, $20
	ctc1	$a1, $21
	ctc1	$a1, $22
	ctc1	$a1, $23
	ctc1	$a1, $24
	ctc1	$a1, $25
	ctc1	$a1, $26
	ctc1	$a1, $27
	ctc1	$a1, $28
	ctc1	$a1, $29
	ctc1	$a1, $30
	ctc1	$a1, $31

	ctc1	$a1, $f0
	ctc1	$a1, $f1
	ctc1	$a1, $f2
	ctc1	$a1, $f3
	ctc1	$a1, $f4
	ctc1	$a1, $f5
	ctc1	$a1, $f6
	ctc1	$a1, $f7
	ctc1	$a1, $f8
	ctc1	$a1, $f9
	ctc1	$a1, $f10
	ctc1	$a1, $f11
	ctc1	$a1, $f12
	ctc1	$a1, $f13
	ctc1	$a1, $f14
	ctc1	$a1, $f15
	ctc1	$a1, $f16
	ctc1	$a1, $f17
	ctc1	$a1, $f18
	ctc1	$a1, $f19
	ctc1	$a1, $f20
	ctc1	$a1, $f21
	ctc1	$a1, $f22
	ctc1	$a1, $f23
	ctc1	$a1, $f24
	ctc1	$a1, $f25
	ctc1	$a1, $f26
	ctc1	$a1, $f27
	ctc1	$a1, $f28
	ctc1	$a1, $f29
	ctc1	$a1, $f30
	ctc1	$a1, $f31

	ctc2	$a1, $0
	ctc2	$a1, $1
	ctc2	$a1, $2
	ctc2	$a1, $3
	ctc2	$a1, $4
	ctc2	$a1, $5
	ctc2	$a1, $6
	ctc2	$a1, $7
	ctc2	$a1, $8
	ctc2	$a1, $9
	ctc2	$a1, $10
	ctc2	$a1, $11
	ctc2	$a1, $12
	ctc2	$a1, $13
	ctc2	$a1, $14
	ctc2	$a1, $15
	ctc2	$a1, $16
	ctc2	$a1, $17
	ctc2	$a1, $18
	ctc2	$a1, $19
	ctc2	$a1, $20
	ctc2	$a1, $21
	ctc2	$a1, $22
	ctc2	$a1, $23
	ctc2	$a1, $24
	ctc2	$a1, $25
	ctc2	$a1, $26
	ctc2	$a1, $27
	ctc2	$a1, $28
	ctc2	$a1, $29
	ctc2	$a1, $30
	ctc2	$a1, $31

	cvt.d.l	$f0, $f1
	cvt.d.l	$f30, $f31
	cvt.d.l	$f2, $f2

	cvt.d.s	$f0, $f1
	cvt.d.s	$f30, $f31
	cvt.d.s	$f2, $f2

	cvt.d.w	$f0, $f1
	cvt.d.w	$f30, $f31
	cvt.d.w	$f2, $f2

	cvt.l.s	$f0, $f1
	cvt.l.s	$f30, $f31
	cvt.l.s	$f2, $f2

	cvt.l.d	$f0, $f1
	cvt.l.d	$f30, $f31
	cvt.l.d	$f2, $f2

	cvt.s.l	$f0, $f1
	cvt.s.l	$f30, $f31
	cvt.s.l	$f2, $f2

	cvt.s.d	$f0, $f1
	cvt.s.d	$f30, $f31
	cvt.s.d	$f2, $f2

	cvt.s.w	$f0, $f1
	cvt.s.w	$f30, $f31
	cvt.s.w	$f2, $f2

	cvt.w.s	$f0, $f1
	cvt.w.s	$f30, $f31
	cvt.w.s	$f2, $f2

	cvt.w.d	$f0, $f1
	cvt.w.d	$f30, $f31
	cvt.w.d	$f2, $f2

	div.d	$f0, $f1, $f2
	div.d	$f29, $f30, $f31
	div.d	$f29, $f29, $f30
	div.d	$f29, $f30

	div.s	$f0, $f1, $f2
	div.s	$f29, $f30, $f31
	div.s	$f29, $f29, $f30
	div.s	$f29, $f30

	floor.l.d	$f0, $f1
	floor.l.d	$f30, $f31
	floor.l.d	$f2, $f2

	floor.l.s	$f0, $f1
	floor.l.s	$f30, $f31
	floor.l.s	$f2, $f2

	floor.w.d	$f0, $f1
	floor.w.d	$f30, $f31
	floor.w.d	$f2, $f2

	floor.w.s	$f0, $f1
	floor.w.s	$f30, $f31
	floor.w.s	$f2, $f2

	ldc1	$3, 0
	ldc1	$3, ($zero)
	ldc1	$3, 4
	ldc1	$3, 4($zero)
	ldc1	$3, ($a0)
	ldc1	$3, 0($a0)
	ldc1	$3, 32767($a0)
	ldc1	$3, -32768($a0)
	ldc1	$3, 65535($a0)
	ldc1	$3, 0xffff0000($a0)
	ldc1	$3, 0xffff8000($a0)
	ldc1	$3, 0xffff0001($a0)
	ldc1	$3, 0xffff8001($a0)
	ldc1	$3, 0xf0000000($a0)
	ldc1	$3, 0xffffffff($a0)
	ldc1	$3, 0x12345678($a0)

	ldc1	$f3, 0
	ldc1	$f3, ($zero)
	ldc1	$f3, 4
	ldc1	$f3, 4($zero)
	ldc1	$f3, ($a0)
	ldc1	$f3, 0($a0)
	ldc1	$f3, 32767($a0)
	ldc1	$f3, -32768($a0)
	ldc1	$f3, 65535($a0)
	ldc1	$f3, 0xffff0000($a0)
	ldc1	$f3, 0xffff8000($a0)
	ldc1	$f3, 0xffff0001($a0)
	ldc1	$f3, 0xffff8001($a0)
	ldc1	$f3, 0xf0000000($a0)
	ldc1	$f3, 0xffffffff($a0)
	ldc1	$f3, 0x12345678($a0)

	l.d	$f3, 0
	l.d	$f3, ($zero)
	l.d	$f3, 4
	l.d	$f3, 4($zero)
	l.d	$f3, ($a0)
	l.d	$f3, 0($a0)
	l.d	$f3, 32767($a0)
	l.d	$f3, -32768($a0)

	ldxc1	$f0, $zero($zero)
	ldxc1	$f0, $zero($t4)
	ldxc1	$f0, $zero($ra)
	ldxc1	$f0, $t4($ra)
	ldxc1	$f0, $ra($ra)
	ldxc1	$f1, $ra($ra)
	ldxc1	$f2, $ra($ra)
	ldxc1	$f31, $ra($ra)

	lwc1	$3, 0
	lwc1	$3, ($zero)
	lwc1	$3, 4
	lwc1	$3, 4($zero)
	lwc1	$3, ($a0)
	lwc1	$3, 0($a0)
	lwc1	$3, 32767($a0)
	lwc1	$3, -32768($a0)
	lwc1	$3, 65535($a0)
	lwc1	$3, 0xffff0000($a0)
	lwc1	$3, 0xffff8000($a0)
	lwc1	$3, 0xffff0001($a0)
	lwc1	$3, 0xffff8001($a0)
	lwc1	$3, 0xf0000000($a0)
	lwc1	$3, 0xffffffff($a0)
	lwc1	$3, 0x12345678($a0)
	lwc1	$f3, 0
	lwc1	$f3, ($zero)
	lwc1	$f3, 4
	lwc1	$f3, 4($zero)
	lwc1	$f3, ($a0)
	lwc1	$f3, 0($a0)
	lwc1	$f3, 32767($a0)
	lwc1	$f3, -32768($a0)
	lwc1	$f3, 65535($a0)
	lwc1	$f3, 0xffff0000($a0)
	lwc1	$f3, 0xffff8000($a0)
	lwc1	$f3, 0xffff0001($a0)
	lwc1	$f3, 0xffff8001($a0)
	lwc1	$f3, 0xf0000000($a0)
	lwc1	$f3, 0xffffffff($a0)
	lwc1	$f3, 0x12345678($a0)

	l.s	$f3, 0
	l.s	$f3, ($zero)
	l.s	$f3, 4
	l.s	$f3, 4($zero)
	l.s	$f3, ($a0)
	l.s	$f3, 0($a0)
	l.s	$f3, 32767($a0)
	l.s	$f3, -32768($a0)
	l.s	$f3, 65535($a0)
	l.s	$f3, 0xffff0000($a0)
	l.s	$f3, 0xffff8000($a0)
	l.s	$f3, 0xffff0001($a0)
	l.s	$f3, 0xffff8001($a0)
	l.s	$f3, 0xf0000000($a0)
	l.s	$f3, 0xffffffff($a0)
	l.s	$f3, 0x12345678($a0)

	lwxc1	$f0, $zero($zero)
	lwxc1	$f0, $zero($t4)
	lwxc1	$f0, $zero($ra)
	lwxc1	$f0, $t4($ra)
	lwxc1	$f0, $ra($ra)
	lwxc1	$f1, $ra($ra)
	lwxc1	$f2, $ra($ra)
	lwxc1	$f31, $ra($ra)

	mfc1	$a1, $0
	mfc1	$a1, $1
	mfc1	$a1, $2
	mfc1	$a1, $3
	mfc1	$a1, $4
	mfc1	$a1, $5
	mfc1	$a1, $6
	mfc1	$a1, $7
	mfc1	$a1, $8
	mfc1	$a1, $9
	mfc1	$a1, $10
	mfc1	$a1, $11
	mfc1	$a1, $12
	mfc1	$a1, $13
	mfc1	$a1, $14
	mfc1	$a1, $15
	mfc1	$a1, $16
	mfc1	$a1, $17
	mfc1	$a1, $18
	mfc1	$a1, $19
	mfc1	$a1, $20
	mfc1	$a1, $21
	mfc1	$a1, $22
	mfc1	$a1, $23
	mfc1	$a1, $24
	mfc1	$a1, $25
	mfc1	$a1, $26
	mfc1	$a1, $27
	mfc1	$a1, $28
	mfc1	$a1, $29
	mfc1	$a1, $30
	mfc1	$a1, $31

	mfc1	$a1, $f0
	mfc1	$a1, $f1
	mfc1	$a1, $f2
	mfc1	$a1, $f3
	mfc1	$a1, $f4
	mfc1	$a1, $f5
	mfc1	$a1, $f6
	mfc1	$a1, $f7
	mfc1	$a1, $f8
	mfc1	$a1, $f9
	mfc1	$a1, $f10
	mfc1	$a1, $f11
	mfc1	$a1, $f12
	mfc1	$a1, $f13
	mfc1	$a1, $f14
	mfc1	$a1, $f15
	mfc1	$a1, $f16
	mfc1	$a1, $f17
	mfc1	$a1, $f18
	mfc1	$a1, $f19
	mfc1	$a1, $f20
	mfc1	$a1, $f21
	mfc1	$a1, $f22
	mfc1	$a1, $f23
	mfc1	$a1, $f24
	mfc1	$a1, $f25
	mfc1	$a1, $f26
	mfc1	$a1, $f27
	mfc1	$a1, $f28
	mfc1	$a1, $f29
	mfc1	$a1, $f30
	mfc1	$a1, $f31

	mfhc1	$a1, $0
	mfhc1	$a1, $1
	mfhc1	$a1, $2
	mfhc1	$a1, $3
	mfhc1	$a1, $4
	mfhc1	$a1, $5
	mfhc1	$a1, $6
	mfhc1	$a1, $7
	mfhc1	$a1, $8
	mfhc1	$a1, $9
	mfhc1	$a1, $10
	mfhc1	$a1, $11
	mfhc1	$a1, $12
	mfhc1	$a1, $13
	mfhc1	$a1, $14
	mfhc1	$a1, $15
	mfhc1	$a1, $16
	mfhc1	$a1, $17
	mfhc1	$a1, $18
	mfhc1	$a1, $19
	mfhc1	$a1, $20
	mfhc1	$a1, $21
	mfhc1	$a1, $22
	mfhc1	$a1, $23
	mfhc1	$a1, $24
	mfhc1	$a1, $25
	mfhc1	$a1, $26
	mfhc1	$a1, $27
	mfhc1	$a1, $28
	mfhc1	$a1, $29
	mfhc1	$a1, $30
	mfhc1	$a1, $31

	mfhc1	$a1, $f0
	mfhc1	$a1, $f1
	mfhc1	$a1, $f2
	mfhc1	$a1, $f3
	mfhc1	$a1, $f4
	mfhc1	$a1, $f5
	mfhc1	$a1, $f6
	mfhc1	$a1, $f7
	mfhc1	$a1, $f8
	mfhc1	$a1, $f9
	mfhc1	$a1, $f10
	mfhc1	$a1, $f11
	mfhc1	$a1, $f12
	mfhc1	$a1, $f13
	mfhc1	$a1, $f14
	mfhc1	$a1, $f15
	mfhc1	$a1, $f16
	mfhc1	$a1, $f17
	mfhc1	$a1, $f18
	mfhc1	$a1, $f19
	mfhc1	$a1, $f20
	mfhc1	$a1, $f21
	mfhc1	$a1, $f22
	mfhc1	$a1, $f23
	mfhc1	$a1, $f24
	mfhc1	$a1, $f25
	mfhc1	$a1, $f26
	mfhc1	$a1, $f27
	mfhc1	$a1, $f28
	mfhc1	$a1, $f29
	mfhc1	$a1, $f30
	mfhc1	$a1, $f31

	mov.d	$f0, $f1
	mov.d	$f30, $f31
	mov.s	$f0, $f1
	mov.s	$f30, $f31

	mtc1	$a1, $0
	mtc1	$a1, $1
	mtc1	$a1, $2
	mtc1	$a1, $3
	mtc1	$a1, $4
	mtc1	$a1, $5
	mtc1	$a1, $6
	mtc1	$a1, $7
	mtc1	$a1, $8
	mtc1	$a1, $9
	mtc1	$a1, $10
	mtc1	$a1, $11
	mtc1	$a1, $12
	mtc1	$a1, $13
	mtc1	$a1, $14
	mtc1	$a1, $15
	mtc1	$a1, $16
	mtc1	$a1, $17
	mtc1	$a1, $18
	mtc1	$a1, $19
	mtc1	$a1, $20
	mtc1	$a1, $21
	mtc1	$a1, $22
	mtc1	$a1, $23
	mtc1	$a1, $24
	mtc1	$a1, $25
	mtc1	$a1, $26
	mtc1	$a1, $27
	mtc1	$a1, $28
	mtc1	$a1, $29
	mtc1	$a1, $30
	mtc1	$a1, $31

	mtc1	$a1, $f0
	mtc1	$a1, $f1
	mtc1	$a1, $f2
	mtc1	$a1, $f3
	mtc1	$a1, $f4
	mtc1	$a1, $f5
	mtc1	$a1, $f6
	mtc1	$a1, $f7
	mtc1	$a1, $f8
	mtc1	$a1, $f9
	mtc1	$a1, $f10
	mtc1	$a1, $f11
	mtc1	$a1, $f12
	mtc1	$a1, $f13
	mtc1	$a1, $f14
	mtc1	$a1, $f15
	mtc1	$a1, $f16
	mtc1	$a1, $f17
	mtc1	$a1, $f18
	mtc1	$a1, $f19
	mtc1	$a1, $f20
	mtc1	$a1, $f21
	mtc1	$a1, $f22
	mtc1	$a1, $f23
	mtc1	$a1, $f24
	mtc1	$a1, $f25
	mtc1	$a1, $f26
	mtc1	$a1, $f27
	mtc1	$a1, $f28
	mtc1	$a1, $f29
	mtc1	$a1, $f30
	mtc1	$a1, $f31

	mthc1	$a1, $0
	mthc1	$a1, $1
	mthc1	$a1, $2
	mthc1	$a1, $3
	mthc1	$a1, $4
	mthc1	$a1, $5
	mthc1	$a1, $6
	mthc1	$a1, $7
	mthc1	$a1, $8
	mthc1	$a1, $9
	mthc1	$a1, $10
	mthc1	$a1, $11
	mthc1	$a1, $12
	mthc1	$a1, $13
	mthc1	$a1, $14
	mthc1	$a1, $15
	mthc1	$a1, $16
	mthc1	$a1, $17
	mthc1	$a1, $18
	mthc1	$a1, $19
	mthc1	$a1, $20
	mthc1	$a1, $21
	mthc1	$a1, $22
	mthc1	$a1, $23
	mthc1	$a1, $24
	mthc1	$a1, $25
	mthc1	$a1, $26
	mthc1	$a1, $27
	mthc1	$a1, $28
	mthc1	$a1, $29
	mthc1	$a1, $30
	mthc1	$a1, $31

	mthc1	$a1, $f0
	mthc1	$a1, $f1
	mthc1	$a1, $f2
	mthc1	$a1, $f3
	mthc1	$a1, $f4
	mthc1	$a1, $f5
	mthc1	$a1, $f6
	mthc1	$a1, $f7
	mthc1	$a1, $f8
	mthc1	$a1, $f9
	mthc1	$a1, $f10
	mthc1	$a1, $f11
	mthc1	$a1, $f12
	mthc1	$a1, $f13
	mthc1	$a1, $f14
	mthc1	$a1, $f15
	mthc1	$a1, $f16
	mthc1	$a1, $f17
	mthc1	$a1, $f18
	mthc1	$a1, $f19
	mthc1	$a1, $f20
	mthc1	$a1, $f21
	mthc1	$a1, $f22
	mthc1	$a1, $f23
	mthc1	$a1, $f24
	mthc1	$a1, $f25
	mthc1	$a1, $f26
	mthc1	$a1, $f27
	mthc1	$a1, $f28
	mthc1	$a1, $f29
	mthc1	$a1, $f30
	mthc1	$a1, $f31

	mul.s	$f0, $f1, $f2
	mul.s	$f29, $f30, $f31
	mul.s	$f29, $f29, $f30
	mul.s	$f29, $f30
	mul.d	$f0, $f1, $f2
	mul.d	$f29, $f30, $f31
	mul.d	$f29, $f29, $f30
	mul.d	$f29, $f30

	neg.s	$f0, $f1
	neg.s	$f30, $f31
	neg.s	$f2, $f2
	neg.s	$f2
	neg.d	$f0, $f1
	neg.d	$f30, $f31
	neg.d	$f2, $f2
	neg.d	$f2

	recip.s	$f0, $f1
	recip.s	$f30, $f31
	recip.s	$f2, $f2
	recip.d	$f0, $f1
	recip.d	$f30, $f31
	recip.d	$f2, $f2

	round.l.s	$f0, $f1
	round.l.s	$f30, $f31
	round.l.s	$f2, $f2
	round.l.d	$f0, $f1
	round.l.d	$f30, $f31
	round.l.d	$f2, $f2

	round.w.s	$f0, $f1
	round.w.s	$f30, $f31
	round.w.s	$f2, $f2
	round.w.d	$f0, $f1
	round.w.d	$f30, $f31
	round.w.d	$f2, $f2

	rsqrt.s	$f0, $f1
	rsqrt.s	$f30, $f31
	rsqrt.s	$f2, $f2
	rsqrt.d	$f0, $f1
	rsqrt.d	$f30, $f31
	rsqrt.d	$f2, $f2

	sdc1	$3, 0
	sdc1	$3, ($zero)
	sdc1	$3, 4
	sdc1	$3, 4($zero)
	sdc1	$3, ($a0)
	sdc1	$3, 0($a0)
	sdc1	$3, 32767($a0)
	sdc1	$3, -32768($a0)
	sdc1	$3, 65535($a0)
	sdc1	$3, 0xffff0000($a0)
	sdc1	$3, 0xffff8000($a0)
	sdc1	$3, 0xffff0001($a0)
	sdc1	$3, 0xffff8001($a0)
	sdc1	$3, 0xf0000000($a0)
	sdc1	$3, 0xffffffff($a0)
	sdc1	$3, 0x12345678($a0)

	sdc1	$f3, 0
	sdc1	$f3, ($zero)
	sdc1	$f3, 4
	sdc1	$f3, 4($zero)
	sdc1	$f3, ($a0)
	sdc1	$f3, 0($a0)
	sdc1	$f3, 32767($a0)
	sdc1	$f3, -32768($a0)
	sdc1	$f3, 65535($a0)
	sdc1	$f3, 0xffff0000($a0)
	sdc1	$f3, 0xffff8000($a0)
	sdc1	$f3, 0xffff0001($a0)
	sdc1	$f3, 0xffff8001($a0)
	sdc1	$f3, 0xf0000000($a0)
	sdc1	$f3, 0xffffffff($a0)
	sdc1	$f3, 0x12345678($a0)

	s.d	$f3, 0
	s.d	$f3, ($zero)
	s.d	$f3, 4
	s.d	$f3, 4($zero)
	s.d	$f3, ($a0)
	s.d	$f3, 0($a0)
	s.d	$f3, 32767($a0)
	s.d	$f3, -32768($a0)

	sdxc1	$f0, $zero($zero)
	sdxc1	$f0, $zero($t4)
	sdxc1	$f0, $zero($ra)
	sdxc1	$f0, $t4($ra)
	sdxc1	$f0, $ra($ra)
	sdxc1	$f1, $ra($ra)
	sdxc1	$f2, $ra($ra)
	sdxc1	$f31, $ra($ra)

	sqrt.s	$f0, $f1
	sqrt.s	$f30, $f31
	sqrt.s	$f2, $f2
	sqrt.d	$f0, $f1
	sqrt.d	$f30, $f31
	sqrt.d	$f2, $f2

	sub.s	$f0, $f1, $f2
	sub.s	$f29, $f30, $f31
	sub.s	$f29, $f29, $f30
	sub.s	$f29, $f30
	sub.d	$f0, $f1, $f2
	sub.d	$f29, $f30, $f31
	sub.d	$f29, $f29, $f30
	sub.d	$f29, $f30

	swc1	$3, 0
	swc1	$3, ($zero)
	swc1	$3, 4
	swc1	$3, 4($zero)
	swc1	$3, ($a0)
	swc1	$3, 0($a0)
	swc1	$3, 32767($a0)
	swc1	$3, -32768($a0)
	swc1	$3, 65535($a0)
	swc1	$3, 0xffff0000($a0)
	swc1	$3, 0xffff8000($a0)
	swc1	$3, 0xffff0001($a0)
	swc1	$3, 0xffff8001($a0)
	swc1	$3, 0xf0000000($a0)
	swc1	$3, 0xffffffff($a0)
	swc1	$3, 0x12345678($a0)

	swc1	$f3, 0
	swc1	$f3, ($zero)
	swc1	$f3, 4
	swc1	$f3, 4($zero)
	swc1	$f3, ($a0)
	swc1	$f3, 0($a0)
	swc1	$f3, 32767($a0)
	swc1	$f3, -32768($a0)
	swc1	$f3, 65535($a0)
	swc1	$f3, 0xffff0000($a0)
	swc1	$f3, 0xffff8000($a0)
	swc1	$f3, 0xffff0001($a0)
	swc1	$f3, 0xffff8001($a0)
	swc1	$f3, 0xf0000000($a0)
	swc1	$f3, 0xffffffff($a0)
	swc1	$f3, 0x12345678($a0)

	s.s	$f3, 0
	s.s	$f3, ($zero)
	s.s	$f3, 4
	s.s	$f3, 4($zero)
	s.s	$f3, ($a0)
	s.s	$f3, 0($a0)
	s.s	$f3, 32767($a0)
	s.s	$f3, -32768($a0)
	s.s	$f3, 65535($a0)
	s.s	$f3, 0xffff0000($a0)
	s.s	$f3, 0xffff8000($a0)
	s.s	$f3, 0xffff0001($a0)
	s.s	$f3, 0xffff8001($a0)
	s.s	$f3, 0xf0000000($a0)
	s.s	$f3, 0xffffffff($a0)
	s.s	$f3, 0x12345678($a0)

	swxc1	$f0, $zero($zero)
	swxc1	$f0, $zero($t4)
	swxc1	$f0, $zero($ra)
	swxc1	$f0, $t4($ra)
	swxc1	$f0, $ra($ra)
	swxc1	$f1, $ra($ra)
	swxc1	$f2, $ra($ra)
	swxc1	$f31, $ra($ra)

	trunc.l.s	$f0, $f1
	trunc.l.s	$f30, $f31
	trunc.l.s	$f2, $f2
	trunc.l.d	$f0, $f1
	trunc.l.d	$f30, $f31
	trunc.l.d	$f2, $f2

	trunc.w.s	$f0, $f1
	trunc.w.s	$f30, $f31
	trunc.w.s	$f2, $f2
	trunc.w.d	$f0, $f1
	trunc.w.d	$f30, $f31
	trunc.w.d	$f2, $f2
	.end	fp_test
