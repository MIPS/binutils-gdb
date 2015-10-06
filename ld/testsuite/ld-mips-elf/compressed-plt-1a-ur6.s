# Define a function with all "compressed" (dc and ic) references.

	.abicalls
	.option	pic0

	.include "compressed-plt-1.s"

	.macro	test_one, name, types
	.if	(\types) & DC
	balc	\name
	.if	micromips
	.ifdef	o32
	bc	\name
	.endif
	.endif
	.endif
	.if	(\types) & IC
	lw	$2, %call16(\name)($3)
	.endif
	.endm

	.if	micromips
	.set	micromips
	.else
	.set	mips16
	.endif

	.section .text.a, "ax", @progbits
	.globl	testc
	.ent	testc
	.set	noreorder
testc:
	test_all
	jr	$31
	.end	testc
