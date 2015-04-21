# relocs against undefined weak symbols should not be treated as
# overflowing

	.module mips64r2
	.globl	start
	.weak	foo
start:
	.set noreorder
	b	foo
	nop
	bal	foo
	lui	$4, %gp_rel(foo)

	jal	foo
	nop
	j	foo
	nop

	.set micromips
micro:
	beqz16	$4, foo
	nop
	b16	foo
	nop
	b	foo
	nop
	bal	foo
	nop

	jal	foo
	nop
	j	foo
	nop

	.set nomicromips
	.set mips16
mips16:
	b	foo

	jal	foo
	nop
