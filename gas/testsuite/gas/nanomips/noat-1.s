	.set noat
	lw $27, 0x7ff($27)
	lw $27, -0x80($27)
	sw $27, 0x7ff($27)
	sw $27, -0x80($27)

	.space 8
