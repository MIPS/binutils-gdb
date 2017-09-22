	.text
	.align	3
	.ent	test
test:
	lwc1	$f4, %gprel(test)($gp)
	swc1	$f4, %gprel(test)($gp)
	ldc1	$f4, %gprel(test)($gp)
	sdc1	$f4, %gprel(test)($gp)
	lb	$a0, %gprel(test)($gp)
	lh	$a0, %gprel(test)($gp)
	lw	$a0, %gprel(test)($gp)
	lbu	$a0, %gprel(test)($gp)
	lhu	$a0, %gprel(test)($gp)
	lw	$a0, %gprel(test)($gp)
	sb	$a0, %gprel(test)($gp)
	sh	$a0, %gprel(test)($gp)
	sw	$a0, %gprel(test)($gp)
	addiu	$a0, $gp, %gprel(test)
	addiu.b	$a0, $gp, %gprel(test)
	addiu.w	$a0, $gp, %gprel(test)
	addiu48	$a0, $gp, %gprel(test)
	addiu	$a0, %lo (test)
	lw16	$a0, %lo (test)($a1)
	lw	$a0, %got_call(test)($gp)
	lw	$a0, %got_disp(test)($gp)
	lw	$a0, %got_page(test)($gp)
	lw	$a0, %got_ofst(test)($gp)
	lw	$a0, %got(test)($gp)
	lui	$a0, %gprel_hi(test)
	addiu	$a0, %gprel_lo(test)
	addiu	$a0, $gp, %gprel32(test)
	lui	$a0, %hi(test)
	addiu	$a0, %lo(test)
	aluipc	$a0, %pcrel_hi(test)
	addiu	$a0, %pcrel_lo(test)
	aluipc	$a0, %got_pcrel_hi(test)
	addiu	$a0, %got_pcrel_lo(test)
	addiu	$a0, %got_lo(test)
	lwpc	$a0, %got_pcrel32(test)
	.reloc	1f, R_NANOMIPS_JALR32, end
1:	jalr	$t9
	.reloc	1f, R_NANOMIPS_JALR16, end
1:	jalr	$t9
end:
	.end	test
