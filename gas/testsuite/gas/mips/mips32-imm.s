# Source file to test wide immediates with MIPS32 WAIT and SDBBP instructions

	.set noreorder
	.set noat

	.text
text_label:

	# 20 bits accepted for MIPS32
	.ifdef r7
	# wait operand is 10 bits for R7
	wait	0x367
	.else
	wait	0x56789
	.endif
	sdbbp	0x56789

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.space	8
