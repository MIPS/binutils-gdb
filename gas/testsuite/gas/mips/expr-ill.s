# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
foo:
	jrc $4
.L3:
	nop
.L4:
	bc .L3
.L2:
	jrc $31

b:
	.word	.L3 - (.L4 - .L2)
	.word	.L3 >> .L4
	.word	(.L2 >> 1) + 3
