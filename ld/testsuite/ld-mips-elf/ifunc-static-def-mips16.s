	.abicalls
	.option	pic0
	.text

	.align	2

	.set	mips16
	.set	nomicromips
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	move	$17,$sp
	li	$2,1
	move	$sp,$17
	restore	8,$17
	j	$31
	.end	f1_a

	.size	f1_a, .-f1_a
	.align	2
	.set	mips16
	.set	nomicromips
	.ent	f1_b
	.type	f1_b, @function
f1_b:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	move	$17,$sp
	li	$2,2
	move	$sp,$17
	restore	8,$17
	j	$31
	.end	f1_b

	.size	f1_b, .-f1_b
	.align	2
	.set	mips16
	.set	nomicromips
	.ent	f1_c
	.type	f1_c, @function
f1_c:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	move	$17,$sp
	li	$2,3
	move	$sp,$17
	restore	8,$17
	j	$31
	.end	f1_c
	.size	f1_c, .-f1_c

	.comm	global,4,4
	.globl	result
	.data
	.align	2
	.type	result, @object
	.size	result, 4
result:
	.word	6
	.text
	.align	2
	.globl	func1_ifunc
	.set	mips16
	.set	nomicromips
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	.frame	$17,24,$31		# vars= 8, regs= 1/0, args= 0, gp= 8
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	24,$17
	move	$17,$sp
	lw	$2,$L13
	lw	$2,0($2)
	beqz	$2,$L8
	li	$2,48
	sw	$2,8($17)
	b	$L9
$L8:
	li	$2,3
	sw	$2,8($17)
$L9:
	lw	$3,8($17)
	li	$2,240
	and	$2,$3
	beqz	$2,$L10
	lw	$2,$L14
	b	$L11
$L10:
	lw	$3,8($17)
	li	$2,15
	and	$2,$3
	beqz	$2,$L12
	lw	$2,$L15
	b	$L11
$L12:
	lw	$2,$L16
$L11:
	move	$sp,$17
	restore	24,$17
	j	$31
	.align	2
$L13:
	.word	global
$L14:
	.word	f1_a
$L15:
	.word	f1_b
$L16:
	.word	f1_c
	.end	func1_ifunc

	.size	func1_ifunc, .-func1_ifunc
	.globl	func1
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc
