	.text
	.set reorder
reorder:
	b 1f			# bc16
	b16 1f			# bc16
	b32 1f			# bc32 (pre-r6 beq32)

	bal 1f			# balc

	beqz	$s2,1f		# beqzc16 s2,1f [PC7]
	beqz32 	$s2,1f		# beqzc32 s2,1f
	beqz16 	$s2,1f		# beqzc16 s2,1f

	beq16	$s3,$a0,ext	# beqzc16 s3,ext [PC7]
	beq16	$a0,$s3,ext	# beqzc16 s3,ext
	beq	$s3,$zero,ext	# beqzc s3,ext [PC21]
	beq	$zero,$s3,ext	# beqzc s3,ext
	beq	$s3,$s2,ext	# beqc s2,s3,ext [PC16]
	beq	$s2,$s3,ext	# beqc s2,s3,ext
	beqz16	$s3,ext		# beqzc16 s3,ext [PC7]
	beqzc	$s3,ext		# beqzc s3,ext [new reloc=PC21]

	bnez	$s2,1f		# bnezc16 s2,1f [PC7]
	bnez32	$s2,1f		# bnezc32 s2,1f [PC7]
	bnez16 	$s2,1f		# bnezc16 s2,1f

	bne16	$s3,$a0,ext	# bnezc16 s3,ext [PC7]
	bne16	$a0,$s3,ext	# bnezc16 s3,ext
	bne	$s3,$zero,ext	# bnezc s3,ext [PC21]
	bne	$zero,$s3,ext	# bnezc s3,ext [PC21]
	bne	$s3,$s2,ext	# bnec s2,s3,ext [PC16]
	bne	$s2,$s3,ext	# bnec s2,s3,ext
	bnez16	$s3,ext		# bnezc16 s3,ext [PC7]
	bnezc	$s3,ext		# bnezc s3,ext [new reloc=PC21]

        bgez	$s2, ext	# bgezc s2,ext
        bltz	$s2, ext	# bgezc s2,ext

	j16	$a0		# jrc16 a0
	jr	$t4		# jrc16 t4

	jrc32	$t4		# jic t4,0
	j	1f		# bc32
	j	0x100		# bc32

	jal 	1f		# balc

	j32	$a0		# jic a0,0
	jr32	$a0		# jic a0,0

	jalr	$a0		# jalrc16 a0

	jalr32	$a0		# jalrc a0
	jalr	$a0,$a1		# jalrc a0,a1
	jalr32	$a0,$a1		# jalrc a0,a1

	jalr	$t4		# jalrc16 t4
	jalr16	$t4		# jalrc16 t4

	jalr16	$ra,$t4		# jalrc16 t4
	jr.hb $a0		# jrc.hb a0
	jalr.hb $a0		# jalrc.hb a0
	jalr.hb $a0,$a1		# jalrc.hb a0,a1

1:
	nop
	.align	2	
	.space	8
