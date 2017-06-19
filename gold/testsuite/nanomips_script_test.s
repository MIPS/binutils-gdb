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
	.align	1
	.globl	__start
	.ent	__start
__start:
	lbu	$r18,%gp_rel(a)($gp)
	lw	$r18,%gp_rel(b)($gp)
	lw	$r18,%gp_rel(c)($gp)
	lw	$r18,%gp_rel(c)($gp)
	lw	$r18,%gp_rel(c)($gp)
	lw	$r18,%gp_rel(d)($gp)
	lw	$r18,%gp_rel(d)($gp)
	lw	$r2,%gp_rel(c)($gp)
	lw	$r2,%gp_rel(c)($gp)
	sw	$r18,%gp_rel(d)($gp)
	sw	$r18,%gp_rel(d)($gp)
	lh	$r18,%gp_rel(e)($gp)
	.end	__start
	.size	__start, .-__start
