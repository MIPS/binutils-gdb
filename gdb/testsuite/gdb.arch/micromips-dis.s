	.text
	.space 2
	.set micromips
	.ent test1
	.set noreorder
test1:
	addiu   $v0,$a0,1
	jr 	$ra
	.end test1
	.globl main
	.align 2
	.ent main
main:
	jr $ra
	.end main
