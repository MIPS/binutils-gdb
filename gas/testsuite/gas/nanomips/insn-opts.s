	.text

	.globl	foo
	.type	foo, @function
foo:
	.insn
	.dc.l	0xc0008000
	.size	foo, . - foo

	.globl	bar
	.type	bar, @function
bar:
	.insn
	.dc.l	0xc0008000
	.size	bar, . - bar

	.globl	baz
	.type	baz, @object
baz:
	.dc.l	0
	.size	baz, . - baz
