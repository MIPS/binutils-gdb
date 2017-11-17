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
	/*
	ssnop
	*/
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
/*
	jalrc.hb	$ra
*/
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
/*
	lwm	$s0, $ra, 12<<2($sp)
	lwm	$s0, $s1, $ra, 12<<2($sp)
	lwm	$s0-$s1, $ra, 12<<2($sp)
	lwm	$s0, $s1, $s2, $ra, 12<<2($sp)
	lwm	$s0-$s2, $ra, 12<<2($sp)
	lwm	$s0, $s1, $s2, $s3, $ra, 12<<2($sp)
	lwm	$s0-$s3, $ra, 12<<2($sp)
	lwm	$s0, $ra, ($sp)
	lwm	$s0, $ra, 0($sp)
	lwm	$s0, $ra, 1<<2($sp)
	lwm	$s0, $ra, 2<<2($sp)
	lwm	$s0, $ra, 3<<2($sp)
	lwm	$s0, $ra, 4<<2($sp)
	lwm	$s0, $ra, 5<<2($sp)
	lwm	$s0, $ra, 6<<2($sp)
	lwm	$s0, $ra, 7<<2($sp)
	lwm	$s0, $ra, 8<<2($sp)
	lwm	$s0, $ra, 9<<2($sp)
	lwm	$s0, $ra, 10<<2($sp)
	lwm	$s0, $ra, 11<<2($sp)
	lwm	$s0, $ra, 12<<2($sp)
	lwm	$s0, $ra, 13<<2($sp)
	lwm	$s0, $ra, 14<<2($sp)
	lwm	$s0, $ra, 15<<2($sp)

	lwm	$s0, 0
	lwm	$s0, 4
	lwm	$s0, ($a1)
	lwm	$s0, 2047($a1)
	lwm	$s0-$s1, 2047($a1)
	lwm	$s0-$s2, 2047($a1)
	lwm	$s0-$s3, 2047($a1)
	lwm	$s0-$s4, 2047($a1)
	lwm	$s0-$s5, 2047($a1)
	lwm	$s0-$s6, 2047($a1)
	lwm	$s0-$s7, 2047($a1)
	lwm	$s0-$s8, 2047($a1)
	lwm	$ra, 2047($a1)
	lwm	$s0,$ra, ($a1)
	lwm	$s0-$s1,$ra, ($a1)
	lwm	$s0-$s2,$ra, ($a1)
	lwm	$s0-$s3,$ra, ($a1)
	lwm	$s0-$s4,$ra, ($a1)
	lwm	$s0-$s5,$ra, ($a1)
	lwm	$s0-$s6,$ra, ($a1)
	lwm	$s0-$s7,$ra, ($a1)
	lwm	$s0-$s8,$ra, ($a1)
	lwm	$s0, -32768($zero)
	lwm	$s0, 32767($zero)
	lwm	$s0, 0($zero)
	lwm	$s0, 65535($zero)
	lwm	$s0, -32768($sp)
	lwm	$s0, 32767($sp)
	lwm	$s0, 0($sp)
	lwm	$s0, 65535($sp)

	lwp	$t4, 0
	lwp	$t4, 4
	lwp	$t4, ($sp)
	lwp	$t4, 0($sp)
	lwp	$t4, -2048($t5)
	lwp	$t4, 2047($t5)
	lwp	$t4, -32768($t5)
	lwp	$t4, 32767($t5)
	lwp	$t4, 0($t5)
	lwp	$t4, 65535($t5)
	lwp	$t4, -32768($zero)
	lwp	$t4, 32767($zero)
	lwp	$t4, 65535($zero)

	lwl	$t5, 4
	lwl	$t5, 4($zero)
	lwl	$t5, ($zero)
	lwl	$t5, 0($zero)
	lwl	$t5, 2047($zero)
	lwl	$t5, -2048($zero)
	lwl	$t5, 32767($zero)
	lwl	$t5, -32768($zero)
	lwl	$t5, 65535($zero)
	lwl	$t5, 0xffff0000($zero)
	lwl	$t5, 0xffff8000($zero)
	lwl	$t5, 0xffff0001($zero)
	lwl	$t5, 0xffff8001($zero)
	lwl	$t5, 0xf0000000($zero)
	lwl	$t5, 0xffffffff($zero)
	lwl	$t5, 0x12345678($zero)
	lwl	$t5, ($a0)
	lwl	$t5, 0($a0)
	lwl	$t5, 2047($a0)
	lwl	$t5, -2048($a0)
	lwl	$t5, 32767($a0)
	lwl	$t5, -32768($a0)
	lwl	$t5, 65535($a0)
	lwl	$t5, 0xffff0000($a0)
	lwl	$t5, 0xffff8000($a0)
	lwl	$t5, 0xffff0001($a0)
	lwl	$t5, 0xffff8001($a0)
	lwl	$t5, 0xf0000000($a0)
	lwl	$t5, 0xffffffff($a0)
	lwl	$t5, 0x12345678($a0)

	lcache	$t5, 4
	lcache	$t5, 4($zero)
	lcache	$t5, ($zero)
	lcache	$t5, 0($zero)
	lcache	$t5, 2047($zero)
	lcache	$t5, -2048($zero)
	lcache	$t5, 32767($zero)
	lcache	$t5, -32768($zero)
	lcache	$t5, 65535($zero)
	lcache	$t5, 0xffff0000($zero)
	lcache	$t5, 0xffff8000($zero)
	lcache	$t5, 0xffff0001($zero)
	lcache	$t5, 0xffff8001($zero)
	lcache	$t5, 0xf0000000($zero)
	lcache	$t5, 0xffffffff($zero)
	lcache	$t5, 0x12345678($zero)
	lcache	$t5, ($a0)
	lcache	$t5, 0($a0)
	lcache	$t5, 2047($a0)
	lcache	$t5, -2048($a0)
	lcache	$t5, 32767($a0)
	lcache	$t5, -32768($a0)
	lcache	$t5, 65535($a0)
	lcache	$t5, 0xffff0000($a0)
	lcache	$t5, 0xffff8000($a0)
	lcache	$t5, 0xffff0001($a0)
	lcache	$t5, 0xffff8001($a0)
	lcache	$t5, 0xf0000000($a0)
	lcache	$t5, 0xffffffff($a0)
	lcache	$t5, 0x12345678($a0)

	lwr	$t5, 4
	lwr	$t5, 4($zero)
	lwr	$t5, ($zero)
	lwr	$t5, 0($zero)
	lwr	$t5, 2047($zero)
	lwr	$t5, -2048($zero)
	lwr	$t5, 32767($zero)
	lwr	$t5, -32768($zero)
	lwr	$t5, 65535($zero)
	lwr	$t5, 0xffff0000($zero)
	lwr	$t5, 0xffff8000($zero)
	lwr	$t5, 0xffff0001($zero)
	lwr	$t5, 0xffff8001($zero)
	lwr	$t5, 0xf0000000($zero)
	lwr	$t5, 0xffffffff($zero)
	lwr	$t5, 0x12345678($zero)
	lwr	$t5, ($a0)
	lwr	$t5, 0($a0)
	lwr	$t5, 2047($a0)
	lwr	$t5, -2048($a0)
	lwr	$t5, 32767($a0)
	lwr	$t5, -32768($a0)
	lwr	$t5, 65535($a0)
	lwr	$t5, 0xffff0000($a0)
	lwr	$t5, 0xffff8000($a0)
	lwr	$t5, 0xffff0001($a0)
	lwr	$t5, 0xffff8001($a0)
	lwr	$t5, 0xf0000000($a0)
	lwr	$t5, 0xffffffff($a0)
	lwr	$t5, 0x12345678($a0)

	flush	$t5, 4
	flush	$t5, 4($zero)
	flush	$t5, ($zero)
	flush	$t5, 0($zero)
	flush	$t5, 2047($zero)
	flush	$t5, -2048($zero)
	flush	$t5, 32767($zero)
	flush	$t5, -32768($zero)
	flush	$t5, 65535($zero)
	flush	$t5, 0xffff0000($zero)
	flush	$t5, 0xffff8000($zero)
	flush	$t5, 0xffff0001($zero)
	flush	$t5, 0xffff8001($zero)
	flush	$t5, 0xf0000000($zero)
	flush	$t5, 0xffffffff($zero)
	flush	$t5, 0x12345678($zero)
	flush	$t5, ($a0)
	flush	$t5, 0($a0)
	flush	$t5, 2047($a0)
	flush	$t5, -2048($a0)
	flush	$t5, 32767($a0)
	flush	$t5, -32768($a0)
	flush	$t5, 65535($a0)
	flush	$t5, 0xffff0000($a0)
	flush	$t5, 0xffff8000($a0)
	flush	$t5, 0xffff0001($a0)
	flush	$t5, 0xffff8001($a0)
	flush	$t5, 0xf0000000($a0)
	flush	$t5, 0xffffffff($a0)
	flush	$t5, 0x12345678($a0)
*/
	.set push
	lwxs	$s3, $a0($a1)
	.set pop
/*
	madd	$a0,$a1
	maddu	$a0,$a1
*/
	mfc0	$t4, $0
	mfc0	$t4, $1
	mfc0	$t4, $2
	mfc0	$t4, $3
	mfc0	$t4, $4
	mfc0	$t4, $5
	mfc0	$t4, $6
	mfc0	$t4, $7
	mfc0	$t4, $8
	mfc0	$t4, $9
	mfc0	$t4, $10
	mfc0	$t4, $11
	mfc0	$t4, $12
	mfc0	$t4, $13
	mfc0	$t4, $14
	mfc0	$t4, $15
	mfc0	$t4, $16
	mfc0	$t4, $17
	mfc0	$t4, $18
	mfc0	$t4, $19
	mfc0	$t4, $20
	mfc0	$t4, $21
	mfc0	$t4, $22
	mfc0	$t4, $23
	mfc0	$t4, $24
	mfc0	$t4, $25
	mfc0	$t4, $26
	mfc0	$t4, $27
	mfc0	$t4, $28
	mfc0	$t4, $29
	mfc0	$t4, $30
	mfc0	$t4, $31

	mfc0	$t4, $0, 0
	mfc0	$t4, $0, 1
	mfc0	$t4, $0, 2
	mfc0	$t4, $0, 3
	mfc0	$t4, $0, 4
	mfc0	$t4, $0, 5
	mfc0	$t4, $0, 6
	mfc0	$t4, $0, 7
	mfc0	$t4, $1, 0
	mfc0	$t4, $1, 1
	mfc0	$t4, $1, 2
	mfc0	$t4, $1, 3
	mfc0	$t4, $1, 4
	mfc0	$t4, $1, 5
	mfc0	$t4, $1, 6
	mfc0	$t4, $1, 7
	mfc0	$t4, $2, 0
	mfc0	$t4, $2, 1
	mfc0	$t4, $2, 2
	mfc0	$t4, $2, 3
	mfc0	$t4, $2, 4
	mfc0	$t4, $2, 5
	mfc0	$t4, $2, 6
	mfc0	$t4, $2, 7

	movn	$t4, $t5
	movn	$t4, $t4, $t5
	movn	$t4, $t5, $a0

	movz	$t4, $t5
	movz	$t4, $t4, $t5
	movz	$t4, $t5, $a0
/*
	msub	$a0,$a1
	msubu	$a0,$a1
*/
	mtc0	$t4, $0
	mtc0	$t4, $1
	mtc0	$t4, $2
	mtc0	$t4, $3
	mtc0	$t4, $4
	mtc0	$t4, $5
	mtc0	$t4, $6
	mtc0	$t4, $7
	mtc0	$t4, $8
	mtc0	$t4, $9
	mtc0	$t4, $10
	mtc0	$t4, $11
	mtc0	$t4, $12
	mtc0	$t4, $13
	mtc0	$t4, $14
	mtc0	$t4, $15
	mtc0	$t4, $16
	mtc0	$t4, $17
	mtc0	$t4, $18
	mtc0	$t4, $19
	mtc0	$t4, $20
	mtc0	$t4, $21
	mtc0	$t4, $22
	mtc0	$t4, $23
	mtc0	$t4, $24
	mtc0	$t4, $25
	mtc0	$t4, $26
	mtc0	$t4, $27
	mtc0	$t4, $28
	mtc0	$t4, $29
	mtc0	$t4, $30
	mtc0	$t4, $31

	mtc0	$t4, $0, 0
	mtc0	$t4, $0, 1
	mtc0	$t4, $0, 2
	mtc0	$t4, $0, 3
	mtc0	$t4, $0, 4
	mtc0	$t4, $0, 5
	mtc0	$t4, $0, 6
	mtc0	$t4, $0, 7
	mtc0	$t4, $1, 0
	mtc0	$t4, $1, 1
	mtc0	$t4, $1, 2
	mtc0	$t4, $1, 3
	mtc0	$t4, $1, 4
	mtc0	$t4, $1, 5
	mtc0	$t4, $1, 6
	mtc0	$t4, $1, 7
	mtc0	$t4, $2, 0
	mtc0	$t4, $2, 1
	mtc0	$t4, $2, 2
	mtc0	$t4, $2, 3
	mtc0	$t4, $2, 4
	mtc0	$t4, $2, 5
	mtc0	$t4, $2, 6
	mtc0	$t4, $2, 7
	mul	$t4, $t5, $a0
	mul	$sp, $fp, $ra
	mul	$t4, $t4, $a0
	mul	$t4, $a0
	mul	$t4, $t4, 0
	mul	$t4, $t4, 1
	mul	$t4, $t4, 32767
	mul	$t4, $t4, -32768
	mul	$t4, $t4, 65535
/*
	mulo	$t4, $t5, $a0
	mulo	$t4, $t5, 4
	mulou	$t4, $t5, $a0
	mulou	$t4, $t5, 4
	mult	$t4, $t5
	multu	$t4, $t5
*/

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
/*
	rdpgpr	$t4
*/
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
/*

	remu	$zero, $t4, $t5
	remu	$zero, $fp, $ra
	remu	$zero, $t5
	remu	$zero, $ra

	remu	$t4, $t5, $zero
	remu	$t4, $t5, $a0

	remu	$t5, $a0, 0
	remu	$t5, $a0, 1
	remu	$t5, $a0, -1
	remu	$t5, $a0, 2
*/
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
/*
	sb32	$t5, -32768($a0)
	*/
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
/*
	sh32	$t5, -32768($zero)
	*/
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
/*
	sh32	$t5, -32768($a0)
	*/
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

	/*
	slti	$t5, $a0, -32768
	*/
	slti	$t5, $a0, 0
	slti	$t5, $a0, 4095
	/*
	slti	$t5, $a0, 65535
	slti	$t5, $t5, 65535
	slti	$t5, 65535
	sltiu	$t5, $a0, -32768
	*/
	sltiu	$t5, $a0, 0
	sltiu	$t5, $a0, 4095
	/*
	sltiu	$t5, $a0, 65535
	sltiu	$t5, $t5, 65535
	sltiu	$t5, 65535
	*/
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
	/*
	sw32	$t5, -32768($zero)
	*/
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
	/*
	sw32	$t5, -32768($a0)
	*/
	sw	$t5, 65535($a0)
	sw	$t5, 0xffff0000($a0)
	sw	$t5, 0xffff8000($a0)
	sw	$t5, 0xffff0001($a0)
	sw	$t5, 0xffff8001($a0)
	sw	$t5, 0xf0000000($a0)
	sw	$t5, 0xffffffff($a0)
	sw	$t5, 0x12345678($a0)
/*
	swl	$t5, 4
	swl	$t5, 4($zero)
	swl	$t5, 2047($zero)
	swl	$t5, -2048($zero)
	swl	$t5, 32767($zero)
	swl	$t5, -32768($zero)
	swl	$t5, 65535($zero)
	swl	$t5, 0xffff0000($zero)
	swl	$t5, 0xffff8000($zero)
	swl	$t5, 0xffff0001($zero)
	swl	$t5, 0xffff8001($zero)
	swl	$t5, 0xf0000000($zero)
	swl	$t5, 0xffffffff($zero)
	swl	$t5, 0x12345678($zero)
	swl	$t5, ($a0)
	swl	$t5, 0($a0)
	swl	$t5, 2047($a0)
	swl	$t5, -2048($a0)
	swl	$t5, 32767($a0)
	swl	$t5, -32768($a0)
	swl	$t5, 65535($a0)
	swl	$t5, 0xffff0000($a0)
	swl	$t5, 0xffff8000($a0)
	swl	$t5, 0xffff0001($a0)
	swl	$t5, 0xffff8001($a0)
	swl	$t5, 0xf0000000($a0)
	swl	$t5, 0xffffffff($a0)
	swl	$t5, 0x12345678($a0)

	swr	$t5, 4
	swr	$t5, 4($zero)
	swr	$t5, 2047($zero)
	swr	$t5, -2048($zero)
	swr	$t5, 32767($zero)
	swr	$t5, -32768($zero)
	swr	$t5, 65535($zero)
	swr	$t5, 0xffff0000($zero)
	swr	$t5, 0xffff8000($zero)
	swr	$t5, 0xffff0001($zero)
	swr	$t5, 0xffff8001($zero)
	swr	$t5, 0xf0000000($zero)
	swr	$t5, 0xffffffff($zero)
	swr	$t5, 0x12345678($zero)
	swr	$t5, ($a0)
	swr	$t5, 0($a0)
	swr	$t5, 2047($a0)
	swr	$t5, -2048($a0)
	swr	$t5, 32767($a0)
	swr	$t5, -32768($a0)
	swr	$t5, 65535($a0)
	swr	$t5, 0xffff0000($a0)
	swr	$t5, 0xffff8000($a0)
	swr	$t5, 0xffff0001($a0)
	swr	$t5, 0xffff8001($a0)
	swr	$t5, 0xf0000000($a0)
	swr	$t5, 0xffffffff($a0)
	swr	$t5, 0x12345678($a0)

	scache	$t5, 4
	scache	$t5, 4($zero)
	scache	$t5, 2047($zero)
	scache	$t5, -2048($zero)
	scache	$t5, 32767($zero)
	scache	$t5, -32768($zero)
	scache	$t5, 65535($zero)
	scache	$t5, 0xffff0000($zero)
	scache	$t5, 0xffff8000($zero)
	scache	$t5, 0xffff0001($zero)
	scache	$t5, 0xffff8001($zero)
	scache	$t5, 0xf0000000($zero)
	scache	$t5, 0xffffffff($zero)
	scache	$t5, 0x12345678($zero)
	scache	$t5, ($a0)
	scache	$t5, 0($a0)
	scache	$t5, 2047($a0)
	scache	$t5, -2048($a0)
	scache	$t5, 32767($a0)
	scache	$t5, -32768($a0)
	scache	$t5, 65535($a0)
	scache	$t5, 0xffff0000($a0)
	scache	$t5, 0xffff8000($a0)
	scache	$t5, 0xffff0001($a0)
	scache	$t5, 0xffff8001($a0)
	scache	$t5, 0xf0000000($a0)
	scache	$t5, 0xffffffff($a0)
	scache	$t5, 0x12345678($a0)

	invalidate	$t5, 4
	invalidate	$t5, 4($zero)
	invalidate	$t5, 2047($zero)
	invalidate	$t5, -2048($zero)
	invalidate	$t5, 32767($zero)
	invalidate	$t5, -32768($zero)
	invalidate	$t5, 65535($zero)
	invalidate	$t5, 0xffff0000($zero)
	invalidate	$t5, 0xffff8000($zero)
	invalidate	$t5, 0xffff0001($zero)
	invalidate	$t5, 0xffff8001($zero)
	invalidate	$t5, 0xf0000000($zero)
	invalidate	$t5, 0xffffffff($zero)
	invalidate	$t5, 0x12345678($zero)
	invalidate	$t5, ($a0)
	invalidate	$t5, 0($a0)
	invalidate	$t5, 2047($a0)
	invalidate	$t5, -2048($a0)
	invalidate	$t5, 32767($a0)
	invalidate	$t5, -32768($a0)
	invalidate	$t5, 65535($a0)
	invalidate	$t5, 0xffff0000($a0)
	invalidate	$t5, 0xffff8000($a0)
	invalidate	$t5, 0xffff0001($a0)
	invalidate	$t5, 0xffff8001($a0)
	invalidate	$t5, 0xf0000000($a0)
	invalidate	$t5, 0xffffffff($a0)
	invalidate	$t5, 0x12345678($a0)

	swm	$s0, $ra, 12<<2($sp)
	swm	$s0, $s1, $ra, 12<<2($sp)
	swm	$s0-$s1, $ra, 12<<2($sp)
	swm	$s0, $s1, $s2, $ra, 12<<2($sp)
	swm	$s0-$s2, $ra, 12<<2($sp)
	swm	$s0, $s1, $s2, $s3, $ra, 12<<2($sp)
	swm	$s0-$s3, $ra, 12<<2($sp)
	swm	$s0, $ra, ($sp)
	swm	$s0, $ra, 0($sp)
	swm	$s0, $ra, 1<<2($sp)
	swm	$s0, $ra, 2<<2($sp)
	swm	$s0, $ra, 3<<2($sp)
	swm	$s0, $ra, 4<<2($sp)
	swm	$s0, $ra, 5<<2($sp)
	swm	$s0, $ra, 6<<2($sp)
	swm	$s0, $ra, 7<<2($sp)
	swm	$s0, $ra, 8<<2($sp)
	swm	$s0, $ra, 9<<2($sp)
	swm	$s0, $ra, 10<<2($sp)
	swm	$s0, $ra, 11<<2($sp)
	swm	$s0, $ra, 12<<2($sp)
	swm	$s0, $ra, 13<<2($sp)
	swm	$s0, $ra, 14<<2($sp)
	swm	$s0, $ra, 15<<2($sp)

	swm	$s0, 0
	swm	$s0, 4
	swm	$s0, 2047
	swm	$s0, -2048
	swm	$s0, 2048
	swm	$s0, -2049
	swm	$s0, ($a1)
	swm	$s0, 2047($a1)
	swm	$s0, -2048($a1)
	swm	$s0, 2048($a1)
	swm	$s0, -2049($a1)
	swm	$s0-$s1, 2047($a1)
	swm	$s0-$s2, 2047($a1)
	swm	$s0-$s3, 2047($a1)
	swm	$s0-$s4, 2047($a1)
	swm	$s0-$s5, 2047($a1)
	swm	$s0-$s6, 2047($a1)
	swm	$s0-$s7, 2047($a1)
	swm	$s0-$s8, 2047($a1)
	swm	$ra, 2047($a1)
	swm	$s0,$ra, ($a1)
	swm	$s0-$s1,$ra, ($a1)
	swm	$s0-$s2,$ra, ($a1)
	swm	$s0-$s3,$ra, ($a1)
	swm	$s0-$s4,$ra, ($a1)
	swm	$s0-$s5,$ra, ($a1)
	swm	$s0-$s6,$ra, ($a1)
	swm	$s0-$s7,$ra, ($a1)
	swm	$s0-$s8,$ra, ($a1)
	swm	$s0, -32768($sp)
	swm	$s0, 32767($sp)
	swm	$s0, 0($sp)
	swm	$s0, 65535($sp)

	swp	$t4, 0
	swp	$t4, 4
	swp	$t4, 2047
	swp	$t4, -2048
	swp	$t4, 2048
	swp	$t4, -2049
	swp	$t4, ($sp)
	swp	$t4, 0($sp)
	swp	$t4, 2047($t5)
	swp	$t4, -2048($t5)
	swp	$t4, 2048($t5)
	swp	$t4, -2049($t5)
	swp	$t4, 32767($t5)
	swp	$t4, -32768($t5)
	swp	$t4, 0($t5)
	swp	$t4, 65535($t5)
*/
	sync
	sync	0
	sync	1
	sync	2
	sync	3
	sync	4
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
	teqi	$t4, 0
	teqi	$t4, -32768
	teqi	$t4, 32767
	teqi	$t4, 65535
	teq	$t4, $t5
	teq	$t5, $t4
	teq	$t4, $t5, 0
	teq	$t4, $t5, 1
	teq	$t4, $t5, 15
	teq	$t4, 0
	teq	$t4, -32768
	teq	$t4, 32767
	teq	$t4, 65535

	tgei	$t4, 0
	tgei	$t4, -32768
	tgei	$t4, 32767
	tgei	$t4, 65535
	tge	$t4, $t5
	tge	$t5, $t4
	tge	$t4, $t5, 0
	tge	$t4, $t5, 1
	tge	$t4, $t5, 15
	tge	$t4, 0
	tge	$t4, -32768
	tge	$t4, 32767
	tge	$t4, 65535

	tgeiu	$t4, 0
	tgeiu	$t4, -32768
	tgeiu	$t4, 32767
	tgeiu	$t4, 65535
	tgeu	$t4, $t5
	tgeu	$t5, $t4
	tgeu	$t4, $t5, 0
	tgeu	$t4, $t5, 1
	tgeu	$t4, $t5, 15
	tgeu	$t4, 0
	tgeu	$t4, -32768
	tgeu	$t4, 32767
	tgeu	$t4, 65535

	tlbp
	tlbr
	tlbwi
	tlbwr

	tlti	$t4, 0
	tlti	$t4, -32768
	tlti	$t4, 32767
	tlti	$t4, 65535
	tlt	$t4, $t5
	tlt	$t5, $t4
	tlt	$t4, $t5, 0
	tlt	$t4, $t5, 1
	tlt	$t4, $t5, 15
	tlt	$t4, 0
	tlt	$t4, -32768
	tlt	$t4, 32767
	tlt	$t4, 65535

	tltiu	$t4, 0
	tltiu	$t4, -32768
	tltiu	$t4, 32767
	tltiu	$t4, 65535
	tltu	$t4, $t5
	tltu	$t5, $t4
	tltu	$t4, $t5, 0
	tltu	$t4, $t5, 1
	tltu	$t4, $t5, 15
	tltu	$t4, 0
	tltu	$t4, -32768
	tltu	$t4, 32767
	tltu	$t4, 65535
	tltu	$t4, 65536
	tltu	$t4, 0xffffffff

	tnei	$t4, 0
	tnei	$t4, -32768
	tnei	$t4, 32767
	tnei	$t4, 65535
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

/* 
	.set	noreorder
*/
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
/*
	bgezal	$t4, test
	addu	$s3, $a0, $a1
*/
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
/*
	bltzal	$a5, test
	addu	$s3, $a0, $a1
*/
	bnez	$a5, test
	addu	$s3, $a0, $a1

	bne	$a5, $a6, test
	addu	$s3, $a0, $a1

	bne	$a5, 0, test
	addu	$s3, $a0, $a1

	bne	$a5, 1, test
	addu	$s3, $a0, $a1
	
/* 
	.ifndef	insn32
	addiur1sp	$t4, 0
	addiur1sp	$t4, 1<<2
	addiur1sp	$t4, 2<<2
	addiur1sp	$t4, 3<<2
	addiur1sp	$t4, 4<<2
	addiur1sp	$t4, 63<<2
	addiur1sp	$t5, 63<<2
	addiur1sp	$a0, 63<<2
	addiur1sp	$a1, 63<<2
	addiur1sp	$a2, 63<<2
	addiur1sp	$a3, 63<<2
	addiur1sp	$s0, 63<<2
	addiur1sp	$s1, 63<<2

	addiur2	$t4, $t4, -1
	addiur2	$t4, $t5, -1
	addiur2	$t4, $a0, -1
	addiur2	$t4, $a1, -1
	addiur2	$t4, $a2, -1
	addiur2	$t4, $a3, -1
	addiur2	$t4, $s0, -1
	addiur2	$t4, $s1, -1
	addiur2	$t5, $s1, -1
	addiur2	$a0, $s1, -1
	addiur2	$a1, $s1, -1
	addiur2	$a2, $s1, -1
	addiur2	$a3, $s1, -1
	addiur2	$s0, $s1, -1
	addiur2	$s1, $s1, -1
	addiur2	$s1, $s1, 1
	addiur2	$s1, $s1, 4
	addiur2	$s1, $s1, 8
	addiur2	$s1, $s1, 12
	addiur2	$s1, $s1, 16
	addiur2	$s1, $s1, 20
	addiur2	$s1, $s1, 24

	addiusp	2 << 2
	addiusp	3 << 2
	addiusp	254 << 2
	addiusp	255 << 2
	addiusp	256 << 2
	addiusp	257 << 2
	addiusp	-3 << 2
	addiusp	-4 << 2
	addiusp	-255 << 2
	addiusp	-256 << 2
	addiusp	-257 << 2
	addiusp	-258 << 2

	addius5	$zero, 0
	addius5	$t4, 0
	addius5	$t5, 0
	addius5	$fp, 0
	addius5	$ra, 0
	addius5	$ra, 1
	addius5	$ra, 2
	addius5	$ra, 3
	addius5	$ra, 7
	addius5	$ra, -6
	addius5	$ra, -7
	addius5	$ra, -8
	.endif
*/
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

/*
	cache	0, %lo(test)($t5)
	lwp	$t4, %lo(test)($t5)
	swp	$t4, %lo(test)($t5)

	ll	$t4, %lo(test)($t5)
	sc	$t4, %lo(test)($t5)
	lwl	$t4, %lo(test)($t5)
	lwr	$t4, %lo(test)($t5)
	swl	$t4, %lo(test)($t5)
	swr	$t4, %lo(test)($t5)
	lwm	$s0, %lo(test)($t5)
	swm	$s0, %lo(test)($t5)
	lwc2	$16, %lo(test)($t5)
	swc2	$16, %lo(test)($t5)
	lcache	$t4, %lo(test)($t5)
	flush	$t4, %lo(test)($t5)
	scache	$t4, %lo(test)($t5)
	invalidate	$t4, %lo(test)($t5)
*/
	sdbbp	1023
	wait	1023
	syscall	1023
	/*
	cop2	0x7fffff
	*/
	.end	test
	.set	reorder

	.align	3
	.ent	fp_test
	.globl	fp_test
fp_test:
	/*
	prefx	0, $zero($zero)
	prefx	0, $zero($t4)
	prefx	0, $zero($ra)
	prefx	0, $t4($ra)
	prefx	0, $ra($ra)
	prefx	1, $ra($ra)
	prefx	2, $ra($ra)
	prefx	31, $ra($ra)
	*/
	abs.s	$f0, $f1
	abs.s	$f30, $f31
	abs.s	$f2, $f2
	abs.s	$f2
	abs.d	$f0, $f1
	abs.d	$f30, $f31
	abs.d	$f2, $f2
	abs.d	$f2
	/*
	abs.ps	$f0, $f1
	abs.ps	$f30, $f31
	abs.ps	$f2, $f2
	abs.ps	$f2
	*/
	add.s	$f0, $f1, $f2
	add.s	$f29, $f30, $f31
	add.s	$f29, $f29, $f30
	add.s	$f29, $f30
	add.d	$f0, $f1, $f2
	add.d	$f29, $f30, $f31
	add.d	$f29, $f29, $f30
	add.d	$f29, $f30

	/*
	add.ps	$f0, $f1, $f2
	add.ps	$f29, $f30, $f31
	add.ps	$f29, $f29, $f30
	add.ps	$f29, $f30
	
	alnv.ps	$f0, $f1, $f2, $zero
	alnv.ps	$f0, $f1, $f2, $t4
	alnv.ps	$f0, $f1, $f2, $ra
	alnv.ps	$f29, $f30, $f31, $ra
	alnv.ps	$f29, $f29, $f31, $ra
	
	bc1f	fp_test
	bc1f	$fcc0, fp_test
	bc1f	$fcc1, fp_test
	bc1f	$fcc2, fp_test
	bc1f	$fcc3, fp_test
	bc1f	$fcc4, fp_test
	bc1f	$fcc5, fp_test
	bc1f	$fcc6, fp_test
	bc1f	$fcc7, fp_test

	bc1t	fp_test
	bc1t	$fcc0, fp_test
	bc1t	$fcc1, fp_test
	bc1t	$fcc2, fp_test
	bc1t	$fcc3, fp_test
	bc1t	$fcc4, fp_test
	bc1t	$fcc5, fp_test
	bc1t	$fcc6, fp_test
	bc1t	$fcc7, fp_test

	c.f.d	$f0, $f1
	c.f.d	$f30, $f31
	c.f.d	$fcc0, $f30, $f31
	c.f.d	$fcc1, $f30, $f31
	c.f.d	$fcc7, $f30, $f31
	c.f.s	$f0, $f1
	c.f.s	$f30, $f31
	c.f.s	$fcc0, $f30, $f31
	c.f.s	$fcc1, $f30, $f31
	c.f.s	$fcc7, $f30, $f31
	c.f.ps	$f0, $f1
	c.f.ps	$f30, $f31
	c.f.ps	$fcc0, $f30, $f31
	c.f.ps	$fcc2, $f30, $f31
	c.f.ps	$fcc6, $f30, $f31

	c.un.d	$f0, $f1
	c.un.d	$f30, $f31
	c.un.d	$fcc0, $f30, $f31
	c.un.d	$fcc1, $f30, $f31
	c.un.d	$fcc7, $f30, $f31
	c.un.s	$f0, $f1
	c.un.s	$f30, $f31
	c.un.s	$fcc0, $f30, $f31
	c.un.s	$fcc1, $f30, $f31
	c.un.s	$fcc7, $f30, $f31
	c.un.ps	$f0, $f1
	c.un.ps	$f30, $f31
	c.un.ps	$fcc0, $f30, $f31
	c.un.ps	$fcc2, $f30, $f31
	c.un.ps	$fcc6, $f30, $f31

	c.eq.d	$f0, $f1
	c.eq.d	$f30, $f31
	c.eq.d	$fcc0, $f30, $f31
	c.eq.d	$fcc1, $f30, $f31
	c.eq.d	$fcc7, $f30, $f31
	c.eq.s	$f0, $f1
	c.eq.s	$f30, $f31
	c.eq.s	$fcc0, $f30, $f31
	c.eq.s	$fcc1, $f30, $f31
	c.eq.s	$fcc7, $f30, $f31
	c.eq.ps	$f0, $f1
	c.eq.ps	$f30, $f31
	c.eq.ps	$fcc0, $f30, $f31
	c.eq.ps	$fcc2, $f30, $f31
	c.eq.ps	$fcc6, $f30, $f31

	c.ueq.d	$f0, $f1
	c.ueq.d	$f30, $f31
	c.ueq.d	$fcc0, $f30, $f31
	c.ueq.d	$fcc1, $f30, $f31
	c.ueq.d	$fcc7, $f30, $f31
	c.ueq.s	$f0, $f1
	c.ueq.s	$f30, $f31
	c.ueq.s	$fcc0, $f30, $f31
	c.ueq.s	$fcc1, $f30, $f31
	c.ueq.s	$fcc7, $f30, $f31
	c.ueq.ps	$f0, $f1
	c.ueq.ps	$f30, $f31
	c.ueq.ps	$fcc0, $f30, $f31
	c.ueq.ps	$fcc2, $f30, $f31
	c.ueq.ps	$fcc6, $f30, $f31

	c.olt.d	$f0, $f1
	c.olt.d	$f30, $f31
	c.olt.d	$fcc0, $f30, $f31
	c.olt.d	$fcc1, $f30, $f31
	c.olt.d	$fcc7, $f30, $f31
	c.olt.s	$f0, $f1
	c.olt.s	$f30, $f31
	c.olt.s	$fcc0, $f30, $f31
	c.olt.s	$fcc1, $f30, $f31
	c.olt.s	$fcc7, $f30, $f31
	c.olt.ps	$f0, $f1
	c.olt.ps	$f30, $f31
	c.olt.ps	$fcc0, $f30, $f31
	c.olt.ps	$fcc2, $f30, $f31
	c.olt.ps	$fcc6, $f30, $f31

	c.ult.d	$f0, $f1
	c.ult.d	$f30, $f31
	c.ult.d	$fcc0, $f30, $f31
	c.ult.d	$fcc1, $f30, $f31
	c.ult.d	$fcc7, $f30, $f31
	c.ult.s	$f0, $f1
	c.ult.s	$f30, $f31
	c.ult.s	$fcc0, $f30, $f31
	c.ult.s	$fcc1, $f30, $f31
	c.ult.s	$fcc7, $f30, $f31
	c.ult.ps	$f0, $f1
	c.ult.ps	$f30, $f31
	c.ult.ps	$fcc0, $f30, $f31
	c.ult.ps	$fcc2, $f30, $f31
	c.ult.ps	$fcc6, $f30, $f31

	c.ole.d	$f0, $f1
	c.ole.d	$f30, $f31
	c.ole.d	$fcc0, $f30, $f31
	c.ole.d	$fcc1, $f30, $f31
	c.ole.d	$fcc7, $f30, $f31
	c.ole.s	$f0, $f1
	c.ole.s	$f30, $f31
	c.ole.s	$fcc0, $f30, $f31
	c.ole.s	$fcc1, $f30, $f31
	c.ole.s	$fcc7, $f30, $f31
	c.ole.ps	$f0, $f1
	c.ole.ps	$f30, $f31
	c.ole.ps	$fcc0, $f30, $f31
	c.ole.ps	$fcc2, $f30, $f31
	c.ole.ps	$fcc6, $f30, $f31

	c.ule.d	$f0, $f1
	c.ule.d	$f30, $f31
	c.ule.d	$fcc0, $f30, $f31
	c.ule.d	$fcc1, $f30, $f31
	c.ule.d	$fcc7, $f30, $f31
	c.ule.s	$f0, $f1
	c.ule.s	$f30, $f31
	c.ule.s	$fcc0, $f30, $f31
	c.ule.s	$fcc1, $f30, $f31
	c.ule.s	$fcc7, $f30, $f31
	c.ule.ps	$f0, $f1
	c.ule.ps	$f30, $f31
	c.ule.ps	$fcc0, $f30, $f31
	c.ule.ps	$fcc2, $f30, $f31
	c.ule.ps	$fcc6, $f30, $f31

	c.sf.d	$f0, $f1
	c.sf.d	$f30, $f31
	c.sf.d	$fcc0, $f30, $f31
	c.sf.d	$fcc1, $f30, $f31
	c.sf.d	$fcc7, $f30, $f31
	c.sf.s	$f0, $f1
	c.sf.s	$f30, $f31
	c.sf.s	$fcc0, $f30, $f31
	c.sf.s	$fcc1, $f30, $f31
	c.sf.s	$fcc7, $f30, $f31
	c.sf.ps	$f0, $f1
	c.sf.ps	$f30, $f31
	c.sf.ps	$fcc0, $f30, $f31
	c.sf.ps	$fcc2, $f30, $f31
	c.sf.ps	$fcc6, $f30, $f31

	c.ngle.d	$f0, $f1
	c.ngle.d	$f30, $f31
	c.ngle.d	$fcc0, $f30, $f31
	c.ngle.d	$fcc1, $f30, $f31
	c.ngle.d	$fcc7, $f30, $f31
	c.ngle.s	$f0, $f1
	c.ngle.s	$f30, $f31
	c.ngle.s	$fcc0, $f30, $f31
	c.ngle.s	$fcc1, $f30, $f31
	c.ngle.s	$fcc7, $f30, $f31
	c.ngle.ps	$f0, $f1
	c.ngle.ps	$f30, $f31
	c.ngle.ps	$fcc0, $f30, $f31
	c.ngle.ps	$fcc2, $f30, $f31
	c.ngle.ps	$fcc6, $f30, $f31

	c.seq.d	$f0, $f1
	c.seq.d	$f30, $f31
	c.seq.d	$fcc0, $f30, $f31
	c.seq.d	$fcc1, $f30, $f31
	c.seq.d	$fcc7, $f30, $f31
	c.seq.s	$f0, $f1
	c.seq.s	$f30, $f31
	c.seq.s	$fcc0, $f30, $f31
	c.seq.s	$fcc1, $f30, $f31
	c.seq.s	$fcc7, $f30, $f31
	c.seq.ps	$f0, $f1
	c.seq.ps	$f30, $f31
	c.seq.ps	$fcc0, $f30, $f31
	c.seq.ps	$fcc2, $f30, $f31
	c.seq.ps	$fcc6, $f30, $f31

	c.ngl.d	$f0, $f1
	c.ngl.d	$f30, $f31
	c.ngl.d	$fcc0, $f30, $f31
	c.ngl.d	$fcc1, $f30, $f31
	c.ngl.d	$fcc7, $f30, $f31
	c.ngl.s	$f0, $f1
	c.ngl.s	$f30, $f31
	c.ngl.s	$fcc0, $f30, $f31
	c.ngl.s	$fcc1, $f30, $f31
	c.ngl.s	$fcc7, $f30, $f31
	c.ngl.ps	$f0, $f1
	c.ngl.ps	$f30, $f31
	c.ngl.ps	$fcc0, $f30, $f31
	c.ngl.ps	$fcc2, $f30, $f31
	c.ngl.ps	$fcc6, $f30, $f31

	c.lt.d	$f0, $f1
	c.lt.d	$f30, $f31
	c.lt.d	$fcc0, $f30, $f31
	c.lt.d	$fcc1, $f30, $f31
	c.lt.d	$fcc7, $f30, $f31
	c.lt.s	$f0, $f1
	c.lt.s	$f30, $f31
	c.lt.s	$fcc0, $f30, $f31
	c.lt.s	$fcc1, $f30, $f31
	c.lt.s	$fcc7, $f30, $f31
	c.lt.ps	$f0, $f1
	c.lt.ps	$f30, $f31
	c.lt.ps	$fcc0, $f30, $f31
	c.lt.ps	$fcc2, $f30, $f31
	c.lt.ps	$fcc6, $f30, $f31

	c.nge.d	$f0, $f1
	c.nge.d	$f30, $f31
	c.nge.d	$fcc0, $f30, $f31
	c.nge.d	$fcc1, $f30, $f31
	c.nge.d	$fcc7, $f30, $f31
	c.nge.s	$f0, $f1
	c.nge.s	$f30, $f31
	c.nge.s	$fcc0, $f30, $f31
	c.nge.s	$fcc1, $f30, $f31
	c.nge.s	$fcc7, $f30, $f31
	c.nge.ps	$f0, $f1
	c.nge.ps	$f30, $f31
	c.nge.ps	$fcc0, $f30, $f31
	c.nge.ps	$fcc2, $f30, $f31
	c.nge.ps	$fcc6, $f30, $f31

	c.le.d	$f0, $f1
	c.le.d	$f30, $f31
	c.le.d	$fcc0, $f30, $f31
	c.le.d	$fcc1, $f30, $f31
	c.le.d	$fcc7, $f30, $f31
	c.le.s	$f0, $f1
	c.le.s	$f30, $f31
	c.le.s	$fcc0, $f30, $f31
	c.le.s	$fcc1, $f30, $f31
	c.le.s	$fcc7, $f30, $f31
	c.le.ps	$f0, $f1
	c.le.ps	$f30, $f31
	c.le.ps	$fcc0, $f30, $f31
	c.le.ps	$fcc2, $f30, $f31
	c.le.ps	$fcc6, $f30, $f31

	c.ngt.d	$f0, $f1
	c.ngt.d	$f30, $f31
	c.ngt.d	$fcc0, $f30, $f31
	c.ngt.d	$fcc1, $f30, $f31
	c.ngt.d	$fcc7, $f30, $f31
	c.ngt.s	$f0, $f1
	c.ngt.s	$f30, $f31
	c.ngt.s	$fcc0, $f30, $f31
	c.ngt.s	$fcc1, $f30, $f31
	c.ngt.s	$fcc7, $f30, $f31
	c.ngt.ps	$f0, $f1
	c.ngt.ps	$f30, $f31
	c.ngt.ps	$fcc0, $f30, $f31
	c.ngt.ps	$fcc2, $f30, $f31
	c.ngt.ps	$fcc6, $f30, $f31
	*/
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

	cvt.s.pl	$f0, $f1
	cvt.s.pl	$f30, $f31
	cvt.s.pl	$f2, $f2

	cvt.s.pu	$f0, $f1
	cvt.s.pu	$f30, $f31
	cvt.s.pu	$f2, $f2

	cvt.w.s	$f0, $f1
	cvt.w.s	$f30, $f31
	cvt.w.s	$f2, $f2

	cvt.w.d	$f0, $f1
	cvt.w.d	$f30, $f31
	cvt.w.d	$f2, $f2
/*
	cvt.ps.s	$f0, $f1, $f2
	cvt.ps.s	$f29, $f30, $f31
	cvt.ps.s	$f29, $f29, $f31
	cvt.ps.s	$f29, $f31
*/
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
/*
	luxc1	$f0, $zero($zero)
	luxc1	$f0, $zero($t4)
	luxc1	$f0, $zero($ra)
	luxc1	$f0, $t4($ra)
	luxc1	$f0, $ra($ra)
	luxc1	$f1, $ra($ra)
	luxc1	$f2, $ra($ra)
	luxc1	$f31, $ra($ra)
	*/

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
/*

	madd.d	$f0, $f1, $f2, $f3
	madd.d	$f28, $f29, $f30, $f31
	madd.s	$f0, $f1, $f2, $f3
	madd.s	$f28, $f29, $f30, $f31
	madd.ps	$f0, $f1, $f2, $f3
	madd.ps	$f28, $f29, $f30, $f31
*/
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
/*
	mov.ps	$f0, $f1
	mov.ps	$f30, $f31

	movf.d	$f2, $f3, $fcc0
	movf.d	$f2, $f3, $fcc1
	movf.d	$f2, $f3, $fcc2
	movf.d	$f2, $f3, $fcc3
	movf.d	$f2, $f3, $fcc4
	movf.d	$f2, $f3, $fcc5
	movf.d	$f2, $f3, $fcc6
	movf.d	$f2, $f3, $fcc7
	movf.d	$f30, $f31, $fcc7

	movf.s	$f2, $f3, $fcc0
	movf.s	$f2, $f3, $fcc1
	movf.s	$f2, $f3, $fcc2
	movf.s	$f2, $f3, $fcc3
	movf.s	$f2, $f3, $fcc4
	movf.s	$f2, $f3, $fcc5
	movf.s	$f2, $f3, $fcc6
	movf.s	$f2, $f3, $fcc7
	movf.s	$f30, $f31, $fcc7

	movf.ps	$f2, $f3, $fcc0
	movf.ps	$f2, $f3, $fcc2
	movf.ps	$f2, $f3, $fcc4
	movf.ps	$f2, $f3, $fcc6
	movf.ps	$f2, $f3, $fcc6
	movf.ps	$f30, $f31, $fcc6

	movn.d	$f2, $f3, $zero
	movn.d	$f2, $f3, $ra
	movn.s	$f2, $f3, $zero
	movn.s	$f2, $f3, $ra
	movn.ps	$f2, $f3, $zero
	movn.ps	$f2, $f3, $ra

	movt.ps	$f2, $f3, $fcc0
	movt.ps	$f2, $f3, $fcc2
	movt.ps	$f2, $f3, $fcc4
	movt.ps	$f2, $f3, $fcc6
	movt.ps	$f2, $f3, $fcc6
	movt.ps	$f30, $f31, $fcc6

	movz.d	$f2, $f3, $zero
	movz.d	$f2, $f3, $ra
	movz.s	$f2, $f3, $zero
	movz.s	$f2, $f3, $ra
	movz.ps	$f2, $f3, $zero
	movz.ps	$f2, $f3, $ra

	msub.d	$f0, $f1, $f2, $f3
	msub.d	$f28, $f29, $f30, $f31
	msub.s	$f0, $f1, $f2, $f3
	msub.s	$f28, $f29, $f30, $f31
	msub.ps	$f0, $f1, $f2, $f3
	msub.ps	$f28, $f29, $f30, $f31
*/
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
/*
	mul.ps	$f0, $f1, $f2
	mul.ps	$f29, $f30, $f31
	mul.ps	$f29, $f29, $f30
	mul.ps	$f29, $f30
*/
	neg.s	$f0, $f1
	neg.s	$f30, $f31
	neg.s	$f2, $f2
	neg.s	$f2
	neg.d	$f0, $f1
	neg.d	$f30, $f31
	neg.d	$f2, $f2
	neg.d	$f2
/*
	neg.ps	$f0, $f1
	neg.ps	$f30, $f31
	neg.ps	$f2, $f2
	neg.ps	$f2

	nmadd.d	$f0, $f1, $f2, $f3
	nmadd.d	$f28, $f29, $f30, $f31
	nmadd.s	$f0, $f1, $f2, $f3
	nmadd.s	$f28, $f29, $f30, $f31
	nmadd.ps	$f0, $f1, $f2, $f3
	nmadd.ps	$f28, $f29, $f30, $f31

	nmsub.d	$f0, $f1, $f2, $f3
	nmsub.d	$f28, $f29, $f30, $f31
	nmsub.s	$f0, $f1, $f2, $f3
	nmsub.s	$f28, $f29, $f30, $f31
	nmsub.ps	$f0, $f1, $f2, $f3
	nmsub.ps	$f28, $f29, $f30, $f31

	pll.ps	$f0, $f1, $f2
	pll.ps	$f29, $f30, $f31
	pll.ps	$f29, $f29, $f30
	pll.ps	$f29, $f30
	plu.ps	$f0, $f1, $f2
	plu.ps	$f29, $f30, $f31
	plu.ps	$f29, $f29, $f30
	plu.ps	$f29, $f30
	pul.ps	$f0, $f1, $f2
	pul.ps	$f29, $f30, $f31
	pul.ps	$f29, $f29, $f30
	pul.ps	$f29, $f30
	puu.ps	$f0, $f1, $f2
	puu.ps	$f29, $f30, $f31
	puu.ps	$f29, $f29, $f30
	puu.ps	$f29, $f30
*/
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

/*
	sub.ps	$f0, $f1, $f2
	sub.ps	$f29, $f30, $f31
	sub.ps	$f29, $f29, $f30
	sub.ps	$f29, $f30

	suxc1	$f0, $zero($zero)
	suxc1	$f0, $zero($t4)
	suxc1	$f0, $zero($ra)
	suxc1	$f0, $t4($ra)
	suxc1	$f0, $ra($ra)
	suxc1	$f1, $ra($ra)
	suxc1	$f2, $ra($ra)
	suxc1	$f31, $ra($ra)
*/
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
	/*
	movf	$t4, $t5, $fcc0
	movf	$fp, $ra, $fcc0
	movf	$fp, $ra, $fcc1
	movf	$fp, $ra, $fcc2
	movf	$fp, $ra, $fcc3
	movf	$fp, $ra, $fcc4
	movf	$fp, $ra, $fcc5
	movf	$fp, $ra, $fcc6
	movf	$fp, $ra, $fcc7

	movt	$t4, $t5, $fcc0
	movt	$fp, $ra, $fcc0
	movt	$fp, $ra, $fcc1
	movt	$fp, $ra, $fcc2
	movt	$fp, $ra, $fcc3
	movt	$fp, $ra, $fcc4
	movt	$fp, $ra, $fcc5
	movt	$fp, $ra, $fcc6
	movt	$fp, $ra, $fcc7

	.set	noreorder
	bc1fl	$fcc1, test
	addu	$t5, $a0, $a1
	bc1tl	$fcc2, test
	addu	$a2, $a3, $a4
	.set	reorder

	bc1fl	$fcc3, test
	addu	$t5, $a0, $a1
	bc1tl	$fcc4, test
	addu	$a2, $a3, $a4
	*/
	.end	fp_test

	.set	reorder
	.ent	test_delay_slot
test_delay_slot:
	bal	test_delay_slot
/*
	bgezal	$t5, test_delay_slot
	bltzal	$t5, test_delay_slot
	bgezall	$t5, test_delay_slot
	bltzall	$t5, test_delay_slot
	jal	test_delay_slot
	jalx	test_delay_slot
	*/
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
/*
	.ifndef	insn32
	jals	test_delay_slot
	jalrs16	$t4
	jalrs32	$t4
	jrs	$t4
	jalrs.hb	$t4
	jrs.hb	$t4
	.endif
*/
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
