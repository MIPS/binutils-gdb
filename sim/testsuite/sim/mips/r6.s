# mips r6 tests (non FPU)
# TODO once as knows about r6, change mach here
# mach:  mips32r2 mips64r2
# as:    -mabi=eabi
# ld:    -N -Ttext=0x80010000
# output: *\\npass\\n

  .include "testutils.inc"
  .include "utils-r6.inc"

  setup

  .set noreorder

  .ent DIAG
DIAG:

  writemsg "[1] Test MUL"
  #mul $7, $4, $5 = $7 <- LO($4*$5) = 0x00853898
  r6ck_2s 0x00853898, 7, 9, 63
  r6ck_2s 0x00853898, -7, -9, 63
  r6ck_2s 0x00853898, 61, -11, -671
  r6ck_2s 0x00853898, 1001, 1234, 1235234
  r6ck_2s 0x00853898, 123456789, 999999, 0x7eb1e22b
  r6ck_2s 0x00853898, 0xaaaabbbb, 0xccccdddd, 0x56787f6f

  writemsg "[2] Test MUH"
  #muh $7, $4, $5 = $7 <- HI($4*$5) = 0x008538d8
  r6ck_2s 0x008538d8, 61, -11, 0xffffffff
  r6ck_2s 0x008538d8, 1001, 1234, 0
  r6ck_2s 0x008538d8, 123456789, 999999, 0x7048
  r6ck_2s 0x008538d8, 0xaaaabbbb, 0xccccdddd, 0x111107f7

  writemsg "[3] Test MULU"
  #mulu $7, $4, $5 = $7 <- LO($4*$5) = 0x00853899
  r6ck_2s 0x00853899, 7, 9, 63
  r6ck_2s 0x00853898, -7, -9, 63
  r6ck_2s 0x00853898, 61, -11, -671
  r6ck_2s 0x00853899, 1001, 1234, 1235234
  r6ck_2s 0x00853899, 123456789, 999999, 0x7eb1e22b
  r6ck_2s 0x00853899, 0xaaaabbbb, 0xccccdddd, 0x56787f6f

  writemsg "[4] Test MUHU"
  #muhu $7, $4, $5 = $7 <- HI($4*$5) = 0x008538d9
  r6ck_2s 0x008538d9, 1001, 1234, 0
  r6ck_2s 0x008538d9, 123456789, 999999, 0x7048
  r6ck_2s 0x008538d9, 0xaaaabbbb, 0xccccdddd, 0x8888a18f
  r6ck_2s 0x008538d9, 0xaaaabbbb, 0xccccdddd, 0x8888a18f

  writemsg "[5] Test DIV"
  #div $7, $4, $5 = $7 <- $4/$5 = 0x0085389a
  r6ck_2s 0x0085389a, 10001, 10, 1000
  r6ck_2s 0x0085389a, -123456, 560, -220
  r6ck_2s 0x0085389a, 9, 100, 0

  writemsg "[6] Test MOD"
  #mod $7, $4, $5 = $7 <- $4%$5 = 0x008538da
  r6ck_2s 0x008538da, 10001, 10, 1
  r6ck_2s 0x008538da, -123456, 560, 0xffffff00
  r6ck_2s 0x008538da, 9, 100, 9

  writemsg "[7] Test DIVU"
  #divu $7, $4, $5 = $7 <- $4/$5 = 0x0085389b
  r6ck_2s 0x0085389b, 10001, 10, 1000
  r6ck_2s 0x0085389b, -123456, 560, 0x750674
  r6ck_2s 0x0085389b, 9, 100, 0
  r6ck_2s 0x0085389b, 0xaaaabbbb, 3, 0x38e393e9

  writemsg "[8] Test MODU"
  #modu $7, $4, $5 = $7 <- $4%$5 = 0x008538db
  r6ck_2s 0x008538db, 10001, 10, 1
  r6ck_2s 0x008538db, -123456, 560, 0
  r6ck_2s 0x008538db, 9, 100, 9
  r6ck_2s 0x008538db, 0xaaaabbbb, 5, 4

  writemsg "[9] Test LSA"
  #lsa $7, $4, $5, 4 = $7 <- $4 << (imm2+1) + $5 = 0x008538c5
  r6ck_2s 0x008538c5, 0x8001000, 2, 0x80010002
  r6ck_2s 0x008538c5, 0x8001000, 0xa000, 0x8001a000
  r6ck_2s 0x008538c5, 0x8200000, 0x2000068, 0x84000068

  writemsg "[10] Test LUI"
  #lui $7, $4, IMM = $7 <- $4 + sign_extend(IMM<<16) = 0x3c87XXXX
  r6ck_1s 0x3c87dead, 0x0000c0de, 0xdeadc0de
  r6ck_1s 0x3c870123, 0x00004567, 0x01234567
  r6ck_1s 0x3c87abab, 0x0000eeff, 0xababeeff

  pass

  .end DIAG
