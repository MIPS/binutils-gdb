	.abicalls
	.option	pic0
	.text
	.align	2
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,1			# 0x1
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	f1_a
	.size	f1_a, .-f1_a
	.align	2
	.ent	f1_b
	.type	f1_b, @function
f1_b:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,2			# 0x2
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	f1_b
	.size	f1_b, .-f1_b
	.align	2
	.ent	f1_c
	.type	f1_c, @function
f1_c:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,3			# 0x3
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	f1_c
	.size	f1_c, .-f1_c
	.align	2
	.globl	func1_ifunc
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	.frame	$fp,432,$31		# vars= 400, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-432
	sw	$31,428($sp)
	sw	$fp,424($sp)
	move	$fp,$sp
	addiu	$2,$fp,28
	move	$4,$2
	nop

	beq	$2,$0,$L8
	nop

	li	$2,48			# 0x30
	sw	$2,24($fp)
	j	$L9
	nop

$L8:
	li	$2,3			# 0x3
	sw	$2,24($fp)
$L9:
	lw	$2,24($fp)
	andi	$2,$2,0xf0
	beq	$2,$0,$L10
	nop

	lui	$2,%hi(f1_a)
	addiu	$2,$2,%lo(f1_a)
	j	$L13
	nop

$L10:
	lw	$2,24($fp)
	andi	$2,$2,0xf
	beq	$2,$0,$L12
	nop

	lui	$2,%hi(f1_b)
	addiu	$2,$2,%lo(f1_b)
	j	$L13
	nop

$L12:
	lui	$2,%hi(f1_c)
	addiu	$2,$2,%lo(f1_c)
$L13:
	move	$sp,$fp
	lw	$31,428($sp)
	lw	$fp,424($sp)
	addiu	$sp,$sp,432
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	func1_ifunc
	.size	func1_ifunc, .-func1_ifunc
	.globl	func1
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc
