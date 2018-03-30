# Source file to verify PC-relative relocations do not overflow.

	.text
	.space	0x40000
	.globl	foo
	.ent	foo
foo:
	b	bar
.Lfoo:
	b	.Lbar
	.end	foo

	.section .init, "ax", @progbits
	.globl	bar
	.ent	bar
bar:
	b	foo
.Lbar:
	b	.Lfoo
	.end	bar
