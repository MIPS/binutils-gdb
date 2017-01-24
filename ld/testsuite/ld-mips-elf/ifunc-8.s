	.gnu_attribute 4, 1
	.abicalls
	.text
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	nop
	.end	f1_a
	.size	f1_a, .-f1_a

	.ent	f1_b
	.type	f1_b, @function
f1_b:
	nop
	.end	f1_b
	.size	f1_b, .-f1_b

	.ent	f1_c
	.type	f1_c, @function
f1_c:
	nop
	.end	f1_c
	.size	f1_c, .-f1_c

	.globl	func1_ifunc
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	lw	$2,%got(f1_a)($28)
	addiu	$2,$2,%lo(f1_a)
	lw	$2,%got(f1_b)($28)
	addiu	$2,$2,%lo(f1_b)
	lw	$2,%got(f1_c)($28)
	addiu	$2,$2,%lo(f1_c)
	.end	func1_ifunc
	.size	func1_ifunc, .-func1_ifunc

	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc

	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.cpload	$25
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	.cprestore	16
	lw	$2,%got(func1)($28)
	move	$25,$2
1:	jalr	$25
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31

	.end	main
	.size	main, .-main
