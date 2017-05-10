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

	addiu $31, $31, 5b-3b+1 # [RS5] x += 7
	addiu $2, $2, 2b-5b 	# [RS5] x -= 8
	addiu $4, $5, 5b-2b	# [R2] x = y + 8
	addiu $4, $5, 6b-2b	# [R2] x = y + 28

	addiu $31, $2, 5b-3b+1  # x = y + 3, U16 for reg
	addiu $2, $3, 2b-5b 	# x = y - 4, NEG12 for reg
	addiu $4, $8, 5b-2b	# x = y + 8, U16 for reg
	addiu $4, $2, 6b-2b	# x = y + 28, U16 for reg

	addiu $31, $31, 5b-2b   # x = y + 8, U16 for range
	addiu $2, $2, 2b-6b+16 	# x = y - 12, NEG12 for range
	addiu $4, $5, 2b-5b	# x = y - 8, NEG12 for range
	addiu $4, $5, 7b-2b	# x = y + 30, U16 for range
	addiu $4, $5, 5b-3b	# x = y + 30, U16 for range

	addiu $31, $31, 5f-3f+1 # [RS5] x += 7
	addiu $2, $2, 2f-5f 	# [RS5] x -= 8
	addiu $4, $5, 5f-2f	# [R2] x = y + 8
	addiu $4, $5, 6f-2f	# [R2] x = y + 28

	addiu $31, $2, 5f-3f+1  # x = y + 3, U16 for reg
	addiu $2, $3, 2f-5f 	# x = y - 4, NEG12 for reg
	addiu $4, $8, 5f-2f	# x = y + 8, U16 for reg
	addiu $4, $2, 6f-2f	# x = y + 28, U16 for reg

	addiu $31, $31, 5f-2f   # x = y + 8, U16 for range
	addiu $2, $2, 2f-6f+16 	# x = y - 12, NEG12 for range
	addiu $4, $5, 2f-5f	# x = y - 8, NEG12 for range
	addiu $4, $5, 7f-2f	# x = y + 30, U16 for range
	addiu $4, $5, 5f-3f	# x = y + 30, U16 for range

	addiu32 $31, $31, 5f-3f+1 # x += 7, forced length
	addiu32 $2, $2, 2f-5f 	# x -= 8, forced length
	addiu32 $4, $5, 5f-2f	# x = y + 8, forced length
	addiu32 $4, $5, 6f-2f	# x = y + 28, forced length

	.set insn32
	addiu $31, $31, 5f-3f+1 # x += 7, forced length
	addiu $2, $2, 2f-5f 	# x -= 8, forced length
	addiu $4, $5, 5f-2f	# x = y + 8, forced length
	addiu $4, $5, 6f-2f	# x = y + 28, forced length
	.set noinsn32

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
	nop
	.align
	.space 8
