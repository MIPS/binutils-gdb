	.type test1, @function
	.ent test1, 0
	.section .text.test1, "x"
test1:
	balc test2
	.end test1

	.type test2, @function
	.ent test2, 0
	.section .text.test2, "x"
test2:
	nop
	.end test2
