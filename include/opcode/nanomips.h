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

#ifdef __cplusplus
extern "C" {
#endif

/* Enumerates the various types of nanoMIPS operand.  */
enum nanomips_operand_type {
  /* Described by nanomips_int_operand.  */
  OP_INT,

  /* Described by nanomips_mapped_int_operand.  */
  OP_MAPPED_INT,

  /* Described by nanomips_msb_operand.  */
  OP_MSB,

  /* Described by nanomips_reg_operand.  */
  OP_REG,

  /* Like OP_REG, but can be omitted if the register is the same as the
     previous operand.  */
  OP_OPTIONAL_REG,

  /* Described by nanomips_reg_pair_operand.  */
  OP_REG_PAIR,

  /* Described by nanomips_pcrel_operand.  */
  OP_PCREL,

  /* The register list and frame size for a MIPS16 SAVE or RESTORE
     instruction.  */
  OP_SAVE_RESTORE_LIST,

  /* A register operand that must match the destination register.  */
  OP_REPEAT_DEST_REG,

  /* A register operand that must match the previous register.  */
  OP_REPEAT_PREV_REG,

  /* Described by nanomips_prev_operand.  */
  OP_CHECK_PREV,

  /* A register operand that must not be zero.  */
  OP_NON_ZERO_REG,

 /* The floating-point register list for a nanoMIPS SAVE or RESTORE
     instruction. */
  OP_SAVE_RESTORE_FP_LIST,

  /* Fractured upper immediate PC-offset for nanoMIPS */
  OP_HI20_PCREL,

  /* Fractured upper immediate 20-bit signed integer for nanoMIPS */
  OP_HI20_INT,

  /* Fractured upper immediate 20-bit scaled integer for nanoMIPS */
  OP_HI20_SCALE,

  /* A non-zero PC-relative offset.  */
  OP_NON_ZERO_PCREL_S1,

  /* To check a mapped register against a previous operand.  */
  OP_MAPPED_CHECK_PREV,

  /* Unsigned word operand.  */
  OP_UINT_WORD,

  /* Signed word operand.  */
  OP_INT_WORD,

  /* Immediate PC-relative word operand.  */
  OP_PC_WORD,

  /* Immediate GP-relative word operand.  */
  OP_GPREL_WORD,

  /* Don't care bits.  */
  OP_DONT_CARE,

  /* Immediate unsigned word operand, to be negated.  */
  OP_NEG_INT,

  /* Immediate (non-relocatable) integer operand.  */
  OP_IMM_INT,

  /* Immediate (non-relocatable) word operand.  */
  OP_IMM_WORD,

  /* Base register for limited types of offsets.  */
  OP_BASE_CHECK_OFFSET,

  /* Copy over bits from another part of instruction.  */
  OP_COPY_BITS,
};

/* Enumerates the types of nanoMIPS register.  */
enum nanomips_reg_operand_type {
  /* General registers $0-$31.  Software names like $at can also be used.  */
  OP_REG_GP,

  /* Floating-point registers $f0-$f31.  */
  OP_REG_FP,

  /* Coprocessor condition code registers $cc0-$cc7.  FPU condition codes
     can also be written $fcc0-$fcc7.  */
  OP_REG_CCC,

  /* FPRs used in a vector capacity.  They can be written $f0-$f31
     or $v0-$v31, although the latter form is not used for the VR5400
     vector instructions.  */
  OP_REG_VEC,

  /* DSP accumulator registers $ac0-$ac3.  */
  OP_REG_ACC,

  /* Coprocessor registers $0-$31.  Mnemonic names like c0_cause can
     also be used in some contexts.  */
  OP_REG_COPRO,

  /* Hardware registers $0-$31.  Mnemonic names like hwr_cpunum can
     also be used in some contexts.  */
  OP_REG_HW,

  /* Floating-point registers $vf0-$vf31.  */
  OP_REG_VF,

  /* Integer registers $vi0-$vi31.  */
  OP_REG_VI,

  /* MSA registers $w0-$w31.  */
  OP_REG_MSA,

  /* MSA control registers $0-$31.  */
  OP_REG_MSA_CTRL
};

/* Base class for all operands.  */
struct nanomips_operand
{
  /* The type of the operand.  */
  enum nanomips_operand_type type;

  /* The operand occupies SIZE bits of the instruction, starting at LSB.  */
  unsigned short size;
  unsigned short lsb;

  /* These are used to split a value across two different
     parts of the instruction encoding.  */
  unsigned int size_top;
  unsigned int lsb_top;
};

/* Describes an integer operand with a regular encoding pattern.  */
struct nanomips_int_operand
{
  struct nanomips_operand root;

  /* The low ROOT.SIZE bits of MAX_VAL encodes (MAX_VAL + BIAS) << SHIFT.
     The cyclically previous field value encodes 1 << SHIFT less than that,
     and so on.  E.g.

     - for { { T, 4, L }, 14, 0, 0 }, field values 0...14 encode themselves,
       but 15 encodes -1.

     - { { T, 8, L }, 127, 0, 2 } is a normal signed 8-bit operand that is
       shifted left two places.

     - { { T, 3, L }, 8, 0, 0 } is a normal unsigned 3-bit operand except
       that 0 encodes 8.

     - { { ... }, 0, 1, 3 } means that N encodes (N + 1) << 3.  */
  unsigned int max_val;
  int bias;
  unsigned int shift;

  /* True if the operand should be printed as hex rather than decimal.  */
  bfd_boolean print_hex;
};

/* Uses a lookup table to describe a small integer operand.  */
struct nanomips_mapped_int_operand
{
  struct nanomips_operand root;

  /* Maps each encoding value to the integer that it represents.  */
  const int *int_map;

  /* True if the operand should be printed as hex rather than decimal.  */
  bfd_boolean print_hex;
};

/* An operand that encodes the most significant bit position of a bitfield.
   Given a bitfield that spans bits [MSB, LSB], some operands of this type
   encode MSB directly while others encode MSB - LSB.  Each operand of this
   type is preceded by an integer operand that specifies LSB.

   The assembly form varies between instructions.  For some instructions,
   such as EXT, the operand is written as the bitfield size.  For others,
   such as EXTS, it is written in raw MSB - LSB form.  */
struct nanomips_msb_operand
{
  struct nanomips_operand root;

  /* The assembly-level operand encoded by a field value of 0.  */
  int bias;

  /* True if the operand encodes MSB directly, false if it encodes
     MSB - LSB.  */
  bfd_boolean add_lsb;

  /* The maximum value of MSB + 1.  */
  unsigned int opsize;
};

/* Describes a single register operand.  */
struct nanomips_reg_operand
{
  struct nanomips_operand root;

  /* The type of register.  */
  enum nanomips_reg_operand_type reg_type;

  /* If nonnull, REG_MAP[N] gives the register associated with encoding N,
     otherwise the encoding is the same as the register number.  */
  const unsigned char *reg_map;
};

/* Describes an operand that which must match a condition based on the
   previous operand.  */
struct nanomips_check_prev_operand
{
  struct nanomips_operand root;

  bfd_boolean greater_than_ok;
  bfd_boolean less_than_ok;
  bfd_boolean equal_ok;
  bfd_boolean zero_ok;
};

/* Describes an operand that encodes a pair of registers.  */
struct nanomips_reg_pair_operand
{
  struct nanomips_operand root;

  /* The type of register.  */
  enum nanomips_reg_operand_type reg_type;

  /* Encoding N represents REG1_MAP[N], REG2_MAP[N].  */
  unsigned char *reg1_map;
  unsigned char *reg2_map;
};

/* Describes an operand that is calculated relative to a base PC.
   The base PC is usually the address of the following instruction,
   but the rules for MIPS16 instructions like ADDIUPC are more complicated.  */
struct nanomips_pcrel_operand
{
  /* Encodes the offset.  */
  struct nanomips_int_operand root;

  /* The low ALIGN_LOG2 bits of the base PC are cleared to give PC',
     which is then added to the offset encoded by ROOT.  */
  unsigned int align_log2 : 8;

  /* If INCLUDE_ISA_BIT, the ISA bit of the original base PC is then
     reinstated.  This is true for jumps and branches and false for
     PC-relative data instructions.  */
  unsigned int include_isa_bit : 1;

  /* If FLIP_ISA_BIT, the ISA bit of the result is inverted.
     This is true for JALX and false otherwise.  */
  unsigned int flip_isa_bit : 1;
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

/* Return true if the assembly syntax allows OPERAND to be omitted.  */

static inline bfd_boolean
nanomips_optional_operand_p (const struct nanomips_operand *operand)
{
  return (operand->type == OP_OPTIONAL_REG
	  || operand->type == OP_REPEAT_PREV_REG
	  || (operand->type != OP_INT
	      && operand->size == 0
	      && operand->lsb == 0));
}

/* Return a version of INSN in which the field specified by OPERAND
   has value UVAL.  */

static inline unsigned int
nanomips_insert_operand (const struct nanomips_operand *operand,
			 unsigned int insn, unsigned int uval)
{
  unsigned int mask;
  unsigned int size_bottom = operand->size - operand->size_top;

  mask = (1 << size_bottom) - 1;
  insn &= ~(mask << operand->lsb);
  insn |= (uval & mask) << operand->lsb;

  mask = (1 << operand->size_top) - 1;
  insn &= ~(mask << operand->lsb_top);
  insn |= ((uval & (mask << size_bottom)) >> size_bottom) << operand->lsb_top;
  return insn;
}

/* Extract OPERAND from instruction INSN.  */

static inline unsigned int
nanomips_extract_operand (const struct nanomips_operand *operand,
			  unsigned int insn)
{
  unsigned int uval;
  unsigned int size_bottom = operand->size - operand->size_top;

  uval = (insn >> operand->lsb_top) & ((1 << operand->size_top) - 1);
  uval <<= size_bottom;
  uval |= (insn >> operand->lsb) & ((1 << size_bottom) - 1);
  return uval;
}

/* UVAL is the value encoded by OPERAND.  Return it in signed form.  */

static inline int
nanomips_signed_operand (const struct nanomips_operand *operand,
			 unsigned int uval)
{
  unsigned int sign_bit, mask;

  mask = (1 << operand->size) - 1;
  sign_bit = 1 << (operand->size - 1);
  return ((uval + sign_bit) & mask) - sign_bit;
}

/* Return the integer that OPERAND encodes as UVAL.  */

static inline int
nanomips_decode_int_operand (const struct nanomips_int_operand *operand,
			     unsigned int uval)
{
  uval |= (operand->max_val - uval) & -(1 << operand->root.size);
  uval += operand->bias;
  uval <<= operand->shift;
  return uval;
}

/* Return the maximum value that can be encoded by OPERAND.  */

static inline int
nanomips_int_operand_max (const struct nanomips_int_operand *operand)
{
  return (operand->max_val + operand->bias) << operand->shift;
}

/* Return the minimum value that can be encoded by OPERAND.  */

static inline int
nanomips_int_operand_min (const struct nanomips_int_operand *operand)
{
  unsigned int mask;

  mask = (1 << operand->root.size) - 1;
  return nanomips_int_operand_max (operand) - (mask << operand->shift);
}

/* Return the register that OPERAND encodes as UVAL.  */

static inline int
nanomips_decode_reg_operand (const struct nanomips_reg_operand *operand,
			     unsigned int uval)
{
  if (operand->reg_map)
    uval = operand->reg_map[uval];
  return uval;
}

/* PC-relative operand OPERAND has value UVAL and is relative to BASE_PC.
   Return the address that it encodes.  */

static inline bfd_vma
nanomips_decode_pcrel_operand (const struct nanomips_pcrel_operand *operand,
			       bfd_vma base_pc, unsigned int uval)
{
  bfd_vma addr;

  addr = base_pc & -(1 << operand->align_log2);
  addr += nanomips_decode_int_operand (&operand->root, uval);
  if (operand->include_isa_bit)
    addr |= base_pc & 1;
  if (operand->flip_isa_bit)
    addr ^= 1;
  return addr;
}

/* Describes an operand that encapsulates a mapped register with
   a check against the previous operand.  */
struct nanomips_mapped_check_prev_operand
{
  struct nanomips_operand root;

  enum nanomips_reg_operand_type reg_type;
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
  struct nanomips_operand root;

  enum nanomips_reg_operand_type reg_type;

  bfd_boolean const_ok;
  bfd_boolean expr_ok;
};

/* Return true if MO is an instruction that requires 32-bit encoding.  */

static inline bfd_boolean
nanomips_opcode_32bit_p (const struct nanomips_opcode *mo)
{
  return mo->mask >> 16 != 0;
}

static inline int
nanomips_operand_mask (const struct nanomips_operand *operand)
{
  unsigned int mask;

  mask = ((1 << operand->size_top) - 1) << operand->lsb_top;
  mask |= ((1 << (operand->size - operand->size_top)) - 1) << operand->lsb;
  return mask;
}

/* Return the UVAL encoding of REGNO as OPERAND.  */

static inline unsigned int
nanomips_encode_reg_operand (const struct nanomips_operand *operand,
			     int regno)
{
  unsigned int uval;
  const unsigned int num_vals = 1 << operand->size;
  const struct nanomips_reg_operand *reg_op
    = (const struct nanomips_reg_operand *) operand;

  for (uval = 0; uval < num_vals; uval++)
    if (reg_op->reg_map[uval] == regno)
      break;
  return uval;
}


/* Re-organize HI20 bits of OPERAND encoded as UVAL.  */

#define SIGNEX_VALUE(OP) {OP_INT, OP->size - 1, 0, 0, 0}

static inline int
nanomips_decode_hi20_operand (const struct nanomips_operand *operand,
			      unsigned int uval)
{
  const struct nanomips_operand op_ext = SIGNEX_VALUE (operand);
  const struct nanomips_operand op_shuffle = {OP_INT, 19, 10, 10, 0};
  unsigned int low19 = nanomips_extract_operand (&op_shuffle, uval);
  return nanomips_insert_operand (&op_ext, uval, low19);
}

/* Decode HI20 signed integer.  */

#define SIGNED_VALUE(OP) {OP_INT, OP->size, 0, 0, 0}

static inline int
nanomips_decode_hi20_int_operand (const struct nanomips_operand *operand,
				  unsigned int uval)
{
  const struct nanomips_operand op_enc = SIGNED_VALUE (operand);
  uval = nanomips_decode_hi20_operand (operand, uval);
  return (nanomips_signed_operand (&op_enc, uval));
}

/* Decode HI20 PCREL  */

#define PCREL_VALUE(OP) { { { OP_PCREL, OP->size, 0, 0, 0}, \
	(1 << (OP->size - 1)) - 1, 0, 0, FALSE}, 12, 0, 0}

static inline bfd_vma
nanomips_decode_hi20_pcrel_operand (const struct nanomips_operand *operand,
				    bfd_vma base_pc, unsigned int uval)
{
  const struct nanomips_pcrel_operand pcrel_op = PCREL_VALUE (operand);
  uval = nanomips_decode_hi20_operand (operand, uval);
  return nanomips_decode_pcrel_operand (&pcrel_op, base_pc, uval << 12);
}


/* Return true if MO is an instruction that requires 48-bit encoding.  */

static inline bfd_boolean
opcode_48bit_p (const struct nanomips_opcode *mo)
{
  return ((mo->mask >> 16 == 0)
	  && ((mo->match >> 10) == 0x18));
}

/* These are the bits which may be set in the pinfo field of an
   instructions, if it is not equal to INSN_MACRO.  */

/* Writes to operand number N.  */
#define INSN_WRITE_SHIFT            0
#define INSN_WRITE_1                0x00000001
#define INSN_WRITE_2                0x00000002
#define INSN_WRITE_ALL              0x00000003
/* Reads from operand number N.  */
#define INSN_READ_SHIFT             2
#define INSN_READ_1                 0x00000004
#define INSN_READ_2                 0x00000008
#define INSN_READ_3                 0x00000010
#define INSN_READ_4                 0x00000020
#define INSN_READ_ALL               0x0000003c
/* Modifies general purpose register 31.  */
#define INSN_WRITE_GPR_31           0x00000040
/* Modifies coprocessor condition code.  */
#define INSN_WRITE_COND_CODE        0x00000080
/* Reads coprocessor condition code.  */
#define INSN_READ_COND_CODE         0x00000100
/* TLB operation.  */
#define INSN_TLB                    0x00000200
/* Reads coprocessor register other than floating point register.  */
#define INSN_COP                    0x00000400
/* Instruction loads value from memory.  */
#define INSN_LOAD_MEMORY	    0x00000800
/* Instruction loads value from coprocessor, (may require delay).  */
#define INSN_LOAD_COPROC	    0x00001000
/* Instruction has unconditional branch delay slot.  */
#define INSN_UNCOND_BRANCH_DELAY    0x00002000
/* Instruction has conditional branch delay slot.  */
#define INSN_COND_BRANCH_DELAY      0x00004000
/* Conditional branch likely: if branch not taken, insn nullified.  */
#define INSN_COND_BRANCH_LIKELY	    0x00008000
/* Moves to coprocessor register, (may require delay).  */
#define INSN_COPROC_MOVE            0x00010000
/* Loads coprocessor register from memory, requiring delay.  */
#define INSN_COPROC_MEMORY_DELAY    0x00020000
/* Reads the HI register.  */
#define INSN_READ_HI		    0x00040000
/* Reads the LO register.  */
#define INSN_READ_LO		    0x00080000
/* Modifies the HI register.  */
#define INSN_WRITE_HI		    0x00100000
/* Modifies the LO register.  */
#define INSN_WRITE_LO		    0x00200000
/* Not to be placed in a branch delay slot, either architecturally
   or for ease of handling (such as with instructions that take a trap).  */
#define INSN_NO_DELAY_SLOT	    0x00400000
/* Instruction stores value into memory.  */
#define INSN_STORE_MEMORY	    0x00800000
/* Instruction uses single precision floating point.  */
#define FP_S			    0x01000000
/* Instruction uses double precision floating point.  */
#define FP_D			    0x02000000
/* A user-defined instruction.  */
#define INSN_UDI                    0x20000000
/* Instruction is actually a macro.  It should be ignored by the
   disassembler, and requires special treatment by the assembler.  */
#define INSN_MACRO                  0xffffffff

/* These are the bits which may be set in the pinfo2 field of an
   instruction. */

/* Instruction is a simple alias (I.E. "move" for daddu/addu/or) */
#define	INSN2_ALIAS		    0x00000001
/* Macro uses single-precision floating-point instructions.  This should
   only be set for macros.  For instructions, FP_S in pinfo carries the
   same information.  */
#define INSN2_M_FP_S		    0x00000008
/* Macro uses double-precision floating-point instructions.  This should
   only be set for macros.  For instructions, FP_D in pinfo carries the
   same information.  */
#define INSN2_M_FP_D		    0x00000010
/* Writes to the stack pointer ($29).  */
#define INSN2_WRITE_SP		    0x00000080
/* Reads from the stack pointer ($29).  */
#define INSN2_READ_SP		    0x00000100
/* Reads the RA ($31) register.  */
#define INSN2_READ_GPR_31	    0x00000200
/* Reads the program counter ($pc).  */
#define INSN2_READ_PC		    0x00000400
/* Is an unconditional branch insn. */
#define INSN2_UNCOND_BRANCH	    0x00000800
/* Is a conditional branch insn. */
#define INSN2_COND_BRANCH	    0x00001000
/* Instruction has a forbidden slot.  */
#define INSN2_FORBIDDEN_SLOT        0x00008000
/* Opcode table entry is for a short MIPS16 form only.  An extended
   encoding may still exist, but with a separate opcode table entry
   required.  In disassembly the presence of this flag in an otherwise
   successful match against an extended instruction encoding inhibits
   matching against any subsequent short table entry even if it does
   not have this flag set.  A table entry matching the full extended
   encoding is needed or otherwise the final EXTEND entry will apply,
   for the disassembly of the prefix only.  */
#define INSN2_SHORT_ONLY	    0x00010000
/* This indicates delayed branch converted to compact branch.  */
#define INSN2_CONVERTED_TO_COMPACT  0x00020000
/* Marks the LI macro expansion as special, temporary.  */
#define INSN2_MACRO	    0x00080000


/* Masks used to mark instructions to indicate which MIPS ISA level
   they were introduced in.  INSN_ISA_MASK masks an enumeration that
   specifies the base ISA level(s).  The remainder of a 32-bit
   word constructed using these macros is a bitmask of the remaining
   INSN_* values below.  */

#define INSN_ISA_MASK		  0x0000001ful


/* We cannot start at zero due to ISA_UNKNOWN below.  */
#define INSN_ISAN32R6   1
#define INSN_ISAN64R6	2

#define ISA_UNKNOWN	0               /* Gas internal use.  */

#define ISA_NANOMIPS32R6	INSN_ISAN32R6
#define ISA_NANOMIPS64R6	INSN_ISAN64R6

/* CPU defines, use instead of hardcoding processor number. Keep this
   in sync with bfd/archures.c in order for machine selection to work.  */
#define CPU_UNKNOWN	0               /* Gas internal use.  */

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

/* DSP ASE */
#define ASE_DSP			0x00000001
#define ASE_DSP64		0x00000002
/* DSP R2 ASE  */
#define ASE_DSPR2		0x00000004
/* Enhanced VA Scheme */
#define ASE_EVA			0x00000008
/* MCU (MicroController) ASE */
#define ASE_MCU			0x00000010
/* MT ASE */
#define ASE_MT			0x00000080
/* SmartMIPS ASE  */
#define ASE_SMARTMIPS		0x00000100
/* Virtualization ASE */
#define ASE_VIRT		0x00000200
#define ASE_VIRT64		0x00000400
/* MSA Extension  */
#define ASE_MSA			0x00000800
#define ASE_MSA64		0x00001000
/* eXtended Physical Address (XPA) Extension.  */
#define ASE_XPA			0x00002000
/* DSP R3 Module.  */
#define ASE_DSPR3		0x00004000
/* MIPS16e2 ASE.  */
#define ASE_MIPS16E2		0x00008000
/* MIPS16e2 MT ASE instructions.  */
#define ASE_MIPS16E2_MT		0x00010000
/* The Virtualization ASE has eXtended Physical Addressing (XPA)
   instructions which are only valid when both ASEs are enabled.  */
#define ASE_XPA_VIRT		0x00020000
/* The Enhanced VA Scheme (EVA) extension has instructions which are
   only valid for the R6 ISA.  */
#define ASE_EVA_R6		0x00040000
/* Cyclic redundancy check (CRC) ASE */
#define ASE_CRC			0x00100000
#define ASE_CRC64		0x00200000
/* Crypto ASE */
#define ASE_CRYPTO		0x00400000
/* Global INValidate Extension. */
#define ASE_GINV		0x00800000
/* The Virtualization ASE has Global INValidate extension instructions
   which are only valid when both ASEs are enabled. */
#define ASE_GINV_VIRT		0x01000000
/* Low Power instructions on nanoMIPS.  */
#define ASE_xNMS		0x02000000
/* TLB control instructions on nanoMIPS.  */
#define ASE_TLB			0x04000000

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

/* This is a list of macro expanded instructions.

   _I appended means immediate
   _A appended means target address of a jump
   _AB appended means address with (possibly zero) base register
   _D appended means 64 bit floating point constant
   _S appended means 32 bit floating point constant.  */

enum
{
  M_ABS,
  M_ACLR_AB,
  M_ADD_I,
  M_ADDU_I,
  M_AND_I,
  M_ASET_AB,
  M_BEQ,
  M_BEQ_I,
  M_BGE,
  M_BGE_I,
  M_BGEU,
  M_BGEU_I,
  M_BGEZ,
  M_BGT,
  M_BGT_I,
  M_BGTU,
  M_BGTU_I,
  M_BGTZ,
  M_BLE,
  M_BLE_I,
  M_BLEU,
  M_BLEU_I,
  M_BLEZ,
  M_BLT,
  M_BLT_I,
  M_BLTU,
  M_BLTU_I,
  M_BLTZ,
  M_BNE,
  M_BNE_I,
  M_CACHE_AB,
  M_CACHEE_AB,
  M_DABS,
  M_DADD_I,
  M_DADDU_I,
  M_DLA_AB,
  M_DLI,
  M_DMUL,
  M_DMUL_I,
  M_DSUB_I,
  M_DSUBU_I,
  M_J_A,
  M_JAL_A,
  M_JRADDIUSP,
  M_LA_AB,
  M_LB_AB,
  M_LBE_AB,
  M_LBU_AB,
  M_LBUE_AB,
  M_LD_AB,
  M_LDC1_AB,
  M_LDC2_AB,
  M_LDM_AB,
  M_LH_AB,
  M_LHE_AB,
  M_LHU_AB,
  M_LHUE_AB,
  M_LI,
  M_LI_D,
  M_LI_DD,
  M_LI_S,
  M_LI_SS,
  M_LL_AB,
  M_LLD_AB,
  M_LLE_AB,
  M_LW_AB,
  M_LWE_AB,
  M_LWC1_AB,
  M_LWC2_AB,
  M_LWM_AB,
  M_LWU_AB,
  M_MUL,
  M_MUL_I,
  M_NOR_I,
  M_OR_I,
  M_PREF_AB,
  M_PREFE_AB,
  M_REM_3I,
  M_DROL,
  M_ROL,
  M_DROL_I,
  M_ROL_I,
  M_ROR_I,
  M_SC_AB,
  M_SCD_AB,
  M_SCE_AB,
  M_SD_AB,
  M_SDC1_AB,
  M_SDC2_AB,
  M_SDM_AB,
  M_SEQ,
  M_SEQ_I,
  M_SGE,
  M_SGE_I,
  M_SGEU,
  M_SGEU_I,
  M_SGT,
  M_SGT_I,
  M_SGTU,
  M_SGTU_I,
  M_SLE,
  M_SLE_I,
  M_SLEU,
  M_SLEU_I,
  M_SLT_I,
  M_SLTU_I,
  M_SNE,
  M_SNE_I,
  M_SB_AB,
  M_SBE_AB,
  M_SH_AB,
  M_SHE_AB,
  M_SW_AB,
  M_SWE_AB,
  M_SWC1_AB,
  M_SWC2_AB,
  M_SWM_AB,
  M_SUB_I,
  M_SUBU_I,
  M_TEQ_I,
  M_TNE_I,
  M_ULD_AB,
  M_ULH_AB,
  M_ULHU_AB,
  M_ULW_AB,
  M_USH_AB,
  M_USW_AB,
  M_USD_AB,
  M_XOR_I,
  M_BGEZAL,
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

extern const struct nanomips_operand *decode_nanomips_operand (const char *);
extern const struct nanomips_opcode nanomips_opcodes[];
extern const int bfd_nanomips_num_opcodes;

/* These are the bit masks and shift counts used for the different fields
   in the microMIPS instruction formats.  No masks are provided for the
   fixed portions of an instruction, since they are not needed.  */

#define NANOMIPSOP_MASK_RS		0x1f
#define NANOMIPSOP_SH_RS		16
#define NANOMIPSOP_MASK_RT		0x1f
#define NANOMIPSOP_SH_RT		21
#define NANOMIPSOP_SH_MC		4
#define NANOMIPSOP_SH_MD		7
#define NANOMIPSOP_SH_MP		5
#define NANOMIPSOP_SH_MQ		7

#ifdef __cplusplus
}
#endif

#endif /* _NANOMIPS_H_ */
