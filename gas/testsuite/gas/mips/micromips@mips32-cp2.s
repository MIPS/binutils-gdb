# Source file to test assembly of MIPS32-derived microMIPS cop2 instructions.

	.set noreorder
	.set noat

	.text
text_label:
	# Unprivileged coprocessor instructions.
	# These tests use cp2 to avoid other (cp0, fpu, prefetch) opcodes.

	.ifndef r6
	bc2f	text_label
	nop
	bc2fl	text_label
	nop
	bc2t	text_label
	nop
	bc2tl	text_label
	nop
	.endif
	# XXX other BCzCond encodings not currently expressable.

	cfc2	$1, $2
	# Different cop2 range for microMIPS.
	cop2	0x12345			# disassembles as c2 ...
	ctc2	$2, $3

	# No sel with cp2 for microMIPS.
	mfc2	$3, $4
	mtc2	$6, $7


	.ifndef r6
	# Cop2 branches with cond code number, like bc1t/f.
	bc2f	$cc0,text_label
	nop
	bc2fl	$cc1,text_label
	nop
	bc2t	$cc6,text_label
	nop
	bc2tl	$cc7,text_label
	nop
	.endif

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
