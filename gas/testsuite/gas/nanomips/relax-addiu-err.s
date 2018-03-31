	/* Check for overflow errors in addiu relaxation.  */
	.text
foo:
1:
	.space 0x10004
2:
	addiu $a0, $a1, (1b - 2b)	# [48] same register, backward negative
	addiu $a0, $a1, (2b - 1b)	# [48] same register, backward positive
	addiu $a0, $a1, (3f - 4f)	# [48] same register, forward negative
	addiu $a0, $a1, (4f - 3f)	# [48] same register, forward positive
3:
	.space 0x10004
4:
