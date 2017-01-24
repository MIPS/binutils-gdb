	.abicalls
	.option	pic0
	.text
	.globl	main
	.ent	main
	.type	main, @function
main:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	jal	func1

	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31

	.end	main
	.size	main, .-main
