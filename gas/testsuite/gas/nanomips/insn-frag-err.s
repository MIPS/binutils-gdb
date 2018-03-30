	/* Detect instruction fragmentation in disassembly */

	.text
	.ent test1
test1:
	.half 0x8000
	.end test1

	.text
	.align 1
	.ent test2
test2:
	.half 0x6000
	.end test2


	.text
	.ent test3
test3:
	.half 0x6000
	.half 0x1000
	.end test3
	# dummy label so that test3 is not the last.
test4:
