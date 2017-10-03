# Check that general const expression evaluations work as expected
# after introducing special handling for expressions as relocations.

	.text
	.equ sym1,10
	.equ sym2,8
test:
	.dword (0x123 + 4)
	.word (0x100 >> 3)
	.hword (0x123 - 4)
	.byte (0x100 - 0x123)

	.dword (sym1 + 4)
	.word (sym1 >> 3)
	.hword (sym1 - 4)
	.byte (0x100 - sym1)

	.dword ((sym1 + sym2) + 4)
	.word ((sym1 + 1) >> 3)
	.hword ((sym1 >> 4) - 4)
	.byte (0x1 + (sym1 - sym2))

	.dword (0x123 + 4):2
	.word ((sym1 + 1) >> 3):4
