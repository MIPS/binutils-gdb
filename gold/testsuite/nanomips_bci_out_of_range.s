	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	beqic	$r4,90,foo
	bgeic	$r17,1,foo
	bgeiuc	$r3,127,foo
	bltic	$r2,4,foo
	bltiuc	$r24,6,foo
	bneic	$r23,2,foo
	.end	__start
	.size	__start, .-__start

	.section	.foo,"ax",@progbits
	.align	1
	.globl	foo
	.ent	foo
foo:
	jrc	$ra
	.end	foo
	.size	foo, .-foo
