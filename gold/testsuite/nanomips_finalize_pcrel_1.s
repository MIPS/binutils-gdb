	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	balc	foo
	bc	foo
	move.balc	$r4,$r16,foo
	bnec	$r4, $r5, foo
	beqic	$r4,90,foo
	bgeic	$r17,1,foo
	bgeiuc	$r3,127,foo
	bltic	$r2,4,foo
	bltiuc	$r24,6,foo
	bneic	$r23,2,foo
	balc16	foo
	bc16	foo
	bnec16	$r4,$r5,foo
	beqc16	$r5,$r4,foo
	nop
	.end	__start
	.size	__start, .-__start
