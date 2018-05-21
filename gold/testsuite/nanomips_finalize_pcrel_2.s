	.section	.text,"ax",@progbits
	.align	4
	.global	foo
	.ent	foo
foo:
	jrc	$r31
	.end	foo
	.size	foo, .-foo
