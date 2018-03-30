	.text
	.align	3
	.ent	test
	.globl	test
test:
	pref	0, 0
	pref	0, 2047
	pref	0, -2048
	pref	0, 2048
	pref	0, -2049
	pref	0, ($zero)
	pref	0, 0($zero)
	pref	1, 0($zero)
	pref	2, 0($zero)
	pref	3, 0($zero)
	pref	4, 0($zero)
	pref	5, 0($zero)
	pref	6, 0($zero)
	pref	7, 0($zero)
	pref	7, 511($zero)
	pref	7, -512($zero)
	pref	3, 32767($zero)
	pref	3, -32768($zero)

	pref	3, 32767($t4)
	pref	3, -32768($t4)

	nop
	.ifndef	insn32
	nop16
	.endif
	nop32
	ehb
	pause

	li	$s2, -1
	li	$s3, -1
	li	$a0, -1
	li	$a1, -1
	li	$a2, -1
	li	$a3, -1
	li	$s0, -1
	li	$s1, -1
	li	$s1, 0
	li	$s1, 125
	li	$s1, 126
	li	$s1, 127
	li	$t0, 0
	li	$t9, 0

	li32	$t4, 0
	li32	$t4, 1
	li	$t4, 32767
	li	$t4, -32768
	li	$t4, 65535

	li	$t4, 65536
	li	$t4, 0xffff8000
	li	$t4, 0xffff8001
	li	$t4, 0xffffffff
	li	$t4, 0x12345678
	li	$t5, 0xffffffff
	li	$a0, 0xffffffff

	move	$zero, $s6
	move	$t4, $s6
	move	$t5, $s6
	move	$a0, $s6
	move	$a1, $s6
	move	$a2, $s6
	move	$a3, $s6
	move	$a4, $s6
	move	$a5, $s6
	move	$a6, $s6
	move	$fp, $s6
	move	$ra, $s6
	move	$zero, $zero
	move	$zero, $t4
	move	$zero, $t5
	move	$zero, $a0
	move	$zero, $a1
	move	$zero, $a2
	move	$zero, $a3
	move	$zero, $a4
	move	$zero, $a5
	move	$zero, $a6
	move	$zero, $fp
	move	$zero, $ra

	move	$s6, $t4
	.ifndef	insn32
	move16	$t4, $s6
	move16	$s6, $t4
	.endif

	move32	$t4, $s6
	move32	$s6, $t4

	b	test
	.ifndef	insn32
	b16	test
	.endif
	b32	test
	b	1f
	.ifndef	insn32
	b16	1f
	.endif
	b32	1f
1:
	b	1b
	.ifndef	insn32
	b16	1b
	.endif
	b32	1b

	abs	$t4, $t5
	abs	$t4, $a0
	abs	$t4, $t4
	abs	$t4

	add	$t4, $t5, $a0
	add	$sp, $fp, $ra
	add	$t4, $t4, $a0
	add	$t4, $a0
	
	add	$t4, $t4, 0
	add	$t4, $t4, 1
	add	$t4, $t4, 32767
	add	$t4, $t4, -32768
	add	$t4, $t4, 65535
	
	addi	$t5, $a0, -32768
	addi	$t5, $a0, 0
	addi	$t5, $a0, 32767
	addi	$t5, $a0, 65535
	addi	$t5, $t5, 65535
	addi	$t5, 65535
	
	addiu	$zero, -8
	addiu	$t4, -8
	addiu	$t5, -8
	addiu	$a0, -8
	addiu	$a1, -8
	addiu	$a2, -8
	addiu	$a3, -8
	addiu	$a4, -8
	addiu	$a5, -8
	addiu	$a6, -8
	addiu	$fp, -8
	addiu	$ra, -8
	addiu	$ra, -7
	addiu	$ra, 0
	addiu	$ra, 1
	addiu	$ra, 6
	addiu	$ra, 7
	addiu	$ra, 8
	addiu	$sp, -258 << 2
	addiu	$sp, -257 << 2
	addiu	$sp, -256 << 2
	addiu	$sp, 255 << 2
	addiu	$sp, 256 << 2
	addiu	$sp, 257 << 2
	addiu	$sp, $sp, 257 << 2
	addiu	$sp, $sp, 258 << 2

	addiu	$t4, $t4, -1
	addiu	$t4, $t5, -1
	addiu	$t4, $a0, -1
	addiu	$t4, $a1, -1
	addiu	$t4, $a2, -1
	addiu	$t4, $a3, -1
	addiu	$t4, $s0, -1
	addiu	$t4, $s1, -1
	addiu	$t4, $s1, 1
	addiu	$s2, $s1, 4
	addiu	$s2, $s1, 8
	addiu	$s2, $s1, 12
	addiu	$s2, $s1, 16
	addiu	$s2, $s1, 20
	addiu	$s2, $s1, 24
	addiu	$s3, $s1, 24
	addiu	$a0, $s1, 24
	addiu	$a1, $s1, 24
	addiu	$a2, $s1, 24
	addiu	$a3, $s1, 24
	addiu	$s0, $s1, 24
	addiu	$s1, $s1, 24

	addiu	$s2, $sp, 0 << 2
	addiu	$s2, $sp, 1 << 2
	addiu	$s2, $sp, 62 << 2
	addiu	$s2, $sp, 63 << 2
	addiu	$t4, $sp, 64 << 2
	addiu	$s2, $sp, 63 << 2
	addiu	$s3, $sp, 63 << 2
	addiu	$a0, $sp, 63 << 2
	addiu	$a1, $sp, 63 << 2
	addiu	$a2, $sp, 63 << 2
	addiu	$a3, $sp, 63 << 2
	addiu	$s0, $sp, 63 << 2
	addiu	$s1, $sp, 63 << 2

	addiu	$t5, $a0, -4095
	addiu	$s3, $a0, 0
	addiu	$t5, $a0, 8191

	addiu	$t5, $a0, 16383 
	addiu	$t5, $t5, 16383
	addiu	$t5, 16383

	addu	$t4, $s6, $zero
	addu	$s6, $t4, $zero
	addu	$t4, $zero, $s6
	addu	$s6, $zero, $t4

	addu	$s2, $s3, $s2
	addu	$s2, $s3, $s3
	addu	$s2, $s3, $a0
	addu	$s2, $s3, $a1
	addu	$s2, $s3, $a2
	addu	$s2, $s3, $a3
	addu	$s2, $s3, $s0
	addu	$s2, $s3, $s1

	addu	$s2, $s2, $s1
	addu	$s2, $s3, $s1
	addu	$s2, $a0, $s1
	addu	$s2, $a1, $s1
	addu	$s2, $a2, $s1
	addu	$s2, $a3, $s1
	addu	$s2, $s0, $s1
	addu	$s2, $s1, $s1

	addu	$s2, $s2, $s1
	addu	$s3, $s2, $s1
	addu	$a0, $s2, $s1
	addu	$a1, $s2, $s1
	addu	$a2, $s2, $s1
	addu	$a3, $s2, $s1
	addu	$s0, $s2, $s1
	addu	$s1, $s2, $s1

	addu	$a3, $a3, $s2
	addu	$a3, $s2
	addu	$a3, $s2, $a3

	addu	$sp, $fp, $ra
	addu	$t4, $t4, 0
	addu	$t4, $t4, 1
	addu	$t4, $t4, 32767
	addu	$t4, $t4, -32768
	addu	$t4, $t4, 65535

	and	$s2, $s2
	and	$s2, $s3
	and	$s2, $a0
	and	$s2, $a1
	and	$s2, $a2
	and	$s2, $a3
	and	$s2, $s0
	and	$s2, $s1
	and	$s3, $s2
	and	$a0, $s2
	and	$a1, $s2
	and	$a2, $s2
	and	$a3, $s2
	and	$s0, $s2
	and	$s1, $s2

	and	$s2, $s3
	and	$s2, $s2, $s3
	and	$s2, $s3, $s2
	.ifndef	insn32
	and16	$s2, $s2, $s3
	.endif
	and32	$t4, $t4, $t5

	andi	$s2,$s2,1
	andi	$s2,$s2,2
	andi	$s2,$s2,3
	andi	$s2,$s2,4
	andi	$s2,$s2,7
	andi	$s2,$s2,8
	andi	$s2,$s2,15
	andi	$t4,$t4,16
	andi	$t4,$t4,31
	andi	$t4,$t4,32
	andi	$t4,$t4,63
	andi	$t4,$t4,64
	andi	$t4,$t4,128
	andi	$s2,$s2,255
	andi	$t4,$t4,4095
	andi	$s2,$s2,65535
	andi	$s2,$s3,65535
	andi	$s2,$a0,65535
	andi	$s2,$a1,65535
	andi	$s2,$a2,65535
	andi	$s2,$a3,65535
	andi	$s2,$s0,65535
	andi	$s2,$s1,65535
	andi	$s3,$s1,65535
	andi	$a0,$s1,65535
	andi	$a1,$s1,65535
	andi	$a2,$s1,65535
	andi	$a3,$s1,65535
	andi	$s0,$s1,65535
	andi	$s1,$s1,65535

	andi	$a3,$a3,65535

	andi	$a3,65535
	.ifndef	insn32
	andi16	$a3,65535
	.endif

	and32	$t4, $t5, $a0
	and32	$t4, $t4, $a0
	and32	$t4, $a0
	and	$t4, $t5, 0
	and	$t4, $t5, 4095
	and	$t4, $t5, 4096
	and	$t4, $t5, 0xffff0001

test2:
	beqz	$s2, test2
	beqz	$s3, test2
	beqz	$a0, test2
	beqz	$a1, test2
	beqz	$a2, test2
	beqz	$a3, test2
	beqz	$s0, test2
	beqz	$s1, test2
	beq	$s2, $zero, test2
	beq	$s3, $zero, test2
	beq	$a0, $zero, test2
	beq	$a1, $zero, test2
	beq	$a2, $zero, test2
	beq	$a3, $zero, test2
	beq	$s0, $zero, test2
	beq	$s1, $zero, test2
	beq	$zero, $s2, test2
	beq	$zero, $s3, test2
	beq	$zero, $a0, test2
	beq	$zero, $a1, test2
	beq	$zero, $a2, test2
	beq	$zero, $a3, test2
	beq	$zero, $s0, test2
	beq	$zero, $s1, test2

	.ifndef	insn32
	beqz16	$s0, test2
	.endif
	beqz32	$s0, test2
	beqz	$s1, test2
	beqz32	$s1, test2

	beqzc	$s1, test2

	beq	$s0, 0, test2
	beq	$s0, 10, test2
	beq	$s0, 32767, test2
	beq	$s0, 65536, test2

	bnez	$s2, test3
	bnez	$s3, test3
	bnez	$a0, test3
	bnez	$a1, test3
	bnez	$a2, test3
	bnez	$a3, test3
	bnez	$s0, test3
	bnez	$s1, test3
	bne	$s2, $zero, test3
	bne	$s3, $zero, test3
	bne	$a0, $zero, test3
	bne	$a1, $zero, test3
	bne	$a2, $zero, test3
	bne	$a3, $zero, test3
	bne	$s0, $zero, test3
	bne	$s1, $zero, test3
	bne	$zero, $s2, test3
	bne	$zero, $s3, test3
	bne	$zero, $a0, test3
	bne	$zero, $a1, test3
	bne	$zero, $a2, test3
	bne	$zero, $a3, test3
	bne	$zero, $s0, test3
	bne	$zero, $s1, test3

	.ifndef	insn32
	bnez16	$s0, test3
	.endif
	bnez32	$s0, test3
	bnez	$s1, test2
	bnez32	$s1, test2
test3:
	bnezc	$s1, test2

	break
	break	0
	break	1
	break	2
	break	3
	break	4
	break	5
	break	6
	break	7
	break	8
	break	9
	break	10
	break	11
	break	12
	break	13
	break	14
	break	15
	break	63
	break	64
	break	1023
	break32
	
	break32	0
	break32	1
	break32	2
	break32	15
	break32	63
	break32	64
	break32	1023
	cache	0, 0
	cache	0, -2048
	cache	0, 2047
	cache	0, -2049
	cache	0, 2048
	cache	0, 0($t4)
	cache	0, -2048($t4)
	cache	0, 2047($t4)
	cache	0, -2049($t4)
	cache	0, 2048($t4)

	cache	0, ($zero)
	cache	0, 0($zero)
	cache	1, 0($zero)
	cache	2, 0($zero)
	cache	3, 0($zero)
	cache	4, 0($zero)
	cache	5, 0($zero)
	cache	6, 0($zero)
	cache	31, 0($zero)
	cache	31, 2047($zero)
	cache	31, -2048($zero)
	cache	0, 2047($zero)
	cache	0, -2048($zero)

	cache	31, 65536($t5)
	cache	31, 2048($t5)
	cache	31, -2049($t5)
	cache	31, 65537($t5)
	cache	31, 0xffffffff($t5)
	cache	31, 0xffff0000($t5)
	cache	31, 0xffff0001($t5)
	cache	31, 0xffff($t5)

	cache	31, 65536($zero)
	cache	31, 2048($zero)
	cache	31, -2049($zero)
	cache	31, 65537($zero)
	cache	31, 0xffffffff($zero)
	cache	31, 0xffff0000($zero)
	cache	31, 0xffff0001($zero)
	cache	31, 0xffff($zero)


	clo	$t4, $t5
	clo	$t5, $t4
	clz	$t4, $t5
	clz	$t5, $t4

	deret
	di

	di	$zero
	di	$t4
	di	$t5
	di	$fp
	di	$ra

	div	$zero, $t4, $t5
	div	$zero, $fp, $ra
	div	$zero, $t5
	div	$zero, $ra

	div	$t4, $t5, $zero
	div	$t4, $t5, $a0

	div	$t5, $a0, 0
	div	$t5, $a0, 1
	div	$t5, $a0, -1
	div	$t5, $a0, 2

	divu	$zero, $t4, $t5
	divu	$zero, $fp, $ra
	divu	$zero, $t5
	divu	$zero, $ra

	divu	$t4, $t5, $zero
	divu	$t4, $t5, $a0

	divu	$t5, $a0, 0
	divu	$t5, $a0, 1
	divu	$t5, $a0, -1
	divu	$t5, $a0, 2

	ei
	ei	$zero
	ei	$t4
	ei	$t5
	ei	$fp
	ei	$ra

	eret

	ext	$t4, $t5, 5, 15
	ext	$t4, $t5, 0, 32
	ext	$t4, $t5, 31, 1
	ext	$ra, $fp, 31, 1

	ins	$t4, $t5, 5, 15
	ins	$t4, $t5, 0, 32
	ins	$t4, $t5, 31, 1
	ins	$ra, $fp, 31, 1

	jr	$zero
	jr	$t4
	jr	$t5
	jr	$a0
	jr	$a1
	jr	$a2
	jr	$a3
	jr	$a4
	jr	$fp
	jr	$ra

	jr32	$zero
	jr32	$t4
	jr32	$t5
	jr32	$a0
	jr32	$a1
	jr32	$a2
	jr32	$a3
	jr32	$a4
	jr32	$fp
	jr32	$ra

	jrc	$zero
	jrc	$t4
	jrc	$t5
	jrc	$a0
	jrc	$a1
	jrc	$a2
	jrc	$a3
	jrc	$a4
	jrc	$fp
	jrc	$ra

	jr.hb	$zero
	jr.hb	$t4
	jr.hb	$t5
	jr.hb	$a0
	jr.hb	$a1
	jr.hb	$a2
	jr.hb	$a3
	jr.hb	$a4
	jr.hb	$fp
	jr.hb	$ra

	j	$zero
	j	$t4
	j	$t5
	j	$a0
	j	$a1
	j	$a2
	j	$a3
	j	$a4
	j	$fp
	j	$ra

	jalrc	$ra, $zero
	jalrc	$t4
	jalrc	$t5
	jalrc	$a0
	jalrc	$a1
	jalrc	$a2
	jalrc	$a3
	jalrc	$a4
	jalrc	$fp

	jalrc32	$ra, $zero

	jalrc32	$t4
	jalrc32	$t5
	jalrc32	$a0
	jalrc32	$a1
	jalrc32	$a2
	jalrc32	$a3
	jalrc32	$a4
	jalrc32	$fp

	jalrc	$ra, $zero
	jalrc	$ra, $t4
	jalrc	$ra, $t5
	jalrc	$ra, $a0
	jalrc	$ra, $a1
	jalrc	$ra, $a2
	jalrc	$ra, $a3
	jalrc	$ra, $a4
	jalrc	$ra, $fp
	jalrc	$fp, $ra

	jalrc	$t4, $zero
	jalrc	$t5, $t4
	jalrc	$t4, $t5
	jalrc	$t4, $a0
	jalrc	$t4, $a1
	jalrc	$t4, $a2
	jalrc	$t4, $a3
	jalrc	$t4, $a4
	jalrc	$t4, $fp
	jalrc	$t4, $ra

	jalrc.hb	$ra, $zero
	jalrc.hb	$t4
	jalrc.hb	$t5
	jalrc.hb	$a0
	jalrc.hb	$a1
	jalrc.hb	$a2
	jalrc.hb	$a3
	jalrc.hb	$a4
	jalrc.hb	$fp

	jalrc.hb	$ra, $zero
	jalrc.hb	$ra, $t4
	jalrc.hb	$ra, $t5
	jalrc.hb	$ra, $a0
	jalrc.hb	$ra, $a1
	jalrc.hb	$ra, $a2
	jalrc.hb	$ra, $a3
	jalrc.hb	$ra, $a4
	jalrc.hb	$ra, $fp
	jalrc.hb	$fp, $ra

	jalrc.hb	$t4, $zero
	jalrc.hb	$t5, $t4
	jalrc.hb	$t4, $t5
	jalrc.hb	$t4, $a0
	jalrc.hb	$t4, $a1
	jalrc.hb	$t4, $a2
	jalrc.hb	$t4, $a3
	jalrc.hb	$t4, $a4
	jalrc.hb	$t4, $fp
	jalrc.hb	$t4, $ra

	jal	$t4, $t5
	jal	$fp, $ra

	jal	$t5
	jal	$ra

	jal	test
	jal	test2
	la	$t4, test
	lb	$t5, 0
	lb	$t5, 4
	lb	$t5, 0($zero)
	lb	$t5, 4($zero)
	lb	$t5, 32767($zero)
	lb	$t5, -32768($zero)
	lb	$t5, 65535($zero)
	lb	$t5, 0xffff0000($zero)
	lb	$t5, 0xffff8000($zero)
	lb	$t5, 0xffff0001($zero)
	lb	$t5, 0xffff8001($zero)
	lb	$t5, 0xf0000000($zero)
	lb	$t5, 0xffffffff($zero)
	lb	$t5, 0x12345678($zero)
	lb	$s3, ($a0)
	lb	$s3, 0($a0)
	lb	$t5, 4($a0)
	lb	$t5, 32767($a0)
	lb	$t5, -32768($a0)
	lb	$t5, 65535($a0)
	lb	$t5, 0xffff0000($a0)
	lb	$t5, 0xffff8000($a0)
	lb	$t5, 0xffff0001($a0)
	lb	$t5, 0xffff8001($a0)
	lb	$t5, 0xf0000000($a0)
	lb	$t5, 0xffffffff($a0)
	lb	$t5, 0x12345678($a0)

	lbu	$t4, -1($t5)
	lbu	$s2, 0($s3)
	lbu	$s2, ($s3)
	lbu	$s2, 1($s3)
	lbu	$s2, 2($s3)
	lbu	$s2, 3($s3)
	lbu	$t4, 4($t5)
	lbu	$t4, 5($t5)
	lbu	$t4, 6($t5)
	lbu	$t4, 7($t5)
	lbu	$t4, 8($t5)
	lbu	$t4, 9($t5)
	lbu	$t4, 10($t5)
	lbu	$t4, 11($t5)
	lbu	$t4, 12($t5)
	lbu	$t4, 13($t5)
	lbu	$t4, 14($t5)
	lbu	$t4, 14($t4)
	lbu	$t4, 14($a0)
	lbu	$t4, 14($a1)
	lbu	$t4, 14($a2)
	lbu	$t4, 14($a3)
	lbu	$t4, 14($s0)
	lbu	$t4, 14($s1)
	lbu	$t5, 14($s1)
	lbu	$a0, 14($s1)
	lbu	$a1, 14($s1)
	lbu	$a2, 14($s1)
	lbu	$a3, 14($s1)
	lbu	$s0, 14($s1)
	lbu	$s1, 14($s1)

	lbu	$t5, 0
	lbu	$t5, 4
	lbu	$t5, 0($zero)
	lbu	$t5, 4($zero)
	lbu	$t5, 32767($zero)
	lbu	$t5, -32768($zero)
	lbu	$t5, 65535($zero)
	lbu	$t5, 0xffff0000($zero)
	lbu	$t5, 0xffff8000($zero)
	lbu	$t5, 0xffff0001($zero)
	lbu	$t5, 0xffff8001($zero)
	lbu	$t5, 0xf0000000($zero)
	lbu	$t5, 0xffffffff($zero)
	lbu	$t5, 0x12345678($zero)

	lbu	$s3, ($a0)
	lbu	$s3, 0($a0)
	lbu	$t5, 4($a0)
	lbu	$t5, 32767($a0)
	lbu	$t5, -32768($a0)
	lbu	$t5, 65535($a0)
	lbu	$t5, 0xffff0000($a0)
	lbu	$t5, 0xffff8000($a0)
	lbu	$t5, 0xffff0001($a0)
	lbu	$t5, 0xffff8001($a0)
	lbu	$t5, 0xf0000000($a0)
	lbu	$t5, 0xffffffff($a0)
	lbu	$t5, 0x12345678($a0)

	lh	$t5, 0
	lh	$t5, 4
	lh	$t5, 0($zero)
	lh	$t5, 4($zero)
	lh	$t5, 32767($zero)
	lh	$t5, -32768($zero)
	lh	$t5, 65535($zero)
	lh	$t5, 0xffff0000($zero)
	lh	$t5, 0xffff8000($zero)
	lh	$t5, 0xffff0001($zero)
	lh	$t5, 0xffff8001($zero)
	lh	$t5, 0xf0000000($zero)
	lh	$t5, 0xffffffff($zero)
	lh	$t5, 0x12345678($zero)
	lh	$s3, ($a0)
	lh	$s3, 0($a0)
	lh	$s3, 4($a0)
	lh	$t5, 32767($a0)
	lh	$t5, -32768($a0)
	lh	$t5, 65535($a0)
	lh	$t5, 0xffff0000($a0)
	lh	$t5, 0xffff8000($a0)
	lh	$t5, 0xffff0001($a0)
	lh	$t5, 0xffff8001($a0)
	lh	$t5, 0xf0000000($a0)
	lh	$t5, 0xffffffff($a0)
	lh	$t5, 0x12345678($a0)

	lhu	$s2, ($s3)
	lhu	$s2, 0<<1($s3)
	lhu	$s2, 1<<1($s3)
	lhu	$s2, 2<<1($s3)
	lhu	$s2, 3<<1($s3)
	lhu	$t4, 4<<1($t5)
	lhu	$t4, 5<<1($t5)
	lhu	$t4, 6<<1($t5)
	lhu	$t4, 7<<1($t5)
	lhu	$t4, 8<<1($t5)
	lhu	$t4, 9<<1($t5)
	lhu	$t4, 10<<1($t5)
	lhu	$t4, 11<<1($t5)
	lhu	$t4, 12<<1($t5)
	lhu	$t4, 13<<1($t5)
	lhu	$t4, 14<<1($t5)
	lhu	$t4, 15<<1($t5)
	lhu	$t4, 15<<1($a0)
	lhu	$t4, 15<<1($a1)
	lhu	$t4, 15<<1($a2)
	lhu	$t4, 15<<1($a3)
	lhu	$t4, 15<<1($t4)
	lhu	$t4, 15<<1($s0)
	lhu	$t4, 15<<1($s1)
	lhu	$t5, 15<<1($s1)
	lhu	$a0, 15<<1($s1)
	lhu	$a1, 15<<1($s1)
	lhu	$a2, 15<<1($s1)
	lhu	$a3, 15<<1($s1)
	lhu	$s0, 15<<1($s1)
	lhu	$s1, 15<<1($s1)

	lhu	$t5, 0
	lhu	$t5, 4
	lhu	$t5, 0($zero)
	lhu	$t5, 4($zero)
	lhu	$t5, 32767($zero)
	lhu	$t5, -32768($zero)
	lhu	$t5, 65535($zero)
	lhu	$t5, 0xffff0000($zero)
	lhu	$t5, 0xffff8000($zero)
	lhu	$t5, 0xffff0001($zero)
	lhu	$t5, 0xffff8001($zero)
	lhu	$t5, 0xf0000000($zero)
	lhu	$t5, 0xffffffff($zero)
	lhu	$t5, 0x12345678($zero)
	lhu	$s3, ($a0)
	lhu	$s3, 0($a0)
	lhu	$s3, 4($a0)
	lhu	$t5, 32767($a0)
	lhu	$t5, -32768($a0)
	lhu	$t5, 65535($a0)
	lhu	$t5, 0xffff0000($a0)
	lhu	$t5, 0xffff8000($a0)
	lhu	$t5, 0xffff0001($a0)
	lhu	$t5, 0xffff8001($a0)
	lhu	$t5, 0xf0000000($a0)
	lhu	$t5, 0xffffffff($a0)
	lhu	$t5, 0x12345678($a0)

	ll	$t5, 0
	ll	$t5, 0($zero)
	ll	$t5, 4
	ll	$t5, 4($zero)
	ll	$t5, 32767($zero)
	ll	$t5, -32768($zero)
	ll	$t5, 65535($zero)
	ll	$t5, 0xffff0000($zero)
	ll	$t5, 0xffff8000($zero)
	ll	$t5, 0xffff0001($zero)
	ll	$t5, 0xffff8001($zero)
	ll	$t5, 0xf0000000($zero)
	ll	$t5, 0xffffffff($zero)
	ll	$t5, 0x12345678($zero)
	ll	$t5, ($a0)
	ll	$t5, 0($a0)
	ll	$t5, 4($a0)
	ll	$t5, 32767($a0)
	ll	$t5, -32768($a0)
	ll	$t5, 65535($a0)
	ll	$t5, 0xffff0000($a0)
	ll	$t5, 0xffff8000($a0)
	ll	$t5, 0xffff0001($a0)
	ll	$t5, 0xffff8001($a0)
	ll	$t5, 0xf0000000($a0)
	ll	$t5, 0xffffffff($a0)
	ll	$t5, 0x12345678($a0)

	lui	$t5, 0
	lui	$t5, 32767
	lui	$t5, 65535

	lw	$s2, ($a0)
	lw	$s2, 0($a0)
	lw	$s2, 1<<2($a0)
	lw	$s2, 2<<2($a0)
	lw	$s2, 3<<2($a0)
	lw	$s2, 4<<2($a0)
	lw	$s2, 5<<2($a0)
	lw	$s2, 6<<2($a0)
	lw	$s2, 7<<2($a0)
	lw	$s2, 8<<2($a0)
	lw	$s2, 9<<2($a0)
	lw	$s2, 10<<2($a0)
	lw	$s2, 11<<2($a0)
	lw	$s2, 12<<2($a0)
	lw	$s2, 13<<2($a0)
	lw	$s2, 14<<2($a0)
	lw	$s2, 15<<2($a0)
	lw	$s2, 15<<2($a1)
	lw	$s2, 15<<2($a2)
	lw	$s2, 15<<2($a3)
	lw	$s2, 15<<2($s2)
	lw	$s2, 15<<2($s3)
	lw	$s2, 15<<2($s0)
	lw	$s2, 15<<2($s1)
	lw	$s3, 15<<2($s1)
	lw	$a0, 15<<2($s1)
	lw	$a1, 15<<2($s1)
	lw	$a2, 15<<2($s1)
	lw	$a3, 15<<2($s1)
	lw	$s0, 15<<2($s1)
	lw	$s1, 15<<2($s1)

	lw	$a0, ($sp)
	lw	$a0, 0($sp)
	lw	$a0, 1<<2($sp)
	lw	$a0, 2<<2($sp)
	lw	$a0, 3<<2($sp)
	lw	$a0, 4<<2($sp)
	lw	$a0, 5<<2($sp)
	lw	$a0, 31<<2($sp)
	lw	$t4, 31<<2($sp)
	lw	$t4, 31<<2($sp)
	lw	$t5, 31<<2($sp)
	lw	$a0, 31<<2($sp)
	lw	$a1, 31<<2($sp)
	lw	$a2, 31<<2($sp)
	lw	$a3, 31<<2($sp)
	lw	$a4, 31<<2($sp)
	lw	$a5, 31<<2($sp)
	lw	$a6, 31<<2($sp)
	lw	$fp, 31<<2($sp)
	lw	$ra, 31<<2($sp)

	lw	$a0, 126<<2($sp)
	lw	$a0, 127<<2($sp)
	lw	$s0, 127<<2($sp)
	lw	$s1, 127<<2($sp)
	lw	$s2, 127<<2($sp)
	lw	$s3, 127<<2($sp)
	lw	$s4, 127<<2($sp)
	lw	$s5, 127<<2($sp)
	lw	$ra, 127<<2($sp)

	lw	$t5, 0
	lw	$t5, 4
	lw	$t5, ($zero)
	lw	$t5, 0($zero)
	lw	$t5, 0($zero)
	lw	$t5, 4($zero)
	lw	$t5, 32767($zero)
	lw	$t5, -32768($zero)
	lw	$t5, 65535($zero)
	lw	$t5, 0xffff0000($zero)
	lw	$t5, 0xffff8000($zero)
	lw	$t5, 0xffff0001($zero)
	lw	$t5, 0xffff8001($zero)
	lw	$t5, 0xf0000000($zero)
	lw	$t5, 0xffffffff($zero)
	lw	$t5, 0x12345678($zero)
	lw	$s3, ($a0)
	lw	$s3, 0($a0)
	lw	$s3, 4($a0)
	lw	$t5, 32767($a0)
	lw	$t5, -32768($a0)
	lw	$t5, 65535($a0)
	lw	$t5, 0xffff0000($a0)
	lw	$t5, 0xffff8000($a0)
	lw	$t5, 0xffff0001($a0)
	lw	$t5, 0xffff8001($a0)
	lw	$t5, 0xf0000000($a0)
	lw	$t5, 0xffffffff($a0)
	lw	$t5, 0x12345678($a0)
	.set push
	lwxs	$s3, $a0($a1)
	.set pop

	mfc0	$t4, $0
	mfc0	$t4, $1
	mfc0	$t4, $2, 1
	mfc0	$t4, $2, 2
	mtc0	$t4, $3
	mtc0	$t4, $4
	mtc0	$t4, $5, 6
	mtc0	$t4, $5, 7

	movn	$t4, $t5
	movn	$t4, $t4, $t5
	movn	$t4, $t5, $a0

	movz	$t4, $t5
	movz	$t4, $t4, $t5
	movz	$t4, $t5, $a0

	mul	$t4, $t5, $a0
	mul	$sp, $fp, $ra
	mul	$t4, $t4, $a0
	mul	$t4, $a0
	mul	$t4, $t4, 0
	mul	$t4, $t4, 1
	mul	$t4, $t4, 32767
	mul	$t4, $t4, -32768
	mul	$t4, $t4, 65535

	neg	$t4, $t5
	neg	$t4, $t4
	neg	$t4
	negu	$t4, $t5
	negu	$t4, $t4
	negu	$t4
	negu32	$t4, $t5
	negu32	$t4, $t4
	negu32	$t4

	not	$s2, $s2
	not	$s2, $s2
	not	$s2, $s3
	not	$s2, $a0
	not	$s2, $a1
	not	$s2, $a2
	not	$s2, $a3
	not	$s2, $s0
	not	$s2, $s1
	not	$s3, $s1
	not	$a0, $s1
	not	$a1, $s1
	not	$a2, $s1
	not	$a3, $s1
	not	$s0, $s1
	not	$s1, $s1

	nor	$t4, $a3, $zero
	nor	$t4, $zero, $a3

	nor32	$t4, $t5, $a0
	nor32	$sp, $fp, $ra
	nor32	$t4, $t4, $a0
	nor32	$t4, $a0

	nor	$t4, $t5, 32768
	nor	$t4, $t5, 65535
	nor	$t4, $t5, 65536
	nor	$t4, $t5, -32768
	nor	$t4, $t5, -32769

	or	$t4, $s6, $zero
	or	$s6, $t4, $zero
	or	$t4, $zero, $s6
	or	$s6, $zero, $t4

	or	$s2, $s2
	or	$s2, $s3
	or	$s2, $a0
	or	$s2, $a1
	or	$s2, $a2
	or	$s2, $a3
	or	$s2, $s0
	or	$s2, $s1
	or	$s3, $s2
	or	$a0, $s2
	or	$a1, $s2
	or	$a2, $s2
	or	$a3, $s2
	or	$s0, $s2
	or	$s1, $s2
	or	$s2, $s2
	or	$s2, $s2, $s3
	or	$s2, $s3, $s2

	or32	$t4, $t5, $a0
	or32	$sp, $fp, $ra
	or32	$t4, $t4, $a0
	or32	$t4, $a0

	or	$t4, $t5, 32768
	or	$t4, $t5, 4095
	or	$t4, $t5, 4096
	or	$t4, $t5, -32768
	or	$t4, $t5, -32769

	ori	$t5, $a0, 0
	ori	$t5, $a0, 4095

	rdhwr	$t4, $0
	rdhwr	$t4, $1
	rdhwr	$t4, $2
	rdhwr	$t4, $3
	rdhwr	$t4, $4
	rdhwr	$t4, $5
	rdhwr	$t4, $6
	rdhwr	$t4, $7
	rdhwr	$t4, $8
	rdhwr	$t4, $9
	rdhwr	$t4, $10

	rdpgpr	$t4, $t5
	rdpgpr	$t4, $t4

	rem	$zero, $t4, $t5
	rem	$zero, $fp, $ra
	rem	$zero, $t5
	rem	$zero, $ra

	rem	$t4, $t5, $zero
	rem	$t4, $t5, $a0

	rem	$t5, $a0, 0
	rem	$t5, $a0, 1
	rem	$t5, $a0, -1
	rem	$t5, $a0, 2

	rol	$t4, $t5, $a0
	rol	$t4, $t4, $a0
	rol	$t4, $t5, $t5
	rol	$t4, $t5, $t4

	rol	$t4, $t5, 0
	rol	$t4, $t5, 1
	rol	$t4, $t5, 31
	rol	$t4, $t4, 31
	rol	$t4, 31

	ror	$t4, $t5, 0
	ror	$t4, $t5, 1
	ror	$t4, $t5, 31
	ror	$t4, $t4, 31
	ror	$t4, 31

	ror	$t4, $t5, $a0
	ror	$t4, $t4, $a0

	rotr	$t4, $t5, $a0
	rotr	$t4, $t4, $a0

	rorv	$t4, $t5, $a0
	rorv	$t4, $t4, $a0

	rotrv	$t4, $t5, $a0
	rotrv	$t4, $t4, $a0

	sb	$zero, ($s3)
	sb	$zero, 0($s3)
	sb	$zero, 1($s3)
	sb	$zero, 2($s3)
	sb	$zero, 3($s3)
	sb	$zero, 4($t5)
	sb	$zero, 5($t5)
	sb	$zero, 6($t5)
	sb	$zero, 7($t5)
	sb	$zero, 8($t5)
	sb	$zero, 9($t5)
	sb	$zero, 10($t5)
	sb	$zero, 11($t5)
	sb	$zero, 12($t5)
	sb	$zero, 13($t5)
	sb	$zero, 14($t5)
	sb	$zero, 15($t5)
	sb	$t4, 15($t5)
	sb	$t5, 15($t5)
	sb	$a0, 15($t5)
	sb	$a1, 15($t5)
	sb	$a2, 15($t5)
	sb	$a3, 15($t5)
	sb	$s1, 15($t5)
	sb	$s1, 15($a0)
	sb	$s1, 15($a1)
	sb	$s1, 15($a2)
	sb	$s1, 15($a3)
	sb	$s1, 15($t4)
	sb	$s1, 15($s0)
	sb	$s1, 15($s1)

	sb32	$t5, 4
	sb32	$t5, 4($zero)

	sb32	$t5, 4095($zero)

	sb	$t5, 65535($zero)
	sb	$t5, 0xffff0000($zero)
	sb	$t5, 0xffff8000($zero)
	sb	$t5, 0xffff0001($zero)
	sb	$t5, 0xffff8001($zero)
	sb	$t5, 0xf0000000($zero)
	sb	$t5, 0xffffffff($zero)
	sb	$t5, 0x12345678($zero)
	sb32	$t5, ($a0)
	sb32	$t5, 0($a0)
	sb32	$t5, 4095($a0)

	sb	$t5, 65535($a0)
	sb	$t5, 0xffff0000($a0)
	sb	$t5, 0xffff8000($a0)
	sb	$t5, 0xffff0001($a0)
	sb	$t5, 0xffff8001($a0)
	sb	$t5, 0xf0000000($a0)
	sb	$t5, 0xffffffff($a0)
	sb	$t5, 0x12345678($a0)

	sc	$t5, 4
	sc	$t5, 4($zero)
	sc	$t5, 2047($zero)
	sc	$t5, -2048($zero)
	sc	$t5, 32767($zero)
	sc	$t5, -32768($zero)
	sc	$t5, 65535($zero)
	sc	$t5, 0xffff0000($zero)
	sc	$t5, 0xffff8000($zero)
	sc	$t5, 0xffff0001($zero)
	sc	$t5, 0xffff8001($zero)
	sc	$t5, 0xf0000000($zero)
	sc	$t5, 0xffffffff($zero)
	sc	$t5, 0x12345678($zero)
	sc	$t5, ($a0)
	sc	$t5, 0($a0)
	sc	$t5, 2047($a0)
	sc	$t5, -2048($a0)
	sc	$t5, 32767($a0)
	sc	$t5, -32768($a0)
	sc	$t5, 65535($a0)
	sc	$t5, 0xffff0000($a0)
	sc	$t5, 0xffff8000($a0)
	sc	$t5, 0xffff0001($a0)
	sc	$t5, 0xffff8001($a0)
	sc	$t5, 0xf0000000($a0)
	sc	$t5, 0xffffffff($a0)
	sc	$t5, 0x12345678($a0)

	sdbbp
	sdbbp	0
	sdbbp	1
	sdbbp	2
	sdbbp	3
	sdbbp	4
	sdbbp	5
	sdbbp	6
	sdbbp	7
	sdbbp	8
	sdbbp	9
	sdbbp	10
	sdbbp	11
	sdbbp	12
	sdbbp	13
	sdbbp	14
	sdbbp	15


	sdbbp32

	sdbbp32	0
	sdbbp32	1
	sdbbp32	2
	sdbbp32	255

	seb	$t4, $t5
	seb	$t4, $t4
	seb	$t4
	seh	$t4, $t5
	seh	$t4, $t4
	seh	$t4

	seq	$t4, $t5, $a0
	seq	$t4, $t5, $zero
	seq	$t4, $zero, $a0

	seq	$t4, $t5, 0
	seq	$t4, $t5, 1
	seq	$t4, $t5, -1
	seq	$t4, $t5, -32769

	sge	$t4, $t5, $a0
	sge	$t4, $t4, $a0
	sge	$t4, $a0
	sge	$t4, $t5, 0
	sge	$t4, $t5, -32768
	sge	$t4, $t5, 0
	sge	$t4, $t5, 32767
	sge	$t4, $t5, 65535
	sge	$t4, $t5, 65536
	sge	$t4, $t5, -32769

	sgeu	$t4, $t5, $a0
	sgeu	$t4, $t4, $a0
	sgeu	$t4, $a0
	sgeu	$t4, $t5, 0
	sgeu	$t4, $t5, -32768
	sgeu	$t4, $t5, 0
	sgeu	$t4, $t5, 32767
	sgeu	$t4, $t5, 65535
	sgeu	$t4, $t5, 65536
	sgeu	$t4, $t5, -32769

	sgt	$t4, $t5, $a0
	sgt	$t4, $t4, $a0
	sgt	$t4, $a0
	sgt	$t4, $t5, 0
	sgt	$t4, $t5, -32768
	sgt	$t4, $t5, 0
	sgt	$t4, $t5, 32767
	sgt	$t4, $t5, 65535
	sgt	$t4, $t5, 65536
	sgt	$t4, $t5, -32769

	sgtu	$t4, $t5, $a0
	sgtu	$t4, $t4, $a0
	sgtu	$t4, $a0
	sgtu	$t4, $t5, 0
	sgtu	$t4, $t5, -32768
	sgtu	$t4, $t5, 0
	sgtu	$t4, $t5, 32767
	sgtu	$t4, $t5, 65535
	sgtu	$t4, $t5, 65536
	sgtu	$t4, $t5, -32769

	sh	$s2, ($s3)
	sh	$s2, 0<<1($s3)
	sh	$s2, 1<<1($s3)
	sh	$s2, 2<<1($s3)
	sh	$s2, 3<<1($s3)
	sh	$t4, 4<<1($t5)
	sh	$t4, 5<<1($t5)
	sh	$t4, 6<<1($t5)
	sh	$t4, 7<<1($t5)
	sh	$t4, 8<<1($t5)
	sh	$t4, 9<<1($t5)
	sh	$t4, 10<<1($t5)
	sh	$t4, 11<<1($t5)
	sh	$t4, 12<<1($t5)
	sh	$t4, 13<<1($t5)
	sh	$t4, 14<<1($t5)
	sh	$t4, 15<<1($t5)
	sh	$t4, 15<<1($a0)
	sh	$t4, 15<<1($a1)
	sh	$t4, 15<<1($a2)
	sh	$t4, 15<<1($a3)
	sh	$t4, 15<<1($t4)
	sh	$t4, 15<<1($s0)
	sh	$t4, 15<<1($s1)
	sh	$t5, 15<<1($s1)
	sh	$a0, 15<<1($s1)
	sh	$a1, 15<<1($s1)
	sh	$a2, 15<<1($s1)
	sh	$a3, 15<<1($s1)
	sh	$s1, 15<<1($s1)
	sh	$zero, 15<<1($s1)

	sh32	$t5, 4
	sh32	$t5, 4($zero)
	sh32	$t5, 4095($zero)

	sh	$t5, 65535($zero)
	sh	$t5, 0xffff0000($zero)
	sh	$t5, 0xffff8000($zero)
	sh	$t5, 0xffff0001($zero)
	sh	$t5, 0xffff8001($zero)
	sh	$t5, 0xf0000000($zero)
	sh	$t5, 0xffffffff($zero)
	sh	$t5, 0x12345678($zero)
	sh32	$t5, ($a0)
	sh32	$t5, 0($a0)
	sh32	$t5, 4095($a0)

	sh	$t5, 65535($a0)
	sh	$t5, 0xffff0000($a0)
	sh	$t5, 0xffff8000($a0)
	sh	$t5, 0xffff0001($a0)
	sh	$t5, 0xffff8001($a0)
	sh	$t5, 0xf0000000($a0)
	sh	$t5, 0xffffffff($a0)
	sh	$t5, 0x12345678($a0)

	sle	$t4, $t5, $a0
	sle	$t4, $t4, $a0
	sle	$t4, $a0
	sle	$t4, $t5, 0
	sle	$t4, $t5, -32768
	sle	$t4, $t5, 0
	sle	$t4, $t5, 32767
	sle	$t4, $t5, 65535
	sle	$t4, $t5, 65536
	sle	$t4, $t5, -32769

	sleu	$t4, $t5, $a0
	sleu	$t4, $t4, $a0
	sleu	$t4, $a0
	sleu	$t4, $t5, 0
	sleu	$t4, $t5, -32768
	sleu	$t4, $t5, 0
	sleu	$t4, $t5, 32767
	sleu	$t4, $t5, 65535
	sleu	$t4, $t5, 65536
	sleu	$t4, $t5, -32769

	sll	$s2, $s2, 1
	sll	$s2, $s2, 2
	sll	$s2, $s2, 3
	sll	$s2, $s2, 4
	sll	$s2, $s2, 5
	sll	$s2, $s2, 6
	sll	$s2, $s2, 7
	sll	$s2, $s2, 8
	sll	$s2, $s3, 8
	sll	$s2, $a0, 8
	sll	$s2, $a1, 8
	sll	$s2, $a2, 8
	sll	$s2, $a3, 8
	sll	$s2, $s0, 8
	sll	$s2, $s1, 8
	sll	$s3, $s2, 8
	sll	$a0, $s2, 8
	sll	$a1, $s2, 8
	sll	$a2, $s2, 8
	sll	$a3, $s2, 8
	sll	$s0, $s2, 8
	sll	$s1, $s2, 8
	sll	$s2, $s2, 1
	sll	$s3, 1

	sllv	$t4, $t5, $a0
	sllv	$t4, $t4, $a0
	sll	$t4, $t4, $a0
	sll	$t4, $a0

	sll32	$t4, $a0, 0
	sll32	$t4, $a0, 1
	sll32	$t4, $a0, 31
	sll32	$t4, $t4, 31
	sll32	$t4, 31

	slt	$t4, $t5, $a0
	slt	$t4, $t4, $a0
	slt	$t4, $a0
	slt	$t4, $t5, 0
	slt	$t4, $t5, -32768
	slt	$t4, $t5, 0
	slt	$t4, $t5, 32767
	slt	$t4, $t5, 65535
	slt	$t4, $t5, 65536
	slt	$t4, $t5, -32769

	slti	$t5, $a0, 0
	slti	$t5, $a0, 4095

	sltiu	$t5, $a0, 0
	sltiu	$t5, $a0, 4095

	sltu	$t4, $t5, $a0
	sltu	$t4, $t4, $a0
	sltu	$t4, $a0
	sltu	$t4, $t5, 0
	sltu	$t4, $t5, -32768
	sltu	$t4, $t5, 0
	sltu	$t4, $t5, 32767
	sltu	$t4, $t5, 65535
	sltu	$t4, $t5, 65536
	sltu	$t4, $t5, -32769

	sne	$t4, $t5, $a0
	sne	$t4, $zero, $a0
	sne	$t4, $t5, $zero

	sne	$t4, $t5, 0
	sne	$t4, $t5, 1
	sne	$t4, $t5, -1
	sne	$t4, $t5, -32769

	srav	$t4, $t5, $a0
	srav	$t4, $t4, $a0
	sra	$t4, $t4, $a0
	sra	$t4, $a0
	sra	$t4, $a0, 0
	sra	$t4, $a0, 1
	sra	$t4, $a0, 31
	sra	$t4, $t4, 31
	sra	$t4, 31

	srlv	$t4, $t5, $a0
	srlv	$t4, $t4, $a0
	srl	$t4, $t4, $a0
	srl	$t4, $a0
	srl	$t4, $a0, 0
	srl	$s2, $a0, 1
	srl	$t4, $a0, 31
	srl	$t4, $t4, 31
	srl	$t4, 31

	srl	$s2, $s2, 1
	srl	$s2, $s2, 2
	srl	$s2, $s2, 3
	srl	$s2, $s2, 4
	srl	$s2, $s2, 5
	srl	$s2, $s2, 6
	srl	$s2, $s2, 7
	srl	$s2, $s2, 8
	srl	$s2, $s3, 8
	srl	$s2, $a0, 8
	srl	$s2, $a1, 8
	srl	$s2, $a2, 8
	srl	$s2, $a3, 8
	srl	$s2, $s0, 8
	srl	$s2, $s1, 8
	srl	$s2, $s2, 8
	srl	$s3, $s2, 8
	srl	$a0, $s2, 8
	srl	$a1, $s2, 8
	srl	$a2, $s2, 8
	srl	$a3, $s2, 8
	srl	$s0, $s2, 8
	srl	$s1, $s2, 8
	srl	$s3, $s3, 1
	srl	$s3, 1
	
	sub	$t4, $t5, $a0
	sub	$sp, $fp, $ra
	sub	$t4, $t4, $a0
	sub	$t4, $a0
	sub	$t4, $t4, 0
	sub	$t4, $t4, 1
	sub	$t4, $t4, 32767
	sub	$t4, $t4, -32768
	sub	$t4, $t4, 65535
	subu	$s2, $s3, $s2
	subu	$s2, $s3, $s3
	subu	$s2, $s3, $a0
	subu	$s2, $s3, $a1
	subu	$s2, $s3, $a2
	subu	$s2, $s3, $a3
	subu	$s2, $s3, $s0
	subu	$s2, $s3, $s1
	subu	$s2, $s2, $s1
	subu	$s2, $a0, $s1
	subu	$s2, $a1, $s1
	subu	$s2, $a2, $s1
	subu	$s2, $a3, $s1
	subu	$s2, $s0, $s1
	subu	$s2, $s1, $s1
	subu	$s2, $s2, $s1
	subu	$s3, $s2, $s1
	subu	$a0, $s2, $s1
	subu	$a1, $s2, $s1
	subu	$a2, $s2, $s1
	subu	$a3, $s2, $s1
	subu	$s0, $s2, $s1
	subu	$s1, $s2, $s1
	subu	$a3, $a3, $s2
	subu	$a3, $s2

	subu32	$t4, $t5, $a0
	subu32	$sp, $fp, $ra
	subu32	$t4, $t4, $a0
	subu32	$t4, $a0
	subu	$t4, $t4, 0
	subu	$t4, $t4, 1
	subu	$t4, $t4, 32767
	subu	$t4, $t4, -32768
	subu	$t4, $t4, 65535

	sw	$s2, ($a0)
	sw	$s2, 0($a0)
	sw	$s2, 1<<2($a0)
	sw	$s2, 2<<2($a0)
	sw	$s2, 3<<2($a0)
	sw	$s2, 4<<2($a0)
	sw	$s2, 5<<2($a0)
	sw	$s2, 6<<2($a0)
	sw	$s2, 7<<2($a0)
	sw	$s2, 8<<2($a0)
	sw	$s2, 9<<2($a0)
	sw	$s2, 10<<2($a0)
	sw	$s2, 11<<2($a0)
	sw	$s2, 12<<2($a0)
	sw	$s2, 13<<2($a0)
	sw	$s2, 14<<2($a0)
	sw	$s2, 15<<2($a0)
	sw	$s2, 15<<2($a1)
	sw	$s2, 15<<2($a2)
	sw	$s2, 15<<2($a3)
	sw	$s2, 15<<2($s0)
	sw	$s2, 15<<2($s1)
	sw	$s2, 15<<2($s2)
	sw	$s2, 15<<2($s3)
	sw	$s3, 15<<2($s3)
	sw	$a0, 15<<2($s3)
	sw	$a1, 15<<2($s3)
	sw	$a2, 15<<2($s3)
	sw	$a3, 15<<2($s3)
	sw	$s1, 15<<2($s3)
	sw	$zero, 15<<2($s3)

	sw	$zero, ($sp)
	sw	$zero, 0($sp)
	sw	$zero, 1<<2($sp)
	sw	$zero, 2<<2($sp)
	sw	$zero, 3<<2($sp)
	sw	$zero, 4<<2($sp)
	sw	$zero, 5<<2($sp)
	sw	$zero, 30<<2($sp)
	sw	$zero, 31<<2($sp)
	sw	$t4, 31<<2($sp)
	sw	$s1, 31<<2($sp)
	sw	$t5, 31<<2($sp)
	sw	$a0, 31<<2($sp)
	sw	$a1, 31<<2($sp)
	sw	$a2, 31<<2($sp)
	sw	$a3, 31<<2($sp)
	sw	$ra, 31<<2($sp)

	sw32	$t5, 4
	sw32	$t5, 4($zero)
	sw32	$t5, 4095($zero)

	sw	$t5, 65535($zero)
	sw	$t5, 0xffff0000($zero)
	sw	$t5, 0xffff8000($zero)
	sw	$t5, 0xffff0001($zero)
	sw	$t5, 0xffff8001($zero)
	sw	$t5, 0xf0000000($zero)
	sw	$t5, 0xffffffff($zero)
	sw	$t5, 0x12345678($zero)
	sw32	$t5, ($a0)
	sw32	$t5, 0($a0)
	sw32	$t5, 4095($a0)

	sw	$t5, 65535($a0)
	sw	$t5, 0xffff0000($a0)
	sw	$t5, 0xffff8000($a0)
	sw	$t5, 0xffff0001($a0)
	sw	$t5, 0xffff8001($a0)
	sw	$t5, 0xf0000000($a0)
	sw	$t5, 0xffffffff($a0)
	sw	$t5, 0x12345678($a0)

	sync
	sync	0
	sync	1
	sync	2
	sync	3
	sync	5
	sync	30
	sync	31

	synci	0
	synci	($zero)
	synci	0($zero)
	synci	2047($zero)
	synci	2048($zero)

	synci	0($t4)
	synci	0($t5)
	synci	255($t5)
	synci	-256($t5)
	synci	2048($t5)

	syscall
	syscall	0
	syscall	1
	syscall	2
	syscall	255
/*
	teq	$t4, $t5
	teq	$t5, $t4
	teq	$t4, $t5, 0
	teq	$t4, $t5, 1
	teq	$t4, $t5, 15
	teq	$t4, 0
	teq	$t4, -32768
	teq	$t4, 32767
	teq	$t4, 65535

	tlbp
	tlbr
	tlbwi
	tlbwr

	tne	$t4, $t5
	tne	$t5, $t4
	tne	$t4, $t5, 0
	tne	$t4, $t5, 1
	tne	$t4, $t5, 15
	tne	$t4, 0
	tne	$t4, -32768
	tne	$t4, 32767
	tne	$t4, 65535
	tne	$t4, 65536
	tne	$t4, 0xffffffff
*/
	ulh	$t5, 4
	ulh	$t5, 4($zero)
	ulh	$t5, ($a0)
	ulh	$t5, 0($a0)
	ulh	$t5, 32763($a0)
	ulh	$t5, -32768($a0)
	ulh	$t5, 65535($a0)
	ulh	$t5, 0xffff0000($a0)
	ulh	$t5, 0xffff8000($a0)
	ulh	$t5, 0xffff0001($a0)
	ulh	$t5, 0xffff8001($a0)
	ulh	$t5, 0xf0000000($a0)
	ulh	$t5, 0xffffffff($a0)

	ulhu	$t5, 4
	ulhu	$t5, 4($zero)
	ulhu	$t5, ($a0)
	ulhu	$t5, 0($a0)
	ulhu	$t5, 32763($a0)
	ulhu	$t5, -32768($a0)
	ulhu	$t5, 65535($a0)
	ulhu	$t5, 0xffff0000($a0)
	ulhu	$t5, 0xffff8000($a0)
	ulhu	$t5, 0xffff0001($a0)
	ulhu	$t5, 0xffff8001($a0)
	ulhu	$t5, 0xf0000000($a0)
	ulhu	$t5, 0xffffffff($a0)

	ulw	$t5, 0
	ulw	$t5, ($zero)
	ulw	$t5, 4
	ulw	$t5, 4($zero)
	ulw	$t5, 2047
	ulw	$t5, -2048
	ulw	$t5, 2048
	ulw	$t5, -2049
	ulw	$t5, 32763($zero)
	ulw	$t5, -32768($zero)
	ulw	$t5, 65535($zero)
	ulw	$t5, 0xffff0000($zero)
	ulw	$t5, 0xffff8000($zero)
	ulw	$t5, 0xffff0001($zero)
	ulw	$t5, 0xffff8001($zero)
	ulw	$t5, 0xf0000000($zero)
	ulw	$t5, 0xffffffff($zero)
	ulw	$t5, 0x12345678($zero)
	ulw	$t5, 0($a0)
	ulw	$t5, 4($a0)
	ulw	$t5, 2047($a0)
	ulw	$t5, -2048($a0)
	ulw	$t5, 2048($a0)
	ulw	$t5, -2049($a0)
	ulw	$t5, 32763($a0)
	ulw	$t5, -32768($a0)
	ulw	$t5, 65535($a0)
	ulw	$t5, 0xffff0000($a0)
	ulw	$t5, 0xffff8000($a0)
	ulw	$t5, 0xffff0001($a0)
	ulw	$t5, 0xffff8001($a0)
	ulw	$t5, 0xf0000000($a0)
	ulw	$t5, 0xffffffff($a0)
	ulw	$t5, 0x12345678($a0)

	ush	$t5, 4
	ush	$t5, 4($zero)
	ush	$t5, ($a0)
	ush	$t5, 0($a0)
	ush	$t5, 32763($a0)
	ush	$t5, -32768($a0)
	ush	$t5, 65535($a0)
	ush	$t5, 0xffff0000($a0)
	ush	$t5, 0xffff8000($a0)
	ush	$t5, 0xffff0001($a0)
	ush	$t5, 0xffff8001($a0)
	ush	$t5, 0xf0000000($a0)
	ush	$t5, 0xffffffff($a0)

	usw	$t5, 0
	usw	$t5, ($zero)
	usw	$t5, 4
	usw	$t5, 4($zero)
	usw	$t5, 2047
	usw	$t5, -2048
	usw	$t5, 2048
	usw	$t5, -2049
	usw	$t5, 32763($zero)
	usw	$t5, -32768($zero)
	usw	$t5, 65535($zero)
	usw	$t5, 0xffff0000($zero)
	usw	$t5, 0xffff8000($zero)
	usw	$t5, 0xffff0001($zero)
	usw	$t5, 0xffff8001($zero)
	usw	$t5, 0xf0000000($zero)
	usw	$t5, 0xffffffff($zero)
	usw	$t5, 0x12345678($zero)
	usw	$t5, 0($a0)
	usw	$t5, 4($a0)
	usw	$t5, 2047($a0)
	usw	$t5, -2048($a0)
	usw	$t5, 2048($a0)
	usw	$t5, -2049($a0)
	usw	$t5, 32763($a0)
	usw	$t5, -32768($a0)
	usw	$t5, 65535($a0)
	usw	$t5, 0xffff0000($a0)
	usw	$t5, 0xffff8000($a0)
	usw	$t5, 0xffff0001($a0)
	usw	$t5, 0xffff8001($a0)
	usw	$t5, 0xf0000000($a0)
	usw	$t5, 0xffffffff($a0)
	usw	$t5, 0x12345678($a0)


	wait
	wait	0
	wait	1
	wait	255

	wrpgpr	$t4, $t5
	wrpgpr	$t4, $a0
	wrpgpr	$t4, $t4
	wrpgpr	$t4

	wsbh	$t4, $t5
	wsbh	$t4, $a0
	wsbh	$t4, $t4
	wsbh	$t4

	xor	$s2, $s2
	xor	$s2, $s3
	xor	$s2, $a0
	xor	$s2, $a1
	xor	$s2, $a2
	xor	$s2, $a3
	xor	$s2, $s0
	xor	$s2, $s1
	xor	$s3, $s1
	xor	$a0, $s1
	xor	$a1, $s1
	xor	$a2, $s1
	xor	$a3, $s1
	xor	$s0, $s1
	xor	$s1, $s1
	xor	$s2, $s3
	xor	$s2, $s2, $s3
	xor	$s2, $s3, $s2

	xor32	$t4, $t5, $a0
	xor32	$sp, $fp, $ra
	xor32	$t4, $t4, $a0
	xor32	$t4, $a0

	xor	$t4, $t5, 32768
	xor	$t4, $t5, 4095
	xor	$t4, $t5, 4096
	xor	$t4, $t5, -32768
	xor	$t4, $t5, -32769

	xori	$t5, $a0, 0
	xori	$t5, $t5, 4095

	beqz	$a5, test
	addu	$s3, $a0, $a1

	beq	$a5, $a6, test
	addu	$s3, $a0, $a1

	beq	$a5, 0, test
	addu	$s3, $a0, $a1

	beq	$a5, 1, test
	addu	$s3, $a0, $a1

	bge	$a6, $zero, test
	addu	$s3, $a0, $a1

	bge	$a6, $zero, test
	addu	$s3, $a0, $a1

	bge	$zero, $a6, test
	addu	$s3, $a0, $a1

	bge	$a6, $a7, test
	addu	$s3, $a0, $a1

	bge	$a6, 0, test
	addu	$s3, $a0, $a1

	bge	$a6, 1, test
	addu	$s3, $a0, $a1

	bge	$a6, 2, test
	addu	$s3, $a0, $a1

	bge	$a6, 0x80000000, test
	addu	$s3, $a0, $a1

	bgeu	$t4, $zero, test
	addu	$s3, $a0, $a1

	bgeu	$zero, $t4, test
	addu	$s3, $a0, $a1

	bgeu	$t4, $t5, test
	addu	$s3, $a0, $a1

	bgeu	$t4, 0, test
	addu	$s3, $a0, $a1

	bgeu	$t4, 1, test
	addu	$s3, $a0, $a1

	bgeu	$t4, 2, test
	addu	$s3, $a0, $a1

	bgez	$t4, test
	addu	$s3, $a0, $a1

	bgt	$t4, $zero, test
	addu	$s3, $a0, $a1

	bgt	$zero, $t4, test
	addu	$s3, $a0, $a1

	bgt	$a5, $a6, test
	addu	$s3, $a0, $a1

	bgt	$a5, 0x7fffffff, test
	addu	$s3, $a0, $a1

	bgt	$a5, -1, test
	addu	$s3, $a0, $a1

	bgt	$a5, 0, test
	addu	$s3, $a0, $a1

	bgt	$a5, 1, test
	addu	$s3, $a0, $a1

	bgt	$a5, 0x80000000, test
	addu	$s3, $a0, $a1

	bgtu	$a5, $zero, test
	addu	$s3, $a0, $a1

	bgtu	$zero, $a5, test
	addu	$s3, $a0, $a1

	bgtu	$a5, $a6, test
	addu	$s3, $a0, $a1

	bgtu	$zero, 0, test
	addu	$s3, $a0, $a1

	bgtu	$a5, 0xffffffff, test
	addu	$s3, $a0, $a1

	bgtu	$a5, -1, test
	addu	$s3, $a0, $a1

	bgtu	$a5, 0, test
	addu	$s3, $a0, $a1

	bgtu	$a5, 1, test
	addu	$s3, $a0, $a1

	bgtz	$a5, test
	addu	$s3, $a0, $a1

	ble	$a5, $zero, test
	addu	$s3, $a0, $a1

	ble	$zero, $a6, test
	addu	$s3, $a0, $a1

	ble	$a5, $a6, test
	addu	$s3, $a0, $a1

	ble	$a5, 0x7fffffff, test
	addu	$s3, $a0, $a1

	ble	$a5, -1, test
	addu	$s3, $a0, $a1

	ble	$a5, 0, test
	addu	$s3, $a0, $a1

	ble	$a5, 1, test
	addu	$s3, $a0, $a1

	bleu	$a5, $zero, test
	addu	$s3, $a0, $a1

	bleu	$zero, $a6, test
	addu	$s3, $a0, $a1

	bleu	$a5, $a6, test
	addu	$s3, $a0, $a1

	bleu	$zero, $a6, test
	addu	$s3, $a0, $a1

	bleu	$a5, 0xffffffff, test
	addu	$s3, $a0, $a1

	bleu	$a5, 0, test
	addu	$s3, $a0, $a1

	bleu	$a5, 1, test
	addu	$s3, $a0, $a1

	blez	$a5, test
	addu	$s3, $a0, $a1

	blt	$a5, $zero, test
	addu	$s3, $a0, $a1

	blt	$zero, $a6, test
	addu	$s3, $a0, $a1

	blt	$a5, $a6, test
	addu	$s3, $a0, $a1

	blt	$a5, 0, test
	addu	$s3, $a0, $a1

	blt	$a5, 1, test
	addu	$s3, $a0, $a1

	blt	$a5, 2, test
	addu	$s3, $a0, $a1

	bltu	$a5, $zero, test
	addu	$s3, $a0, $a1

	bltu	$zero, $a6, test
	addu	$s3, $a0, $a1

	bltu	$a5, $a6, test
	addu	$s3, $a0, $a1

	bltu	$a5, 0, test
	addu	$s3, $a0, $a1

	bltu	$a5, 1, test
	addu	$s3, $a0, $a1

	bltu	$a5, 2, test
	addu	$s3, $a0, $a1

	bltz	$a5, test
	addu	$s3, $a0, $a1

	bnez	$a5, test
	addu	$s3, $a0, $a1

	bne	$a5, $a6, test
	addu	$s3, $a0, $a1

	bne	$a5, 0, test
	addu	$s3, $a0, $a1

	bne	$a5, 1, test
	addu	$s3, $a0, $a1
	
	sd	$t5, 4
	sd	$t5, 4($zero)
	sd	$t5, 32767($zero)
	sd	$t5, -32768($zero)
	sd	$t5, 65535($zero)
	sd	$t5, 0xffff0000($zero)
	sd	$t5, 0xffff8000($zero)
	sd	$t5, 0xffff0001($zero)
	sd	$t5, 0xffff8001($zero)
	sd	$t5, 0xf0000000($zero)
	sd	$t5, 0xffffffff($zero)
	sd	$t5, 0x12345678($zero)
	sd	$t5, ($a0)
	sd	$t5, 0($a0)
	sd	$t5, 32767($a0)
	sd	$t5, -32768($a0)
	sd	$t5, 65535($a0)
	sd	$t5, 0xffff0000($a0)
	sd	$t5, 0xffff8000($a0)
	sd	$t5, 0xffff0001($a0)
	sd	$t5, 0xffff8001($a0)
	sd	$t5, 0xf0000000($a0)
	sd	$t5, 0xffffffff($a0)
	sd	$t5, 0x12345678($a0)

	ld	$t5, 4
	ld	$t5, 4($zero)
	ld	$t5, 32767($zero)
	ld	$t5, -32768($zero)
	ld	$t5, 65535($zero)
	ld	$t5, 0xffff0000($zero)
	ld	$t5, 0xffff8000($zero)
	ld	$t5, 0xffff0001($zero)
	ld	$t5, 0xffff8001($zero)
	ld	$t5, 0xf0000000($zero)
	ld	$t5, 0xffffffff($zero)
	ld	$t5, 0x12345678($zero)
	ld	$t5, ($a0)
	ld	$t5, 0($a0)
	ld	$t5, 32767($a0)
	ld	$t5, -32768($a0)
	ld	$t5, 65535($a0)
	ld	$t5, 0xffff0000($a0)
	ld	$t5, 0xffff8000($a0)
	ld	$t5, 0xffff0001($a0)
	ld	$t5, 0xffff8001($a0)
	ld	$t5, 0xf0000000($a0)
	ld	$t5, 0xffffffff($a0)
	ld	$t5, 0x12345678($a0)

	jraddiusp	0 << 2
	jraddiusp	2 << 2
	jraddiusp	4 << 2
	jraddiusp	6 << 2
	jraddiusp	8 << 2
	jraddiusp	10 << 2
	jraddiusp	(1 << 2)
	jraddiusp	3 << 2
	jraddiusp	5 << 2
	jraddiusp	7 << 2
	jraddiusp	9 << 2
	jraddiusp	30 << 2
	jraddiusp	31 << 2

	ldc2	$3, 0
	ldc2	$3, ($zero)
	ldc2	$3, 4
	ldc2	$3, 4($zero)
	ldc2	$3, ($a0)
	ldc2	$3, 0($a0)
	ldc2	$3, 32767($a0)
	ldc2	$3, -32768($a0)
	ldc2	$3, 65535($a0)
	ldc2	$3, 0xffff0000($a0)
	ldc2	$3, 0xffff8000($a0)
	ldc2	$3, 0xffff0001($a0)
	ldc2	$3, 0xffff8001($a0)
	ldc2	$3, 0xf0000000($a0)
	ldc2	$3, 0xffffffff($a0)
	ldc2	$3, 0x12345678($a0)

	lwc2	$3, 0
	lwc2	$3, ($zero)
	lwc2	$3, 4
	lwc2	$3, 4($zero)
	lwc2	$3, ($a0)
	lwc2	$3, 0($a0)
	lwc2	$3, 32767($a0)
	lwc2	$3, -32768($a0)
	lwc2	$3, 65535($a0)
	lwc2	$3, 0xffff0000($a0)
	lwc2	$3, 0xffff8000($a0)
	lwc2	$3, 0xffff0001($a0)
	lwc2	$3, 0xffff8001($a0)
	lwc2	$3, 0xf0000000($a0)
	lwc2	$3, 0xffffffff($a0)
	lwc2	$3, 0x12345678($a0)

	mfc2	$a1, $0
	mfc2	$a1, $1
	mfc2	$a1, $2
	mfc2	$a1, $3
	mfc2	$a1, $4
	mfc2	$a1, $5
	mfc2	$a1, $6
	mfc2	$a1, $7
	mfc2	$a1, $8
	mfc2	$a1, $9
	mfc2	$a1, $10
	mfc2	$a1, $11
	mfc2	$a1, $12
	mfc2	$a1, $13
	mfc2	$a1, $14
	mfc2	$a1, $15
	mfc2	$a1, $16
	mfc2	$a1, $17
	mfc2	$a1, $18
	mfc2	$a1, $19
	mfc2	$a1, $20
	mfc2	$a1, $21
	mfc2	$a1, $22
	mfc2	$a1, $23
	mfc2	$a1, $24
	mfc2	$a1, $25
	mfc2	$a1, $26
	mfc2	$a1, $27
	mfc2	$a1, $28
	mfc2	$a1, $29
	mfc2	$a1, $30
	mfc2	$a1, $31

	mfhc2	$a1, $0
	mfhc2	$a1, $1
	mfhc2	$a1, $2
	mfhc2	$a1, $3
	mfhc2	$a1, $4
	mfhc2	$a1, $5
	mfhc2	$a1, $6
	mfhc2	$a1, $7
	mfhc2	$a1, $8
	mfhc2	$a1, $9
	mfhc2	$a1, $10
	mfhc2	$a1, $11
	mfhc2	$a1, $12
	mfhc2	$a1, $13
	mfhc2	$a1, $14
	mfhc2	$a1, $15
	mfhc2	$a1, $16
	mfhc2	$a1, $17
	mfhc2	$a1, $18
	mfhc2	$a1, $19
	mfhc2	$a1, $20
	mfhc2	$a1, $21
	mfhc2	$a1, $22
	mfhc2	$a1, $23
	mfhc2	$a1, $24
	mfhc2	$a1, $25
	mfhc2	$a1, $26
	mfhc2	$a1, $27
	mfhc2	$a1, $28
	mfhc2	$a1, $29
	mfhc2	$a1, $30
	mfhc2	$a1, $31

	mtc2	$a1, $0
	mtc2	$a1, $1
	mtc2	$a1, $2
	mtc2	$a1, $3
	mtc2	$a1, $4
	mtc2	$a1, $5
	mtc2	$a1, $6
	mtc2	$a1, $7
	mtc2	$a1, $8
	mtc2	$a1, $9
	mtc2	$a1, $10
	mtc2	$a1, $11
	mtc2	$a1, $12
	mtc2	$a1, $13
	mtc2	$a1, $14
	mtc2	$a1, $15
	mtc2	$a1, $16
	mtc2	$a1, $17
	mtc2	$a1, $18
	mtc2	$a1, $19
	mtc2	$a1, $20
	mtc2	$a1, $21
	mtc2	$a1, $22
	mtc2	$a1, $23
	mtc2	$a1, $24
	mtc2	$a1, $25
	mtc2	$a1, $26
	mtc2	$a1, $27
	mtc2	$a1, $28
	mtc2	$a1, $29
	mtc2	$a1, $30
	mtc2	$a1, $31

	mthc2	$a1, $0
	mthc2	$a1, $1
	mthc2	$a1, $2
	mthc2	$a1, $3
	mthc2	$a1, $4
	mthc2	$a1, $5
	mthc2	$a1, $6
	mthc2	$a1, $7
	mthc2	$a1, $8
	mthc2	$a1, $9
	mthc2	$a1, $10
	mthc2	$a1, $11
	mthc2	$a1, $12
	mthc2	$a1, $13
	mthc2	$a1, $14
	mthc2	$a1, $15
	mthc2	$a1, $16
	mthc2	$a1, $17
	mthc2	$a1, $18
	mthc2	$a1, $19
	mthc2	$a1, $20
	mthc2	$a1, $21
	mthc2	$a1, $22
	mthc2	$a1, $23
	mthc2	$a1, $24
	mthc2	$a1, $25
	mthc2	$a1, $26
	mthc2	$a1, $27
	mthc2	$a1, $28
	mthc2	$a1, $29
	mthc2	$a1, $30
	mthc2	$a1, $31

	sdc2	$3, 0
	sdc2	$3, ($zero)
	sdc2	$3, 4
	sdc2	$3, 4($zero)
	sdc2	$3, ($a0)
	sdc2	$3, 0($a0)
	sdc2	$3, 32767($a0)
	sdc2	$3, -32768($a0)
	sdc2	$3, 65535($a0)
	sdc2	$3, 0xffff0000($a0)
	sdc2	$3, 0xffff8000($a0)
	sdc2	$3, 0xffff0001($a0)
	sdc2	$3, 0xffff8001($a0)
	sdc2	$3, 0xf0000000($a0)
	sdc2	$3, 0xffffffff($a0)
	sdc2	$3, 0x12345678($a0)

	swc2	$3, 0
	swc2	$3, ($zero)
	swc2	$3, 4
	swc2	$3, 4($zero)
	swc2	$3, ($a0)
	swc2	$3, 0($a0)
	swc2	$3, 32767($a0)
	swc2	$3, -32768($a0)
	swc2	$3, 65535($a0)
	swc2	$3, 0xffff0000($a0)
	swc2	$3, 0xffff8000($a0)
	swc2	$3, 0xffff0001($a0)
	swc2	$3, 0xffff8001($a0)
	swc2	$3, 0xf0000000($a0)
	swc2	$3, 0xffffffff($a0)
	swc2	$3, 0x12345678($a0)

	sdbbp	1023
	wait	1023
	syscall	1023
	.end	test
	.set	reorder

	.set	reorder
	.ent	test_delay_slot
test_delay_slot:
	bal	test_delay_slot
	.ifndef	insn32
	jalr16	$t4
	.endif
	jalr32	$t4
	.ifndef	insn32
	jr16	$t4
	.endif
	jr32	$t4
	jalr.hb	$t4

	jr.hb	$t4
	.end	test_delay_slot

	.set	noreorder
	.ent	test_spec102
test_spec102:
	lw	$s2, 127<<2 ($gp)
	lw	$s3, 127<<2 ($gp)
	lw	$a0, 127<<2 ($gp)
	lw	$a1, 127<<2 ($gp)
	lw	$a2, 127<<2 ($gp)
	lw	$a3, 127<<2 ($gp)
	lw	$s0, 127<<2 ($gp)
	lw	$s1, 127<<2 ($gp)
	lw	$s1, 126<<2 ($gp)
	lw	$s1, 125<<2 ($gp)
	lw	$s1, 0<<2 ($gp)
	lw	$s1, 1<<2 ($gp)
	lw	$s1, 62<<2 ($gp)
	lw	$s1, 63<<2 ($gp)
	lw	$s1, 64<<2 ($gp)
	lw	$s1, -65<<2 ($gp)
	lw	$s1, 1 ($gp)
	lw	$s1, 2 ($gp)
	lw	$s1, 3 ($gp)
	lw	$s1, -1 ($gp)
	lw	$s1, -2 ($gp)
	lw	$s1, -3 ($gp)
	lw	$s1, 0 ($k1)
	.end	test_spec102

	.set	noreorder
	.ent	test_spec107
test_spec107:
	.ifndef insn32
	movep	$a1, $a2, $zero, $zero
	movep	$a2, $a3, $zero, $zero
	movep	$a0, $a1, $zero, $zero
	movep	$a1, $a2, $zero, $zero
	movep	$a2, $a3, $zero, $zero
	movep	$a2, $a3, $s1, $zero
	movep	$a2, $a3, $a5, $zero
	movep	$a2, $a3, $a6, $zero
	movep	$a2, $a3, $s0, $zero
	movep	$a2, $a3, $s2, $zero
	movep	$a2, $a3, $s3, $zero
	movep	$a2, $a3, $s4, $zero
	movep	$a2, $a3, $s4, $s1
	movep	$a2, $a3, $s4, $a5
	movep	$a2, $a3, $s4, $a6
	movep	$a2, $a3, $s4, $s0
	movep	$a2, $a3, $s4, $s2
	movep	$a2, $a3, $s4, $s3
	movep	$a2, $a3, $s4, $s4
	.endif

	lwc1	$f3, ($gp)
	lwc1	$f3, 0($gp)
	lwc1	$f3, 4($gp)
	lwc1	$f3, 16384($gp)
	lwc1	$f3, 262140($gp)

	swc1	$f3, ($gp)
	swc1	$f3, 0($gp)
	swc1	$f3, 4($gp)
	swc1	$f3, 16384($gp)
	swc1	$f3, 262140($gp)

	andi	$t4, $t4, 0xfff
	andi	$t4, $t5, 0x1fff
	andi	$t4, $a0, 0x3fff
	andi	$t4, $a1, 0x7fff
	andi	$t4, $a2, 0xffff
	andi	$t4, $a3, 0x1fffff
	andi	$t4, $a4, 0x3fffff
	andi	$t4, $a5, 0x7fffff
	andi	$t4, $s0, 0xffffff
	li	$t4, test
	dvp
	dvp	$a1
	evp
	evp	$a2
	.end	test_spec107
