# Source code used to test %hi/%lo operators with constants worked out
# as a difference of local symbols,both previously defined and forward
# references.

	.text
foo:
	lui	$4,%hi(2f-0f)
	addiu	$4,%lo(2f-0f)
	li	$4,(2f-0f)
	lui	$5,%hi(0f-3f)
	addiu	$5,%lo(0f-3f)
	li	$5,(0f-3f)
0:
	lui	$4,%hi(2f-0b)
	addiu	$4,%lo(2f-0b)
	li	$4,(2f-0b)
	lui	$5,%hi(0b-3f)
	addiu	$5,%lo(0b-3f)
	li	$5,(0b-3f)
1:
	.insn
	.fill	0x7ffc-(1b-0b)
2:
	.insn
	.fill	0x8000-(2b-0b)
3:
	lui	$4,%hi(2b-0b)
	addiu	$4,%lo(2b-0b)
	li	$4,(2b-0b)
	lui	$5,%hi(0b-3b)
	addiu	$5,%lo(0b-3b)
	li	$5,(3b-0b)

	lui	$4,%hi(2f-0f)
	addiu	$4,%lo(2f-0f)
	li	$4,(2f-0f)
	lui	$5,%hi(0f-3f)
	addiu	$5,%lo(0f-3f)
	li	$5,(0f-3f)
0:
	lui	$4,%hi(2f-0b)
	addiu	$4,%lo(2f-0b)
	li	$4,(2f-0b)
	lui	$5,%hi(0b-3f)
	addiu	$5,%lo(0b-3f)
	li	$5,(0b-3f)
1:
	.insn
	.fill	0x8000-(1b-0b)
2:
	.insn
	.fill	0x8004-(2b-0b)
3:
	lui	$4,%hi(2b-0b)
	addiu	$4,%lo(2b-0b)
	li	$4,(2b-0b)
	lui	$5,%hi(0b-3b)
	addiu	$5,%lo(0b-3b)
	li	$5,(0b-3b)

	lui	$4,%hi(2f-0f)
	addiu	$4,%lo(2f-0f)
	li	$4,(2f-0f)
	lui	$5,%hi(0f-3f)
	addiu	$5,%lo(0f-3f)
	li	$5,(0f-3f)
0:
	lui	$4,%hi(2f-0b)
	addiu	$4,%lo(2f-0b)
	li	$4,(2f-0b)
	lui	$5,%hi(0b-3f)
	addiu	$5,%lo(0b-3f)
	li	$5,(0b-3f)
1:
	.insn
	.fill	0x11ffdc-(1b-0b)
2:
	.insn
	.fill	0
3:
	lui	$4,%hi(2b-0b)
	addiu	$4,%lo(2b-0b)
	li	$4,(2b-0b)
	lui	$5,%hi(0b-3b)
	addiu	$5,%lo(0b-3b)
	li	$5,(0b-3b)
