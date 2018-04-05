# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
	.linkrelax
foo:
.L3:
	bal foo1
.L4:
	addiu	$t4, $gp,%gprel(foo)
.L2:
	.align 4
	.data
b:
	.word	.L2:2
	.hword	.L3
	.byte	.L4

	.word	.L2 + 2
	.hword	.L3 - 3
	.byte	(.L4 + 4) - 10

	.word	.L2 >> 4
	.hword	(.L3 - 10) >> 2
	.byte	(.L2 - .L4) >> 1

	.word	(.L2 - .L3)
	.hword	(.L2 + 4) - .L4
	.byte	(.L3 - 10) - .L4

	.word	.L4 - (.L2 + 3)
	.word	(.L4 - (.L3 + 5)) >> 3
	.hword	.L3 - ((.L4 + 6) >> 3)
	.byte	((.L3 - ((.L2 + 7) >> 3)) >> 2):3
	.shword	(.L4 + 6) >> 3
	.sbyte	(.L3 - .L2) >> 1
