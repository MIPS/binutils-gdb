	.section .mdebug.abi32
	.previous
	.nan	legacy
	.gnu_attribute 4, 1
	.abicalls
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	nop

	.set	macro
	.set	reorder
	.end	f1_a
	.size	f1_a, .-f1_a
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	f1_b
	.type	f1_b, @function
f1_b:
	nop

	.set	macro
	.set	reorder
	.end	f1_b
	.size	f1_b, .-f1_b
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	f1_c
	.type	f1_c, @function
f1_c:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	nop

	.set	macro
	.set	reorder
	.end	f1_c
	.size	f1_c, .-f1_c
	.align	2
	.globl	func1_ifunc
	.set	nomips16
	.set	nomicromips
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	lw	$2,%got(f1_a)($28)
	addiu	$2,$2,%lo(f1_a)
	lw	$2,%got(f1_b)($28)
	addiu	$2,$2,%lo(f1_b)
	lw	$2,%got(f1_c)($28)
	addiu	$2,$2,%lo(f1_c)
	nop

	.set	macro
	.set	reorder
	.end	func1_ifunc
	.size	func1_ifunc, .-func1_ifunc
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc

	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.globl	main
	.ent	main
	.type	main, @function
main:
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
	lw	$2,%got16(func1)($28)
	move	$25,$2
	jalr	$25
	nop

	lui	$2,%hi(func1)
	addiu	$2, $2, %lo(func1)
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
	.end	main
	.size	main, .-main
	.section	.data.rel,"aw",@progbits
	.align	2
	.type	fptr, @object
	.size	fptr, 4
fptr:
	.word	func1
	.ident	"GCC: (GNU) 4.9.0 20130930 (experimental)"
