	.linkrelax
	.module	pcrel
	.module	softfloat
	.section	.foo,"ax",@progbits
	.align	4
	.globl	foo
	.ent	foo
foo:
	move	$a0,$zero
	jrc	$ra
	.end	foo
	.size	foo, .-foo
