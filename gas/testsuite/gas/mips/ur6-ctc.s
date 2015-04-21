	.text
	.set micromips

	.set reorder
reorder:
	b 1f			# bc16
	b16 1f			# bc16
	b32 1f			# bc32 (pre-r6 beq32)

	bal 1f			# balc

	beqz	$2,1f		# beqzc16 v0,1f [PC7]
	beqz32 	$2,1f		# beqzc32 v0,1f
	beqz16 	$2,1f		# beqzc16 v0,1f

	beq16	$3,$0,ext	# beqzc16 v1,ext [PC7]
	beq16	$0,$3,ext	# beqzc16 v1,ext
	beq	$3,$0,ext	# beqzc v1,ext [PC21]
	beq	$0,$3,ext	# beqzc v1,ext
	beq	$3,$2,ext	# beqc v0,v1,ext [PC16]
	beq	$2,$3,ext	# beqc v0,v1,ext
	beqz16	$3,ext		# beqzc16 v1,ext [PC7]
	beqzc	$3,ext		# beqzc v1,ext [new reloc=PC21]

	bnez	$2,1f		# bnezc16 v0,1f [PC7]
	bnez32	$2,1f		# bnezc32 v0,1f [PC7]
	bnez16 	$2,1f		# bnezc16 v0,1f

	bne16	$3,$0,ext	# bnezc16 v1,ext [PC7]
	bne16	$0,$3,ext	# bnezc16 v1,ext
	bne	$3,$0,ext	# bnezc v1,ext [PC21]
	bne	$0,$3,ext	# bnezc v1,ext [PC21]
	bne	$3,$2,ext	# bnec v0,v1,ext [PC16]
	bne	$2,$3,ext	# bnec v0,v1,ext
	bnez16	$3,ext		# bnezc16 v1,ext [PC7]
	bnezc	$3,ext		# bnezc v1,ext [new reloc=PC21]

	bgez	$2, ext		# bgezc v0,ext
	bltz	$2, ext		# bgezc v0,ext
	bltzal	$2, ext		# bltzalc v0,ext
	bgezal	$2, ext		# bgezalc v0,ext

	j16	$4		# jrc16 a0
	jr	$2		# jrc16 v0
	jrc32	$2		# jic v0,0


	j	1f		# bc32
	j32 	1f		# bc32

	jal 	1f		# balc

	j32	$4		# jic a0,0
	jr32	$4		# jic a0,0

	jalr	$4		# jalrc16 a0
	jalr32	$4		# jalrc a0
	jalr	$4,$5		# jalrc a0,a1
	jalr32	$4,$5		# jalrc a0,a1

	jalr	$2		# jalrc16 v0
	jalr16	$2		# jalrc16 v0
	jalr16	$31,$2		# jalrc16 v0

	jr.hb $4		# jrc.hb a0
	jalr.hb $4		# jalrc.hb a0
	jalr.hb $4,$5		# jalrc.hb a0,a1

	jraddiusp 32		# jrcaddiusp

	.set noreorder
noreorder:
	b 1f			# bc
	nop
	b16 1f			# bc16
	nop
	b32 1f			# bc32 (pre-r6 beq32)
	nop

	beqz	$2,1f		# beqzc16 v0,1f [PC7]
	nop
	beqz32 	$2,1f		# beqzc32 v0,1f
	nop
	beqz16 	$2,1f		# beqzc16 v0,1f
	nop

	beq16	$3,$0,ext	# beqzc16 v1,ext [PC7]
	nop
	beq16	$0,$3,ext	# beqzc16 v1,ext
	nop
	beq	$3,$0,ext	# beqzc v1,ext [PC21]
	nop
	beq	$0,$3,ext	# beqzc v1,ext
	nop
	beq	$3,$2,ext	# beqc v0,v1,ext [PC16]
	nop
	beq	$2,$3,ext	# beqc v0,v1,ext
	nop
	beqz16	$3,ext		# beqzc16 v1,ext [PC7]
	nop
	beqzc	$3,ext		# beqzc v1,ext [new reloc=PC21]
	nop

	bnez	$2,1f		# bnezc16 v0,1f [PC7]
	nop
	bnez32	$2,1f		# bnezc32 v0,1f [PC7]
	nop
	bnez16 	$2,1f		# bnezc16 v0,1f
	nop

	bne16	$3,$0,ext	# bnezc16 v1,ext [PC7]
	nop
	bne16	$0,$3,ext	# bnezc16 v1,ext
	nop
	bne	$3,$0,ext	# bnezc v1,ext [PC21]
	nop
	bne	$3,$2,ext	# bnec v0,v1,ext [PC16]
	nop
	bne	$2,$3,ext	# bnec v0,v1,ext
	nop
	bnez16	$3,ext		# bnezc16 v1,ext [PC7]
	nop
	bnezc	$3,ext		# bnezc v1,ext [new reloc=PC21]
	nop

	bgez	$2, ext		# bgezc v0,ext
	nop
	bltz	$2, ext		# bgezc v0,ext
	nop

	j16	$4		# jrc16 a0
	nop
	jr	$2		# jrc16 v0
	nop
	jrc32	$2		# jic v0,0
	nop

	j	1f		# bc32
	nop
	j32 	1f		# bc32
	nop

	j32	$4		# jic a0,0
	nop
	jr32	$4		# jic a0,0
	nop

	jr.hb $4		# jrc.hb a0
	nop

	jraddiusp 32		# jrcaddiusp
	li	$2, 0xf		# jraddiusp has no DS

1:
	nop
	.align	2
	.space	8
