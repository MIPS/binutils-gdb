	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	lw	$v0,%gp_rel(var)($gp)
	sw	$v1,%gp_rel(var)($gp)
	lb	$a2,%gp_rel(var)($gp)
	lbu	$a3,%gp_rel(var)($gp)
	lh	$s0,%gp_rel(var)($gp)
	lhu	$s4,%gp_rel(var)($gp)
	sb	$t1,%gp_rel(var)($gp)
	sh	$t5,%gp_rel(var)($gp)
	.end	__start
	.size	__start, .-__start

	.globl	var
	.section	.sdata,"aw",@progbits
	.align	2
	.type	var, @object
	.size	var, 4
var:
	.word	5
