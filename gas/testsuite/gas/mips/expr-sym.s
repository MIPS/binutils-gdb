# Test representation of various symbolic expressions as relocations.
# This only works for PABI currently.

	.text
foo:
	balc foo
.L3:
	bc foo
.L4:
	lui	$2, %hi(foo)
.L2:

b:
	.word	.L2
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

	.word	(.L2-.L3)
	.hword	(.L2 + 4) - .L4
	.byte	(.L3 - 10) - .L4
