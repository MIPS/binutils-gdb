	.text
foo:
2:	
	nop
3:
	nop
4:
	nop32
5:
	.space 20
6:
	nop
7:	

	addiu $ra, $ra, 5b-3b+1 # [RS5] x += 7
	addiu $t4, $t4, 2b-5b 	# [RS5] x -= 8
	addiu $a0, $a1, 5b-2b	# [R2] x = y + 8
	addiu $a0, $a1, 6b-2b	# [R2] x = y + 28

	addiu $ra, $t4, 5b-3b+1  # x = y + 3, U16 for reg
	addiu $t4, $t5, 2b-5b 	# x = y - 4, NEG12 for reg
	addiu $a0, $a4, 5b-2b	# x = y + 8, U16 for reg
	addiu $a0, $t4, 6b-2b	# x = y + 28, U16 for reg

	addiu $ra, $ra, 5b-2b   # x = y + 8, U16 for range
	addiu $t4, $t4, 2b-6b+16 	# x = y - 12, NEG12 for range
	addiu $a0, $a1, 2b-5b	# x = y - 8, NEG12 for range
	addiu $a0, $a1, 7b-2b	# x = y + 30, U16 for range
	addiu $a0, $a1, 5b-3b	# x = y + 30, U16 for range

	addiu $ra, $ra, 5f-3f+1 # [RS5] x += 7
	addiu $t4, $t4, 2f-5f 	# [RS5] x -= 8
	addiu $a0, $a1, 5f-2f	# [R2] x = y + 8
	addiu $a0, $a1, 6f-2f	# [R2] x = y + 28

	addiu $ra, $t4, 5f-3f+1  # x = y + 3, U16 for reg
	addiu $t4, $t5, 2f-5f 	# x = y - 4, NEG12 for reg
	addiu $a0, $a4, 5f-2f	# x = y + 8, U16 for reg
	addiu $a0, $t4, 6f-2f	# x = y + 28, U16 for reg

	addiu $ra, $ra, 5f-2f   # x = y + 8, U16 for range
	addiu $t4, $t4, 2f-6f+16 	# x = y - 12, NEG12 for range
	addiu $a0, $a1, 2f-5f	# x = y - 8, NEG12 for range
	addiu $a0, $a1, 7f-2f	# x = y + 30, U16 for range
	addiu $a0, $a1, 5f-3f	# x = y + 30, U16 for range

	addiu32 $ra, $ra, 5f-3f+1 # x += 7, forced length
	addiu32 $t4, $t4, 2f-5f 	# x -= 8, forced length
	addiu32 $a0, $a1, 5f-2f	# x = y + 8, forced length
	addiu32 $a0, $a1, 6f-2f	# x = y + 28, forced length

	.set insn32
	addiu $ra, $ra, 5f-3f+1 # x += 7, forced length
	addiu $t4, $t4, 2f-5f 	# x -= 8, forced length
	addiu $a0, $a1, 5f-2f	# x = y + 8, forced length
	addiu $a0, $a1, 6f-2f	# x = y + 28, forced length
	.ifndef insn32
	.set noinsn32
	.endif

	/* LI relaxation */
	li    $a0, 7f-8f		# [16] x = -1
	li    $a0, 6f-2f		# [16] x = 28

	li    $t5, 7f-8f		# [16] x = -8, U16 for reg
	li    $t5, 6f-2f		# [16] x = 28, U16 for reg

	li    $a0, 2f-5f		# [16] x = -8, NEG12 for range
	li    $a0, 9f-8f		# [16] x = 128, U16 for range

	li32    $a0, 7f-8f	# [16] x = -1, forced length
	li32    $a0, 6f-2f	# [16] x = 28, forced length

	.set insn32
	li    $a0, 7f-8f		# [16] x = -1, forced length
	li    $a0, 6f-2f		# [16] x = 28, forced length
	.ifndef insn32
	.set noinsn32
	.endif
2:	
	nop
3:
	nop
4:
	nop32
5:
	.space 20
6:
	nop
7:
	.byte 0
8:
	.space 127
9:
	nop
	.align
	.space 8
