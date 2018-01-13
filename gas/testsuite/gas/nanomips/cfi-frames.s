	.linkrelax
	.module	pcrel
	.text
	.align	1
	.cfi_startproc
	.ent	test
	.type	test, @function
test:
	save	16,$fp,$ra
	balc	test
	.cfi_def_cfa_offset 16
	.cfi_offset 30, -4
	.cfi_offset 31, -8
	balc	test
	.cfi_def_cfa 30, 4096
	lw	$a3,%gprel(test)($gp)
	beqzc	$a3,$L3
	balc	test
	addiu[gp.w]	$a1,$gp,%gprel(test)
	move.balc	$a0,$a3,__cxa_throw
	addiu	$sp,$fp,4080
	.cfi_def_cfa 29, 16
	restore.jrc	16,$fp,$ra
	balc	test
	.cfi_def_cfa_offset 32
	.cfi_offset 30, -4
	.cfi_offset 31, -8
	balc	test
	sw	$a0,4076($fp)
	.cfi_def_cfa 30, 4096
	balc	test
	addiu	$sp,$fp,4080
	.cfi_def_cfa 29, 16
	restore.jrc	16,$fp,$ra
	balc	test
	.cfi_def_cfa 28, 4096
	balc	test
	addiu	$sp,$fp,4080
	.cfi_def_cfa 27, 32
	.end test
	.cfi_endproc
