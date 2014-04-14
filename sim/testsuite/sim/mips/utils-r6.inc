  .macro fp_assert a, b
  beq \a, \b, 1f
  nop
  j _fail
  nop
1:
  .endm

  .macro r6ck_1s inst, a, ret
  li $4, \a
  li $6, \ret
  .word \inst
  #\inst $7, $4
  fp_assert $6, $7
  .endm

  .macro r6ck_2s inst, a, b, ret
  li $4, \a
  li $5, \b
  li $6, \ret
  .word \inst
  #\inst $7, $4, $5
  fp_assert $6, $7
  .endm

  .macro r6ck_fm_s inst, a, b, c, ret
  li $4, \a
  li $5, \b
  li $6, \c
  li $7, \ret
  mtc1 $4, $f2
  mtc1 $5, $f4
  mtc1 $6, $f6
  .word \inst
  #\inst $f1, $f2, $f3
  mfc1 $8, $f2
  fp_assert $7, $8
  .endm

  .macro r6ck_fm_d inst, a, b, c, ret
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
  .word \inst
  #\inst $f1, $f2, $f3

  #simulate dmfc1
  mfhc1 $9, $f2
  mfc1 $10, $f2
  fp_assert $7, $9
  fp_assert $8, $10
  .endm
