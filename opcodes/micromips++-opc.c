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
static unsigned char reg_29_map[] = { 29 };
static unsigned char reg_31_map[] = { 31 };
static unsigned char reg_m16_map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
static unsigned char reg_mn_map[] = { 0, 17, 2, 3, 16, 18, 19, 20 };
static unsigned char reg_q_map[] = { 0, 17, 2, 3, 4, 5, 6, 7 };

static unsigned char reg_h_map1[] = { 5, 5, 6, 4, 4, 4, 4, 4 };
static unsigned char reg_h_map2[] = { 6, 7, 7, 21, 22, 5, 6, 7 };

static int int_b_map[] = {
  1, 4, 8, 12, 16, 20, 24, -1
};
static int int_c_map[] = {
  128, 1, 2, 3, 4, 7, 8, 15, 16, 31, 32, 63, 64, 255, 32768, 65535
};

/* Return the mips_operand structure for the operand at the beginning of P.  */

const struct mips_operand *
decode_micromipspp_operand (const char *p)
{
  switch (p[0])
    {
    case 'm':
      switch (p[1])
	{
	case 'c': MAPPED_REG (3, 4, GP, reg_m16_map);
	case 'd': MAPPED_REG (3, 7, GP, reg_m16_map);
	case 'e': REG (5, 0, GP);
	case 'f': REG (5, 5, GP);
	case 'I': INT_ADJ (7, 0, 126, 0, FALSE); /* (-1 .. 126) */
	case 'M': INT_ADJ (3, 0, 8, 0, FALSE);   /* (1 .. 8) */
	case 'i': INT_ADJ (14, 0, 8, 0, FALSE);   /* (1 .. 8) */
	}
      break;
      case '+':
	switch (p[1])
	{
	  case 'd': REG (5, 11, GP);
	  case 's': REG (5, 16, GP);
	  case 't': REG (5, 21, GP);
	}
      break;
    }
  return 0;
}

#define UBD	INSN_UNCOND_BRANCH_DELAY
#define CBD	INSN_COND_BRANCH_DELAY
#define NODS	INSN_NO_DELAY_SLOT
#define TRAP	INSN_NO_DELAY_SLOT
#define LM	INSN_LOAD_MEMORY
#define SM	INSN_STORE_MEMORY
#define CM	INSN_COPROC_MOVE
#define LC	INSN_LOAD_COPROC
#define BD16	INSN2_BRANCH_DELAY_16BIT	/* Used in pinfo2.  */
#define BD32	INSN2_BRANCH_DELAY_32BIT	/* Used in pinfo2.  */

#define WR_1	INSN_WRITE_1
#define WR_2	INSN_WRITE_2
#define RD_1	INSN_READ_1
#define RD_2	INSN_READ_2
#define RD_3	INSN_READ_3
#define RD_4	INSN_READ_4
#define MOD_1	(WR_1|RD_1)
#define MOD_2	(WR_2|RD_2)

/* For 16-bit/32-bit microMIPS instructions.  They are used in pinfo2.  */
#define UBR	INSN2_UNCOND_BRANCH
#define CBR	INSN2_COND_BRANCH
#define RD_sp	INSN2_READ_SP
#define WR_sp	INSN2_WRITE_SP
#define RD_31	INSN2_READ_GPR_31
#define RD_pc	INSN2_READ_PC
#define CTC	INSN2_CONVERTED_TO_COMPACT
#define NNODS	INSN2_NEXT_NO_DS

/* For 32-bit microMIPS instructions.  */
#define WR_31	INSN_WRITE_GPR_31
#define WR_CC	INSN_WRITE_COND_CODE

#define RD_CC	INSN_READ_COND_CODE
#define RD_C0	INSN_COP
#define RD_C1	INSN_COP
#define RD_C2	INSN_COP
#define WR_C0	INSN_COP
#define WR_C1	INSN_COP
#define WR_C2	INSN_COP
#define CP	INSN_COP

#define WR_HI	INSN_WRITE_HI
#define RD_HI	INSN_READ_HI

#define WR_LO	INSN_WRITE_LO
#define RD_LO	INSN_READ_LO

#define WR_HILO	WR_HI|WR_LO
#define RD_HILO	RD_HI|RD_LO
#define MOD_HILO WR_HILO|RD_HILO

/* New base ISAs starting at revision 7. */
#define I38	INSN_ISA32R7
#define I70	INSN_ISA64R7

const struct mips_opcode micromipspp_opcodes[] =
{
/* These instructions appear first so that the disassembler will find
   them first.  The assemblers uses a hash table based on the
   instruction name anyhow.  */
/* name,		args,		match,      mask,	pinfo,			pinfo2,		membership,	ase,	exclusions */
{"li",			"md,mI",	    0xd000,     0xfc00,	WR_1,			0,		I38,		0,	0 },
{"sll",			"md,mc,mM",	    0x3000,     0xfc08,	WR_1|RD_2,		0,		I38,		0,	0 },
{"srl",			"md,mc,mM",	    0x3008,     0xfc08,	WR_1|RD_2,		0,		I38,		0,	0 },
/* {"addiur2",		"md,mc,mB",	    0x9000,     0xfc08,	WR_1|RD_2,		0,		I38,		0,	0 }, */
/* {"and",			"mf,mt,mg",	    0x5008,     0xfc0f,	MOD_1|RD_3,		0,		I38,		0,	0 }, */
/* {"not",			"mf,mg",	    0x5000,     0xfc0f,	WR_1|RD_2,		0,		I38,		0,	0 }, /\* put not before nor *\/ */
/* {"or",			"mf,mt,mg",	    0x500c,     0xfc0f,	MOD_1|RD_3,		0,		I38,		0,	0 }, */
/* {"xor",			"mf,mt,mg",	    0x5004,     0xfc0f,	MOD_1|RD_3,		0,		I38,		0,	0 }, */
{"move16",			"mf,me",         0xb000,     0xfc00,	WR_1|RD_2,			0,		I38,		0,	0 },
{"nop",			"",	    	    0xb000,     0xffff,	0,			0,		I38,		0,	0 },
{"addu",		"+d,+s,+t",	0x20000150, 0xfc0007ff,	WR_1|RD_2|RD_3,		0,		I38,		0,	0 },
};

const int bfd_micromipspp_num_opcodes =
  ((sizeof micromipspp_opcodes) / (sizeof (micromipspp_opcodes[0])));
