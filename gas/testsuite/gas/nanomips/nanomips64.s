# source file to test assembly of nanoMIPS64 instructions
	.set noat
	.globl text_label
text_label:

	# unprivileged CPU instructions
	dclo    $1, $2
	dclz    $3, $4

	# Test macro's ability to turn "dext" into "dext", "dextm" and
	# "dextu" as appropriate.  Also, add some explicit tests of the
	# actual instructions.
	dext	$2, $3, 0, 1	# dext
	dext	$2, $3, 0, 32	# dext
	dext	$2, $3, 0, 33	# dextm
	dext	$2, $3, 0, 64	# dextm
	dext	$2, $3, 31, 1	# dext
	dext	$2, $3, 31, 32	# dext
	dext	$2, $3, 31, 33	# dextm
	dext	$2, $3, 32, 1	# dextu
	dext	$2, $3, 32, 32	# dextu
	dext	$2, $3, 63, 1	# dextu
	dextm	$2, $3, 10, 44
	dextu	$2, $3, 42, 12

	# Test macro's ability to turn "dins" into "dins", "dinsm" and
	# "dinsu" as appropriate.  Also, add some explicit tests of the
	# non-macro instructions.
	dins	$2, $3, 0, 1	# dins
	dins	$2, $3, 0, 32	# dins
	dins	$2, $3, 0, 33	# dinsm
	dins	$2, $3, 0, 64	# dinsm
	dins	$2, $3, 31, 1	# dins
	dins	$2, $3, 31, 2	# dinsm
	dins	$2, $3, 31, 33	# dinsm
	dins	$2, $3, 32, 1	# dinsu
	dins	$2, $3, 32, 32	# dinsu
	dins	$2, $3, 63, 1	# dinsu
	dinsm	$2, $3, 10, 44
	dinsu	$2, $3, 42, 12

	dsbh	$7
	dsbh	$8, $10

	dshd	$7
	dshd	$8, $10

	.set at
	# drol and dror macros.
	drotl	$25, $10, 4	# dror32
	drotr	$25, $10, 4	# dror
	drotl	$25, $10, 36	# dror
	drotl	$25, $10, $4	# neg / drorv
	.ifdef nanomips_broken
	drotr	$25, $10, 36	# dror32
	drotr	$25, $10, $4	# drorv
	.endif
	drotr32	$25, $10, 4	# dror32
	drotrv	$25, $10, $4	# drorv

	drol	$4,$5
	drol	$4,$5,$6
	drol	$4,1
	drol	$4,$5,0
	drol	$4,$5,1
	drol	$4,$5,31
	drol	$4,$5,32
	drol	$4,$5,33
	drol	$4,$5,63
	drol	$4,$5,64

	dror	$4,1
	dror	$4,$5,0
	dror	$4,$5,1
	dror	$4,$5,31
	.ifdef nanomips_broken
	dror	$4,$5
	dror	$4,$5,$6
	dror	$4,$5,32
	dror	$4,$5,33
	dror	$4,$5,63
	dror	$4,$5,64
	.endif

	drol	$4,$5,65
	drol	$4,$5,95
	drol	$4,$5,96
	drol	$4,$5,97
	drol	$4,$5,127

	.ifdef nanomips_broken
	dror	$4,$5,65
	dror	$4,$5,95
	dror	$4,$5,96
	dror	$4,$5,97
	dror	$4,$5,127
	.endif

	# unprivileged coprocessor instructions.
	# these tests use cp2 to avoid other (cp0, fpu, prefetch) opcodes.

	dmfc2   $3, $4
	dmtc2   $6, $7
