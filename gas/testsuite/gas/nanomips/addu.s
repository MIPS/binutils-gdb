# Source file used to test the add macro.

foo:
	addu	$a0,$a0,0
	addu	$a0,$a0,1
	addu	$a0,$a0,0x8000
	addu	$a0,$a0,-0x8000
	addu	$a0,$a0,0x10000
	addu	$a0,$a0,0x1a5a5
	.align 2
	.space 8
