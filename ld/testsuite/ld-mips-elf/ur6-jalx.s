# uMIPSr6 JALX contraction test

	.set noreorder

	.set micromips
	.ent test
	.globl test
test:
	jalx Unear
	jalx Mnear
	jalx Ufar
	jalx Mfar
	jalx Urfar
	jalx Mrfar
	j Unear
	j Mnear
	j Ufar
	j Mfar
	j Urfar
	j Mrfar
	.end test

	.set nomicromips
testmips:
	jalx Unear
	jalx Mnear
	jalx Ufar
	jalx Mfar
	jalx Urfar
	jalx Mrfar
	j Unear
	j Mnear
	j Ufar
	j Mfar
	j Urfar
	j Mrfar

#Test that PC-rel relocations around a relaxed sequence get relocated
	.set micromips
testrel:
	b L1
	nop
	jalx Unear
	b L1
	nop

	b L1
	nop
	j Unear
	b L1
	nop

L1:
	addiu $3, 4

#####################################

# Near targets: b(al)c
	.set micromips
Unear:
	addiu $ra, 4
	jrc $ra

	.set nomicromips
	.align 3
Mnear:
	addiu $ra, 8
	jr $ra
	nop

# Far targets: j(al)

	.skip 0x7000000
	.set micromips
Ufar:
	addiu $ra, 4
	jrc $ra

	.skip 0x1000000
	.set nomicromips
	.align 3
Mfar:
	addiu $ra, 8
	jr $ra

# Really far targets: auipc + ji(al)c

	.skip 0x4000000
	.set micromips
Urfar:
	addiu $ra, 8
	jrc $ra

	.skip 0x4000000
	.set nomicromips
	.align 3
Mrfar:
	addiu $ra, 4
	jr $ra
	nop
