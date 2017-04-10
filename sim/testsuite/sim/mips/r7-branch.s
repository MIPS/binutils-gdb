# mips r7 branch tests (non FPU)
# mach:  mips32r7
# as:    -mabi=eabi -mmicromips
# ld:    -N -Ttext=0x80010000
# output: *\\npass\\n

  .include "testutils.inc"
  .include "utils-r7.inc"

  setup 4, 6

  .set noreorder

  .ent DIAG
DIAG:
  li $14, 0xffffffff
  li $13, 0x123
  li $20, 0x123
  li $12, 0x45
  li $7, 0x45
  li $8, 0xfffffffe
  li $11, 0
  li $15, Lret

  writemsg "[1] Test BEQZC", 4, 6
  beqzc $12, Lfail
  nop
  beqzc $11, L1
  nop
  fail

L1:
  writemsg "[2] Test BEQC", 4, 6
  beqc $12, $13, Lfail
  nop
  beqc $12, $7, L2
  nop
  fail

L2:
  writemsg "[3] Test BEQIC", 4, 6
  beqic $12, 0x46, Lfail
  nop
  beqic $12, 0x45, L3
  nop
  fail

L3:
  writemsg "[4] Test BNEC", 4, 6
  bnec $12, $7, Lfail
  nop
  bnec $12, $13, L4
  nop
  fail

L4:
  writemsg "[5] Test BNEIC", 4, 6
  bneic $12, 0x45, Lfail
  nop
  bneic $12, 0x46, L5
  nop
  fail

L5:
  writemsg "[6] Test BNEZC", 4, 6
  bnezc $11, Lfail
  nop
  bnezc $12, L6
  nop
  fail

L6:
  writemsg "[7] Test BLTC", 4, 6
  bltc $13, $12, Lfail
  nop
  bltc $12, $13, L7
  nop
  fail

L7:
  writemsg "[8] Test BGEC", 4, 6
  bgec $12, $13, Lfail
  nop
  bgec $13, $12, L8
  nop
  fail

L8:
  writemsg "[9] Test BGEIC", 4, 6
  bgeic $12, 0x46, Lfail
  nop
  bgeic $13, 0x44, L9
  nop
  fail

L9:
  writemsg "[10] Test BLTUC", 4, 6
  bltuc $14, $13, Lfail
  nop
  bltuc $8, $14, L10
  nop
  fail

L10:
  writemsg "[11] Test BLTIC", 4, 6
  bltic $12, 0x44, Lfail
  nop
  bltic $12, 0x46, L11
  nop
  fail

L11:
  writemsg "[12] Test BGEUC", 4, 6
  bgeuc $13, $14, Lfail
  nop
  bgeuc $14, $8, L12
  nop
  fail

L12:
  writemsg "[13] Test BGEUIC", 4, 6
  bgeuic $12, 0x46, Lfail
  nop
  bgeuic $12, 0x44, L13
  nop
  fail

L13:
  writemsg "[14] Test BC", 4, 6
  bc L14
  fail

L14:
  writemsg "[15] Test BALC", 4, 6
  balc Lret
  li $10, 1
  beqzc $10, L15
  nop
  fail

L15:
  writemsg "[16] Test MOVE.BALC", 4, 6
  move.balc $4, $20, Lret
  li $10, 1
  fp_assert $4, $20
  beqzc $10, L16
  nop
  fail

L16:
  writemsg "[17] Test JALRC[16]", 4, 6
  jalrc $15
  li $10, 1
  beqzc $10, L17
  nop
  fail

L17:
  writemsg "[18] Test JALRC", 4, 6
  jalrc $ra, $15
  li $10, 1
  beqzc $10, L18
  nop
  fail

L18:
  writemsg "[19] Test JALRC.HB", 4, 6
  jalrc.hb $ra, $15
  li $10, 1
  beqzc $10, L19
  nop
  fail

L19:
  writemsg "[20] Test JRC", 4, 6
  li $ra, L191
  jrc $15
L191:
  li $10, 1
  beqzc $10, L20
  nop
  fail

L20:
  li $9, Lret - L201 + 1
  writemsg "[21] Test BRC", 4, 6
  li $ra, L201
  brc $9
L201:
  li $10, 2
  beqzc $10, L21
  nop
  fail

L21:
  li $9, Lret - L211 + 1
  srl $9, 1
  writemsg "[22] Test BRSC", 4, 6
  li $ra, L211
  brsc $9
L211:
  li $10, 2
  beqzc $10, L22
  nop
  fail

L22:
  li $9, Lret - L221 + 1
  writemsg "[23] Test BALRC", 4, 6
  balrc $ra, $9
L221:
  li $10, 2
  beqzc $10, L23
  nop
  fail

L23:
  li $9, Lret - L231 + 1
  srl $9, 1
  writemsg "[24] Test BALRSC", 4, 6
  balrsc $ra, $9
L231:
  li $10, 2
  beqzc $10, L24
  nop
  fail

L24:
  writemsg "[25] Test BALC", 4, 6
  balc Lret
  li $10, 1
  beqzc $10, Lend
  nop
  fail

Lend:
  pass

Lfail:
  fail

  .end DIAG

Lret:
  li $10, 0
  addiu $ra, 4
  jrc $ra
