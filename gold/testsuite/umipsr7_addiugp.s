	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	addiu	$a0,$gp, %gp_rel(b)
	.end	__start
	.size	__start, .-__start

	.globl	a
	.section	.sdata,"aw",@progbits
	.type	a, @object
	.size	a, 1
a:
	.byte	2
	.globl	b
	.type	b, @object
	.size	b, 1
b:
	.byte	1
