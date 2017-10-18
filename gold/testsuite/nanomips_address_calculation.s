	.linkrelax
	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	lw	$a3,%got_disp(a)($gp)
	.ifdef preword
	lw	$a3,%got_disp(b)($gp)
	.endif
	.end	__start
	.size	__start, .-__start

	.globl	d
	.section	.sdata,"aw",@progbits
	.type	d, @object
	.size	d, 1
d:
	.byte	4
	.globl	c
	.type	c, @object
	.size	c, 1
c:
	.byte	3
	.globl	b
	.type	b, @object
	.size	b, 1
b:
	.byte	2
	.globl	a
	.align	2
	.type	a, @object
	.size	a, 4
a:
	.word	1
