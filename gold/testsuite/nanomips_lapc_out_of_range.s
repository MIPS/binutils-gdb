	.linkrelax
	.section	.text,"ax",@progbits
	.align	4
	.globl	__start
	.ent	__start
__start:
	lapc	$r4, foo
	.end	__start
	.size	__start, .-__start

	.section	.foo,"ax",@progbits
	.align	4
	.globl	foo
	.ent	foo
foo:
	jrc	$ra
	.end	foo
	.size	foo, .-foo
