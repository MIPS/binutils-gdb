	.text
	.space	0x1000

	.balign	4
	.set	mips32r6
	.set	micromips
	.ent	foo
foo:
	jalr	$0, $ra
	.end	foo

	.balign	4
	.set	nomicromips
	.ent	bar
bar:
	bc	foo
	beqzc	$2, foo
	jrc	$ra
	.end	bar

# Force some (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	4, 0
	.space	16
