	.text
foo:
	li $a0,1
	.linkrelax
	nop
	li $a0,1
	move $a0, $a0
	nop
