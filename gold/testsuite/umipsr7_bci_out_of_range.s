	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	beqic	$a0,90,foo
	bgeic	$s1,1,foo
	bgeuic	$v1,127,foo
	bltic	$v0,4,foo
	bltuic	$t8,6,foo
	bneic	$s7,2,foo
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
