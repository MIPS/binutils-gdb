	.text
	.align	3
	.globl	test_mips64
	.ent	test_mips64

test_mips64:
	dabs	$2, $3
	dabs	$2, $2
	dabs	$2

	dadd	$2, $3, $4
	dadd	$29, $30, $31
	dadd	$2, $2, $3
	dadd	$2, $3

	dadd	$2, $3, 0
	dadd	$2, $3, 1
	dadd	$2, $3, -512
	dadd	$2, $3, 511
	dadd	$2, $3, 32767
	dadd	$2, $3, -32768
	dadd	$2, $3, 65535
	dadd	$2, $3, 0x12345678
	dadd	$2, $3, 0x1234567887654321

	daddi	$2, $3, 0
	daddi	$2, $3, 1
	daddi	$2, $3, -512
	daddi	$2, $3, 511
	daddi	$2, $2, 511
	daddi	$2, 511
	daddi	$2, $3, 32767
	daddi	$2, $3, -32768
	daddi	$2, $3, 65535
	daddi	$2, $3, 0x12345678

	daddiu	$2, $3, 0
	daddiu	$2, $3, -32768
	daddiu	$2, $3, 32767
	daddiu	$2, $2, 32767
	daddiu	$2, 32767

	daddu	$2, $3, $4
	daddu	$29, $30, $31
	daddu	$2, $2, $3
	daddu	$2, $3
	daddu	$2, $3, $0
	daddu	$2, $3, 0
	daddu	$2, $3, 1
	daddu	$2, $3, 32767
	daddu	$2, $3, -32768
	daddu	$2, $3, 65535

	dclo	$2, $3
	dclo	$3, $2
	dclz	$2, $3
	dclz	$3, $2

	ddiv	$0, $2, $3
	ddiv	$0, $30, $31
	ddiv	$0, $3
	ddiv	$0, $31

	ddiv	$2, $3, $0
	ddiv	$2, $3, $4

	ddiv	$3, $4, 0
	ddiv	$3, $4, 1
	ddiv	$3, $4, -1
	ddiv	$3, $4, 2

	ddivu	$0, $2, $3
	ddivu	$0, $30, $31
	ddivu	$0, $3
	ddivu	$0, $31

	ddivu	$2, $3, $0
	ddivu	$2, $3, $4

	ddivu	$3, $4, 0
	ddivu	$3, $4, 1
	ddivu	$3, $4, -1
	ddivu	$3, $4, 2

	dext	$2, $3, 31, 1
	dext	$2, $3, 0, 32

	dext	$2, $3, 31, 33
	dextm	$2, $3, 31, 33

	dext	$2, $3, 33, 10
	dextu	$2, $3, 33, 10

	dins	$2, $3, 31, 1
	dins	$2, $3, 0, 32

	dins	$2, $3, 31, 33
	dinsm	$2, $3, 31, 33

	dins	$2, $3, 33, 10
	dinsu	$2, $3, 33, 10

	dla	$2, test
	dlca	$2, test

	dli	$2, -32768
	dli	$2, 32767
	dli	$2, 65535
	dli	$2, 0x12345678

	dmfc0	$2, $0
	dmfc0	$2, $1
	dmfc0	$2, $2
	dmfc0	$2, $3
	dmfc0	$2, $4
	dmfc0	$2, $5
	dmfc0	$2, $6
	dmfc0	$2, $7
	dmfc0	$2, $8
	dmfc0	$2, $9
	dmfc0	$2, $10
	dmfc0	$2, $11
	dmfc0	$2, $12
	dmfc0	$2, $13
	dmfc0	$2, $14
	dmfc0	$2, $15
	dmfc0	$2, $16
	dmfc0	$2, $17
	dmfc0	$2, $18
	dmfc0	$2, $19
	dmfc0	$2, $20
	dmfc0	$2, $21
	dmfc0	$2, $22
	dmfc0	$2, $23
	dmfc0	$2, $24
	dmfc0	$2, $25
	dmfc0	$2, $26
	dmfc0	$2, $27
	dmfc0	$2, $28
	dmfc0	$2, $29
	dmfc0	$2, $30
	dmfc0	$2, $31
	dmfc0	$2, $0, 0
	dmfc0	$2, $0, 1
	dmfc0	$2, $0, 2
	dmfc0	$2, $0, 3
	dmfc0	$2, $0, 4
	dmfc0	$2, $0, 5
	dmfc0	$2, $0, 6
	dmfc0	$2, $0, 7
	dmfc0	$2, $1, 0
	dmfc0	$2, $1, 1
	dmfc0	$2, $1, 2
	dmfc0	$2, $1, 3
	dmfc0	$2, $1, 4
	dmfc0	$2, $1, 5
	dmfc0	$2, $1, 6
	dmfc0	$2, $1, 7
	dmfc0	$2, $2, 0
	dmfc0	$2, $2, 1
	dmfc0	$2, $2, 2
	dmfc0	$2, $2, 3
	dmfc0	$2, $2, 4
	dmfc0	$2, $2, 5
	dmfc0	$2, $2, 6
	dmfc0	$2, $2, 7

	dmtc0	$2, $0
	dmtc0	$2, $1
	dmtc0	$2, $2
	dmtc0	$2, $3
	dmtc0	$2, $4
	dmtc0	$2, $5
	dmtc0	$2, $6
	dmtc0	$2, $7
	dmtc0	$2, $8
	dmtc0	$2, $9
	dmtc0	$2, $10
	dmtc0	$2, $11
	dmtc0	$2, $12
	dmtc0	$2, $13
	dmtc0	$2, $14
	dmtc0	$2, $15
	dmtc0	$2, $16
	dmtc0	$2, $17
	dmtc0	$2, $18
	dmtc0	$2, $19
	dmtc0	$2, $20
	dmtc0	$2, $21
	dmtc0	$2, $22
	dmtc0	$2, $23
	dmtc0	$2, $24
	dmtc0	$2, $25
	dmtc0	$2, $26
	dmtc0	$2, $27
	dmtc0	$2, $28
	dmtc0	$2, $29
	dmtc0	$2, $30
	dmtc0	$2, $31
	dmtc0	$2, $0, 0
	dmtc0	$2, $0, 1
	dmtc0	$2, $0, 2
	dmtc0	$2, $0, 3
	dmtc0	$2, $0, 4
	dmtc0	$2, $0, 5
	dmtc0	$2, $0, 6
	dmtc0	$2, $0, 7
	dmtc0	$2, $1, 0
	dmtc0	$2, $1, 1
	dmtc0	$2, $1, 2
	dmtc0	$2, $1, 3
	dmtc0	$2, $1, 4
	dmtc0	$2, $1, 5
	dmtc0	$2, $1, 6
	dmtc0	$2, $1, 7
	dmtc0	$2, $2, 0
	dmtc0	$2, $2, 1
	dmtc0	$2, $2, 2
	dmtc0	$2, $2, 3
	dmtc0	$2, $2, 4
	dmtc0	$2, $2, 5
	dmtc0	$2, $2, 6
	dmtc0	$2, $2, 7

	dmfc1	$5, $0
	dmfc1	$5, $1
	dmfc1	$5, $2
	dmfc1	$5, $3
	dmfc1	$5, $4
	dmfc1	$5, $5
	dmfc1	$5, $6
	dmfc1	$5, $7
	dmfc1	$5, $8
	dmfc1	$5, $9
	dmfc1	$5, $10
	dmfc1	$5, $11
	dmfc1	$5, $12
	dmfc1	$5, $13
	dmfc1	$5, $14
	dmfc1	$5, $15
	dmfc1	$5, $16
	dmfc1	$5, $17
	dmfc1	$5, $18
	dmfc1	$5, $19
	dmfc1	$5, $20
	dmfc1	$5, $21
	dmfc1	$5, $22
	dmfc1	$5, $23
	dmfc1	$5, $24
	dmfc1	$5, $25
	dmfc1	$5, $26
	dmfc1	$5, $27
	dmfc1	$5, $28
	dmfc1	$5, $29
	dmfc1	$5, $30
	dmfc1	$5, $31
	dmfc1	$5, $f0
	dmfc1	$5, $f1
	dmfc1	$5, $f2
	dmfc1	$5, $f3
	dmfc1	$5, $f4
	dmfc1	$5, $f5
	dmfc1	$5, $f6
	dmfc1	$5, $f7
	dmfc1	$5, $f8
	dmfc1	$5, $f9
	dmfc1	$5, $f10
	dmfc1	$5, $f11
	dmfc1	$5, $f12
	dmfc1	$5, $f13
	dmfc1	$5, $f14
	dmfc1	$5, $f15
	dmfc1	$5, $f16
	dmfc1	$5, $f17
	dmfc1	$5, $f18
	dmfc1	$5, $f19
	dmfc1	$5, $f20
	dmfc1	$5, $f21
	dmfc1	$5, $f22
	dmfc1	$5, $f23
	dmfc1	$5, $f24
	dmfc1	$5, $f25
	dmfc1	$5, $f26
	dmfc1	$5, $f27
	dmfc1	$5, $f28
	dmfc1	$5, $f29
	dmfc1	$5, $f30
	dmfc1	$5, $f31

	dmtc1	$5, $0
	dmtc1	$5, $1
	dmtc1	$5, $2
	dmtc1	$5, $3
	dmtc1	$5, $4
	dmtc1	$5, $5
	dmtc1	$5, $6
	dmtc1	$5, $7
	dmtc1	$5, $8
	dmtc1	$5, $9
	dmtc1	$5, $10
	dmtc1	$5, $11
	dmtc1	$5, $12
	dmtc1	$5, $13
	dmtc1	$5, $14
	dmtc1	$5, $15
	dmtc1	$5, $16
	dmtc1	$5, $17
	dmtc1	$5, $18
	dmtc1	$5, $19
	dmtc1	$5, $20
	dmtc1	$5, $21
	dmtc1	$5, $22
	dmtc1	$5, $23
	dmtc1	$5, $24
	dmtc1	$5, $25
	dmtc1	$5, $26
	dmtc1	$5, $27
	dmtc1	$5, $28
	dmtc1	$5, $29
	dmtc1	$5, $30
	dmtc1	$5, $31
	dmtc1	$5, $f0
	dmtc1	$5, $f1
	dmtc1	$5, $f2
	dmtc1	$5, $f3
	dmtc1	$5, $f4
	dmtc1	$5, $f5
	dmtc1	$5, $f6
	dmtc1	$5, $f7
	dmtc1	$5, $f8
	dmtc1	$5, $f9
	dmtc1	$5, $f10
	dmtc1	$5, $f11
	dmtc1	$5, $f12
	dmtc1	$5, $f13
	dmtc1	$5, $f14
	dmtc1	$5, $f15
	dmtc1	$5, $f16
	dmtc1	$5, $f17
	dmtc1	$5, $f18
	dmtc1	$5, $f19
	dmtc1	$5, $f20
	dmtc1	$5, $f21
	dmtc1	$5, $f22
	dmtc1	$5, $f23
	dmtc1	$5, $f24
	dmtc1	$5, $f25
	dmtc1	$5, $f26
	dmtc1	$5, $f27
	dmtc1	$5, $f28
	dmtc1	$5, $f29
	dmtc1	$5, $f30
	dmtc1	$5, $f31

	dmfc2	$2, $0
	dmfc2	$2, $1
	dmfc2	$2, $2
	dmfc2	$2, $3
	dmfc2	$2, $4
	dmfc2	$2, $5
	dmfc2	$2, $6
	dmfc2	$2, $7
	dmfc2	$2, $8
	dmfc2	$2, $9
	dmfc2	$2, $10
	dmfc2	$2, $11
	dmfc2	$2, $12
	dmfc2	$2, $13
	dmfc2	$2, $14
	dmfc2	$2, $15
	dmfc2	$2, $16
	dmfc2	$2, $17
	dmfc2	$2, $18
	dmfc2	$2, $19
	dmfc2	$2, $20
	dmfc2	$2, $21
	dmfc2	$2, $22
	dmfc2	$2, $23
	dmfc2	$2, $24
	dmfc2	$2, $25
	dmfc2	$2, $26
	dmfc2	$2, $27
	dmfc2	$2, $28
	dmfc2	$2, $29
	dmfc2	$2, $30
	dmfc2	$2, $31
/*
	dmfc2	$2, $0, 0
	dmfc2	$2, $0, 1
	dmfc2	$2, $0, 2
	dmfc2	$2, $0, 3
	dmfc2	$2, $0, 4
	dmfc2	$2, $0, 5
	dmfc2	$2, $0, 6
	dmfc2	$2, $0, 7
	dmfc2	$2, $1, 0
	dmfc2	$2, $1, 1
	dmfc2	$2, $1, 2
	dmfc2	$2, $1, 3
	dmfc2	$2, $1, 4
	dmfc2	$2, $1, 5
	dmfc2	$2, $1, 6
	dmfc2	$2, $1, 7
	dmfc2	$2, $2, 0
	dmfc2	$2, $2, 1
	dmfc2	$2, $2, 2
	dmfc2	$2, $2, 3
	dmfc2	$2, $2, 4
	dmfc2	$2, $2, 5
	dmfc2	$2, $2, 6
	dmfc2	$2, $2, 7
*/

	dmtc2	$2, $0
	dmtc2	$2, $1
	dmtc2	$2, $2
	dmtc2	$2, $3
	dmtc2	$2, $4
	dmtc2	$2, $5
	dmtc2	$2, $6
	dmtc2	$2, $7
	dmtc2	$2, $8
	dmtc2	$2, $9
	dmtc2	$2, $10
	dmtc2	$2, $11
	dmtc2	$2, $12
	dmtc2	$2, $13
	dmtc2	$2, $14
	dmtc2	$2, $15
	dmtc2	$2, $16
	dmtc2	$2, $17
	dmtc2	$2, $18
	dmtc2	$2, $19
	dmtc2	$2, $20
	dmtc2	$2, $21
	dmtc2	$2, $22
	dmtc2	$2, $23
	dmtc2	$2, $24
	dmtc2	$2, $25
	dmtc2	$2, $26
	dmtc2	$2, $27
	dmtc2	$2, $28
	dmtc2	$2, $29
	dmtc2	$2, $30
	dmtc2	$2, $31
/*
	dmtc2	$2, $0, 0
	dmtc2	$2, $0, 1
	dmtc2	$2, $0, 2
	dmtc2	$2, $0, 3
	dmtc2	$2, $0, 4
	dmtc2	$2, $0, 5
	dmtc2	$2, $0, 6
	dmtc2	$2, $0, 7
	dmtc2	$2, $1, 0
	dmtc2	$2, $1, 1
	dmtc2	$2, $1, 2
	dmtc2	$2, $1, 3
	dmtc2	$2, $1, 4
	dmtc2	$2, $1, 5
	dmtc2	$2, $1, 6
	dmtc2	$2, $1, 7
	dmtc2	$2, $2, 0
	dmtc2	$2, $2, 1
	dmtc2	$2, $2, 2
	dmtc2	$2, $2, 3
	dmtc2	$2, $2, 4
	dmtc2	$2, $2, 5
	dmtc2	$2, $2, 6
	dmtc2	$2, $2, 7
*/

	dmult	$2, $3
	dmultu	$2, $3

	dmul	$2, $3, $4
	dmul	$2, $3, 0x12345678

	dmulo	$2, $3, $4
	dmulo	$2, $3, 4

	dmulou	$2, $3, $4
	dmulou	$2, $3, 4

	drem	$3, $4, 0
	drem	$3, $4, 1
	drem	$3, $4, -1
	drem	$3, $4, 2

	drem	$0, $2, $3
	drem	$0, $30, $31
	drem	$0, $3
	drem	$0, $31

	drem	$3, $4, 0
	drem	$3, $4, 1
	drem	$3, $4, -1
	drem	$3, $4, 2

	dremu	$0, $2, $3
	dremu	$0, $30, $31
	dremu	$0, $3
	dremu	$0, $31

	dremu	$3, $4, 0
	dremu	$3, $4, 1
	dremu	$3, $4, -1
	dremu	$3, $4, 2

	drol	$2, $3, $4
	drol	$2, $2, $4
	drol	$2, $3, 4

	dror	$2, $3, $4
	dror	$2, $3, 4
	dror	$2, $3, 36

	drorv	$2, $3, $4
	dror32	$2, $3, 4

	drotl	$2, $3, $4
	drotl	$2, $2, $4
	drotl	$2, $3, 4

	drotr	$2, $3, $4
	drotr	$2, $3, 4
	drotr	$2, $3, 36

	drotrv	$2, $3, $4
	drotr32	$2, $3, 4

	dsbh	$2, $3
	dsbh	$2, $2
	dsbh	$2

	dshd	$2, $3
	dshd	$2, $2
	dshd	$2

	dsllv	$2, $3, $4
	dsll32	$2, $3, 31
	dsll	$2, $3, $4
	dsll	$2, $3, 63
	dsll	$2, $3, 31

	dsrav	$2, $3, $4
	dsra32	$2, $3, 4
	dsra	$2, $3, $4
	dsra	$2, $3, 36
	dsra	$2, $3, 4

	dsrlv	$2, $3, $4
	dsrl32	$2, $3, 31
	dsrl	$2, $3, $4
	dsrl	$2, $3, 36
	dsrl	$2, $3, 4

	dsub	$2, $3, $4
	dsub	$29, $30, $31
	dsub	$2, $2, $3
	dsub	$2, $3

	dsubu	$2, $3, $4
	dsubu	$29, $30, $31
	dsubu	$2, $2, $3
	dsubu	$2, $3

	dsubu	$2, $3, 0x1234
	dsubu	$2, $3, 0x12345678

	dsub	$2, $3, 0
	dsub	$2, $3, 1
	dsub	$2, $3, 512
	dsub	$2, $3, -511
	dsub	$2, $3, -32768
	dsub	$2, $3, 32767
	dsub	$2, $3, 65535
	dsub	$2, $3, 0x12345678
	dsub	$2, $3, 0x8888111112345678

	.set	push
	.set	noreorder
	.set	nomacro
	ld	$2, 0
	ld	$2, 4
	ld	$2, ($0)
	ld	$2, 0($0)
	ld	$2, 4($0)
	ld	$2, 4($3)
	ld	$2, -32768($3)
	ld	$2, 32767($3)
	.set	pop

	ldl	$2, 0
	ldl	$2, 4
	ldl	$2, ($0)
	ldl	$2, 0($0)
	ldl	$2, 4($0)
	ldl	$2, 4($3)
	ldl	$2, -512($3)
	ldl	$2, 511($3)
	ldl	$2, -32768($3)
	ldl	$2, 0x12345678($3)

	ldr	$2, 0
	ldr	$2, 4
	ldr	$2, ($0)
	ldr	$2, 0($0)
	ldr	$2, 4($0)
	ldr	$2, 4($3)
	ldr	$2, -512($3)
	ldr	$2, 511($3)
	ldr	$2, -32768($3)
	ldr	$2, 0x12345678($3)

	lld	$2, 0
	lld	$2, 4
	lld	$2, ($0)
	lld	$2, 0($0)
	lld	$2, 4($0)
	lld	$2, 4($3)
	lld	$2, -512($3)
	lld	$2, 511($3)
	lld	$2, -32768($3)
	lld	$2, 0x12345678($3)

	lwu	$2, 0
	lwu	$2, 4
	lwu	$2, ($0)
	lwu	$2, 0($0)
	lwu	$2, 4($0)
	lwu	$2, 4($3)
	lwu	$2, -512($3)
	lwu	$2, 511($3)
	lwu	$2, -32768($3)
	lwu	$2, 0x12345678($3)

	scd	$2, 0
	scd	$2, 4
	scd	$2, ($0)
	scd	$2, 0($0)
	scd	$2, 4($0)
	scd	$2, 4($3)
	scd	$2, -512($3)
	scd	$2, 511($3)
	scd	$2, -32768($3)
	scd	$2, 0x12345678($3)

	.set	push
	.set	noreorder
	.set	nomacro
	sd	$2, 0
	sd	$2, 4
	sd	$2, ($0)
	sd	$2, 0($0)
	sd	$2, 4($0)
	sd	$2, 4($3)
	sd	$2, -32768($3)
	sd	$2, 32767($3)
	.set	pop

	sdl	$2, 0
	sdl	$2, 4
	sdl	$2, ($0)
	sdl	$2, 0($0)
	sdl	$2, 4($0)
	sdl	$2, 4($3)
	sdl	$2, -32768($3)
	sdl	$2, 32767($3)
	sdl	$2, 0x12345678($3)

	sdr	$2, 0
	sdr	$2, 4
	sdr	$2, ($0)
	sdr	$2, 0($0)
	sdr	$2, 4($0)
	sdr	$2, 4($3)
	sdr	$2, -32768($3)
	sdr	$2, 32767($3)
	sdr	$2, 0x12345678($3)

	ldm	$s0, 0
	ldm	$s0, 4
	ldm	$s0, ($5)
	ldm	$s0, 2047($5)
	ldm	$s0-$s1, 2047($5)
	ldm	$s0-$s2, 2047($5)
	ldm	$s0-$s3, 2047($5)
	ldm	$s0-$s4, 2047($5)
	ldm	$s0-$s5, 2047($5)
	ldm	$s0-$s6, 2047($5)
	ldm	$s0-$s7, 2047($5)
	ldm	$s0-$s8, 2047($5)
	ldm	$ra, 2047($5)
	ldm	$s0,$ra, ($5)
	ldm	$s0-$s1,$ra, ($5)
	ldm	$s0-$s2,$ra, ($5)
	ldm	$s0-$s3,$ra, ($5)
	ldm	$s0-$s4,$ra, ($5)
	ldm	$s0-$s5,$ra, ($5)
	ldm	$s0-$s6,$ra, ($5)
	ldm	$s0-$s7,$ra, ($5)
	ldm	$s0-$s8,$ra, ($5)
	ldm	$s0, -32768($0)
	ldm	$s0, 32767($0)
	ldm	$s0, 0($0)
	ldm	$s0, 65535($0)
	ldm	$s0, -32768($29)
	ldm	$s0, 32767($29)
	ldm	$s0, 0($29)
	ldm	$s0, 65535($29)
	ldm	$s0, 0x12345678($29)

	ldp	$2, 0
	ldp	$2, 4
	ldp	$2, ($29)
	ldp	$2, 0($29)
	ldp	$2, -2048($3)
	ldp	$2, 2047($3)
	ldp	$2, -32768($3)
	ldp	$2, 32767($3)
	ldp	$2, 0($3)
	ldp	$2, 65535($3)
	ldp	$2, -32768($0)
	ldp	$2, 32767($0)
	ldp	$2, 65535($0)
	ldp	$2, 0x12345678($0)

	sdm	$s0, 0
	sdm	$s0, 4
	sdm	$s0, ($5)
	sdm	$s0, 2047($5)
	sdm	$s0-$s1, 2047($5)
	sdm	$s0-$s2, 2047($5)
	sdm	$s0-$s3, 2047($5)
	sdm	$s0-$s4, 2047($5)
	sdm	$s0-$s5, 2047($5)
	sdm	$s0-$s6, 2047($5)
	sdm	$s0-$s7, 2047($5)
	sdm	$s0-$s8, 2047($5)
	sdm	$ra, 2047($5)
	sdm	$s0,$ra, ($5)
	sdm	$s0-$s1,$ra, ($5)
	sdm	$s0-$s2,$ra, ($5)
	sdm	$s0-$s3,$ra, ($5)
	sdm	$s0-$s4,$ra, ($5)
	sdm	$s0-$s5,$ra, ($5)
	sdm	$s0-$s6,$ra, ($5)
	sdm	$s0-$s7,$ra, ($5)
	sdm	$s0-$s8,$ra, ($5)
	sdm	$s0, -32768($0)
	sdm	$s0, 32767($0)
	sdm	$s0, 0($0)
	sdm	$s0, 65535($0)
	sdm	$s0, -32768($29)
	sdm	$s0, 32767($29)
	sdm	$s0, 0($29)
	sdm	$s0, 65535($29)
	sdm	$s0, 0x12345678($29)

	sdp	$2, 0
	sdp	$2, 4
	sdp	$2, ($29)
	sdp	$2, 0($29)
	sdp	$2, -2048($3)
	sdp	$2, 2047($3)
	sdp	$2, -32768($3)
	sdp	$2, 32767($3)
	sdp	$2, 0($3)
	sdp	$2, 65535($3)
	sdp	$2, -32768($0)
	sdp	$2, 32767($0)
	sdp	$2, 65535($0)
	sdp	$2, 0x12345678($0)

	uld	$3, 0
	uld	$3, ($0)
	uld	$3, 4
	uld	$3, 4($0)
	uld	$3, 2047
	uld	$3, -2048
	uld	$3, 2048
	uld	$3, -2049
	uld	$3, 32753($0)
	uld	$3, -32768($0)
	uld	$3, 65535($0)
	uld	$3, 0xffff0000($0)
	uld	$3, 0xffff8000($0)
	uld	$3, 0xffff0001($0)
	uld	$3, 0xffff8001($0)
	uld	$3, 0xf0000000($0)
	uld	$3, 0xffffffff($0)
	uld	$3, 0x12345678($0)
	uld	$3, 0($4)
	uld	$3, 4($4)
	uld	$3, 2047($4)
	uld	$3, -2048($4)
	uld	$3, 2048($4)
	uld	$3, -2049($4)
	uld	$3, 32753($4)
	uld	$3, -32768($4)
	uld	$3, 65535($4)
	uld	$3, 0xffff0000($4)
	uld	$3, 0xffff8000($4)
	uld	$3, 0xffff0001($4)
	uld	$3, 0xffff8001($4)
	uld	$3, 0xf0000000($4)
	uld	$3, 0xffffffff($4)
	uld	$3, 0x12345678($4)

	usd	$3, 0
	usd	$3, ($0)
	usd	$3, 4
	usd	$3, 4($0)
	usd	$3, 2047
	usd	$3, -2048
	usd	$3, 2048
	usd	$3, -2049
	usd	$3, 32753($0)
	usd	$3, -32768($0)
	usd	$3, 65535($0)
	usd	$3, 0xffff0000($0)
	usd	$3, 0xffff8000($0)
	usd	$3, 0xffff0001($0)
	usd	$3, 0xffff8001($0)
	usd	$3, 0xf0000000($0)
	usd	$3, 0xffffffff($0)
	usd	$3, 0x12345678($0)
	usd	$3, 0($4)
	usd	$3, 4($4)
	usd	$3, 2047($4)
	usd	$3, -2048($4)
	usd	$3, 2048($4)
	usd	$3, -2049($4)
	usd	$3, 32753($4)
	usd	$3, -32768($4)
	usd	$3, 65535($4)
	usd	$3, 0xffff0000($4)
	usd	$3, 0xffff8000($4)
	usd	$3, 0xffff0001($4)
	usd	$3, 0xffff8001($4)
	usd	$3, 0xf0000000($4)
	usd	$3, 0xffffffff($4)
	usd	$3, 0x12345678($4)

	ldl	$16, %lo(test)($3)
	ldr	$16, %lo(test)($3)
	lld	$16, %lo(test)($3)
	lwu	$16, %lo(test)($3)
	scd	$16, %lo(test)($3)
	sdl	$16, %lo(test)($3)
	sdr	$16, %lo(test)($3)
	ldm	$16, %lo(test)($3)
	ldp	$16, %lo(test)($3)
	sdm	$16, %lo(test)($3)
	sdp	$16, %lo(test)($3)
	ldc2	$16, %lo(test)($3)
	sdc2	$16, %lo(test)($3)

	.end	test_mips64


	.align	2
	.space	8
