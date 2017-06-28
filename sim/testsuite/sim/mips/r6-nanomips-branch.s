# mips r6 nanoMIPS branch tests (non FPU)
# mach:  32r6
# as:    -m32
# ld:    -N -Ttext=0x80010000
# output: *\\npass\\n

  .include "testutils-r6-nanomips.inc"
  .include "utils-r6-nanomips.inc"

  setup

  .set noreorder

  .ent DIAG
DIAG:
  li $t2, 0xffffffff
  li $t1, 0x123
  li $s4, 0x123
  li $t0, 0x45
  li $a3, 0x45
  li $a4, 0xfffffffe
  li $a7, 0
  li $t3, Lret

  writemsg "[1] Test BEQZC"
  beqzc $t0, Lfail
  nop
  beqzc $a7, L1
  nop
  fail

L1:
  writemsg "[2] Test BEQC"
  beqc $t0, $t1, Lfail
  nop
  beqc $t0, $a3, L2
  nop
  fail

L2:
  writemsg "[3] Test BEQIC"
  beqic $t0, 0x46, Lfail
  nop
  beqic $t0, 0x45, L3
  nop
  fail

L3:
  writemsg "[4] Test BNEC"
  bnec $t0, $a3, Lfail
  nop
  bnec $t0, $t1, L4
  nop
  fail

L4:
  writemsg "[5] Test BNEIC"
  bneic $t0, 0x45, Lfail
  nop
  bneic $t0, 0x46, L5
  nop
  fail

L5:
  writemsg "[6] Test BNEZC"
  bnezc $a7, Lfail
  nop
  bnezc $t0, L6
  nop
  fail

L6:
  writemsg "[7] Test BLTC"
  bltc $t1, $t0, Lfail
  nop
  bltc $t0, $t1, L7
  nop
  fail

L7:
  writemsg "[8] Test BGEC"
  bgec $t0, $t1, Lfail
  nop
  bgec $t1, $t0, L8
  nop
  fail

L8:
  writemsg "[9] Test BGEIC"
  bgeic $t0, 0x46, Lfail
  nop
  bgeic $t1, 0x44, L9
  nop
  fail

L9:
  writemsg "[10] Test BLTUC"
  bltuc $t2, $t1, Lfail
  nop
  bltuc $a4, $t2, L10
  nop
  fail

L10:
  writemsg "[11] Test BLTIC"
  bltic $t0, 0x44, Lfail
  nop
  bltic $t0, 0x46, L11
  nop
  fail

L11:
  writemsg "[12] Test BGEUC"
  bgeuc $t1, $t2, Lfail
  nop
  bgeuc $t2, $a4, L12
  nop
  fail

L12:
  writemsg "[13] Test BGEIUC"
  bgeiuc $t0, 0x46, Lfail
  nop
  bgeiuc $t0, 0x44, L13
  nop
  fail

L13:
  writemsg "[14] Test BC"
  bc L14
  fail

L14:
  writemsg "[15] Test BALC"
  balc Lret
  li $a6, 1
  beqzc $a6, L15
  nop
  fail

L15:
  writemsg "[16] Test MOVE.BALC"
  move.balc $a0, $s4, Lret
  li $a6, 1
  fp_assert $a0, $s4
  beqzc $a6, L16
  nop
  fail

L16:
  writemsg "[17] Test JALRC[16]"
  jalrc $t3
  li $a6, 1
  beqzc $a6, L17
  nop
  fail

L17:
  writemsg "[18] Test JALRC"
  jalrc $ra, $t3
  li $a6, 1
  beqzc $a6, L18
  nop
  fail

L18:
  writemsg "[19] Test JALRC.HB"
  jalrc.hb $ra, $t3
  li $a6, 1
  beqzc $a6, L19
  nop
  fail

L19:
  writemsg "[20] Test JRC"
  li $ra, L191
  jrc $t3
L191:
  li $a6, 1
  beqzc $a6, L20
  nop
  fail

L20:
  li $a5, Lret - L201 + 1
  srl $a5, 1
  writemsg "[21] Test BRSC"
  li $ra, L201
  brsc $a5
L201:
  li $a6, 2
  beqzc $a6, L21
  nop
  fail

L21:
  li $a5, Lret - L211 + 1
  srl $a5, 1
  writemsg "[22] Test BALRSC"
  balrsc $ra, $a5
L211:
  li $a6, 2
  beqzc $a6, L22
  nop
  fail

L22:
  writemsg "[23] Test BALC"
  balc Lret
  li $a6, 1
  beqzc $a6, Lend
  nop
  fail

Lend:
  pass

Lfail:
  fail

  .end DIAG

Lret:
  li $a6, 0
  addiu $ra, 4
  jrc $ra
