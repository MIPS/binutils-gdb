# nanoMIPS assembly errors

	.text
	.ent	test
	.globl	test
test:
	/* Order between 1st and 2nd operand of movep should be enforced.
	 2nd-op = 4 + (( 1st-op + 1 ) % 4).
	 Likewise for 3rd and 4th operands of movep[REV]. */
	movep   $a1,$a1,$s0,$zero
	movep   $a2,$a1,$s1,$at
	movep   $a3,$a2,$s2,$t4
	movep   $a3,$a3,$s3,$t5
	movep   $a0,$s4,$a0,$a4
	movep   $a1,$s5,$a1,$a3
	movep   $a2,$s6,$a2,$a4
	movep   $a3,$s7,$a2,$a2

	/* Non-zero register check */

	balrsc	$zero, $a2

	move16 $zero, $at

	/* Valid values for ALIGN macro are 0, 1, 2, 3 */
	align   $a0, $t4, $t5, 4
	align   $a0, $t4, $t5, 31

	/* Range of immediate operand for branch with compare-immediate */
	bgeiuc	$t4, -1, test
	bgeiuc	$t5, 128, test
	bltiuc	$a0, -3, test
	bltiuc	$a1, 256, test

	.end	test
