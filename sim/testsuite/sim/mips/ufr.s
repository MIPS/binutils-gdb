# mips test ufr, expected to pass.
# mach:	 mips32r2 mips64r2
# as:		-mabi=eabi
# ld:		-N -Ttext=0x80010000
#output:	*\\npass\\n

	.include "testutils.inc"

	setup

	.set noreorder

	.ent DIAG
DIAG:
	writemsg "[1] Enable writing to FR"
	li $2, 0x4
	mfc0 $3, $16, 5
	or $3, $3, $2
	mtc0 $3, $16, 5
	mfc0 $3, $16, 5
	and $3, $3, $2
	beq $3, $0, _fail
	nop

	writemsg "[2] Change to FR 0 mode"
	ctc1 $0, $1
	cfc1 $2, $1
	bne $2, $0, _fail
	nop

	writemsg "[3] Change to FR 1 mode"
	ctc1 $0, $4
	cfc1 $2, $1
	li $3, 1
	bne $2, $3, _fail
	nop

	pass

	.end DIAG
