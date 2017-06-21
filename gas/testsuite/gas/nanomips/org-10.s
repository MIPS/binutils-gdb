	.text
	.globl	foo
foo:
	beqz	$4, lbar
	.org	0x10
	nop32
	.space	0xfffec
	.globl	bar
bar:
lbar:
	nop
