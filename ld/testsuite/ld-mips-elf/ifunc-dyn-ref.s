	.gnu_attribute 4, 1
	.abicalls
	.text
	.globl	ref1
	.ent	ref1
	.type	ref1, @function
ref1:
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	lw	$2,%call16(func1)($28)
	move	$25,$2
	jalr	$25

	lw	$28,16($fp)
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31

	.end	ref1
	.size	ref1, .-ref1
