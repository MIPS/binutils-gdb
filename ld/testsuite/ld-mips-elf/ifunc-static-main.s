	.abicalls
	.option	pic0
	.text
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.set	noreorder
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

	.set	reorder
	.end	main
	.size	main, .-main
