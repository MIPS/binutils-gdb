	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	move.balc	$a0,$s0,foo
	.end	__start
	.size	__start, .-__start

	.section	.foo,"ax",@progbits
	.align	1
	.globl	foo
	.ent	foo
foo:
	jrc	$31
	.end	foo
	.size	foo, .-foo
