# mips r6 nanomips common tests (must be micromips compatible)
# mach:  mips32r7
# as:    -mabi=eabi -mmicromips
# ld:    -N -Ttext=0x80010000
# output: *\\npass\\n

  .include "testutils.inc"
  .include "utils-r6-nanomips.inc"

  setup 4, 6

  .data
dval1:  .word 0xabcd1234
dval2: .word 0x1234eeff

  .text

  .set noreorder

  .ent DIAG
DIAG:

  writemsg "[1] Test MUL", 4, 6
  nanomips_ck_2r32 mul, 7, 9, 63
  nanomips_ck_2r32 mul, -7, -9, 63
  nanomips_ck_2r32 mul, 61, -11, -671
  nanomips_ck_2r32 mul, 1001, 1234, 1235234
  nanomips_ck_2r32 mul, 123456789, 999999, 0x7eb1e22b
  nanomips_ck_2r32 mul, 0xaaaabbbb, 0xccccdddd, 0x56787f6f

  writemsg "[2] Test MULU", 4, 6
  nanomips_ck_2r32 mulu, 7, 9, 63
  nanomips_ck_2r32 mulu, -7, -9, 63
  nanomips_ck_2r32 mulu, 61, -11, -671
  nanomips_ck_2r32 mulu, 1001, 1234, 1235234
  nanomips_ck_2r32 mulu, 123456789, 999999, 0x7eb1e22b
  nanomips_ck_2r32 mulu, 0xaaaabbbb, 0xccccdddd, 0x56787f6f

  writemsg "[3] Test MUH", 4, 6
  nanomips_ck_2r32 muh, 61, -11, 0xffffffff
  nanomips_ck_2r32 muh, 1001, 1234, 0
  nanomips_ck_2r32 muh, 123456789, 999999, 0x7048
  nanomips_ck_2r32 muh, 0xaaaabbbb, 0xccccdddd, 0x111107f7

  writemsg "[4] Test MUHU", 4, 6
  nanomips_ck_2r32 muhu, 1001, 1234, 0
  nanomips_ck_2r32 muhu, 123456789, 999999, 0x7048
  nanomips_ck_2r32 muhu, 0xaaaabbbb, 0xccccdddd, 0x8888a18f
  nanomips_ck_2r32 muhu, 0xaaaabbbb, 0xccccdddd, 0x8888a18f

  writemsg "[5] Test DIV", 4, 6
  nanomips_ck_2r32 div, 10001, 10, 1000
  nanomips_ck_2r32 div, -123456, 560, -220
  nanomips_ck_2r32 div, 9, 100, 0

  writemsg "[6] Test DIVU", 4, 6
  nanomips_ck_2r32 divu, 10001, 10, 1000
  nanomips_ck_2r32 divu, -123456, 560, 0x750674
  nanomips_ck_2r32 divu, 9, 100, 0
  nanomips_ck_2r32 divu, 0xaaaabbbb, 3, 0x38e393e9

  writemsg "[7] Test MOD", 4, 6
  nanomips_ck_2r32 mod, 10001, 10, 1
  nanomips_ck_2r32 mod, -123456, 560, 0xffffff00
  nanomips_ck_2r32 mod, 9, 100, 9

  writemsg "[8] Test MODU", 4, 6
  nanomips_ck_2r32 modu, 10001, 10, 1
  nanomips_ck_2r32 modu, -123456, 560, 0
  nanomips_ck_2r32 modu, 9, 100, 9

  writemsg "[9] Test MOVE", 4, 6
  nanomips_ck_move 12345
  nanomips_ck_move 0xaabbccdd
  nanomips_ck_move -15316136
  nanomips_ck_move 0xffffcccc

  writemsg "[10] Test MOVEP", 4, 6
  nanomips_ck_movep $4, $5, $16, $17, 0xaaaabbbb, 0xccccdddd
  nanomips_ck_movep $5, $6, $17, $18, 0xbbbbcccc, 0xddddeeee
  nanomips_ck_movep $5, $6, $22, $23, 0xbbbbcccc, 0xddddeeee
  nanomips_ck_movep $16, $17, $4, $5, 0xaabbccdd, 0xffffcccc
  nanomips_ck_movep $18, $19, $6, $7, 0xaabbccdd, 0xffffcccc
  nanomips_ck_movep $22, $23, $6, $7, 0xaabbccdd, 0xffffcccc

  writemsg "[11] Test MOVN", 4, 6
  nanomips_ck_movnz n, 10, 1, 10
  nanomips_ck_movnz n, 10, 0, 0xdeadbeef
  nanomips_ck_movnz n, 0xaabbccdd, 1, 0xaabbccdd
  nanomips_ck_movnz n, 0xaabbccdd, 0, 0xdeadbeef

  writemsg "[12] Test MOVZ", 4, 6
  nanomips_ck_movnz z, 10, 0, 10
  nanomips_ck_movnz z, 10, 1, 0xdeadbeef
  nanomips_ck_movnz z, 0xaabbccdd, 0, 0xaabbccdd
  nanomips_ck_movnz z, 0xaabbccdd, 1, 0xdeadbeef

  writemsg "[13] Test LI[48]", 4, 6
  li $4, 0xaabbccdd
  li $5, 0xaabbccdd
  fp_assert $4, $5

  li $4, 0xffffffff
  li $5, -1
  fp_assert $4, $5

  writemsg "[14] Test ADD", 4, 6
  nanomips_ck_2r32 add, 10, 5, 15
  nanomips_ck_2r32 add, -10, -5, -15
  nanomips_ck_2r32 add, -999, 1000, 1
  nanomips_ck_2r32 add, 0xaabbccdd, 0x00bbccdd, 0xab7799ba
  nanomips_ck_2r32 add, 123456789, 99999, 123556788
  nanomips_ck_2r32 add, 100, -1, 99
  nanomips_ck_2r32 add, 100, 0xffffffff, 99

  writemsg "[15] Test SUB", 4, 6
  nanomips_ck_2r32 sub, 10, 5, 5
  nanomips_ck_2r32 sub, -10, -5, -5
  nanomips_ck_2r32 sub, -999, 1, -1000
  nanomips_ck_2r32 sub, 0xaabbccdd, 0x11111111, 0x99aabbcc
  nanomips_ck_2r32 sub, 123456789, 99999, 123356790
  nanomips_ck_2r32 sub, 100, -1, 101
  nanomips_ck_2r32 sub, 100, 0xffffffff, 101

  writemsg "[16] Test SUBU", 4, 6
  nanomips_ck_2r32 subu, 10, 5, 5
  nanomips_ck_2r32 subu, -10, -5, -5
  nanomips_ck_2r32 subu, -999, 1, -1000
  nanomips_ck_2r32 subu, 0xaabbccdd, 0x11111111, 0x99aabbcc
  nanomips_ck_2r32 subu, 123456789, 99999, 123356790
  nanomips_ck_2r32 subu, 100, -1, 101
  nanomips_ck_2r32 subu, 100, 0xffffffff, 101

  writemsg "[17] Test SUBU[16]", 4, 6
  nanomips_ck_2r16 subu, 10, 5, 5
  nanomips_ck_2r16 subu, -10, -5, -5
  nanomips_ck_2r16 subu, -999, 1, -1000
  nanomips_ck_2r16 subu, 0xaabbccdd, 0x11111111, 0x99aabbcc
  nanomips_ck_2r16 subu, 123456789, 99999, 123356790
  nanomips_ck_2r16 subu, 100, -1, 101
  nanomips_ck_2r16 subu, 100, 0xffffffff, 101

  writemsg "[18] Test ADDIU", 4, 6
  nanomips_ck_1r1i32 addiu, 10, 5, 15
  nanomips_ck_1r1i32 addiu, -10, -5, -15
  nanomips_ck_1r1i32 addiu, -999, 1000, 1
  nanomips_ck_1r1i32 addiu, 0xaabbccdd, 0x111, 0xaabbcdee
  nanomips_ck_1r1i32 addiu, 123456789, 999, 123457788
  nanomips_ck_1r1i32 addiu, 100, -1, 99
  nanomips_ck_1r1i32 addiu, 100, -10, 90

  writemsg "[19] Test ADDIU[48]", 4, 6
  nanomips_ck_1r1i2 addiu, 10, 5, 15
  nanomips_ck_1r1i2 addiu, -10, -5, -15
  nanomips_ck_1r1i2 addiu, -999, 1000, 1
  nanomips_ck_1r1i2 addiu, 0xaabbccdd, 0x11111111, 0xbbccddee
  nanomips_ck_1r1i2 addiu, 123456789, 999999, 124456788
  nanomips_ck_1r1i2 addiu, 100, -1, 99
  nanomips_ck_1r1i2 addiu, 100, 0xffffffff, 99

  writemsg "[20] Test ADDU", 4, 6
  nanomips_ck_2r32 addu, 10, 5, 15
  nanomips_ck_2r32 addu, -10, -5, -15
  nanomips_ck_2r32 addu, -999, 1000, 1
  nanomips_ck_2r32 addu, 0xaabbccdd, 0x00bbccdd, 0xab7799ba
  nanomips_ck_2r32 addu, 123456789, 99999, 123556788
  nanomips_ck_2r32 addu, 100, -1, 99
  nanomips_ck_2r32 addu, 100, 0xffffffff, 99

  writemsg "[21] Test ADDU[16]", 4, 6
  nanomips_ck_2r16 addu, 10, 5, 15
  nanomips_ck_2r16 addu, -10, -5, -15
  nanomips_ck_2r16 addu, -999, 1000, 1
  nanomips_ck_2r16 addu, 0xaabbccdd, 0x00bbccdd, 0xab7799ba
  nanomips_ck_2r16 addu, 123456789, 99999, 123556788
  nanomips_ck_2r16 addu, 100, -1, 99
  nanomips_ck_2r16 addu, 100, 0xffffffff, 99

  writemsg "[22] Test AND", 4, 6
  nanomips_ck_2r32 and, 0x00000001, 0x00000001, 0x00000001
  nanomips_ck_2r32 and, 0x00000001, 0x00000000, 0x00000000
  nanomips_ck_2r32 and, 0x00ffffff, 0xaabbccdd, 0x00bbccdd
  nanomips_ck_2r32 and, 0x000fffff, 0xaabbccdd, 0x000bccdd
  nanomips_ck_2r32 and, 0x0000ffff, 0xaabbccdd, 0x0000ccdd

  writemsg "[23] Test AND[16]", 4, 6
  nanomips_ck_2r16 and, 0x00000001, 0x00000001, 0x00000001
  nanomips_ck_2r16 and, 0x00000001, 0x00000000, 0x00000000
  nanomips_ck_2r16 and, 0x00ffffff, 0xaabbccdd, 0x00bbccdd
  nanomips_ck_2r16 and, 0x000fffff, 0xaabbccdd, 0x000bccdd
  nanomips_ck_2r16 and, 0x0000ffff, 0xaabbccdd, 0x0000ccdd

  writemsg "[24] Test ANDI[16]", 4, 6
  nanomips_ck_1r1i16 andi, 0x00000001, 0x00000001, 0x00000001
  nanomips_ck_1r1i16 andi, 0x00000001, 0x00000000, 0x00000000
  nanomips_ck_1r1i16 andi, 0x0000000f, 0x00000005, 0x00000005
  nanomips_ck_1r1i16 andi, 0x0000000e, 0x00000007, 0x00000006
  nanomips_ck_1r1i16 andi, 0x00000003, 0x00000001, 0x00000001

  writemsg "[25] Test ANDI", 4, 6
  nanomips_ck_1r1i32 andi, 0x000000ff, 0x000000f0, 0x000000f0
  nanomips_ck_1r1i32 andi, 0x000000ff, 0x0000000f, 0x0000000f
  nanomips_ck_1r1i32 andi, 0x00000aaa, 0x00000555, 0x00000000
  nanomips_ck_1r1i32 andi, 0x00000fff, 0x00000abc, 0x00000abc
  nanomips_ck_1r1i32 andi, 0x00000033, 0x00000022, 0x00000022

  writemsg "[26] Test OR", 4, 6
  nanomips_ck_2r32 or, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_2r32 or, 0xffffffff, 0x00000000, 0xffffffff
  nanomips_ck_2r32 or, 0xaaaaaaaa, 0x55555555, 0xffffffff
  nanomips_ck_2r32 or, 0xa0000000, 0x00000000, 0xa0000000
  nanomips_ck_2r32 or, 0x0000ffff, 0xaabbccdd, 0xaabbffff

  writemsg "[27] Test OR[16]", 4, 6
  nanomips_ck_2r16 or, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_2r16 or, 0xffffffff, 0x00000000, 0xffffffff
  nanomips_ck_2r16 or, 0xaaaaaaaa, 0x55555555, 0xffffffff
  nanomips_ck_2r16 or, 0xa0000000, 0x00000000, 0xa0000000
  nanomips_ck_2r16 or, 0x0000ffff, 0xaabbccdd, 0xaabbffff

  writemsg "[28] Test ORI", 4, 6
  nanomips_ck_1r1i32 ori, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_1r1i32 ori, 0xffffffff, 0x00000000, 0xffffffff
  nanomips_ck_1r1i32 ori, 0xaaaaaaaa, 0x00000055, 0xaaaaaaff
  nanomips_ck_1r1i32 ori, 0xa0000000, 0x00000000, 0xa0000000
# nanomips_ck_1r1i32 ori, 0xfffff000, 0x00000abc, 0xfffffabc

  writemsg "[29] Test NOR", 4, 6
  nanomips_ck_2r32 nor, 0x00000001, 0x00000000, 0xfffffffe
  nanomips_ck_2r32 nor, 0xffffffff, 0x00000000, 0x00000000
  nanomips_ck_2r32 nor, 0xaaaaaaaa, 0x55555555, 0x00000000
  nanomips_ck_2r32 nor, 0x00000000, 0x00000000, 0xffffffff
  nanomips_ck_2r32 nor, 0x0000ffff, 0xaabbccdd, 0x55440000

  writemsg "[30] Test XOR", 4, 6
  nanomips_ck_2r32 xor, 0x00000001, 0x00000001, 0x00000000
  nanomips_ck_2r32 xor, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_2r32 xor, 0xaaaaaaaa, 0x55555555, 0xffffffff
  nanomips_ck_2r32 xor, 0xffffffff, 0xffffffff, 0x00000000
  nanomips_ck_2r32 xor, 0x0000ffff, 0xaabbccdd, 0xaabb3322

  writemsg "[31] Test XOR[16]", 4, 6
  nanomips_ck_2r16 xor, 0x00000001, 0x00000001, 0x00000000
  nanomips_ck_2r16 xor, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_2r16 xor, 0xaaaaaaaa, 0x55555555, 0xffffffff
  nanomips_ck_2r16 xor, 0xffffffff, 0xffffffff, 0x00000000
  nanomips_ck_2r16 xor, 0x0000ffff, 0xaabbccdd, 0xaabb3322

  writemsg "[32] Test XORI", 4, 6
  nanomips_ck_1r1i32 xori, 0x00000001, 0x00000001, 0x00000000
  nanomips_ck_1r1i32 xori, 0x00000001, 0x00000000, 0x00000001
  nanomips_ck_1r1i32 xori, 0xaaaaaaaa, 0x00000555, 0xaaaaafff
# nanomips_ck_1r1i32 xori, 0xffffffff, 0x00000fff, 0xfffff000
# nanomips_ck_1r1i32 xori, 0x00000fff, 0x00000abc, 0x00000543

  writemsg "[33] Test NOT[16]", 4, 6
  nanomips_ck_1r not, 0x00000001, 0xfffffffe
  nanomips_ck_1r not, 0xffffffff, 0x00000000
  nanomips_ck_1r not, 0xffff0000, 0x0000ffff
  nanomips_ck_1r not, 0x00000000, 0xffffffff
  nanomips_ck_1r not, 0xaaaaaaaa, 0x55555555

  writemsg "[34] Test SLL", 4, 6
  nanomips_ck_1r1i32 sll, 0x00000001, 1, 0x00000002
  nanomips_ck_1r1i32 sll, 0x00000001, 2, 0x00000004
  nanomips_ck_1r1i32 sll, 0x0000000f, 4, 0x000000f0
  nanomips_ck_1r1i32 sll, 0x0000ffff, 5, 0x001fffe0
  nanomips_ck_1r1i32 sll, 0x0000ffff, 6, 0x003fffc0

  writemsg "[35] Test SLL[16]", 4, 6
  nanomips_ck_1r1i16 sll, 0x00000001, 1, 0x00000002
  nanomips_ck_1r1i16 sll, 0x00000001, 2, 0x00000004
  nanomips_ck_1r1i16 sll, 0x0000000f, 4, 0x000000f0
  nanomips_ck_1r1i16 sll, 0x0000ffff, 5, 0x001fffe0
  nanomips_ck_1r1i16 sll, 0x0000ffff, 6, 0x003fffc0

  writemsg "[36] Test SLLV", 4, 6
  nanomips_ck_2r32 sllv, 0x00000001, 1, 0x00000002
  nanomips_ck_2r32 sllv, 0x00000001, 2, 0x00000004
  nanomips_ck_2r32 sllv, 0x0000000f, 4, 0x000000f0
  nanomips_ck_2r32 sllv, 0x0000ffff, 5, 0x001fffe0
  nanomips_ck_2r32 sllv, 0x0000ffff, 6, 0x003fffc0

  writemsg "[37] Test SRL", 4, 6
  nanomips_ck_1r1i32 srl, 0x00000001, 1, 0x00000000
  nanomips_ck_1r1i32 srl, 0x00000004, 2, 0x00000001
  nanomips_ck_1r1i32 srl, 0x000000f0, 4, 0x0000000f
  nanomips_ck_1r1i32 srl, 0xffff0000, 5, 0x07fff800
  nanomips_ck_1r1i32 srl, 0xffff0000, 6, 0x03fffc00

  writemsg "[38] Test SRL[16]", 4, 6
  nanomips_ck_1r1i16 srl, 0x00000001, 1, 0x00000000
  nanomips_ck_1r1i16 srl, 0x00000004, 2, 0x00000001
  nanomips_ck_1r1i16 srl, 0x000000f0, 4, 0x0000000f
  nanomips_ck_1r1i16 srl, 0xffff0000, 5, 0x07fff800
  nanomips_ck_1r1i16 srl, 0xffff0000, 6, 0x03fffc00

  writemsg "[39] Test SEH", 4, 6
  nanomips_ck_1r seh, 0x0000ffff, 0xffffffff
  nanomips_ck_1r seh, 0x0000ffff, -1
  nanomips_ck_1r seh, 0x00001234, 0x00001234
  nanomips_ck_1r seh, 0x00008234, 0xffff8234

  writemsg "[40] Test SEB", 4, 6
  nanomips_ck_1r seb, 0x000000ff, 0xffffffff
  nanomips_ck_1r seb, 0x000000ff, -1
  nanomips_ck_1r seb, 0x00000070, 0x00000070
  nanomips_ck_1r seb, 0x00000080, 0xffffff80

  writemsg "[41] Test SEQI", 4, 6
  nanomips_ck_1r1i2 seqi, 0, 0, 1
  nanomips_ck_1r1i2 seqi, 1, 1, 1
  nanomips_ck_1r1i2 seqi, 1, 0, 0

  writemsg "[42] Test SLT", 4, 6
  nanomips_ck_2r32 slt, 10, 9, 0
  nanomips_ck_2r32 slt, 10, 11, 1
  nanomips_ck_2r32 slt, 10, 10, 0

  writemsg "[43] Test SLTU", 4, 6
  nanomips_ck_2r32 sltu, 10, 9, 0
  nanomips_ck_2r32 sltu, 10, 11, 1
  nanomips_ck_2r32 sltu, 10, 10, 0

  writemsg "[44] Test SLTI", 4, 6
  nanomips_ck_1r1i2 slti, 10, 9, 0
  nanomips_ck_1r1i2 slti, 10, 11, 1
  nanomips_ck_1r1i2 slti, 10, 10, 0

  writemsg "[45] Test SLTIU", 4, 6
  nanomips_ck_1r1i2 sltiu, 10, 9, 0
  nanomips_ck_1r1i2 sltiu, 10, 11, 1
  nanomips_ck_1r1i2 sltiu, 10, 10, 0

  writemsg "[46] Test LSA", 4, 6
  nanomips_ck_2r1i lsa, 1, 2, 2, 6
  nanomips_ck_2r1i lsa, 0x8000, 0xa000, 1, 0x1a000
  nanomips_ck_2r1i lsa, 0x82, 0x2000068, 3, 0x2000478

  writemsg "[47] Test ROTR", 4, 6
  nanomips_ck_2r32 rotr 0x1234, 16, 0x12340000
  nanomips_ck_2r32 rotr 0x12345678, 16, 0x56781234
  nanomips_ck_2r32 rotr 0x1, 1, 0x80000000
  nanomips_ck_2r32 rotr 0x12345678, 32, 0x12345678

  writemsg "[48] Test ROTRV", 4, 6
  nanomips_ck_2r32 rotrv 0x1234, 16, 0x12340000
  nanomips_ck_2r32 rotrv 0x12345678, 16, 0x56781234
  nanomips_ck_2r32 rotrv 0x1, 1, 0x80000000
  nanomips_ck_2r32 rotrv 0x12345678, 32, 0x12345678

  writemsg "[49] Test SRA", 4, 6
  nanomips_ck_1r1i32 sra 0x00001234, 4, 0x00000123
  nanomips_ck_1r1i32 sra 0x00001234, 12, 0x00000001
  nanomips_ck_1r1i32 sra 0xaabbccdd, 31, 0xffffffff

  writemsg "[50] Test SRAV", 4, 6
  nanomips_ck_2r32 srav 0x00001234, 0x00000004, 0x00000123
  nanomips_ck_2r32 srav 0x00001234, 0xffffffe4, 0x00000123
  nanomips_ck_2r32 srav 0xaabbccdd, 0xfffffff0, 0xffffaabb

  writemsg "[51] Test SRLV", 4, 6
  nanomips_ck_2r32 srlv 0x00001234, 0x00000004, 0x00000123
  nanomips_ck_2r32 srlv 0x00001234, 0xffffffe4, 0x00000123
  nanomips_ck_2r32 srlv 0xaabbccdd, 0xfffffff0, 0x0000aabb

  writemsg "[52] Test SOV", 4, 6
  nanomips_ck_2r32 sov, 0x7fffffff, 1, 1
  nanomips_ck_2r32 sov, 0x7ffffffe, 1, 0
  nanomips_ck_2r32 sov, 0x80000001, -1, 0
  nanomips_ck_2r32 sov, 0x80000000, -1, 1

  writemsg "[53] Test BITSWAP"
  nanomips_ck_1r bitswap, 0xaabbccdd, 0x55dd33bb
  nanomips_ck_1r bitswap, 0x11884422, 0x88112244

  writemsg "[54] Test CLO"
  nanomips_ck_1r clo, 0x00000001, 0
  nanomips_ck_1r clo, 0xf0000000, 4
  nanomips_ck_1r clo, 0xff000000, 8
  nanomips_ck_1r clo, 0xfff00000, 12
  nanomips_ck_1r clo, 0x0f000000, 0
  nanomips_ck_1r clo, 0xffffffff, 32

  writemsg "[55] Test CLO"
  nanomips_ck_1r clz, 0x00000001, 31
  nanomips_ck_1r clz, 0xf0000000, 0
  nanomips_ck_1r clz, 0x0000000f, 28
  nanomips_ck_1r clz, 0x000000ff, 24
  nanomips_ck_1r clz, 0x0000ffff, 16
  nanomips_ck_1r clz, 0x0fffffff, 4


  pass

  .end DIAG
