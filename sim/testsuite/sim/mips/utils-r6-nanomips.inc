  .macro fp_assert a, b
  beqc \a, \b, 1f
  nop
  j _fail
  nop
1:
  .endm

  .macro nanomips_ck_move imm
  li $5, \imm
  move $4, $5
  fp_assert $4, $5
  .endm

  .macro nanomips_ck_movep a, b, c, d, imm1, imm2
  li \c, \imm1
  li \d, \imm2
  movep \a, \b, \c, \d
  fp_assert \a, \c
  fp_assert \b, \d
  .endm

  .macro nanomips_ck_movnz inst, a, b, ret
  li $7, 0xdeadbeef
  li $4, \a
  li $5, \b
  li $6, \ret
  mov\inst $7, $4, $5
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_1r inst, a, ret
  li $4, \a
  li $6, \ret
  \inst $7, $4
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_2r16 inst, a, b, ret
  li $4, \a
  li $5, \b
  li $6, \ret
  \inst $7, $4, $5
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_2r32 inst, a, b, ret
  li $4, \a
  li $5, \b
  li $6, \ret
  \inst $8, $4, $5
  fp_assert $6, $8
  .endm

  .macro nanomips_ck_1r1i16 inst, a, imm, ret
  li $4, \a
  li $6, \ret
  \inst $7, $4, \imm
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_1r1i32 inst, a, imm, ret
  li $4, \a
  li $6, \ret
  \inst $8, $4, \imm
  fp_assert $6, $8
  .endm

  .macro nanomips_ck_1r1i2 inst, a, imm, ret
  li $4, \a
  li $6, \ret
  \inst $4, \imm
  fp_assert $4, $6
  .endm

  .macro nanomips_ck_2r1i inst, a, b, imm, ret
  li $4, \a
  li $5, \b
  li $6, \ret
  \inst $7, $4, $5, \imm
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_2s inst, a, b, ret
  li $4, \a
  li $5, \b
  li $6, \ret
  mtc1 $4, $f2
  mtc1 $5, $f4
  \inst $f4, $f2
  mfc1 $7, $f2
  fp_assert $6, $7
  .endm

  .macro nanomips_ck_3s inst, a, b, c, ret
  li $4, \a
  li $5, \b
  li $6, \c
  li $7, \ret
  mtc1 $4, $f2
  mtc1 $5, $f4
  mtc1 $6, $f6
  \inst $f2, $f4, $f6
  mfc1 $8, $f2
  fp_assert $7, $8
  .endm

  .macro nanomips_ck_2d inst, a, b, ret
  .data
1: .dword \a
2: .dword \b
3: .dword \ret
  .text
  la $4, 1b
  la $5, 2b
  la $6, 3b
  ldc1 $f2, 0($4)
  ldc1 $f4, 0($5)
  lw $7, 0($6)
  lw $8, 4($6)
  \inst $f4, $f2

  #simulate dmfc1
  mfhc1 $9, $f2
  mfc1 $10, $f2
  fp_assert $7, $9
  fp_assert $8, $10
  .endm

  .macro nanomips_ck_3d inst, a, b, c, ret
  .data
1: .dword \a
2: .dword \b
3: .dword \c
4: .dword \ret
  .text
  la $4, 1b
  la $5, 2b
  la $6, 3b
  la $2, 4b
  ldc1 $f2, 0($4)
  ldc1 $f4, 0($5)
  ldc1 $f6, 0($6)
  lw $7, 0($2)
  lw $8, 4($2)
  \inst $f2, $f4, $f6

  #simulate dmfc1
  mfhc1 $9, $f2
  mfc1 $10, $f2
  fp_assert $7, $9
  fp_assert $8, $10
  .endm
