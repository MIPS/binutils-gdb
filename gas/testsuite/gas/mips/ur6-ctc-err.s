	.text
	.set micromips
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

	beqz	$2,1f		# beqzc16 v0,1f [PC7]
	li $2, 0x1
	beqz16 	$2,1f		# beqzc16 v0,1f
	li $2, 0x1

	beq16	$3,$0,ext	# beqzc16 v1,ext [PC7]
	li $2, 0x1
	beq16	$0,$3,ext	# beqzc16 v1,ext
	li $2, 0x1
	beq	$3,$0,ext	# beqzc v1,ext [PC21]
	li $2, 0x1
	beq	$0,$3,ext	# beqzc v1,ext
	li $2, 0x1
	beq	$3,$2,ext	# beqc v0,v1,ext [PC16]
	li $2, 0x1
	beq	$2,$3,ext	# beqc v0,v1,ext
	li $2, 0x1
	beqz16	$3,ext		# beqzc16 v1,ext [PC7]
	li $2, 0x1
	beqzc	$3,ext # compact, no error should be reported
	li $2, 0x1
	bnez	$2,1f		# bnezc16 v0,1f [PC7]
	li $2, 0x1
	bnez16 	$2,1f		# bnezc16 v0,1f
	li $2, 0x1
	bne16	$3,$0,ext	# bnezc16 v1,ext [PC7]
	li $2, 0x1
	bne16	$0,$3,ext	# bnezc16 v1,ext
	li $2, 0x1
	bne	$3,$0,ext	# bnezc v1,ext [PC21]
	li $2, 0x1
	bne	$3,$2,ext	# bnec v0,v1,ext [PC16]
	li $2, 0x1
	bne	$2,$3,ext	# bnec v0,v1,ext
	li $2, 0x1
	bnez16	$3,ext		# bnezc16 v1,ext [PC7]
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

# Impossible mappings
	beq  $3, $3, ext # rs must not be equal to rt -> beqzalc
	bne  $3, $3, ext # as above but bnezalc

	beqz  $0, 1b
	bnez  $0, 1b

	bgez  $0, 1b
	bltz  $0, 1b
	bltzal  $0, 1b

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
	jalr	$4		# jalrc16 a0
	nop
	jalr32	$4		# jalrc a0
	nop
	jalr	$4,$5		# jalrc a0,a1
	nop
	jalr32	$4,$5		# jalrc a0,a1
	nop

	jalr	$2		# jalrc16 v0
	nop
	jalr16	$2		# jalrc16 v0
	nop
	jalr16	$31,$2		# jalrc16 v0
	nop

	jalr.hb $4		# jalrc.hb a0
	nop
	jalr.hb $4,$5		# jalrc.hb a0,a1
	nop

	.align	  2
	.space	  8
