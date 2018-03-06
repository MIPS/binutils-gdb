/* Test sync codes  */
	.text
	.ent test
test:
	sync
	sync 4
	sync 16
	sync 17
	sync 18
	sync 19
	sync 20
	.end test
	.align	2
	.space	8
