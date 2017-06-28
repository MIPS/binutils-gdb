  .macro fp_assert a, b
  beqc \a, \b, 1f
  nop
  j _fail
  nop
1:
  .endm

  .macro nanomips_ck_move imm
  li $a1, \imm
  move $a0, $a1
  fp_assert $a0, $a1
  .endm

  .macro nanomips_ck_movep a, b, c, d, imm1, imm2
  li \c, \imm1
  li \d, \imm2
  movep \a, \b, \c, \d
  fp_assert \a, \c
  fp_assert \b, \d
  .endm

  .macro nanomips_ck_movnz inst, a, b, ret
  li $a3, 0xdeadbeef
  li $a0, \a
  li $a1, \b
  li $a2, \ret
  mov\inst $a3, $a0, $a1
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_1r inst, a, ret
  li $a0, \a
  li $a2, \ret
  \inst $a3, $a0
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_2r16 inst, a, b, ret
  li $a0, \a
  li $a1, \b
  li $a2, \ret
  \inst $a3, $a0, $a1
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_2r32 inst, a, b, ret
  li $a0, \a
  li $a1, \b
  li $a2, \ret
  \inst $a4, $a0, $a1
  fp_assert $a2, $a4
  .endm

  .macro nanomips_ck_1r1i16 inst, a, imm, ret
  li $a0, \a
  li $a2, \ret
  \inst $a3, $a0, \imm
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_1r1i32 inst, a, imm, ret
  li $a0, \a
  li $a2, \ret
  \inst $a4, $a0, \imm
  fp_assert $a2, $a4
  .endm

  .macro nanomips_ck_1r1i2 inst, a, imm, ret
  li $a0, \a
  li $a2, \ret
  \inst $a0, \imm
  fp_assert $a0, $a2
  .endm

  .macro nanomips_ck_2r1i inst, a, b, imm, ret
  li $a0, \a
  li $a1, \b
  li $a2, \ret
  \inst $a3, $a0, $a1, \imm
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_2s inst, a, b, ret
  li $a0, \a
  li $a1, \b
  li $a2, \ret
  mtc1 $a0, $f2
  mtc1 $a1, $f4
  \inst $f4, $f2
  mfc1 $a3, $f2
  fp_assert $a2, $a3
  .endm

  .macro nanomips_ck_3s inst, a, b, c, ret
  li $a0, \a
  li $a1, \b
  li $a2, \c
  li $a3, \ret
  mtc1 $a0, $f2
  mtc1 $a1, $f4
  mtc1 $a2, $f6
  \inst $f2, $f4, $f6
  mfc1 $a4, $f2
  fp_assert $a3, $a4
  .endm

  .macro nanomips_ck_2d inst, a, b, ret
  .data
1: .dword \a
2: .dword \b
3: .dword \ret
  .text
  la $a0, 1b
  la $a1, 2b
  la $a2, 3b
  ldc1 $f2, 0($a0)
  ldc1 $f4, 0($a1)
  lw $a3, 0($a2)
  lw $a4, 4($a2)
  \inst $f4, $f2

  #simulate dmfc1
  mfhc1 $a6, $f2
  mfc1 $a5, $f2
  fp_assert $a3, $a5
  fp_assert $a4, $a6
  .endm

  .macro nanomips_ck_3d inst, a, b, c, ret
  .data
1: .dword \a
2: .dword \b
3: .dword \c
4: .dword \ret
  .text
  la $a0, 1b
  la $a1, 2b
  la $a2, 3b
  la $t4, 4b
  ldc1 $f2, 0($a0)
  ldc1 $f4, 0($a1)
  ldc1 $f6, 0($a2)
  lw $a3, 0($t4)
  lw $a4, 4($t4)
  \inst $f2, $f4, $f6

  #simulate dmfc1
  mfhc1 $a6, $f2
  mfc1 $a5, $f2
  fp_assert $a3, $a5
  fp_assert $a4, $a6
  .endm
