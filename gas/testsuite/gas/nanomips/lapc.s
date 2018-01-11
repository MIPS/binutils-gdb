	.extern test1
	.ent test
test:
	lapc $a0, test
	lapc $a0, test1
	lapc32 $a0, test
	lapc48 $a0, test1
	lapc[32] $a0, test
	lapc[48] $a0, test1
	lapc.h $a0, test
	lapc.b $a0, test1
	.end test

	# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align  2
	.space  8
