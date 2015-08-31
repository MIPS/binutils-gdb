	.file	1 "ifunc_ref.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.option	pic0
	.text
	.align	2
	.globl	ref1
	.set 	mips32r2
	.ent	ref1
	.type	ref1, @function
ref1:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	jal	func1
	nop

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
	.ident	"GCC: (GNU) 4.9.0 20130930 (experimental)"
