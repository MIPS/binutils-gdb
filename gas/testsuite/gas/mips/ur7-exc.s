	.text
	.ent	test
	.globl	test
test:	
	movep	$4, $5, $18, $19
	movep	$5, $6, $18, $19
	movep	$6, $7, $18, $19
	movep	$7, $4, $18, $19

.end	test
