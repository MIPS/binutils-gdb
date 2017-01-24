	.abicalls
	.option	pic0
	.text
	.globl	ref1
	.set 	mips32r2
	.ent	ref1
	.type	ref1, @function
ref1:
	jal	func1
	j	$31
	.end	ref1
	.size	ref1, .-ref1
