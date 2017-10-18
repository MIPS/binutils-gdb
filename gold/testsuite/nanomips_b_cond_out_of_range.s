	.linkrelax
	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	beqc	$r3,$r4,foo
	bnec	$r5,$r6,foo
	bgec	$r7,$r8,foo
	bltc	$r8,$r7,foo
	bgeuc	$r6,$r23,foo
	bltuc	$r25,$r19,foo
	bbeqzc	$r2,31,foo
	bbnezc	$r15,1,foo
	beqic	$r4,90,foo
	bneic	$r23,2,foo
	bgeic	$r17,1,foo
	bltic	$r2,4,foo
	bgeiuc	$r3,127,foo
	bltiuc	$r24,6,foo
	nop
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
