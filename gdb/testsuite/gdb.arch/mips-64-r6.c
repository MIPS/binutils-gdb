/*
   Copyright 2023-2025 Free Software Foundation, Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#define xstr(s) str(s)
#define str(s) #s

/* ============ macros from sim/testutils/mips/utils-r6.inc ============= */

/* 58 is local label to exit with errcode != 0, indicating error.  */
#define fp_assert(a, b) "beq " xstr (a) ", " xstr (b) ", 1f \n\t" \
  "nop \n\t" \
  "b 58f \n\t" \
  "nop \n\t" \
  "1: \n\t"

/* Clobbers: $4,$6,$7.  */
#define r6ck_1r(inst, a, ret) \
  "li $4, " xstr (a) "    \n\t" \
  "li $6, " xstr (ret) "  \n\t" \
  xstr (inst) " $7, $4    \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$6,$7.  */
#define r6ck_1dr(inst, a, ret) \
  "ld $4, " xstr (a) "   \n\t" \
  "ld $6, " xstr (ret) " \n\t" \
  xstr (inst) " $7, $4   \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$5,$6,$7.  */
#define r6ck_2r(inst, a, b, ret) \
  "li $4, " xstr (a) "   \n\t" \
  "li $5, " xstr (b) "   \n\t" \
  "li $6, " xstr (ret) " \n\t" \
  xstr (inst) " $7, $4, $5   \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$5,$6,$7.  */
#define r6ck_2dr(inst, a, b, ret) \
  "ld $4, " xstr (a) "    \n\t" \
  "ld $5, " xstr (b) "    \n\t" \
  "ld $6, " xstr (ret) "  \n\t" \
  xstr (inst) " $7, $4, $5  \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$5,$6,$7.  */
#define r6ck_2dr1i(inst, a, b, imm, ret) \
  "ld $4, " xstr (a) "      \n\t" \
  "ld $5, " xstr (b) "      \n\t" \
  "ld $6, " xstr (ret) "    \n\t" \
  xstr (inst) " $7, $4, $5, " xstr (imm) "  \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$6,$7.  */
#define r6ck_1r1i(inst, a, imm, ret) \
  "li $4, " xstr (a) "      \n\t" \
  "li $6, " xstr (ret) "    \n\t" \
  xstr (inst) " $7, $4, " xstr (imm) "  \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$6,$7.  */
#define r6ck_1dr1i(inst, a, imm, ret) \
  "ld $4, " xstr (a) "     \n\t" \
  "ld $6, " xstr (ret) "   \n\t" \
  xstr (inst) " $7, $4, " xstr (imm) "  \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$6.  */
#define r6ck_0dr1i(inst, a, imm, ret) \
  "ld $4, " xstr (a) "     \n\t" \
  "ld $6, " xstr (ret) "   \n\t" \
  xstr (inst) " $4, $4, " xstr (imm) "   \n\t" \
  fp_assert ($6, $4)

/* Clobbers: $4,$5,$6,$7.  */
#define r6ck_2r1i(inst, a, b, imm, ret) \
  "li $4, " xstr (a) "     \n\t" \
  "li $5, " xstr (b) "     \n\t" \
  "li $6, " xstr (ret) "   \n\t" \
  xstr (inst) " $7, $4, $5, " xstr (imm) "   \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$5,$6,$7,$8,$f2,$f4,$f6.  */
#define r6ck_3s(inst, a, b, c, ret) \
  "li $4, " xstr (a) "     \n\t" \
  "li $5, " xstr (b) "     \n\t" \
  "li $6, " xstr (c) "     \n\t" \
  "li $7, " xstr (ret) "   \n\t" \
  "mtc1 $4, $f2           \n\t" \
  "mtc1 $5, $f4           \n\t" \
  "mtc1 $6, $f6           \n\t" \
  xstr (inst) " $f2, $f4, $f6       \n\t" \
  "mfc1 $8, $f2           \n\t" \
  fp_assert ($7, $8)

/* Clobbers: $4,$5,$6,$7,$f2,$f4.  */
#define r6ck_2s(inst, a, b, ret) \
  "li $4, " xstr (a) "       \n\t" \
  "li $5, " xstr (b) "       \n\t" \
  "li $6, " xstr (ret) "     \n\t" \
  "mtc1 $4, $f2             \n\t" \
  "mtc1 $5, $f4             \n\t" \
  xstr (inst) " $f2, $f4     \n\t" \
  "mfc1 $7, $f2             \n\t" \
  fp_assert ($6, $7)

/* Clobbers: $4,$5,$6,$7,$8,$9,$10,$f2,$f4.  */
#define r6ck_2d(inst, a, b, ret) \
  ".data                  \n\t" \
  "1: .dword " xstr (a) "    \n\t" \
  "2: .dword " xstr (b) "    \n\t" \
  "3: .dword " xstr (ret) "  \n\t" \
  ".text                   \n\t" \
  "dla $4, 1b              \n\t" \
  "dla $5, 2b              \n\t" \
  "dla $6, 3b              \n\t" \
  "ldc1 $f2, 0($4)        \n\t" \
  "ldc1 $f4, 0($5)        \n\t" \
  "lw $7, 0($6)           \n\t" \
  "lw $8, 4($6)           \n\t" \
  xstr (inst) " $f2, $f4   \n\t" \
  "mfhc1 $9, $f2          \n\t" \
  "mfc1 $10, $f2          \n\t" \
  fp_assert ($7, $9) \
  fp_assert ($8, $10)

/* Clobbers: $2,$4,$5,$6,$7,$8,$9,$10,$f2,$f4,$f6.  */
#define r6ck_3d(inst, a, b, c, ret) \
  ".data                                \n\t" \
  "1: .dword " xstr (a) "                  \n\t" \
  "2: .dword " xstr (b) "                  \n\t" \
  "3: .dword " xstr (c) "                  \n\t" \
  "4: .dword " xstr (ret) "                \n\t" \
  ".text                                \n\t" \
  "dla $4, 1b                            \n\t" \
  "dla $5, 2b                            \n\t" \
  "dla $6, 3b                            \n\t" \
  "dla $2, 4b                            \n\t" \
  "ldc1 $f2, 0($4)                      \n\t" \
  "ldc1 $f4, 0($5)                      \n\t" \
  "ldc1 $f6, 0($6)                      \n\t" \
  "lw $7, 0($2)                         \n\t" \
  "lw $8, 4($2)                         \n\t" \
  xstr (inst) " $f2, $f4, $f6            \n\t" \
  "mfhc1 $9, $f2                        \n\t" \
  "mfc1 $10, $f2                        \n\t" \
  fp_assert ($7, $9) \
  fp_assert ($8, $10)

/* ============ macros from sim/testutils/mips/testutils.inc ============= */

/* Put value 'val' into register 'reg'.
   Clobbers: None.  */
#define load32(reg, val) \
  "li  " xstr (reg) ", " xstr (val) "     \n\t"

/* Check whether two registers contain the same value.
   Clobbers: None.  */
#define checkreg(reg, expreg) \
  ".set push         \n\t" \
  ".set noat         \n\t" \
  ".set noreorder    \n\t" \
  "beq "  xstr (expreg) ", " xstr (reg) ", 901f    \n\t" \
  "nop               \n\t" \
  "b 58f              \n\t" \
  "nop                \n\t" \
  "901:                   \n\t" \
  ".set pop           \n\t"

/* Check if register 'reg' contains value 'val'.
   Clobbers: $1.  */
#define check32(reg, val) \
  ".set push         \n\t" \
  ".set noat         \n\t" \
  load32 ($1, val) \
  checkreg (reg, $1) \
  ".set pop          \n\t"

/* Checkpair based on endianess
   Clobbers: $1.  */
#define checkpair_xendian(lo, hi, base, ec, w) \
  ".set noat               \n\t" \
  "lw   $1, " xstr (ec) "   \n\t" \
  "andi $1, $1, 0x1        \n\t" \
  "beqz  $1, 2f            \n\t" \
  ".set at                 \n\t" \
  "1:                          \n\t" \
  checkpair_be_##w (lo, hi, base) \
  "b 3f                    \n\t" \
  "nop                     \n\t" \
  "2:                          \n\t" \
  checkpair_le_##w (lo, hi, base) \
  "3:                          \n\t"

/* Check hi-lo register pair against data stored at base+o1 and base+o2.
   Clobbers: $1 - $5.  */
#define  checkpair(lo, hi, base, w, o1, o2) \
  "move  $2, " xstr (lo) "   \n\t" \
  "move  $3, " xstr (hi) "   \n\t" \
  ".set noat                \n\t" \
  "dla   $1, " xstr (base) "  \n\t" \
  "l" xstr (w) " $4, " xstr (o1) "($1)  \n\t" \
  "l" xstr (w)  " $5, " xstr (o2) "($1)  \n\t" \
  ".set at                  \n\t" \
  checkreg ($2, $4) \
  checkreg ($3, $5)

#define checkpair_le_d(lo, hi, base) \
  checkpair (lo, hi, base, w, 0, 4)

#define checkpair_be_d(lo, hi, base) \
  checkpair (lo, hi, base, w, 4, 0)

#define checkpair_le_q(lo, hi, base) \
  checkpair (lo, hi, base, d, 0, 8)

#define checkpair_be_q(lo, hi, base) \
  checkpair (lo, hi, base, d, 8, 0)

#define checkpair_qword(lo, hi, base, oe) \
  checkpair_xendian (lo, hi, base, oe, q)

#define checkpair_dword(lo, hi, base, oe) \
  checkpair_xendian (lo, hi, base, oe, d)

void
abort (void);

/* Tests branch instructions.  */

int
test_r6_branch (void)
{
/* Using volatile to prevent certain optimizations which could cause
   instruction deletion.
   'err' identifies instruction which (eventually) caused error.
   (err == 0) ==> all instructions executed successfully.  */

  volatile int err = -1;
  volatile int a14 = 0xffffffff;
  volatile int a13 = 0x123;
  volatile int a12 = 0x45;
  volatile int a7 = 0x45;
  volatile int a8 = 0xfffffffe;
  volatile int a9 = 2147483647;
  volatile int a11 = 0;
  volatile int a10 = 0;

  asm (
  ".set push             \n\t" /* Create new scope for asm configuration.  */
  ".set noreorder        \n\t" /* Don't allow reordering of instructions.  */
  "li %[err], 1                  \n\t"
  "bovc %[a12], %[a13], Lfail    \n\t" /* BOVC */
  "nop                           \n\t"
  "bovc %[a9], %[a13], L2        \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L2:                           \n\t"
  "li %[err], 2                  \n\t"
  "bnvc %[a9], %[a13], Lfail     \n\t" /* BNVC */
  "nop                           \n\t"
  "bnvc %[a12], %[a13], L3       \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L3:                           \n\t"
  "li %[err], 3                  \n\t"
  "beqc %[a12], %[a13], Lfail    \n\t" /* BEQC */
  "nop                           \n\t"
  "beqc %[a12], %[a7], L4        \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L4:                           \n\t"
  "li %[err], 4                  \n\t"
  "bnec %[a12], %[a7], Lfail     \n\t" /* BNEC */
  "nop                           \n\t"
  "bnec %[a12], %[a13], L5       \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L5:                           \n\t"
  "li %[err], 5                  \n\t"
  "bltc %[a13], %[a12], Lfail    \n\t" /* BLTC */
  "nop                           \n\t"
  "bltc %[a12], %[a13], L6       \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L6:                           \n\t"
  "L7:                           \n\t"
  "li %[err], 7                  \n\t"
  "bgec %[a12], %[a13], Lfail    \n\t" /* BGEC */
  "nop                           \n\t"
  "bgec %[a13], %[a12], L8       \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L8:                           \n\t"
  "L9:                           \n\t"
  "li %[err], 9                  \n\t"
  "bltuc %[a14], %[a13], Lfail   \n\t" /* BLTUC */
  "nop                           \n\t"
  "bltuc %[a8], %[a14], L10      \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L10:                          \n\t"
  "L11:                          \n\t"
  "li %[err], 11                 \n\t"
  "bgeuc %[a13], %[a14], Lfail   \n\t" /* BGEUC */
  "nop                           \n\t"
  "bgeuc %[a14], %[a8], L12      \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L12:                          \n\t"
  "L13:                          \n\t"
  "li %[err], 13                 \n\t"
  "bltzc %[a13], Lfail           \n\t" /* BLTZC */
  "nop                           \n\t"
  "bltzc %[a11], Lfail           \n\t"
  "nop                           \n\t"
  "bltzc %[a14], L14             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L14:                          \n\t"
  "li %[err], 14                 \n\t"
  "blezc %[a13], Lfail           \n\t" /* BLEZC */
  "nop                           \n\t"
  "blezc %[a11], L145            \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L145:                         \n\t"
  "blezc %[a14], L15             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L15:                          \n\t"
  "li %[err], 15                 \n\t"
  "bgezc %[a8], Lfail            \n\t" /* BGEZC */
  "nop                           \n\t"
  "bgezc %[a11], L155            \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L155:                         \n\t"
  "bgezc %[a13], L16             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L16:                          \n\t"
  "li %[err], 16                 \n\t"
  "bgtzc %[a8], Lfail            \n\t" /* BGTZC */
  "nop                           \n\t"
  "bgtzc %[a11], Lfail           \n\t"
  "nop                           \n\t"
  "bgtzc %[a13], L17             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "li %[a10], 0                  \n\t"
  "L17:                          \n\t"
  "li %[err], 17                 \n\t"
  "blezalc %[a12], Lfail         \n\t" /* BLEZALC */
  "nop                           \n\t"
  "blezalc %[a11], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L175            \n\t" /* BEQZC */
  "nop                           \n\t"
  "li %[err], 8531               \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L175:                         \n\t"
  "li %[err], 23531              \n\t"
  "blezalc %[a14], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L18             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L18:                          \n\t"
  "li %[err], 18                 \n\t"
  "bgezalc %[a14], Lfail         \n\t" /* BGEZALC */
  "nop                           \n\t"
  "bgezalc %[a11], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L185            \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L185:                         \n\t"
  "bgezalc %[a12], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L19             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L19:                          \n\t"
  "li %[err], 19                 \n\t"
  "bgtzalc %[a14], Lfail         \n\t" /* BGTZALC */
  "nop                           \n\t"
  "bgtzalc %[a11], Lfail         \n\t"
  "nop                           \n\t"
  "bgtzalc %[a12], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L20             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L20:                          \n\t"
  "li %[err], 20                 \n\t"
  "bltzalc %[a12], Lfail         \n\t" /* BLTZALC */
  "nop                           \n\t"
  "bltzalc %[a11], Lfail         \n\t"
  "nop                           \n\t"
  "bltzalc %[a14], Lret          \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L21             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L21:                          \n\t"
  "li %[err], 21                 \n\t"
  "bc L22                        \n\t" /* BC */
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L22:                          \n\t"
  "li %[err], 22                 \n\t"
  "balc Lret                     \n\t" /* BALC */
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], L23             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L23:                          \n\t"
  "li %[err], 23                 \n\t"
  "jal GetPC                     \n\t" /* JAL */
  "nop                           \n\t"
  "jic $6, 4                     \n\t" /* JIC */
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L24:                          \n\t"
  "li %[err], 24                 \n\t"
  "li %[a10], 1                  \n\t"
  "jal GetPC                     \n\t"
  "nop                           \n\t"
  "jialc $6, 20                  \n\t" /* JIALC */
  "nop                           \n\t"
  "beqzc %[a10], L25             \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "LJIALCRET:                    \n\t"
  "li %[a10], 0                  \n\t"
  "jr $31                        \n\t" /* JR */
  "nop                           \n\t"
  "L25:                          \n\t"
  "li %[err], 25                 \n\t"
  "jal GetPC                     \n\t"
  "nop                           \n\t"
  "move %[a11], $6               \n\t"
  "nal                           \n\t"
  "nop                           \n\t"
  "addiu %[a11], 12              \n\t" /* ADDIU */
  "beqc %[a11], $31, L26         \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "L26:                          \n\t"
  "li %[err], 26                 \n\t"
  "balc Lret                     \n\t"
  "li %[a10], 1                  \n\t"
  "beqzc %[a10], Lend            \n\t"
  "nop                           \n\t"
  "b Lfail                       \n\t"
  "nop                           \n\t"
  "Lret:                         \n\t"
  "li %[a10], 0                  \n\t"
  "daddiu $31, 4                 \n\t" /* DADDIU */
  "jrc $31                       \n\t" /* JRC */
  "nop                           \n\t"
  "GetPC:                        \n\t"
  "move $6, $31                  \n\t"
  "jr $31                        \n\t"
  "Lend:                         \n\t"
  "li %[err], 0                  \n\t"
  "Lfail:                        \n\t"
  ".set pop                      \n\t" /* Restore previous config */
  : [err] "+r"(err), [a14] "+r"(a14), [a13] "+r"(a13), [a12] "+r"(a12),
    [a7] "+r"(a7), [a8] "+r"(a8), [a9] "+r"(a9), [a10] "+r"(a10),
    [a11] "+r"(a11)
  : /* inputs */
  : "$31", "$6" /* clobbers */
  );

  return err;
}

/* Tests forbidden slot branching i.e. conditional compact branch
   instructions.  */

int
test_r6_forbidden (void)
{
  volatile int err = -1;
  volatile int a4 = 0;
  volatile int a2 = 0;
  volatile int a1 = 0;

  asm (
  ".set push                         \n\t"
  ".set noreorder                    \n\t"
/* Test if FS is ignored when branch is taken */
  "li %[err], 1                      \n\t"
  "li %[a4], 0                       \n\t"
  "beqzalc %[a4], L41                \n\t"
  "li %[err], -85                    \n\t"
  "L42:                              \n\t"
  "b Lfail2                          \n\t"
  "nop                               \n\t"
  "L41:                              \n\t"
  "blez %[err], Lfail2               \n\t"
/* Test if FS is used when branch is not taken */
  "li %[err], 2                      \n\t"
  "li %[a4], 1                       \n\t"
  "blezc %[a4], L43                  \n\t"
  "addiu %[a4], %[a4], 1             \n\t"
  "li %[a2], 2                       \n\t"
  "beq %[a4], %[a2], L44             \n\t"
  "nop                               \n\t"
  "L43:                              \n\t"
  "nop                               \n\t"
  "b Lfail2                          \n\t"
  "nop                               \n\t"
  "L44:                              \n\t"
  "li %[err], 3                      \n\t"
  "li %[a4], 3                       \n\t"
  "beqzalc %[a4], Lfail2             \n\t"
/* Note: 'bc L45' instead nop would cause SegFault: Illegal instruction:
   Forbidden slot causes an error when it contains a branch.  */
  "nop                               \n\t"
  "b Lend2                           \n\t"
  "nop                               \n\t"
  "L45:                              \n\t"
  "nop                               \n\t"
  "b Lfail2                          \n\t"
  "nop                               \n\t"
  "Lend2:                            \n\t"
  "li %[err], 0                      \n\t"
  "Lfail2:                           \n\t"
  "nop                               \n\t"
  ".set pop                          \n\t"
  : [err] "+r" (err), [a4] "+r"(a4), [a2] "+r"(a2), [a1] "+r"(a1) /* outputs */
  : /* inputs */
  : "$31" /* clobbers */
  );

  return err;
}

int
test_r6_64 (void)
{
  volatile int err = 0;

  asm (
  ".set push                                   \n\t"
  ".set noreorder                              \n\t"
  ".data                                       \n\t"
  "dval: .dword 0xaa55bb66cc77dd88             \n\t"
  "d1:   .dword 0xaaaabbbbccccdddd             \n\t"
  "d5:   .dword 0x00000000000000dd             \n\t"
  "d7:   .dword 0xeeeeffff00001111             \n\t"
  "d8:   .dword 0xbbccccddddeeeeff             \n\t"
  "d9:   .dword 0x000000ddaaaabbbb             \n\t"
  "dval1: .word 0x1234abcd                     \n\t"
  "dval2: .word 0xffee0000                     \n\t"
  "dval3: .dword 0xffffffffffffffff            \n\t"
  "  .fill 240,1,0                             \n\t"
  "dval4: .dword 0x5555555555555555            \n\t"
  "  .fill  264,1,0                            \n\t"

/* Register $11 stores instruction currently being tested and hence
 * identifies error if it occurs.  */
  ".text                                       \n\t"

  "li $11, 1                                   \n\t" /* Test DALIGN */
  r6ck_2dr1i (dalign, d7, d1, 3, d8)
  r6ck_2dr1i (dalign, d1, d5, 4, d9)

  "li $11, 2                                   \n\t" /* Test LDPC */
  "ld $5, dval                                 \n\t"
  "nop                                         \n\t"
  "ldpc $4, dval                               \n\t"
  fp_assert ($4, $5)

  "li $11, 3                                   \n\t" /* Test LWUPC */
  "lwu $5, dval1                               \n\t"
  "lwupc $4, dval1                             \n\t"
  fp_assert ($4, $5)
  "lwu $5, dval2                               \n\t"
  "lwupc $4, dval2                             \n\t"
  fp_assert ($4, $5)

  "li $11, 4                                   \n\t" /* Test LLD */
  "ld $5, dval3                                \n\t"
  "dla $3, dval4                               \n\t"
  "lld $4, -248($3)                            \n\t"
  fp_assert ($4, $5)

  "li $11, 5                                   \n\t" /* Test SCD */
  "lld $4, -248($3)                            \n\t"
  "dli $4, 0xafaf                              \n\t"
  "scd $4, -248($3)                            \n\t"
  "ld $5, dval3                                \n\t"
  "dli $4, 0xafaf                              \n\t"
  fp_assert ($4, $5)

  "Lend3:                                      \n\t"
  "li $11, 0                                   \n\t"
  "58:                                         \n\t"
  "move %[err], $11                            \n\t"
  ".set pop                                    \n\t"
   : [err] "+r" (err) /* outputs */
   :                  /* inputs */
   : "$3", "$4", "$5", "$6", "$7", "$11" /* clobbers */
  );

  return err;
}

int
test_r6 (void)
{
  volatile int err = 0;

  asm (
  ".set push                                                   \n\t"
  ".set noreorder                                              \n\t"
  ".data                                                       \n\t"
  "dval_1:  .word 0xabcd1234                                   \n\t"
  "dval_2: .word 0x1234eeff                                    \n\t"
  ".fill 248,1,0                                               \n\t"
  "dval_3: .word 0x55555555                                    \n\t"
  ".fill  260,1,0                                              \n\t"
  "dval_4: .word 0xaaaaaaaa                                    \n\t"
  ".text                                                       \n\t"
  "li $11, 1            \n\t" /* ADDIUPC */
  "jal GetPC_2                                               \n\t"
  "nop                                                       \n\t"
  "addiu $4, $6, 8                                           \n\t"
  "addiupc $5, 4                                             \n\t"
  fp_assert ($4, $5)

  "li $11, 2            \n\t" /* AUIPC */
  "jal GetPC_2                                               \n\t"
  "nop                                                       \n\t"
  "addiu $4, $6, 8                                           \n\t"
  "aui $4, $4, 8                                             \n\t"
  "auipc $5, 8                                               \n\t"
  fp_assert ($4, $5)

  "li $11, 3            \n\t" /* ALUIPC */
  "jal GetPC_2                                               \n\t"
  "nop                                                       \n\t"
  "addiu $4, $6, 16                                          \n\t"
  "aui $4, $4, 8                                             \n\t"
  "li $7, 0xffff0000                                         \n\t"
  "and $4, $4, $7                                            \n\t"
  "aluipc $5, 8                                              \n\t"
  fp_assert ($4, $5)

  "li $11, 4            \n\t" /* LWPC */
  "lw $5, dval_1                                             \n\t"
  "lwpc $4, dval_1                                           \n\t"
  fp_assert ($4, $5)
  "lw $5, dval_2                                             \n\t"
  "lwpc $4, dval_2                                           \n\t"
  fp_assert ($4, $5)

/* Testing LL follows.
 * NOTE: May be redundant because SC already contains LL in its test.  */
  "li $11, 5                                                \n\t"
  "lw $5, dval_2                                             \n\t"
  "dla $3, dval_3                                            \n\t"
  "ll $4, -252($3)                                           \n\t"
  fp_assert ($4, $5)

  "li $11, 6        \n\t"    /* LL-SC sequence */
  "ll $4, -252($3)                                           \n\t"
  "li $4, 0xafaf                                             \n\t"
  "sc $4, -252($3)                                           \n\t"
  "lw $5, dval_2                                             \n\t"
  "li $4, 0xafaf                                             \n\t"
  fp_assert ($4, $5)
  "b Lend4                                                   \n\t"
  "nop                                                       \n\t"
  "GetPC_2:                                                  \n\t"
  "move $6, $31                                              \n\t"
  "jr $31                                                    \n\t"
  "Lend4:                                                    \n\t"
  "li $11, 0                                                 \n\t"
  "58:                                                       \n\t"
  "move %[err], $11                                          \n\t"
  ".set pop                                                  \n\t"
  : [err] "+r"(err)  /* outputs */
  : /* inputs */
  : "$3", "$4", "$5", "$6", "$7", "$8", "$9", "$10",
    "$11", "$31" /* clobbers */
  );

  return err;
}

/* For fpu-branching testing, bc1eq/eqz are enough.  */

int
test_r6_fpu (void)
{
  volatile int err = 0;

  asm (
  ".set push                               \n\t"
  ".set noreorder                          \n\t"
/* Test qNaN format is 754-2008 */
  "li $11, 1                               \n\t"
  "li $4, 0x0                              \n\t"
  "li $5, 0x0                              \n\t"
  "li $6, 0x7fc00000                       \n\t"
  "mtc1 $4, $f2                            \n\t"
  "mtc1 $5, $f4                            \n\t"
  "div.s $f6, $f2, $f4                     \n\t"
  "mfc1 $8, $f6                            \n\t"
  fp_assert ($6, $8)

  "li $11, 2                                \n\t"  /* bc1eqz */
  "li $10, 0x01                             \n\t"
  "mtc1 $10, $f2                            \n\t"
  "mtc1 $0, $f4                             \n\t"
  "bc1eqz $f2, 58f                          \n\t"
  "nop                                      \n\t"
  "bc1eqz $f4, L62                          \n\t"
  "nop                                      \n\t"
  "b 58f                                    \n\t"
  "nop                                      \n\t"
"L62:                                       \n\t"
  "li $11, 3                                \n\t"  /* bc1nez */
  "bc1nez $f4, 58f                          \n\t"
  "nop                                      \n\t"
  "bc1nez $f2, Lend8                        \n\t"
  "nop                                      \n\t"
  "b 58f                                    \n\t"
  "nop                                      \n\t"
"Lend8:                                     \n\t"
  "li $11, 0                                \n\t"
  "58:                                      \n\t"
  "move %[err], $11                         \n\t"
  ".set pop                                 \n\t"
  : [err] "+r"(err)  /* outputs */
  :                  /* inputs */
  : "$4", "$5", "$6", "$8", "$10", "$11", "$31",
    "$f2", "$f4", "$f6" /* clobbers */
  );

  return err;
}

/* R6 specific tests for mips64 (64-bit).  */

int
test_r6_llsc_dp (void)
{
  volatile int err = 0;

  asm (
  ".set push                                            \n\t"
  ".set noreorder                                       \n\t"
  ".data                                                \n\t"
  ".align 16                                            \n\t"
  "test_data:                                           \n\t"
  ".word 0xaaaaaaaa                                     \n\t"
  ".word 0xbbbbbbbb                                     \n\t"
  ".word 0xcccccccc                                     \n\t"
  ".word 0xdddddddd                                     \n\t"
  ".align 16                                            \n\t"
  "end_check:                                           \n\t"
  ".byte 0                                              \n\t"
  ".byte 0                                              \n\t"
  ".byte 0                                              \n\t"
  ".byte 0x1                                            \n\t"
  ".text                                                \n\t"
  "li $11, 1                                            \n\t" /* LLWP */
  "llwp $2, $3, test_data                               \n\t"
  checkpair_dword ($2, $3, test_data, end_check)
  "sll $2, $2, 1                                        \n\t"
  "srl $3, $3, 1                                        \n\t"
  "move  $s0, $2                                        \n\t"
  "scwp $2, $3, test_data                               \n\t"
  check32 ($2, 1)
  checkpair_dword ($s0, $3, test_data, end_check)
  /* Test SCWP, done */
  "li $11, 2                                            \n\t"
  "li $11, 3                                            \n\t" /* LLDP */
  "lldp $2, $3, test_data                               \n\t"
  checkpair_qword ($2, $3, test_data, end_check)
  "dsll $2, $2, 1                                       \n\t"
  "dsrl $3, $3, 1                                       \n\t"
  "move $s0, $2                                         \n\t"
  "scdp $2, $3, test_data                               \n\t"
  check32 ($2, 1)
  checkpair_qword ($s0, $3, test_data, end_check)
  "li $11, 4                                            \n\t" /* SCDP done */
  "Lend5:                                               \n\t"
  "li $11, 0                                            \n\t"
  "58:                                                  \n\t"
  "move %[err], $11                                     \n\t"
  ".set pop                                             \n\t"
  : [err] "+r"(err) /* outputs */
  : /* inputs */
  : "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9", "$10", "$11",
    "$31", "$s0"  /* clobbers */
  );

  return err;
}

/* R6 specific tests for mips32 (32-bit).  */

int
test_r6_llsc_wp (void)
{
  volatile int err = 0;

  asm (
  ".set push                                            \n\t"
  ".set noreorder                                       \n\t"
  ".data                                                \n\t"
  ".align 8                                             \n\t"
  "test_data_2:                                         \n\t"
  ".word 0xaaaaaaaa                                     \n\t"
  ".word 0xbbbbbbbb                                     \n\t"
  ".align 8                                             \n\t"
  "end_check_2:                                         \n\t"
  ".byte 0                                              \n\t"
  ".byte 0                                              \n\t"
  ".byte 0                                              \n\t"
  ".byte 0x1                                            \n\t"
  ".text                                                \n\t"
  "li $11, 1                                            \n\t" /* Test LLWP */
  "llwp $2, $3, test_data_2                             \n\t"
  checkpair_dword ($2, $3, test_data_2, end_check_2)
  "sll $2, $2, 1                                        \n\t"
  "srl $3, $3, 1                                        \n\t"
  "move  $s0, $2                                        \n\t"
  "scwp $2, $3, test_data_2                             \n\t"
  check32 ($2, 1)
  checkpair_dword ($s0, $3, test_data_2, end_check_2)
/* Test SCWP, done.  */
  "li $11, 2                                            \n\t"
  "Lend6:                                               \n\t"
  "li $11, 0                                            \n\t"
  "58:                                                  \n\t"
  "move %[err], $11                                     \n\t"
  ".set pop                                             \n\t"
  : [err] "+r"(err) /* outputs */
  : /* inputs */
  : "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9", "$10",
    "$11", "$31", "$s0"  /* clobbers */
  );

  return err;
}

/* If any test_r6_* function returns non-zero, it's a failure.  */
#define EXPECT(X) if ((X)) abort ();

int
main (void)
{
  EXPECT (test_r6_branch ());

  EXPECT (test_r6_forbidden ());

  EXPECT (test_r6_64 ());

  EXPECT (test_r6 ());

  EXPECT (test_r6_fpu ());

  EXPECT (test_r6_llsc_dp ());

  EXPECT (test_r6_llsc_wp ());

  return 0;
}
