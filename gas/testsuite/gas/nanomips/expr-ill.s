# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
	.linkrelax
foo:
	jrc $a0
.L3:
	nop
.L4:
	bc .L3
.L2:
	jrc $ra

b:
	.word	(.L4 - .L2) - .L3
	.word	.L3 >> .L4
	.word	(.L2 >> 1) + 3
	.word	(.L2 >> 1):-2
	.word	(.L2 >> 1):.L3
