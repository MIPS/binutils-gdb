	.text
	.set	micromips
	.set	reorder
	.globl test3
test:
	/* Following branches should be optimized to use compact versions.  */

	/* Too far for 16-bits, expand to 32-bits compact.  */
	addu	$2, $3, $4
	beqz	$2, test2

	addu	$2, $3, $4
	bnez	$2, test2

	b	test2
	
	/* No conversion for in-range 16-bit branches.  */
	addu	$2, $3, $4
	beqz	$2, test1

	addu	$2, $3, $4
	bnez	$2, test1

	b 	test1
	
	.skip	10
test1:
	/* No conversion if instruction is available to fill delay slot.  */
	/* In 32-bit range */
	addu	$2, $3, $4
	beqz	$5, test2

	/* Out of range */
	addu	$2, $3, $4
	bnez	$5, test3
	
	addu	$2, $3, $4
	b	test2
	
	.skip	1024
test2:
	.skip	65536
test3:	
	
# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
