	.text
	.ifdef relaxmode
	.linkrelax
	.endif
foo:
	.set push
	.set nolinkrelax
	li $a0,1
	.set push
	.set linkrelax
	nop
	li $a0,1
	.set pop
	move $a0, $a0
	.set pop
	nop
