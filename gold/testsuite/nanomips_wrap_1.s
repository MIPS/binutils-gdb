	.linkrelax
	.module	pcrel
	.module	softfloat
	.section	.text,"ax",@progbits
	.align	4
	.globl	__start
	.ent	__start
__start:
	bc	foo
	.end	__start
	.size	__start, .-__start
	.align	4
	.globl	__wrap_foo
	.ent	__wrap_foo
__wrap_foo:
	bc	__real_foo
	.end	__wrap_foo
	.size	__wrap_foo, .-__wrap_foo
