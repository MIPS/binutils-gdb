	.linkrelax
	.section	.text,"ax",@progbits
	.align	4
	.globl	__start
	.ent	__start
__start:
	move.balc	$r4,$r16,foo
	.end	__start
	.size	__start, .-__start

	.section	.foo,"ax",@progbits
	.align	4
	.globl	foo
	.ent	foo
foo:
	jrc	$r31
	.end	foo
	.size	foo, .-foo
