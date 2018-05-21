	.linkrelax
	.section	.text,"ax",@progbits
	.align	4
	.globl	__start
	.ent	__start
__start:
	lw	$a3,%got_call(foo)($gp)
	.ifndef reloc_jalr32
	.reloc	1f ,R_NANOMIPS_JALR16, foo
1:	jalrc	$a3
	.else
	.reloc	1f, R_NANOMIPS_JALR32, foo
1:	jalrc32	$a3
	.endif
	.end	__start
	.size	__start, .-__start

	.section	.foo,"ax",@progbits
	.align	4
	.globl	foo
	.ent	foo
foo:
	jrc	$ra
	.end	foo
	.size	foo, .-foo
