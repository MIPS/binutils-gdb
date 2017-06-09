	.text

	.set noreorder
noreorder:
	b 1f			# bc16
	li $t4, 0x1
	b16 1f			# bc16
	li $t4, 0x1
	b32 1f			# bc32 (pre-r6 beq32)
	li $t4, 0x1

	bal 1f			# balc
	li $t4, 0x1

	beqz	$s2,1f		# beqzc16 s2,1f [PC7]
	li $s2, 0x1
	beqz16 	$s2,1f		# beqzc16 s2,1f
	li $s2, 0x1

	beq16	$s3,$s0,ext	# beqzc16 s3,s0,ext [PC7]
	li $t4, 0x1
	beq16	$s0,$s3,ext	# beqzc16 s0,s3,ext
	li $t4, 0x1
	beq	$t5,$zero,ext	# beqzc v1,ext [PC21]
	li $t4, 0x1
	beq	$zero,$t5,ext	# beqzc v1,ext
	li $t4, 0x1
	beq	$t5,$t4,ext	# beqc v0,v1,ext [PC16]
	li $t4, 0x1
	beq	$t4,$t5,ext	# beqc v0,v1,ext
	li $t4, 0x1
	beqz16	$s3,ext		# beqzc16 s3,ext [PC7]
	li $t4, 0x1
	beqzc	$t5,ext # compact, no error should be reported
	li $t4, 0x1
	bnez	$s2,1f		# bnezc16 s2,1f [PC7]
	li $s2, 0x1
	bnez16 	$s2,1f		# bnezc16 s2,1f
	li $s2, 0x1
	bne16	$s3,$s0,ext	# bnezc16 s3,s0,ext [PC7]
	li $t4, 0x1
	bne16	$s0,$s3,ext	# bnezc16 s0,s3,ext
	li $t4, 0x1
	bne	$t5,$zero,ext	# bnezc v1,ext [PC21]
	li $t4, 0x1
	bne	$t5,$t4,ext	# bnec v0,v1,ext [PC16]
	li $t4, 0x1
	bne	$t4,$t5,ext	# bnec v0,v1,ext
	li $t4, 0x1
	bnez16	$s3,ext		# bnezc16 s3,ext [PC7]
	li $t4, 0x1
	bnezc	$t5,ext # compact, no error should be reported
	li $t4, 0x1

	      bgez	$t4, ext		# bgezc v0,ext
	li $t4, 0x1
	      bltz	$t4, ext		# bgezc v0,ext
	li $t4, 0x1
	      bltzal	$t4, ext		# bgezc v0,ext
	li $t4, 0x1

	j16	$a0		# jrc16 a0
	li $t4, 0x1
	jr	$t4		# jrc16 v0
	li $t4, 0x1
#	jrc32	$t4		# jic v0,0
	li $t4, 0x1


	j	1f		# bc32
	li $t4, 0x1
	j32 	1f		# bc32
	li $t4, 0x1

	jal 	1f		# balc

f:
	li $t4, 0x1

	j32	$a0		# jalrc32/jrc a0
	li $t4, 0x1
	jr32	$a0		# jalrc32/jrc a0
	li $t4, 0x1

	jalr	$a0		# jalrc16 a0
	li $t4, 0x1
	jalr32	$a0		# jalrc a0
	li $t4, 0x1
	jalr	$a0,$a1		# jalrc a0,a1
	li $t4, 0x1
	jalr32	$a0,$a1		# jalrc a0,a1
	li $t4, 0x1

	jalr	$t4		# jalrc16 v0
	li $t4, 0x1
	jalr16	$t4		# jalrc16 v0
	li $t4, 0x1
	jalr16	$ra,$t4		# jalrc16 v0
	li $t4, 0x1

	jr.hb $a0		# jrc.hb a0
	li $t4, 0x1
	jalr.hb $a0		# jalrc.hb a0
	li $t4, 0x1
	jalr.hb $a0,$a1		# jalrc.hb a0,a1
	li $t4, 0x1
	jalr.hb $a0,$a1		# jalrc.hb a0,a1
	li $t4, 0x1

text_label:
	.set noreorder
	j text_label
	.set    reorder
	nop

	.set noreorder
	j text_label
	.set    reorder
	li $t4, 0x1

	.set    noreorder
	.set    nomacro
	jal     func1
	sh      $t4,36($s1)
	.set    macro
	.set    reorder
1:
	nop

	.set    noreorder
	bal 2f
	nop

2:
	bgezal $t5, 3f
	nop

3:
	bltzal $t5, 4f
	nop

4:
	jal 5f
	nop

5:
	nop

	.align	  2
	.space	  8
