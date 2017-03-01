	.text
	.ent	test
	.globl	test
test:
	ext	$2, $3, 5, 10
	ext	$2, $3, 0, 31
	ext	$2, $3, 31, 1
	ext	$31, $30, 31, 1
	/* INS instruction */
	ins	$2, $3, 5, 15
	ins	$2, $3, 16, 16
	ins	$2, $3, 0, 32 /* MOVE */
	ins	$2, $3, 0, 31
	ins	$2, $3, 31, 1
	ins	$2, $3, 1, 31
	/* INS with same source and destination */
	ins	$3, $3, 5, 15
	ins	$3, $3, 16, 16
	ins	$3, $3, 0, 32  /* NOP */
	ins	$3, $3, 0, 31  /* NOP */
	ins	$3, $3, 31, 1
	ins	$3, $3, 1, 31
	.end test

	.align	2
	.space	8
