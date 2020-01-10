	.linkrelax
	.module	pcrel
	.module	pic1
	.module	softfloat
	.section	.text.startup,"ax",@progbits
	.align	1
    .globl	test
    .ent	test
test:
	.reloc	1f,R_NANOMIPS_SAVERESTORE,main
1:
	save	32,$ra,$s0-$s3,$gp
	lapc	$gp,_gp
	lw	$a3,%got_page(x)($gp)
	lw	$a0,%got_ofst(x)($a3)
	.reloc	1f,R_NANOMIPS_SAVERESTORE,main
1:
	restore.jrc	32,$ra,$s0-$s3,$gp
    .end	test
    .size	test, .-test

	.comm	x,4,4
