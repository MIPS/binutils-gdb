	.text
	.align	3
	.ent	test
	.globl	test
	/* Relax to 16-bit */ 
test:
	beqc	$4,$5,test1 /* forward, relax to 32-bit */
	.space	(1<<5)
test1:
	bc	test2	/* forward, relax to 32-bit */
	.space	(1<<10)
test2:
	bc 	test1	/* backward, relax to 32-bit */
	bnec	$5, $4, test3
	.space (1<<5)
test3:	
	beqc	$4, $5, test2 /* backward, relax to 32-bit */
	.space (1<<5)
test4:
	balc	test5 /* forward, relax to 32-bit */
	.space (1<<10)
	.end	test
	.ent test5
	.globl test5
test5:
	beqc	$4,$5,test6 /* forward, no relax */
	.space	(1<<5)-2
test6:
	bc	test7	/* forward, no relax */
	.space	(1<<10)-4
test7:
	bc 	test6	/* backward, no relax */
	bnec	$5, $4, test8 /* forward, no relax */
	.space (1<<5)-2
test8:
	.space (1<<10)-2
test9:
	balc	test8 /* backward, no relax */

	beqc $17,$7,$L1
$L1:
	nop
	.end test5
