	.text
	.ent	test
	.globl	test
test:
	ext	$2, $3, 5, 10
	ext	$2, $3, 0, 31
	ext	$2, $3, 31, 1
	ext	$31, $30, 31, 1

	ins	$2, $3, 5, 15
	ins	$2, $3, 0, 32
	ins	$2, $3, 31, 1
	ins	$31, $30, 31, 1

	.end test
