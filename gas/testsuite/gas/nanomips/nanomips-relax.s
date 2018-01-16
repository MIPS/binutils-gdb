	.text
	.align	3
	.ent	test
	.globl	test
	/* Relax to 16-bit */
test:
	beqc	$a0,$a1,test1 /* forward, relax to 32-bit */
	.space	(1<<5)
test1:
	bc	test2	/* forward, relax to 32-bit */
	.space	(1<<10)
test2:
	bc 	test1	/* backward, relax to 32-bit */
	bnec	$a1, $a0, test3
	.space (1<<5)
test3:
	beqc	$a0, $a1, test2 /* backward, relax to 32-bit */
	.space (1<<5)
test4:
	balc	test5 /* forward, relax to 32-bit */
	.space (1<<10)
	.end	test
	.ent test5
	.globl test5
test5:
	beqc	$a0,$a1,test6 /* forward, no relax */
	.space	(1<<5)-4
test6:
	bc	test7	/* forward, no relax */
test6a:
	.space	(1<<10)-4
test7:
	bc 	test6a	/* backward, no relax */
	bnec	$a1, $a0, test8 /* forward, no relax */
	.space (1<<5)-4
test8:
	.space (1<<10)-2
test9:
	balc	test8 /* backward, no relax */

	beqc $s1,$a3,$L1 /* unreachable forward to relaxable, relax.  */
$L1:
	beqc $s1,$a3,$L2 /* unreachable forward to non-relaxable, relax.  */
$L2:
	nop
	beqc $s1,$a3,$L3 /* reachable forward over non-relaxable, no relax.  */
	restore.jrc	16,$ra
$L3:
	beqc $s1,$a3,$L4 /* reachable forward over relaxable, no relax.  */
	beqzc $s1, $L3
$L4:
	beqzc $s1, $L3

	.end test5
	.space 8
