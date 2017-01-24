	.abicalls
	.option	pic0
	.text
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,1			# 0x1
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	.end	f1_a
	.size	f1_a, .-f1_a

	.ent	f1_b
	.type	f1_b, @function
f1_b:
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,2			# 0x2
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	.end	f1_b
	.size	f1_b, .-f1_b

	.ent	f1_c
	.type	f1_c, @function
f1_c:
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	li	$2,3			# 0x3
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	.end	f1_c
	.size	f1_c, .-f1_c

	.globl	func1_ifunc
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	addiu	$sp,$sp,-432
	sw	$31,428($sp)
	sw	$fp,424($sp)
	move	$fp,$sp
	addiu	$2,$fp,28
	move	$4,$2

	beq	$2,$0,$L8

	li	$2,48			# 0x30
	sw	$2,24($fp)
	j	$L9

$L8:
	li	$2,3			# 0x3
	sw	$2,24($fp)
$L9:
	lw	$2,24($fp)
	andi	$2,$2,0xf0
	beq	$2,$0,$L10

	lui	$2,%hi(f1_a)
	addiu	$2,$2,%lo(f1_a)
	j	$L13

$L10:
	lw	$2,24($fp)
	andi	$2,$2,0xf
	beq	$2,$0,$L12

	lui	$2,%hi(f1_b)
	addiu	$2,$2,%lo(f1_b)
	j	$L13

$L12:
	lui	$2,%hi(f1_c)
	addiu	$2,$2,%lo(f1_c)
$L13:
	move	$sp,$fp
	lw	$31,428($sp)
	lw	$fp,424($sp)
	addiu	$sp,$sp,432
	j	$31

	.end	func1_ifunc
	.size	func1_ifunc, .-func1_ifunc
	.globl	func1
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc
