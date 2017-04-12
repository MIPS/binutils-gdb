# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
foo:
	bal foo
.L3:
	b foo
.L4:
	lui	$2, %hi(foo)
.L2:
	.align 4
b:
	.word	.L2:2
	.hword	.L3
	.ifdef r7
	.byte	.L4
	.endif

	.word	.L2 + 2
	.hword	.L3 - 3
	.ifdef r7
	.byte	(.L4 + 4) - 10
	.endif

	.ifdef r7
	.word	.L2 >> 4
	.hword	(.L3 - 10) >> 2
	.endif
	.byte	(.L2 - .L4) >> 1

	.word	(.L2 - .L3)
	.hword	(.L2 + 4) - .L4
	.byte	(.L3 - 10) - .L4

	.word	.L4 - (.L2 + 3)
	.ifdef r7
	.word	(.L4 - (.L3 + 5)) >> 3
	.hword	.L3 - ((.L4 + 6) >> 3)
	.byte	((.L3 - ((.L2 + 7) >> 3)) >> 2):3
	.shword	(.L4 + 6) >> 3
	.sbyte	(.L3 - .L2) >> 1
	.endif
