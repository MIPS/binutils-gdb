	.text
	.ent test1
test1:
	nop
	jr $31
	.end test1

test2:
	nop
	jr $31

test3:
	balc test1
	balc test2
	balc test9
	jr $31

	.ent test3a
test3a:
	nop
	.end test3a

	.text
	.ent test4
test4:
	nop
	jr $31
	.end test4

	.data
test5:
	.word 0x0

	.text
test6:
	balc $test4

	.section	.mytext, "ax"
test7:
	balc test2
	balc test4

test8:
	balc test3
	jr $31

