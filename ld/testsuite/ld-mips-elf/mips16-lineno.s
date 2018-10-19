	# Dummy file name
	.file 1 "mips16-lineno.c"
	.section .text.foo,"ax",@progbits
	.globl foo
	# Dummy line number 1
	.loc 1 1 0
	.set	mips16
	.set	nomicromips
	.ent	foo
foo:
	nop
	jr	$ra
	.end	foo
	.section .text.bar,"ax",@progbits
	.globl	bar
	# Dummy line number 2
	.loc 1 2 0
	.set	nomips16
	.ent	bar
bar:
	nop
	jr	$ra
	.end	bar
	.section .text.baz,"ax",@progbits
	.globl	baz
	# Dummy line number 3
	.loc 1 3 0
	.set	mips16
	.ent	baz
baz:
	nop
	jr	$ra
	.end	baz
	.globl	__start
__start:
	nop
