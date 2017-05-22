	.text
	.set micromips

	.set reorder
reorder:
	b 1f			# bc16
	b16 1f			# bc16
	b32 1f			# bc32 (pre-r6 beq32)

	bal 1f			# balc

	beqz	$18,1f		# beqzc16 s2,1f [PC7]
	beqz32 	$18,1f		# beqzc32 s2,1f
	beqz16 	$18,1f		# beqzc16 s2,1f

	beq16	$19,$4,ext	# beqzc16 s3,ext [PC7]
	beq16	$4,$19,ext	# beqzc16 s3,ext
	beq	$19,$0,ext	# beqzc s3,ext [PC21]
	beq	$0,$19,ext	# beqzc s3,ext
	beq	$19,$18,ext	# beqc s2,s3,ext [PC16]
	beq	$18,$19,ext	# beqc s2,s3,ext
	beqz16	$19,ext		# beqzc16 s3,ext [PC7]
	beqzc	$19,ext		# beqzc s3,ext [new reloc=PC21]

	bnez	$18,1f		# bnezc16 s2,1f [PC7]
	bnez32	$18,1f		# bnezc32 s2,1f [PC7]
	bnez16 	$18,1f		# bnezc16 s2,1f

	bne16	$19,$4,ext	# bnezc16 s3,ext [PC7]
	bne16	$4,$19,ext	# bnezc16 s3,ext
	bne	$19,$0,ext	# bnezc s3,ext [PC21]
	bne	$0,$19,ext	# bnezc s3,ext [PC21]
	bne	$19,$18,ext	# bnec s2,s3,ext [PC16]
	bne	$18,$19,ext	# bnec s2,s3,ext
	bnez16	$19,ext		# bnezc16 s3,ext [PC7]
	bnezc	$19,ext		# bnezc s3,ext [new reloc=PC21]

        bgez	$18, ext	# bgezc s2,ext
        bltz	$18, ext	# bgezc s2,ext

	j16	$4		# jrc16 a0
	jr	$2		# jrc16 v0

	jrc32	$2		# jic v0,0
	j	1f		# bc32
	j	0x100		# bc32

	jal 	1f		# balc

	j32	$4		# jic a0,0
	jr32	$4		# jic a0,0

	jalr	$4		# jalrc16 a0

	jalr32	$4		# jalrc a0
	jalr	$4,$5		# jalrc a0,a1
	jalr32	$4,$5		# jalrc a0,a1

	jalr	$2		# jalrc16 v0
	jalr16	$2		# jalrc16 v0

	jalr16	$31,$v0		# jalrc16 v0
	jr.hb $4		# jrc.hb a0
	jalr.hb $4		# jalrc.hb a0
	jalr.hb $4,$5		# jalrc.hb a0,a1

	jraddiusp 32		# jrcaddiusp

1:
	nop
	.align	2	
	.space	8
