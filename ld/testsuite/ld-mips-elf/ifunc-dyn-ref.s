	.gnu_attribute 4, 1
	.abicalls
	.text
	.align	2
	.globl	ref1
	.set	nomips16
	.set	nomicromips
	.ent	ref1
	.type	ref1, @function
ref1:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	.cprestore	16
	lw	$2,%call16(func1)($28)
	move	$25,$2
	jalr	$25
	nop

	lw	$28,16($fp)
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	ref1
	.size	ref1, .-ref1
