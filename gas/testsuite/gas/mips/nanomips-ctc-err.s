	.text

	.set noreorder
noreorder:
	b 1f			# bc16
	li $2, 0x1
	b16 1f			# bc16
	li $2, 0x1
	b32 1f			# bc32 (pre-r6 beq32)
	li $2, 0x1

	bal 1f			# balc
	li $2, 0x1

	beqz	$18,1f		# beqzc16 s2,1f [PC7]
	li $18, 0x1
	beqz16 	$18,1f		# beqzc16 s2,1f
	li $18, 0x1

	beq16	$19,$16,ext	# beqzc16 s3,s0,ext [PC7]
	li $2, 0x1
	beq16	$16,$19,ext	# beqzc16 s0,s3,ext
	li $2, 0x1
	beq	$3,$0,ext	# beqzc v1,ext [PC21]
	li $2, 0x1
	beq	$0,$3,ext	# beqzc v1,ext
	li $2, 0x1
	beq	$3,$2,ext	# beqc v0,v1,ext [PC16]
	li $2, 0x1
	beq	$2,$3,ext	# beqc v0,v1,ext
	li $2, 0x1
	beqz16	$19,ext		# beqzc16 s3,ext [PC7]
	li $2, 0x1
	beqzc	$3,ext # compact, no error should be reported
	li $2, 0x1
	bnez	$18,1f		# bnezc16 s2,1f [PC7]
	li $18, 0x1
	bnez16 	$18,1f		# bnezc16 s2,1f
	li $18, 0x1
	bne16	$19,$16,ext	# bnezc16 s3,s0,ext [PC7]
	li $2, 0x1
	bne16	$16,$19,ext	# bnezc16 s0,s3,ext
	li $2, 0x1
	bne	$3,$0,ext	# bnezc v1,ext [PC21]
	li $2, 0x1
	bne	$3,$2,ext	# bnec v0,v1,ext [PC16]
	li $2, 0x1
	bne	$2,$3,ext	# bnec v0,v1,ext
	li $2, 0x1
	bnez16	$19,ext		# bnezc16 s3,ext [PC7]
	li $2, 0x1
	bnezc	$3,ext # compact, no error should be reported
	li $2, 0x1

	      bgez	$2, ext		# bgezc v0,ext
	li $2, 0x1
	      bltz	$2, ext		# bgezc v0,ext
	li $2, 0x1
	      bltzal	$2, ext		# bgezc v0,ext
	li $2, 0x1

	j16	$4		# jrc16 a0
	li $2, 0x1
	jr	$2		# jrc16 v0
	li $2, 0x1
#	jrc32	$2		# jic v0,0
	li $2, 0x1


	j	1f		# bc32
	li $2, 0x1
	j32 	1f		# bc32
	li $2, 0x1

	jal 	1f		# balc

f:
	li $2, 0x1

	j32	$4		# jalrc32/jrc a0
	li $2, 0x1
	jr32	$4		# jalrc32/jrc a0
	li $2, 0x1

	jalr	$4		# jalrc16 a0
	li $2, 0x1
	jalr32	$4		# jalrc a0
	li $2, 0x1
	jalr	$4,$5		# jalrc a0,a1
	li $2, 0x1
	jalr32	$4,$5		# jalrc a0,a1
	li $2, 0x1

	jalr	$2		# jalrc16 v0
	li $2, 0x1
	jalr16	$2		# jalrc16 v0
	li $2, 0x1
	jalr16	$31,$2		# jalrc16 v0
	li $2, 0x1

	jr.hb $4		# jrc.hb a0
	li $2, 0x1
	jalr.hb $4		# jalrc.hb a0
	li $2, 0x1
	jalr.hb $4,$5		# jalrc.hb a0,a1
	li $2, 0x1
	jalr.hb $4,$5		# jalrc.hb a0,a1
	li $2, 0x1

text_label:
	.set noreorder
	j text_label
	.set    reorder
	nop

	.set noreorder
	j text_label
	.set    reorder
	li $2, 0x1

	.set    noreorder
	.set    nomacro
	jal     func1
	sh      $2,36($17)
	.set    macro
	.set    reorder
1:
	nop

	.set    noreorder
	bal 2f
	nop

2:
	bgezal $3, 3f
	nop

3:
	bltzal $3, 4f
	nop

4:
	jal 5f
	nop

5:
	nop

	.align	  2
	.space	  8
