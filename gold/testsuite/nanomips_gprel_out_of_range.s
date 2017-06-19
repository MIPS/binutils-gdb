	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	lw	$r2,%gp_rel(var)($gp)
	sw	$r3,%gp_rel(var)($gp)
	lb	$r6,%gp_rel(var)($gp)
	lbu	$r7,%gp_rel(var)($gp)
	lh	$r16,%gp_rel(var)($gp)
	lhu	$r20,%gp_rel(var)($gp)
	sb	$r9,%gp_rel(var)($gp)
	sh	$r13,%gp_rel(var)($gp)
	addiu.w	$r14,$gp, %gp_rel(var)
	addiu.b	$r15,$gp, %gp_rel(var)
	.end	__start
	.size	__start, .-__start

	.globl	var
	.section	.sdata,"aw",@progbits
	.align	2
	.type	var, @object
	.size	var, 4
var:
	.word	5
