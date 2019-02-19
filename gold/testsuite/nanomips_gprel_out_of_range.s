	.linkrelax
	.section	.text,"ax",@progbits
	.align	4
	.globl	__start
	.ent	__start
__start:
	lw	$r2,%gprel(var)($gp)
	sw	$r3,%gprel(var)($gp)
	lb	$r6,%gprel(var)($gp)
	lbu	$r7,%gprel(var)($gp)
	lh	$r16,%gprel(var)($gp)
	lhu	$r20,%gprel(var)($gp)
	sb	$r9,%gprel(var)($gp)
	sh	$r13,%gprel(var)($gp)
	addiu.w	$r14,$gp, %gprel(var)
	addiu.b	$r15,$gp, %gprel(var)
	.end	__start
	.size	__start, .-__start

	.globl	var
	.section	.sdata,"aw",@progbits
	.align	2
	.type	var, @object
	.size	var, 4
var:
	.word	5
