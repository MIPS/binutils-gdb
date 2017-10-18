	.linkrelax
	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	lw	$a0,%got_page(w)($gp)
	lw	$a1,%got_ofst(w)($a0)
	sw	$a2,%got_ofst(w)($a0)
	.ifndef pcrel
	lw	$a1,%got_page(h)($gp)
	lh	$t0,%got_ofst(h)($a1)
	lhu	$t1,%got_ofst(h)($a1)
	sh	$t2,%got_ofst(h)($a1)
	lw	$a2,%got_page(b)($gp)
	lb	$s0,%got_ofst(b)($a2)
	lbu	$s1,%got_ofst(b)($a2)
	sb	$s2,%got_ofst(b)($a2)
	.endif
	.end	__start
	.size	__start, .-__start

	.globl	b
	.section	.sdata,"aw",@progbits
	.type	b, @object
	.size	b, 1
b:
	.byte	3
	.globl	h
	.align	1
	.type	h, @object
	.size	h, 2
h:
	.half	4
	.globl	w
	.align	2
	.type	w, @object
	.size	w, 4
w:
	.word	5
