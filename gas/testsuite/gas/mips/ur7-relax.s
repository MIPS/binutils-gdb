	.text
	.align	3
	.ent	test
	.globl	test
	/* Relax to 16-bit */ 
test:
	beqc	$2,$3,test1 /* forward */
	.space	28
test1:
	bc	test2	/* forward */
	.space	1020
test2:
	bc 	test1	/* backward */
	bnec	$3, $2, test3
	.space (1<<4)
test3:	
	beqc	$2, $3, test2
	.space (1<<4)
test4:
	balc	printf
	.space (1<<9)
	.end	test
	.ent printf
	.globl printf
printf:
	nop
	.end printf

.data
	.globl gpdata
gpdata:
	.word
