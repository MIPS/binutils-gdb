	.linkrelax
	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	lw	$r2,%gp_rel(var)($gp)
	sw	$r3,%gp_rel(var)($gp)
	.end	__start
	.size	__start, .-__start

	.globl	var
	.section	.sdata,"aw",@progbits
	.align	2
	.type	var, @object
	.size	var, 4
var:
	.word	5
