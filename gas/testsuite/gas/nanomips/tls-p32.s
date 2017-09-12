	.file	1 "tls.s"
	.text
	.set 	pic
	.align	2
	.globl	fn
	.ent	fn
	.type	fn,@function
fn:
	.frame	$fp,16,$ra
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpsetup $t9
	.set	reorder
	addiu	$sp,$sp,-16
	sw	$fp,8($sp)
	move	$fp,$sp
	.cprestore	0

	# General Dynamic
	lw	$t9,%call16(__tls_get_addr)($gp)
	addiu	$a0,$gp,%tlsgd(tlsvar_gd)
	jal	$t9

	# Local Dynamic
	lw	$t9,%call16(__tls_get_addr)($gp)
	addiu	$a0,$gp,%tlsldm(tlsvar_ld)
	jal	$t9

	move	$t4,$t4		# Arbitrary instructions

	lui	$t5,%dtprel_hi(tlsvar_ld)
	addiu	$t5,$t5,%dtprel_lo(tlsvar_ld)
	addu	$t5,$t5,$t4

	# Initial Exec
	.set	push
	rdhwr	$t4, $5
	.set	pop
	lw	$t5,%gottprel(tlsvar_ie)($gp)
	addu	$t5,$t5,$t4

	# Local Exec
	.set	push
	rdhwr	$t4, $5
	.set	pop
	lui	$t5,%tprel_hi(tlsvar_le)
	ori	$t5,$t5,%tprel_lo(tlsvar_le)
	addu	$t5,$t5,$t4

	move	$sp,$fp
	lw	$fp,8($sp)
	addiu	$sp,$sp,16
	j	$ra
	.end	fn

	.section		.tbss,"awT",@nobits
	.align	2
	.global	tlsvar_gd
	.type	tlsvar_gd,@object
	.size	tlsvar_gd,4
tlsvar_gd:
	.space	4
	.global	tlsvar_ie
	.type	tlsvar_ie,@object
	.size	tlsvar_ie,4
tlsvar_ie:
	.space	4

	.section		.tdata,"awT"
	.align	2
	.global	tlsvar_ld
	.hidden	tlsvar_ld
	.type	tlsvar_ld,@object
	.size	tlsvar_ld,4
tlsvar_ld:
	.word	1
	.global	tlsvar_le
	.hidden	tlsvar_le
	.type	tlsvar_le,@object
	.size	tlsvar_le,4
tlsvar_le:
	.word	1
