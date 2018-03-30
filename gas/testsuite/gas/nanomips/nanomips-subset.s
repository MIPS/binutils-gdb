	.text
	.ent	test
	.globl	test
test:
	ext	$t4, $t5, 5, 10
	ext	$t4, $t5, 0, 31
	ext	$t4, $t5, 31, 1
	ext	$ra, $fp, 31, 1
	/* INS instruction */
	ins	$t4, $t5, 5, 15
	ins	$t4, $t5, 16, 16
	ins	$t4, $t5, 0, 32 /* MOVE */
	ins	$t4, $t5, 0, 31
	ins	$t4, $t5, 31, 1
	ins	$t4, $t5, 1, 31
	/* INS with same source and destination */
	ins	$t5, $t5, 5, 15
	ins	$t5, $t5, 16, 16
	ins	$t5, $t5, 0, 32  /* NOP */
	ins	$t5, $t5, 0, 31  /* NOP */
	ins	$t5, $t5, 31, 1
	ins	$t5, $t5, 1, 31
	.end test
