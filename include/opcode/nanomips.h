/* nanomips.h.  nanoMIPS opcode list for GDB, the GNU debugger.
   Copyright (C) 2017 Free Software Foundation, Inc.
   Contributed by Imagination Technologies Ltd.

   This file is part of GDB, GAS, and the GNU binutils.

   GDB, GAS, and the GNU binutils are free software; you can redistribute
   them and/or modify them under the terms of the GNU General Public
   License as published by the Free Software Foundation; either version 3,
   or (at your option) any later version.

   GDB, GAS, and the GNU binutils are distributed in the hope that they
   will be useful, but WITHOUT ANY WARRANTY; without even the implied
   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
   the GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this file; see the file COPYING3.  If not, write to the Free
   Software Foundation, 51 Franklin Street - Fifth Floor, Boston,
   MA 02110-1301, USA.  */

#ifndef _NANOMIPS_H_
#define _NANOMIPS_H_

#include "bfd.h"

#define INSN_ISAN32R6             1
#define INSN_ISAN64R6             2

#define       ISA_NANOMIPS32R6	INSN_ISAN32R6
#define       ISA_NANOMIPS64R6	INSN_ISAN64R6

#define CPU_NANOMIPS32R6 32
#define CPU_NANOMIPS64R6 64

#define ISAF(X) (1 << (INSN_ISA##X - 1))

/* The same information in table form: bit INSN_ISA<X> - 1 of index
   INSN_UPTO<Y> - 1 is set if ISA Y includes ISA X.  */
static const unsigned int nanomips_isa_table[] = {
  ISAF(N32R6),
  ISAF(N32R6) | ISAF(N64R6)
};
#undef ISAF


/* Describes an operand that encapsulates a mapped register with
   a check against the previous operand.  */
struct nanomips_mapped_check_prev_operand
{
  struct mips_operand root;

  enum mips_reg_operand_type reg_type;
  const unsigned char *reg_map;

  bfd_boolean greater_than_ok;
  bfd_boolean less_than_ok;
  bfd_boolean equal_ok;
  bfd_boolean zero_ok;
};

/* Describes an operand that encapsulates a base register with
   a check against the type of offset.  */
struct nanomips_base_check_offset_operand
{
  struct mips_operand root;

  enum mips_reg_operand_type reg_type;

  bfd_boolean const_ok;
  bfd_boolean expr_ok;
};

/* This structure holds information for a particular instruction.  */

struct nanomips_opcode
{
  /* The name of the instruction.  */
  const char *name;
  /* An optional suffix.  */
  const char *suffix;
  /* A string describing the arguments for this instruction.  */
  const char *args;
  /* The basic opcode for the instruction.  When assembling, this
     opcode is modified by the arguments to produce the actual opcode
     that is used.  If pinfo is INSN_MACRO, then this is 0.  */
  unsigned long match;
  /* If pinfo is not INSN_MACRO, then this is a bit mask for the
     relevant portions of the opcode when disassembling.  If the
     actual opcode anded with the match field equals the opcode field,
     then we have found the correct instruction.  If pinfo is
     INSN_MACRO, then this field is the macro identifier.  */
  unsigned long mask;
  /* For a macro, this is INSN_MACRO.  Otherwise, it is a collection
     of bits describing the instruction, notably any relevant hazard
     information.  */
  unsigned long pinfo;
  /* A collection of additional bits describing the instruction. */
  unsigned long pinfo2;
  /* A collection of bits describing the instruction sets of which this
     instruction or macro is a member. */
  unsigned long membership;
  /* A collection of bits describing the ASE of which this instruction
     or macro is a member.  */
  unsigned long ase;
};

/* Return true if MO is an instruction that requires 32-bit encoding.  */

static inline bfd_boolean
nanomips_opcode_32bit_p (const struct nanomips_opcode *mo)
{
  return mo->mask >> 16 != 0;
}

static inline int
nanomips_operand_mask (const struct mips_operand *operand)
{
  unsigned int mask;

  mask = ((1 << operand->size_top) - 1) << operand->lsb_top;
  mask |= ((1 << (operand->size - operand->size_top)) - 1) << operand->lsb;
  return mask;
}

/* Return the UVAL encoding of REGNO as OPERAND.  */

static inline unsigned int
mips_encode_reg_operand (const struct mips_operand *operand,
			 int regno)
{
  unsigned int uval;
  const unsigned int num_vals = 1 << operand->size;
  const struct mips_reg_operand *reg_op
    = (const struct mips_reg_operand *) operand;

  for (uval = 0; uval < num_vals; uval++)
    if (reg_op->reg_map[uval] == regno)
      break;
  return uval;
}


/* Re-organize HI20 bits of OPERAND encoded as UVAL.  */

#define SIGNEX_VALUE(OP) {OP_INT, OP->size - 1, 0, 0, 0}

static inline int
mips_decode_hi20_operand (const struct mips_operand *operand,
			      unsigned int uval)
{
  const struct mips_operand op_ext = SIGNEX_VALUE (operand);
  const struct mips_operand op_shuffle = {OP_INT, 19, 10, 10, 0};
  unsigned int low19 = mips_extract_operand (&op_shuffle, uval);
  return mips_insert_operand (&op_ext, uval, low19);
}

/* Decode HI20 signed integer.  */

#define SIGNED_VALUE(OP) {OP_INT, OP->size, 0, 0, 0}

static inline int
mips_decode_hi20_int_operand (const struct mips_operand *operand,
			      unsigned int uval)
{
  const struct mips_operand op_enc = SIGNED_VALUE (operand);
  uval = mips_decode_hi20_operand (operand, uval);
  return (mips_signed_operand (&op_enc, uval));
}

/* Decode HI20 PCREL  */

#define PCREL_VALUE(OP) { { { OP_PCREL, OP->size, 0, 0, 0}, \
	(1 << (OP->size - 1)) - 1, 0, 0, FALSE}, 12, 0, 0}

static inline bfd_vma
mips_decode_hi20_pcrel_operand (const struct mips_operand *operand,
			   bfd_vma base_pc, unsigned int uval)
{
  const struct mips_pcrel_operand pcrel_op = PCREL_VALUE (operand);
  uval = mips_decode_hi20_operand (operand, uval);
  return mips_decode_pcrel_operand (&pcrel_op, base_pc, uval << 12);
}


/* Return true if MO is an instruction that requires 48-bit encoding.  */

static inline bfd_boolean
opcode_48bit_p (const struct nanomips_opcode *mo)
{
  return ((mo->mask >> 16 == 0)
	  && ((mo->match >> 10) == 0x18));
}

static inline bfd_boolean
nanomips_cpu_is_member (int cpu, unsigned int mask)
{
  switch (cpu)
    {
    case CPU_NANOMIPS32R6:
      return (mask & INSN_ISA_MASK) == INSN_ISAN32R6;

    case CPU_NANOMIPS64R6:
      return ((mask & INSN_ISA_MASK) == INSN_ISAN32R6)
	     || ((mask & INSN_ISA_MASK) == INSN_ISAN64R6);

    default:
      return FALSE;
    }
}

/* Test for membership in an ISA including chip specific ISAs.  INSN
   is pointer to an element of the opcode table; ISA is the specified
   ISA/ASE bitmask to test against; and CPU is the CPU specific ISA to
   test, or zero if no CPU specific ISA test is desired.  Return true
   if instruction INSN is available to the given ISA and CPU. */
static inline bfd_boolean
nanomips_opcode_is_member (const struct nanomips_opcode *insn,
			   int isa, int ase, int cpu)
{
  /* Test for ISA level compatibility.  */
  if ((isa & INSN_ISA_MASK) != 0
      && (insn->membership & INSN_ISA_MASK) != 0
      && ((nanomips_isa_table[(isa & INSN_ISA_MASK) - 1]
	   >> ((insn->membership & INSN_ISA_MASK) - 1)) & 1) != 0)
    return TRUE;

  /* Test for ASE compatibility.  */
  if (insn->ase != 0 && (ase & insn->ase) == insn->ase)
    return TRUE;

  /* Test for processor-specific extensions.  */
  if (nanomips_cpu_is_member (cpu, insn->membership))
    return TRUE;

  return FALSE;
}

enum
{
  M_BGEZAL = M_NUM_MACROS,
  M_BLTZAL,
  M_EXT,
  M_INS,
  M_MOD_I,
  M_MODU_I,
  M_DMOD_I,
  M_DMODU_I,
  M_DIV_I,
  M_DIVU_I,
  M_DDIV_I,
  M_DDIVU_I,
  M_NANOMIPS_NUM_MACROS
};

extern const struct mips_operand *decode_nanomips_operand (const char *);
extern const struct nanomips_opcode nanomips_opcodes[];
extern const int bfd_nanomips_num_opcodes;

#define INSN2_MACRO	    0x00080000

#endif /* _NANOMIPS_H_ */
