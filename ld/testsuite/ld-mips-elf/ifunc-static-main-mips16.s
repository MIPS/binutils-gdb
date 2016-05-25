	.abicalls
	.option	pic0
	.text
	.align	2
	.globl	main
	.set	mips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	save	32,$17,$31
	addiu	$17,$sp,16
	jal	func1
	move	$sp,$17
	restore	16,$17,$31
	j	$31
	.end	main
	.size	main, .-main
