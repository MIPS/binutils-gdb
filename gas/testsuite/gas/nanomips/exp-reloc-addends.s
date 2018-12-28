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
	lb	$a0,%gprel(test+5)($gp)
	lh	$a0,%gprel(test+6)($gp)
	lw	$a0,%gprel(test+7)($gp)
	lbu	$a0,%gprel(test+8)($gp)
	lhu	$a0,%gprel(test+9)($gp)
	lw	$a0,%gprel(test+10)($gp)
	sb	$a0,%gprel(test+11)($gp)
	sh	$a0,%gprel(test+12)($gp)
	sw	$a0,%gprel(test+13)($gp)
	addiu	$a0,$gp,%gprel(test+14)
	addiu.b	$a0,$gp,%gprel(test+15)
	addiu.w	$a0,$gp,%gprel(test+16)
	addiu48	$a0,$gp,%gprel(test+17)
	addiu	$a0,%lo (test+18)
	lw16	$a0,%lo (test+19)($a1)
	lw	$a0,%got_call(test+20)($gp)
	lw	$a0,%got_disp(test+21)($gp)
	lw	$a0,%got_page(test+22)($gp)
	lw	$a0,%got_ofst(test+23)($gp)
	lw	$a0,%got(test+24)($gp)
	lui	$a0,%gprel_hi(test+25)
	addiu	$a0,%gprel_lo(test+26)
	addiu.b32 $a0,$gp,%gprel(test+27)
	lui	$a0,%hi(test+28)
	addiu	$a0,%lo(test+29)
	aluipc	$a0,%pcrel_hi(test+30)
	addiu	$a0,%pcrel_lo(test+31)
	aluipc	$a0,%got_pcrel_hi(test+32)
	addiu	$a0,%got_pcrel_lo(test+33)
	addiu	$a0,%got_lo(test+34)
	lwpc	$a0,%got_pcrel32(test+35)
	.reloc	1f,R_NANOMIPS_JALR32,end+36
1:	jalr	$t9
	.reloc	1f,R_NANOMIPS_JALR16,end+37
1:	jalr	$t9
end:

	addiu.w	$a0,$gp,%tlsgd(tlsvar+1)
	addiu32	$a0,$gp,%tlsgd(tlsvar+2)
	addiu.b32 $a0,$gp,%tlsgd(tlsvar+3)
	addiu48 $a0,$gp,%tlsgd(tlsvar+4)
	addiu.w	$a0,$gp,%tlsld(tlsvar+5)
	addiu32	$a0,$gp,%tlsld(tlsvar+6)
	addiu.b32 $a0,$gp,%tlsld(tlsvar+7)
	addiu48 $a0,$gp,%tlsld(tlsvar+8)

	lb	$a0,%tprel(tlsvar+13)($a1)
	lh	$a0,%tprel(tlsvar+14)($a1)
	lw	$a0,%tprel(tlsvar+15)($a1)
	lbu	$a0,%tprel(tlsvar+16)($a1)
	lhu	$a0,%tprel(tlsvar+17)($a1)
	lw	$a0,%tprel(tlsvar+18)($a1)
	sb	$a0,%tprel(tlsvar+19)($a1)
	sh	$a0,%tprel(tlsvar+20)($a1)
	sw	$a0,%tprel(tlsvar+21)($a1)
	addiu	$a0,$a1,%tprel(tlsvar+22)
	addiu48 $a0,$a0,%tprel(tlsvar+23)
	li48 	$a0,%tprel(tlsvar+24)
	lb	$a0,%dtprel(tlsvar+29)($a1)
	lh	$a0,%dtprel(tlsvar+30)($a1)
	lw	$a0,%dtprel(tlsvar+31)($a1)
	lbu	$a0,%dtprel(tlsvar+32)($a1)
	lhu	$a0,%dtprel(tlsvar+33)($a1)
	lw	$a0,%dtprel(tlsvar+34)($a1)
	sb	$a0,%dtprel(tlsvar+35)($a1)
	sh	$a0,%dtprel(tlsvar+36)($a1)
	sw	$a0,%dtprel(tlsvar+37)($a1)
	addiu	$a0,$a1,%dtprel(tlsvar+38)
	addiu48 $a0,$a0,%dtprel(tlsvar+39)
	li48 	$a0,%dtprel(tlsvar+40)
	lw	$a0,%gottprel(tlsvar+41)($gp)
	lwpc	$a0,%gottprel_pc32(tlsvar+42)
	.end	test
