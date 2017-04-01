# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
	.ifdef r7
	.linkrelax
	.endif
foo:
	jrc $4
.L3:
	nop
.L4:
	bc .L3
.L2:
	jrc $31

b:
	.word	(.L4 - .L2) - .L3
	.word	.L3 >> .L4
	.word	(.L2 >> 1) + 3
	.word	(.L2 >> 1):-2
	.word	(.L2 >> 1):.L3
