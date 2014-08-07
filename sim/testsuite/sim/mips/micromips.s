# micromips switching test
# mach:  mips32r6 mips64r6
# as:    -mabi=eabi -mmicromips
# ld:    -N -Ttext=0x80010000 --relax
# output: *\\npass\\n

###########################################################################
# USE THE VERSIONS IN TESTUTILS.INC ONCE R6 JALX WORK GETS TO USE JAL

# $1, $4, $5, %6, are used as temps by the macros defined here.

	.macro writemsg msg
	la	$5, 901f
	li	$6, 902f - 901f
	.data
901:	.ascii	"\msg\n"
902:
	.previous
	.set push
	.set noreorder
	li	$4, 0
	.set at
	jalx	_dowrite
	.set noat
	nop
	.set pop
	.endm


	# The MIPS simulator uses "break 0x3ff" as the code to exit,
	# with the return value in $4 (a0).
	.macro exit rc
	li	$4, \rc
	break	0x3ff
	.endm


	.macro setup

	.global _start
	.global __start
	.ent _start
_start:
__start:
	.set push
	.set noreorder
	j	DIAG
	nop
	.set pop
	.end _start

	.global _fail
	.ent _fail
_fail:
	writemsg "fail"
	exit 1
	.end _fail

	.global _pass
	.ent _pass
_pass:
	writemsg "pass"
	exit 0
	.end _pass

	# The MIPS simulator can use multiple different monitor types,
	# so we hard-code the simulator "write" reserved instruction opcode,
	# rather than jumping to a vector that invokes it.  The operation
	# expects RA to point to the location at which to continue
	# after writing.
	.global _dowrite
	.ent _dowrite
_dowrite:
	# Write opcode (reserved instruction).  See sim_monitor and its
	# callers in sim/mips/interp.c. The nop is required here.
	nop
	.word	0x00000039 | ((8 << 1) << 6)
	.end _dowrite

	.endm	# setup


	.macro pass
	.set push
	.set noreorder
	jalx	_pass
	nop
	.set pop
	.endm


	.macro fail
	.set push
	.set noreorder
	jalx	_fail
	nop
	.set pop
	.endm
###########################################################################

  .include "utils-r6.inc"

  setup

  .set noreorder
  .set micromips
DIAG:

  writemsg "[1] Tests from uMIPSr6"

  .set noat
  writemsg "[1.1] JALX not-macro"
  auipc $at, %pcrel_hi(Mrfar)
  jialc $at, %pcrel_lo(Mrfar+4)
  .set at
  fail

  .set at
  writemsg "[1.2] JALX macro expansion"
  jalx Mrfar
  fail

  writemsg "[1.3] JIALC -> JALC relaxation"
  jalx Ufar
  fail

  writemsg "[1.4] JIALC -> BALC relaxation"
  jalx Unear
  fail

  .set noat
  li $7, 0xfffffffe
  writemsg "[1.5] JIC manual"
  jalc GetPC
  addiu $6, $6, 12
  move $ra, $6
  auipc $at, %pcrel_hi(Mrfar)
  jic $at, %pcrel_lo(Mrfar+4)
  .set at
  fail

  .set at
  writemsg "[1.6] JIC expansion"
  jalc GetPC
  addiu $6, $6, 12
  move $ra, $6
  j Mrfar
  fail

  .set noat
  writemsg "[1.7] JIC -> J relaxation"
  jalc GetPC
  addiu $6, $6, 10
  move $ra, $6
  auipc $at, %pcrel_hi(Ufar)
  jic $at, %pcrel_lo(Ufar+4)
  .set at
  fail

  .set noat
  writemsg "[1.8] JIC -> BC relaxation"
  jalc GetPC
  addiu $6, $6, 10
  move $ra, $6
  auipc $at, %pcrel_hi(Unear)
  jic $at, %pcrel_lo(Unear+4)
  .set at
  fail

  #Switch to the second half of the tests
  .set at
  jalx DIAG2

  .skip 128
  .align 3
  .set nomicromips
DIAG2:
  writemsg "[2] Tests from MIPSr6"

  .set noat
  writemsg "[2.1] JALX not-macro"
  auipc $at, %pcrel_hi(Urfar)
  jialc $at, %pcrel_lo(Urfar+4)
  .set at
  fail

  .set at
  writemsg "[2.2] JALX macro expansion"
  jalx Urfar
  fail

  writemsg "[2.3] JIALC -> JALC relaxation"
  jalx Mfar
  fail

  writemsg "[2.4] JIALC -> BALC relaxation"
  jalx Mnear
  fail

  writemsg "[2.5] JIC manual"
  jalx GetPC
  addiu $6, 16
  move $ra, $6
  .set noat
  auipc $at, %pcrel_hi(Urfar)
  jic $at, %pcrel_lo(Urfar+4)
  .set at
  fail

  writemsg "[2.6] JIC macro"
  jalx GetPC
  addiu $6, 16
  move $ra, $6
  j Urfar
  fail

  writemsg "[2.7] JIC -> J relaxation"
  jalx GetPC
  addiu $6, 16
  move $ra, $6
  j Mfar
  fail

  writemsg "[2.8] JIC -> BC relaxation"
  jalx GetPC
  addiu $6, 16
  move $ra, $6
  j Mnear
  fail

  pass

#####################################

# Near targets: b(al)c
  .set micromips
Unear:
  addiu $ra, 4
  jrc $ra

  .set nomicromips
Mnear:
  addiu $ra, 8
  jr $ra
  nop

# Far targets: j(al)

  .skip 0x7000000
  .set micromips
Ufar:
  addiu $ra, 4
  jrc $ra

  .skip 0x1000000
  .set nomicromips
  .align 3
Mfar:
  addiu $ra, 8
  jr $ra

# Really far targets: auipc + ji(al)c

  .skip 0x4000000
  .set micromips
Urfar:
  addiu $ra, 8
  jrc $ra

  .set nomicromips
  .align 3
Mrfar:
  addiu $ra, 4
  jr $ra
  nop
