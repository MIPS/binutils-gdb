	.text
	.globl	foo
foo:
	addu	$4, $5, $6
	beqz	$6, lbar
	.org	0x6
	nop
	.space	0xff8
	.globl	bar
bar:
lbar:
	nop
