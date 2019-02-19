	.linkrelax
	.globl	a
	.section	.sdata.a,"aw",@progbits
	.type	a, @object
	.size	a, 1
a:
	.byte	6
	.globl	b
	.section	.sdata.b,"aw",@progbits
	.align	2
	.type	b, @object
	.size	b, 4
b:
	.word	5
	.globl	c
	.section	.sdata.c,"aw",@progbits
	.align	2
	.type	c, @object
	.size	c, 4
c:
	.word	7
	.globl	d
	.section	.sdata.d,"aw",@progbits
	.align	2
	.type	d, @object
	.size	d, 4
d:
	.word	8
	.globl	e
	.section	.sdata.e,"aw",@progbits
	.align	1
	.type	e, @object
	.size	e, 2
e:
	.half	9
	.text
	.align	4
	.globl	__start
	.ent	__start
__start:
	lbu	$r18,%gprel(a)($gp)
	lw	$r18,%gprel(b)($gp)
	lw	$r18,%gprel(c)($gp)
	lw	$r18,%gprel(c)($gp)
	lw	$r18,%gprel(c)($gp)
	lw	$r18,%gprel(d)($gp)
	lw	$r18,%gprel(d)($gp)
	lw	$r2,%gprel(c)($gp)
	lw	$r2,%gprel(c)($gp)
	sw	$r18,%gprel(d)($gp)
	sw	$r18,%gprel(d)($gp)
	lh	$r18,%gprel(e)($gp)
	.end	__start
	.size	__start, .-__start
