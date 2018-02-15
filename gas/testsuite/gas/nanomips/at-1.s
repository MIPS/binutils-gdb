	.macro	do_atblock atreg base
	.set	at=\atreg
	sw	\base, 0x7fff(\base)
	lw	\base, -0x8000(\base)
	sw	\base, -0x8000(\base)
	sw	\base, 0x8000(\base)
	.ifdef nms
	lw	\base, -0x8001(\base)
	.endif
	sw	\base, -0x8001(\base)
	.endm

	.text
foo:
	do_atblock $1,$27
	do_atblock $2,$27
	do_atblock $3,$27
	do_atblock $4,$27
	do_atblock $5,$27
	do_atblock $6,$27
	do_atblock $7,$27
	do_atblock $8,$27
	do_atblock $9,$27
	do_atblock $10,$27
	do_atblock $11,$27
	do_atblock $12,$27
	do_atblock $13,$27
	do_atblock $14,$27
	do_atblock $15,$27
	do_atblock $16,$27
	do_atblock $17,$27
	do_atblock $18,$27
	do_atblock $19,$27
	do_atblock $20,$27
	do_atblock $21,$27
	do_atblock $22,$27
	do_atblock $23,$27
	do_atblock $24,$27
	do_atblock $25,$27
	do_atblock $26,$27
	do_atblock $27,$26
	do_atblock $gp,$27
	do_atblock $fp,$27
	do_atblock $sp,$27
	do_atblock $ra,$27

	.set	at
	sw	$27, 0x7fff($27)
	lw	$27, -0x8000($27)
	sw	$27, -0x8000($27)
	sw	$27, 0x8000($27)
	.ifdef nms
	lw	$27, -0x8001($27)
	.endif
	sw	$27, -0x8001($27)

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.space	8
