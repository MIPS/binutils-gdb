	.section		.tdata,"awT"
	.align	2
	.global	tlsvar
	.hidden	tlsvar
	.type	tlsvar,@object
	.size	tlsvar,4
tlsvar:
	.word	1


	.text
	.align	3
	.ent	test
test:
	lb	$a0,%gprel(test)($gp)
	lh	$a0,%gprel(test)($gp)
	lw	$a0,%gprel(test)($gp)
	lbu	$a0,%gprel(test)($gp)
	lhu	$a0,%gprel(test)($gp)
	lw	$a0,%gprel(test)($gp)
	sb	$a0,%gprel(test)($gp)
	sh	$a0,%gprel(test)($gp)
	sw	$a0,%gprel(test)($gp)
	addiu	$a0,$gp,%gprel(test)
	addiu.b	$a0,$gp,%gprel(test)
	addiu.w	$a0,$gp,%gprel(test)
	addiu48	$a0,$gp,%gprel(test)
	addiu	$a0,%lo (test)
	lw16	$a0,%lo (test)($a1)
	lw	$a0,%got_call(test)($gp)
	lw	$a0,%got_disp(test)($gp)
	lw	$a0,%got_page(test)($gp)
	lw	$a0,%got_ofst(test)($gp)
	lw	$a0,%got(test)($gp)
	lui	$a0,%gprel_hi(test)
	addiu	$a0,%gprel_lo(test)
	addiu.b32 $a0,$gp,%gprel(test)
	lui	$a0,%hi(test)
	addiu	$a0,%lo(test)
	aluipc	$a0,%pcrel_hi(test)
	addiu	$a0,%pcrel_lo(test)
	aluipc	$a0,%got_pcrel_hi(test)
	addiu	$a0,%got_pcrel_lo(test)
	addiu	$a0,%got_lo(test)
	lwpc	$a0,%got_pcrel32(test)
	.reloc	1f,R_NANOMIPS_JALR32,end
1:	jalr	$t9
	.reloc	1f,R_NANOMIPS_JALR16,end
1:	jalr	$t9
end:

	addiu.w	$a0,$gp,%tlsgd(tlsvar)
	addiu32	$a0,$gp,%tlsgd(tlsvar)
	addiu.b32 $a0,$gp,%tlsgd(tlsvar)
	addiu48 $a0,$gp,%tlsgd(tlsvar)
	addiu.w	$a0,$gp,%tlsld(tlsvar)
	addiu32	$a0,$gp,%tlsld(tlsvar)
	addiu.b32 $a0,$gp,%tlsld(tlsvar)
	addiu48 $a0,$gp,%tlsld(tlsvar)

	lb	$a0,%tprel(tlsvar)($a1)
	lh	$a0,%tprel(tlsvar)($a1)
	lw	$a0,%tprel(tlsvar)($a1)
	lbu	$a0,%tprel(tlsvar)($a1)
	lhu	$a0,%tprel(tlsvar)($a1)
	lw	$a0,%tprel(tlsvar)($a1)
	sb	$a0,%tprel(tlsvar)($a1)
	sh	$a0,%tprel(tlsvar)($a1)
	sw	$a0,%tprel(tlsvar)($a1)
	addiu	$a0,$a1,%tprel(tlsvar)
	addiu48 $a0,$a0,%tprel(tlsvar)
	li48 	$a0,%tprel(tlsvar)
	lb	$a0,%dtprel(tlsvar)($a1)
	lh	$a0,%dtprel(tlsvar)($a1)
	lw	$a0,%dtprel(tlsvar)($a1)
	lbu	$a0,%dtprel(tlsvar)($a1)
	lhu	$a0,%dtprel(tlsvar)($a1)
	lw	$a0,%dtprel(tlsvar)($a1)
	sb	$a0,%dtprel(tlsvar)($a1)
	sh	$a0,%dtprel(tlsvar)($a1)
	sw	$a0,%dtprel(tlsvar)($a1)
	addiu	$a0,$a1,%dtprel(tlsvar)
	addiu48 $a0,$a0,%dtprel(tlsvar)
	li48 	$a0,%dtprel(tlsvar)
	lw	$a0,%gottprel(tlsvar)($gp)
	lwpc	$a0,%gottprel_pc32(tlsvar)
	.reloc	1f,R_NANOMIPS_JUMP32,test
1:	jalr	$t9
	.reloc	1f,R_NANOMIPS_JUMP16,test
1:	jalr	$t9

	.end	test
