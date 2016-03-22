	.text
	.set	micromips
	.set	reorder
	.globl test3
test:
	/* Relaxed using 16-bit negated branches.  */

	addu	$2, $3, $4	/* No swap  */
	beqz	$2, test2	/* Negate to 16-bit with delay  */

	addu	$2, $3, $4	/* Swap  */
	bnez	$5, test2	/* Negate to 16-bit with delay  */

	addu	$2, $3, $4	/* No swap  */
	bnezc	$2, test2	/* Negate to 16-bit with delay  */

	addu	$2, $3, $4	/* Swap  */
	beqzc	$5, test2	/* Negate to 16-bit with delay  */

	/* Relaxed to use 32-bit negated branches.  */

	addu	$2, $3, $4	/* No swap  */
	beq	$2, $5, test2	/* 32-bit negated  */

	addu	$2, $3, $4	/* Swap  */
	bne	$3, $5, test2	/* 32-bit negated  */

	addu	$2, $3, $4	/* No swap  */
	bgezal	$2, test2	/* Use short-delay slot  */

	addu	$2, $3, $4	/* Swap  */
	bltzal	$5, test2	/* Use short-delay slot  */

	.skip	65536
test2:

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
