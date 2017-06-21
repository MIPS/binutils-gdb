	.text
	.globl	foo
foo:
	addu	$4, $5, $6
	beqz	$4, lbar
	.org	0x4
	nop
	.space	0x7a
	.globl	bar
bar:
lbar:
	nop
