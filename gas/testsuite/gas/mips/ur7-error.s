# MIPSR7 assembly errors

	.text
	.ent	test
	.globl	test
test:
	/* Order between 1st and 2nd operand of movep should be enforced.
	 2nd-op = 4 + (( 1st-op + 1 ) % 4).
	 Likewise for 3rd and 4th operands of movep[REV]. */
	.set noat
	movep   $5,$5,$16,$0
	movep   $6,$5,$17,$1
	movep   $7,$6,$18,$2
	movep   $7,$7,$19,$3
	movep   $4,$20,$4,$8
	movep   $5,$21,$5,$7
	movep   $6,$22,$6,$8
	movep   $7,$23,$6,$6

	balrc	$0, $4
	balrsc	$0, $6

	auipc	$0, 1
	move16 $0, $1
	
	.end	test
