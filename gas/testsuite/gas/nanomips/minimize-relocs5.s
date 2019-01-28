	# Label difference with reloc minimization
	# This case comes from exception handling in C++ code
	# The assembler must detect that the lapc.b is liable
	# to be contracted by the linker if test2 is close enough.

	.linkrelax
	.ent	test
	.type	test, @function
test:
$L15:
	bltzc	$s0,$L15
	lapc.b	$a0,test2
$L16:
	bc	$L15
$L17:
	.end	test
	.data
	.4byte	$L16-$L15
