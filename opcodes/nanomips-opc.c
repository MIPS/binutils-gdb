/* nanomips-opc.c.  nanoMIPS opcode table.
   Copyright (C) 2017 Free Software Foundation, Inc.
   Contributed by MIPS Tech LLC.

   This file is part of the GNU opcodes library.

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   It is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   You should have received a copy of the GNU General Public License
   along with this file; see the file COPYING.  If not, write to the
   Free Software Foundation, 51 Franklin Street - Fifth Floor, Boston,
   MA 02110-1301, USA.  */

#include "sysdep.h"
#include "opcode/nanomips.h"
#include "nanomips-formats.h"

static unsigned char reg_0_map[] = { 0 };
static unsigned char reg_28_map[] = { 28 };
static unsigned char reg_28_opt_map[] = { 0, 28 };
static unsigned char reg_29_map[] = { 29 };
static unsigned char reg_30_opt_map[] = { 0, 30 };
static unsigned char reg_31_map[] = { 31 };
static unsigned char reg_m16_map[] = { 16, 17, 18, 19, 4, 5, 6, 7 };
static unsigned char reg_q_map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };

static unsigned char reg_4to5_map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
					16, 17, 18, 19, 20, 21, 22, 23 };

static unsigned char reg_4to5_srcmap[] = { 8, 9, 10, 0, 4, 5, 6, 7,
					   16, 17, 18, 19, 20, 21, 22, 23 };

static unsigned char reg_4or5_map[] = { 4, 5 };

static unsigned char reg_gpr2d_map1[] = { 4, 5, 6, 7 };
static unsigned char reg_gpr2d_map2[] = { 5, 6, 7, 8 };

static int int_b_map[] = {
  0, 4, 8, 12, 16, 20, 24, 28
};

static int int_c_map[] = {
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 65535, 14, 15
};

static int word_byte_map[] = {
  0, 0, 0, 0, 0, 0, 0, 0,
  3, 0, 0, 0, 0, 0, 0, 0,
  2, 0, 0, 0, 0, 0, 0, 0,
  1, 0, 0, 0, 0, 0, 0, 0
};

static int int_6_map[] = {
  0x1, 0x3, 0x7, 0xf,
  0x1f, 0x3f, 0x7f, 0xff,
  0x1ff, 0x3ff, 0x7ff, 0xfff,
  0x1fff, 0x3fff, 0x7fff, 0xffff,
  0x1ffff, 0x3ffff, 0x7ffff, 0xfffff,
  0x1fffff, 0x3fffff, 0x7fffff, 0xffffff,
  0x1ffffff,0x3ffffff,0x7ffffff,0xfffffff,
  0x1fffffff, 0x3fffffff, 0x7fffffff, 0xffffffff
};

/* Return the mips_operand structure for the operand at the beginning of P.  */

/* FIXME: Unused cases left commented in-place for quick reminder
   of which character strings are unused.  */
const struct nanomips_operand *
decode_nanomips_operand (const char *p)
{
  switch (p[0])
    {
    case 'm':
      switch (p[1])
	{
	case 'a': MAPPED_REG (0, 0, GP, reg_28_map);
	case 'b': MAPPED_REG (1, 1, GP, reg_28_opt_map);
	case 'c': OPTIONAL_MAPPED_REG (3, 4, GP, reg_m16_map);
	case 'd': MAPPED_REG (3, 7, GP, reg_m16_map);
	case 'e': MAPPED_REG (3, 1, GP, reg_m16_map);  /* Used to be optional */
/* 	case 'f': MAPPED_REG (3, 3, GP, reg_m16_map); */
/* 	case 'g': MAPPED_REG (3, 0, GP, reg_m16_map); */
/* 	case 'h': REG_PAIR (3, 7, GP, reg_h_map); */
	case 'j': REG (5, 0, GP);
	case 'l': MAPPED_REG (3, 4, GP, reg_m16_map);
/* 	case 'm': MAPPED_REG (3, 1, GP, reg_mn_map); */
/* 	case 'n': MAPPED_REG (3, 4, GP, reg_mn_map); */
	case 'p': REG (5, 5, GP);
	case 'q': MAPPED_REG (3, 7, GP, reg_q_map);
	case 's': MAPPED_REG (0, 0, GP, reg_29_map);
	case 't': SPECIAL (0, 0, REPEAT_PREV_REG);
	case 'u': REG (5, 3, GP); // New
	case 'w': MAPPED_REG (1, 0, GP, reg_30_opt_map);
	case 'x': SPECIAL (0, 0, REPEAT_DEST_REG);
	case 'y': MAPPED_REG (0, 0, GP, reg_31_map);
	case 'z': UINT (0, 0); 	/* Literal 0 */
	case 'A': INT_ADJ (7, 0, 127, 2, FALSE);	 /* (0 .. 127) << 2 */
	case 'B': MAPPED_INT (3, 0, int_b_map, FALSE);
	case 'C': MAPPED_INT (4, 0, int_c_map, TRUE);
	case 'D': BRANCH_UNORD_SPLIT (10, 1);
	case 'E': BRANCH_UNORD_SPLIT (7, 1);
	case 'F': SPECIAL (4, 0, NON_ZERO_PCREL_S1);
	case 'G': INT_ADJ (4, 4, 15, 4, FALSE);
	case 'H': INT_ADJ (2, 1, 3, 1, FALSE);	 /* (0 .. 3) << 1 */
	case 'I': INT_ADJ (7, 0, 126, 0, FALSE); /* (-1 .. 126) */
	case 'J': INT_ADJ (4, 0, 15, 2, FALSE);	 /* (0 .. 15) << 2 */
	case 'K': SPECIAL_SPLIT (20, 2, 1, 0, HI20_PCREL); /* tri-part 20-bit */
	case 'L': UINT (2, 0);	 /* (0 .. 3) */
	case 'M': INT_ADJ (3, 0, 8, 0, FALSE);   /* (1 .. 8) */
	case 'N': UINT_SPLIT (2, 8, 2, 1, 3); /* split encoded 2-bit offset << 2 */
	case 'O': UINT_SPLIT (17, 0, 0, 5, 16); /* split 17-bit offset */
	case 'P': UINT_SPLIT (16, 0, 0, 4, 16); /* split 16-bit offset */
	case 'S': UINT (4, 17); /* (0 .. 15) */
	case 'T': UINT (4, 6); /* (0 .. 15) */
	case 'U': INT_ADJ (5, 0, 31, 2, FALSE);	 /* (0 .. 31) << 2 */
	case 'V': INT_ADJ (18, 3, (1<<18)-1, 3, FALSE); /* 18-bit << 3 */
	case 'W': INT_ADJ (6, 0, 63, 2, FALSE);	 /* (0 .. 63) << 2 */
	case 'X': INT_ADJ (4, 2, 15, 4, FALSE);	 /* 4-bit << 3 */
	case 'Y': INT_ADJ (9, 3, 511, 3, FALSE);	 /* 9-bit << 3 */
	case 'Z': UINT (0, 0);			 /* 0 only */
	case '0': INT_ADJ (4, 2, 15, 4, FALSE);
	case '1': IMM_INT_ADJ (7, 0, 127, 2, FALSE);	 /* (0 .. 127) << 2 */
/* 	case '2': SPLIT_MAPPED_REG (4, 0, 1, 4, GP, reg_4to5_map); */
/* 	case '3': SPLIT_MAPPED_REG (4, 5, 1, 9, GP, reg_4to5_srcmap); */
	case '4': MAPPED_REG (1, 24, GP, reg_4or5_map);
	case '5': SPLIT_MAPPED_REG_PAIR (2, 8, 1, 3, GP, reg_gpr2d_map1,
					 reg_gpr2d_map2);
	case '6': MAPPED_INT (5, 6, int_6_map, TRUE);
	case '7': SPLIT_MAPPED_REG_PAIR (2, 8, 1, 3, GP, reg_gpr2d_map2,
					 reg_gpr2d_map1);
	case '8': HINT (23, 3);
	case '9': UINT (7, 11);
	}
      break;

    case '-':
      switch (p[1])
	{
/* 	case 'A': PCREL (19, 0, TRUE, 2, 2, FALSE, FALSE); */
/* 	case 'B': PCREL (18, 0, TRUE, 3, 3, FALSE, FALSE); */
/* 	case 'd': MAPPED_REG (3, 1, GP, reg_m16_map); */
/* 	case 'e': OPTIONAL_MAPPED_REG (3, 7, GP, reg_m16_map); */

/* 	case 'm': SPLIT_MAPPED_REG (3, 0, 1, 3, GP, reg_mn_map); */
	case 'a': SPECIAL (5, 16, DONT_CARE);
	case 'b': SPECIAL_SPLIT (8, 9, 5, 16, DONT_CARE);
	case 'i': REG (0, 0, GP); /* Ignored register operand.  */
	case 'm': SPECIAL_SPLIT (5, 11, 5, 21, COPY_BITS);
	case 'n': SPECIAL_SPLIT (5, 11, 5, 16, COPY_BITS);

	case 'p': SPECIAL (5, 5, NON_ZERO_REG);
	case 's': SPECIAL (5, 16, NON_ZERO_REG);
	case 't': SPECIAL (5, 21, NON_ZERO_REG);
	case 'u': MAPPED_PREV_CHECK (3, 7, GP, reg_m16_map, TRUE, FALSE, FALSE, FALSE);
	case 'v': MAPPED_PREV_CHECK (3, 4, GP, reg_m16_map, FALSE, TRUE, FALSE, FALSE);
	case 'w': MAPPED_PREV_CHECK (3, 7, GP, reg_m16_map, FALSE, TRUE, TRUE, FALSE);
	case 'x': MAPPED_PREV_CHECK (3, 4, GP, reg_m16_map, TRUE, FALSE, TRUE, FALSE);
/* 	case 'y': PREV_CHECK (5, 16, FALSE, TRUE, FALSE, FALSE); */
	}
      break;

    case '+':
      switch (p[1])
	{
	case 'A': BIT (5, 0, 0);		 /* (0 .. 31) */
	case 'B': MSB (5, 6, 1, TRUE, 32);	 /* (1 .. 32), 32-bit op */
	case 'C': MSB (5, 6, 1, FALSE, 32);	 /* (1 .. 32), 32-bit op */
/* 	case 'D': REG (5, 16, FP); */
	case 'E': BIT (5, 0, 32);		 /* (32 .. 63) */
	case 'F': MSB (5, 6, 33, TRUE, 64);	 /* (33 .. 64), 64-bit op */
	case 'G': MSB (5, 6, 33, FALSE, 64);	 /* (33 .. 64), 64-bit op */
	case 'H': MSB (5, 6, 1, FALSE, 64);	 /* (1 .. 32), 64-bit op */
	case 'I': BIT (5, 6, 0); /* (0 .. 31) */
	case 'K': HINT (3, 0);
	case 'L': HINT (10, 16);
	case 'J': HINT (19, 0);
	case 'M': HINT (18, 0);
	case 'N': SPECIAL_SPLIT (5, 0, 1, 9, SAVE_RESTORE_LIST);
	case 'P': SPECIAL (4, 16, SAVE_RESTORE_FP_LIST);
	case 'O': UINT (3, 8);
	case 'Q': SPECIAL_WORD (0, UINT_WORD);
	case 'R': SPECIAL_WORD (0, INT_WORD);
	case 'S': SPECIAL_WORD (0, PC_WORD);
	case 'T': SPECIAL_WORD (0, GPREL_WORD);
	case 'U': SPECIAL_WORD (6, IMM_WORD);
/* 	case 'V': SPECIAL_WORD (0, INT_WORD); */
/* 	case 'W': INT_ADJ (10, 16, 511, 3, FALSE);	/\* (-512 .. 511) << 3 *\/ */

/* 	case 'd': REG (5, 6, MSA); */
/* 	case 'e': REG (5, 11, MSA); */
/* 	case 'h': REG (5, 16, MSA); */
	case 'i': BIT (5, 11, 0);			 /* (0 .. 31) */
	case 'j': SINT_SPLIT (9, 0, 0, 1, 15, 0);
/* 	case 'k': REG (5, 6, GP); */
/* 	case 'l': REG (5, 6, MSA_CTRL); */
	case 'm': SINT_SPLIT (7, 2, 2, 1, 15, 0); /* split 7-bit signed << 2 */
/* 	case 'n': REG (5, 11, MSA_CTRL); */
	case 'o': HINT (2, 0);
	case 'q': SINT_SPLIT (6, 3, 3, 1, 15, 0); /* split 6-bit signed << 3 */
	case 'r': BRANCH_UNORD_SPLIT (21, 1); /* split 21-bit signed << 1 */
	case 's': IMM_SINT_SPLIT (21, 1, 1, 1, 0, 2); /* split (21-bit signed + 2) << 1 */
/*
	case 't': REG (5, 21, GP);
*/
/* 	case 'u': BRANCH_UNORD_SPLIT (14, 1); */
/* 	case 'v': SPECIAL (2, 16, IMM_INDEX); */
/* 	case 'w': SPECIAL (1, 16, IMM_INDEX); */
	case 'x': BIT (5, 16, 0);		/* (0 .. 31) */

/* 	case '!': BIT (3, 16, 0);		/\* (0 .. 7) *\/ */
/* 	case '#': BIT (6, 16, 0);		/\* (0 .. 63) *\/ */
/* 	case '$': UINT (5, 16);			/\* (0 .. 31) *\/ */
/* 	case '%': SINT (5, 16);			/\* (-16 .. 15) *\/ */
/* 	case '&': SPECIAL (0, 0, IMM_INDEX); */
	case '*': INT_ADJ (4, 7, 15, 1, FALSE); /* (0 .. 15) << 1 */
	case '|': UINT (1, 6);			/* 0/1 */
	case '\'': BRANCH_UNORD_SPLIT (25, 1);
/* 	case '"': BRANCH (21, 0, 1); */
	case ':': MAPPED_INT (5, 6, word_byte_map, FALSE);
	case '.': BIT (2, 9, 0);		/* (0 .. 3) */
	case ';': UINT (2, 21);			/* (0 .. 3) */
	case '1': UINT (18, 0);
	case '2': INT_ADJ (16, 2, (1<<16) - 1, 2, FALSE);
	case '3': INT_ADJ (17, 1, (1<<17) - 1, 1, FALSE);
	case '4': SPLIT_MAPPED_REG (4, 5, 1, 9, GP, reg_4to5_map);
	case '5': SPLIT_MAPPED_REG (4, 0, 1, 4, GP, reg_4to5_map);
	case '6': SPLIT_MAPPED_REG (4, 5, 1, 9, GP, reg_4to5_srcmap);
	case '7': SPLIT_MAPPED_REG (4, 0, 1, 4, GP, reg_4to5_srcmap);
	case '8': SPLIT_MAPPED_REG (4, 21, 1, 25, GP, reg_4to5_srcmap);
	case '9': SINT_SPLIT (4, 0, 0, 1, 4, 0);
	}
      break;

    case '.': INT_ADJ (19, 2, (1<<19) - 1, 2, FALSE);
    case '<': BIT (5, 0, 0);			 /* (0 .. 31) */
/*     case '>': BIT (5, 11, 32);			 /\* (32 .. 63) *\/ */
    case '\\': BIT (3, 21, 0);			 /* (0 .. 7) */
    case '|': INT_ADJ (3, 12, 8, 0, FALSE);	/* 1 .. 8 */
    case '~': BRANCH_UNORD_SPLIT (11, 1); 	/* split 11-bit signed << 1 */
    case '@': SINT (10, 11);
    case '^': HINT (5, 11);
    case '!': UINT (1, 10);
    case '$': UINT (1, 3);
    case '*': REG (2, 18, ACC);
    case '&': REG (2, 23, ACC);

    case '0': SINT (6, 16);
    case '1': HINT (5, 16);
    case '2': HINT (2, 14);
    case '3': BIT (3, 13, 0);
    case '4': BIT (4, 12, 0);
    case '5': HINT (8, 13);
/*       case '6': HINT (5, 16); /\* unused / available *\/ */
    case '7': REG (2, 14, ACC);
    case '8': HINT (7, 14);

    case 'C': HINT (23, 3);
    case 'D': REG (5, 11, FP);
    case 'E': REG (5, 21, COPRO);
    case 'G': REG (5, 16, COPRO);
    case 'H': UINT (3, 11);
    case 'J': SPECIAL (5, 11, CP0SEL);
    case 'K': REG (5, 16, HW);
/*     case 'M': REG (3, 13, CCC); */
/*     case 'N': REG (3, 18, CCC); */
    case 'O': REG (10, 11, CP0);
    case 'P': REG (5, 16, CP0SEL);
    case 'Q': UINT (5, 11);
    case 'R': REG (5, 11, FP);
    case 'S': REG (5, 16, FP);
    case 'T': REG (5, 21, FP);
    case 'V': OPTIONAL_REG (5, 16, FP);

    case 'a': JUMP (26, 0, 1);
    case 'b': REG (5, 16, GP);
    case 'c': BASE_OFFSET_CHECK (5, 16, TRUE, FALSE);
    case 'd': REG (5, 11, GP);
    case 'g': HINT (12, 0);
    case 'h': SPECIAL (12, 0, NEG_INT);
    case 'i': UINT (12, 0);
    case 'j': UINT (16, 0);
    case 'k': HINT (5, 21);
    case 'n': SPECIAL_SPLIT (11, 2, 10, 16, SAVE_RESTORE_LIST);
    case 'o': UINT (12, 0);
    case 'p': BRANCH_UNORD_SPLIT (14, 1);
/*     case 'q': BRANCH_UNORD_SPLIT (20, 1); - unused */
    case 'r': OPTIONAL_REG (5, 16, GP);
    case 's': REG (5, 16, GP);
    case 't': REG (5, 21, GP);
    case 'u': SPECIAL_SPLIT (20, 2, 1, 0, HI20_INT);  /* tri-part 20-bit */
    case 'x': SPECIAL_SPLIT (20, 2, 1, 0, HI20_SCALE);  /* tri-part 20-bit */
    case 'v': OPTIONAL_REG (5, 16, GP);
    case 'w': OPTIONAL_REG (5, 21, GP);
/*     case 'y': REG (5, 6, GP); */
    case 'z': MAPPED_REG (0, 0, GP, reg_0_map);
    }
  return 0;
}

#define NODS	INSN_NO_DELAY_SLOT
#define LM	INSN_LOAD_MEMORY
#define SM	INSN_STORE_MEMORY
#define CM	INSN_COPROC_MOVE
#define LC	INSN_LOAD_COPROC

#define WR_1	INSN_WRITE_1
#define WR_2	INSN_WRITE_2
#define RD_1	INSN_READ_1
#define RD_2	INSN_READ_2
#define RD_3	INSN_READ_3
#define RD_4	INSN_READ_4
#define MOD_1	(WR_1|RD_1)
#define MOD_2	(WR_2|RD_2)


#define WR_HI	INSN_WRITE_HI
#define RD_HI	INSN_READ_HI
#define MOD_HI  WR_HI|RD_HI
#define WR_LO	INSN_WRITE_LO
#define RD_LO	INSN_READ_LO
#define MOD_LO  WR_LO|RD_LO

#define WR_HILO WR_HI|WR_LO
#define RD_HILO RD_HI|RD_LO
#define MOD_HILO WR_HILO|RD_HILO

#define WR_a	WR_HILO	/* Write dsp accumulators (reuse WR_HILO)  */
#define RD_a	RD_HILO	/* Read dsp accumulators (reuse RD_HILO)  */


/* For 16-bit/32-bit nanoMIPS instructions.  They are used in pinfo2.  */
#define RD_sp	INSN2_READ_SP
#define WR_sp	INSN2_WRITE_SP
#define RD_31	INSN2_READ_GPR_31
#define RD_pc	INSN2_READ_PC
#define CTC	INSN2_CONVERTED_TO_COMPACT
#define UBR	INSN2_UNCOND_BRANCH
#define CBR	INSN2_COND_BRANCH
#define ALIAS	INSN2_ALIAS

/* For 32-bit nanoMIPS instructions.  */
#define WR_31	INSN_WRITE_GPR_31

/* nanoMIPS DSP ASE support.  */
#define D32	ASE_DSP

/* nanoMIPS MT ASE support.  */
#define MT32	ASE_MT

/* nanoMIPS MCU (MicroController) ASE support.  */
#define MC	ASE_MCU

/* nanoMIPS Enhanced VA Scheme.  */
#define EVA	ASE_EVA

/* nanoMIPS Virtualization ASE.  */
#define IVIRT	ASE_VIRT
#define IVIRT64	ASE_VIRT64
#define IVIRT_XPA ASE_XPA_VIRT
#define IVIRT_GINV ASE_GINV_VIRT

/* MSA support.  */
#define MSA     ASE_MSA
#define MSA64   ASE_MSA64

/* eXtended Physical Address (XPA) support.  */
#define XPA     ASE_XPA

/* Global INValidate extension.  */
#define GINV	ASE_GINV

/* Cyclic redundancy check instruction (CRC) support.  */
#define CRC	ASE_CRC
#define CRC64	ASE_CRC64

#define FPU	0
#define EJTAG	0
#define UDI	0
#define xNMS	ASE_xNMS
#define TLB	ASE_TLB

/* New base ISAs starting at revision 7. */
#define I38	INSN_ISAN32R6
#define I70	INSN_ISAN64R6

const struct nanomips_opcode nanomips_opcodes[] = {
/* These instructions appear first so that the disassembler will find
   them first.  The assemblers uses a hash table based on the
   instruction name anyhow.  */
/* name,	suffix,		args,		match,	mask,	pinfo		pinfo2, 	membership, ase */
/* Pure macros */
{"la",		"",		"t,A(c)",	0,    (int) M_LA_AB,	INSN_MACRO,		0,	I38,	0},
{"dla", 	"", 		"t,A(b)",	0,    (int) M_DLA_AB,	INSN_MACRO,		0,	I38,	0},
/* Precedence=1 */
{"aluipc",	"",		"t,mK",		0xe0000002, 0xfc000002, WR_1,			0,	I38,	0}, /* ALUIPC */
{"break",	"[16]",		"",		0x1010,		0xffff, 	0,	INSN2_ALIAS,	I38,	0},
{"break",	"[16]",		"+K",		0x1010,		0xfff8, 	0,		0,	I38,	0},
{"break",	"[32]",		"",		0x00100000, 0xffffffff,		0,	INSN2_ALIAS,	I38,	0},
{"break",	"[32]",		"+J",		0x00100000, 0xfff80000,		0,		0,	I38,	0},
{"dvp", 	"", 		"-a",		0x20000390, 0xffe0ffff,		0,	INSN2_ALIAS,	I38,	0}, /* DVP */
{"dvp", 	"", 		"t,-a",		0x20000390, 0xfc00ffff,		WR_1,		0,	I38,	0},
{"nop", 	"[16]",		"",		0x9008,		0xffff,		0,		0,	I38,	0}, /* NOP[16] */
{"nop", 	"[32]", 	"",		0x8000c000, 0xffffffff,		0,		0,	I38,	0}, /* NOP */
{"sdbbp",	"[16]",		"",		0x1018,		0xffff,		0,	INSN2_ALIAS,	I38,	EJTAG},
{"sdbbp",	"[16]",		"+K",		0x1018,		0xfff8,		0,		0,	I38,	EJTAG},
{"sdbbp",	"[32]",		"",		0x00180000, 0xffffffff,		0,	INSN2_ALIAS,	I38,	0},
{"sdbbp",	"[32]",		"+J",		0x00180000, 0xfff80000,		0,		0,	I38,	0},
{"move",	"",		"-p,mj",	0x1000,		0xfc00,	WR_1|RD_2,		0,	I38,	0}, /* preceded by BREAK, SDBBP */
{"move",	"",		"d,s",		0x20000290, 0xffe007ff, WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* OR */
{"move",	"",		"d,s",		0x20000150, 0xffe007ff, WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* ADDU */
{"move",	"",		"d,s",		0xc0000150, 0xffe007ff, WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DADDU */
{"sigrie",	"",		"+J",		0x00000000, 0xfff80000,	0,			0,	I38,	0},
{"synci",	"[u12]",	"o(b)",		0x87e03000, 0xffe0f000,	RD_2,			0,	I38,	0}, /* SYNCI[U12] */
{"synci",	"[s9]",		"+j(b)",	0xa7e01800, 0xffe07f00,	RD_2,			0,	I38,	0}, /* SYNCI[S9] */
{"syncie",	"",		"+j(b)",	0xa7e01a00, 0xffe07f00,	RD_2,			0,	0,		EVA},
{"jrc", 	"[16]", 	"mp",		0xd800,		0xfc1f,	RD_1,			0,	I38,	0}, /* JRC[16] */
{"jrc", 	"[32]",		"s",		0x48000000, 0xffe0ffff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* JALRC */
{"jalrc",	"[16]",		"mp",		0xd810,		0xfc1f,	WR_31|RD_1,		0,	I38,	0}, /* JALRC[16] */
{"jalrc",	"[16]",		"my,mp",	0xd810,		0xfc1f,	WR_31|RD_1,	INSN2_ALIAS,	I38,	0}, /* JALRC[16] */
{"jalrc",	"[32]",		"s",		0x4be00000, 0xffe0ffff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* JALRC[32] */
{"jalrc",	"[32]",		"t,s",		0x48000000, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"jalrc",	"",	        "mp,-i",	0xd810,		0xfc1f,	WR_31|RD_1, 	INSN2_ALIAS, 	I38,	0}, /* JALRC[16] */
{"jalrc",	"",		"s,-i",		0x4be00000, 0xffe0ffff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* JALRC[32] */
{"jr",		"",		"mp",		0xd800,		0xfc1f,	RD_1, 	    INSN2_ALIAS|UBR|CTC, I38,	0}, /* JRC */
{"jr",		"",		"s",		0x48000000, 0xffe0ffff,	RD_1, 	    INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC */
{"jalr",	"",		"my,mp",	0xd810,		0xfc1f,	WR_31|RD_1, INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC[16] */
{"jalr",	"",	        "mp",		0xd810,		0xfc1f,	WR_31|RD_1, INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC[16] */
{"jalr",	"",		"s",		0x4be00000, 0xffe0ffff,	RD_1,	    INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC */
{"jalr",	"",		"t,s",		0x48000000, 0xfc00ffff,	WR_1|RD_2,  INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC */
{"lui", 	"", 		"t,u",		0xe0000000, 0xfc000002,	WR_1,			0,	I38,	0},
{"li",		"[16]",		"md,mI",	0xd000,		0xfc00,	WR_1,			0,	I38,	0}, /* LI[16] */
{"li",		"",		"-p,mZ",	0x1000,		0xfc1f,	WR_1,		INSN2_ALIAS,	I38,	0}, /* MOVE[16] */
{"li",		"[32]",		"-t,j",		0x00000000, 0xfc1f0000,	WR_1,		INSN2_ALIAS,	I38,	0}, /* ADDIU[32] */
{"li",		"[neg]",	 "t,h",		0x80008000, 0xfc1ff000,	WR_1,		INSN2_ALIAS,	I38,	0}, /* ADDIU[NEG] */
{"li",		"", 		"t,x",		0xe0000000, 0xfc000002,	WR_1,		INSN2_ALIAS,	I38,	0}, /* LUI */
{"li",		"[48]",		"mp,+Q",	0x6000, 	0xfc1f,	WR_1,			0,	0,	xNMS}, /* LI[48] */
{"li",		"",		"-t,A",		0,	(int) M_LI,	INSN_MACRO,	INSN2_MACRO,	I38,	0},
{"ext", 	"",		"t,r,+A,+C",	0x8000f000, 0xfc00f820,	WR_1|RD_2,		0,	0,	xNMS},
{"ext", 	"",		"t,r,+A,+C",	0,    (int) M_EXT,	INSN_MACRO,		0,	I38,	0},

/* Precedence=0 */
{"abs", 	"", 		"d,v",		0,	   (int) M_ABS,	INSN_MACRO,		0,	I38,	0},
{"abs.d",	"",		"T,V",		0xa000237b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"abs.s",	"",		"T,V",		0xa000037b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"absq_s.ph",	"",		"t,s",		0x2000113f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"absq_s.qb",	"",		"t,s",		0x2000013f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"absq_s.w",	"",		"t,s",		0x2000213f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"aclr",	"",		"\\,+j(b)",	0xa6001100, 0xff007f00,		RD_3,		0,	0,	MC},
{"aclr",	"",		"\\,A(c)",	0,    (int) M_ACLR_AB,	INSN_MACRO,		0,	0,	MC},
{"add", 	"", 		"d,v,t",	0x20000110, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	xNMS},
{"add", 	"", 		"t,r,I",	0,    (int) M_ADD_I,	INSN_MACRO,		0,	0,	xNMS},
{"addi",	"", 		"t,r,I",	0,    (int) M_ADD_I,	INSN_MACRO,		0,	0,	xNMS},
{"add.d",	"",		"D,V,T",	0xa0000130, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"add.s",	"",		"D,V,T",	0xa0000030, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"addiu",	"[r1.sp]",	"md,ms,mW",	0x7040,		0xfc40,	WR_1|RD_2,		0,	I38,	0}, /* ADDIU[R1.SP] */
{"addiu",	"[r2]",		"md,mc,mB",	0x9000,		0xfc08,	WR_1|RD_2,		0,	I38,	0}, /* ADDIU[R2] */
{"addiu",	"[rs5]",	"mp,mx,+9",	0x9008,		0xfc08,	MOD_1,		INSN2_ALIAS,	I38,	0}, /* ADDIU[RS5] */
{"addiu",	"[rs5]",	"mp,+9",	0x9008,		0xfc08,	MOD_1,			0,	I38,	0}, /* ADDIU[RS5], preceded by NOP[16] */
{"addiu",	"[gp.b]",	"t,ma,+1",	0x440c0000, 0xfc1c0000,	WR_1|RD_2,		0,	I38,	0}, /* ADDIU[GP.B] */
{"addiu",	"[gp.w]",	"t,ma,.",	0x40000000, 0xfc000003,	WR_1|RD_2,		0,	I38,	0}, /* ADDIU[GP.W] */
{"addiu",	"[32]",		"-t,r,j",	0x00000000, 0xfc000000,	WR_1|RD_2,		0,	I38,	0}, /* preceded by S
IGRIE */
{"addiu",	"[neg]",	"t,r,h",	0x80008000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0}, /* ADDIU[NEG] */
{"addiu",	"[48]",		"mp,mt,+R",	0x6001,     0xfc1f,	MOD_1,			0,	0,	xNMS}, /* ADDIU[48] */
{"addiu",	"[gp48]",	"mp,ma,+T",	0x6002,     0xfc1f,	WR_1|RD_2,		0,	0,	xNMS}, /* ADDIU[GP48] */
{"lapc",	"[32]",		"t,+r",		0x04000000, 0xfc000000, WR_1,		INSN2_ALIAS,	I38,	0}, /* ADDIUPC */
{"lapc",	"[48]",		"mp,+S",	0x6003,     0xfc1f,	WR_1,		INSN2_ALIAS,	0,	xNMS}, /* ADDIUPC[48] */
{"lapc.h",	"",		"t,+r",		0x04000000, 0xfc000000, WR_1,		INSN2_ALIAS,	I38,	0}, /* ADDIUPC */
{"lapc.b",	"",		"mp,+S",	0x6003,     0xfc1f,	WR_1,		INSN2_ALIAS,	0,	xNMS}, /* ADDIUPC[48] */
{"addiupc",	"[32]",		"t,+s",		0x04000000, 0xfc000000, WR_1,			0,	I38,	0},
{"addiupc",	"[48]",		"mp,+U",	0x6003,     0xfc1f,	WR_1,			0,	0,	xNMS}, /* ADDIUPC[48] */
{"addiu.b",	"",	        "t,ma,+1",	0x440c0000, 0xfc1c0000,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* ADDIU[GP.B] */
{"addiu.w",	"",		"t,ma,.",	0x40000000, 0xfc000003,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* ADDIU[GP.W] */
{"addiu.b32",	"",		"mp,ma,+T",	0x6002,     0xfc1f,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ADDIU[GP48] */
{"addq.ph",	"",		"d,s,t",	0x2000000d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addqh.ph",	"",		"d,s,t",	0x2000004d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addqh.w",	"",		"d,s,t",	0x2000008d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addqh_r.ph",	"",		"d,s,t",	0x2000044d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addqh_r.w",	"",		"d,s,t",	0x2000048d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addq_s.ph",	"",		"d,s,t",	0x2000040d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addq_s.w",	"",		"d,s,t",	0x20000305, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addsc",	"",		"d,s,t",	0x20000385, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addu",	"[16]",		"me,mc,md",	0xb000,		0xfc01, WR_1|RD_2|RD_3,		0,	I38,	0}, /* ADDU[16] */
{"addu",	"[4x4]",	"+4,mt,+5",	0x3c00,		0xfd08,	MOD_1|RD_3,		0,	0,	xNMS}, /* ADDU[4X4] */
{"addu",	"[4x4]",	"+4,+5,mx",	0x3c00,		0xfd08,	MOD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ADDU[4X4] */
{"addu",	"[32]",		"d,v,t",	0x20000150, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"addu",	"",		"t,r,I",	0,    (int) M_ADDU_I,	INSN_MACRO,		0,	I38,	0},
{"addu.ph",	"",		"d,s,t",	0x2000010d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addu.qb",	"",		"d,s,t",	0x200000cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"adduh.qb",	"",		"d,s,t",	0x2000014d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"adduh_r.qb",	"", 		"d,s,t",	0x2000054d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addu_s.ph",	"",		"d,s,t",	0x2000050d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addu_s.qb",	"",		"d,s,t",	0x200004cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"addwc",	"",		"d,s,t",	0x200003c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extw",	"",		"d,s,t,+I",	0x2000001f, 0xfc00003f, WR_1|RD_2|RD_3,		0,	I38,	0},
{"align",	"",		"-p,-i,mj,mz",	0x1000,     0xfc00, 	WR_1|RD_3,	INSN2_ALIAS,	I38,	0}, /* MOVE[16] */
{"align",	"",		"d,-i,s,mz",	0x20000290, 0xffe007ff, WR_1|RD_3,	INSN2_ALIAS,	I38,	0}, /* MOVE[32] */
{"align",	"",		"d,s,t,+:",	0x2000001f, 0xfc00003f, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* EXTW */
{"and", 	"[16]",		"md,mx,ml",	0x5008,		0xfc0f,	MOD_1|RD_3,	INSN2_ALIAS,	I38,	0}, /* AND[16] */
{"and", 	"[16]",		"md,ml,mx",	0x5008,		0xfc0f,	MOD_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* AND[16] */
{"and", 	"[16]",		"md,ml",	0x5008,		0xfc0f,	MOD_1|RD_2,		0,	I38,	0}, /* AND[16] */
{"and", 	"[32]",		"d,v,t",	0x20000250, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"and", 	"[32]",		"t,r,I",	0,    (int) M_AND_I,	INSN_MACRO,		0,	I38,	0},
{"andi",	"[16]",	        "md,mc,mC",	0xf000,		0xfc00,	WR_1|RD_2,		0,	I38,	0}, /* ANDI[16] */
{"andi",	"[32]",		"t,r,g",	0x80002000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0},
{"andi",	"",		"t,r,m6",	0x8000f000, 0xfc00f83f,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* EXT */
{"append",	"",		"t,s,+i",	0x20000215, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32},
{"aset",	"",		"\\,+j(b)",	0xa4001100, 0xff007f00,		RD_3,		0,	0,	MC},
{"aset",	"",		"\\,A(c)",	0,    (int) M_ASET_AB,		INSN_MACRO,	0,	0,	MC},
{"balc",	"[16]",		"mD",		0x3800,		0xfc00,		WR_31,		0,	I38,	0}, /* BALC[16] */
{"balc",	"[32]",		"+'",		0x2a000000, 0xfe000000,		WR_31,		0,	I38,	0},
{"bal", 	"",		"mD",		0x3800,		0xfc00,	WR_31,	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BALC[16] */
{"bal", 	"",		"+'",		0x2a000000, 0xfe000000,	WR_31,	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BALC */
{"balign",	"",		"d,-m,s,+:",	0x2000001f, 0xfc00003f, WR_1|RD_3,	INSN2_ALIAS,	0,	D32}, /* EXTW */
{"balrsc",	"",		"-t,s",		0x48008200, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"balrsc",	"",		"s",		0x4be08200, 0xffe0ffff,	RD_1|WR_31,		0,	I38,	0}, /* BALRSC */
{"bbeqzc",	"",		"t,+i,~",	0xc8040000, 0xfc1f0000,	RD_1,			0,	0,	xNMS},
{"bbnezc",	"",		"t,+i,~",	0xc8140000, 0xfc1f0000,	RD_1,			0,	0,	xNMS},
{"bc",		"[16]",		"mD",		0x1800,		0xfc00,	0,			0,	I38,	0}, /* BC[16] */
{"bc",		"[32]",		"+'",		0x28000000, 0xfe000000,	0,			0,	I38,	0},
{"b",		"",		"mD",		0x1800,		0xfc00,	0, 	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BC[16] */
{"b",		"",		"+'",		0x28000000, 0xfe000000,	0, 	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BC */
{"bc1eqzc",	"",		"T,p",		0x88004000, 0xfc1fc000,	RD_1,			0,	I38,	0},
{"bc1eqz",	"",		"T,p",		0x88004000, 0xfc1fc000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BC1EQZC */
{"bc1nezc",	"",		"T,p",		0x88014000, 0xfc1fc000,	RD_1,			0,	I38,	0},
{"bc1nez",	"",		"T,p",		0x88014000, 0xfc1fc000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BC1NEZC */
{"bc2eqzc",	"",		"E,p",		0x88024000, 0xfc1fc000,	RD_1,			0,	I38,	0},
{"bc2eqz",	"",		"E,p",		0x88024000, 0xfc1fc000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BC2EQZC */
{"bc2nezc",	"",		"E,p",		0x88034000, 0xfc1fc000,	RD_1,			0,	I38,	0},
{"bc2nez",	"",		"E,p",		0x88034000, 0xfc1fc000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BC2NEZC */
{"beqzc",	"[16]",		"md,mE",	0x9800,		0xfc00,	RD_1,			0,	I38,	0}, /* BEQZC[16] */
{"beqzc",	"[32]",		"t,p",		0x88000000, 0xfc1fc000,	RD_1,	INSN2_ALIAS,		I38,	0}, /* BEQC */
{"beqzc",	"[32]",		"s,p",		0x88000000, 0xffe0c000,	RD_1,	INSN2_ALIAS,		I38,	0}, /* BEQC */
{"beqz",	"",		"md,mE",	0x9800,		0xfc00,	RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQZC[16] */
{"beqz",	"",	        "t,p",		0x88000000, 0xfc1fc000,	RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQC */
{"beqz",	"",		"s,p",		0x88000000, 0xffe0c000,	RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQC */
{"beqc",	"[16]",		"md,z,mE",	0x9800,		0xfc00,	RD_1,	INSN2_ALIAS,		I38,	0}, /* BEQZC[16] */
{"beqc",	"[16]",		"z,md,mE",	0x9800,		0xfc00,	RD_1,	INSN2_ALIAS,		I38,	0}, /* BEQZC[16] */
{"beqc",	"[16]",		"ml,-u,mF",	0xd800,		0xfc00,	RD_1|RD_2,		0,	0,	xNMS}, /* BEQC[16], with rs3<rt3 && u[4:1]!=0 */
{"beqc",	"[16]",		"md,-v,mF",	0xd800,		0xfc00,	RD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* BEQC[16], with operands commutated */
{"beqc",	"[32]",		"s,t,p",	0x88000000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"beq", 	"",		"md,z,mE",	0x9800,		0xfc00,	RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQZC[16] */
{"beq", 	"",		"z,md,mE",	0x9800,		0xfc00,	RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQZC[16] */
{"beq", 	"",		"ml,-u,mF",	0xd800,		0xfc00,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	0,	xNMS}, /* BEQC[16], with rs3<rt3 && u[4:1]!=0 */
{"beq", 	"",		"md,-v,mF",	0xd800,		0xfc00,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	0,	xNMS}, /* BEQC[16], with operands commutated */
{"beq", 	"", 		"s,t,p",	0x88000000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BEQC */
{"beq", 	"", 		"s,I,p",	0,    (int) M_BEQ_I,	INSN_MACRO,		0,	I38,	0},
{"beqic",	"",		"t,m9,~",	0xc8000000, 0xfc1c0000,		RD_1,		0,	I38,	0},
{"blezc",	"",		"t,p",		0x88008000, 0xfc1fc000,	RD_1,	INSN2_ALIAS,	I38,	0}, /* BGEC $0, t */
{"blez",	"",		"t,p",		0x88008000, 0xfc1fc000,	RD_1, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BGEC $0, t */
{"bgezc",	"",		"s,p",		0x88008000, 0xffe0c000,	RD_1,	INSN2_ALIAS,	I38,	0}, /* BGEC s, $0 */
{"bgez",	"",		"s,p",		0x88008000, 0xffe0c000,	RD_1, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BGEC s, $0 */
{"bgec",	"",		"s,t,p",	0x88008000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"bge", 	"", 		"s,t,p",	0x88008000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BGEC */
{"bge", 	"", 		"s,I,p",	0,    (int) M_BGE_I,	INSN_MACRO,		0,	I38,	0},
{"bgt", 	"", 		"s,t,p",	0,    (int) M_BGT,	INSN_MACRO,		0,	I38,	0},
{"bgt", 	"", 		"s,I,p",	0,    (int) M_BGT_I,	INSN_MACRO,		0,	I38,	0},
{"bgtu",	"",		"s,t,p",	0,    (int) M_BGTU,	INSN_MACRO,		0,	I38,	0},
{"bgtu",	"",		"s,I,p",	0,    (int) M_BGTU_I,	INSN_MACRO,		0,	I38,	0},
{"ble", 	"", 		"s,t,p",	0,    (int) M_BLE,	INSN_MACRO,		0,	I38,	0},
{"ble", 	"", 		"s,I,p",	0,    (int) M_BLE_I,	INSN_MACRO,		0,	I38,	0},
{"bleu",	"",		"s,t,p",	0,    (int) M_BLEU,	INSN_MACRO,		0,	I38,	0},
{"bleu",	"",		"s,I,p",	0,    (int) M_BLEU_I,	INSN_MACRO,		0,	I38,	0},
{"bgezal",	"",		"s,p",		0,    (int) M_BGEZAL,	INSN_MACRO,		0,	I38,	0},
{"bgeic",	"",		"t,m9,~",	0xc8080000, 0xfc1c0000,		RD_1,		0,	I38,	0},
{"bgeuc",	"",	        "s,t,p",	0x8800c000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"bgeu",	"",		"s,t,p",	0x8800c000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BGEUC */
{"bgeu",	"",		"s,I,p",	0,    (int) M_BGEU_I,	INSN_MACRO,		0,	I38,	0},
{"bgeiuc",	"",		"t,m9,~",	0xc80c0000, 0xfc1c0000,		RD_1,		0,	I38,	0},
{"bitrev",	"",		"t,r",		0x2000313f, 0xfc00ffff,	WR_1|RD_2,     		0,	0,	D32}, /* ROTX t,s,7,8,1 */
{"bitrevb",	"",		"t,r",		0x8000d247, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,7,8,1 */
{"bitrevh",	"",		"t,r",		0x8000d40f, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,15,16 */
{"bitrevw",	"",		"t,r",		0x8000d01f, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,31,0*/
{"bitswap",	"",		"t,r",		0x8000d247, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,7,8,1*/
{"bgtzc",	"",		"t,p",		0xa8008000, 0xfc1fc000,	RD_1,		INSN2_ALIAS,	I38,	0}, /* BLTC $0, t */
{"bgtz",	"",		"t,p",		0xa8008000, 0xfc1fc000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BLTC $0, t */
{"bltzc",	"",		"s,p",		0xa8008000, 0xffe0c000,	RD_1,		INSN2_ALIAS,	I38,	0}, /* BLTC s, $0 */
{"bltz",	"",		"s,p",		0xa8008000, 0xffe0c000,	RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BLTC s, $0 */
{"bltc",	"",		"s,t,p",	0xa8008000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"blt", 	"", 		"s,t,p",	0xa8008000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BLTC */
{"blt", 	"", 		"s,I,p",	0,    (int) M_BLT_I,	INSN_MACRO,		0,	I38,	0},
{"bltzal",	"",		"s,p",		0,    (int) M_BLTZAL,	INSN_MACRO,		0,	I38,	0},
{"bltic",	"",		"t,m9,~",	0xc8180000, 0xfc1c0000,		RD_1,		0,	I38,	0},
{"bltuc",	"",		"s,t,p",	0xa800c000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"bltu",	"",		"s,t,p",	0xa800c000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BLTUC */
{"bltu",	"",		"s,I,p",	0,    (int) M_BLTU_I,	INSN_MACRO,		0,	I38,	0},
{"bltiuc",	"",		"t,m9,~",	0xc81c0000, 0xfc1c0000, RD_1,			0,	I38,	0},
{"bnezc",	"[16]",		"md,mE",	0xb800,		0xfc00, RD_1,			0,	I38,	0}, /* BNEZC[16] */
{"bnezc",	"[32]",		"t,p",		0xa8000000, 0xfc1fc000, RD_1,		INSN2_ALIAS,	I38,	0}, /* BNEC */
{"bnezc",	"[32]",		"s,p",		0xa8000000, 0xffe0c000, RD_1,		INSN2_ALIAS,	I38,	0}, /* BNEC */
{"bnez",	"",		"md,mE",	0xb800,		0xfc00, RD_1, 	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BNEZC[16] */
{"bnez",	"",		"t,p",		0xa8000000, 0xfc1fc000, RD_1,	INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BNEC */
{"bnez",	"",		"s,p",		0xa8000000, 0xffe0c000,		RD_1,	INSN2_ALIAS,	I38,	0}, /* BNEC */
{"bnec",	"[16]",		"md,z,mE",	0xb800,		0xfc00,	RD_1,		INSN2_ALIAS,	I38,	0}, /* BNEZC[16] */
{"bnec",	"[16]",		"z,md,mE",	0xb800,		0xfc00,	RD_2,		INSN2_ALIAS,	I38,	0}, /* BNEZC[16] */
{"bnec",	"[16]",		"ml,-w,mF",	0xd800,		0xfc00,	RD_1|RD_2,		0,	0,	xNMS}, /* BNEC[16], with rs3>=rt3 && u[4:1]!=0 */
{"bnec",	"[16]",		"md,-x,mF",	0xd800,		0xfc00,	RD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* BNEC[16], with operands commutated */
{"bnec",	"[32]",		"s,t,p",	0xa8000000, 0xfc00c000,	RD_1|RD_2,		0,	I38,	0},
{"bne", 	"",	        "md,z,mE",	0xb800,		0xfc00,	RD_1, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BNEZC[16] */
{"bne", 	"",		"z,md,mE",	0xb800,		0xfc00,	RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BNEZC[16] */
{"bne", 	"",		"ml,-w,mF",	0xd800,		0xfc00,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	0,	xNMS}, /* BNEC[16], with rs3>=rt3 && u[4:1]!=0 */
{"bne", 	"",		"md,-x,mF",	0xd800,		0xfc00,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	0,	xNMS}, /* BNEC[16], with operands commutated */
{"bne", 	"",		"s,t,p",	0xa8000000, 0xfc00c000,	RD_1|RD_2, INSN2_ALIAS|CBR|CTC,	I38,	0}, /* BNEC */
{"bne", 	"",		"s,I,p",	0,    (int) M_BNE_I,	INSN_MACRO,		0,	I38,	0},
{"bneic",	"",		"t,m9,~",	0xc8100000, 0xfc1c0000,		RD_1,		0,	I38,	0},
{"bposge32c",	"",		"p",		0x88044000, 0xffffc000,		0,		0,	0,	D32},
{"bposge32",	"",		"p",		0x88044000, 0xffffc000,	0,	INSN2_ALIAS|CBR|CTC,	0,	D32}, /* BPOSGE32C */
{"brsc",	"",		"s",		0x48008000, 0xffe0ffff,	RD_1,			0,	I38,	0},
{"byterevh",	"",		"t,r",		0x8000d608, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,8,24 */
{"byterevw",	"",		"t,r",		0x8000d218, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,24,8 */
{"cache",	"",		"k,+j(b)",	0xa4003900, 0xfc007f00,		RD_3,		0,	I38,	0},
{"cache",	"",		"k,A(c)",	0,    (int) M_CACHE_AB,		INSN_MACRO,	0,	I38,	0},
{"cachee",	"",		"k,+j(b)",	0xa4003a00, 0xfc007f00,		RD_3,		0,	0,	EVA},
{"cachee",	"",		"k,A(c)",	0,    (int) M_CACHEE_AB,	INSN_MACRO,	0,	0,	EVA},
{"ceil.l.d",	"",		"T,S",		0xa000533b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"ceil.l.s",	"",		"T,S",		0xa000133b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"ceil.w.d",	"",		"T,S",		0xa0005b3b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"ceil.w.s",	"",		"T,S",		0xa0001b3b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"cfc1",	"",		"t,S",		0xa000103b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"cfc1",	"",		"t,G",		0xa000103b, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0},
{"cfc2",	"",		"t,G",		0x2000cd3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"cftc1",	"",		"t,G",		0x20001e30, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"cftc1",	"",		"t,S",		0x20001e30, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"cftc2",	"",		"t,G",		0x20002e30, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"class.d",	"",		"T,S",		0xa0000260, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"class.s",	"",		"T,S",		0xa0000060, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"clo", 	"",		"t,s",		0x20004b3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	xNMS},
{"clz", 	"",		"t,s",		0x20005b3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	xNMS},
{"cmp.af.d",	"",		"D,S,T",	0xa0000015, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.af.s",	"",	        "D,S,T",	0xa0000005, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.eq.d",	"",		"D,S,T",	0xa0000095, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.eq.ph",	"",		"s,t",		0x20000005, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cmp.eq.s",	"",		"D,S,T",	0xa0000085, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.le.d",	"",		"D,S,T",	0xa0000195, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.le.ph",	"",		"s,t",		0x20000085, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cmp.le.s",	"",		"D,S,T",	0xa0000185, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.lt.d",	"",		"D,S,T",	0xa0000115, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.lt.ph",	"",		"s,t",		0x20000045, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cmp.lt.s",	"",		"D,S,T",	0xa0000105, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.ne.d",	"",		"D,S,T",	0xa00004d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.ne.s",	"",		"D,S,T",	0xa00004c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.or.d",	"",		"D,S,T",	0xa0000455, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.or.s",	"",		"D,S,T",	0xa0000445, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.saf.d",	"",		"D,S,T",	0xa0000215, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.saf.s",	"",		"D,S,T",	0xa0000205, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.seq.d",	"",		"D,S,T",	0xa0000295, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.seq.s",	"",		"D,S,T",	0xa0000285, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sle.d",	"",		"D,S,T",	0xa0000395, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sle.s",	"",		"D,S,T",	0xa0000385, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.slt.d",	"",		"D,S,T",	0xa0000315, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.slt.s",	"",		"D,S,T",	0xa0000305, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sne.d",	"",		"D,S,T",	0xa00006d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sne.s",	"",		"D,S,T",	0xa00006c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sor.d",	"",		"D,S,T",	0xa0000655, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sor.s",	"",		"D,S,T",	0xa0000645, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sueq.d",	"", 		"D,S,T",	0xa00002d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sueq.s",	"", 		"D,S,T",	0xa00002c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sule.d",	"", 		"D,S,T",	0xa00003d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sule.s",	"", 		"D,S,T",	0xa00003c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sult.d",	"", 		"D,S,T",	0xa0000355, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sult.s",	"", 		"D,S,T",	0xa0000345, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S|FP_D, 0,	I38,	0},
{"cmp.sun.d",	"",		"D,S,T",	0xa0000255, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sun.s",	"",		"D,S,T",	0xa0000245, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.sune.d",	"", 		"D,S,T",	0xa0000695, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.sune.s",	"", 		"D,S,T",	0xa0000685, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.ueq.d",	"",		"D,S,T",	0xa00000d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.ueq.s",	"",		"D,S,T",	0xa00000c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.ule.d",	"",		"D,S,T",	0xa00001d5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.ule.s",	"",		"D,S,T",	0xa00001c5, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.ult.d",	"",		"D,S,T",	0xa0000155, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.ult.s",	"",		"D,S,T",	0xa0000145, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.un.d",	"",		"D,S,T",	0xa0000055, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.un.s",	"",		"D,S,T",	0xa0000045, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmp.une.d",	"",		"D,S,T",	0xa0000495, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"cmp.une.s",	"",		"D,S,T",	0xa0000485, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"cmpgdu.eq.qb", "", 		"d,s,t",	0x20000185, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpgdu.le.qb", "", 		"d,s,t",	0x20000205, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpgdu.lt.qb", "", 		"d,s,t",	0x200001c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpgu.eq.qb",	"", 		"d,s,t",	0x200000c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpgu.le.qb",	"", 		"d,s,t",	0x20000145, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpgu.lt.qb",	"", 		"d,s,t",	0x20000105, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"cmpu.eq.qb",	"", 		"s,t",		0x20000245, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cmpu.le.qb",	"", 		"s,t",		0x200002c5, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cmpu.lt.qb",	"", 		"s,t",		0x20000285, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"cop2_1",	"",		"C",		0x20000002, 0xfc000007,		0,		0,	I38,	0},
{"crc32b",	"",		"t,r",		0x200003e8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32h",	"",		"t,r",		0x200007e8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32w",	"",		"t,r",		0x20000be8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32d",	"",		"t,r",		0x20000fe8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC64},
{"crc32cb",	"",		"t,r",		0x200013e8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32ch",	"",		"t,r",		0x200017e8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32cw",	"",		"t,r",		0x20001be8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC},
{"crc32cd",	"",		"t,r",		0x20001fe8, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CRC64},
{"ctc1",	"",		"t,S",		0xa000183b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"ctc1",	"",		"t,G",		0xa000183b, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	I38,	0},
{"ctc2",	"",		"t,G",		0x2000dd3f, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"cttc1",	"",		"t,G",		0x20001e70, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"cttc1",	"",		"t,S",		0x20001e70, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"cttc2",	"",		"t,G",		0x20002e70, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"cvt.d.l",	"",		"T,S",		0xa000537b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"cvt.d.s",	"",		"T,S",		0xa000137b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.d.w",	"",		"T,S",		0xa000337b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.l.d",	"",		"T,S",		0xa000413b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"cvt.l.s",	"",		"T,S",		0xa000013b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.s.d",	"",		"T,S",		0xa0001b7b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.s.l",	"",		"T,S",		0xa0005b7b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.s.w",	"",		"T,S",		0xa0003b7b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"cvt.w.d",	"",		"T,S",		0xa000493b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"cvt.w.s",	"",		"T,S",		0xa000093b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"dabs",	"",		"d,v",		0,    	  (int) M_DABS,	INSN_MACRO,		0,	I38,	0},
{"dadd",	"",		"d,v,t",	0xc0000110, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dadd",	"",		"t,r,I",	0,    (int) M_DADD_I,	INSN_MACRO,		0,	I70,	0},
{"daddiu",	"[neg]",	"t,r,h",	0x80008000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0}, /* DADDIU[NEG] */
{"daddiu",	"[u12]",	"t,r,i",	0x8000a000, 0xfc00f000,	WR_1|RD_2,		0,	I70,	0}, /* DADDIU[U12] */
{"daddiu",	"[gp]",		"t,ma,.",	0x40000000, 0xfc000003,	WR_1|RD_2,		0,	I70,	0}, /* ADDIU[GP] */
{"daddiu",	"[48]",		"mp,mt,+R",	0x6011, 	0xfc1f,	MOD_1,			0,	I70,	0}, /* DADDIU[48] */
{"daddiu",	"[gp48]",	"mp,ma,+T",	0x6012,		0xfc1f,	WR_1|RD_2,		0,	I70,	0}, /* DADDIU[GP48] */
{"daddu",	"",		"d,v,t",	0xc0000150, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"daddu",	"",		"t,r,I",	0,    (int) M_DADDU_I,	INSN_MACRO,		0,	I70,	0},
{"dahi",	"",		"t,mO",		0x80008000, 0xfc00f000,		WR_1,		0,	I70,	0},
{"extd",	"",		"d,s,t,+I",	0xc0000004, 0xfc00003f, WR_1|RD_2|RD_3,		0,	I70,	0},
{"extd32",	"",		"d,s,t,+I",	0xc000000c, 0xfc00003f, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dati",	"",		"t,mP",		0x80009000, 0xfc10f000,		WR_1,		0,	I70,	0},
{"dbitswap",	"",		"t,s",		0xc0000b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"dclo",	"",		"t,s",		0xc0004b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"dclz",	"",		"t,s",		0xc0005b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"ddiv",	"",		"d,v,t",	0xc0000118, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"ddiv",	"", 		"d,v,I",	0,    (int) M_DDIV_I,	INSN_MACRO,		0,	I70,	0},
{"ddivu",	"",		"d,v,t",	0xc0000198, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"ddivu",	"",		"d,v,I",	0,    (int) M_DIVU_I,	INSN_MACRO,		0,	I70,	0},
{"deret",	"",		"",		0x2000e37f, 0xffffffff,		0,		0,	I38,	0},
{"dext",	"",		"t,r,+A,+H",	0x8000f820, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"dext",	"",		"t,r,+A,+G",	0x8000f800, 0xfc00f820,	WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DEXTM */
{"dext",	"",		"t,r,+E,+H",	0x8000f020, 0xfc00f820,	WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DEXTU */
{"dextm",	"",		"t,r,+A,+G",	0x8000f800, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"dextu",	"",		"t,r,+E,+H",	0x8000f020, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"di",		"",		"",		0x2000477f, 0xffffffff,		0,	INSN2_ALIAS,	I38,	0},
{"di",		"",		"w",		0x2000477f, 0xfc1fffff,		WR_1,		0,	I38,	0},
{"dins",	"",		"t,r,+A,+B",	0x8000e820, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"dins",	"",		"t,r,+A,+F",	0x8000e800, 0xfc00f820,	WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DINSM */
{"dins",	"",		"t,r,+E,+F",	0x8000e020, 0xfc00f820,	WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DINSU */
{"dinsm",	"",		"t,r,+A,+F",	0x8000e800, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"dinsu",	"",		"t,r,+E,+F",	0x8000e020, 0xfc00f820,	WR_1|RD_2,		0,	I70,	0},
{"div", 	"", 		"d,v,t",	0x20000118, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"div", 	"", 		"d,v,I",	0,    (int) M_DIV_I,	INSN_MACRO,		0,	I38,	0},
{"div.d",	"",		"D,V,T",	0xa00001f0, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"div.s",	"",		"D,V,T",	0xa00000f0, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"divu",	"",		"d,v,t",	0x20000198, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"divu",	"",		"d,v,I",	0,    (int) M_DIVU_I,	INSN_MACRO,		0,	I38,	0},
{"dli", 	"[neg]",	"t,h",		0x8000a000, 0xfc1ff000,	WR_1,			0,	I70,	0}, /* DADDIU[NEG] */
{"dli", 	"[u12]",	"t,i",		0x8000a000, 0xfc1ff000,	WR_1,			0,	I70,	0}, /* DADDIU[U12] */
{"dli", 	"", 		"t,I",		0,    (int) M_DLI,	INSN_MACRO,		0,	I70,	0},
{"dlsa",	"",		"d,v,t,+.",	0xc0000008, 0xfc0001ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dlui",	"[48]",		"mp,+Q",	0x6014, 	0xfc1f,	WR_1,			0,	I70,	0}, /* DLUI[48] */
{"dmfc0",	"",		"t,O",		0x20000130, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	I70,	0}, /* DMFC0 with named register */
{"dmfc0",	"",		"t,P,J",	0x20000130, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	I70,	0}, /* DMFC0 with named register & select */
{"dmfc0",	"",		"t,G,J",	0x20000130, 0xfc0007ff,	WR_1,			0,	I70,	0},
{"dmfc1",	"",		"t,S",		0xa000243b, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"dmfc2",	"",		"t,G",		0x20006d3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"dmfgc0",	"",		"t,O",		0x200001b0, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT64}, /* DMFGC0 with named register */
{"dmfgc0",	"",		"t,P,J",	0x200001b0, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT64}, /* DMFGC0 with named register & select */
{"dmfgc0",	"",		"t,G,J",	0x200001b0, 0xfc0007ff,	WR_1,			0,	0,	IVIRT64},
{"dmod",	"",		"d,v,t",	0xc0000158, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dmod",	"",		"d,v,I",	0,    (int) M_DMOD_I,	INSN_MACRO,		0,	I70,	0},
{"dmodu",	"",		"d,v,t",	0xc00001d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dmodu",	"",		"d,v,I",	0,    (int) M_DMODU_I,	INSN_MACRO,		0,	I70,	0},
{"dmt", 	"",		"",		0x20010ab0, 0xffffffff,	0,		INSN2_ALIAS,	0,	MT32},
{"dmt", 	"",		"t",		0x20010ab0, 0xfc1fffff,	WR_1,			0,	0,	MT32},
{"dmtc0",	"",		"t,O",		0x20000170, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	I70,	0}, /* DMTC0 with named register */
{"dmtc0",	"",		"t,P,J",	0x20000170, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	I70,	0}, /* DMTC0 with named register & select */
{"dmtc0",	"",		"t,G,J",	0x20000170, 0xfc0007ff,	RD_1,			0,	I70,	0},
{"dmtc1",	"",		"t,S",		0xa0002c3b, 0xfc00ffff,	RD_1|WR_2,		0,	I70,	0},
{"dmtc2",	"",		"t,G",		0x20007d3f, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"dmtgc0",	"",		"t,O",		0x200001f0, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT64}, /* DMTGC0 with named register */
{"dmtgc0",	"",		"t,P,J",	0x200001f0, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT64}, /* DMTGC0 with named register & select */
{"dmtgc0",	"",		"t,G,J",	0x200001f0, 0xfc0007ff,	RD_1,			0,	0,	IVIRT64},
{"dmuh",	"",		"d,s,t",	0xc0000058, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dmuhu",	"",		"d,s,t",	0xc00000d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dmul",	"",		"d,v,t",	0xc0000018, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dmulu",	"",		"d,s,t",	0xc0000098, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dneg",	"",		"d,w",		0xc0000190, 0xfc1f07ff, WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DSUB */
{"dnegu",	"",		"d,w",		0xc00001d0, 0xfc1f07ff, WR_1|RD_2,	INSN2_ALIAS,	I70,	0}, /* DSUBU */
{"dpa.w.ph",	"",		"7,s,t",	0x200000bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpaqx_s.w.ph", "", 		"7,s,t",	0x200022bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpaqx_sa.w.ph","", 		"7,s,t",	0x200032bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpaq_s.w.ph",	"", 		"7,s,t",	0x200002bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpaq_sa.l.w",	"", 		"7,s,t",	0x200012bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpau.h.qbl",	"", 		"7,s,t",	0x200020bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpau.h.qbr",	"", 		"7,s,t",	0x200030bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpax.w.ph",	"", 		"7,s,t",	0x200010bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dps.w.ph",	"",		"7,s,t",	0x200004bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsqx_s.w.ph", "", 		"7,s,t",	0x200026bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsqx_sa.w.ph", "", 		"7,s,t",	0x200036bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsq_s.w.ph",	"", 		"7,s,t",	0x200006bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsq_sa.l.w",	"", 		"7,s,t",	0x200016bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsu.h.qbl",	"", 		"7,s,t",	0x200024bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsu.h.qbr",	"", 		"7,s,t",	0x200034bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"dpsx.w.ph",	"",		"7,s,t",	0x200014bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32},
{"drol",	"",		"d,v,t",	0,    (int) M_DROL,	INSN_MACRO,		0,	I70,	0},
{"drol",	"",		"d,v,I",	0,    (int) M_DROL_I,	INSN_MACRO,		0,	I70,	0},
{"drotl",	"",		"d,v,t",	0,    (int) M_DROL,	INSN_MACRO,		0,	I70,	0},
{"drotl",	"",		"d,v,I",	0,    (int) M_DROL_I,	INSN_MACRO,		0,	I70,	0},
{"drotr",	"",		"t,r,<",	0x8000c1c0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"drotr32",	"",		"t,r,<",	0x8000c1e0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dror",	"",		"t,r,<",	0x8000c1c0, 0xfc00ffe0,	WR_1|RD_2,    INSN2_ALIAS,	I70,	0}, /* DROTR */
{"dror32",	"",		"t,r,<",	0x8000c1e0, 0xfc00ffe0,	WR_1|RD_2,    INSN2_ALIAS,	I70,	0}, /* DROTR32 */
{"drotrv",	"",		"d,v,t",	0xc00000d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"drorv",	"",		"d,v,t",	0xc00000d0, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I70,	0}, /* DROTRV */
{"dsbh",	"",		"t,r",		0xc0007b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"dshd",	"",		"t,r",		0xc000fb3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0},
{"dsll",	"",		"t,r,<",	0x8000c100, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsll32",	"",		"t,r,<",	0x8000c120, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsllv",	"",		"d,s,t",	0xc0000010, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dsra",	"",		"t,r,<",	0x8000c180, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsra32",	"",		"t,r,<",	0x8000c1a0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsrav",	"",		"d,s,t",	0xc0000090, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dsrl",	"",		"t,r,<",	0x8000c140, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsrl32",	"",		"t,r,<",	0x8000c160, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,	0},
{"dsrlv",	"",		"d,s,t",	0xc0000050, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dsub",	"",		"d,v,t",	0xc0000190, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dsub",	"",		"t,r,I",	0,    (int) M_DSUB_I,	INSN_MACRO,		0,	I70,	0},
{"dsubu",	"",		"d,v,t",	0xc00001d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"dsubu",	"",		"d,v,I",	0,    (int) M_DSUBU_I,	INSN_MACRO,		0,	I70,	0},
{"dvpe",	"",		"",		0x20000ab0, 0xffffffff,	0,		INSN2_ALIAS,	0,	MT32}, /* DVPE */
{"dvpe",	"",		"t",		0x20000ab0, 0xfc1fffff,	WR_1,			0,	0,	MT32},
{"ehb", 	"",		"",		0x8000c003, 0xffffffff,	0,			0,	I38,	0},
{"ei",		"",		"",		0x2000577f, 0xffffffff,	0,		INSN2_ALIAS,	I38,	0},
{"ei",		"",		"t",		0x2000577f, 0xfc1fffff,	WR_1,			0,	I38,	0},
{"emt", 	"",		"",		0x20010eb0, 0xffffffff,	0,		INSN2_ALIAS,	0,	MT32},
{"emt", 	"",		"t",		0x20010eb0, 0xfc1fffff, WR_1,			0,	0,	MT32},
{"eret",	"",		"",		0x2000f37f, 0xffffffff,	0,			0,	I38,	0},
{"eretnc",	"",		"",		0x2001f37f, 0xffffffff,	0,			0,	0,	xNMS},
{"evpe",	"",		"",		0x20000eb0, 0xffffffff,	0,		INSN2_ALIAS,	0,	MT32}, /* EVPE */
{"evpe",	"",		"t",		0x20000eb0, 0xfc1fffff,	WR_1,			0,	0,	MT32},
{"evp", 	"", 	 	"-a",		0x20000790, 0xffe0ffff,	0,		INSN2_ALIAS,	I38,	0}, /* EVP */
{"evp", 	"", 	 	"t,-a",		0x20000790, 0xfc00ffff,	WR_1,			0,	I38,	0},
{"extp",	"",		"t,7,+x",	0x2000267f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"extpdp",	"",		"t,7,+x",	0x2000367f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"extpdpv",	"",		"t,7,s",	0x200038bf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extpv",	"",		"t,7,s",	0x200028bf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extr.w",	"",		"t,7,+x",	0x20000e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"extrv.w",	"",		"t,7,s",	0x20000ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extrv_r.w",	"",		"t,7,s",	0x20001ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extrv_rs.w",	"", 	 	"t,7,s",	0x20002ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extrv_s.h",	"",		"t,7,s",	0x20003ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"extr_r.w",	"",		"t,7,+x",	0x20001e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"extr_rs.w",	"",		"t,7,+x",	0x20002e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"extr_s.h",	"",		"t,7,+x",	0x20003e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32},
{"fork",	"",		"d,s,t",	0x20000228, 0xfc0007ff,	WR_1|RD_2|RD_3,		0,	0,	MT32},
{"floor.l.d",	"",		"T,S",		0xa000433b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"floor.l.s",	"",		"T,S",		0xa000033b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"floor.w.d",	"",		"T,S",		0xa0004b3b, 0xfc00ffff,	WR_1|RD_2|FP_S|FP_D,	0,	I38,	0},
{"floor.w.s",	"",		"T,S",		0xa0000b3b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"ginvi",	"", 		"s",		0x20001f7f, 0xffe0ffff, RD_1,			0,	0,	GINV},
{"ginvt",	"",		"s,+;",		0x20000f7f, 0xff80ffff, RD_1,			0,	0,	GINV},
{"ginvgt",	"",		"s,+;",		0x20000d7f, 0xff80ffff, RD_1,			0,	0,	IVIRT_GINV},
{"hypcall",	"[16]",		"",		0x100c,		0xffff,		0,	INSN2_ALIAS,	0,	IVIRT}, /* HYPCALL[16] */
{"hypcall",	"[16]",		"+o",		0x100c,		0xfffc,		0,		0,	0,	IVIRT}, /* HYPCALL[16] */
{"hypcall",	"[32]",		"",		0x000c0000, 0xffffffff,		0,	INSN2_ALIAS,	0,	IVIRT},
{"hypcall",	"[32]",		"+M",		0x000c0000, 0xfffc0000,		0,		0,	0,	IVIRT},
{"ins", 	"",		"t,r,+A,+B",	0x8000e000, 0xfc00f820,	WR_1|RD_2,		0,	0,	xNMS},
{"ins", 	"",		"t,r,+A,+B",	0,    (int) M_INS,	INSN_MACRO,		0,	I38,	0},
{"insv",	"",		"t,s",		0x2000413f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"iret",	"",		"",		0x2000d37f, 0xffffffff,		0,		0,	0,	MC},
{"j",		"", 		"mp",		0xd800,		0xfc1f,	RD_1,	INSN2_ALIAS|UBR|CTC,	I38,	0},
{"j",		"",		"+'",		0x28000000, 0xfe000000,	0, 	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BC */
{"j",		"",		"s",		0x48000000, 0xffe0ffff,	RD_1,	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* JALRC */
{"jrc.hb",	"",		"s",		0x48001000, 0xffe0ffff,	RD_1,	INSN2_ALIAS,	I38,	0}, /* JALRC.HB */
{"jr.hb",	"",		"s",		0x48001000, 0xffe0ffff,	RD_1, INSN2_ALIAS|UBR|CTC,	I38,	0}, /* JALRC.HB */
{"jalrc.hb",	"",		"s",		0x4be01000, 0xffe0ffff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* JALRC.HB */
{"jalrc.hb",	"",		"t,s",		0x48001000, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"jalr.hb",	"",		"s",		0x4be01000, 0xffe0ffff,	RD_1,	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* JALRC.HB */
{"jalr.hb",	"",		"t,s",		0x48001000, 0xfc00ffff,	WR_1|RD_2, INSN2_ALIAS|UBR|CTC,	I38,	0}, /* JALRC.HB */
/* SVR4 PIC code requires special handling for jal, so it must be a macro.  */
{"jal",		"",		"my,mp",	0xd810,		0xfc1f,	WR_31|RD_1, INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC[16] */
{"jal",		"",	        "mp",		0xd810,		0xfc1f,	WR_31|RD_1, INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC[16] */
{"jal",		"",		"s",		0x4be00000, 0xffe0ffff,	RD_1,	    INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC */
{"jal",		"",		"t,s",		0x48000000, 0xfc00ffff,	WR_1|RD_2,  INSN2_ALIAS|UBR|CTC, I38,	0}, /* JALRC */
{"jal", 	"",		"A",		0,    (int) M_JAL_A,	INSN_MACRO,		0,	I38,	0},
{"jal", 	"",		"+'",		0x2a000000, 0xfe000000,	WR_31,	INSN2_ALIAS|UBR|CTC,	I38,	0}, /* BALC */
{"lb",		"[16]",		"md,mL(ml)",	0x5c00,		0xfc0c,	WR_1|RD_3,		0,	I38,	0}, /* LB[16] */
{"lb",		"[gp]",		"t,+1(ma)",	0x44000000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,	0}, /* LB[GP] */
{"lb",		"[u12]",	"t,o(b)",	0x84000000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LB[U12] */
{"lb",		"[s9]",		"t,+j(b)",	0xa4000000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LB[S9] */
{"lb",		"",		"t,A(c)",	0,    (int) M_LB_AB,	INSN_MACRO,		0,	I38,	0},
{"lbe", 	"", 		"t,+j(b)",	0xa4000200, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA},
{"lbe", 	"", 		"t,A(c)",	0,	(int) M_LBE_AB,	INSN_MACRO,		0,	0,	EVA},
{"lbu", 	"[16]",		"md,mL(ml)",	0x5c08,		0xfc0c,	WR_1|RD_3,		0,	I38,	0}, /* LBU[16] */
{"lbu", 	"[gp]",		"t,+1(ma)",	0x44080000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,	0}, /* LBU[GP] */
{"lbu", 	"[u12]",	"t,o(b)",	0x84002000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LBU[U12] */
{"lbu", 	"[s9]",		"t,+j(b)",	0xa4001000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LBU[S9] */
{"lbu", 	"",		"t,A(c)",	0,    (int) M_LBU_AB,	INSN_MACRO,		0,	I38,	0},
{"lbue",	"",		"t,+j(b)",	0xa4001200, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA},
{"lbue",	"",		"t,A(c)",	0,     (int) M_LBUE_AB,	INSN_MACRO,		0,	0,	EVA},
{"lbux",	"",		"d,s(t)",	0x20000107, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lbx", 	"",		"d,s(t)",	0x20000007, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"ld",		"[gp]",		"t,mV(ma)",	0x40000001, 0xfc000007,	WR_1|RD_3,		0,	I70,	0}, /* LD[GP] */
{"ld",		"[u12]",	"t,o(b)",	0x8400c000, 0xfc00f000,	WR_1|RD_3,		0,	I70,	0}, /* LD[U12] */
{"ld",		"[s9]",		"t,+j(b)",	0xa4006000, 0xfc007f00,	WR_1|RD_3,		0,	I70,	0}, /* LD[S9] */
{"ld",		"",		"t,A(b)",	0,    (int) M_LD_AB,	INSN_MACRO,		0,	I38,	0},
{"ldc1",	"[gp]",		"T,+2(ma)",	0x44180002, 0xfc1c0003,	WR_1|RD_3|FP_D,		0,	I38,	0}, /* LDC1[GP] */
{"ldc1",	"[u12]", 	"T,o(b)",	0x8400e000, 0xfc00f000,	WR_1|RD_3|FP_D,		0,	I38,	0}, /* LDC1[U12] */
{"ldc1",	"[s9]", 	"T,+j(b)",	0xa4007000, 0xfc007f00,	WR_1|RD_3|FP_D,		0,	I38,	0}, /* LDC1[S9] */
{"ldc1",	"",		"T,A(c)",	0,    (int) M_LDC1_AB,	INSN_MACRO,		0,	I38,	0},
{"ldc1",	"",		"E,A(c)",	0,    (int) M_LDC1_AB,	INSN_MACRO,		0,	I38,	0},
{"ldc1x",	"",		"R,s(t)",	0x20000707, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"l.d", 	"[gp]",		"T,+2(ma)",	0x44180002, 0xfc1c0003,	WR_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* LDC1[GP] */
{"l.d", 	"[u12]",	"T,o(b)",	0x8400e000, 0xfc00f000,	WR_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* LDC1 */
{"l.d", 	"[s9]",		"T,+j(b)",	0xa4007000, 0xfc007f00,	WR_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* LDC1[S9] */
{"l.d", 	"",		"T,A(c)",	0,    (int) M_LDC1_AB,	INSN_MACRO,	INSN2_M_FP_D,	I38,	0},
{"ldc1xs",	"",		"R,s(t)",	0x20000747, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"ldc2",	"",		"E,+j(b)",	0xa4006100, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0},
{"ldc2",	"",		"E,A(c)",	0,    (int) M_LDC2_AB,	INSN_MACRO,		0,	I38,	0},
{"ldpc",	"",		"mp,+S",	0x601b,     0xfc1f,	WR_1,			0,	0,	xNMS}, /* LDPC[48] */
{"ldx", 	"",		"d,s,t",	0x20000607, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"ldxs",	"",		"d,s,t",	0x20000647, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"ldxc1",	"",		"R,s(t)",	0x20000707, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* LDC1X */
{"lh",		"[16]", 	"md,mH(ml)",	0x7c00,		0xfc09,	WR_1|RD_3,		0,	I38,	0}, /* LH[16] */
{"lh",		"[gp]", 	"t,+3(ma)",	0x44100000, 0xfc1c0001,	WR_1|RD_3,		0,	I38,	0}, /* LH[GP] */
{"lh",		"[u12]",	 "t,o(b)",	0x84004000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LH[U12] */
{"lh",		"[s9]",		"t,+j(b)",	0xa4002000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LH[S9] */
{"lh",		"",		"t,A(c)",	0,    (int) M_LH_AB,	INSN_MACRO,		0,	I38,	0},
{"lhe", 	"", 		"t,+j(b)",	0xa4002200, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA},
{"lhe", 	"", 		"t,A(c)",	0,     (int) M_LHE_AB,	INSN_MACRO,		0,	0,	EVA},
{"lhu", 	"[16]",		"md,mH(ml)",	0x7c08,		0xfc09,	WR_1|RD_3,		0,	I38,	0}, /* LHU[16] */
{"lhu", 	"[gp]",		"t,+3(ma)",	0x44100001, 0xfc1c0001,	WR_1|RD_3,		0,	I38,	0}, /* LHU[GP] */
{"lhu", 	"[u12]",	 "t,o(b)",	0x84006000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LHU[U12] */
{"lhu", 	"[s9]",		"t,+j(b)",	0xa4003000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LHU[S9] */
{"lhu", 	"", 		"t,A(c)",	0,    (int) M_LHU_AB,	INSN_MACRO,		0,	I38,	0},
{"lhue",	"",		"t,+j(b)",	0xa4003200, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA},
{"lhue",	"",		"t,A(c)",	0,     (int) M_LHUE_AB,	INSN_MACRO,		0,	0,	EVA},
{"lhux",	"",		"d,s(t)",	0x20000307, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lhuxs",	"",		"d,s(t)",	0x20000347, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lhx", 	"",		"d,s(t)",	0x20000207, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lhxs",	"",		"d,s(t)",	0x20000247, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"li.d",	"",		"t,F",		0,    (int) M_LI_D,	INSN_MACRO,	INSN2_M_FP_D,	I38,	0},
{"li.d",	"",		"T,L",		0,    (int) M_LI_DD,	INSN_MACRO,	INSN2_M_FP_D,	I38,	0},
{"li.s",	"",	 	"t,f",		0,    (int) M_LI_S,	INSN_MACRO,	INSN2_M_FP_S,	I38,	0},
{"li.s",	"",		"T,l",		0,    (int) M_LI_SS,	INSN_MACRO,	INSN2_M_FP_S,	I38,	0},
{"ll",		"",		"t,+m(b)",	0xa4005100, 0xfc007f03,	WR_1|RD_3,		0,	I38,	0},
{"ll",		"",		"t,A(c)",	0,    (int) M_LL_AB,	INSN_MACRO,		0,	I38,	0},
{"lld", 	"", 		"t,+q(b)",	0xa4007100, 0xfc007f07,	WR_1|RD_3,		0,	I70,	0},
{"lld", 	"",		"t,A(c)",	0,    (int) M_LLD_AB,	INSN_MACRO,		0,	I70,	0},
{"lldp",	"",		"t,mu,(b)",	0xa4007101, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	I70,	0},
{"lldp",	"",		"t,mu,A(c)",	0,     (int) M_LLDP_AB, INSN_MACRO,		0,	I70,	0},
{"lle", 	"", 		"t,+m(b)",	0xa4005200, 0xfc007f03,	WR_1|RD_3,		0,	0,	EVA},
{"lle", 	"", 		"t,A(c)",	0,     (int) M_LLE_AB,	INSN_MACRO,		0,	0,	EVA},
{"llwp",	"",		"t,mu,(b)",	0xa4005101, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	0,	xNMS},
{"llwp",	"",		"t,mu,A(c)",	0, 	(int) M_LLWP_AB, INSN_MACRO,		0,	0,	xNMS},
{"llwpe",	"",		"t,mu,(b)",	0xa4005201, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	0,	EVA},
{"llwpe",	"",		"t,mu,A(c)",	0, 	(int) M_LLWP_AB, INSN_MACRO,		0,	0,	EVA},
{"lsa",		"",		"d,v,t,+.",	0x2000000f, 0xfc0001ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lw",		"[16]",		"md,mJ(ml)",	0x1400,		0xfc00,	WR_1|RD_3,		0,	I38,	0}, /* LW[16] */
{"lw",		"[4x4]",	"+4,mN(+5)",	0x7400,		0xfc00,	WR_1|RD_3,		0,	0,	xNMS}, /* LW[4X4] */
{"lw",		"[sp]",		"mp,mU(ms)",	0x3400,		0xfc00,	WR_1|RD_3,		0,	I38,	0}, /* LW[SP] */
{"lw",		"[gp16]",	"md,m1(ma)",	0x5400,		0xfc00,	WR_1|RD_3,		0,	I38,	0}, /* LW[GP16] */
{"lw",		"[gp]",		"t,.(ma)",	0x40000002, 0xfc000003,	WR_1|RD_3,		0,	I38,	0}, /* LW[GP] */
{"lw",		"[gp16]",	"md,mA(ma)",	0x5400,		0xfc00,	WR_1|RD_3,		0,	I38,	0}, /* LW[GP16] */
{"lw",		"[u12]",	"t,o(b)",	0x84008000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LW[U12] */
{"lw",		"[s9]",		"t,+j(b)",	0xa4004000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LW[S9] */
{"lw",		"",		"t,A(c)",	0,    (int) M_LW_AB,	INSN_MACRO,		0,	I38,	0},
{"lwc1",	"[gp]",		"T,+2(ma)",	0x44180000, 0xfc1c0003,	WR_1|RD_3,		0,	I38,	0}, /* LWC1[GP] */
{"lwc1",	"[u12]", 	"T,o(b)",	0x8400a000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0}, /* LWC1[U12] */
{"lwc1",	"[s9]",		"T,+j(b)",	0xa4005000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0}, /* LWC1[S9] */
{"lwc1",	"",		"T,A(c)",	0,    (int) M_LWC1_AB,	INSN_MACRO,		0,	I38,	0},
{"lwc1",	"",		"E,A(c)",	0,    (int) M_LWC1_AB,	INSN_MACRO,		0,	I38,	0},
{"l.s", 	"[gp]", 	"T,+2(ma)",	0x44180000, 0xfc1c0003,	WR_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* LWC1[GP] */
{"l.s", 	"[u12]", 	"T,o(b)",	0x8400a000, 0xfc00f000,	WR_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* LWC1[U12] */
{"l.s", 	"[s9]", 	"T,+j(b)",	0xa4005000, 0xfc007f00,	WR_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* LWC1[S9] */
{"l.s", 	"", 		"T,A(c)",	0,    (int) M_LWC1_AB,	INSN_MACRO,	INSN2_M_FP_S,	I38,	0},
{"lwc1x",	"",		"R,s(t)",	0x20000507, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lwc1xs",	"",		"R,s(t)",	0x20000547, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lwc2",	"",		"E,+j(b)",	0xa4004100, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0},
{"lwc2",	"",		"E,A(c)",	0,    (int) M_LWC2_AB,	INSN_MACRO,		0,	I38,	0},
{"ldm", 	"",		"t,+j(b),|",	0xa4000600, 0xfc000f00,	WR_1|RD_3,		0,	0,	xNMS}, /* LDM */
{"lwe", 	"",		"t,+j(b)",	0xa4004200, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA},
{"lwe", 	"",		"t,A(c)",	0,     (int) M_LWE_AB,	INSN_MACRO,		0,	0,	EVA},
{"lwm", 	"",		"t,+j(b),|",	0xa4000400, 0xfc000f00,	WR_1|RD_3,		0,	0,	xNMS}, /* LWM */
{"lwpc",	"[48]",		"mp,+S",	0x600b,     0xfc1f,	WR_1,			0,	0,	xNMS}, /* LWPC[48] */
{"lwu", 	"[gp]",		"t,+2(ma)",	0x441c0000, 0xfc1c0003,	WR_1|RD_3,		0,	I70,	0}, /* LWU[GP] */
{"lwu", 	"[u12]",	 "t,o(b)",	0x84007000, 0xfc00f000,	WR_1|RD_3,		0,	I70,	0}, /* LWU[U12] */
{"lwu", 	"[s9]",		"t,+j(b)",	0xa4003800, 0xfc007f00,	WR_1|RD_3,		0,	I70,	0}, /* LWU[S9] */
{"lwu", 	"",		"t,A(c)",	0,    (int) M_LWU_AB,	INSN_MACRO,		0,	I70,	0},
{"lwux",	"",		"d,s(t)",	0x20000387, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"lwuxs",	"",		"d,s(t)",	0x200003c7, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,	0},
{"lwx", 	"",		"d,s(t)",	0x20000407, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lwxs",	"[16]",		"me,ml(md)",	0x5001,		0xfc01, WR_1|RD_2|RD_3,		0,	I38,	0}, /* LWXS[16] */
{"lwxs",	"[32]",		"d,s(t)",	0x20000447, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"lwxc1",	"",		"R,s(t)",	0x20000507, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* LWC1X */
{"madd",	"[dsp]",	"7,s,t",	0x20000abf, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32}, /* MADD[DSP] */
{"maddf.d",	"",		"D,S,T",	0xa00003b8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"maddf.s",	"",		"D,S,T",	0xa00001b8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"maddu",	"[dsp]",	"7,s,t",	0x20001abf, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32}, /* MADDU[DSP] */
{"maq_s.w.phl",	"", 		"7,s,t",	0x20001a7f, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32},
{"maq_s.w.phr",	"", 		"7,s,t",	0x20000a7f, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32},
{"maq_sa.w.phl", "", 	 	"7,s,t",	0x20003a7f, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32},
{"maq_sa.w.phr", "", 	 	"7,s,t",	0x20002a7f, 0xfc003fff, MOD_1|RD_2|RD_3,	0,	0,	D32},
{"max.d",	"",		"D,S,T",	0xa000020b, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"max.s",	"",		"D,S,T",	0xa000000b, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"maxa.d",	"",		"D,S,T",	0xa000022b, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"maxa.s",	"",		"D,S,T",	0xa000002b, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"mfc0",	"",		"t,O",		0x20000030, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	I38,	0}, /* MFC0 with named register */
{"mfc0",	"",		"t,P,J",	0x20000030, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	I38,	0}, /* MFC0 with named register & select */
{"mfc0",	"",		"t,G,J",	0x20000030, 0xfc0007ff,	WR_1,			0,	I38,	0},
{"mfc1",	"",		"t,S",		0xa000203b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"mfc1",	"",		"t,G",		0xa000203b, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0},
{"mfc2",	"",		"t,G",		0x20004d3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"mfgc0",	"",		"t,O",		0x200000b0, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT}, /* MFGC0 with named register */
{"mfgc0",	"",		"t,P,J",	0x200000b0, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT},  /* MFGC0 with named register & select */
{"mfgc0",	"",		"t,G,J",	0x200000b0, 0xfc0007ff,	WR_1,			0,	0,	IVIRT},
{"mfhc0",	"",		"t,O",		0x20000038, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	XPA}, /* MFHC0 with named register */
{"mfhc0",	"",		"t,P,J",	0x20000038, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	XPA}, /* MFHC0 with named register & select*/
{"mfhc0",	"",		"t,G,J",	0x20000038, 0xfc0007ff,	WR_1,			0,	0,	XPA},
{"mfhc1",	"",		"t,S",		0xa000303b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"mfhc1",	"",		"t,G",		0xa000303b, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0},
{"mfhc2",	"",		"t,G",		0x20008d3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"mfhgc0",	"",		"t,O",		0x200000b8, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT_XPA}, /* MFHGC0 with named register */
{"mfhgc0",	"",		"t,P,J",	0x200000b8, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	IVIRT_XPA}, /* MFHGC0 with named register & select*/
{"mfhgc0",	"",		"t,G,J",	0x200000b8, 0xfc0007ff,	WR_1,			0,	0,	IVIRT_XPA},
{"mfhi",	"[dsp]",	"t,7",		0x2000007f, 0xfc1f3fff,	WR_1|RD_2,		0,	0,	D32}, /* MFHI[DSP] */
{"mflo",	"[dsp]",	"t,7",		0x2000107f, 0xfc1f3fff,	WR_1|RD_2,		0,	0,	D32}, /* MFLO[DSP] */
{"mftc0",	"",		"t,O",		0x20000230, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR with named register */
{"mftc0",	"",	 	"t,P,J",	0x20000230, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR with named register & select */
{"mfthc0",	"",	 	"t,O",		0x20000238, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR with named register */
{"mfthc0",	"",		"t,P,J",	0x20000238, 0xfc0007ff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR with named register & select*/
{"mftc1",	"",		"t,S",		0x20001630, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftc1",	"",		"t,G",		0x20001630, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftc2",	"",		"t,G",		0x20002630, 0xfc00ffff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftdsp",	"",		"t",		0x20100e30, 0xfc1fffff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftgpr",	"",		"t,s",		0x20000630, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mfthc1",	"",		"t,S",		0x20001638, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mfthc1",	"",		"t,G",		0x20001638, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mfthc2",	"",		"t,G",		0x20002638, 0xfc00ffff,	WR_1,		INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mfthi",	"",		"t",		0x20010e30, 0xfc1fffff,	WR_1|RD_a,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mfthi",	"",		"t,*",		0x20010e30, 0xfc13ffff,	WR_1|RD_a,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftlo",	"",		"t",		0x20000e30, 0xfc1fffff,	WR_1|RD_a,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftlo",	"",		"t,*",		0x20000e30, 0xfc13ffff,	WR_1|RD_a,	INSN2_ALIAS,	0,	MT32}, /* MFTR */
{"mftr",	"",		"t,s,!,Q,$",	0x20000230, 0xfc0003f7,	WR_1,			0,	0,	MT32},
{"min.d",	"",		"D,S,T",	0xa0000203, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"min.s",	"",		"D,S,T",	0xa0000003, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"mina.d",	"",		"D,S,T",	0xa0000223, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"mina.s",	"",		"D,S,T",	0xa0000023, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"mod", 	"", 		"d,v,t",	0x20000158, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"mod", 	"",	 	"d,v,I",	0,    (int) M_MOD_I,	INSN_MACRO,		0,	I38,	0},
{"modsub",	"",	 	"d,s,t",	0x20000295, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"modu",	"",		"d,v,t",	0x200001d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"modu",	"",		"d,v,I",	0,    (int) M_MODU_I,	INSN_MACRO,		0,	I38,	0},
{"mov.d",	"",		"T,S",		0xa000207b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"mov.s",	"",		"T,S",		0xa000007b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"move.balc",	"",		"m4,+8,+r",	0x08000000, 0xfc000000,	WR_1|RD_2,		0,	0,	xNMS},
{"move.bal",	"",		"m4,+8,+r",	0x08000000, 0xfc000000,	WR_1|RD_2, 	INSN2_ALIAS|UBR|CTC, 0,	xNMS}, /* MOVE.BALC */
{"movep",	"",		"m5,+7,+6",	0xbc00,		0xfc00,	WR_1|RD_2|RD_3,		0,	0,	xNMS}, /* MOVEP */
{"movep",	"",		"m7,+6,+7",	0xbc00,		0xfc00,	WR_1|RD_2|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* MOVEP */
{"movep",	"[rev]",	"+5,+4,m5",	0xfc00,		0xfc00,	WR_1|WR_2|RD_3,		0,	0,	xNMS}, /* MOVEP[REV] */
{"movep",	"[rev]",	"+4,+5,m7",	0xfc00,		0xfc00,	WR_1|WR_2|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* MOVEP[REV] */
{"movn",	"",		"d,v,t",	0x20000610, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"movz",	"",		"d,v,t",	0x20000210, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"msub",	"[dsp]",	"7,s,t",	0x20002abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32}, /* MSUB[DSP] */
{"msubf.d",	"",		"D,S,T",	0xa00003f8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"msubf.s",	"",		"D,S,T",	0xa00001f8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"msubu",	"[dsp]",	"7,s,t",	0x20003abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32}, /* MSUBU[DSP] */
{"mtc0",	"",		"t,O",		0x20000070, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* MTC0 with named register */
{"mtc0",	"",		"t,P,J",	0x20000070, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	I38,	0}, /* MTCO with named register & select */
{"mtc0",	"",		"t,G,J",	0x20000070, 0xfc0007ff,	RD_1,			0,	I38,	0},
{"mtc1",	"",		"t,S",		0xa000283b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"mtc1",	"",		"t,G",		0xa000283b, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	I38,	0},
{"mtc2",	"",		"t,G",		0x20005d3f, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"mtgc0",	"",		"t,O",		0x200000f0, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT}, /* MTGC0 with named register */
{"mtgc0",	"",		"t,P,J",	0x200000f0, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT}, /* MTGC0 with named register & select */
{"mtgc0",	"",		"t,G,J",	0x200000f0, 0xfc0007ff,	RD_1,			0,	0,	IVIRT},
{"mthc0",	"",		"t,O",		0x20000078, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	XPA}, /* MTHC0 with named register */
{"mthc0",	"",		"t,P,J",	0x20000078, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	XPA}, /* MTHC0 with named register & select */
{"mthc0",	"",		"t,G,J",	0x20000078, 0xfc0007ff,	RD_1,			0,	0,	XPA},
{"mthc1",	"",		"t,S",		0xa000383b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"mthc1",	"",		"t,G",		0xa000383b, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	I38,	0},
{"mthc2",	"",		"t,G",		0x20009d3f, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0},
{"mthgc0",	"",		"t,O",		0x200000f8, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT_XPA}, /* MTHGC0 with named register */
{"mthgc0",	"",		"t,P,J",	0x200000f8, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	IVIRT_XPA}, /* MTHGC0 with named register & select */
{"mthgc0",	"",		"t,G,J",	0x200000f8, 0xfc0007ff,	RD_1,			0,	0,	IVIRT_XPA},
{"mthi",	"[dsp]",	"s,7",		0x2000207f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32}, /* MTHI[DSP] */
{"mthlip",	"",		"s,7",		0x2000027f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32},
{"mtlo",	"[dsp]",	"s,7",		0x2000307f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32}, /* MTLO[DSP] */
{"mttc0",	"",		"t,O",		0x20000270, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR with named register */
{"mttc0",	"",		"t,P,J",	0x20000270, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR with named register & select */
{"mtthc0",	"",		"t,O",		0x20000278, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR with named register*/
{"mtthc0",	"",		"t,P,J",	0x20000278, 0xfc0007ff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR with named register & select */
{"mttc1",	"",		"t,S",		0x20001670, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttc1",	"",		"t,G",		0x20001670, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttc2",	"",		"t,G",		0x20002670, 0xfc00ffff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttgpr",	"",		"s,t",		0x20000670, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mtthc1",	"",		"t,S",		0x20001678, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mtthc1",	"",		"t,G",		0x20001678, 0xfc00ffff,	RD_1|WR_2,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mtthc2",	"",		"t,G",		0x20002678, 0xfc00ffff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mtthi",	"",		"t",		0x20010e70, 0xfc1fffff,	RD_1|WR_a,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mtthi",	"",		"t,*",		0x20010e70, 0xfc13ffff,	RD_1|WR_a,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttlo",	"",		"t",		0x20000e70, 0xfc1fffff,	RD_1|WR_a,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttlo",	"",		"t,*",		0x20000e70, 0xfc13ffff,	RD_1|WR_a,	INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttdsp",	"",		"t",		0x20100e70, 0xfc1fffff,	RD_1,		INSN2_ALIAS,	0,	MT32}, /* MTTR */
{"mttr",	"",		"t,s,!,Q,$",	0x20000270, 0xfc0003f7,	RD_1,			0,	0,	MT32},
{"muh", 	"", 	 	"d,v,t",	0x20000058, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"muhu",	"",		"d,v,t",	0x200000d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"mul", 	"[4x4]",	"+4,mt,+5",	0x3c08,		0xfd08,	MOD_1|RD_3,		0,	0,	xNMS}, /* MUL[4X4] */
{"mul", 	"[4x4]",	"+4,+5,mx",	0x3c08,		0xfd08,	MOD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* MUL[4X4] */
{"mul", 	"[32]", 	"d,v,t",	0x20000018, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"mul", 	"",		"d,v,I",	0,    (int) M_MUL_I,	INSN_MACRO,		0,	I38,	0},
{"mul.d",	"",		"D,V,T",	0xa00001b0, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"mul.ph",	"",		"d,s,t",	0x2000002d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mul.s",	"",		"D,V,T",	0xa00000b0, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"muleq_s.w.phl", "", 		"d,s,t",	0x20000025, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"muleq_s.w.phr", "", 		"d,s,t",	0x20000065, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"muleu_s.ph.qbl", "", 		"d,s,t",	0x20000095, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"muleu_s.ph.qbr", "", 		"d,s,t",	0x200000d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulq_rs.ph",	"", 		"d,s,t",	0x20000115, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulq_rs.w",	"",		"d,s,t",	0x20000195, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulq_s.ph",	"",		"d,s,t",	0x20000155, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulq_s.w",	"",		"d,s,t",	0x200001d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulsa.w.ph",	"", 		"7,s,t",	0x20002cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mulsaq_s.w.ph", "", 		"7,s,t",	0x20003cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"mult",	"[dsp]",	"7,s,t",	0x20000cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32}, /* MULT[DSP] */
{"multu",	"[dsp]",	"7,s,t",	0x20001cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32}, /* MULTU[DSP] */
{"mulu",	"",		"d,v,t",	0x20000098, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"mul_s.ph",	"",		"d,s,t",	0x2000042d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"neg", 	"", 		"d,w",		0x20000190, 0xfc1f07ff, WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* SUB */
{"negu",	"",		"d,w",		0x200001d0, 0xfc1f07ff, WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* SUBU */
{"neg.d",	"",		"T,V",		0xa0002b7b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"neg.s",	"",		"T,V",		0xa0000b7b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"not", 	"[16]",		"md,ml",	0x5000,		0xfc0f,	WR_1|RD_2,		0,	I38,	0}, /* NOT[16] */
{"not", 	"[32]",		"d,v",		0x200002d0, 0xffe007ff, WR_1|RD_2, 	INSN2_ALIAS,	I38,	0}, /* NOR */
{"nor", 	"",		"d,v,t",	0x200002d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"nor", 	"",		"t,r,I",	0,    (int) M_NOR_I,	INSN_MACRO,		0,	I38,	0},
{"or",		"[16]",		"md,mx,ml",	0x500c,		0xfc0f,	WR_1|RD_3,	INSN2_ALIAS,	I38,	0}, /* OR[16] */
{"or",		"[16]",		"md,ml,mx",	0x500c,		0xfc0f,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* OR[16] */
{"or",		"[16]",		"md,ml",	0x500c,		0xfc0f,	WR_1|RD_2,		0,	I38,	0}, /* OR[16] */
{"or",		"[32]",		"d,v,t",	0x20000290, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"or",		"",		"t,r,I",	0,    (int) M_OR_I,	INSN_MACRO,		0,	I38,	0},
{"ori", 	"", 		"t,r,g",	0x80000000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0},
{"pause",	"",		"",		0x8000c005, 0xffffffff,	0,			0,	I38,	0},
{"packrl.ph",	"",		"d,s,t",	0x200001ad, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"pick.ph",	"",		"d,s,t",	0x2000022d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"pick.qb",	"",		"d,s,t",	0x200001ed, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"preceq.w.phl", "", 		"t,s",		0x2000513f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"preceq.w.phr", "", 		"t,s",		0x2000613f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"precequ.ph.qbl", "", 		"t,s",		0x2000713f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"precequ.ph.qbla", "", 	"t,s",		0x2000733f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"precequ.ph.qbr", "", 		"t,s",		0x2000913f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"precequ.ph.qbra", "", 	"t,s",		0x2000933f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"preceu.ph.qbl", "", 		"t,s",		0x2000b13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"preceu.ph.qbla", "", 		"t,s",		0x2000b33f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"preceu.ph.qbr", "", 		"t,s",		0x2000d13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"preceu.ph.qbra", "", 		"t,s",		0x2000d33f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"precr.qb.ph",	"", 		"d,s,t",	0x2000006d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"precrq.ph.w",	"", 		"d,s,t",	0x200000ed, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"precrq.qb.ph", "", 		"d,s,t",	0x200000ad, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"precrqu_s.qb.ph", "", 	"d,s,t",	0x2000016d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"precrq_rs.ph.w", "", 		"d,s,t",	0x2000012d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"precr_sra.ph.w", "",		"t,s,+i",	0x200003cd, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32},
{"precr_sra_r.ph.w", "", 	"t,s,+i",	0x200007cd, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32},
{"pref",	"[u12]",	"k,o(b)",	0x84003000, 0xfc00f000,	RD_3,			0,	I38,	0}, /* PREF[U12] */
{"pref",	"[s9]",		"k,+j(b)",	0xa4001800, 0xfc007f00,	RD_3,			0,	I38,	0}, /* PREF[S9], preceded by SYNCI[S9] */
{"pref",	"",		"k,A(c)",	0,    (int) M_PREF_AB,	INSN_MACRO,		0,	I38,	0},
{"prefe",	"",		"k,+j(b)",	0xa4001a00, 0xfc007f00,	RD_3,			0,	0,	EVA}, /* preceded by SYNCIE */
{"prefe",	"",		"k,A(c)",	0,    (int) M_PREFE_AB,	INSN_MACRO,		0,	0,	EVA},
{"prepend",	"",		"d,-n,t,+I",	0x2000001f, 0xfc00003f, WR_1|RD_3,	INSN2_ALIAS,	0,	D32}, /* EXTW */
{"raddu.w.qb",	"", 		"t,s",		0x2000f13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"rddsp",	"",		"t",		0x201fc67f, 0xfc1fffff,	WR_1,		INSN2_ALIAS,	0,	D32},
{"rddsp",	"",		"t,8",		0x2000067f, 0xfc003fff,	WR_1,			0,	0,	D32},
{"rdhwr",	"",		"t,K",		0x200001c0, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* RDHWR with sel=0 */
{"rdhwr",	"",		"t,K,H",	0x200001c0, 0xfc00c7ff,	WR_1|RD_2,		0,	I38,	0},
{"rdpgpr",	"",		"t,s",		0x2000e17f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"recip.d",	"",		"T,S",		0xa000523b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"recip.s",	"",		"T,S",		0xa000123b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"rem", 	"", 		"d,v,t",	0x20000158, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* MOD */
{"rem", 	"", 		"d,v,I",	0,    (int) M_REM_3I,	INSN_MACRO,		0,	I38,	0},
{"remu",	"",		"d,v,t",	0x200001d8, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* MODU */
{"repl.ph",	"",		"t,@",		0x2000003d, 0xfc0007ff,	WR_1,			0,	0,	D32},
{"repl.qb",	"",		"t,5",		0x200005ff, 0xfc001fff,	WR_1,			0,	0,	D32},
{"replv.ph",	"",		"t,s",		0x2000033f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"replv.qb",	"",		"t,s",		0x2000133f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32},
{"restore",	"[32]",		"mY,n",		0x80003002, 0xfc00f003,	0,			0,	I38,	0},
{"restore.jrc",	"[16]", 	"mG",		0x1d00,		0xff0f,	0,			0,	I38,	0}, /* RESTORE.JRC[16] */
{"restore.jrc",	"[16]", 	"mG,+N",	0x1d00,		0xfd00,	0,			0,	I38,	0}, /* RESTORE.JRC[16], preceded by RESTORE[16] */
{"restore.jrc",	"[32]",		"mY",		0x80003003, 0xfffff007,	0,     			0,	I38,	0}, /* RESTORE.JRC[32] */
{"restore.jrc",	"[32]", 	"mY,n",		0x80003003, 0xfc00f003,	0,			0,	I38,	0},
{"jraddiusp",	"",		"mG",		0x1d00,		0xff0f,	0,		INSN2_ALIAS,	I38,	0}, /* RESTORE.JRC[16] */
{"jraddiusp",	"",		"mY",		0x80003003, 0xfffff007,	0,		INSN2_ALIAS,	I38,	0}, /* RESTORE.JRC[32] */
{"jraddiusp",	"",		"I",		0,   (int) M_JRADDIUSP,	INSN_MACRO,		0,	I38,	0},
{"restoref",	"",		"mY,+P",	0x80103001, 0xfff0f007,	FP_S,			0,	I38,	0},
{"rint.d",	"",		"T,S",		0xa0000220, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"rint.s",	"",		"T,S",		0xa0000020, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"rol", 	"", 		"d,v,t",	0,    (int) M_ROL,	INSN_MACRO,		0,	I38,	0},
{"rol", 	"", 		"d,v,I",	0,    (int) M_ROL_I,	INSN_MACRO,		0,	I38,	0},
{"rotrv",	"",		"d,s,t",	0x200000d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"rotr",	"",		"t,r,<",	0x8000c0c0, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,	0},
{"rotr",	"",		"d,v,t",	0x200000d0, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* ROTRV */
{"ror", 	"",		"t,r,<",	0x8000c0c0, 0xfc00ffe0,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* ROTR */
{"ror", 	"",		"d,v,t",	0x200000d0, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* ROTRV */
{"ror", 	"", 		"d,v,I",	0,    (int) M_ROR_I,	INSN_MACRO,		0,	I38,	0},
{"rorv",	"",		"t,r,<",	0x8000c0c0, 0xfc00ffe0,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* ROTR */
{"rorv",	"",		"d,v,t",	0x200000d0, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* ROTRV */
{"rotl",	"",		"d,v,t",	0,    (int) M_ROL,	INSN_MACRO,		0,	I38,	0},
{"rotl",	"",		"d,v,I",	0,    (int) M_ROL_I,	INSN_MACRO,		0,	I38,	0},
{"wsbh",	"",		"t,r",		0x8000d608, 0xfc00ffff,	WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* ROTX t,s,8,24*/
{"rotx",	"",		"t,r,<,+*",	0x8000d000, 0xfc00f860, WR_1|RD_2,	INSN2_ALIAS,	0,	xNMS},
{"rotx",	"",		"t,r,<,+*,+|",	0x8000d000, 0xfc00f820, WR_1|RD_2,		0,	0,	xNMS},
{"round.l.d",	"",		"T,S",		0xa000733b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"round.l.s",	"",		"T,S",		0xa000333b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"round.w.d",	"",		"T,S",		0xa0007b3b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"round.w.s",	"",		"T,S",		0xa0003b3b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"rsqrt.d",	"",		"T,S",		0xa000423b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"rsqrt.s",	"",		"T,S",		0xa000023b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"savef",	"",		"mY,+P",	0x80103000, 0xfff0f007,	    	FP_S,		0,	I38,	0}, /* precedes SAVE */
{"save",	"[16]",		"mG",		0x1c00,		0xff0f,		0,		0,	I38,	0}, /* SAVE[16] */
{"save",	"[16]",		"mG,+N",	0x1c00,		0xfd00,		0,		0,	I38,	0}, /* SAVE[16] */
{"save",	"[32]",		"mY,n",		0x80003000, 0xfc00f003,		0,		0,	I38,	0},
{"sb",		"[16]",		"mq,mL(ml)",	0x5c04,		0xfc0c,	RD_1|RD_3,		0,	I38,	0}, /* SB[16] */
{"sb",		"[gp]",		"t,+1(ma)",	0x44040000, 0xfc1c0000,	RD_1|RD_3,		0,	I38,	0}, /* SB[GP] */
{"sb",		"[u12]",	"t,o(b)",	0x84001000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0}, /* SB[U12] */
{"sb",		"[s9]",		"t,+j(b)",	0xa4000800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0}, /* SB[S9] */
{"sb",		"",		"t,A(c)",	0,    (int) M_SB_AB,	INSN_MACRO,		0,	I38,	0},
{"sbe", 	"", 		"t,+j(b)",	0xa4000a00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA},
{"sbe", 	"", 		"t,A(c)",	0,     (int) M_SBE_AB,	INSN_MACRO,		0,	0,	EVA},
{"sbx", 	"",		"d,s(t)",	0x20000087, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	xNMS},
{"sc",		"",		"t,+m(b)",	0xa4005900, 0xfc007f03,	MOD_1|RD_3,		0,	I38,	0},
{"sc",		"",		"t,A(c)",	0,    (int) M_SC_AB,	INSN_MACRO,		0,	I38,	0},
{"scd", 	"", 		"t,+q(b)",	0xa4007900, 0xfc007f07,	MOD_1|RD_3,		0,	I70,	0},
{"scd", 	"",		"t,A(c)",	0,    (int) M_SCD_AB,	INSN_MACRO,		0,	I70,	0},
{"scdp",	"",		"t,mu,(b)",	0xa4007901, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	I70,	0},
{"scdp",	"",		"t,mu,A(c)",	0,     (int) M_SCDP_AB, INSN_MACRO,		0,	I70,	0},
{"sce", 	"", 		"t,+m(b)",	0xa4005a00, 0xfc007f03,	MOD_1|RD_3,		0,	0,	EVA},
{"sce", 	"", 		"t,A(c)",	0,     (int) M_SCE_AB,	INSN_MACRO,		0,	0,	EVA},
{"scwp",	"",		"t,mu,(b)",	0xa4005901, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	0,	xNMS},
{"scwp",	"",		"t,mu,A(c)",	0, 	(int) M_SCWP_AB, INSN_MACRO,		0,	0,	xNMS},
{"scwpe",	"",		"t,mu,(b)",	0xa4005a01, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	0,	EVA},
{"scwpe",	"",		"t,mu,A(c)",	0, 	(int) M_SCWP_AB, INSN_MACRO,		0,	0,	EVA},
{"sd",		"[gp]",		"t,mV(ma)",	0x40000005, 0xfc000007,	RD_1|RD_3,		0,	I70,	0}, /* SD[GP] */
{"sd",		"[u12]",	"t,o(b)",	0x8400d000, 0xfc00f000,	RD_1|RD_3,		0,	I70,	0}, /* SD[U12] */
{"sd",		"[s9]",		"t,+j(b)",	0xa4006800, 0xfc007f00,	RD_1|RD_3,		0,	I70,	0}, /* SD[S9] */
{"sd",		"",		"t,A(b)",	0,    (int) M_SD_AB,	INSN_MACRO,		0,	I38,	0},
{"sdc1",	"[gp]",		"T,+2(ma)",	0x44180003, 0xfc1c0003,	RD_1|RD_3|FP_D,		0,	I38,	0}, /* SDC1[GP] */
{"sdc1",	"[u12]",	"T,o(b)",	0x8400f000, 0xfc00f000,	RD_1|RD_3|FP_D,		0,	I38,	0}, /* SDC1[U12] */
{"sdc1",	"[s9]",		"T,+j(b)",	0xa4007800, 0xfc007f00,	RD_1|RD_3|FP_D,		0,	I38,	0}, /* SDC1[S9] */
{"sdc1",	"",		"T,A(c)",	0,    (int) M_SDC1_AB,	INSN_MACRO,		0,	I38,	0},
{"sdc1",	"",		"E,A(c)",	0,    (int) M_SDC1_AB,	INSN_MACRO,		0,	I38,	0},
{"s.d", 	"[gp]", 	"T,+2(ma)",	0x44180003, 0xfc1c0003,	RD_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* SDC1[GP] */
{"s.d", 	"[u12]", 	"T,o(b)",	0x8400f000, 0xfc00f000,	RD_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* SDC1[U12] */
{"s.d", 	"[s9]", 	"T,+j(b)",	0xa4007800, 0xfc007f00,	RD_1|RD_3|FP_D,	INSN2_ALIAS,	I38,	0}, /* SDC1[S9] */
{"s.d", 	"", 		"T,A(c)",	0,    (int) M_SDC1_AB,	INSN_MACRO,	INSN2_M_FP_D,	I38,	0},
{"sdc1x",	"",		"R,s(t)",	0x20000787, 0xfc0007ff, RD_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"sdc1xs",	"",		"R,s(t)",	0x200007c7, 0xfc0007ff, RD_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"sdc2",	"",		"E,+j(b)",	0xa4006900, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0},
{"sdc2",	"",		"E,A(c)",	0,    (int) M_SDC2_AB,	INSN_MACRO,		0,	I38,	0},
{"sdpc",	"",		"mp,+S",	0x601f,     0xfc1f,	WR_1,			0,	0,	xNMS}, /* LDPC[48] */
{"sdx", 	"",		"d,s,t",	0x20000687, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I70,	0},
{"sdxs",	"",		"d,s,t",	0x200006c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I70,	0},
{"sdxc1",	"",		"R,s(t)",	0x20000787, 0xfc0007ff, RD_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* SDC1X */
{"seb", 	"", 		"t,r",		0x20000008, 0xfc00ffff,	WR_1|RD_2,		0,	0,	xNMS},
{"seh", 	"", 		"t,r",		0x20000048, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"sel.d",	"",		"D,S,T",	0xa00002b8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"sel.s",	"",		"D,S,T",	0xa00000b8, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"seleqz.d",	"",		"D,S,T",	0xa0000238, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"seleqz.s",	"",		"D,S,T",	0xa0000038, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"selnez.d",	"",		"D,S,T",	0xa0000278, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"selnez.s",	"",		"D,S,T",	0xa0000078, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"seqi",	"",		"t,r,i",	0x80006000, 0xfc00f000, WR_1|RD_2,		0,	I38,	0},
{"seq", 	"", 		"d,v,t",	0,    (int) M_SEQ,	INSN_MACRO,		0,	I38,	0},
{"seq", 	"", 		"d,v,I",	0,    (int) M_SEQ_I,	INSN_MACRO,		0,	I38,	0},
{"sge", 	"", 		"d,v,t",	0,    (int) M_SGE,	INSN_MACRO,		0,	I38,	0},
{"sge", 	"", 		"d,v,I",	0,    (int) M_SGE_I,	INSN_MACRO,		0,	I38,	0},
{"sgeu",	"",		"d,v,t",	0,    (int) M_SGEU,	INSN_MACRO,		0,	I38,	0},
{"sgeu",	"",		"d,v,I",	0,    (int) M_SGEU_I,	INSN_MACRO,		0,	I38,	0},
{"sgt", 	"", 		"d,v,t",	0,    (int) M_SGT,	INSN_MACRO,		0,	I38,	0},
{"sgt", 	"", 		"d,v,I",	0,    (int) M_SGT_I,	INSN_MACRO,		0,	I38,	0},
{"sgtu",	"",		"d,v,t",	0,    (int) M_SGTU,	INSN_MACRO,		0,	I38,	0},
{"sgtu",	"",		"d,v,I",	0,    (int) M_SGTU_I,	INSN_MACRO,		0,	I38,	0},
{"sh",		"[16]",		"mq,mH(ml)",	0x7c01,		0xfc09,	RD_1|RD_3,		0,	I38,	0}, /* SH[16] */
{"sh",		"[gp]",		"t,+3(ma)",	0x44140000, 0xfc1c0001,	RD_1|RD_3,		0,	I38,	0}, /* SH[GP] */
{"sh",		"[u12]",	 "t,o(b)",	0x84005000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0}, /* SH[U12] */
{"sh",		"[s9]",		"t,+j(b)",	0xa4002800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0}, /* SH[S9] */
{"sh",		"",		"t,A(c)",		0,    (int) M_SH_AB,	INSN_MACRO,	0,	I38,	0},
{"she", 	"", 		"t,+j(b)",	0xa4002a00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA},
{"she", 	"", 		"t,A(c)",	0,     (int) M_SHE_AB,	INSN_MACRO,		0,	0,	EVA},
{"shilo",	"",		"7,0",		0x2000001d, 0xffc03fff,		MOD_1,		0,	0,	D32},
{"shilov",	"",		"7,s",		0x2000127f, 0xffe03fff,	MOD_1|RD_2,		0,	0,	D32},
{"shll.ph",	"",		"t,s,4",	0x200003b5, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32},
{"shll.qb",	"",		"t,s,3",	0x2000087f, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32},
{"shllv.ph",	"",		"d,t,s",	0x2000038d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shllv.qb",	"",		"d,t,s",	0x20000395, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shllv_s.ph",	"",		"d,t,s",	0x2000078d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shllv_s.w",	"",		"d,t,s",	0x200003d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shll_s.ph",	"",		"t,s,4",	0x20000bb5, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32},
{"shll_s.w",	"",		"t,s,+i",	0x200003f5, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32},
{"shra.ph",	"",		"t,s,4",	0x20000335, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32},
{"shra.qb",	"",		"t,s,3",	0x200001ff, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32},
{"shrav.ph",	"",		"d,t,s",	0x2000018d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shrav.qb",	"",		"d,t,s",	0x200001cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shrav_r.ph",	"",		"d,t,s",	0x2000058d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shrav_r.qb",	"",		"d,t,s",	0x200005cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shrav_r.w",	"",		"d,t,s",	0x200002d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shra_r.ph",	"",		"t,s,4",	0x20000735, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32},
{"shra_r.qb",	"",		"t,s,3",	0x200011ff, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32},
{"shra_r.w",	"",		"t,s,+i",	0x200002f5, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32},
{"shrl.ph",	"",		"t,s,4",	0x200003ff, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32},
{"shrl.qb",	"",		"t,s,3",	0x2000187f, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32},
{"shrlv.ph",	"",		"d,t,s",	0x20000315, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shrlv.qb",	"",		"d,t,s",	0x20000355, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"shx", 	"",		"d,s(t)",	0x20000287, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	xNMS},
{"shxs",	"",		"d,s(t)",	0x200002c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	xNMS},
{"sync",	"",		"",		0x8000c006, 0xffffffff,		0,		0,	I38,	0},
{"sync",	"",		"1",		0x8000c006, 0xffe0ffff,		0,		0,	I38,	0},
{"sle", 	"", 		"d,v,t",	0,    (int) M_SLE,	INSN_MACRO,		0,	I38,	0},
{"sle", 	"", 		"d,v,I",	0,    (int) M_SLE_I,	INSN_MACRO,		0,	I38,	0},
{"sleu",	"",		"d,v,t",	0,    (int) M_SLEU,	INSN_MACRO,		0,	I38,	0},
{"sleu",	"",		"d,v,I",	0,    (int) M_SLEU_I,	INSN_MACRO,		0,	I38,	0},
{"sllv",	"",		"d,s,t",	0x20000010, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"sll", 	"[16]",		"md,mc,mM",	0x3000,		0xfc08,	WR_1|RD_2,		0,	I38,	0}, /* SLL[16] */
{"sll", 	"[32]", 	"t,r,<",	0x8000c000, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,	0}, /* preceded by EHB, PAUSE, SYNC */
{"sll",		"[32]",		"d,v,t",	0x20000010, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* SLLV */
{"slt", 	"", 		"d,v,t",	0x20000350, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"slt", 	"", 		"d,v,I",	0,    (int) M_SLT_I,	INSN_MACRO,		0,	I38,	0},
{"slti",	"",		"t,r,i",	0x80004000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0},
{"sltiu",	"",		"t,r,i",	0x80005000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0},
{"sltu",	"",		"d,v,t",	0x20000390, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0}, /* preceded by DVP */
{"sltu",	"",		"d,v,I",	0,    (int) M_SLTU_I,	INSN_MACRO,		0,	I38,	0},
{"sne", 	"", 		"d,v,t",	0,    (int) M_SNE,	INSN_MACRO,		0,	I38,	0},
{"sne", 	"", 		"d,v,I",	0,    (int) M_SNE_I,	INSN_MACRO,		0,	I38,	0},
{"sov", 	"", 		"d,v,t",	0x200003d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"special2",	"",		"m8",		0x20000001, 0xfc000007,		0,		0,	0,	UDI},
{"sqrt.d",	"",		"T,S",		0xa0004a3b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"sqrt.s",	"",		"T,S",		0xa0000a3b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"srav",	"",		"d,s,t",	0x20000090, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"sra", 	"",		"t,r,<",	0x8000c080, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,	0},
{"sra", 	"",		"d,v,t",	0x20000090, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* SRAV */
{"srlv",	"",		"d,s,t",	0x20000050, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"srl", 	"[16]",		"md,mc,mM",	0x3008,		0xfc08,	WR_1|RD_2,		0,	I38,	0}, /* SRL[16] */
{"srl", 	"[32]",		"t,r,<",	0x8000c040, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,	0},
{"srl", 	"[32]",		"d,v,t",	0x20000050, 0xfc0007ff, WR_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* SRLV */
{"sub", 	"", 		"d,v,t",	0x20000190, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	xNMS},
{"sub", 	"", 		"t,r,I",	0,    (int) M_SUB_I,	INSN_MACRO,		0,	0,	xNMS},
{"sub.d",	"",		"D,V,T",	0xa0000170, 0xfc0007ff, WR_1|RD_2|RD_3|FP_D,	0,	I38,	0},
{"sub.s",	"",		"D,V,T",	0xa0000070, 0xfc0007ff, WR_1|RD_2|RD_3|FP_S,	0,	I38,	0},
{"subq.ph",	"",		"d,s,t",	0x2000020d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subqh.ph",	"",		"d,s,t",	0x2000024d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subqh.w",	"",		"d,s,t",	0x2000028d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subqh_r.ph",	"", 		"d,s,t",	0x2000064d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subqh_r.w",	"",		"d,s,t",	0x2000068d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subq_s.ph",	"",		"d,s,t",	0x2000060d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subq_s.w",	"",		"d,s,t",	0x20000345, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subu",	"[16]",		"me,mc,md",	0xb001,		0xfc01, WR_1|RD_2|RD_3,		0,	I38,	0}, /* SUBU[16] */
{"subu",	"[32]",		"d,v,t",	0x200001d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"subu",	"",		"d,v,I",	0,    (int) M_SUBU_I,	INSN_MACRO,		0,	I38,	0},
{"subu.ph",	"",		"d,s,t",	0x2000030d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subu.qb",	"",		"d,s,t",	0x200002cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subuh.qb",	"",		"d,s,t",	0x2000034d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subuh_r.qb",	"", 		"d,s,t",	0x2000074d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subu_s.ph",	"",		"d,s,t",	0x2000070d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"subu_s.qb",	"",		"d,s,t",	0x200006cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32},
{"sw",		"[16]",		"mq,mJ(ml)",	0x9400,		0xfc00,	RD_1|RD_3,		0,	I38,	0}, /* SW[16] */
{"sw",		"[sp]",		"mp,mU(ms)",	0xb400,		0xfc00,	RD_1|RD_3,		0,	I38,	0}, /* SW[SP] */
{"sw",		"[4x4]",	"+6,mN(+5)",	0xf400,		0xfc00,	RD_1|RD_3,		0,	0,	xNMS}, /* SW[4X4] */
{"sw",		"[gp16]",	"mq,m1(ma)",	0xd400,		0xfc00,	RD_1|RD_3,		0,	I38,	0}, /* SW[GP16] */
{"sw",		"[gp]",		"t,.(ma)",	0x40000003, 0xfc000003,	RD_1|RD_3,		0,	I38,	0}, /* SW[GP] */
{"sw",		"[gp16]",	"mq,mA(ma)",	0xd400,		0xfc00,	RD_1|RD_3,		0,	I38,	0}, /* SW[GP16] */
{"sw",		"[u12]",	"t,o(b)",	0x84009000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0}, /* SW[U12] */
{"sw",		"[s9]",		"t,+j(b)",	0xa4004800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0}, /* SW[S9] */
{"sw",		"",		"t,A(c)",	0,    (int) M_SW_AB,	INSN_MACRO,		0,	I38,	0},
{"swc1",	"[gp]",		"T,+2(ma)",	0x44180001, 0xfc1c0003,	RD_1|RD_3,		0,	I38,	0}, /* SWC1[GP] */
{"swc1",	"[u21]",	"T,o(b)",	0x8400b000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0}, /* SWC1[U12] */
{"swc1",	"[s9]",		"T,+j(b)",	0xa4005800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0}, /* SWC1[S9] */
{"swc1",	"",		"T,A(c)",	0,    (int) M_SWC1_AB,	INSN_MACRO,		0,	I38,	0},
{"swc1",	"",		"E,A(c)",	0,    (int) M_SWC1_AB,	INSN_MACRO,		0,	I38,	0},
{"s.s", 	"[gp]",         "T,+2(ma)",	0x44180001, 0xfc1c0003,	RD_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* SWC1[GP] */
{"s.s", 	"[u12]", 	"T,o(b)",	0x8400b000, 0xfc00f000,	RD_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* SWC1[U12]  */
{"s.s", 	"[s9]", 	"T,+j(b)",	0xa4005800, 0xfc007f00,	RD_1|RD_3|FP_S,	INSN2_ALIAS,	I38,	0}, /* SWC1[S9] */
{"s.s", 	"", 		"T,A(c)",	0,    (int) M_SWC1_AB,	INSN_MACRO,	INSN2_M_FP_S,	I38,	0},
{"swc1x",	"",		"R,s(t)",	0x20000587, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0},
{"swc1xs",	"",		"R,s(t)",	0x200005c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0},
{"swc2",	"",		"E,+j(b)",	0xa4004900, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0},
{"swc2",	"",		"E,A(c)",	0,    (int) M_SWC2_AB,	INSN_MACRO,		0,	I38,	0},
{"sdm", 	"",		"t,+j(b),|",	0xa4000e00, 0xfc000f00,	RD_1|RD_3,		0,	0,	xNMS}, /* SDM */
{"swe", 	"",		"t,+j(b)",	0xa4004a00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA},
{"swe", 	"", 		"t,A(c)",	0,    (int) M_SWE_AB,	INSN_MACRO,		0,	0,	EVA},
{"swm", 	"", 		"t,+j(b),|",	0xa4000c00, 0xfc000f00,	RD_1|RD_3,		0,	0,	xNMS}, /* SWM */
{"swpc",	"[48]",		"mp,+S",	0x600f,     0xfc1f,	WR_1,			0,	0,	xNMS}, /* LWPC[48] */
{"swx", 	"",		"d,s(t)",	0x20000487, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	xNMS},
{"swxs",	"",		"d,s(t)",	0x200004c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	xNMS},
{"swxc1",	"",		"R,s(t)",	0x20000587, 0xfc0007ff, RD_1|RD_2|RD_3,	INSN2_ALIAS,	I38,	0}, /* SWC1X */
{"syscall",	"[16]",		"",		0x1008,     0xffff,		0,	INSN2_ALIAS,	I38,	0}, /* SYSCALL[16] */
{"syscall",	"[16]",		"+o",		0x1008,     0xfffc,		0,		0,	I38,	0}, /* SYSCALL[16] */
{"syscall",	"[32]",		"",		0x00080000, 0xffffffff,		0,	INSN2_ALIAS,	I38,	0},
{"syscall",	"[32]",		"+M",		0x00080000, 0xfffc0000,		0,		0,	I38,	0},
{"teq", 	"", 		"s,t",		0x20000000, 0xfc00ffff,	RD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* TEQ */
{"teq", 	"", 		"s,t,^",	0x20000000, 0xfc0007ff,	RD_1|RD_2,		0,	0,	xNMS}, /* TEQ */
{"teq", 	"", 		"s,I",		0, 	 (int) M_TEQ_I,	INSN_MACRO,		0,	0,	xNMS},
{"tne", 	"", 		"s,t",		0x20000400, 0xfc00ffff,	RD_1|RD_2,	INSN2_ALIAS,	0,	xNMS}, /* TNE */
{"tne", 	"", 		"s,t,^",	0x20000400, 0xfc0007ff,	RD_1|RD_2,		0,	0,	xNMS}, /* TNE */
{"tne", 	"", 		"s,I",		0, 	 (int) M_TNE_I,	INSN_MACRO,		0,	0,	xNMS},
{"tlbginv",	"",		"",		0x2000057f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbginvf",	"",		"",		0x2000157f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbgp",	"",		"",		0x2000017f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbgr",	"",		"",		0x2000117f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbgwi",	"",		"",		0x2000217f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbgwr",	"",		"",		0x2000317f, 0xffffffff,		0,		0,	0,	IVIRT|TLB},
{"tlbinv",	"",		"",		0x2000077f, 0xffffffff,		0,		0,	0,	TLB},
{"tlbinvf",	"",		"",		0x2000177f, 0xffffffff,		0,		0,	0,	TLB},
{"tlbp",	"",		"",		0x2000037f, 0xffffffff,		0,		0,	0,	TLB},
{"tlbr",	"",		"",		0x2000137f, 0xffffffff,		0,		0,	0,	TLB},
{"tlbwi",	"",		"",		0x2000237f, 0xffffffff,		0,		0,	0,	TLB},
{"tlbwr",	"",		"",		0x2000337f, 0xffffffff,		0,		0,	0,	TLB},
{"trunc.l.d",	"",		"T,S",		0xa000633b, 0xfc00ffff,	WR_1|RD_2|FP_D,		0,	I38,	0},
{"trunc.l.s",	"",		"T,S",		0xa000233b, 0xfc00ffff,	WR_1|RD_2|FP_D|FP_S,	0,	I38,	0},
{"trunc.w.d",	"",		"T,S",		0xa0006b3b, 0xfc00ffff,	WR_1|RD_2|FP_D|FP_S,	0,	I38,	0},
{"trunc.w.s",	"",		"T,S",		0xa0002b3b, 0xfc00ffff,	WR_1|RD_2|FP_S,		0,	I38,	0},
{"ualh",	"",		"t,+j(b)",	0xa4002100, 0xfc007f00,	WR_1|RD_3,		0,	0,	xNMS},
{"ualwm",	"",		"t,+j(b),|",	0xa4000500, 0xfc000f00,	WR_1|RD_3,		0,	0,	xNMS}, /* UALWM */
{"ualw",	"",		"t,+j(b)",	0xa4001500, 0xfc007f00,	WR_1|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* UALWM */
{"ualdm",	"",		"t,+j(b),|",	0xa4000700, 0xfc000f00,	WR_1|RD_3,		0,	0,	xNMS}, /* UALDM */
{"uald",	"",		"t,+j(b)",	0xa4001700, 0xfc007f00,	WR_1|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* UALDM */
{"uash",	"",		"t,+j(b)",	0xa4002900, 0xfc007f00,	RD_1|RD_3,		0,	0,	xNMS},
{"uaswm",	"",		"t,+j(b),|",	0xa4000d00, 0xfc000f00,	RD_1|RD_3,		0,	0,	xNMS}, /* UASWM */
{"uasw",	"",		"t,+j(b)",	0xa4001d00, 0xfc007f00,	RD_1|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* UASWM */
{"uasdm",	"",		"t,+j(b),|",	0xa4000f00, 0xfc000f00,	RD_1|RD_3,		0,	0,	xNMS}, /* UASDM */
{"uasd",	"",		"t,+j(b)",	0xa4001f00, 0xfc007f00,	RD_1|RD_3,	INSN2_ALIAS,	0,	xNMS}, /* UASDM */
{"uld", 	"",		"t,A(c)",	0,    (int) M_ULD_AB,	INSN_MACRO,		0,	I38,	0},
{"ulh", 	"",		"t,A(c)",	0,    (int) M_ULH_AB,	INSN_MACRO,		0,	I38,	0},
{"ulhu",	"",		"t,A(c)",	0,    (int) M_ULHU_AB,	INSN_MACRO,		0,	I38,	0},
{"ulw", 	"",		"t,A(c)",	0,    (int) M_ULW_AB,	INSN_MACRO,		0,	I38,	0},
{"usd",		"",		"t,A(c)",	0,    (int) M_USD_AB,	INSN_MACRO,		0,	I38,	0},
{"ush", 	"",		"t,A(c)",	0,    (int) M_USH_AB,	INSN_MACRO,		0,	I38,	0},
{"usw", 	"",		"t,A(c)",	0,    (int) M_USW_AB,	INSN_MACRO,		0,	I38,	0},
{"udi", 	"",		"m8",		0x20000003, 0xfc000007,		0,		0,	0,	UDI},
{"wait",	"",		"",		0x2000c37f, 0xffffffff,		0,	INSN2_ALIAS,	I38,	0},
{"wait",	"",		"+L",		0x2000c37f, 0xfc00ffff,		0,		0,	I38,	0},
{"wrdsp",	"",		"t",		0x201fd67f, 0xfc1fffff,	RD_1,		INSN2_ALIAS,	0,	D32},
{"wrdsp",	"",		"t,8",		0x2000167f, 0xfc003fff,	RD_1,			0,	0,	D32},
{"wrpgpr",	"",		"t,r",		0x2000f17f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0},
{"xor", 	"[16]",		"md,mx,ml",	0x5004,		0xfc0f,	WR_1|RD_3,	INSN2_ALIAS,	I38,	0}, /* XOR[16] */
{"xor", 	"[16]",		"md,ml,mx",	0x5004,		0xfc0f,	WR_1|RD_2,	INSN2_ALIAS,	I38,	0}, /* XOR[16] */
{"xor", 	"[16]",		"md,ml",	0x5004,		0xfc0f,	WR_1|RD_2,		0,	I38,	0}, /* XOR[16] */
{"xor", 	"[32]",		"d,v,t",	0x20000310, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0},
{"xor", 	"",		"t,r,I",	0,    (int) M_XOR_I,	INSN_MACRO,		0,	I38,	0},
{"xori",	"",		"t,r,g",	0x80001000, 0xfc00f000,	WR_1|RD_2,		0,	I38,	0},
{"yield",	"",		"s",		0x20000268, 0xffe0ffff,	RD_1,		INSN2_ALIAS,	0,	MT32},
{"yield",	"",		"t,s",		0x20000268, 0xfc00ffff,	WR_1|RD_2,		0,	0,	MT32},
};

const int bfd_nanomips_num_opcodes =
  ((sizeof nanomips_opcodes) / (sizeof (nanomips_opcodes[0])));
