	/* Check addiu relaxation to 48-bits.  */
	.text
foo:
1:
	.space 0x10004
2:
	addiu $a0, $a0, (1b - 2b)	# [48] same register, backward negative
	addiu $a0, $a0, (2b - 1b)	# [48] same register, backward positive
	li $a0, (3f - 4f)		# [48] LI negative
	li $a0, (4f - 3f)		# [48] LI positive
	addiu $a0, $a0, (3f - 4f)	# [48] same register, forward negative
	addiu $a0, $a0, (4f - 3f)	# [48] same register, forward positive
	li $a0, (3f - 4f)		# [48] LI negative
	li $a0, (4f - 3f)		# [48] LI positive
3:
	.space 0x10004
4:
