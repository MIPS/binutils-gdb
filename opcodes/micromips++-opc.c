/* micromips-opc.c.  microMIPS opcode table.
   Copyright (C) 2008-2014 Free Software Foundation, Inc.
   Contributed by Chao-ying Fu, MIPS Technologies, Inc.

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
#include "opcode/mips.h"
#include "mips-formats.h"

static unsigned char reg_0_map[] = { 0 };
static unsigned char reg_28_map[] = { 28 };
static unsigned char reg_28_opt_map[] = { 0, 28 };
static unsigned char reg_29_map[] = { 29 };
static unsigned char reg_30_opt_map[] = { 0, 30 };
static unsigned char reg_31_map[] = { 31 };
static unsigned char reg_m16_map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
static unsigned char reg_q_map[] = { 0, 17, 2, 3, 4, 5, 6, 7 };

static unsigned char reg_4to5_map[] = { 0, 1, 2, 3, 4, 5, 6, 7,
					0, 1, 2, 3, 4, 5, 6, 7,
					16, 17, 18, 19, 20, 21, 22, 23,
					16, 17, 18, 19, 20, 21, 22, 23 };

static unsigned char reg_4or5_map[] = { 4, 5 };

static unsigned char reg_gpr2d1_map[] = {4, 5, 6, 7};
static unsigned char reg_gpr2d2_map[] = {7, 4, 5, 6};

static int int_b_map[] = {
  0, 4, 8, 12, 16, 20, 24, 28
};

static int int_c_map[] = {
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 65536, 14, 15
};


#define ALUI_PCREL_DEC \
    { \
      { { OP_PCREL, 20, 0, 0, 0 }, \
	(1 << ((20) - (1))) - 1, 0, 12, TRUE }, \
      0, FALSE, FALSE				\
    }

/* Return the mips_operand structure for the operand at the beginning of P.  */

/* FIXME: Unused pre-R7 cases left commented in-place for quick reminder 
   of which character strings are unused and what they used to be.  */
const struct mips_operand *
decode_micromipspp_operand (const char *p)
{
  switch (p[0])
    {
    case 'm':
      switch (p[1])
	{
	case 'a': MAPPED_REG (0, 0, GP, reg_28_map);
	case 'b': MAPPED_REG (1, 1, GP, reg_28_opt_map);
	  /* Note: this used to be optional previously, but the way it is used in the
	     new opcode table is not always amenable to optional use */
	case 'c': MAPPED_REG (3, 4, GP, reg_m16_map);
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
/* 	case 'r': SPECIAL (0, 0, PC); */
	case 's': MAPPED_REG (0, 0, GP, reg_29_map);
/* 	case 't': SPECIAL (0, 0, REPEAT_PREV_REG); */
	case 'u': REG (5, 3, GP); // New
	case 'w': MAPPED_REG (1, 0, GP, reg_30_opt_map);
/* 	case 'x': SPECIAL (0, 0, REPEAT_DEST_REG); */
	case 'y': MAPPED_REG (0, 0, GP, reg_31_map);
	case 'z': MAPPED_REG (0, 0, GP, reg_0_map);

	case 'A': INT_ADJ (7, 0, 63, 2, FALSE);	 /* (-64 .. 63) << 2 */
	case 'B': MAPPED_INT (3, 0, int_b_map, FALSE);
	case 'C': MAPPED_INT (4, 0, int_c_map, TRUE);
	case 'D': BRANCH_UNORD_SPLIT (10, 1);
	case 'E': BRANCH_UNORD_SPLIT (7, 1);
	case 'F': SPECIAL (4, 0, NON_ZERO_PCREL_S1);
	case 'G': INT_ADJ (4, 1, 15, 3, FALSE);
	case 'H': INT_ADJ (2, 1, 3, 1, FALSE);	 /* (0 .. 15) << 1 */
	case 'I': INT_ADJ (7, 0, 126, 0, FALSE); /* (-1 .. 126) */
	case 'J': INT_ADJ (4, 0, 15, 2, FALSE);	 /* (0 .. 15) << 2 */
	case 'K': SPECIAL_SPLIT (20, 2, 1, 0, HI20_PCREL); /* tri-part 20-bit */
	case 'L': UINT (2, 0);	 /* (0 .. 3) */
	case 'M': INT_ADJ (3, 0, 8, 0, FALSE);   /* (1 .. 8) */
	case 'N': UINT_SPLIT (2, 8, 2, 1, 3); /* split encoded 2-bit offset << 2 */
	case 'O': UINT_SPLIT (17, 0, 0, 5, 16); /* split 17-bit offset */
	case 'P': UINT_SPLIT (16, 0, 0, 4, 16); /* split 16-bit offset */
/* 	case 'Q': INT_ADJ (23, 0, 4194303, 2, FALSE); */
	case 'S': UINT (4, 17); /* (0 .. 15) */
	case 'T': UINT (4, 6); /* (0 .. 15) */
	case 'U': INT_ADJ (5, 0, 31, 2, FALSE);	 /* (0 .. 31) << 2 */
	case 'V': INT_ADJ (18, 3, (1<<18)-1, 3, FALSE); /* 18-bit << 3 */
	case 'W': INT_ADJ (6, 0, 63, 2, FALSE);	 /* (0 .. 63) << 2 */
	case 'X': INT_ADJ (4, 2, 15, 4, FALSE);	 /* 4-bit << 3 */
	case 'Y': INT_ADJ (9, 3, 511, 3, FALSE);	 /* 9-bit << 3 */
/* 	case 'Z': UINT (0, 0);			 /\* 0 only *\/ */
	case '1': SPLIT_MAPPED_REG (4, 5, 1, 9, GP, reg_4to5_map);
	case '2': SPLIT_MAPPED_REG (4, 0, 1, 4, GP, reg_4to5_map);
	case '3': SPLIT_MAPPED_REG (4, 5, 1, 9, GP, reg_4to5_map);
	case '4': MAPPED_REG (1, 24, GP, reg_4or5_map);
	case '5': SPLIT_MAPPED_REG (2, 3, 1, 8, GP, reg_gpr2d1_map);
	case '6': SPLIT_MAPPED_REG (2, 3, 1, 8, GP, reg_gpr2d2_map);
	case '7': SPLIT_MAPPED_REG (4, 21, 1, 25, GP, reg_4to5_map);
	case '8': HINT (23, 3);
	case '9': BRANCH (7, 11, 0);
	}
      break;

    case '-':
      switch (p[1])
	{
/* 	case 'A': PCREL (19, 0, TRUE, 2, 2, FALSE, FALSE); */
/* 	case 'B': PCREL (18, 0, TRUE, 3, 3, FALSE, FALSE); */

/* 	case 'a': INT_ADJ (19, 0, 262143, 2, FALSE); */
/* 	case 'b': INT_ADJ (18, 0, 131071, 3, FALSE); */
/* 	case 'd': MAPPED_REG (3, 1, GP, reg_m16_map); */
/* 	case 'e': OPTIONAL_MAPPED_REG (3, 7, GP, reg_m16_map); */
/* 	case 'm': SPLIT_MAPPED_REG (3, 0, 1, 3, GP, reg_mn_map); */
	case 's': SPECIAL (5, 16, NON_ZERO_REG);
	case 't': SPECIAL (5, 21, NON_ZERO_REG);
	case 'u': PREV_CHECK (3, 7, TRUE, FALSE, FALSE, FALSE);
/* 	case 'v': PREV_CHECK (5, 21, TRUE, TRUE, FALSE, FALSE); */
	case 'w': PREV_CHECK (3, 7, FALSE, TRUE, TRUE, TRUE);
/* 	case 'x': PREV_CHECK (5, 16, TRUE, FALSE, FALSE, TRUE); */
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
/* 	case 'E': BIT (5, 6, 32);		 /\* (32 .. 63) *\/ */
/* 	case 'F': MSB (5, 11, 33, TRUE, 64);	 /\* (33 .. 64), 64-bit op *\/ */
/* 	case 'G': MSB (5, 11, 33, FALSE, 64);	 /\* (33 .. 64), 64-bit op *\/ */
/* 	case 'H': MSB (5, 11, 1, FALSE, 64);	 /\* (1 .. 32), 64-bit op *\/ */
	case 'I': UINT (2, 9);
	case 'K': HINT (3, 2);
/* 	case 'L': INT_ADJ (4, 4, 15, 2, FALSE);	 /\* (0 .. 15) << 2 *\/ */
	case 'J': HINT (19, 0);
	case 'M': HINT (10, 16);
 	case 'N': SPECIAL (4, 6, SAVE_RESTORE_LIST);
	case 'O': UINT (3, 8);
	case 'Q': HINT (3, 2);
/* 	case 'P': INT_ADJ (5, 5, 31, 2, FALSE);	 /\* (0 .. 31) << 2 *\/ */
/* 	case 'S': REG (5, 21, FP); */
/* 	case 'T': INT_ADJ (10, 16, 511, 0, FALSE);	/\* (-512 .. 511) << 0 *\/ */
/* 	case 'U': INT_ADJ (10, 16, 511, 1, FALSE);	/\* (-512 .. 511) << 1 *\/ */
/* 	case 'V': INT_ADJ (10, 16, 511, 2, FALSE);	/\* (-512 .. 511) << 2 *\/ */
/* 	case 'W': INT_ADJ (10, 16, 511, 3, FALSE);	/\* (-512 .. 511) << 3 *\/ */

/* 	case 'd': REG (5, 6, MSA); */
/* 	case 'e': REG (5, 11, MSA); */
/* 	case 'h': REG (5, 16, MSA); */
	case 'i': HINT (5, 11);
	case 'j': UINT_SPLIT (9, 0, 0, 1, 15);
/* 	case 'k': REG (5, 6, GP); */
/* 	case 'l': REG (5, 6, MSA_CTRL); */
	case 'm': SINT_SPLIT (7, 2, 2, 1, 15); /* split 7-bit signed << 2 */
/* 	case 'n': REG (5, 11, MSA_CTRL); */
/* 	case 'o': SPECIAL (4, 16, IMM_INDEX); */
	case 'q': SINT_SPLIT (6, 3, 3, 1, 15); /* split 6-bit signed << 3 */
	case 'r': SINT_SPLIT (21, 1, 1, 1, 0); /* split 21-bit signed << 1 */
	case 's': REG (5, 21, GP);
	case 't': REG (5, 16, GP);
	case 'u': INT_ADJ (14, 0, ((1<<14)-1), 1, FALSE);
/* 	case 'v': SPECIAL (2, 16, IMM_INDEX); */
/* 	case 'w': SPECIAL (1, 16, IMM_INDEX); */
/* 	case 'x': BIT (5, 16, 0);		/\* (0 .. 31) *\/ */

/* 	case '!': BIT (3, 16, 0);		/\* (0 .. 7) *\/ */
/* 	case '#': BIT (6, 16, 0);		/\* (0 .. 63) *\/ */
/* 	case '$': UINT (5, 16);			/\* (0 .. 31) *\/ */
/* 	case '%': SINT (5, 16);			/\* (-16 .. 15) *\/ */
/* 	case '&': SPECIAL (0, 0, IMM_INDEX); */
/* 	case '*': SPECIAL (5, 16, REG_INDEX); */
/* 	case '|': BIT (8, 16, 0);		/\* (0 .. 255) *\/ */
/* 	case '\'': BRANCH (26, 0, 1); */
/* 	case '"': BRANCH (21, 0, 1); */
/* 	case ':': SINT (11, 0); */
	case '.': BIT (2, 9, 1);		/* (1 .. 4) */
/* 	case ';': SPECIAL (10, 16, SAME_RS_RT); */
	case '0': BRANCH_UNORD_SPLIT (14, 1);
	case '1': UINT (18, 0);
	case '2': INT_ADJ (16, 2, 2, 0, FALSE);
	case '6': SINT_SPLIT (4, 0, 0, 1, 4);
	case '8': BRANCH_UNORD_SPLIT (25, 1);
	}
      break;

    case '.': INT_ADJ (19, 2, (1<<19)-1, 2, FALSE);
    case '<': BIT (5, 0, 0);			 /* (0 .. 31) */
/*     case '>': BIT (5, 11, 32);			 /\* (32 .. 63) *\/ */
    case '\\': BIT (3, 21, 0);			 /* (0 .. 7) */
/*     case '|': HINT (4, 12); */
    case '~': BRANCH_UNORD_SPLIT (11, 1); 	/* split 11-bit signed << 1 */
    case '@': SINT (10, 16);
    case '^': HINT (5, 11);

    case '0': SINT (6, 16);
    case '1': HINT (5, 16);
    case '2': HINT (2, 14);
    case '3': HINT (3, 13);
    case '4': HINT (4, 12);
    case '5': HINT (8, 13);
    case '6': HINT (5, 16);
    case '7': REG (2, 14, ACC);
    case '8': HINT (7, 14);

    case 'C': HINT (23, 3);
    case 'D': REG (5, 11, FP);
    case 'E': REG (5, 21, COPRO);
    case 'G': REG (5, 16, COPRO);
    case 'K': REG (5, 16, HW);
    case 'H': UINT (3, 11);
/*     case 'M': REG (3, 13, CCC); */
/*     case 'N': REG (3, 18, CCC); */
    case 'R': REG (5, 11, FP);
    case 'S': REG (5, 16, FP);
    case 'T': REG (5, 21, FP);
/*     case 'V': OPTIONAL_REG (5, 16, FP); */

/*     case 'a': JUMP (26, 0, 1); */
    case 'b': REG (5, 16, GP);
/*     case 'c': HINT (10, 16); */
    case 'd': REG (5, 11, GP);
/*     case 'h': HINT (5, 11); */
    case 'i': UINT (12, 0);
    case 'j': SINT_SPLIT (14, 0, 0, 1, 15);
    case 'k': HINT (5, 21);
    case 'n': SPECIAL_SPLIT (11, 0, 9, 17, SAVE_RESTORE_LIST);
    case 'o': BRANCH_UNORD_SPLIT (20, 1);
/*     case 'p': BRANCH (16, 0, 1); */
/*     case 'q': HINT (10, 6); */
/*     case 'r': OPTIONAL_REG (5, 16, GP); */
    case 's': REG (5, 16, GP);
    case 't': REG (5, 21, GP);
    case 'u': SPECIAL_SPLIT (20, 2, 1, 0, HI20_INT);  /* tri-part 20-bit */

/*     case 'v': OPTIONAL_REG (5, 16, GP); */
/*     case 'w': OPTIONAL_REG (5, 21, GP); */
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

/* For 16-bit/32-bit microMIPS instructions.  They are used in pinfo2.  */
#define RD_sp	INSN2_READ_SP
#define WR_sp	INSN2_WRITE_SP
#define RD_31	INSN2_READ_GPR_31
#define RD_pc	INSN2_READ_PC

/* For 32-bit microMIPS instructions.  */
#define WR_31	INSN_WRITE_GPR_31

/* MIPS DSP ASE support.  */
#define D32	ASE_DSP

/* MIPS MCU (MicroController) ASE support.  */
#define MC	ASE_MCU

/* MIPS Enhanced VA Scheme.  */
#define EVA	ASE_EVA
#define EVA_R6	ASE_EVA_R6

/* TLB invalidate instruction support.  */
#define TLBINV	ASE_EVA

/* MIPS Virtualization ASE.  */
#define IVIRT	ASE_VIRT
#define IVIRT64	ASE_VIRT64
#define IVIRT_XPA ASE_VIRT_XPA

/* MSA support.  */
#define MSA     ASE_MSA
#define MSA64   ASE_MSA64

/* eXtended Physical Address (XPA) support.  */
#define XPA     ASE_XPA

#define FPU	0
#define CP2	0
#define EJTAG	0
#define UDI	0
#define XLP	ASE_XLP

/* New base ISAs starting at revision 7. */
#define I38	INSN_ISA32R7
#define I70	INSN_ISA64R7

const struct mips_opcode micromipspp_opcodes[] =
{
/* These instructions appear first so that the disassembler will find
   them first.  The assemblers uses a hash table based on the
   instruction name anyhow.  */
/* name,		args,		match,      mask,	pinfo,			pinfo2,		membership,	ase,	exclusions */
/* Precedence=1 */
{"aluipc",	"ma,mK",		0xe0000002, 0xffe00002,		WR_1,		0,	I38,		0,		0}, /* ALUIPC[GP] */
{"break",	"+K",		0xb001,	0xffe3,		0,		0,	I38,		0,		0},
{"dvp",	"t",		0x20000390, 0xfc1fffff,		WR_1,		0,	I38,		0,		0},
{"nop",	"",		0xb000,	0xffff,		0,		0,	I38,		0,		0}, /* NOP[16] */
{"sdbbp",	"+K",		0xb003,	0xffe3,		0,		0,	0,	EJTAG,		0},
{"sigrie",	"+J",		0x00000000, 0xfff80000,		0,		0,	I38,		0,		0},
{"synci",	"i(s)",		0x87e03000, 0xffe0f000,		RD_2,		0,	I38,		0,		0},
{"synci",	"+j(s)",		0xa7e01800, 0xffe07f00,		RD_2,		0,	I38,		0,		0}, /* SYNCI[S9] */
{"syncie",	"+j(s)",		0xa7e01c00, 0xffe07f00,		RD_2,		0,	0,	EVA,		0},
{"syncix",	"+s,+t",		0x2000f987, 0xfc00ffff,	RD_1|RD_2,		0,	I38,		0,		0},
	
/* Precedence=0 */
{"abs.d",	"T,S",		0xa000237b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"abs.s",	"T,S",		0xa000037b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"absq_s.ph",	"t,s",		0x2000113f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"absq_s.qb",	"t,s",		0x2000013f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"absq_s.w",	"t,s",		0x2000213f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"aclr",	"\\,+j(s)",		0xa6001100, 0xff007f00,		RD_3,		0,	0,	MC,		0},
{"add",	"d,s,t",		0x20000110, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"add.d",	"D,S,T",		0xa0000130, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"add.s",	"D,S,T",		0xa0000030, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"addiu",	"md,ms,mW",		0x7040,	0xfc40,	WR_1|RD_2,		0,	I38,		0,		0}, /* ADDIU[R1.SP] */
{"addiu",	"md,mc,mB",		0x9000,	0xfc08,	WR_1|RD_2,		0,	I38,		0,		0}, /* ADDIU[R2] */
{"addiu",	"mp,+6",		0x9008,	0xfc08,		MOD_1,		0,	I38,		0,		0}, /* ADDIU[RS5] */
{"addiu",	"-t,s,j",		0x00000000, 0xfc006000,	WR_1|RD_2,		0,	I38,		0,		0}, /* preceded by SIGRIE */
{"addiu",	"t,ma,.",		0x40000000, 0xfc000003,	WR_1|RD_2,		0,	I38,		0,		0}, /* ADDIU[GP] */
{"addq.ph",	"d,s,t",		0x2000000d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addqh.ph",	"d,s,t",		0x2000004d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addqh.w",	"d,s,t",		0x2000008d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addqh_r.ph", "d,s,t",		0x2000044d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addqh_r.w",	"d,s,t",		0x2000048d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addq_s.ph",	"d,s,t",		0x2000040d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addq_s.w",	"d,s,t",		0x20000305, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addsc",	"d,s,t",		0x20000385, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addu",	"me,mc,md",		0x1000,	0xfc01, WR_1|RD_2|RD_3,		0,	I38,		0,		0}, /* ADDU[16] */
{"addu",	"d,s,t",		0x20000150, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"addu.ph",	"d,s,t",		0x2000010d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addu.qb",	"d,s,t",		0x200000cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"adduh.qb",	"d,s,t",		0x2000014d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"adduh_r.qb", "d,s,t",		0x2000054d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addu_s.ph",	"d,s,t",		0x2000050d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addu_s.qb",	"d,s,t",		0x200004cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"addwc",	"d,s,t",		0x200003c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"align",	"d,s,t,+I",		0x2000001f, 0xfc0001ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"and",	"md,mc",		0x5008,	0xfc0f,	MOD_1|RD_2,		0,	I38,		0,		0}, /* AND[16] */
{"and",	"d,s,t",		0x20000250, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"andi",	"md,mc,mC",		0xf000,	0xfc00,	WR_1|RD_2,		0,	I38,		0,		0}, /* ANDI[16] */
{"andi",	"t,s,i",		0x80002000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"append",	"t,s,^",		0x20000215, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"aset",	"\\,+j(s)",		0xa4001100, 0xff007f00,		RD_3,		0,	0,	MC,		0},
{"auipc",	"t,mK",		0xe0000002, 0xfc000002,		WR_1,		0,	I38,		0,		0}, /* preceded by ALUIPC[GP] */
{"balc",	"mD",		0x3800,	0xfc00,		WR_31,		0,	I38,		0,		0}, /* BALC[16] */
{"balc",	"+8",		0x0a000000, 0xfe000000,		WR_31,		0,	I38,		0,		0},
{"balign",	"t,s,2",		0x200008bf, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"bc",		"mD",		0x1800,	0xfc00,		0,		0,	I38,		0,		0}, /* BC[16] */
{"bc",		"+8",		0x08000000, 0xfe000000,		0,		0,	I38,		0,		0},
{"bc1eqzc",	"T,+0",		0xc8004000, 0xfc1fc000,		RD_1,		0,	I38,	0,		0},
{"bc1nezc",	"T,+0",		0xc8014000, 0xfc1fc000,		RD_1,		0,	I38,	0,		0},
{"bc2eqzc",	"E,+0",		0xc8024000, 0xfc1fc000,		RD_1,		0,	0,	CP2,		0},
{"bc2nezc",	"E,+0",		0xc8034000, 0xfc1fc000,		RD_1,		0,	0,	CP2,		0},
{"beqc",	"mc,-u,mF",	0x5800,	0xfc00,	RD_1|RD_2,		0,	0,	XLP,		0}, /* BEQC[16], with rs3<rt3 && u[4:1]!=0 */
{"beqc",	"s,t,+0",	0xc8000000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"beqic",	"t,m9,~",	0x48000000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"beqzc",	"md,mE",		0x9800,	0xfc00,		RD_1,		0,	I38,		0,		0}, /* BEQZC[16] */
{"beqzc",	"t,o",		0xa8000000, 0xfc100000,		RD_1,		0,	I38,		0,		0},
{"bgec",	"s,t,+0",	0xc8008000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"bgeic",	"t,m9,~",	0x48080000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"bgeuc",	"s,t,+0",	0xc800c000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"bgeuic",	"t,m9,~",	0x480c0000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"bitrev",	"t,s",		0x2000313f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"bitswap",	"t,s",		0x20000b3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	XLP,		0},
{"bltc",	"s,t,+0",	0xe8008000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"bltic",	"t,m9,~",	0x48180000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"bltuc",	"s,t,+0",	0xe800c000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"bltuic",	"t,m9,~",	0x481c0000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"bnec",	"mc,-w,mF",	0x5800,	0xfc00,	RD_1|RD_2,		0,	0,	XLP,		0}, /* BNEC[16], with rs3>=rt3 && u[4:1]!=0 */
{"bnec",	"s,t,+0",	0xe8000000, 0xfc00c000,	RD_1|RD_2,		0,	I38,		0,		0},
{"bneic",	"t,m9,~",	0x48100000, 0xfc1c0000,		RD_1,		0,	0,	XLP,		0},
{"bnezc",	"md,mE",		0xb800,	0xfc00,		RD_1,		0,	I38,		0,		0}, /* BNEZC[16] */
{"bnezc",	"t,o",		0xa8100000, 0xfc100000,		RD_1,		0,	I38,		0,		0},
{"bposge32c",	"+u",		0xc8044000, 0xffffc000,		0,		0,	0,	D32,		0},
{"cache",	"k,+j(s)",		0xa4001900, 0xfc007f00,		RD_3,		0,	I38,		0,		0},
{"cachee",	"k,+j(s)",		0xa4001d00, 0xfc007f00,		RD_3,		0,	0,	EVA,		0},
{"ceil.l.d",	"T,S",		0xa000533b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"ceil.l.s",	"T,S",		0xa000133b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"ceil.w.d",	"T,S",		0xa0005b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"ceil.w.s",	"T,S",		0xa0001b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cfc1",	"t,S",		0xa000103b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cfc2",	"t,G",		0x2000cd3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CP2,		0},
{"class.d",	"T,S",		0xa0000260, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"class.s",	"T,S",		0xa0000060, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"clo",	"t,s",		0x20004b3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	XLP,		0},
{"clz",	"t,s",		0x20005b3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	XLP,		0},
{"cmp.af.d",	"D,S,T",		0xa0000015, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.af.s",	"D,S,T",		0xa0000005, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.eq.d",	"D,S,T",		0xa0000095, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.eq.ph",	"t,s",		0x20000005, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cmp.eq.s",	"D,S,T",		0xa0000085, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.le.d",	"D,S,T",		0xa0000195, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.le.ph",	"t,s",		0x20000085, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cmp.le.s",	"D,S,T",		0xa0000185, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.lt.d",	"D,S,T",		0xa0000115, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.lt.ph",	"t,s",		0x20000045, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cmp.lt.s",	"D,S,T",		0xa0000105, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ne.d",	"D,S,T",		0xa00004d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ne.s",	"D,S,T",		0xa00004c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.or.d",	"D,S,T",		0xa0000455, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.or.s",	"D,S,T",		0xa0000445, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.saf.d",	"D,S,T",		0xa0000215, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.saf.s",	"D,S,T",		0xa0000205, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.seq.d",	"D,S,T",		0xa0000295, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.seq.s",	"D,S,T",		0xa0000285, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sle.d",	"D,S,T",		0xa0000395, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sle.s",	"D,S,T",		0xa0000385, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.slt.d",	"D,S,T",		0xa0000315, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.slt.s",	"D,S,T",		0xa0000305, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sne.d",	"D,S,T",		0xa00006d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sne.s",	"D,S,T",		0xa00006c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sor.d",	"D,S,T",		0xa0000655, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sor.s",	"D,S,T",		0xa0000645, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sueq.d", "D,S,T",		0xa00002d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sueq.s", "D,S,T",		0xa00002c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sule.d", "D,S,T",		0xa00003d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sule.s", "D,S,T",		0xa00003c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sult.d", "D,S,T",		0xa0000355, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sult.s", "D,S,T",		0xa0000345, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sun.d",	"D,S,T",		0xa0000255, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sun.s",	"D,S,T",		0xa0000245, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sune.d", "D,S,T",		0xa0000695, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.sune.s", "D,S,T",		0xa0000685, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ueq.d",	"D,S,T",		0xa00000d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ueq.s",	"D,S,T",		0xa00000c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ule.d",	"D,S,T",		0xa00001d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ule.s",	"D,S,T",		0xa00001c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ult.d",	"D,S,T",		0xa0000155, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.ult.s",	"D,S,T",		0xa0000145, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.un.d",	"D,S,T",		0xa0000055, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.un.s",	"D,S,T",		0xa0000045, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.une.d",	"D,S,T",		0xa0000495, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmp.une.s",	"D,S,T",		0xa0000485, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"cmpgdu.eq.qb", "d,s,t",		0x20000185, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpgdu.le.qb", "d,s,t",		0x20000205, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpgdu.lt.qb", "d,s,t",		0x200001c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpgu.eq.qb", "d,s,t",		0x200000c5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpgu.le.qb", "d,s,t",		0x20000145, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpgu.lt.qb", "d,s,t",		0x20000105, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"cmpu.eq.qb", "t,s",		0x20000245, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cmpu.le.qb", "t,s",		0x200002c5, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cmpu.lt.qb", "t,s",		0x20000285, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"cop2_1",	"C",		0x20000002, 0xfc000007,		0,		0,	0,	CP2,		0},
{"ctc1",	"t,S",		0xa000183b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0,		0},
{"ctc2",	"t,G",		0x2000dd3f, 0xfc00ffff,	RD_1|WR_2,		0,	0,	CP2,		0},
{"cvt.d.l",	"T,S",		0xa000537b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.d.s",	"T,S",		0xa000137b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.d.w",	"T,S",		0xa000337b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.l.d",	"T,S",		0xa000413b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.l.s",	"T,S",		0xa000013b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.s.d",	"T,S",		0xa0001b7b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.s.l",	"T,S",		0xa0005b7b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.s.pl",	"T,S",		0xa000213b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.s.pu",	"T,S",		0xa000293b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.s.w",	"T,S",		0xa0003b7b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.w.d",	"T,S",		0xa000493b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"cvt.w.s",	"T,S",		0xa000093b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"dadd",	"d,s,t",		0xc0000110, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"daddiu",	"t,s,j",		0x00002000, 0xfc006000,	WR_1|RD_2,		0,	I70,		0,		0}, /* preceded by SIGRIE */
{"daddu",	"d,s,t",		0xc0000150, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dahi",	"t,mO",		0x80008000, 0xfc00f000,		WR_1,		0,	I70,		0,		0},
{"dalign",	"d,s,t,+O",	0xc000001c, 0xfc0000ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dati",	"t,mP",		0x80009000, 0xfc10f000,		WR_1,		0,	I70,		0,		0},
{"dbitswap",	"t,s",		0xc0000b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,		0,		0},
{"dclo",	"t,s",		0xc0004b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,		0,		0},
{"dclz",	"t,s",		0xc0005b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,		0,		0},
{"ddiv",	"d,s,t",		0xc0000118, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"ddivu",	"d,s,t",		0xc0000198, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"deret",	"",		0x2000e37f, 0xffffffff,		0,		0,	0,	EJTAG,		0},
{"dext",	"t,s,+A,+B",	0x8000f820, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"dextm",	"t,s,+A,+B",	0x8000f800, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"dextu",	"t,s,+A,+B",	0x8000f020, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"di",		"t",		0x2000477f, 0xfc1fffff,		WR_1,		0,	I38,		0,		0},
{"dins",	"t,s,+A,+C",	0x8000e820, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"dinsm",	"t,s,+A,+C",	0x8000e800, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"dinsu",	"t,s,+A,+C",	0x8000e020, 0xfc00f820,	WR_1|RD_2,		0,	I70,		0,		0},
{"div",	"d,s,t",		0x20000118, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"div.d",	"D,S,T",		0xa00001f0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"div.s",	"D,S,T",		0xa00000f0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"divu",	"d,s,t",		0x20000198, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"dlsa",	"d,s,t,+.",		0xc0000008, 0xfc0001ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmfc0",	"t,G,H",		0xc00000fc, 0xfc00c7ff,		WR_1,		0,	I70,		0,		0},
{"dmfc1",	"t,S",		0xa000243b, 0xfc00ffff,	WR_1|RD_2,		0,	I70,	0,		0},
{"dmfc2",	"t,G",		0x20006d3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CP2,		0},
{"dmfgc0",	"t,G,H",		0xc00004fc, 0xfc00c7ff,		WR_1,		0,	0,	IVIRT64,		0},
{"dmod",	"d,s,t",		0xc0000158, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmodu",	"d,s,t",		0xc00001d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmtc0",	"t,G,H",		0xc00002fc, 0xfc00c7ff,		RD_1,		0,	I70,		0,		0},
{"dmtc1",	"t,S",		0xa0002c3b, 0xfc00ffff,	RD_1|WR_2,		0,	I70,	0,		0},
{"dmtc2",	"t,G",		0x20007d3f, 0xfc00ffff,	RD_1|WR_2,		0,	0,	CP2,		0},
{"dmtgc0",	"t,G,H",		0xc00006fc, 0xfc00c7ff,		RD_1,		0,	0,	IVIRT64,		0},
{"dmuh",	"d,s,t",		0xc0000058, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmuhu",	"d,s,t",		0xc00000d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmul",	"d,s,t",		0xc0000018, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dmulu",	"d,s,t",		0xc0000098, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dpa.w.ph",	"7,s,t",		0x200000bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpaqx_s.w.ph", "7,s,t",		0x200022bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpaqx_sa.w.ph", "7,s,t",		0x200032bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpaq_s.w.ph", "7,s,t",		0x200002bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpaq_sa.l.w", "7,s,t",		0x200012bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpau.h.qbl", "7,s,t",		0x200020bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpau.h.qbr", "7,s,t",		0x200030bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpax.w.ph",	"7,s,t",		0x200010bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dps.w.ph",	"7,s,t",		0x200004bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsqx_s.w.ph", "7,s,t",		0x200026bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsqx_sa.w.ph", "7,s,t",		0x200036bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsq_s.w.ph", "7,s,t",		0x200006bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsq_sa.l.w", "7,s,t",		0x200016bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsu.h.qbl", "7,s,t",		0x200024bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsu.h.qbr", "7,s,t",		0x200034bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"dpsx.w.ph",	"7,s,t",		0x200014bf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
/*
{"drestore",	"count,mX",		0x1c03,	0xfc03,		0,		0,	I70,		0,		0}, /\* DRESTORE[16] *\/
{"drestore",	"t,countA,mY,j,mw,mb", 0x8001b000, 0xfc01f000,		WR_1,		0,	I70,		0,		0},
*/
{"drotr",	"t,s,<",		0x8000c1c0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"drotr32",	"t,s,<",		0x8000c1e0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"drotrv",	"d,s,t",		0xc00000d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
/*
{"dsave",	"count,mX",		0x1c01,	0xfc03,		0,		0,	I70,		0,		0}, /\* DSAVE[16] *\/
{"dsave",	"t,countA,mY,mw,mb",	0x8000b000, 0xfc01f004,		WR_1,		0,	I70,		0,		0},
*/
{"dsbh",	"t,s",		0xc0007b3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,		0,		0},
{"dshd",	"t,s",		0xc000fb3c, 0xfc00ffff,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsll",	"t,s,<",		0x8000c100, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsll32",	"t,s,<",		0x8000c120, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsllv",	"d,s,t",		0xc0000010, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dsra",	"t,s,<",		0x8000c180, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsra32",	"t,s,<",		0x8000c1a0, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsrav",	"d,s,t",		0xc0000090, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dsrl",	"t,s,<",		0x8000c140, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsrl32",	"t,s,<",		0x8000c160, 0xfc00ffe0,	WR_1|RD_2,		0,	I70,		0,		0},
{"dsrlv",	"d,s,t",		0xc0000050, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dsub",	"d,s,t",		0xc0000190, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"dsubu",	"d,s,t",		0xc00001d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"ei",		"t",		0x2000577f, 0xfc1fffff,		WR_1,		0,	I38,		0,		0},
{"eret",	"",		0x2000f37f, 0xffffffff,		0,		0,	I38,		0,		0},
{"eretnc",	"",		0x2001f37f, 0xffffffff,		0,		0,	I38,		0,		0},
{"evp",	"t",		0x20000790, 0xfc1fffff,		WR_1,		0,	I38,		0,		0},
{"ext",	"t,s,+A,+B",	0x8000f000, 0xfc00f820,	WR_1|RD_2,		0,	I38,		0,		0},
{"extp",	"t,7,6",		0x2000267f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"extpdp",	"t,7,6",		0x2000367f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"extpdpv",	"t,7,s",		0x200038bf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extpv",	"t,7,s",		0x200028bf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extr.w",	"t,7,6",	0x20000e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"extrv.w",	"t,7,s",		0x20000ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extrv_r.w",	"t,7,s",		0x20001ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extrv_rs.w", "t,7,s",		0x20002ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extrv_s.h",	"t,7,s",		0x20003ebf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"extr_r.w",	"t,7,6",	0x20001e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"extr_rs.w",	"t,7,6",	0x20002e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"extr_s.h",	"t,7,6",	0x20003e7f, 0xfc003fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"floor.l.d",	"T,S",		0xa000433b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"floor.l.s",	"T,S",		0xa000033b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"floor.w.d",	"T,S",		0xa0004b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"floor.w.s",	"T,S",		0xa0000b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"hypcall",	"+M",		0x2000c37f, 0xfc00ffff,		0,		0,	0,		IVIRT,		0},
{"ins",	"t,s,+A,+C",	0x8000e000, 0xfc00f820,	WR_1|RD_2,		0,	I38,		0,		0},
{"insv",	"t,s",		0x2000413f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"iret",	"",		0x2000d37f, 0xffffffff,		0,		0,	0,	MC,		0},
{"jalrc",	"mp",		0x5810,	0xfc1f,	WR_31|RD_1,		0,	I38,		0,		0},
{"jialc",	"t,s,i",		0x88000000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"jialc.hb",	"t,s,i",		0x88001000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"jrc",	"mp",		0x5800,	0xfc1f,		RD_1,		0,	I38,		0,		0},
{"lb",		"md,mL(mc)",		0x1400,	0xfc0c,	WR_1|RD_3,		0,	I38,		0,		0}, /* LB[16] */
{"lb",		"t,i(s)",		0x84000000, 0xfc00f000,	WR_1|RD_3,		0,	I38,		0,		0},
{"lb",		"t,+1(ma)",		0x44000000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,		0,		0}, /* LB[GP] */
{"lb",		"t,+j(s)",		0xa4000000, 0xfc007f00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LB[S9] */
{"lbe",	"t,+j(s)",		0xa4000400, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA,		0},
{"lbu",	"md,mL(mc)",		0x1408,	0xfc0c,	WR_1|RD_3,		0,	I38,		0,		0}, /* LBU[16] */
{"lbu",	"t,i(s)",		0x84002000, 0xfc00f000,	WR_1|RD_3,		0,	I38,		0,		0},
{"lbu",	"t,+1(ma)",		0x44080000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,		0,		0}, /* LBU[GP] */
{"lbu",	"t,+j(s)",		0xa4001000, 0xfc007f00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LBU[S9] */
{"lbue",	"t,+j(s)",		0xa4001400, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA,		0},
{"lbux",	"d,s,t",		0x20000107, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lbx",	"d,s,t",		0x20000007, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"ld",		"t,i(s)",		0x8400c000, 0xfc00f000,	WR_1|RD_3,		0,	I70,		0,		0},
{"ld",		"t,mV(ma)",		0x40000001, 0xfc000007,	WR_1|RD_3,		0,	I70,		0,		0}, /* LD[GP] */
{"ld",		"t,+j(s)",		0xa4006000, 0xfc007f00,	WR_1|RD_3,		0,	I70,		0,		0}, /* LD[S9] */
{"ldc1",	"T,i(s)",		0x8400e000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0,		0},
{"ldc1",	"T,+2(ma)",		0x440c0002, 0xfc1c0003,	WR_1|RD_3,		0,	I38,	0,		0}, /* LDC1[GP] */
{"ldc1",	"T,+j(s)",		0xa4007000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0,		0}, /* LDC1[S9] */
{"ldc1x",	"R,s,t",		0x20000707, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"ldc1xs",	"R,s,t",		0x20000747, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"ldc2",	"E,+j(s)",		0xa4007100, 0xfc007f00,	WR_1|RD_3,		0,	0,	CP2,		0},
{"ldx",	"d,s,t",		0x20000607, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"ldxs",	"d,s,t",		0x20000647, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"lh",		"md,mH(mc)",		0x3400,	0xfc09,	WR_1|RD_3,		0,	I38,		0,		0}, /* LH[16] */
{"lh",		"t,i(s)",		0x84004000, 0xfc00f000,	WR_1|RD_3,		0,	I38,		0,		0},
{"lh",		"t,+1(ma)",		0x44100000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,		0,		0}, /* LH[GP] */
{"lh",		"t,+j(s)",		0xa4002000, 0xfc007f00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LH[S9] */
{"lhe",	"t,+j(s)",		0xa4002400, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA,		0},
{"lhu",	"md,mH(mc)",		0x3408,	0xfc09,	WR_1|RD_3,		0,	I38,		0,		0}, /* LHU[16] */
{"lhu",	"t,i(s)",		0x84006000, 0xfc00f000,	WR_1|RD_3,		0,	I38,		0,		0},
{"lhu",	"t,+1(ma)",		0x44180000, 0xfc1c0000,	WR_1|RD_3,		0,	I38,		0,		0}, /* LHU[GP] */
{"lhu",	"t,+j(s)",		0xa4003000, 0xfc007f00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LHU[S9] */
{"lhue",	"t,+j(s)",		0xa4003400, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA,		0},
{"lhux",	"d,s,t",		0x20000307, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lhuxs",	"d,s,t",		0x20000347, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lhx",	"d,s,t",		0x20000207, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lhxs",	"d,s,t",		0x20000247, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"li",		"md,mI",		0xd000,	0xfc00,		WR_1,		0,	I38,		0,		0}, /* LI[16] */
{"ll",		"t,+m(s)",		0xa4004100, 0xfc007f03,	WR_1|RD_3,		0,	I38,		0,		0},
{"lld",	"t,+q(s)",		0xa4006100, 0xfc007f07,	WR_1|RD_3,		0,	I70,		0,		0},
{"lldp",	"t,mu,(s)",		0xa4006101, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	I70,		0,		0},
{"lle",	"t,+m(s)",		0xa4004500, 0xfc007f03,	WR_1|RD_3,		0,	0,	EVA,		0},
{"llp",	"t,mu,(s)",		0xa4004101, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	0,	XLP,		0},
{"llpe",	"t,mu,(s)",		0xa4004501, 0xfc00ff07, WR_1|WR_2|RD_3,		0,	0,	EVA,		0},
{"lsa",	"d,s,t,+.",		0x2000000f, 0xfc0001ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lui",	"t,u",		0xe0000000, 0xfc000002,		WR_1,		0,	I38,		0,		0},
{"lw",		"md,mJ(mc)",		0x7400,	0xfc00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LW[16] */
{"lw",		"m1,mN(m2)",		0x9400,	0xfc00,	WR_1|RD_3,		0,	0,	XLP,		0}, /* LW[4X4] */
{"lw",		"md,mA(ma)",		0xb400,	0xfc00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LW[GP16] */
{"lw",		"mp,mU(ms)",		0x5400,	0xfc00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LW[SP] */
{"lw",		"t,i(s)",		0x84008000, 0xfc00f000,	WR_1|RD_3,		0,	I38,		0,		0},
{"lw",		"t,.(ma)",		0x40000002, 0xfc000003,	WR_1|RD_3,		0,	I38,		0,		0}, /* LW[GP] */
{"lw",		"t,+j(s)",		0xa4004000, 0xfc007f00,	WR_1|RD_3,		0,	I38,		0,		0}, /* LW[S9] */
{"lwc1",	"T,i(s)",		0x8400a000, 0xfc00f000,	WR_1|RD_3,		0,	I38,	0,		0},
{"lwc1",	"T,+2(ma)",		0x440c0000, 0xfc1c0003,	WR_1|RD_3,		0,	I38,	0,		0}, /* LWC1[GP] */
{"lwc1",	"T,+j(s)",		0xa4005000, 0xfc007f00,	WR_1|RD_3,		0,	I38,	0,		0}, /* LWC1[S9] */
{"lwc1x",	"R,s,t",		0x20000507, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"lwc1xs",	"R,s,t",		0x20000547, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"lwc2",	"E,+j(s)",		0xa4005100, 0xfc007f00,	WR_1|RD_3,		0,	0,	CP2,		0},
{"lwe",	"t,+j(s)",		0xa4004400, 0xfc007f00,	WR_1|RD_3,		0,	0,	EVA,		0},
{"lwu",	"t,i(s)",		0x84007000, 0xfc00f000,	WR_1|RD_3,		0,	I70,		0,		0},
{"lwu",	"t,+2(ma)",		0x441c0000, 0xfc1c0003,	WR_1|RD_3,		0,	I70,		0,		0}, /* LWU[GP] */
{"lwu",	"t,+j(s)",		0xa4003800, 0xfc007f00,	WR_1|RD_3,		0,	I70,		0,		0}, /* LWU[S9] */
{"lwux",	"d,s,t",		0x20000387, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"lwuxs",	"d,s,t",		0x200003c7, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I70,		0,		0},
{"lwx",	"d,s,t",		0x20000407, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"lwxs",	"me,mc,md",		0x5001,	0xfc01, WR_1|RD_2|RD_3,		0,	0,	XLP,		0}, /* LWXS[16] */
{"lwxs",	"d,s,t",		0x20000447, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"madd",	"7,s,t",		0x20000abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MADD[DSP] */
{"maddf.d",	"D,S,T",		0xa00003b8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"maddf.s",	"D,S,T",		0xa00001b8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"maddu",	"7,s,t",		0x20001abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MADDU[DSP] */
{"maq_s.w.phl", "7,s,t",		0x20001a7f, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"maq_s.w.phr", "7,s,t",		0x20000a7f, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"maq_sa.w.phl", "7,s,t",		0x20003a7f, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"maq_sa.w.phr", "7,s,t",		0x20002a7f, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0},
{"max.d",	"D,S,T",		0xa000020b, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"max.s",	"D,S,T",		0xa000000b, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"maxa.d",	"D,S,T",		0xa000022b, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"maxa.s",	"D,S,T",		0xa000002b, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"mfc0",	"t,G,H",		0x20000030, 0xfc00c7ff,		WR_1,		0,	I38,		0,		0},
{"mfc1",	"t,S",		0xa000203b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"mfc2",	"t,G",		0x20004d3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CP2,		0},
{"mfgc0",	"t,G,H",		0x200000b0, 0xfc00c7ff,		WR_1,		0,	0,		IVIRT,		0},
{"mfhc0",	"t,G,H",		0x20000038, 0xfc00c7ff,		WR_1,		0,	0,	XPA,		0},
{"mfhc1",	"t,S",		0xa000303b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"mfhc2",	"t,G",		0x20008d3f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	CP2,		0},
{"mfhgc0",	"t,G,H",		0x200000b8, 0xfc00c7ff,		WR_1,		0,	0,	IVIRT_XPA,		0},
{"mfhi",	"t,7",		0x2000007f, 0xfc1f3fff,	WR_1|RD_2,		0,	0,	D32,		0}, /* MFHI[DSP] */
{"mflo",	"t,7",		0x2000107f, 0xfc1f3fff,	WR_1|RD_2,		0,	0,	D32,		0}, /* MFLO[DSP] */
{"min.d",	"D,S,T",		0xa0000203, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"min.s",	"D,S,T",		0xa0000003, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"mina.d",	"D,S,T",		0xa0000223, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"mina.s",	"D,S,T",		0xa0000023, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"mod",	"d,s,t",		0x20000158, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"modsub",	"d,s,t",		0x20000295, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"modu",	"d,s,t",		0x200001d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"mov.d",	"T,S",		0xa000207b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"mov.s",	"T,S",		0xa000007b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"move",	"mp,mj",		0xb000,	0xfc00,	WR_1|RD_2,		0,	I38,		0,		0}, /* preceded by BREAK, NOP[16], SDBBP */
{"move.balc",	"m4,m7,+r",	0x68000000, 0xfc000000,	WR_1|RD_2,		0,	0,	XLP,		0},
{"movep",	"m5,m6,m2,m1",		0xbc00,	0xfc00,WR_1|WR_2|RD_3|RD_4,		0,	0,	XLP,		0},
{"movn",	"d,+s,+t",		0x20000610, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"movz",	"d,+s,+t",		0x20000210, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"msub",	"7,s,t",		0x20002abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MSUB[DSP] */
{"msubf.d",	"D,S,T",		0xa00003f8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"msubf.s",	"D,S,T",		0xa00001f8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"msubu",	"7,s,t",		0x20003abf, 0xfc003fff,MOD_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MSUBU[DSP] */
{"mtc0",	"t,G,H",		0x20000070, 0xfc00c7ff,		RD_1,		0,	I38,		0,		0},
{"mtc1",	"t,S",		0xa000283b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0,		0},
{"mtc2",	"t,G",		0x20005d3f, 0xfc00ffff,	RD_1|WR_2,		0,	0,	CP2,		0},
{"mtgc0",	"t,G,H",		0x200000f0, 0xfc00c7ff,		RD_1,		0,	0,		IVIRT,		0},
{"mthc0",	"t,G,H",		0x20000078, 0xfc00c7ff,		RD_1,		0,	0,	XPA,		0},
{"mthc1",	"t,S",		0xa000383b, 0xfc00ffff,	RD_1|WR_2,		0,	I38,	0,		0},
{"mthc2",	"t,G",		0x20009d3f, 0xfc00ffff,	RD_1|WR_2,		0,	0,	CP2,		0},
{"mthgc0",	"t,G,H",		0x200000f8, 0xfc00c7ff,		RD_1,		0,	0,	IVIRT_XPA,		0},
{"mthi",	"7,s",		0x2000207f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32,		0}, /* MTHI[DSP] */
{"mthlip",	"7,s",		0x2000027f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"mtlo",	"7,s",		0x2000307f, 0xffe03fff,	WR_1|RD_2,		0,	0,	D32,		0}, /* MTLO[DSP] */
{"muh",	"d,s,t",		0x20000058, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"muhu",	"d,s,t",		0x200000d8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"mul",	"d,s,t",		0x20000018, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"mul.d",	"D,S,T",		0xa00001b0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"mul.ph",	"d,s,t",		0x2000002d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mul.s",	"D,S,T",		0xa00000b0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"muleq_s.w.phl", "d,s,t",		0x20000025, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"muleq_s.w.phr", "d,s,t",		0x20000065, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"muleu_s.ph.qbl", "d,s,t",	0x20000095, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"muleu_s.ph.qbr", "d,s,t",	0x200000d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulq_rs.ph", "d,s,t",		0x20000115, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulq_rs.w",	"d,s,t",		0x20000195, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulq_s.ph",	"d,s,t",		0x20000155, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulq_s.w",	"d,s,t",		0x200001d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulsa.w.ph", "7,s,t",		0x20002cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mulsaq_s.w.ph", "7,s,t",		0x20003cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"mult",	"7,s,t",		0x20000cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MULT[DSP] */
{"multu",	"7,s,t",		0x20001cbf, 0xfc003fff, WR_1|RD_2|RD_3,		0,	0,	D32,		0}, /* MULTU[DSP] */
{"mulu",	"d,s,t",		0x20000098, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"mul_s.ph",	"d,s,t",		0x2000042d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"neg.d",	"T,S",		0xa0002b7b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"neg.s",	"T,S",		0xa0000b7b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"nor",	"d,s,t",		0x200002d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"not",	"md,mc",		0x5000,	0xfc0f,	WR_1|RD_2,		0,	I38,		0,		0}, /* NOT[16] */
{"or",		"md,mc",		0x500c,	0xfc0f,	WR_1|RD_2,		0,	I38,		0,		0}, /* OR[16] */
{"or",		"d,s,t",		0x20000290, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"ori",	"t,s,i",		0x80000000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"packrl.ph",	"d,s,t",		0x200001ad, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"pick.ph",	"d,s,t",		0x2000022d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"pick.qb",	"d,s,t",		0x200001ed, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"preceq.w.phl", "t,s",		0x2000513f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"preceq.w.phr", "t,s",		0x2000613f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precequ.ph.qbl", "t,s",		0x2000713f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precequ.ph.qbla", "t,s",		0x2000733f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precequ.ph.qbr", "t,s",		0x2000913f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precequ.ph.qbra", "t,s",		0x2000933f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"preceu.ph.qbl", "t,s",		0x2000b13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"preceu.ph.qbla", "t,s",		0x2000b33f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"preceu.ph.qbr", "t,s",		0x2000d13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"preceu.ph.qbra", "t,s",		0x2000d33f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precr.qb.ph", "d,s,t",		0x2000006d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"precrq.ph.w", "d,s,t",		0x200000ed, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"precrq.qb.ph", "d,s,t",		0x200000ad, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"precrqu_s.qb.ph", "d,s,t",	0x2000016d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"precrq_rs.ph.w", "d,s,t",	0x2000012d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"precr_sra.ph.w", "t,s,^",	0x200003cd, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"precr_sra_r.ph.w", "t,s,^",	0x200007cd, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"pref",	"k,i(s)",		0x84003000, 0xfc00f000,		RD_3,		0,	I38,		0,		0}, /* preceded by SYNCI */
{"pref",	"k,+j(s)",		0xa4001800, 0xfc007f00,		RD_3,		0,	I38,		0,		0}, /* PREF[S9], preceded by SYNCI[S9] */
{"prefe",	"k,+j(s)",		0xa4001c00, 0xfc007f00,		RD_3,		0,	0,	EVA,		0}, /* preceded by SYNCIE */
{"prefx",	"+i,s,t",		0x20000187, 0xfc0007ff,	RD_2|RD_3,		0,	I38,		0,		0}, /* preceded by SYNCIX */
{"prepend",	"t,s,^",		0x20000255, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"raddu.w.qb", "t,s",		0x2000f13f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"rddsp",	"t,8",		0x2000067f, 0xfc003fff,		WR_1,		0,	0,	D32,		0},
{"rdhwr",	"t,K,H",		0x200001c0, 0xfc00c7ff,	WR_1|RD_2,		0,	I38,		0,		0},
{"rdpgpr",	"t,s",		0x2000e17f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,		0,		0},
{"recip.d",	"T,S",		0xa000523b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"recip.s",	"T,S",		0xa000123b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"repl.ph",	"d,@",		0x2000003d, 0xfc0007ff,		WR_1,		0,	0,	D32,		0},
{"repl.qb",	"t,5",		0x200005ff, 0xfc001fff,		WR_1,		0,	0,	D32,		0},
{"replv.ph",	"t,s",		0x2000033f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"replv.qb",	"t,s",		0x2000133f, 0xfc00ffff,	WR_1|RD_2,		0,	0,	D32,		0},
{"restore",	"mG",		0x1fe0,	0xffe1,		0,		0,	0,	XLP,		0}, /* RESTORE[16] */
{"restore",	"n,mY",		0x80013000, 0xfc01f004,		0,		0,	I38,		0,		0},
{"restore.jrc", "+N,mG",		0x1c20,	0xfc21,		0,		0,	0,	XLP,		0}, /* RESTORE.JRC[16], preceded by RESTORE[16] */
{"restore.jrc", "n,mY",	0x80013004, 0xfc01f004,		0,		0,	I38,		0,		0},
/*
{"restoref",	"fpr_list,mY",		0x80017000, 0xffe1f007,		WR_1,		0,	I38,	0,		0},
*/
{"rint.d",	"T,S",		0xa0000220, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"rint.s",	"T,S",		0xa0000020, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"rotr",	"t,s,<",		0x8000c0c0, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,		0,		0},
{"rotrv",	"d,s,t",		0x200000d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"round.l.d",	"T,S",		0xa000733b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"round.l.s",	"T,S",		0xa000333b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"round.w.d",	"T,S",		0xa0007b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"round.w.s",	"T,S",		0xa0003b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"rsqrt.d",	"T,S",		0xa000423b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"rsqrt.s",	"T,S",		0xa000023b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"save",	"+N,mG",		0x1c00,	0xfc21,		0,		0,	0,	XLP,		0}, /* SAVE[16] */
{"save",	"n,mY",		0x80003000, 0xfc01f004,		0,		0,	I38,		0,		0},
/*
{"savef",	"fpr_list,mY",		0x80007000, 0xffe1f007,		RD_1,		0,	I38,	0,		0},
*/
{"sb",		"mq,mL(mc)",		0x1404,	0xfc0c,	RD_1|RD_3,		0,	I38,		0,		0}, /* SB[16] */
{"sb",		"t,i(s)",		0x84001000, 0xfc00f000,	RD_1|RD_3,		0,	I38,		0,		0},
{"sb",		"t,+1(ma)",		0x44040000, 0xfc1c0000,	RD_1|RD_3,		0,	I38,		0,		0}, /* SB[GP] */
{"sb",		"t,+j(s)",		0xa4000800, 0xfc007f00,	RD_1|RD_3,		0,	I38,		0,		0}, /* SB[S9] */
{"sbe",	"t,+j,(s)",		0xa4000c00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA,		0},
{"sbx",	"d,s,t",		0x20000087, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	XLP,		0},
{"sc",		"t,+m(s)",		0xa4004900, 0xfc007f03,	MOD_1|RD_3,		0,	I38,		0,		0},
{"scd",	"t,+q(s)",		0xa4006900, 0xfc007f07,	MOD_1|RD_3,		0,	I70,		0,		0},
{"scdp",	"t,mu,(s)",		0xa4006901, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	I70,		0,		0},
{"sce",	"t,+m(s)",		0xa4004d00, 0xfc007f03,	MOD_1|RD_3,		0,	0,	EVA,		0},
{"scp",	"t,mu,(s)",		0xa4004901, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	0,	XLP,		0},
{"scpe",	"t,mu,(s)",		0xa4004d01, 0xfc00ff07,MOD_1|WR_2|RD_3,		0,	0,	EVA,		0},
{"sd",		"t,i(s)",		0x8400d000, 0xfc00f000,	RD_1|RD_3,		0,	I70,		0,		0},
{"sd",		"t,mV(ma)",		0x40000005, 0xfc000007,	RD_1|RD_3,		0,	I70,		0,		0}, /* SD[GP] */
{"sd",		"t,+j(s)",		0xa4006800, 0xfc007f00,	RD_1|RD_3,		0,	I70,		0,		0}, /* SD[S9] */
{"sdc1",	"T,i(s)",		0x8400f000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0,		0},
{"sdc1",	"T,+2(ma)",		0x440c0003, 0xfc1c0003,	RD_1|RD_3,		0,	I38,	0,		0}, /* SDC1[GP] */
{"sdc1",	"T,+j(s)",		0xa4007800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0,		0}, /* SDC1[S9] */
{"sdc1x",	"R,s,t",		0x20000787, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0,		0},
{"sdc1xs",	"R,s,t",		0x200007c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0,		0},
{"sdc2",	"E,+j(s)",		0xa4007900, 0xfc007f00,	RD_1|RD_3,		0,	0,	CP2,		0},
{"sdx",	"d,s,t",		0x20000687, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I70,		0,		0},
{"sdxs",	"d,s,t",		0x200006c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I70,		0,		0},
{"seb",	"t,s",		0x20002b3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,		0,		0},
{"seh",	"t,s",		0x20003b3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,		0,		0},
{"sel.d",	"D,S,T",		0xa00002b8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"sel.s",	"D,S,T",		0xa00000b8, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"seleqz.d",	"D,S,T",		0xa0000238, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"seleqz.s",	"D,S,T",		0xa0000038, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"selnez.d",	"D,S,T",		0xa0000278, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"selnez.s",	"D,S,T",		0xa0000078, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"sh",		"mq,mH(mc)",		0x3401,	0xfc09,	RD_1|RD_3,		0,	I38,		0,		0}, /* SH[16] */
{"sh",		"t,i(s)",		0x84005000, 0xfc00f000,	RD_1|RD_3,		0,	I38,		0,		0},
{"sh",		"t,+1(ma)",		0x44140000, 0xfc1c0000,	RD_1|RD_3,		0,	I38,		0,		0}, /* SH[GP] */
{"sh",		"t,+j(s)",		0xa4002800, 0xfc007f00,	RD_1|RD_3,		0,	I38,		0,		0}, /* SH[S9] */
{"she",	"t,+j(s)",		0xa4002c00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA,		0},
{"shilo",	"7,0",		0x2000001d, 0xffc03fff,		MOD_1,		0,	0,	D32,		0},
{"shilov",	"7,s",		0x2000127f, 0xffe03fff,	MOD_1|RD_2,		0,	0,	D32,		0},
{"shll.ph",	"t,s,4",		0x200003b5, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shll.qb",	"t,s,3",		0x2000087f, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shllv.ph",	"d,s,t",		0x2000038d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shllv.qb",	"d,s,t",		0x20000395, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shllv_s.ph", "d,s,t",		0x2000078d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shllv_s.w",	"d,s,t",		0x200003d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shll_s.ph",	"t,s,4",		0x20000bb5, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shll_s.w",	"t,s,^",		0x200003f5, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shra.ph",	"t,s,4",		0x20000335, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shra.qb",	"t,s,3",		0x200001ff, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shrav.ph",	"d,s,t",		0x2000018d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shrav.qb",	"d,s,t",		0x200001cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shrav_r.ph", "d,s,t",		0x2000058d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shrav_r.qb", "d,s,t",		0x200005cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shrav_r.w",	"d,s,t",		0x200002d5, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shra_r.ph",	"t,s,4",		0x20000735, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shra_r.qb",	"t,s,3",		0x200011ff, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shra_r.w",	"t,s,^",		0x200002f5, 0xfc0007ff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shrl.ph",	"t,s,4",		0x200003ff, 0xfc000fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shrl.qb",	"t,s,3",		0x2000187f, 0xfc001fff,	WR_1|RD_2,		0,	0,	D32,		0},
{"shrlv.ph",	"d,s,t",		0x20000315, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shrlv.qb",	"d,s,t",		0x20000355, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"shx",	"d,s,t",		0x20000287, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	XLP,		0},
{"shxs",	"d,s,t",		0x200002c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	XLP,		0},
{"sll",	"md,mc,mM",		0x3000,	0xfc08,	WR_1|RD_2,		0,	I38,		0,		0}, /* SLL[16] */
{"sll",	"t,s,<",		0x8000c000, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,		0,		0},
{"sllv",	"d,s,t",		0x20000010, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"slt",	"d,s,t",		0x20000350, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"slti",	"t,s,i",		0x80004000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"sltiu",	"t,s,i",		0x80005000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
{"sltu",	"d,s,t",		0x20000390, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0}, /* preceded by DVP */
{"sov",	"d,s,t",		0x200003d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"special2",	"m8",		0x20000001, 0xfc000007,		0,		0,	0,	UDI,		0},
{"sqrt.d",	"T,S",		0xa0004a3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"sqrt.s",	"T,S",		0xa0000a3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"sra",	"t,s,<",		0x8000c080, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,		0,		0},
{"srav",	"d,s,t",		0x20000090, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"srl",	"md,mc,mM",		0x3008,	0xfc08,	WR_1|RD_2,		0,	I38,		0,		0}, /* SRL[16] */
{"srl",	"t,s,<",		0x8000c040, 0xfc00ffe0,	WR_1|RD_2,		0,	I38,		0,		0},
{"srlv",	"d,s,t",		0x20000050, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"sub",	"d,s,t",		0x20000190, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"sub.d",	"D,S,T",		0xa0000170, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"sub.s",	"D,S,T",		0xa0000070, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,	0,		0},
{"subq.ph",	"d,s,t",		0x2000020d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subqh.ph",	"d,s,t",		0x2000024d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subqh.w",	"d,s,t",		0x2000028d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subqh_r.ph", "d,s,t",		0x2000064d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subqh_r.w",	"d,s,t",		0x2000068d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subq_s.ph",	"d,s,t",		0x2000060d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subq_s.w",	"d,s,t",		0x20000345, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subu",	"me,mc,md",		0x1001,	0xfc01, WR_1|RD_2|RD_3,		0,	I38,		0,		0}, /* SUBU[16] */
{"subu",	"d,s,t",		0x200001d0, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"subu.ph",	"d,s,t",		0x2000030d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subu.qb",	"d,s,t",		0x200002cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subuh.qb",	"d,s,t",		0x2000034d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subuh_r.qb", "d,s,t",		0x2000074d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subu_s.ph",	"d,s,t",		0x2000070d, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"subu_s.qb",	"d,s,t",		0x200006cd, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	0,	D32,		0},
{"sw",		"mq,mJ(mc)",		0xf400,	0xfc00,	RD_1|RD_3,		0,	I38,		0,		0}, /* SW[16] */
{"sw",		"mp,mU(ms)",		0xd400,	0xfc00,	RD_1|RD_3,		0,	I38,		0,		0}, /* SW[SP] */
{"sw",		"t,i(s)",		0x84009000, 0xfc00f000,	RD_1|RD_3,		0,	I38,		0,		0},
{"sw",		"t,.(ma)",		0x40000003, 0xfc000003,	RD_1|RD_3,		0,	I38,		0,		0}, /* SW[GP] */
{"sw",		"t,+j(s)",		0xa4004800, 0xfc007f00,	RD_1|RD_3,		0,	I38,		0,		0}, /* SW[S9] */
{"swc1",	"T,i(s)",		0x8400b000, 0xfc00f000,	RD_1|RD_3,		0,	I38,	0,		0},
{"swc1",	"T,+2(ma)",		0x440c0001, 0xfc1c0003,	RD_1|RD_3,		0,	I38,	0,		0}, /* SWC1[GP] */
{"swc1",	"T,+j(s)",		0xa4005800, 0xfc007f00,	RD_1|RD_3,		0,	I38,	0,		0}, /* SWC1[S9] */
{"swc1x",	"R,s,t",		0x20000587, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0,		0},
{"swc1xs",	"R,s,t",		0x200005c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	I38,	0,		0},
{"swc2",	"E,+j(s)",		0xa4005900, 0xfc007f00,	RD_1|RD_3,		0,	0,	CP2,		0},
{"swe",	"t,+j(s)",		0xa4004c00, 0xfc007f00,	RD_1|RD_3,		0,	0,	EVA,		0},
{"swx",	"d,s,t",		0x20000487, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	XLP,		0},
{"swxs",	"d,s,t",		0x200004c7, 0xfc0007ff, RD_1|RD_2|RD_3,		0,	0,	XLP,		0},
{"sync",	"1",		0x20006b7f, 0xffe0ffff,		0,		0,	I38,		0,		0},
{"syscall",	"+M",		0x20008b7f, 0xfc00ffff,		0,		0,	I38,		0,		0},
{"tlbginv",	"",		0x2000417f, 0xffffffff,		0,		0,	0,	TLBINV,		0},
{"tlbginvf",	"",		0x2000517f, 0xffffffff,		0,		0,	0,	TLBINV,		0},
{"tlbgp",	"",		0x2000017f, 0xffffffff,		0,		0,	0,		IVIRT,		0},
{"tlbgr",	"",		0x2000117f, 0xffffffff,		0,		0,	0,		IVIRT,		0},
{"tlbgwi",	"",		0x2000217f, 0xffffffff,		0,		0,	0,		IVIRT,		0},
{"tlbgwr",	"",		0x2000317f, 0xffffffff,		0,		0,	0,		IVIRT,		0},
{"tlbinv",	"",		0x2000437f, 0xffffffff,		0,		0,	0,	TLBINV,		0},
{"tlbinvf",	"",		0x2000537f, 0xffffffff,		0,		0,	0,	TLBINV,		0},
{"tlbp",	"",		0x2000037f, 0xffffffff,		0,		0,	I38,		0,		0},
{"tlbr",	"",		0x2000137f, 0xffffffff,		0,		0,	I38,		0,		0},
{"tlbwi",	"",		0x2000237f, 0xffffffff,		0,		0,	I38,		0,		0},
{"tlbwr",	"",		0x2000337f, 0xffffffff,		0,		0,	I38,		0,		0},
{"trunc.l.d",	"T,S",		0xa000633b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"trunc.l.s",	"T,S",		0xa000233b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"trunc.w.d",	"T,S",		0xa0006b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"trunc.w.s",	"T,S",		0xa0002b3b, 0xfc00ffff,	WR_1|RD_2,		0,	I38,	0,		0},
{"ualw",	"t,+j(s)",		0xa4000100, 0xfc007f00,	WR_1|RD_3,		0,	0,	XLP,		0},
{"uasw",	"t,+j(s)",		0xa4000900, 0xfc007f00,	RD_1|RD_3,		0,	0,	XLP,		0},
{"udi",	"m8",		0x20000003, 0xfc000007,		0,		0,	0,	UDI,		0},
{"wait",	"+M",		0x2000937f, 0xfc00ffff,		0,		0,	I38,		0,		0},
{"wrdsp",	"t,8",		0x2000167f, 0xfc003fff,		RD_1,		0,	0,	D32,		0},
{"wrpgpr",	"t,s",		0x2000f17f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,		0,		0},
{"wsbh",	"t,s",		0x20007b3f, 0xfc00ffff,	WR_1|RD_2,		0,	I38,		0,		0},
{"xor",	"md,mc",		0x5004,	0xfc0f,	WR_1|RD_2,		0,	I38,		0,		0}, /* XOR[16] */
{"xor",	"d,s,t",		0x20000310, 0xfc0007ff, WR_1|RD_2|RD_3,		0,	I38,		0,		0},
{"xori",	"t,s,i",		0x80001000, 0xfc00f000,	WR_1|RD_2,		0,	I38,		0,		0},
};

const int bfd_micromipspp_num_opcodes =
  ((sizeof micromipspp_opcodes) / (sizeof (micromipspp_opcodes[0])));
