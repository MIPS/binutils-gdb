/* tc-nanomips.c -- assemble code for a nanoMIPS chip.
   Copyright (C) 2018 Free Software Foundation, Inc.
   Contributed by MIPS Tech LLC.
   Written by Faraz Shahbazker <faraz.shahbazker@mips.com>

   This file is part of GAS.

   GAS is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   GAS is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GAS; see the file COPYING.  If not, write to the Free
   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
   02110-1301, USA.  */

#include "as.h"
#include "config.h"
#include "subsegs.h"
#include "safe-ctype.h"

#include "opcode/nanomips.h"
#include "dwarf2dbg.h"
#include "dw2gencfi.h"

/* Check assumptions made in this file.  */
typedef char static_assert1[sizeof (offsetT) < 8 ? -1 : 1];
typedef char static_assert2[sizeof (valueT) < 8 ? -1 : 1];

#ifdef DEBUG
#define DBG(x) printf x
#else
#define DBG(x)
#endif

#define streq(a, b)           (strcmp (a, b) == 0)

#define SKIP_SPACE_TABS(S) \
  do { while (*(S) == ' ' || *(S) == '\t') ++(S); } while (0)

/* Clean up namespace so we can include obj-elf.h too.  */
static int nanomips_output_flavor (void);
static int
nanomips_output_flavor (void)
{
  return OUTPUT_FLAVOR;
}

#undef OBJ_PROCESS_STAB
#undef OUTPUT_FLAVOR
#undef S_GET_ALIGN
#undef S_GET_SIZE
#undef S_SET_ALIGN
#undef S_SET_SIZE
#undef obj_frob_file
#undef obj_frob_file_after_relocs
#undef obj_frob_symbol
#undef obj_pop_insert
#undef obj_sec_sym_ok_for_reloc
#undef OBJ_COPY_SYMBOL_ATTRIBUTES

#include "obj-elf.h"
/* Fix any of them that we actually care about.  */
#undef OUTPUT_FLAVOR
#define OUTPUT_FLAVOR nanomips_output_flavor()

#include "elf/mips-common.h"
#include "elf/nanomips.h"

#ifndef ECOFF_DEBUGGING
#define NO_ECOFF_DEBUGGING
#define ECOFF_DEBUGGING 0
#endif

#include "ecoff.h"

static char *nanomips_flags_frag;

#define ZERO 0
#define ATREG 1
#define S0  16
#define S7  23
#define PIC_CALL_REG 25
#define KT0 26
#define KT1 27
#define GP  28
#define SP  29
#define FP  30
#define RA  31

#define ILLEGAL_REG (32)

#define AT  nanomips_opts.at

extern int target_big_endian;

/* The name of the readonly data section.  */
#define RDATA_SECTION_NAME ".rodata"

/* Information about an instruction, including its format, operands
   and fixups.  */
struct nanomips_cl_insn
{
  /* The opcode's entry in nanomips_opcodes.  */
  const struct nanomips_opcode *insn_mo;

  /* The 16-bit or 32-bit bitstring of the instruction itself.  This is
     a copy of INSN_MO->match with the operands filled in.  */
  unsigned long insn_opcode;

  /* The lower 32-bits of a 48-bit instruction. */
  unsigned long insn_opcode_ext;

  /* The frag that contains the instruction.  */
  struct frag *frag;

  /* The offset into FRAG of the first instruction byte.  */
  long where;

  /* The relocs associated with the instruction, if any.  */
  fixS *fixp[3];

  /* True if this entry cannot be moved from its current position.  */
  unsigned int fixed_p:1;

  /* True if this instruction occurred in a .set noreorder block.  */
  unsigned int noreorder_p:1;

  /* True if this instruction is complete.  */
  unsigned int complete_p:1;

};

/* The ABI to use.  */
enum nanomips_abi_level
{
  NO_ABI = 0,
  P32_ABI,
  P64_ABI,
};

/* The ABI to use.  */
enum mc_model_type
{
  MC_AUTO = 0,
  MC_MEDIUM,
  MC_LARGE,
};

/* nanoMIPS ABI we are using for this output file.  */
static enum nanomips_abi_level nanomips_abi = NO_ABI;

/* nanoMIPS PIC level.  */

enum nanomips_pic_level
{
  /* Do not generate PIC code.  */
  NO_PIC,

  /* Generate medium model PIC code as in the nanoMIPS ABI.  */
  SVR4_PIC,

  /* Generate large model PIC code as in the nanoMIPS ABI.  */
  SVR4_LARGE_PIC,
};

/* This is the set of options which may be modified by the .set
   pseudo-op.  We use a struct so that .set push and .set pop are more
   reliable.  */

struct nanomips_set_options
{
  /* nanoMIPS ISA (Instruction Set Architecture) level.  This is set to -1
     if it has not been initialized.  */
  int isa;
  /* Enabled Application Specific Extensions (ASEs).  Changed by `.set
     <asename>', by command line options, and based on the default
     architecture.  */
  int ase;
  /* Non-zero if we should not reorder instructions.  Changed by `.set
     reorder' and `.set noreorder'.  */
  int noreorder;
  /* Non-zero if we should not permit the register designated "assembler
     temporary" to be used in instructions.  The value is the register
     number, normally $at ($1).  Changed by `.set at=REG', `.set noat'
     (same as `.set at=$0') and `.set at' (same as `.set at=$1').  */
  unsigned int at;
  /* Non-zero if we should warn when a macro instruction expands into
     more than one machine instruction.  Changed by `.set nomacro' and
     `.set macro'.  */
  int nomacro;
  /* True if we should only emit 32-bit nanoMIPS instructions.
     Changed by `.set insn32' and `.set noinsn32', and the -minsn32
     and -mno-insn32 command line options.  */
  bfd_boolean insn32;
  /* Restrict general purpose registers and floating point registers
     to 32 bit.  This is initially determined when -mgp32 or -mfp32
     is passed but can changed.  */
  int gp;
  int fp;
  /* nanoMIPS architecture (CPU) type.  Changed by .set arch=FOO, the -march
     command line option, and the default CPU.  */
  int arch;
  /* True if floating-point operations are not allowed.  Changed by .set
     softfloat or .set hardfloat, by command line options -msoft-float or
     -mhard-float.  The default is false.  */
  bfd_boolean soft_float;

  /* True if only single-precision floating-point operations are allowed.
     Changed by .set singlefloat or .set doublefloat, command-line options
     -msingle-float or -mdouble-float.  The default is false.  */
  bfd_boolean single_float;

  /* The set of ASEs that should be enabled for the user specified
     architecture.  This cannot be inferred from 'arch' for all cores
     as processors only have a unique 'arch' if they add architecture
     specific instructions (UDI).  */
  int init_ase;

  /* Enable/disable balc stub optimization.  */
  bfd_boolean no_balc_stubs;

  /* Enable/disable register names, only for nanoMIPS.  */
  bfd_boolean legacyregs;

  /* Enable/disable PC-relative expansion.  */
  bfd_boolean pcrel;

  /* Enable/disable Position Independent data.  */
  bfd_boolean pid;

  /* Select PIC code.  */
  enum nanomips_pic_level pic;

  /* Code/data memory model.  */
  enum mc_model_type mc_model;

  /* Enable/disable linker relaxation.  */
  bfd_boolean linkrelax;

  /* Enable/disable resolution of link-invariable PC-relative fix-ups.  */
  bfd_boolean minimize_relocs;
};

/* Specifies whether module level options have been checked yet.  */
static bfd_boolean file_nanomips_opts_checked = FALSE;

/* This is the struct we use to hold the module level set of options.
   Note that we must set the isa field to ISA_UNKNOWN and the ASE, gp and
   fp fields to -1 to indicate that they have not been initialized.  */

static struct nanomips_set_options file_nanomips_opts = {
  /* isa */ ISA_UNKNOWN, /* ase */ 0, /* noreorder */ 0, /* at */ ATREG,
  /* nomacro */ 0, /* insn32 */ FALSE, /* gp */ -1, /* fp */ -1,
  /* arch */ CPU_UNKNOWN,  /* soft_float */ FALSE, /* single_float */ FALSE,
  /* init_ase */ 0, /* no_balc_stubs */ TRUE, /* legacyregs */ FALSE,
  /* pcrel */ FALSE, /* pid */ FALSE, /* pic */ NO_PIC,
  /* mc_model */ MC_AUTO, /* linkrelax */ FALSE, /* minimize_relocs */ FALSE
};

/* This is similar to file_nanomips_opts, but for the current set of options.  */

static struct nanomips_set_options nanomips_opts = {
  /* isa */ ISA_UNKNOWN, /* ase */ 0, /* noreorder */ 0, /* at */ ATREG,
  /* nomacro */ 0, /* insn32 */ FALSE, /* gp */ -1, /* fp */ -1,
  /* arch */ CPU_UNKNOWN, /* soft_float */ FALSE, /* single_float */ FALSE,
  /* init_ase */ 0, /* no_balc_stubs */ TRUE, /* legacyregs */ FALSE,
  /* pcrel */ FALSE, /* pid */ FALSE, /* pic */ NO_PIC,
  /* mc_model */ MC_AUTO, /* linkrelax */ FALSE, /* minimize_relocs */ FALSE
};

/* Which bits of file_ase were explicitly set or cleared by ASE options.  */
static unsigned int file_ase_explicit;

/* The argument of the -march= flag.  The architecture we are assembling.  */
static const char *nanomips_arch_string;

/* The argument of the -mtune= flag.  The architecture for which we
   are optimizing.  */
static int nanomips_tune = CPU_UNKNOWN;
static const char *nanomips_tune_string;

/* True when generating 32-bit code for a 64-bit processor.  */
static int nanomips_32bitmode = 0;

/* True if the given ABI requires 32-bit registers.  */
#define ABI_NEEDS_32BIT_REGS(ABI) ((ABI) == P32_ABI)

/* Likewise 64-bit registers.  */
#define ABI_NEEDS_64BIT_REGS(ABI) ((ABI) == P64_ABI)

#define ISA_IS_NANOMIPS(ISA)		\
  (((ISA) == ISA_NANOMIPS32R6		\
    || (ISA) == ISA_NANOMIPS64R6))

/*  Return true if ISA supports 64 bit wide gp registers.  */
#define ISA_HAS_64BIT_REGS(ISA) ((ISA) == ISA_NANOMIPS64R6)

#define GPR_SIZE nanomips_opts.gp

#define HAVE_64BIT_OBJECTS (nanomips_abi == P64_ABI)

/* The ABI-derived address size.  */
#define HAVE_64BIT_ADDRESSES (GPR_SIZE == 64 && nanomips_abi == P64_ABI)
#define HAVE_32BIT_ADDRESSES (!HAVE_64BIT_ADDRESSES)

/* The size of symbolic constants (i.e., expressions of the form
   "SYMBOL" or "SYMBOL + OFFSET").  */
#define HAVE_32BIT_SYMBOLS \
  (HAVE_32BIT_ADDRESSES || !HAVE_64BIT_OBJECTS)
#define HAVE_64BIT_SYMBOLS (!HAVE_32BIT_SYMBOLS)

/* Maximum symbol offset that can be encoded in a BFD_RELOC_GPREL16
   relocation.  */
#define MAX_GPREL_OFFSET (0x1fffc)

/* Addresses are loaded in different ways, depending on the address size
   in use.  The n32 ABI Documentation also mandates the use of additions
   with overflow checking, but existing implementations don't follow it.  */
#define ADDRESS_ADD_INSN						\
   (HAVE_32BIT_ADDRESSES ? "addu" : "daddu")

#define ADDRESS_ADDI_INSN						\
   (HAVE_32BIT_ADDRESSES ? "addiu" : "daddiu")

#define ADDRESS_LOAD_INSN						\
   (HAVE_32BIT_ADDRESSES ? "lw" : "ld")

#define ADDRESS_STORE_INSN						\
   (HAVE_32BIT_ADDRESSES ? "sw" : "sd")

/* The minimum and maximum signed values that can be stored in a GPR.  */
#define GPR_SMAX ((offsetT) (((valueT) 1 << (GPR_SIZE - 1)) - 1))
#define GPR_SMIN (-GPR_SMAX - 1)

/* 1 if trap instructions should used for overflow rather than break
   instructions.  */
static int nanomips_trap = 0;

/* 1 if double width floating point constants should not be constructed
   by assembling two single width halves into two single width floating
   point registers which just happen to alias the double width destination
   register.  On some architectures this aliasing can be disabled by a bit
   in the status register, and the setting of this bit cannot be determined
   automatically at assemble time.  */
static int nanomips_disable_float_construction;

/* Non-zero if .set [no]relax directive was used */
static bfd_boolean toggle_linkrelax_p = FALSE;

/* The size of objects in the small data section.  */
static unsigned int g_switch_value = 8;
/* Whether the -G option was used.  */
static int g_switch_seen = 0;

/* If we can determine in advance that GP optimization won't be
   possible, we can skip the relaxation stuff that tries to produce
   GP-relative references.

   This function can only provide a guess, but it seems to work for
   gcc output.  It needs to guess right for gcc, otherwise gcc
   will put what it thinks is a GP-relative instruction in a branch
   delay slot.  */
static int nopic_need_relax (symbolS *, int);

/* handle of the OPCODE hash table */
static struct hash_control *op_hash = NULL;

/* The opcode hash table we use for the nanoMIPS ASE.  */
static struct hash_control *nanomips_op_hash = NULL;

/* This array holds the chars that always start a comment.  If the
    pre-processor is disabled, these aren't very useful */
const char comment_chars[] = "#";

/* This array holds the chars that only start a comment at the beginning of
   a line.  If the line seems to have the form '# 123 filename'
   .line and .file directives will appear in the pre-processed output */
/* Note that input_file.c hand checks for '#' at the beginning of the
   first line of the input file.  This is because the compiler outputs
   #NO_APP at the beginning of its output.  */
/* Also note that C style comments are always supported.  */
const char line_comment_chars[] = "#";

/* This array holds machine specific line separator characters.  */
const char line_separator_chars[] = ";";

/* Chars that can be used to separate mant from exp in floating point nums */
const char EXP_CHARS[] = "eE";

/* Chars that mean this number is a floating point constant */
/* As in 0f12.456 */
/* or    0d1.2345e12 */
const char FLT_CHARS[] = "rRsSfFdDxXpP";

/* Also be aware that MAXIMUM_NUMBER_OF_CHARS_FOR_FLOAT may have to be
   changed in read.c .  Ideally it shouldn't have to know about it at all,
   but nothing is ideal around here.
 */

/* Types of printf format used for instruction-related error messages.
   "I" means int ("%d") and "S" means string ("%s"). */
enum nanomips_insn_error_format
{
  ERR_FMT_PLAIN,
  ERR_FMT_I,
  ERR_FMT_SS,
  ERR_FMT_SI,
};

/* Information about an error that was found while assembling the current
   instruction.  */
struct nanomips_insn_error
{
  /* We sometimes need to match an instruction against more than one
     opcode table entry.  Errors found during this matching are reported
     against a particular syntactic argument rather than against the
     instruction as a whole.  We grade these messages so that errors
     against argument N have a greater priority than an error against
     any argument < N, since the former implies that arguments up to N
     were acceptable and that the opcode entry was therefore a closer match.
     If several matches report an error against the same argument,
     we only use that error if it is the same in all cases.

     min_argnum is the minimum argument number for which an error message
     should be accepted.  It is 0 if MSG is against the instruction as
     a whole.  */
  int min_argnum;

  /* The printf()-style message, including its format and arguments.  */
  enum nanomips_insn_error_format format;
  const char *msg;
  union
  {
    int i;
    const char *ss[2];
    struct
    {
      const char *s1;
      int u1;
    } si;
  } u;
};

/* The error that should be reported for the current instruction.  */
static struct nanomips_insn_error insn_error;

static int auto_align = 1;

static int nanomips_gp_register = GP;

/* Debugging level.  -g sets this to 2.  -gN sets this to N.  -g0 is
   equivalent to seeing no -g option at all.  */
static int nanomips_debug = 0;

/* The maximum number of NOPs needed for any purpose.  */
#define MAX_NOPS 0

/* A list of previous instructions, with index 0 being the most recent.
   We need to look back MAX_NOPS instructions when filling delay slots
   or working around processor errata.  We need to look back one
   instruction further if we're thinking about using history[0] to
   fill a branch delay slot.  */
static struct nanomips_cl_insn history[1 + MAX_NOPS];

/* Arrays of operands for each instruction.  */
#define MAX_OPERANDS 6
struct nanomips_operand_array
{
  const struct nanomips_operand *operand[MAX_OPERANDS];
};
static struct nanomips_operand_array *nanomips_operands;

/* Nop instructions used by emit_nop.  */
static struct nanomips_cl_insn nanomips_nop16_insn;
static struct nanomips_cl_insn nanomips_nop32_insn;

/* The appropriate nop for the current mode.  */
#define NOP_INSN (nanomips_opts.insn32		\
		  ? &nanomips_nop32_insn	\
		  : &nanomips_nop16_insn)

/* The size of NOP_INSN in bytes.  */
#define NOP_INSN_SIZE (nanomips_opts.insn32? 4 : 2)

/* If this is set, it points to a frag holding nop instructions which
   were inserted before the start of a noreorder section.  If those
   nops turn out to be unnecessary, the size of the frag can be
   decreased.  */
static fragS *prev_nop_frag;

/* The frag containing the last explicit relocation operator.
   Null if explicit relocations have not been used.  */

static fragS *prev_reloc_op_frag;

/* Map 3-bit register numbers to normal nanoMIPS register numbers.  */

static const unsigned int nanomips_to_32_reg_d_map[] = {
  16, 17, 18, 19, 4, 5, 6, 7
};

/* Flag to enable RC1-style MTTGPR format.  */
static bfd_boolean nanomips_mttgpr_rc1 = FALSE;


/* The expansion of many macros depends on the type of symbol that
   they refer to.  For example, when generating position-dependent code,
   a macro that refers to a symbol may have two different expansions,
   one which uses GP-relative addresses and one which uses absolute
   addresses.  When generating SVR4-style PIC, a macro may have
   different expansions for local and global symbols.

   We handle these situations by generating both sequences and putting
   them in variant frags.  In position-dependent code, the first sequence
   will be the GP-relative one and the second sequence will be the
   absolute one.  In SVR4 PIC, the first sequence will be for global
   symbols and the second will be for local symbols.

   The frag's "subtype" is RELAX_ENCODE (FIRST, SECOND), where FIRST and
   SECOND are the lengths of the two sequences in bytes.  These fields
   can be extracted using RELAX_FIRST() and RELAX_SECOND().  In addition,
   the subtype has the following flags:

   RELAX_USE_SECOND
	Set if it has been decided that we should use the second
	sequence instead of the first.

   RELAX_SECOND_LONGER
	Set in the first variant frag if the macro's second implementation
	is longer than its first.  This refers to the macro as a whole,
	not an individual relaxation.

   RELAX_NOMACRO
	Set in the first variant frag if the macro appeared in a .set nomacro
	block and if one alternative requires a warning but the other does not.

   The frag's "opcode" points to the first fixup for relaxable code.

   Relaxable macros are generated using a sequence such as:

      relax_start (SYMBOL);
      ... generate first expansion ...
      relax_switch ();
      ... generate second expansion ...
      relax_end ();

   The code and fixups for the unwanted alternative are discarded
   by md_convert_frag.  */
#define RELAX_ENCODE(FIRST, SECOND) (((FIRST) << 8) | (SECOND))

#define RELAX_FIRST(X) (((X) >> 8) & 0xff)
#define RELAX_SECOND(X) ((X) & 0xff)
#define RELAX_USE_SECOND 0x10000
#define RELAX_SECOND_LONGER 0x20000
#define RELAX_NOMACRO 0x40000

/* For nanoMIPS code, we use relaxation similar to one we use for
   microMIPS code.  Some instructions that take immediate values support
   two encodings: a small one which takes some small value, and a
   larger one which takes a 16 bit value.  As some branches also follow
   this pattern, relaxing these values is required.

   There are no delayed branches in nanoMIPS and we do not relax
   32-bit branch instructions that do not fit within 32-bit range at
   assembly, so attributes related to those features are removed.
   Instead we relax 32-bit calls that do not fit within 16-bit range
   in to calls to 32-bit unconditional branch stubs which can fit within
   16-bit range.

   USESTUB and ONCESTUB track calls which can be relaxed to stubs. KEEPSTUB
   tracks stubs that have sufficient calls (at least 3)  against them to be
   instantiated for reducing code size.

   TOOFAR16/NEGOFF are for relaxation of the ADDIU opcode in to
   32/NEG/R2/RS5 variants.
   !TOOFAR16 && NEGOFF  => ADDIU[RS5], consequent to operand constraints
   !TOOFAR16 && !NEGOFF => ADDIU[R2], consequent to operand constraints
   TOOFAR16  && NEGOFF  => ADDIU[NEG]
   TOOFAR16 &&  !NEGOFF => ADDIU[32]

   RF tracks link-time variability of a frag. It takes one of 4 values:
   RF_NONE: value is link-time varialbe, size is invariable
   RF_FIXED: link-time invariable, does not need relocation
   RF_VARIABLE: link-time variable
   RF_NORELAX: don't care because linker relaxation is disabled
*/

/* The ordering of this enumeration matters. All entries starting
   RT_BRANCH_UCND onwards are understood to be assembler relaxable.  */
enum relax_nanomips_subtype
{
  RT_NONE = 0,
  RT_PC4_S1,
  RT_PC7_S1,
  RT_PC10_S1,
  RT_PC11_S1,
  RT_PC14_S1,
  RT_PC21_S1,
  RT_PC25_S1,
  RT_ADDIU,
  RT_BRANCH_UCND,
  RT_BRANCH_CNDZ,
  RT_BRANCH_CND,
  RT_BALC_STUB,
};

enum relax_nanomips_fix_type
{
  RF_NONE = 0,
  RF_FIXED,
  RF_VARIABLE,
  RF_NORELAX
};

#define RELAX_NANOMIPS_ENCODE(type, link, rf)			\
  (0x20000000							\
   | ((type) & 0xff)						\
   | ((link) ? 0x2000 : 0)					\
   | ((rf) ? (rf << 19) : 0))
#define RELAX_NANOMIPS_P(i) (((i) & 0xe0000000) == 0x20000000)
#define RELAX_NANOMIPS_TYPE(i) ((i) & 0xff)
#define RELAX_NANOMIPS_LINK(i) (((i) & 0x2000) != 0)

#define RELAX_NANOMIPS_BALC_STUB_P(i) \
  (RELAX_NANOMIPS_P (i) && ((i) & 0xff) == RT_BALC_STUB)

#define RELAX_NANOMIPS_BRANCH_P(i)					\
  (RELAX_NANOMIPS_P (i) && (((i) & 0xff) == RT_BRANCH_UCND		\
			       || ((i) & 0xff) == RT_BRANCH_CNDZ	\
			       || ((i) & 0xff) == RT_BRANCH_CND))

#define RELAX_NANOMIPS_ADDIU_P(i)			\
  (RELAX_NANOMIPS_P (i) && ((i) & 0xff) == RT_ADDIU)

#define RELAX_NANOMIPS_KEEPSTUB(i) (((i) & 0x4000) != 0)
#define RELAX_NANOMIPS_MARK_KEEPSTUB(i) ((i) | 0x4000)
#define RELAX_NANOMIPS_CLEAR_KEEPSTUB(i) ((i) & ~0x4000)

#define RELAX_NANOMIPS_USESTUB(i) (((i) & 0x8000) != 0)
#define RELAX_NANOMIPS_MARK_USESTUB(i) ((i) | 0x8000)
#define RELAX_NANOMIPS_CLEAR_USESTUB(i) ((i) & ~0x8000)

#define RELAX_NANOMIPS_ONCESTUB(i) (((i) & 0x10000) != 0)
#define RELAX_NANOMIPS_MARK_ONCESTUB(i) ((i) | 0x10000)
#define RELAX_NANOMIPS_CLEAR_ONCESTUB(i) ((i) & ~0x10000)

#define RELAX_NANOMIPS_TOOFAR16(i) (((i) & 0x20000) != 0)
#define RELAX_NANOMIPS_MARK_TOOFAR16(i) ((i) | 0x20000)
#define RELAX_NANOMIPS_CLEAR_TOOFAR16(i) ((i) & ~0x20000)

#define RELAX_NANOMIPS_NEGOFF(i) (((i) & 0x40000) != 0)
#define RELAX_NANOMIPS_MARK_NEGOFF(i) ((i) | 0x40000)
#define RELAX_NANOMIPS_CLEAR_NEGOFF(i) ((i) & ~0x40000)

#define RELAX_NANOMIPS_FIXED(i) (((i) & 0x180000) >> 19 == RF_FIXED)
#define RELAX_NANOMIPS_MARK_FIXED(i) (((i) & ~0x180000) \
				      | (RF_FIXED << 19))
#define RELAX_NANOMIPS_CLEAR_FIXED(i) ((i) & ~(RF_FIXED << 19))

#define RELAX_NANOMIPS_VARIABLE(i) (((i) & 0x180000) >> 19 == RF_VARIABLE)
#define RELAX_NANOMIPS_MARK_VARIABLE(i) (((i) & ~0x180000) \
					 | (RF_VARIABLE << 19))
#define RELAX_NANOMIPS_CLEAR_VARIABLE(i) ((i) & ~(RF_VARIABLE << 19))
#define RELAX_NANOMIPS_NORELAX(i) (((i) & 0x180000) >> 19 == RF_NORELAX)

/* Sign-extend 16-bit value X.  */
#define SEXT_16BIT(X) ((((X) + 0x8000) & 0xffff) - 0x8000)

/* Is the given value a sign-extended 32-bit value?  */
#define IS_SEXT_32BIT_NUM(x)						\
  (((x) &~ (offsetT) 0x7fffffff) == 0					\
   || (((x) &~ (offsetT) 0x7fffffff) == ~ (offsetT) 0x7fffffff))

/* Is the given value an unsigned 16-bit value?  */
#define IS_SEXT_16BIT_UINT(x)  (((x) &~ (offsetT) 0xffff) == 0)

/* Is the given value a sign-extended 12-bit value?  */
#define IS_SEXT_12BIT_NUM(x) (((((x) & 0xfff) ^ 0x800LL) - 0x800LL) == (x))

/* Is the given value a sign-extended 9-bit value?  */
#define IS_SEXT_9BIT_NUM(x) (((((x) & 0x1ff) ^ 0x100LL) - 0x100LL) == (x))

/* Is the given value a zero-extended 32-bit value?  Or a negated one?  */
#define IS_ZEXT_32BIT_NUM(x)						\
  (((x) &~ (offsetT) 0xffffffff) == 0					\
   || (((x) &~ (offsetT) 0xffffffff) == ~ (offsetT) 0xffffffff))

/* Is the given value an unsigned N-bit value?  */
#define IS_SEXT_UINT(x,n)  (((x) &~ (offsetT) ((1 << (n)) - 1)) == 0)

/* Is the given value an signed-extended N-bit value?  */
#define IS_SEXT_INT(x,n)				 \
  (((((x) & ((1 << (n)) - 1)) ^ (offsetT)(1 << ((n)-1))) \
    - (1 << ((n)-1))) == (x))

/* Extract bits MASK << SHIFT from STRUCT and shift them right
   SHIFT places.  */
#define EXTRACT_BITS(STRUCT, MASK, SHIFT) \
  (((STRUCT) >> (SHIFT)) & (MASK))



/* Global variables used when generating relaxable macros.  See the
   comment above RELAX_ENCODE for more details about how relaxation
   is used.  */
static struct
{
  /* 0 if we're not emitting a relaxable macro.
     1 if we're emitting the first of the two relaxation alternatives.
     2 if we're emitting the second alternative.  */
  int sequence;

  /* The first relaxable fixup in the current frag.  (In other words,
     the first fixup that refers to relaxable code.)  */
  fixS *first_fixup;

  /* sizes[0] says how many bytes of the first alternative are stored in
     the current frag.  Likewise sizes[1] for the second alternative.  */
  unsigned int sizes[2];

  /* The symbol on which the choice of sequence depends.  */
  symbolS *symbol;
} nanomips_relax;

/* Global variables used to decide whether a macro needs a warning.  */
static struct
{
  /* For relaxable macros, sizes[0] is the length of the first alternative
     in bytes and sizes[1] is the length of the second alternative.
     For non-relaxable macros, both elements give the length of the
     macro in bytes.  */
  unsigned int sizes[2];

  /* For relaxable macros, first_insn_sizes[0] is the length of the first
     instruction of the first alternative in bytes and first_insn_sizes[1]
     is the length of the first instruction of the second alternative.
     For non-relaxable macros, both elements give the length of the first
     instruction in bytes.

     Set to zero if we haven't yet seen the first instruction.  */
  unsigned int first_insn_sizes[2];

  /* For relaxable macros, insns[0] is the number of instructions for the
     first alternative and insns[1] is the number of instructions for the
     second alternative.

     For non-relaxable macros, both elements give the number of
     instructions for the macro.  */
  unsigned int insns[2];

  /* The first variant frag for this macro.  */
  fragS *first_frag;
} nanomips_macro_warning;

/* Prototypes for static functions.  */

enum nanomips_regclass { NANOMIPS_GR_REG, NANOMIPS_FP_REG };

static void append_insn
  (struct nanomips_cl_insn *, expressionS *, bfd_reloc_code_real_type *,
   bfd_boolean expansionp);
static void macro_build (expressionS *, const char *, const char *, ...);
static void load_register (int, expressionS *, int);
static void macro_start (void);
static void macro_end (bfd_boolean);
static void nanomips_macro (struct nanomips_cl_insn *ip, char *str);
static void nanomips_ip (char *str, struct nanomips_cl_insn *ip);
static size_t my_getSmallExpression
  (expressionS *, bfd_reloc_code_real_type *, char *);
static void my_getExpression (expressionS *, char *);
static void s_align (int);
static void s_change_sec (int);
static void s_change_section (int);
static void s_cons (int);
static void s_float_cons (int);
static void s_nanomips_globl (int);
static void s_nanomipsset (int);
static void s_cpsetup (int);
static void s_dtprelword (int);
static void s_dtpreldword (int);
static void s_tprelword (int);
static void s_tpreldword (int);
static void s_ehword (int);
static void s_insn (int);
static void s_module (int);
static void s_nanomips_ent (int);
static void s_nanomips_end (int);
static void s_nanomips_frame (int);
static void s_nanomips_mask (int reg_type);
static void s_nanomips_stab (int);
static void s_nanomips_weakext (int);
static void s_nanomips_file (int);
static void s_nanomips_loc (int);
static void s_linkrelax (int);
static bfd_boolean pic_need_relax (symbolS *, asection *);
static void file_check_options (void);
static void stubgroup_new (asection *);
static void s_sign_cons (int);
static void s_nanomips_leb128 (int);

/* Table and functions used to map between CPU/ISA names, and
   ISA levels, and CPU numbers.  */

struct nanomips_cpu_info
{
  const char *name;		/* CPU or ISA name.  */
  int flags;			/* NANOMIPS_CPU_* flags.  */
  int ase;			/* Set of ASEs implemented by the CPU.  */
  int isa;			/* ISA level.  */
  int cpu;			/* CPU number (default CPU if ISA).  */
};

#define NANOMIPS_CPU_IS_ISA	0x0001	/* Is this an ISA?  (If 0, a CPU.) */

static const struct nanomips_cpu_info *nanomips_parse_cpu (const char *,
							   const char *);
static const struct nanomips_cpu_info *nanomips_cpu_info_from_isa
	(int, bfd_boolean);
static const struct nanomips_cpu_info *nanomips_cpu_info_from_arch (int);

/* Command-line options.  */
const char *md_shortopts = "O::g::G:";

enum options
{
  OPTION_MARCH = OPTION_MD_BASE,
  OPTION_MTUNE,
  OPTION_NO_MIPS16,
  OPTION_DSP,
  OPTION_NO_DSP,
  OPTION_MT,
  OPTION_NO_MT,
  OPTION_VIRT,
  OPTION_NO_VIRT,
  OPTION_MSA,
  OPTION_NO_MSA,
  OPTION_DSPR3,
  OPTION_NO_DSPR3,
  OPTION_EVA,
  OPTION_NO_EVA,
  OPTION_NO_MICROMIPS,
  OPTION_MCU,
  OPTION_NO_MCU,
  OPTION_TLB,
  OPTION_NO_TLB,
  OPTION_GINV,
  OPTION_NO_GINV,
  OPTION_CRC,
  OPTION_NO_CRC,
  OPTION_TRAP,
  OPTION_BREAK,
  OPTION_EB,
  OPTION_EL,
  OPTION_CONSTRUCT_FLOATS,
  OPTION_NO_CONSTRUCT_FLOATS,
  OPTION_INSN32,
  OPTION_NO_INSN32,
  OPTION_SOFT_FLOAT,
  OPTION_HARD_FLOAT,
  OPTION_SINGLE_FLOAT,
  OPTION_DOUBLE_FLOAT,
  OPTION_32,
  OPTION_64,
  OPTION_M32,
  OPTION_M64,
  OPTION_BALC_STUBS,
  OPTION_NO_BALC_STUBS,
  OPTION_LEGACY_REGS,
  OPTION_NO_LEGACY_REGS,
  OPTION_LINKRELAX,
  OPTION_PCREL,
  OPTION_NO_PCREL,
  OPTION_PID,
  OPTION_NO_PID,
  OPTION_PIC,
  OPTION_NOPIC,
  OPTION_LARGE_PIC,
  OPTION_MCMODEL,
  OPTION_MTTGPR_RC1,
  OPTION_MINIMIZE_RELOCS,
  OPTION_NO_MINIMIZE_RELOCS,
  OPTION_END_OF_ENUM
};

struct option md_longopts[] = {
  /* Options which specify architecture.  */
  {"march", required_argument, NULL, OPTION_MARCH},
  {"mtune", required_argument, NULL, OPTION_MTUNE},

  /* Options which specify Application Specific Extensions (ASEs).  */
  {"mdsp", no_argument, NULL, OPTION_DSP},
  {"mno-dsp", no_argument, NULL, OPTION_NO_DSP},
  {"mdspr3", no_argument, NULL, OPTION_DSPR3},
  {"mno-dspr3", no_argument, NULL, OPTION_NO_DSPR3},
  {"meva", no_argument, NULL, OPTION_EVA},
  {"mno-eva", no_argument, NULL, OPTION_NO_EVA},
  {"mginv", no_argument, NULL, OPTION_GINV},
  {"mno-ginv", no_argument, NULL, OPTION_NO_GINV},
  {"mcrc", no_argument, NULL, OPTION_CRC},
  {"mno-crc", no_argument, NULL, OPTION_NO_CRC},
  {"mmcu", no_argument, NULL, OPTION_MCU},
  {"mno-mcu", no_argument, NULL, OPTION_NO_MCU},
  {"mmt", no_argument, NULL, OPTION_MT},
  {"mno-mt", no_argument, NULL, OPTION_NO_MT},
  {"mtlb", no_argument, NULL, OPTION_TLB},
  {"mno-tlb", no_argument, NULL, OPTION_NO_TLB},
  {"mvirt", no_argument, NULL, OPTION_VIRT},
  {"mno-virt", no_argument, NULL, OPTION_NO_VIRT},

  /* Miscellaneous options.  */
  {"32", no_argument, NULL, OPTION_32},
  {"64", no_argument, NULL, OPTION_64},
  {"m32", no_argument, NULL, OPTION_M32},
  {"m64", no_argument, NULL, OPTION_M64},
  {"EB", no_argument, NULL, OPTION_EB},
  {"EL", no_argument, NULL, OPTION_EL},
  {"mcmodel", required_argument, NULL, OPTION_MCMODEL},
  {"mpic", no_argument, NULL, OPTION_PIC},
  {"mno-pic", no_argument, NULL, OPTION_NOPIC},
  {"mPIC", no_argument, NULL, OPTION_LARGE_PIC},
  {"mno-PIC", no_argument, NULL, OPTION_NOPIC},
  {"mpid", no_argument, NULL, OPTION_PID},
  {"mno-pid", no_argument, NULL, OPTION_NO_PID},
  {"mpcrel", no_argument, NULL, OPTION_PCREL},
  {"mno-pcrel", no_argument, NULL, OPTION_NO_PCREL},
  {"minsn32", no_argument, NULL, OPTION_INSN32},
  {"mno-insn32", no_argument, NULL, OPTION_NO_INSN32},
  {"mdouble-float", no_argument, NULL, OPTION_DOUBLE_FLOAT},
  {"mhard-float", no_argument, NULL, OPTION_HARD_FLOAT},
  {"msingle-float", no_argument, NULL, OPTION_SINGLE_FLOAT},
  {"msoft-float", no_argument, NULL, OPTION_SOFT_FLOAT},
  {"construct-floats", no_argument, NULL, OPTION_CONSTRUCT_FLOATS},
  {"no-construct-floats", no_argument, NULL, OPTION_NO_CONSTRUCT_FLOATS},
  {"mbalc-stubs", no_argument, NULL, OPTION_BALC_STUBS},
  {"mno-balc-stubs", no_argument, NULL, OPTION_NO_BALC_STUBS},
  {"mlegacyregs", no_argument, NULL, OPTION_LEGACY_REGS},
  {"mno-legacyregs", no_argument, NULL, OPTION_NO_LEGACY_REGS},
  {"linkrelax", no_argument, NULL, OPTION_LINKRELAX},
  {"break", no_argument, NULL, OPTION_BREAK},
  {"no-break", no_argument, NULL, OPTION_TRAP},
  {"trap", no_argument, NULL, OPTION_TRAP},
  {"no-trap", no_argument, NULL, OPTION_BREAK},
  {"mmttgpr-rc1", no_argument, NULL, OPTION_MTTGPR_RC1},
  {"mminimize-relocs", no_argument, NULL, OPTION_MINIMIZE_RELOCS},
  {"mno-minimize-relocs", no_argument, NULL, OPTION_NO_MINIMIZE_RELOCS},

  {NULL, no_argument, NULL, 0}
};

size_t md_longopts_size = sizeof (md_longopts);

/* Information about either an Application Specific Extension or an
   optional architecture feature that, for simplicity, we treat in the
   same way as an ASE.  */
struct nanomips_ase
{
  /* The name of the ASE, used in both the command-line and .set options.  */
  const char *name;

  /* The associated ASE_* flags.  If the ASE is available on both 32-bit
     and 64-bit architectures, the flags here refer to the subset that
     is available on both.  */
  unsigned int flags;

  /* The ASE_* flag used for instructions that are available on 64-bit
     architectures but that are not included in FLAGS.  */
  unsigned int flags64;

  /* The command-line options that turn the ASE on and off.  */
  int option_on;
  int option_off;

  int nanomips32_rev;
  int nanomips64_rev;

  /* The architecture where the ASE was removed or -1 if the extension has not
     been removed.  */
  int rem_rev;
};

/* A table of all supported ASEs.  */
static const struct nanomips_ase nanomips_ases[] = {
  {"dsp", ASE_DSP, ASE_DSP64,
   OPTION_DSP, OPTION_NO_DSP,
   6, 6,
   -1},

  {"dspr3", ASE_DSP, ASE_DSP64,
   OPTION_DSPR3, OPTION_NO_DSPR3,
   6, 6,
   -1},

  {"eva", ASE_EVA, 0,
   OPTION_EVA, OPTION_NO_EVA,
   6, 6,
   -1},

  {"ginv", ASE_GINV, 0,
   OPTION_GINV, OPTION_NO_GINV,
   6, 6,
   -1},

  {"crc", ASE_CRC, ASE_CRC64,
   OPTION_CRC, OPTION_NO_CRC,
   6, 6,
   -1},

  {"mcu", ASE_MCU, 0,
   OPTION_MCU, OPTION_NO_MCU,
   6, 6,
   -1},

  {"msa", ASE_MSA, ASE_MSA64,
   OPTION_MSA, OPTION_NO_MSA,
   6, 6,
   -1},

  {"mt", ASE_MT, 0,
   OPTION_MT, OPTION_NO_MT,
   6, 6,
   -1},

  {"tlb", ASE_TLB, 0,
   OPTION_TLB, OPTION_NO_TLB,
   6, 6,
   -1},

  {"virt", ASE_VIRT, ASE_VIRT64,
   OPTION_VIRT, OPTION_NO_VIRT,
   6, 6,
   -1},
};


/* Pseudo-op table.  */

static const pseudo_typeS nanomips_pseudo_table[] = {
  /* nanoMIPS specific pseudo-ops.  */
  {"set", s_nanomipsset, 0},
  {"rdata", s_change_sec, 'r'},
  {"sdata", s_change_sec, 's'},
  {"cpload", s_ignore, 0},
  {"cpsetup", s_cpsetup, 0},
  {"cplocal", s_ignore, 0},
  {"cprestore", s_ignore, 0},
  {"cpreturn", s_ignore, 0},
  {"dtprelword", s_dtprelword, 0},
  {"dtpreldword", s_dtpreldword, 0},
  {"tprelword", s_tprelword, 0},
  {"tpreldword", s_tpreldword, 0},
  {"ehword", s_ehword, 0},
  {"cpadd", s_ignore, 0},
  {"insn", s_insn, 0},
  {"module", s_module, 0},

  /* Relatively generic pseudo-ops that happen to be used on MIPS.  */
  {"bss", s_change_sec, 'b'},
  {"err", s_err, 0},
  {"half", s_cons, 1},
  {"dword", s_cons, 3},
  {"weakext", s_nanomips_weakext, 0},
  {"origin", s_org, 0},
  {"repeat", s_rept, 0},

  /* This is non-standard, but we define it for consistency.  */
  {"sbss", s_change_sec, 'B'},

  /* These pseudo-ops are defined in read.c, but must be overridden
     here for one reason or another.  */
  {"align", s_align, 0},
  {"byte", s_cons, 0},
  {"data", s_change_sec, 'd'},
  {"double", s_float_cons, 'd'},
  {"float", s_float_cons, 'f'},
  {"globl", s_nanomips_globl, 0},
  {"global", s_nanomips_globl, 0},
  {"hword", s_cons, 1},
  {"int", s_cons, 2},
  {"long", s_cons, 2},
  {"octa", s_cons, 4},
  {"quad", s_cons, 3},
  {"section", s_change_section, 0},
  {"short", s_cons, 1},
  {"single", s_float_cons, 'f'},
  {"stabd", s_nanomips_stab, 'd'},
  {"stabn", s_nanomips_stab, 'n'},
  {"stabs", s_nanomips_stab, 's'},
  {"text", s_change_sec, 't'},
  {"word", s_cons, 2},
  {"uleb128", s_nanomips_leb128, 0},
  {"sleb128", s_nanomips_leb128, 1},

  {"extern", ecoff_directive_extern, 0},

  /* These psuedo-ops are specific to nanoMIPS relocatable expression
     for jump offset tables.  */
  {"sbyte", s_sign_cons, 0},
  {"shword", s_sign_cons, 1},

  /* Control linker-relaxation for nanoMIPS */
  {"linkrelax", s_linkrelax, 0},

  {NULL, NULL, 0},
};

static const pseudo_typeS nanomips_nonecoff_pseudo_table[] = {
  /* These pseudo-ops should be defined by the object file format.
     However, a.out doesn't support them, so we have versions here.  */
  {"aent", s_nanomips_ent, 1},
  {"bgnb", s_ignore, 0},
  {"end", s_nanomips_end, 0},
  {"endb", s_ignore, 0},
  {"ent", s_nanomips_ent, 0},
  {"file", s_nanomips_file, 0},
  {"fmask", s_nanomips_mask, 'F'},
  {"frame", s_nanomips_frame, 0},
  {"loc", s_nanomips_loc, 0},
  {"mask", s_nanomips_mask, 'R'},
  {"verstamp", s_ignore, 0},
  {NULL, NULL, 0},
};

/* Data structures for BALC stub optimization for nanoMIPS ISA.  */
/* List of call-sites to be resolved by a stub.  */
struct call_list
{
  bfd_vma callsite;
  struct call_list *next;
};

/* Tracking info for each planned stub.  */
struct balc_stub
{
  unsigned int numcalls;
  struct call_list *first_call;
  struct call_list *last_call;
  fragS *fragp;
  symbolS *sym;
};

/* Doubly linked list of all planned stubs groups. */
typedef struct stub_group_s
{
  struct hash_control *stubtable;
  bfd_vma next_offset;
  fragS *fragp;
  struct stub_group_s *prev;
  struct stub_group_s *next;
  asection *seg;
} stub_group;

/* Master-table of all stubgroups by section-name.  */
static struct hash_control *balc_stubgroup_table = NULL;
/* Quick pointer to the stubgroup currently under consideration
   for relaxation.  */
static stub_group *stubg_now = NULL;
/* Flag to check when we are in function-less mode.  */
static bfd_boolean stub_funcless_mode = FALSE;
/* BC32 to be used as a call-stub.  */
static struct nanomips_cl_insn nanomips_bc32_insn;
typedef struct proc
{
  symbolS *func_sym;
  symbolS *func_end_sym;
  unsigned long reg_mask;
  unsigned long reg_offset;
  unsigned long fpreg_mask;
  unsigned long fpreg_offset;
  unsigned long frame_offset;
  unsigned long frame_reg;
  unsigned long pc_reg;
} procS;
static procS *cur_proc_ptr;

/* Tracking state for signed cons expression.  */
static bfd_boolean sign_cons = FALSE;

/* Export the ABI address size for use by TC_ADDRESS_BYTES for the
   purpose of the `.dc.a' internal pseudo-op.  */

int
nanomips_address_bytes (void)
{
  file_check_options ();
  return HAVE_64BIT_ADDRESSES ? 8 : 4;
}

extern void pop_insert (const pseudo_typeS *);

void
nanomips_pop_insert (void)
{
  pop_insert (nanomips_pseudo_table);
  if (!ECOFF_DEBUGGING)
    pop_insert (nanomips_nonecoff_pseudo_table);
}

/* Symbols labelling the current insn.  */

struct insn_label_list
{
  struct insn_label_list *next;
  symbolS *label;
};

static struct insn_label_list *free_insn_labels;
#define label_list tc_segment_info_data.labels

static void nanomips_clear_insn_labels (void);

static inline void
nanomips_clear_insn_labels (void)
{
  register struct insn_label_list **pl;
  segment_info_type *si;

  if (now_seg)
    {
      for (pl = &free_insn_labels; *pl != NULL; pl = &(*pl)->next)
	;

      si = seg_info (now_seg);
      *pl = si->label_list;
      si->label_list = NULL;
    }
}


static char *expr_end;

/* An expression in a macro instruction.  This is set by nanomips_ip and
    when populated is always an O_constant.  */

static expressionS imm_expr;

/* The relocatable field in an instruction and the relocs associated
   with it.  These variables are used for instructions like LUI and
   JAL as well as true offsets.  They are also used for address
   operands in macros.  */

static expressionS offset_expr;
static bfd_reloc_code_real_type offset_reloc[3]
  = { BFD_RELOC_UNUSED, BFD_RELOC_UNUSED, BFD_RELOC_UNUSED };

/* This is set to the resulting size of the instruction to be produced
   by nanomips_ip if an explicit size is supplied.  */

static unsigned int forced_insn_length;

/* This is set if the mnemonic includes a specific [xx] format
   notation from the architecture reference manual.  */

static bfd_boolean forced_insn_format;

/* True if we are assembling an instruction.  All dot symbols defined during
   this time should be treated as code labels.  */

static bfd_boolean nanomips_assembling_insn;

/* The default target format to use.  */

#if defined (TE_FreeBSD)
#define ELF_TARGET(PREFIX, ENDIAN) PREFIX ENDIAN "nanomips-freebsd"
#elif defined (TE_TMIPS)
#define ELF_TARGET(PREFIX, ENDIAN) PREFIX "trad" ENDIAN "mips"
#else
#define ELF_TARGET(PREFIX, ENDIAN) PREFIX ENDIAN "mips"
#endif

#define ELF_NTARGET(PREFIX, ENDIAN) PREFIX ENDIAN "nanomips"

const char *
nanomips_target_format (void)
{
  switch (OUTPUT_FLAVOR)
    {
    case bfd_target_elf_flavour:
      return (target_big_endian
	      ? (HAVE_64BIT_OBJECTS
		 ? ELF_NTARGET ("elf64-", "big")
		 : ELF_NTARGET ("elf32-", "big"))
	      : (HAVE_64BIT_OBJECTS
		 ? ELF_NTARGET ("elf64-", "little")
		 : ELF_NTARGET ("elf32-", "little")));
    default:
      abort ();
      return NULL;
    }
}

/* Return the ISA revision that is currently in use.  */

static inline int
nanomips_isa_rev (void)
{
  return 6;
}

/* Check whether the current ISA supports ASE.  Issue a warning if
   appropriate.  */

static void
nanomips_check_isa_supports_ase (const struct nanomips_ase *ase)
{
  int min_rev, size;
  static unsigned int warned_isa;
  static unsigned int warned_fp32;

  if (ISA_HAS_64BIT_REGS (nanomips_opts.isa))
    min_rev = ase->nanomips64_rev;
  else
    min_rev = ase->nanomips32_rev;

  if ((min_rev < 0 || nanomips_isa_rev () < min_rev)
      && (warned_isa & ase->flags) != ase->flags)
    {
      warned_isa |= ase->flags;
      size = ISA_HAS_64BIT_REGS (nanomips_opts.isa) ? 64 : 32;
      if (min_rev < 0)
	as_warn (_("the %d-bit nanoMIPS architecture does not support the"
		   " `%s' extension"), size, ase->name);
      else
	as_warn (_("the `%s' extension requires nanoMIPS%d revision %d or "
		   "greater"), ase->name, size, min_rev);
    }

  if ((ase->flags & ASE_MSA)
      && nanomips_opts.fp != 64
      && (warned_fp32 & ase->flags) != ase->flags)
    {
      warned_fp32 |= ase->flags;
      as_warn (_("the `%s' extension requires 64-bit FPRs"), ase->name);
    }
}

/* Check all enabled ASEs to see whether they are supported by the
   chosen architecture.  */

static void
nanomips_check_isa_supports_ases (void)
{
  unsigned int i, mask;

  for (i = 0; i < ARRAY_SIZE (nanomips_ases); i++)
    {
      mask = nanomips_ases[i].flags;
      if ((nanomips_opts.ase & mask) == nanomips_ases[i].flags)
	nanomips_check_isa_supports_ase (&nanomips_ases[i]);
    }
}

/* Set the state of ASE to ENABLED_P.  Return the mask of ASE_* flags
   that were affected.  */

static unsigned int
nanomips_set_ase (const struct nanomips_ase *ase,
		  struct nanomips_set_options *opts, bfd_boolean enabled_p)
{
  unsigned int mask;

  mask = ase->flags;
  opts->ase &= ~mask;
  opts->ase &= ~ASE_EVA_R6;
  opts->ase &= ~ASE_GINV_VIRT;

  if (enabled_p)
    opts->ase |= ase->flags;

  /* The Virtualization ASE has Global INValidate (GINV) Extension
     instructions which are only valid when both ASEs are enabled.
     This sets the ASE_GINV_VIRT flag when both ASEs are present.  */
  if (((opts->ase & ASE_GINV) != 0) && ((opts->ase & ASE_VIRT) != 0))
    {
      opts->ase |= ASE_GINV_VIRT;
      mask |= ASE_GINV_VIRT;
    }

  return mask;
}

/* Return the ASE called NAME, or null if none.  */

static const struct nanomips_ase *
nanomips_lookup_ase (const char *name)
{
  unsigned int i;

  for (i = 0; i < ARRAY_SIZE (nanomips_ases); i++)
    if (strcmp (name, nanomips_ases[i].name) == 0)
      return &nanomips_ases[i];
  return NULL;
}

/* Return the length of a nanoMIPS instruction in bytes. */

static inline unsigned int
insn_length (const struct nanomips_opcode *mo)
{
  return (opcode_48bit_p (mo) ? 6 : (nanomips_opcode_32bit_p (mo) ? 4 : 2));
}

/* Initialise INSN from opcode entry MO.  Leave its position unspecified.  */

static void
create_insn (struct nanomips_cl_insn *insn, const struct nanomips_opcode *mo)
{
  size_t i;

  insn->insn_mo = mo;
  insn->insn_opcode = mo->match;
  insn->frag = NULL;
  insn->where = 0;
  for (i = 0; i < ARRAY_SIZE (insn->fixp); i++)
    insn->fixp[i] = NULL;
  insn->fixed_p = (nanomips_opts.noreorder > 0);
  insn->noreorder_p = (nanomips_opts.noreorder > 0);
  insn->complete_p = 0;
}

/* Get a list of all the operands in INSN.  */

static const struct nanomips_operand_array *
insn_operands (const struct nanomips_cl_insn *insn)
{
  if (insn->insn_mo >= &nanomips_opcodes[0]
      && insn->insn_mo < &nanomips_opcodes[bfd_nanomips_num_opcodes])
    return &nanomips_operands[insn->insn_mo - &nanomips_opcodes[0]];

  abort ();
}

/* Install UVAL as the value of OPERAND in INSN.  */

static inline void
insn_insert_operand (struct nanomips_cl_insn *insn,
		     const struct nanomips_operand *operand,
		     unsigned int uval)
{
  insn->insn_opcode = nanomips_insert_operand (operand, insn->insn_opcode,
					       uval);
}

/* Extract the value of OPERAND from INSN.  */

static inline unsigned
insn_extract_operand (const struct nanomips_cl_insn *insn,
		      const struct nanomips_operand *operand)
{
  return nanomips_extract_operand (operand, insn->insn_opcode);
}

static void
nanomips_record_compressed_mode (void)
{
  segment_info_type *si;

  si = seg_info (now_seg);
  si->tc_segment_info_data.nanomips = 1;
}

/* Read a compressed instruction of length LENGTH.  */

static unsigned long
read_compressed_insn (char *buf, unsigned int length)
{
  unsigned long insn;
  unsigned int i;

  insn = 0;
  for (i = 0; i < length; i += 2)
    {
      insn <<= 16;
      if (target_big_endian)
	insn |= bfd_getb16 ((char *) buf);
      else
	insn |= bfd_getl16 ((char *) buf);
      buf += 2;
    }

  return insn;
}

/* Write compressed instruction INSN to BUF, given that the
   instruction is LENGTH bytes long.  Return a pointer to the next byte.  */

static char *
write_compressed_insn (char *buf, unsigned int insn, unsigned int length)
{
  unsigned int i;

  for (i = 0; i < length; i += 2)
    md_number_to_chars (buf + i, insn >> ((length - i - 2) * 8), 2);

  return buf + length;
}

/* Install INSN at the location specified by its "frag" and "where" fields.  */

static void
install_insn (const struct nanomips_cl_insn *insn)
{
  char *f = insn->frag->fr_literal + insn->where;

  if (insn_length (insn->insn_mo) == 6)
    {
      write_compressed_insn (f, insn->insn_opcode, 2);
      write_compressed_insn (f + 2, insn->insn_opcode_ext, 4);
    }
  else
    write_compressed_insn (f, insn->insn_opcode, insn_length (insn->insn_mo));

  nanomips_record_compressed_mode ();
}

static void
toggle_linkrelax (fragS *frag, long where)
{
  nanomips_opts.linkrelax = !nanomips_opts.linkrelax;
  toggle_linkrelax_p = FALSE;
  fix_new (frag, where, 0, &abs_symbol, 0, FALSE,
	   (nanomips_opts.linkrelax
	    ? BFD_RELOC_NANOMIPS_RELAX : BFD_RELOC_NANOMIPS_NORELAX));
}

/* Move INSN to offset WHERE in FRAG.  Adjust the fixups accordingly
   and install the opcode in the new location.  */

static void
move_insn (struct nanomips_cl_insn *insn, fragS *frag, long where)
{
  size_t i;

  insn->frag = frag;
  insn->where = where;

  if (toggle_linkrelax_p)
    toggle_linkrelax (frag, where);

  for (i = 0; i < ARRAY_SIZE (insn->fixp); i++)
    if (insn->fixp[i] != NULL)
      {
	insn->fixp[i]->fx_frag = frag;
	insn->fixp[i]->fx_where = where;
      }

  install_insn (insn);
}

/* Add INSN to the end of the output.  */

static void
add_fixed_insn (struct nanomips_cl_insn *insn)
{
  char *f = frag_more (insn_length (insn->insn_mo));
  move_insn (insn, frag_now, f - frag_now->fr_literal);
}

/* Start a variant frag and move INSN to the start of the variant part,
   marking it as fixed.  The other arguments are as for frag_var.  */

static void
add_relaxed_insn (struct nanomips_cl_insn *insn, int max_chars, int var,
		  relax_substateT subtype, symbolS *symbol, offsetT offset)
{
  frag_grow (max_chars);
  move_insn (insn, frag_now, frag_more (0) - frag_now->fr_literal);
  insn->fixed_p = 1;
  frag_var (rs_machine_dependent, max_chars, var,
	    subtype, symbol, offset, NULL);
}

/* Insert N copies of INSN into the history buffer, starting at
   position FIRST.  Neither FIRST nor N need to be clipped.  */

static void
insert_into_history (const struct nanomips_cl_insn *insn)
{
  if (nanomips_relax.sequence != 2)
    history[0] = *insn;
}

/* Clear the error in insn_error.  */

static void
clear_insn_error (void)
{
  memset (&insn_error, 0, sizeof (insn_error));
}

/* Possibly record error message MSG for the current instruction.
   If the error is about a particular argument, ARGNUM is the 1-based
   number of that argument, otherwise it is 0.  FORMAT is the format
   of MSG.  Return true if MSG was used, false if the current message
   was kept.  */

static bfd_boolean
set_insn_error_format (int argnum, enum nanomips_insn_error_format format,
		       const char *msg)
{
  if (argnum == 0)
    {
      /* Give priority to errors against specific arguments, and to
	 the first whole-instruction message.  */
      if (insn_error.msg)
	return FALSE;
    }
  else
    {
      /* Keep insn_error if it is against a later argument.  */
      if (argnum < insn_error.min_argnum)
	return FALSE;

      /* If both errors are against the same argument but are different,
	 give up on reporting a specific error for this argument.
	 See the comment about nanomips_insn_error for details.  */
      if (argnum == insn_error.min_argnum
	  && insn_error.msg && strcmp (insn_error.msg, msg) != 0)
	{
	  insn_error.msg = 0;
	  insn_error.min_argnum += 1;
	  return FALSE;
	}
    }
  insn_error.min_argnum = argnum;
  insn_error.format = format;
  insn_error.msg = msg;
  return TRUE;
}

/* Record an instruction error with no % format fields.  ARGNUM and MSG are
   as for set_insn_error_format.  */

static void
set_insn_error (int argnum, const char *msg)
{
  set_insn_error_format (argnum, ERR_FMT_PLAIN, msg);
}

/* Record an instruction error with one %d field I.  ARGNUM and MSG are
   as for set_insn_error_format.  */

static void
set_insn_error_i (int argnum, const char *msg, int i)
{
  if (set_insn_error_format (argnum, ERR_FMT_I, msg))
    insn_error.u.i = i;
}

/* Record an instruction error with two %s fields S1 and S2.  ARGNUM and MSG
   are as for set_insn_error_format.  */

static void
set_insn_error_ss (int argnum, const char *msg, const char *s1,
		   const char *s2)
{
  if (set_insn_error_format (argnum, ERR_FMT_SS, msg))
    {
      insn_error.u.ss[0] = s1;
      insn_error.u.ss[1] = s2;
    }
}

static void
set_insn_error_si (int argnum, const char *msg, const char *s1, const int i)
{
  if (set_insn_error_format (argnum, ERR_FMT_SI, msg))
    {
      insn_error.u.si.s1 = s1;
      insn_error.u.si.u1 = i;
    }
}

/* Report the error in insn_error, which is against assembly code STR.  */

static void
report_insn_error (const char *str)
{
  const char *msg = concat (insn_error.msg, " `%s'", NULL);

  switch (insn_error.format)
    {
    case ERR_FMT_PLAIN:
      as_bad (msg, str);
      break;

    case ERR_FMT_I:
      as_bad (msg, insn_error.u.i, str);
      break;

    case ERR_FMT_SS:
      as_bad (msg, insn_error.u.ss[0], insn_error.u.ss[1], str);
      break;

    case ERR_FMT_SI:
      as_bad (msg, insn_error.u.si.s1, insn_error.u.si.u1, str);
      break;
    }
}

struct regname
{
  const char *name;
  unsigned int num;
};

#define RNUM_MASK	0x00003ff
#define RTYPE_MASK	0x7fffc00
#define RTYPE_NUM	0x0000400
#define RTYPE_FPU	0x0000800
#define RTYPE_FCC	0x0001000
#define RTYPE_VEC	0x0002000
#define RTYPE_GP	0x0004000
#define RTYPE_CP0	0x0008000
#define RTYPE_PC	0x0010000
#define RTYPE_ACC	0x0020000
#define RTYPE_CCC	0x0040000
#define RTYPE_MSA	0x0080000
#define RTYPE_CP0SEL_EVEN	0x0100000
#define RTYPE_CP0SEL_ODD	0x0200000
#define RTYPE_CP0SEL_LO16	0x0400000
#define RTYPE_CP0SEL_ODD16	(RTYPE_CP0SEL_EVEN | RTYPE_CP0SEL_LO16)
#define RTYPE_CP0SEL_EVEN16	(RTYPE_CP0SEL_ODD | RTYPE_CP0SEL_LO16)
#define RTYPE_CP0SEL		(RTYPE_CP0SEL_EVEN | RTYPE_CP0SEL_ODD \
				 | RTYPE_CP0SEL_LO16)
#define RTYPE_HWR	0x0800000
#define RWARN		0x8000000

#define GENERIC_REGISTER_NUMBERS \
    {"$0",	RTYPE_NUM | 0},  \
    {"$1",	RTYPE_NUM | 1},  \
    {"$2",	RTYPE_NUM | 2},  \
    {"$3",	RTYPE_NUM | 3},  \
    {"$4",	RTYPE_NUM | 4},  \
    {"$5",	RTYPE_NUM | 5},  \
    {"$6",	RTYPE_NUM | 6},  \
    {"$7",	RTYPE_NUM | 7},  \
    {"$8",	RTYPE_NUM | 8},  \
    {"$9",	RTYPE_NUM | 9},  \
    {"$10",	RTYPE_NUM | 10}, \
    {"$11",	RTYPE_NUM | 11}, \
    {"$12",	RTYPE_NUM | 12}, \
    {"$13",	RTYPE_NUM | 13}, \
    {"$14",	RTYPE_NUM | 14}, \
    {"$15",	RTYPE_NUM | 15}, \
    {"$16",	RTYPE_NUM | 16}, \
    {"$17",	RTYPE_NUM | 17}, \
    {"$18",	RTYPE_NUM | 18}, \
    {"$19",	RTYPE_NUM | 19}, \
    {"$20",	RTYPE_NUM | 20}, \
    {"$21",	RTYPE_NUM | 21}, \
    {"$22",	RTYPE_NUM | 22}, \
    {"$23",	RTYPE_NUM | 23}, \
    {"$24",	RTYPE_NUM | 24}, \
    {"$25",	RTYPE_NUM | 25}, \
    {"$26",	RTYPE_NUM | 26}, \
    {"$27",	RTYPE_NUM | 27}, \
    {"$28",	RTYPE_NUM | 28}, \
    {"$29",	RTYPE_NUM | 29}, \
    {"$30",	RTYPE_NUM | 30}, \
    {"$31",	RTYPE_NUM | 31}

#define FPU_REGISTER_NAMES       \
    {"$f0",	RTYPE_FPU | 0},  \
    {"$f1",	RTYPE_FPU | 1},  \
    {"$f2",	RTYPE_FPU | 2},  \
    {"$f3",	RTYPE_FPU | 3},  \
    {"$f4",	RTYPE_FPU | 4},  \
    {"$f5",	RTYPE_FPU | 5},  \
    {"$f6",	RTYPE_FPU | 6},  \
    {"$f7",	RTYPE_FPU | 7},  \
    {"$f8",	RTYPE_FPU | 8},  \
    {"$f9",	RTYPE_FPU | 9},  \
    {"$f10",	RTYPE_FPU | 10}, \
    {"$f11",	RTYPE_FPU | 11}, \
    {"$f12",	RTYPE_FPU | 12}, \
    {"$f13",	RTYPE_FPU | 13}, \
    {"$f14",	RTYPE_FPU | 14}, \
    {"$f15",	RTYPE_FPU | 15}, \
    {"$f16",	RTYPE_FPU | 16}, \
    {"$f17",	RTYPE_FPU | 17}, \
    {"$f18",	RTYPE_FPU | 18}, \
    {"$f19",	RTYPE_FPU | 19}, \
    {"$f20",	RTYPE_FPU | 20}, \
    {"$f21",	RTYPE_FPU | 21}, \
    {"$f22",	RTYPE_FPU | 22}, \
    {"$f23",	RTYPE_FPU | 23}, \
    {"$f24",	RTYPE_FPU | 24}, \
    {"$f25",	RTYPE_FPU | 25}, \
    {"$f26",	RTYPE_FPU | 26}, \
    {"$f27",	RTYPE_FPU | 27}, \
    {"$f28",	RTYPE_FPU | 28}, \
    {"$f29",	RTYPE_FPU | 29}, \
    {"$f30",	RTYPE_FPU | 30}, \
    {"$f31",	RTYPE_FPU | 31}

#define FPU_CONDITION_CODE_NAMES \
    {"$fcc0",	RTYPE_FCC | 0},  \
    {"$fcc1",	RTYPE_FCC | 1},  \
    {"$fcc2",	RTYPE_FCC | 2},  \
    {"$fcc3",	RTYPE_FCC | 3},  \
    {"$fcc4",	RTYPE_FCC | 4},  \
    {"$fcc5",	RTYPE_FCC | 5},  \
    {"$fcc6",	RTYPE_FCC | 6},  \
    {"$fcc7",	RTYPE_FCC | 7}

#define COPROC_CONDITION_CODE_NAMES         \
    {"$cc0",	RTYPE_FCC | RTYPE_CCC | 0}, \
    {"$cc1",	RTYPE_FCC | RTYPE_CCC | 1}, \
    {"$cc2",	RTYPE_FCC | RTYPE_CCC | 2}, \
    {"$cc3",	RTYPE_FCC | RTYPE_CCC | 3}, \
    {"$cc4",	RTYPE_FCC | RTYPE_CCC | 4}, \
    {"$cc5",	RTYPE_FCC | RTYPE_CCC | 5}, \
    {"$cc6",	RTYPE_FCC | RTYPE_CCC | 6}, \
    {"$cc7",	RTYPE_FCC | RTYPE_CCC | 7}

#define NANOMIPS_SYMBOLIC_REG_NAMES \
    {"$zero",	RTYPE_GP | 0},  \
    {"$at",	RTYPE_GP | 1},  \
    {"$t4",	RTYPE_GP | 2},  \
    {"$t5",	RTYPE_GP | 3},  \
    {"$a0",	RTYPE_GP | 4},  \
    {"$a1",	RTYPE_GP | 5},  \
    {"$a2",	RTYPE_GP | 6},  \
    {"$a3",	RTYPE_GP | 7},  \
    {"$a4",	RTYPE_GP | 8},  \
    {"$a5",	RTYPE_GP | 9},  \
    {"$a6",	RTYPE_GP | 10}, \
    {"$a7",	RTYPE_GP | 11}, \
    {"$t0",	RTYPE_GP | 12}, \
    {"$t1",	RTYPE_GP | 13}, \
    {"$t2",	RTYPE_GP | 14}, \
    {"$t3",	RTYPE_GP | 15}, \
    {"$s0",	RTYPE_GP | 16}, \
    {"$s1",	RTYPE_GP | 17}, \
    {"$s2",	RTYPE_GP | 18}, \
    {"$s3",	RTYPE_GP | 19}, \
    {"$s4",	RTYPE_GP | 20}, \
    {"$s5",	RTYPE_GP | 21}, \
    {"$s6",	RTYPE_GP | 22}, \
    {"$s7",	RTYPE_GP | 23}, \
    {"$t8",	RTYPE_GP | 24}, \
    {"$t9",	RTYPE_GP | 25}, \
    {"$k0",	RTYPE_GP | 26}, \
    {"$k1",	RTYPE_GP | 27}, \
    {"$gp",	RTYPE_GP | 28}, \
    {"$sp",	RTYPE_GP | 29}, \
    {"$fp",	RTYPE_GP | 30}, \
    {"$ra",	RTYPE_GP | 31}, \
    {"$AT",	RTYPE_GP | 1}

#define NANOMIPS_NUMERIC_REG_NAMES \
    {"$r0",	RTYPE_GP | 0},  \
    {"$r1",	RTYPE_GP | 1},  \
    {"$r2",	RTYPE_GP | 2},  \
    {"$r3",	RTYPE_GP | 3},  \
    {"$r4",	RTYPE_GP | 4},  \
    {"$r5",	RTYPE_GP | 5},  \
    {"$r6",	RTYPE_GP | 6},  \
    {"$r7",	RTYPE_GP | 7},  \
    {"$r8",	RTYPE_GP | 8},  \
    {"$r9",	RTYPE_GP | 9},  \
    {"$r10",	RTYPE_GP | 10}, \
    {"$r11",	RTYPE_GP | 11}, \
    {"$r12",	RTYPE_GP | 12}, \
    {"$r13",	RTYPE_GP | 13}, \
    {"$r14",	RTYPE_GP | 14}, \
    {"$r15",	RTYPE_GP | 15}, \
    {"$r16",	RTYPE_GP | 16}, \
    {"$r17",	RTYPE_GP | 17}, \
    {"$r18",	RTYPE_GP | 18}, \
    {"$r19",	RTYPE_GP | 19}, \
    {"$r20",	RTYPE_GP | 20}, \
    {"$r21",	RTYPE_GP | 21}, \
    {"$r22",	RTYPE_GP | 22}, \
    {"$r23",	RTYPE_GP | 23}, \
    {"$r24",	RTYPE_GP | 24}, \
    {"$r25",	RTYPE_GP | 25}, \
    {"$r26",	RTYPE_GP | 26}, \
    {"$r27",	RTYPE_GP | 27}, \
    {"$r28",	RTYPE_GP | 28}, \
    {"$r29",	RTYPE_GP | 29}, \
    {"$r30",	RTYPE_GP | 30}, \
    {"$r31",	RTYPE_GP | 31}

#define NANOMIPS_DSP_ACCUMULATOR_NAMES \
    {"$ac0",	RTYPE_ACC | 0}, \
    {"$ac1",	RTYPE_ACC | 1}, \
    {"$ac2",	RTYPE_ACC | 2}, \
    {"$ac3",	RTYPE_ACC | 3}

static const struct regname nanomips_reg_names[] = {
  GENERIC_REGISTER_NUMBERS,
  NANOMIPS_SYMBOLIC_REG_NAMES,
  NANOMIPS_NUMERIC_REG_NAMES,
  FPU_REGISTER_NAMES,
  FPU_CONDITION_CODE_NAMES,
  COPROC_CONDITION_CODE_NAMES,
  NANOMIPS_DSP_ACCUMULATOR_NAMES,
  {0, 0}
};

/* Register symbols $v0 and $v1 map to GPRs 2 and 3, but they can also be
   interpreted as vector registers 0 and 1.  If SYMVAL is the value of one
   of these register symbols, return the associated vector register,
   otherwise return SYMVAL itself.  */

static unsigned int
nanomips_prefer_vec_regno (unsigned int symval)
{
  if ((symval & -2) == (RTYPE_GP | 2))
    return RTYPE_VEC | (symval & 1);
  return symval;
}

/* Return true if string [S, E) is a valid register name, storing its
   symbol value in *SYMVAL_PTR if so.  */

static bfd_boolean
nanomips_parse_register_1 (char *s, char *e, unsigned int *symval_ptr)
{
  char save_c;
  symbolS *symbol;

  /* Terminate name.  */
  save_c = *e;
  *e = '\0';

  /* Look up the name.  */
  symbol = symbol_find (s);
  *e = save_c;

  if (!symbol || S_GET_SEGMENT (symbol) != reg_section)
    return FALSE;

  *symval_ptr = S_GET_VALUE (symbol);
  return TRUE;
}

/* Return true if the string at *SPTR is a valid register name.

   When returning true, move *SPTR past the register, store the
   register's symbol value in *SYMVAL_PTR and the channel mask in
   *CHANNELS_PTR (if nonnull).  The symbol value includes the register
   number (RNUM_MASK) and register type (RTYPE_MASK).  The channel mask
   is a 4-bit value of the form XYZW and is 0 if no suffix was given.  */

static bfd_boolean
nanomips_parse_register (char **sptr, unsigned int *symval_ptr,
			 unsigned int *channels_ptr)
{
  char *s, *e, *m;
  const char *q;
  unsigned int channels, symval, bit;

  /* Find end of name.  */
  s = e = *sptr;
  if (is_name_beginner (*e))
    ++e;
  while (is_part_of_name (*e))
    ++e;

  channels = 0;
  if (!nanomips_parse_register_1 (s, e, &symval))
    {
      if (!channels_ptr)
	return FALSE;

      /* Eat characters from the end of the string that are valid
	 channel suffixes.  The preceding register must be $ACC or
	 end with a digit, so there is no ambiguity.  */
      bit = 1;
      m = e;
      for (q = "wzyx"; *q; q++, bit <<= 1)
	if (m > s && m[-1] == *q)
	  {
	    --m;
	    channels |= bit;
	  }

      if (channels == 0 || !nanomips_parse_register_1 (s, m, &symval))
	return FALSE;
    }

  *sptr = e;
  *symval_ptr = symval;
  if (channels_ptr)
    *channels_ptr = channels;
  return TRUE;
}

/* Check if SPTR points at a valid register specifier according to TYPES.
   If so, then return 1, advance S to consume the specifier and store
   the register's number in REGNOP, otherwise return 0.  */

static int
reg_lookup (char **s, unsigned int types, unsigned int *regnop)
{
  unsigned int regno;

  if (nanomips_parse_register (s, &regno, NULL))
    {
      if (types & RTYPE_VEC)
	regno = nanomips_prefer_vec_regno (regno);
      if (regno & types)
	regno &= RNUM_MASK;
      else
	regno = ~0;
    }
  else
    {
      if (types & RWARN)
	as_warn (_("unrecognized register name `%s'"), *s);
      regno = ~0;
    }
  if (regnop)
    *regnop = regno;
  return regno <= RNUM_MASK;
}

/* Token types for parsed operand lists.  */
enum nanomips_operand_token_type
{
  /* A plain register, e.g. $f2.  */
  OT_REG,

  /* A 4-bit XYZW channel mask.  */
  OT_CHANNELS,

  /* A constant vector index, e.g. [1].  */
  OT_INTEGER_INDEX,

  /* A register vector index, e.g. [$2].  */
  OT_REG_INDEX,

  /* A continuous range of registers, e.g. $s0-$s4.  */
  OT_REG_RANGE,

  /* A (possibly relocated) expression.  */
  OT_INTEGER,

  /* A floating-point value.  */
  OT_FLOAT,

  /* A single character.  This can be '(', ')' or ',', but '(' only appears
     before OT_REGs.  */
  OT_CHAR,

  /* A doubled character, either "--" or "++".  */
  OT_DOUBLE_CHAR,

  /* The end of the operand list.  */
  OT_END
};

/* A parsed operand token.  */
struct nanomips_operand_token
{
  /* The type of token.  */
  enum nanomips_operand_token_type type;
  union
  {
    /* The register symbol value for an OT_REG or OT_REG_INDEX.  */
    unsigned int regno;

    /* The 4-bit channel mask for an OT_CHANNEL_SUFFIX.  */
    unsigned int channels;

    /* The integer value of an OT_INTEGER_INDEX.  */
    addressT index;

    /* The two register symbol values involved in an OT_REG_RANGE.  */
    struct
    {
      unsigned int regno1;
      unsigned int regno2;
    } reg_range;

    /* The value of an OT_INTEGER.  The value is represented as an
       expression and the relocation operators that were applied to
       that expression.  The reloc entries are BFD_RELOC_UNUSED if no
       relocation operators were used.  */
    struct
    {
      expressionS value;
      bfd_reloc_code_real_type relocs[3];
    } integer;

    /* The binary data for an OT_FLOAT constant, and the number of bytes
       in the constant.  */
    struct
    {
      unsigned char data[8];
      int length;
    } flt;

    /* The character represented by an OT_CHAR or OT_DOUBLE_CHAR.  */
    char ch;
  } u;
};

/* An obstack used to construct lists of nanomips_operand_tokens.  */
static struct obstack nanomips_operand_tokens;

/* Give TOKEN type TYPE and add it to nanomips_operand_tokens.  */

static void
nanomips_add_token (struct nanomips_operand_token *token,
		    enum nanomips_operand_token_type type)
{
  token->type = type;
  obstack_grow (&nanomips_operand_tokens, token, sizeof (*token));
}

/* Check whether S is '(' followed by a register name.  Add OT_CHAR
   and OT_REG tokens for them if so, and return a pointer to the first
   unconsumed character.  Return null otherwise.  */

static char *
nanomips_parse_base_start (char *s)
{
  struct nanomips_operand_token token;
  unsigned int regno, channels;
  bfd_boolean decrement_p;

  if (*s != '(')
    return 0;

  ++s;
  SKIP_SPACE_TABS (s);

  /* Only match "--" as part of a base expression.  In other contexts "--X"
     is a double negative.  */
  decrement_p = (s[0] == '-' && s[1] == '-');
  if (decrement_p)
    {
      s += 2;
      SKIP_SPACE_TABS (s);
    }

  /* Allow a channel specifier because that leads to better error messages
     than treating something like "$vf0x++" as an expression.  */
  if (!nanomips_parse_register (&s, &regno, &channels))
    return 0;

  token.u.ch = '(';
  nanomips_add_token (&token, OT_CHAR);

  if (decrement_p)
    {
      token.u.ch = '-';
      nanomips_add_token (&token, OT_DOUBLE_CHAR);
    }

  token.u.regno = regno;
  nanomips_add_token (&token, OT_REG);

  if (channels)
    {
      token.u.channels = channels;
      nanomips_add_token (&token, OT_CHANNELS);
    }

  /* For consistency, only match "++" as part of base expressions too.  */
  SKIP_SPACE_TABS (s);
  if (s[0] == '+' && s[1] == '+')
    {
      s += 2;
      token.u.ch = '+';
      nanomips_add_token (&token, OT_DOUBLE_CHAR);
    }

  return s;
}

/* Parse one or more tokens from S.  Return a pointer to the first
   unconsumed character on success.  Return null if an error was found
   and store the error text in insn_error.  FLOAT_FORMAT is as for
   nanomips_parse_arguments.  */

static char *
nanomips_parse_argument_token (char *s, char float_format)
{
  char *end, *save_in;
  const char *err;
  unsigned int regno1, regno2, channels;
  struct nanomips_operand_token token;

  /* First look for "($reg", since we want to treat that as an
     OT_CHAR and OT_REG rather than an expression.  */
  end = nanomips_parse_base_start (s);
  if (end)
    return end;

  /* Handle other characters that end up as OT_CHARs.  */
  if (*s == ')' || *s == ',')
    {
      token.u.ch = *s;
      nanomips_add_token (&token, OT_CHAR);
      ++s;
      return s;
    }

  /* Handle tokens that start with a register.  */
  if (nanomips_parse_register (&s, &regno1, &channels))
    {
      if (channels)
	{
	  /* A register and a VU0 channel suffix.  */
	  token.u.regno = regno1;
	  nanomips_add_token (&token, OT_REG);

	  token.u.channels = channels;
	  nanomips_add_token (&token, OT_CHANNELS);
	  return s;
	}

      SKIP_SPACE_TABS (s);
      if (*s == '-')
	{
	  /* A register range.  */
	  ++s;
	  SKIP_SPACE_TABS (s);
	  if (!nanomips_parse_register (&s, &regno2, NULL))
	    {
	      set_insn_error (0, _("invalid register range"));
	      return 0;
	    }

	  token.u.reg_range.regno1 = regno1;
	  token.u.reg_range.regno2 = regno2;
	  nanomips_add_token (&token, OT_REG_RANGE);
	  return s;
	}

      /* Add the register itself.  */
      token.u.regno = regno1;
      nanomips_add_token (&token, OT_REG);

      /* Check for a vector index.  */
      if (*s == '[')
	{
	  ++s;
	  SKIP_SPACE_TABS (s);
	  if (nanomips_parse_register (&s, &token.u.regno, NULL))
	    nanomips_add_token (&token, OT_REG_INDEX);
	  else
	    {
	      expressionS element;

	      my_getExpression (&element, s);
	      if (element.X_op != O_constant)
		{
		  set_insn_error (0, _("vector element must be constant"));
		  return 0;
		}
	      s = expr_end;
	      token.u.index = element.X_add_number;
	      nanomips_add_token (&token, OT_INTEGER_INDEX);
	    }
	  SKIP_SPACE_TABS (s);
	  if (*s != ']')
	    {
	      set_insn_error (0, _("missing `]'"));
	      return 0;
	    }
	  ++s;
	}
      return s;
    }

  if (float_format)
    {
      /* First try to treat expressions as floats.  */
      save_in = input_line_pointer;
      input_line_pointer = s;
      err = md_atof (float_format, (char *) token.u.flt.data,
		     &token.u.flt.length);
      end = input_line_pointer;
      input_line_pointer = save_in;
      if (err && *err)
	{
	  set_insn_error (0, err);
	  return 0;
	}
      if (s != end)
	{
	  nanomips_add_token (&token, OT_FLOAT);
	  return end;
	}
    }

  /* Treat everything else as an integer expression.  */
  token.u.integer.relocs[0] = BFD_RELOC_UNUSED;
  token.u.integer.relocs[1] = BFD_RELOC_UNUSED;
  token.u.integer.relocs[2] = BFD_RELOC_UNUSED;
  my_getSmallExpression (&token.u.integer.value, token.u.integer.relocs, s);
  s = expr_end;
  nanomips_add_token (&token, OT_INTEGER);
  return s;
}

/* S points to the operand list for an instruction.  FLOAT_FORMAT is 'f'
   if expressions should be treated as 32-bit floating-point constants,
   'd' if they should be treated as 64-bit floating-point constants,
   or 0 if they should be treated as integer expressions (the usual case).

   Return a list of tokens on success, otherwise return 0.  The caller
   must obstack_free the list after use.  */

static struct nanomips_operand_token *
nanomips_parse_arguments (char *s, char float_format)
{
  struct nanomips_operand_token token;

  SKIP_SPACE_TABS (s);
  while (*s)
    {
      s = nanomips_parse_argument_token (s, float_format);
      if (!s)
	{
	  obstack_free (&nanomips_operand_tokens,
			obstack_finish (&nanomips_operand_tokens));
	  return 0;
	}
      SKIP_SPACE_TABS (s);
    }
  nanomips_add_token (&token, OT_END);
  return (struct nanomips_operand_token *)
    obstack_finish (&nanomips_operand_tokens);
}

/* Return TRUE if opcode MO is valid for the currently selected
   floating point configuration.  */

static bfd_boolean
is_opcode_valid_for_fp (const struct nanomips_opcode *mo)
{
  int fp_s, fp_d;

  /* Check whether the instruction or macro requires single-precision or
     double-precision floating-point support.  Note that this information is
     stored differently in the opcode table for insns and macros.  */
  if (mo->pinfo == INSN_MACRO)
    {
      fp_s = mo->pinfo2 & INSN2_M_FP_S;
      fp_d = mo->pinfo2 & INSN2_M_FP_D;
    }
  else
    {
      fp_s = mo->pinfo & FP_S;
      fp_d = mo->pinfo & FP_D;
    }

  if (fp_d && (nanomips_opts.soft_float || nanomips_opts.single_float))
    return FALSE;

  if (fp_s && nanomips_opts.soft_float)
    return FALSE;

  return TRUE;
}

/* Return TRUE if opcode MO is valid for the currently selected ISA
   with the specified ASE.  */

static bfd_boolean
is_opcode_valid_for_ase (const struct nanomips_opcode *mo, int ase)
{
  int isa = nanomips_opts.isa;
  unsigned int i;

  if (ISA_HAS_64BIT_REGS (isa))
    for (i = 0; i < ARRAY_SIZE (nanomips_ases); i++)
      if ((ase & nanomips_ases[i].flags) == nanomips_ases[i].flags)
	ase |= nanomips_ases[i].flags64;

  return nanomips_opcode_is_member (mo, isa, ase, nanomips_opts.arch);
}

/* Return TRUE if opcode MO is valid for the currently selected ISA,
   ASE and floating point configuration.  */

static bfd_boolean
is_opcode_valid (const struct nanomips_opcode *mo)
{
  return (is_opcode_valid_for_ase (mo, nanomips_opts.ase)
	  && is_opcode_valid_for_fp (mo));
}

/* Return TRUE if opcode MO is valid for the currently selected ISA
   and architecture with a default ASE selection.  */

static bfd_boolean
is_opcode_valid_def_ase (const struct nanomips_opcode *mo)
{
  const struct nanomips_cpu_info *info;
  int ase;

  info = nanomips_cpu_info_from_isa (nanomips_opts.isa,
				     (nanomips_opts.ase & ASE_xNMS) == 0);
  ase = info->ase | nanomips_opts.ase;

  return is_opcode_valid_for_ase (mo, ase);
}

/* Return TRUE if the size of the nanoMIPS opcode MO matches one
   explicitly requested.  */

static bfd_boolean
is_size_valid (const struct nanomips_opcode *mo)
{
  if (nanomips_opts.insn32
      && mo->pinfo != INSN_MACRO
      && insn_length (mo) != 4)
    return FALSE;

  if (!forced_insn_length)
    return TRUE;

  if (mo->pinfo == INSN_MACRO)
    return FALSE;

  return forced_insn_length == insn_length (mo);
}

/* For consistency checking, verify that all bits of OPCODE are specified
   either by the match/mask part of the instruction definition, or by the
   operand list.  Also build up a list of operands in OPERANDS.

   INSN_BITS says which bits of the instruction are significant.
   If OPCODE is a standard or microMIPS instruction, DECODE_OPERAND
   provides the nanomips_operand description of each operand.  */

static int
validate_insn (const struct nanomips_opcode *opcode,
	       unsigned long insn_bits,
	       const struct nanomips_operand *(*decode_operand) (const char
								 *),
	       struct nanomips_operand_array *operands)
{
  const char *s;
  unsigned long used_bits, doubled, undefined, opno, mask;
  const struct nanomips_operand *operand;

  mask = (opcode->pinfo == INSN_MACRO ? 0 : opcode->mask);
  if ((mask & opcode->match) != opcode->match)
    {
      as_bad (_("internal: bad nanomips opcode (mask error): %s %s"),
	      opcode->name, opcode->args);
      return 0;
    }
  used_bits = 0;
  opno = 0;

  for (s = opcode->args; *s; ++s)
    switch (*s)
      {
      case ',':
      case '(':
      case ')':
	break;

      case '#':
	s++;
	break;

      default:
	operand = decode_operand (s);
	if (!operand && opcode->pinfo != INSN_MACRO)
	  {
	    as_bad (_("internal: unknown operand type: %s %s"),
		    opcode->name, opcode->args);
	    return 0;
	  }
	gas_assert (opno < MAX_OPERANDS);
	operands->operand[opno] = operand;
	if (operand != NULL
	    && (decode_operand
		|| operand->type != OP_INT
		|| operand->lsb != 0
		|| !nanomips_opcode_32bit_p (opcode)))
	  used_bits = nanomips_insert_operand (operand, used_bits, -1);
	/* Skip prefix characters.  */
	if (decode_operand && (*s == '+' || *s == 'm'
			       || *s == '-' || *s == '`'))
	  ++s;
	opno += 1;
	break;
      }
  doubled = used_bits & mask & insn_bits;
  if (doubled)
    {
      as_bad (_("internal: bad nanomips opcode (bits 0x%08lx doubly defined):"
		" %s %s"), doubled, opcode->name, opcode->args);
      return 0;
    }
  used_bits |= mask;
  undefined = ~used_bits & insn_bits;
  if (opcode->pinfo != INSN_MACRO && undefined)
    {
      as_bad (_("internal: bad nanomips opcode (bits 0x%08lx undefined): "
		"%s %s"), undefined, opcode->name, opcode->args);
      return 0;
    }
  used_bits &= ~insn_bits;
  if (used_bits)
    {
      as_bad (_("internal: bad nanomips opcode (bits 0x%08lx defined): "
		"%s %s"), used_bits, opcode->name, opcode->args);
      return 0;
    }
  return 1;
}

static int
validate_nanomips_insn (const struct nanomips_opcode *opc,
			struct nanomips_operand_array *operands)
{
  unsigned long insn_bits;
  unsigned long major;
  unsigned int length;

  if (opc->pinfo == INSN_MACRO)
    return validate_insn (opc, 0xffffffff, decode_nanomips_operand, operands);

  length = insn_length (opc);
  if (length != 2 && length != 4 && length != 6)
    {
      as_bad (_("internal error: bad nanoMIPS opcode (incorrect length: %u): "
		"%s %s"), length, opc->name, opc->args);
      return 0;
    }

  if (length == 6)
    /* 48-bit instruction is encoded as 16-bits in the opcode table.  */
    major = opc->match >> 10;
  else
    major = opc->match >> (10 + 8 * (length - 2));

  if ((length == 2 && !(major & 4))
       || (length == 4 && (major & 4))
       || (length == 6 && !(major & 18)))
    {
      as_bad (_("internal error: bad nanoMIPS opcode "
		"(opcode/length mismatch): %s %s"), opc->name, opc->args);
      return 0;
    }

  if (length == 6)
    /* 48-bit instruction is encoded as 16-bits in the opcode table.  */
    insn_bits = 1 << 16;
  else
    {
      /* Shift piecewise to avoid an overflow where unsigned long is 32-bit.  */
      insn_bits = 1 << 4 * length;
      insn_bits <<= 4 * length;
    }

  insn_bits -= 1;
  return validate_insn (opc, insn_bits, decode_nanomips_operand, operands);
}

/* This function is called once, at assembler startup time.  It should set up
   all the tables, etc. that the MD part of the assembler will need.  */

void
md_begin (void)
{
  const char *retval = NULL;
  int i = 0;
  int broken = 0;
  int count_marker = 0;

  if (nanomips_opts.pic != NO_PIC)
    {
      if (g_switch_seen && g_switch_value != 0)
	as_bad (_("-G may not be used in position-independent code"));
      g_switch_value = 0;
    }

  if (!bfd_set_arch_mach (stdoutput, bfd_arch_nanomips,
			  file_nanomips_opts.arch))
    as_warn (_("could not set architecture and machine"));

  op_hash = hash_new ();

  nanomips_op_hash = hash_new ();
  nanomips_operands = XCNEWVEC (struct nanomips_operand_array,
				bfd_nanomips_num_opcodes);

  i = 0;
  while (i < bfd_nanomips_num_opcodes)
    {
      const char *name = nanomips_opcodes[i].name;

      retval = hash_insert (nanomips_op_hash, name,
			    (void *) &nanomips_opcodes[i]);
      if (retval != NULL)
	as_fatal (_("internal: can't hash `%s': %s"),
		  nanomips_opcodes[i].name, retval);
      do
	{
	  struct nanomips_cl_insn *insn;

	  if (!validate_nanomips_insn (&nanomips_opcodes[i],
				       &nanomips_operands[i]))
	    broken = 1;

	  if (count_marker < 3 && nanomips_opcodes[i].pinfo != INSN_MACRO)
	    {
	      if (nanomips_nop16_insn.insn_mo == NULL
		  && insn_length (&nanomips_opcodes[i]) == 2
		  && strcmp (name, "nop") == 0)
		insn = &nanomips_nop16_insn;
	      else if (nanomips_nop32_insn.insn_mo == NULL
		       && insn_length (&nanomips_opcodes[i]) == 4
		       && strcmp (name, "nop") == 0)
		insn = &nanomips_nop32_insn;
	      else if (nanomips_bc32_insn.insn_mo == NULL
		       && insn_length (&nanomips_opcodes[i]) == 4
		       && strcmp (name, "bc") == 0)
		insn = &nanomips_bc32_insn;
	      else
		continue;

	      create_insn (insn, nanomips_opcodes + i);
	      insn->fixed_p = 1;
	      count_marker++;
	    }
	}
      while (++i < bfd_nanomips_num_opcodes
	     && strcmp (nanomips_opcodes[i].name, name) == 0);
    }

  i = 0;
  while (i < bfd_nanomips_num_opcodes)
    {
      const struct nanomips_opcode *opcode = &nanomips_opcodes[i];
      if (opcode->suffix[0] != '\0')
	{
	  char *name;
	  name = xmalloc (strlen (opcode->name)
			  + strlen (opcode->suffix)
			  + 1);
	  name = strcpy (name, opcode->name);
	  name = strcat (name, opcode->suffix);

	  if (hash_find (nanomips_op_hash, name) == NULL)
	    {
	      retval = hash_insert (nanomips_op_hash, name,
				    (void *) &nanomips_opcodes[i]);
	      if (retval != NULL)
		as_fatal (_("internal: can't hash `%s': %s"),
			  opcode->name, retval);
	    }
	}
      i++;
    }

  if (broken)
    as_fatal (_("broken assembler, no assembly attempted"));

  /* We add all the general register names to the symbol table.  This
     helps us detect invalid uses of them.  */
  for (i = 0; nanomips_reg_names[i].name; i++)
    {
      symbolS *regsym = symbol_new (nanomips_reg_names[i].name, reg_section,
				    nanomips_reg_names[i].num,
				    &zero_address_frag);
      symbolS *defsym = symbol_find (nanomips_reg_names[i].name);
      symbol_table_insert (regsym);
      if (defsym)
	as_warn ("Attempt to define internal register symbol %s ignored",
		 nanomips_reg_names[i].name);
    }

  for (i = 0; i < 32; i++)
    {
      char regname[7];

      /* MSA register.  */
      snprintf (regname, sizeof (regname) - 1, "$w%d", i);
      symbol_table_insert (symbol_new (regname, reg_section,
				       RTYPE_MSA | i, &zero_address_frag));
    }

  for (i = 0; nanomips_cp0_3264r6[i].name; i++)
    {
      /* 10-bit symbol value for CP0 named register consists of a 5-bit
	 register number and 5-bit fixed select value.  */
      unsigned int value = (RTYPE_CP0
			    | (nanomips_cp0_3264r6[i].num
			       << NANOMIPSOP_SH_CP0SEL)
			    | nanomips_cp0_3264r6[i].sel);
      symbolS *regsym = symbol_new (nanomips_cp0_3264r6[i].name, reg_section,
				    value, &zero_address_frag);
      symbolS *defsym = symbol_find (nanomips_cp0_3264r6[i].name);
      symbol_table_insert (regsym);
      if (defsym)
	as_warn ("Attempt to define internal register symbol %s ignored",
		 nanomips_cp0_3264r6[i].name);
    }

  for (i = 0; nanomips_cp0sel_3264r6[i].name; i++)
    {
      symbolS *regsym, *defsym;
      unsigned value = nanomips_cp0sel_3264r6[i].num;

      switch (nanomips_cp0sel_3264r6[i].selmask)
	{
	  case NANOMIPS_CP0SEL_MASK_EVEN:
	    value |= RTYPE_CP0SEL_EVEN; break;
	  case NANOMIPS_CP0SEL_MASK_EVEN16:
	    value |= RTYPE_CP0SEL_EVEN16; break;
	  case NANOMIPS_CP0SEL_MASK_ODD:
	    value |= RTYPE_CP0SEL_ODD; break;
	  case NANOMIPS_CP0SEL_MASK_ODD16:
	    value |= RTYPE_CP0SEL_ODD16; break;
	  case NANOMIPS_CP0SEL_MASK_ANY16:
	    value |= RTYPE_CP0SEL_LO16; break;
	  case NANOMIPS_CP0SEL_MASK_ANY:
	    value |= RTYPE_CP0SEL; break;
	  default:
	    break;
	}

      regsym = symbol_new (nanomips_cp0sel_3264r6[i].name, reg_section,
			   value, &zero_address_frag);
      defsym = symbol_find (nanomips_cp0sel_3264r6[i].name);
      symbol_table_insert (regsym);
      if (defsym)
	as_warn ("Attempt to define internal register symbol %s ignored",
		 nanomips_cp0sel_3264r6[i].name);
    }

  for (i = 0; nanomips_hwr_names_3264r6[i].name; i++)
    {
      /* 10-bit symbol value for HWR named register consists of a 5-bit
	 register number and 5-bit fixed select value.  */
      unsigned int value = (RTYPE_HWR
			    | (nanomips_hwr_names_3264r6[i].num
			       << NANOMIPSOP_SH_CP0SEL)
			    | nanomips_hwr_names_3264r6[i].sel);
      symbolS *regsym;
      symbolS *defsym = symbol_find (nanomips_hwr_names_3264r6[i].name);
      if (defsym)
	{
	  if (nanomips_hwr_names_3264r6[i].cp0_num != INV_RNUM
	      || nanomips_hwr_names_3264r6[i].cp0_sel != INV_SEL)
	    /* In cases where HWR register names overlap with CP0 registers, we
	       keep the CP0 register value in the symbol table, but mark the
	       value to indicate that it may be HWR as well.  */
	    S_SET_VALUE (defsym, S_GET_VALUE (defsym) | RTYPE_HWR);
	  else
	    as_warn ("Attempt to define internal register symbol %s ignored",
		     nanomips_hwr_names_3264r6[i].name);
	}
      else
	{
	  regsym = symbol_new (nanomips_hwr_names_3264r6[i].name, reg_section,
			       value, &zero_address_frag);
	  symbol_table_insert (regsym);
	}
    }

  obstack_init (&nanomips_operand_tokens);

  nanomips_flush_pending_output ();

  /* set the default alignment for the text section (2**2) */
  record_alignment (text_section, 2);

  bfd_set_gp_size (stdoutput, g_switch_value);

  /* On a native system sections must be aligned to 16 byte boundaries.
     When configured for an embedded ELF target, we don't bother.  */
  if (strncmp (TARGET_OS, "elf", 3) != 0)
    {
      (void) bfd_set_section_alignment (stdoutput, text_section, 4);
      (void) bfd_set_section_alignment (stdoutput, data_section, 4);
      (void) bfd_set_section_alignment (stdoutput, bss_section, 4);
    }

  {
    segT seg;
    subsegT subseg;
    segT sec;

    seg = now_seg;
    subseg = now_subseg;

    sec = subseg_new (".nanoMIPS.abiflags", (subsegT) 0);
    bfd_set_section_flags (stdoutput, sec,
			   SEC_READONLY | SEC_DATA | SEC_ALLOC | SEC_LOAD);
    bfd_set_section_alignment (stdoutput, sec, 3);
    nanomips_flags_frag = frag_more (sizeof (Elf_External_ABIFlags_v0));

    subseg_set (seg, subseg);
  }
}

static inline void
fpabi_incompatible_with (int fpabi, const char *what)
{
  as_warn (_(".gnu_attribute %d,%d is incompatible with `%s'"),
	   Tag_GNU_NANOMIPS_ABI_FP, fpabi, what);
}

static inline void
fpabi_requires (int fpabi, const char *what)
{
  as_warn (_(".gnu_attribute %d,%d requires `%s'"),
	   Tag_GNU_NANOMIPS_ABI_FP, fpabi, what);
}

/* Check -mabi and register sizes against the specified FP ABI.  */
static void
check_fpabi (int fpabi)
{
  switch (fpabi)
    {
    case Val_GNU_NANOMIPS_ABI_FP_DOUBLE:
      if (file_nanomips_opts.soft_float)
	fpabi_incompatible_with (fpabi, "softfloat");
      else if (file_nanomips_opts.single_float)
	fpabi_incompatible_with (fpabi, "singlefloat");
      break;

    case Val_GNU_NANOMIPS_ABI_FP_SINGLE:
      if (file_nanomips_opts.soft_float)
	fpabi_incompatible_with (fpabi, "softfloat");
      else if (!file_nanomips_opts.single_float)
	fpabi_requires (fpabi, "singlefloat");
      break;

    case Val_GNU_NANOMIPS_ABI_FP_SOFT:
      if (!file_nanomips_opts.soft_float)
	fpabi_requires (fpabi, "softfloat");
      break;

    default:
      as_warn (_(".gnu_attribute %d,%d is not a recognized"
		 " floating-point ABI"), Tag_GNU_NANOMIPS_ABI_FP, fpabi);
      break;
    }
}

/* Perform consistency checks on the module level options exactly once.
   This is a deferred check that happens:
     at the first .set directive
     or, at the first pseudo op that generates code (inc .dc.a)
     or, at the first instruction
     or, at the end.  */

static void
file_check_options (void)
{
  if (file_nanomips_opts_checked)
    return;

  /* The following code determines the register size.
     Similar code was added to GCC 3.3 (see override_options() in
     config/mips/mips.c).  The GAS and GCC code should be kept in sync
     as much as possible.  */

  if (file_nanomips_opts.gp < 0)
    {
      /* Infer the integer register size from the ABI and processor.
	 Restrict ourselves to 32-bit registers if that's all the
	 processor has, or if the ABI cannot handle 64-bit registers.  */
      file_nanomips_opts.gp
	= ((ABI_NEEDS_32BIT_REGS (nanomips_abi)
	    || !ISA_HAS_64BIT_REGS (file_nanomips_opts.isa))
	   ? 32
	   : 64);
    }

  if (file_nanomips_opts.fp < 0)
    /* No user specified float register size.  */
    /* nanoMIPS implies 64-bit float registers.  */
    file_nanomips_opts.fp = 64;

  /* End of GCC-shared inference code.  */

  /* This flag is set when we have a 64-bit capable CPU but use only
     32-bit wide registers.  Note that EABI does not use it.  */
  if (ISA_HAS_64BIT_REGS (file_nanomips_opts.isa)
      && ((nanomips_abi == NO_ABI && file_nanomips_opts.gp == 32)
	  || nanomips_abi == P32_ABI))
    nanomips_32bitmode = 1;

  /* If the user didn't explicitly select or deselect a particular ASE,
     use the default setting for the CPU.  */
  file_nanomips_opts.ase |=
    (file_nanomips_opts.init_ase & ~file_ase_explicit);

  /* Set up the current options.  These may change throughout assembly.  */
  nanomips_opts = file_nanomips_opts;

  nanomips_check_isa_supports_ases ();
  file_nanomips_opts_checked = TRUE;

  if (!bfd_set_arch_mach (stdoutput, bfd_arch_nanomips,
			  file_nanomips_opts.arch))
    as_warn (_("could not set architecture and machine"));
}

void
md_assemble (char *str)
{
  struct nanomips_cl_insn insn;
  bfd_reloc_code_real_type unused_reloc[3]
    = { BFD_RELOC_UNUSED, BFD_RELOC_UNUSED, BFD_RELOC_UNUSED };

  file_check_options ();

  imm_expr.X_op = O_absent;
  offset_expr.X_op = O_absent;
  offset_reloc[0] = BFD_RELOC_UNUSED;
  offset_reloc[1] = BFD_RELOC_UNUSED;
  offset_reloc[2] = BFD_RELOC_UNUSED;

  if (cur_proc_ptr == NULL && !stub_funcless_mode)
    {
      stubgroup_new (now_seg);
      stub_funcless_mode = TRUE;
    }

  nanomips_assembling_insn = TRUE;
  clear_insn_error ();

  nanomips_ip (str, &insn);

  if (insn_error.msg)
    report_insn_error (str);
  else if (insn.insn_mo->pinfo == INSN_MACRO)
    {
      macro_start ();
      nanomips_macro (&insn, str);
      macro_end ((insn.insn_mo->pinfo2 & INSN2_MACRO) != 0);
    }
  else
    {
      if (offset_expr.X_op != O_absent)
	append_insn (&insn, &offset_expr, offset_reloc, FALSE);
      else
	append_insn (&insn, NULL, unused_reloc, FALSE);
    }

  nanomips_assembling_insn = FALSE;
}

static inline bfd_boolean
nanomips_reloc_p (bfd_reloc_code_real_type reloc)
{
  switch (reloc)
    {
    case BFD_RELOC_NANOMIPS_GPREL19_S2:
    case BFD_RELOC_NANOMIPS_GPREL18_S3:
    case BFD_RELOC_NANOMIPS_GPREL16_S2:
    case BFD_RELOC_NANOMIPS_HI20:
    case BFD_RELOC_NANOMIPS_LO12:
    case BFD_RELOC_NANOMIPS_PCREL_HI20:
    case BFD_RELOC_NANOMIPS_7_PCREL_S1:
    case BFD_RELOC_NANOMIPS_10_PCREL_S1:
    case BFD_RELOC_NANOMIPS_11_PCREL_S1:
    case BFD_RELOC_NANOMIPS_21_PCREL_S1:
    case BFD_RELOC_NANOMIPS_25_PCREL_S1:
    case BFD_RELOC_NANOMIPS_14_PCREL_S1:
    case BFD_RELOC_NANOMIPS_GOT_CALL:
    case BFD_RELOC_NANOMIPS_GOTPC_HI20:
    case BFD_RELOC_NANOMIPS_GOT_LO12:
    case BFD_RELOC_NANOMIPS_GOT_PAGE:
    case BFD_RELOC_NANOMIPS_GOT_OFST:
    case BFD_RELOC_NANOMIPS_GOT_DISP:
    case BFD_RELOC_NANOMIPS_IMM16:
    case BFD_RELOC_NANOMIPS_NEG12:
    case BFD_RELOC_NANOMIPS_I32:
    case BFD_RELOC_NANOMIPS_HI32:
    case BFD_RELOC_NANOMIPS_TLS_GD:
    case BFD_RELOC_NANOMIPS_TLS_GD_I32:
    case BFD_RELOC_NANOMIPS_TLS_LD:
    case BFD_RELOC_NANOMIPS_TLS_LD_I32:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL12:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL16:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL_I32:
    case BFD_RELOC_NANOMIPS_TLS_TPREL12:
    case BFD_RELOC_NANOMIPS_TLS_TPREL16:
    case BFD_RELOC_NANOMIPS_TLS_TPREL_I32:
    case BFD_RELOC_NANOMIPS_TLS_GOTTPREL:
    case BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32:
    case BFD_RELOC_NANOMIPS_PC_I32:
    case BFD_RELOC_NANOMIPS_GOTPC_I32:
    case BFD_RELOC_NANOMIPS_GPREL_I32:
    case BFD_RELOC_NANOMIPS_GPREL18:
    case BFD_RELOC_NANOMIPS_GPREL17_S1:
    case BFD_RELOC_NANOMIPS_GPREL_HI20:
    case BFD_RELOC_NANOMIPS_GPREL_LO12:
      return TRUE;

    default:
      return FALSE;
    }
}

static inline bfd_boolean
nanomips_48bit_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_NANOMIPS_I32
	  || reloc == BFD_RELOC_NANOMIPS_HI32
	  || reloc == BFD_RELOC_NANOMIPS_PC_I32
	  || reloc == BFD_RELOC_NANOMIPS_GPREL_I32
	  || reloc == BFD_RELOC_NANOMIPS_GOTPC_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_GD_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_LD_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_DTPREL_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_TPREL_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32);
}

static inline bfd_boolean
hi_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_HI16_S
	  || reloc == BFD_RELOC_NANOMIPS_HI20
	  || reloc == BFD_RELOC_NANOMIPS_GOTPC_HI20
	  || reloc == BFD_RELOC_NANOMIPS_GPREL_HI20);
}

static inline bfd_boolean
lo_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_LO16
	  || reloc == BFD_RELOC_NANOMIPS_LO12
	  || reloc == BFD_RELOC_NANOMIPS_GPREL_LO12
	  || reloc == BFD_RELOC_NANOMIPS_GOT_LO12);

}

static inline bfd_boolean
gprel16_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_GPREL16
	  || reloc == BFD_RELOC_NANOMIPS_GPREL7_S2
	  || reloc == BFD_RELOC_NANOMIPS_GPREL18
	  || reloc == BFD_RELOC_NANOMIPS_GPREL19_S2
	  || reloc == BFD_RELOC_NANOMIPS_GPREL16_S2
	  || reloc == BFD_RELOC_NANOMIPS_GPREL18_S3
	  || reloc == BFD_RELOC_NANOMIPS_GPREL17_S1
	  || reloc == BFD_RELOC_NANOMIPS_TLS_GD
	  || reloc == BFD_RELOC_NANOMIPS_TLS_LD);
}

static inline bfd_boolean
pcrel16_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_NANOMIPS_4_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_7_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_10_PCREL_S1);
}

static inline bfd_boolean
pcrel32_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_32_PCREL
	  || reloc == BFD_RELOC_NANOMIPS_11_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_14_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_21_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_25_PCREL_S1
	  || reloc == BFD_RELOC_NANOMIPS_PCREL_HI20
	  || reloc == BFD_RELOC_NANOMIPS_GOTPC_HI20);
}

static inline bfd_boolean
pcrel_branch_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (pcrel16_reloc_p (reloc)
	  || (pcrel32_reloc_p (reloc)
	      && reloc != BFD_RELOC_NANOMIPS_PCREL_HI20
	      && reloc != BFD_RELOC_NANOMIPS_GOTPC_HI20));
}

static inline bfd_boolean
pcrel48_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_NANOMIPS_PC_I32
	  || reloc == BFD_RELOC_NANOMIPS_GOTPC_I32
	  || reloc == BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32);
}

static inline bfd_boolean
pcrel_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (pcrel16_reloc_p (reloc)
	  || pcrel32_reloc_p (reloc)
	  || pcrel48_reloc_p (reloc));
}

/* Return true if RELOC is a PC-relative relocation that does not have
   full address range.  */

static inline bfd_boolean
limited_pcrel_reloc_p (bfd_reloc_code_real_type reloc)
{
  switch (reloc)
    {
    case BFD_RELOC_NANOMIPS_4_PCREL_S1:
    case BFD_RELOC_NANOMIPS_7_PCREL_S1:
    case BFD_RELOC_NANOMIPS_10_PCREL_S1:
    case BFD_RELOC_NANOMIPS_11_PCREL_S1:
    case BFD_RELOC_NANOMIPS_14_PCREL_S1:
    case BFD_RELOC_NANOMIPS_21_PCREL_S1:
    case BFD_RELOC_NANOMIPS_25_PCREL_S1:
      return TRUE;

    case BFD_RELOC_32_PCREL:
    case BFD_RELOC_NANOMIPS_PCREL_HI20:
      return HAVE_64BIT_ADDRESSES;

    default:
      return FALSE;
    }
}

/* Return true if RELOC is a place-holder for linker relaxation and
   not associated with a particular instruction.  */

static inline bfd_boolean
linkrelax_reloc_p (bfd_reloc_code_real_type reloc)
{
  switch (reloc)
    {
    case BFD_RELOC_NANOMIPS_ALIGN:
    case BFD_RELOC_NANOMIPS_FILL:
    case BFD_RELOC_NANOMIPS_MAX:
    case BFD_RELOC_NANOMIPS_FIXED:
    case BFD_RELOC_NANOMIPS_RELAX:
    case BFD_RELOC_NANOMIPS_NORELAX:
      return TRUE;
    default:
      return FALSE;
    }
}

/* Return true if RELOC is a place-holder to inhibit relaxation
   for a particular instruction.  */
static inline bfd_boolean
linkrelax_inhibit_reloc_p (bfd_reloc_code_real_type reloc)
{
  return (reloc == BFD_RELOC_NANOMIPS_INSN16
	  || reloc == BFD_RELOC_NANOMIPS_INSN32
	  || reloc == BFD_RELOC_NANOMIPS_FIXED);
}

/* Return TRUE if R is an initial selected relocation that has multiple
   size variants.  */

static bfd_boolean
flex_reloc_p (bfd_reloc_code_real_type r)
{
  return (r == BFD_RELOC_NANOMIPS_GPREL18
	  || r == BFD_RELOC_NANOMIPS_TLS_LD
	  || r == BFD_RELOC_NANOMIPS_TLS_GD
	  || r == BFD_RELOC_NANOMIPS_TLS_TPREL12
	  || r == BFD_RELOC_NANOMIPS_TLS_DTPREL12);
}


/* Return TRUE if R is GP-relative relocation that takes 32-bit
   immediate displacement.  */

static bfd_boolean
gprel_i32_reloc_p (bfd_reloc_code_real_type r)
{
  return (r == BFD_RELOC_NANOMIPS_GPREL_I32
	  || r == BFD_RELOC_NANOMIPS_TLS_LD_I32
	  || r == BFD_RELOC_NANOMIPS_TLS_GD_I32);
}

/* Return the type of %lo() reloc needed by RELOC, given that
   reloc_needs_lo_p.  */

static inline bfd_reloc_code_real_type
matching_lo_reloc (bfd_reloc_code_real_type reloc ATTRIBUTE_UNUSED)
{
  return (BFD_RELOC_LO16);
}

/* Return true if the given fixup is followed by a matching %lo
   relocation.  */

static inline bfd_boolean
fixup_has_matching_lo_p (fixS *fixp)
{
  return (fixp->fx_next != NULL
	  && fixp->fx_next->fx_r_type == matching_lo_reloc (fixp->fx_r_type)
	  && fixp->fx_addsy == fixp->fx_next->fx_addsy
	  && fixp->fx_offset == fixp->fx_next->fx_offset);
}

/* Move all labels in LABELS to the current insertion point.  */

static void
nanomips_move_labels (struct insn_label_list *labels)
{
  struct insn_label_list *l;
  valueT val;

  if (toggle_linkrelax_p)
    toggle_linkrelax (frag_now, frag_now_fix ());

  for (l = labels; l != NULL; l = l->next)
    {
      gas_assert (S_GET_SEGMENT (l->label) == now_seg);
      symbol_set_frag (l->label, frag_now);
      val = (valueT) frag_now_fix ();
      S_SET_VALUE (l->label, val);
    }
}

static bfd_boolean
s_is_linkonce (symbolS *sym, segT from_seg)
{
  bfd_boolean linkonce = FALSE;
  segT symseg = S_GET_SEGMENT (sym);

  if (symseg != from_seg && !S_IS_LOCAL (sym))
    {
      if ((bfd_get_section_flags (stdoutput, symseg) & SEC_LINK_ONCE))
	linkonce = TRUE;
      /* The GNU toolchain uses an extension for ELF: a section
	 beginning with the magic string .gnu.linkonce is a
	 linkonce section.  */
      if (strncmp (segment_name (symseg), ".gnu.linkonce",
		   sizeof ".gnu.linkonce" - 1) == 0)
	linkonce = TRUE;
    }
  return linkonce;
}

/* End the current frag.  Make it a variant frag and record the
   relaxation info.  */

static void
relax_close_frag (void)
{
  nanomips_macro_warning.first_frag = frag_now;
  frag_var (rs_machine_dependent, 0, 0,
	    RELAX_ENCODE (nanomips_relax.sizes[0], nanomips_relax.sizes[1]),
	    nanomips_relax.symbol, 0, (char *) nanomips_relax.first_fixup);

  memset (&nanomips_relax.sizes, 0, sizeof (nanomips_relax.sizes));
  nanomips_relax.first_fixup = 0;
}

/* Start a new relaxation sequence whose expansion depends on SYMBOL.
   See the comment above RELAX_ENCODE for more details.  */

static void
relax_start (symbolS *symbol)
{
  gas_assert (nanomips_relax.sequence == 0);
  nanomips_relax.sequence = 1;
  nanomips_relax.symbol = symbol;
}

/* Start generating the second version of a relaxable sequence.
   See the comment above RELAX_ENCODE for more details.  */

static void
relax_switch (void)
{
  gas_assert (nanomips_relax.sequence == 1);
  nanomips_relax.sequence = 2;
}

/* End the current relaxable sequence.  */

static void
relax_end (void)
{
  gas_assert (nanomips_relax.sequence == 2);
  relax_close_frag ();
  nanomips_relax.sequence = 0;
}

/* Return true if IP is a delayed branch or jump.  */

static inline bfd_boolean
delayed_branch_p (const struct nanomips_cl_insn *ip)
{
  return (ip->insn_mo->pinfo & (INSN_UNCOND_BRANCH_DELAY
				| INSN_COND_BRANCH_DELAY
				| INSN_COND_BRANCH_LIKELY)) != 0;
}

/* Return true if IP is a compact branch or jump.  */

static inline bfd_boolean
compact_branch_p (const struct nanomips_cl_insn *ip)
{
  return (ip->insn_mo->pinfo2 & (INSN2_UNCOND_BRANCH
				 | INSN2_COND_BRANCH)) != 0;
}

/* Return true if IP is an unconditional branch or jump.  */

static inline bfd_boolean
uncond_branch_p (const struct nanomips_cl_insn *ip)
{
  return ((ip->insn_mo->pinfo & INSN_UNCOND_BRANCH_DELAY) != 0
	  || (ip->insn_mo->pinfo2 & INSN2_UNCOND_BRANCH) != 0);
}

/* Information about an instruction argument that we're trying to match.  */
struct nanomips_arg_info
{
  /* The instruction so far.  */
  struct nanomips_cl_insn *insn;

  /* The first unconsumed operand token.  */
  struct nanomips_operand_token *token;

  /* The 1-based operand number, in terms of insn->insn_mo->args.  */
  int opnum;

  /* The 1-based argument number, for error reporting.  This does not
     count elided optional registers, etc..  */
  int argnum;

  /* The last OP_REG operand seen, or ILLEGAL_REG if none.  */
  unsigned int last_regno;

  /* If the first operand was an OP_REG, this is the register that it
     specified, otherwise it is ILLEGAL_REG.  */
  unsigned int dest_regno;

  /* The value of the last OP_INT operand.  Used for OP_MSB,
     where it gives the lsb position and to check stack frame size
     for save/restore register list. */
  unsigned int last_op_int;

  /* If true, match routines should assume that no later instruction
     alternative matches and should therefore be as accomodating as
     possible.  Match routines should not report errors if something
     is only invalid for !LAX_MATCH.  */
  bfd_boolean lax_match;

  /* True if a reference to the current AT register was seen.  */
  bfd_boolean seen_at;

  /* CP0 select register mask.  */
  unsigned int select_mask;
};

/* Record that the argument is out of range.  */

static void
match_out_of_range (struct nanomips_arg_info *arg)
{
  set_insn_error_i (arg->argnum, _("operand %d out of range"), arg->argnum);
}

/* Record that the argument isn't constant but needs to be.  */

static void
match_not_constant (struct nanomips_arg_info *arg)
{
  set_insn_error_i (arg->argnum, _("operand %d must be constant"),
		    arg->argnum);
}

/* Try to match an OT_CHAR token for character CH.  Consume the token
   and return true on success, otherwise return false.  */

static bfd_boolean
match_char (struct nanomips_arg_info *arg, char ch)
{
  if (arg->token->type == OT_CHAR && arg->token->u.ch == ch)
    {
      ++arg->token;
      if (ch == ',')
	arg->argnum += 1;
      return TRUE;
    }
  return FALSE;
}

/* Try to get an expression from the next tokens in ARG.  Consume the
   tokens and return true on success, storing the expression value in
   VALUE and relocation types in R.  */

static bfd_boolean
match_expression (struct nanomips_arg_info *arg, expressionS *value,
		  bfd_reloc_code_real_type *r)
{
  /* If the next token is a '(' that was parsed as being part of a base
     expression, assume we have an elided offset.  The later match will fail
     if this turns out to be wrong.  */
  if (arg->token->type == OT_CHAR && arg->token->u.ch == '(')
    {
      value->X_op = O_constant;
      value->X_add_number = 0;
      r[0] = r[1] = r[2] = BFD_RELOC_UNUSED;
      return TRUE;
    }

  /* Reject register-based expressions such as "0+$2" and "(($2))".
     For plain registers the default error seems more appropriate.  */
  if (arg->token->type == OT_INTEGER
      && arg->token->u.integer.value.X_op == O_register)
    {
      set_insn_error (arg->argnum, _("register value used as expression"));
      return FALSE;
    }

  if (arg->token->type == OT_INTEGER)
    {
      *value = arg->token->u.integer.value;
      memcpy (r, arg->token->u.integer.relocs, 3 * sizeof (*r));
      ++arg->token;
      return TRUE;
    }

  set_insn_error_i
    (arg->argnum, _("operand %d must be an immediate expression"),
     arg->argnum);
  return FALSE;
}

/* Try to get a constant expression from the next tokens in ARG.  Consume
   the tokens and return return true on success, storing the constant value
   in *VALUE.  Use FALLBACK as the value if the match succeeded with an
   error.  */

static bfd_boolean
match_const_int (struct nanomips_arg_info *arg, offsetT *value)
{
  expressionS ex;
  bfd_reloc_code_real_type r[3];

  if (!match_expression (arg, &ex, r))
    return FALSE;

  if (r[0] == BFD_RELOC_UNUSED && ex.X_op == O_constant)
    *value = ex.X_add_number;
  else
    {
      match_not_constant (arg);
      return FALSE;
    }
  return TRUE;
}

/* Return the RTYPE_* flags for a register operand of type TYPE that
   appears in instruction OPCODE.  */

static unsigned int
convert_reg_type (const struct nanomips_opcode *opcode,
		  enum nanomips_reg_operand_type type)
{
  switch (type)
    {
    case OP_REG_GP:
    default:
      if (!nanomips_opts.legacyregs)
	return RTYPE_GP;
      else
	return RTYPE_NUM | RTYPE_GP;

    case OP_REG_FP:
      return RTYPE_FPU;

    case OP_REG_CCC:
      if (opcode->pinfo & (FP_D | FP_S))
	return RTYPE_CCC | RTYPE_FCC;
      return RTYPE_CCC;

    case OP_REG_VEC:
      return RTYPE_FPU | RTYPE_VEC;

    case OP_REG_ACC:
      return RTYPE_ACC;

    case OP_REG_COPRO:
      if (opcode->name[strlen (opcode->name) - 1] == '0')
	return RTYPE_NUM | RTYPE_CP0;
      return RTYPE_NUM;

    case OP_REG_HW:
      return RTYPE_HWR;

    case OP_REG_MSA:
      return RTYPE_MSA;

    case OP_REG_MSA_CTRL:
      return RTYPE_NUM;

    case OP_REG_CP0:
      /* CP0 register without select must be symbolic.  */
      return RTYPE_CP0;

    case OP_REG_CP0SEL:
      /* CP0 register with select may be numeric.  */
      return RTYPE_CP0SEL | RTYPE_NUM;

    case OP_REG_HWRSEL:
      /* HWR register with select may be numeric.  */
      return RTYPE_HWR | RTYPE_NUM;
    }
  abort ();
}

/* ARG is register REGNO, of type TYPE.  Warn about any dubious registers.  */

static void
check_regno (struct nanomips_arg_info *arg,
	     enum nanomips_reg_operand_type type, unsigned int regno)
{
  if (AT && type == OP_REG_GP && regno == AT)
    arg->seen_at = TRUE;

  if (type == OP_REG_CCC)
    {
      const char *name;
      size_t length;

      name = arg->insn->insn_mo->name;
      length = strlen (name);
      if ((regno & 1) != 0
	  && ((length >= 3 && strcmp (name + length - 3, ".ps") == 0)
	      || (length >= 5 && strncmp (name + length - 5, "any2", 4) == 0)))
	as_warn (_("condition code register should be even for %s, was %d"),
		 name, regno);

      if ((regno & 3) != 0
	  && (length >= 5 && strncmp (name + length - 5, "any4", 4) == 0))
	as_warn (_("condition code register should be 0 or 4 for %s, was %d"),
		 name, regno);
    }
}

/* ARG is a register with symbol value SYMVAL.  Try to interpret it as
   a register of type TYPE.  Return true on success, storing the register
   number in *REGNO and warning about any dubious uses.  */

static bfd_boolean
match_regno (struct nanomips_arg_info *arg,
	     enum nanomips_reg_operand_type type, unsigned int symval,
	     unsigned int *regno)
{
  if (type == OP_REG_VEC)
    symval = nanomips_prefer_vec_regno (symval);
  if (!(symval & convert_reg_type (arg->insn->insn_mo, type)))
    return FALSE;

  /* Remember if the register name matches a specific select mask type.
     Otherwise fall-back to allowing all select values.  */
  if (type == OP_REG_CP0SEL || type == OP_REG_HWRSEL)
    switch (symval & RTYPE_CP0SEL)
      {
      case RTYPE_CP0SEL_EVEN:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_EVEN; break;
      case RTYPE_CP0SEL_EVEN16:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_EVEN16; break;
      case RTYPE_CP0SEL_ODD:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_ODD; break;
      case RTYPE_CP0SEL_ODD16:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_ODD16; break;
      case RTYPE_CP0SEL_LO16:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_ANY16; break;
      case RTYPE_CP0SEL:
      default:
	arg->select_mask = NANOMIPS_CP0SEL_MASK_ANY; break;
	break;
      }

  if (type == OP_REG_HW)
    {
      int i;
      /* Some HWR register names overlap with CP0 register names.
	 In this case the reference list of HWR registers provides
	 the necessary mapping from CP0 to HWR names. */
      for (i = 0; nanomips_hwr_names_3264r6[i].name; i++)
	/* If the symbol value matches a named CP0 register, replace
	   it with the corresponding HWR register.  */
	if ((symval & RNUM_MASK) == ((nanomips_hwr_names_3264r6[i].cp0_num
				      << NANOMIPSOP_SH_CP0SEL)
				     | nanomips_hwr_names_3264r6[i].cp0_sel))
	  {
	    symval = ((symval & ~RNUM_MASK)
		      | (nanomips_hwr_names_3264r6[i].num
			 << NANOMIPSOP_SH_CP0SEL)
		      | nanomips_hwr_names_3264r6[i].sel);
	    break;
	  }
    }
  else if (type == OP_REG_HWRSEL && (symval & RTYPE_MASK) != RTYPE_NUM)
    {
      if ((symval & RNUM_MASK) == NANOMIPS_CP0SEL_PERFCNT)
	symval = (symval & ~RNUM_MASK) | NANOMIPS_HWRSEL_PERFCNT;
      else
	return FALSE;
    }

  *regno = symval & RNUM_MASK;
  check_regno (arg, type, *regno);
  return TRUE;
}

/* Try to interpret the next token in ARG as a register of type TYPE.
   Consume the token and return true on success, storing the register
   number in *REGNO.  Return false on failure.  */

static bfd_boolean
match_reg (struct nanomips_arg_info *arg, enum nanomips_reg_operand_type type,
	   unsigned int *regno)
{
  if (arg->token->type == OT_REG
      && match_regno (arg, type, arg->token->u.regno, regno))
    {
      ++arg->token;
      return TRUE;
    }
  return FALSE;
}

/* Try to interpret the next token in ARG as a range of registers of type TYPE.
   Consume the token and return true on success, storing the register numbers
   in *REGNO1 and *REGNO2.  Return false on failure.  */

static bfd_boolean
match_reg_range (struct nanomips_arg_info *arg,
		 enum nanomips_reg_operand_type type, unsigned int *regno1,
		 unsigned int *regno2)
{
  if (match_reg (arg, type, regno1))
    {
      *regno2 = *regno1;
      return TRUE;
    }
  if (arg->token->type == OT_REG_RANGE
      && match_regno (arg, type, arg->token->u.reg_range.regno1, regno1)
      && match_regno (arg, type, arg->token->u.reg_range.regno2, regno2)
      && *regno1 <= *regno2)
    {
      ++arg->token;
      return TRUE;
    }
  return FALSE;
}

/* OP_INT matcher.  */

static bfd_boolean
match_relocatable_int_operand (const struct nanomips_operand *operand_base)
{
  const struct nanomips_int_operand *operand;
  unsigned int op_size;

  operand = (const struct nanomips_int_operand *) operand_base;
  op_size = operand_base->size;

  if ((op_size == 7
	   && operand->shift == 2)
	  || (op_size == 4
	      && operand->shift == 2)
	  || op_size == 12
	  || op_size == 14
	  || op_size == 16
	  || op_size == 17
	  || op_size == 18
	  || op_size == 19
	  || op_size == 20)
    return TRUE;

  return FALSE;
}

/* Negative 12-bit constant matcher.  */

static bfd_boolean
match_negative_int_operand (struct nanomips_arg_info *arg,
			    const struct nanomips_operand *operand_base)
{
  offsetT sval;

  if (!match_const_int (arg, &sval))
    return FALSE;
  if ((int) sval > 0 || (int) sval < -4095)
    return FALSE;
  sval = -(int) sval;

  insn_insert_operand (arg->insn, operand_base, sval);
  return TRUE;
}

/* Check if OPERAND_BASE matches a suitable variant of relocation RTYPE.  */

static bfd_boolean
match_flex_reloc_for_int_operand (const struct nanomips_operand *operand_base,
				  bfd_reloc_code_real_type rtype)
{
  size_t i;
  int opmask = nanomips_operand_mask (operand_base);
  const bfd_reloc_code_real_type gp_relocs[] = {
    BFD_RELOC_NANOMIPS_GPREL18,
    BFD_RELOC_NANOMIPS_GPREL19_S2,
    BFD_RELOC_NANOMIPS_GPREL18_S3,
    BFD_RELOC_NANOMIPS_GPREL16_S2,
    BFD_RELOC_NANOMIPS_GPREL17_S1,
    BFD_RELOC_NANOMIPS_GPREL7_S2
  };
  const bfd_reloc_code_real_type tp_relocs[] = {
    BFD_RELOC_NANOMIPS_TLS_TPREL12,
    BFD_RELOC_NANOMIPS_TLS_TPREL16
  };
  const bfd_reloc_code_real_type dtp_relocs[] = {
    BFD_RELOC_NANOMIPS_TLS_DTPREL12,
    BFD_RELOC_NANOMIPS_TLS_DTPREL16
  };
  size_t rcount;
  const bfd_reloc_code_real_type *rlist;

  switch (rtype)
    {
      case BFD_RELOC_NANOMIPS_GPREL18:
	rlist = gp_relocs;
	rcount = ARRAY_SIZE (gp_relocs);
	break;
      case BFD_RELOC_NANOMIPS_TLS_TPREL12:
	rlist = tp_relocs;
	rcount = ARRAY_SIZE (tp_relocs);
	break;
      case BFD_RELOC_NANOMIPS_TLS_DTPREL12:
	rlist = dtp_relocs;
	rcount = ARRAY_SIZE (dtp_relocs);
	break;
      default:
	rlist = &rtype;
	rcount = 1;
	break;
    }

  for (i = 0; i < rcount; i++)
    {
      reloc_howto_type *howto;
      howto = bfd_reloc_type_lookup (stdoutput, rlist[i]);

      if ((howto->dst_mask & opmask) == howto->dst_mask
	  && howto->bitsize == operand_base->size)
	return TRUE;
    }

  return FALSE;
}

/* Generic INT matcher.  */

static bfd_boolean
match_int_operand (struct nanomips_arg_info *arg,
		   const struct nanomips_operand *operand_base)
{
  const struct nanomips_int_operand *operand;
  unsigned int uval;
  int min_val, max_val, factor;
  offsetT sval;

  operand = (const struct nanomips_int_operand *) operand_base;
  factor = 1 << operand->shift;
  min_val = nanomips_int_operand_min (operand);
  max_val = nanomips_int_operand_max (operand);

  if (match_relocatable_int_operand (operand_base))
    {
      /* The operand can be relocated.  */
      if (!match_expression (arg, &offset_expr, offset_reloc))
	return FALSE;

      if (offset_reloc[0] != BFD_RELOC_UNUSED
	  && !nanomips_48bit_reloc_p (offset_reloc[0]))
	/* Relocation operators were used.  Check if relocation
	   destination mask matches operand bits.  */
	{
	  if (flex_reloc_p (offset_reloc[0]))
	    return match_flex_reloc_for_int_operand (operand_base,
						     offset_reloc[0]);
	  else
	    {
	      int opmask;
	      reloc_howto_type *howto;

	      if (offset_reloc[0] == BFD_RELOC_NANOMIPS_LO12
		  && (forced_insn_length == 2
		      || (forced_insn_format &&
			  insn_length (arg->insn->insn_mo) == 2)))
		offset_reloc[0] = BFD_RELOC_NANOMIPS_LO4_S2;

	      howto = bfd_reloc_type_lookup (stdoutput, offset_reloc[0]);
	      opmask = nanomips_operand_mask (operand_base);
	      /* This is not an direct mask comparison.  In some cases
		 the relocation targets only a part of the operand bits.  */
	      match_out_of_range (arg);	      
	      return ((howto->dst_mask & opmask) == howto->dst_mask);
	    }
	}

      if (offset_expr.X_op != O_constant)
	{
	  /* Accept non-constant operands if no later alternative matches,
	     leaving it for the caller to process.  */
	  if (operand_base->size == 16 && offset_expr.X_op == O_subtract)
	    {
	      offset_reloc[0] = BFD_RELOC_UNUSED + RT_ADDIU;
	      return TRUE;
	    }
	  else if (offset_expr.X_op == O_symbol)
	    {
	      match_out_of_range (arg);
	      return FALSE;
	    }
	  else
	    {
	      offset_reloc[0] = BFD_RELOC_NANOMIPS_LO12;
	      return arg->lax_match;
	    }
	}

      /* Clear the global state; we're going to install the operand
	  ourselves.  */
      if (min_val < 0)
	sval = (int) offset_expr.X_add_number;
      else
	sval = offset_expr.X_add_number;

      offset_expr.X_op = O_absent;

      /* For compatibility with older assemblers, we accept
	 0x8000-0xffff as signed 16-bit numbers when only
	 signed numbers are allowed.  */
      if (sval > max_val)
	{
	  max_val = ((1 << operand_base->size) - 1) << operand->shift;
	  if (!arg->lax_match && sval <= max_val)
	    return FALSE;
	}
    }
  else
    {
      if (!match_const_int (arg, &sval))
	return FALSE;
      if (min_val < 0 && IS_ZEXT_32BIT_NUM(sval))
	sval = (int) sval;
    }

  arg->last_op_int = sval;

  if (sval < min_val || sval > max_val || sval % factor)
    {
      match_out_of_range (arg);
      return FALSE;
    }

  uval = (unsigned int) sval >> operand->shift;
  uval -= operand->bias;

  insn_insert_operand (arg->insn, operand_base, uval);
  return TRUE;
}

/* Match integer operand with no relocation.  */
static bfd_boolean
match_imm_int_operand (struct nanomips_arg_info *arg,
		       const struct nanomips_operand *operand_base)
{
  if (!match_int_operand (arg, operand_base))
    return FALSE;

  return ((offset_expr.X_op == O_absent || offset_expr.X_op == O_constant)
	  && *offset_reloc == BFD_RELOC_UNUSED);
}

#define MAX_ADDI_OFFSET (0xffff)

#define MIN_ADDI_OFFSET (-4095)


static bfd_boolean
match_int_word (struct nanomips_arg_info *arg,
		const struct nanomips_operand *operand ATTRIBUTE_UNUSED)
{
  if (match_expression (arg, &offset_expr, offset_reloc))
    {
      if (offset_reloc[0] != BFD_RELOC_UNUSED
	  && !nanomips_48bit_reloc_p (offset_reloc[0])
	  && !flex_reloc_p (offset_reloc[0]))
	/* Any other relocation operators not allowed in this position.  */
	return FALSE;

      if (offset_reloc[0] == BFD_RELOC_UNUSED)
	offset_reloc[0] = BFD_RELOC_NANOMIPS_I32;

      /* We don't match symbol-difference expressions here.  */
      if (offset_expr.X_op != O_constant && offset_expr.X_op_symbol == NULL)
	{
	  arg->insn->insn_opcode_ext = 0;
	  return TRUE;
	}
      else
	if ((forced_insn_length == 6
	     || forced_insn_format
	     || offset_expr.X_add_number > MAX_ADDI_OFFSET
	     || offset_expr.X_add_number < MIN_ADDI_OFFSET)
	    && offset_expr.X_op != O_big)
	/* We don't match the 48-bit instruction, when we could make
	   do with a 32-bit one, unless explicitly required.  */
	{
	  arg->last_op_int = offset_expr.X_add_number;
	  arg->insn->insn_opcode_ext = 0;
	  return TRUE;
	}
    }

  return FALSE;
}

/* Match an immediate 32-bit value with possible bias.  */
static bfd_boolean
match_imm_word (struct nanomips_arg_info *arg,
		const struct nanomips_operand *operand_base)
{
  const struct nanomips_int_operand *operand;
  operand = (const struct nanomips_int_operand *) operand_base;

  if (match_expression (arg, &offset_expr, offset_reloc))
    {
      if (offset_expr.X_op != O_constant || *offset_reloc != BFD_RELOC_UNUSED)
	return FALSE;

      if (offset_expr.X_op != O_big)
	{
	  int sval = offset_expr.X_add_number - operand->bias;
	  arg->last_op_int = sval;
	  arg->insn->insn_opcode_ext = 0;
	  arg->insn->insn_opcode_ext = (((sval >> 16) & 0xffff)
					| (sval << 16));
	  offset_expr.X_op = O_absent;
	  return TRUE;
	}
    }

  return FALSE;
}

static bfd_boolean
match_pcrel_word (struct nanomips_arg_info *arg,
		  const struct nanomips_operand *operand ATTRIBUTE_UNUSED)
{
  if (match_expression (arg, &offset_expr, offset_reloc))
    {
      if (offset_reloc[0] != BFD_RELOC_UNUSED
	  && !nanomips_48bit_reloc_p (offset_reloc[0]))
	/* Any other relocation operators not allowed in this position.  */
	return FALSE;

      if (offset_reloc[0] == BFD_RELOC_UNUSED)
	offset_reloc[0] = BFD_RELOC_NANOMIPS_PC_I32;

      arg->insn->insn_opcode_ext = 0;
      return TRUE;
    }
  return FALSE;
}

static bfd_boolean
match_gprel_word (struct nanomips_arg_info *arg,
		  const struct nanomips_operand *operand ATTRIBUTE_UNUSED)
{
  if (match_expression (arg, &offset_expr, offset_reloc))
    {
      if (offset_reloc[0] != BFD_RELOC_UNUSED
	  && !gprel_i32_reloc_p (offset_reloc[0])
	  && !gprel16_reloc_p (offset_reloc[0]))
	/* Any other relocation operators not allowed in this position.  */
	return FALSE;

      if (offset_reloc[0] == BFD_RELOC_UNUSED)
	offset_reloc[0] = BFD_RELOC_NANOMIPS_GPREL_I32;

      arg->insn->insn_opcode_ext = 0;
      return TRUE;
    }
  return FALSE;
}

/* OP_MAPPED_INT matcher.  */
static bfd_boolean
match_mapped_int_operand (struct nanomips_arg_info *arg,
			  const struct nanomips_operand *operand_base)
{
  const struct nanomips_mapped_int_operand *operand;
  unsigned int uval, num_vals;
  offsetT sval;

  operand = (const struct nanomips_mapped_int_operand *) operand_base;
  if (!match_const_int (arg, &sval))
    return FALSE;

  num_vals = 1 << operand_base->size;
  for (uval = 0; uval < num_vals; uval++)
    if (operand->int_map[uval] == sval)
      break;
  if (uval == num_vals)
    {
      match_out_of_range (arg);
      return FALSE;
    }

  insn_insert_operand (arg->insn, operand_base, uval);
  return TRUE;
}

/* OP_MSB matcher.  */

static bfd_boolean
match_msb_operand (struct nanomips_arg_info *arg,
		   const struct nanomips_operand *operand_base)
{
  const struct nanomips_msb_operand *operand;
  int min_val, max_val, max_high;
  offsetT size, sval, high;

  operand = (const struct nanomips_msb_operand *) operand_base;
  min_val = operand->bias;
  max_val = min_val + (1 << operand_base->size) - 1;
  max_high = operand->opsize;

  if (!match_const_int (arg, &size))
    return FALSE;

  high = size + arg->last_op_int;
  sval = operand->add_lsb ? high : size;

  if (size < 0 || high > max_high || sval < min_val || sval > max_val)
    {
      match_out_of_range (arg);
      return FALSE;
    }
  insn_insert_operand (arg->insn, operand_base, sval - min_val);
  return TRUE;
}

/* OP_REG matcher.  */

static bfd_boolean
match_reg_operand (struct nanomips_arg_info *arg,
		   const struct nanomips_operand *operand_base)
{
  const struct nanomips_reg_operand *operand;
  unsigned int regno, uval, num_vals;

  operand = (const struct nanomips_reg_operand *) operand_base;
  if (!match_reg (arg, operand->reg_type, &regno))
    return FALSE;

  if (operand->reg_map)
    {
      num_vals = 1 << operand->root.size;
      for (uval = 0; uval < num_vals; uval++)
	if (operand->reg_map[uval] == regno)
	  break;
      if (num_vals == uval)
	return FALSE;
    }
  else
    uval = regno;

  if (operand_base->size > 0
      && uval >= (unsigned int) (1 << operand_base->size))
    {
      match_out_of_range (arg);
      return FALSE;
    }

  arg->last_regno = regno;
  if (arg->opnum == 1)
    arg->dest_regno = regno;
  insn_insert_operand (arg->insn, operand_base, uval);
  return TRUE;
}

/* OP_REG_PAIR matcher.  */

static bfd_boolean
match_reg_pair_operand (struct nanomips_arg_info *arg,
			const struct nanomips_operand *operand_base)
{
  const struct nanomips_reg_pair_operand *operand;
  unsigned int regno1, regno2, uval, num_vals;

  operand = (const struct nanomips_reg_pair_operand *) operand_base;
  if (!match_reg (arg, operand->reg_type, &regno1)
      || !match_char (arg, ',')
      || !match_reg (arg, operand->reg_type, &regno2))
    return FALSE;

  num_vals = 1 << operand_base->size;
  for (uval = 0; uval < num_vals; uval++)
    if (operand->reg1_map[uval] == regno1
	&& operand->reg2_map[uval] == regno2)
      break;
  if (uval == num_vals)
    return FALSE;

  insn_insert_operand (arg->insn, operand_base, uval);
  return TRUE;
}

/* OP_PCREL matcher.  The caller chooses the relocation type.  */

static bfd_boolean
match_pcrel_operand (struct nanomips_arg_info *arg)
{
  bfd_reloc_code_real_type r[3];

  return match_expression (arg, &offset_expr, r) && r[0] == BFD_RELOC_UNUSED;
}

static bfd_boolean
match_non_zero_pcrel_operand (struct nanomips_arg_info *arg,
			      const struct nanomips_operand *operand_base)
{
  bfd_reloc_code_real_type r[3];

  if (!match_expression (arg, &offset_expr, r) || r[0] != BFD_RELOC_UNUSED)
    return FALSE;

  if (!offset_expr.X_add_symbol && offset_expr.X_add_number == 0)
    {
      set_insn_error (arg->argnum,
		      _("the PC relative offset must not be $0"));
      return FALSE;
    }

  /* Enforce operand bits in the instruction encoding as non-zero
     so that it can be distinguished from another instructions with the same
     encoding and 0 in these bit positions.  Requires the relocation
     scheme to be RELA, which is trivially true only for nanoMIPS.  The check
     for ISA just to be on the safe side.  */
  insn_insert_operand (arg->insn, operand_base,
		       (1 << operand_base->size) - 1);
  return TRUE;
}

/* OP_HI20_INT matcher.  */

#define UNSIGNED_OPVALUE(OP)					\
{ { OP_INT, OP->size, OP->lsb, OP->size_top, OP->lsb_top },	\
    ((1 << OP->size) - 1), 0, 0, FALSE }

#define SIGNEX_OPVALUE(OP) { OP_INT, OP->size - 1, OP->lsb, 0, 0 }

static bfd_boolean
match_hi20_int_operand (struct nanomips_arg_info *arg,
			const struct nanomips_operand *operand_base ATTRIBUTE_UNUSED)
{
  offsetT uval = 0;
  const struct nanomips_int_operand op_enc = { {OP_INT, 20, 2, 1, 0},
					       (1 << 20) - 1, 12, 0, FALSE };
  const struct nanomips_int_operand op_shuffle = { {OP_INT, 19, 10, 10, 0},
						   (1 << 19) - 1, 12, 0, FALSE };

  if (!match_expression (arg, &offset_expr, offset_reloc))
    return FALSE;

  /* 16-bit immediate without %hi reloc  */
  if (offset_reloc[0] == BFD_RELOC_UNUSED && offset_expr.X_op == O_constant)
    {
      if ((offset_expr.X_add_number & ~0xffff) == 0)
	uval = offset_expr.X_add_number << 4;
      else
	{
	  match_out_of_range (arg);
	  return FALSE;
	}
    }
  /* 20-bit high part using %hi  */
  else if (hi_reloc_p (offset_reloc[0]))
    uval = offset_expr.X_add_number >> 12;
  else
    {
      /* Accept non-constant operands if no later alternative matches,
	 leaving it for the caller to process.  */
      if (arg->lax_match)
	offset_reloc[0] = BFD_RELOC_NANOMIPS_HI20;
      return arg->lax_match;
    }

  if (offset_expr.X_op == O_constant)
    {
      offset_expr.X_op = O_absent;
      /* Re-shuffle and insert lower 19-bits, exluding sign.  */
      uval = nanomips_insert_operand (&op_shuffle.root,
				      uval & 0x80000, uval & 0x7ffff);

      /* Insert 20-bits in to instruction.  */
      insn_insert_operand (arg->insn, &op_enc.root, uval);
    }

  return TRUE;
}

/* OP_HI20_PCREL matcher.  Relocation must be specified.  */
static bfd_boolean
match_hi20_pcrel_operand (struct nanomips_arg_info *arg)
{
  const struct nanomips_int_operand op_enc = { {OP_INT, 20, 2, 1, 0 },
					       (1 << 20) - 1, 0, 0, FALSE };
  const struct nanomips_int_operand op_shuffle = { {OP_INT, 19, 10, 10, 0},
						   (1 << 19) - 1, 0, 0, FALSE };
  /* Encode full 20-bit signed value.  */
  if (!match_expression (arg, &offset_expr, offset_reloc))
    return FALSE;

  if (offset_reloc[0] == BFD_RELOC_UNUSED)
    {
      unsigned int uval = offset_expr.X_add_number;
      /* Re-shuffle and insert lower 19-bits, exluding sign.  */
      uval = nanomips_insert_operand (&op_shuffle.root,
				      uval & 0x80000, uval & 0x7ffff);
      /* Insert 20-bits in to instruction.  */
      insn_insert_operand (arg->insn, &op_enc.root, uval);
      /* Expression is completely handled, we don't want append_insn
	 messing up the opcode.  */
      offset_expr.X_op = O_absent;
      return TRUE;
    }
  else
    return (offset_reloc[0] == BFD_RELOC_NANOMIPS_PCREL_HI20
	    || offset_reloc[0] == BFD_RELOC_NANOMIPS_GOTPC_HI20);
}

static bfd_boolean
match_hi20_scaled_operand (struct nanomips_arg_info *arg)
{
  const struct nanomips_int_operand op_enc = { {OP_INT, 20, 2, 1, 0},
					       (1 << 20) - 1, 12, 0, FALSE};
  const struct nanomips_int_operand op_shuffle = { {OP_INT, 19, 10, 10, 0},
						   (1 << 19) - 1, 12, 0,
						   FALSE };
  offsetT uval = 0;

  if (!match_const_int (arg, &uval) || (uval & 0xfff) != 0)
    return FALSE;

  uval = uval >> 12;
  offset_expr.X_op = O_absent;

  /* Re-shuffle and insert lower 19-bits, exluding sign.  */
  uval = nanomips_insert_operand (&op_shuffle.root,
				  uval & 0x80000, uval & 0x7ffff);

  /* Insert 20-bits in to instruction.  */
  insn_insert_operand (arg->insn, &op_enc.root, uval);

  return TRUE;
}

/* OP_CHECK_PREV matcher.  */

static bfd_boolean
match_check_prev_operand (struct nanomips_arg_info *arg,
			  const struct nanomips_operand *operand_base)
{
  const struct nanomips_check_prev_operand *operand;
  unsigned int regno;

  operand = (const struct nanomips_check_prev_operand *) operand_base;

  if (!match_reg (arg, OP_REG_GP, &regno))
    return FALSE;

  if (!operand->zero_ok && regno == 0)
    return FALSE;

  if ((operand->less_than_ok && regno < arg->last_regno)
      || (operand->greater_than_ok && regno > arg->last_regno)
      || (operand->equal_ok && regno == arg->last_regno))
    {
      arg->last_regno = regno;
      insn_insert_operand (arg->insn, operand_base, regno);
      return TRUE;
    }

  return FALSE;
}

/* OP_MAPPED_CHECK_PREV matcher.  */

static bfd_boolean
match_mapped_check_prev_operand (struct nanomips_arg_info *arg,
				 const struct nanomips_operand *operand_base)
{
  unsigned char uval, last_uval;
  const struct nanomips_mapped_check_prev_operand *operand
    = (const struct nanomips_mapped_check_prev_operand *) operand_base;

  last_uval = nanomips_encode_reg_operand (operand_base, arg->last_regno);

  if (!match_reg_operand (arg, operand_base))
    return FALSE;

  if (!operand->zero_ok && arg->last_regno == 0)
    return FALSE;

  uval = nanomips_encode_reg_operand (operand_base, arg->last_regno);

  if ((operand->less_than_ok && uval < last_uval)
      || (operand->greater_than_ok && uval > last_uval)
      || (operand->equal_ok && uval == last_uval))
    return TRUE;

  return FALSE;
}

/* OP_SAVE_RESTORE_FP_LIST matcher for nanoMIPS.  */

static bfd_boolean
match_save_restore_fp_list_operand (struct nanomips_arg_info *arg,
				    const struct nanomips_operand *operand)
{
  unsigned int opval;
  unsigned int regno1, regno2;

  if (!match_reg_range (arg, OP_REG_FP, &regno1, &regno2))
    return FALSE;

  if (regno1 != 0 || regno2 > 15)
    return FALSE;

  opval = (regno2 - regno1);

  insn_insert_operand (arg->insn, operand, opval);
  return TRUE;
}

/* OP_SAVE_RESTORE_LIST matcher.  */

static bfd_boolean
match_save_restore_list_operand (struct nanomips_arg_info *arg,
				 const struct nanomips_operand *operand)
{
  unsigned int opval, count;
  unsigned first_reg, last_reg;
  bfd_boolean mode16 = (insn_length (arg->insn->insn_mo) == 2);
  bfd_boolean gp = FALSE;

  count = 0;
  first_reg = last_reg = RNUM_MASK + 1;
  do
    {
      unsigned int regno1 = 0, regno2 = 0;

      if (!match_reg_range (arg, OP_REG_GP, &regno1, &regno2))
	{
	  arg->token--;
	  if (regno2 != 0 && regno2 < regno1)
	    set_insn_error_ss (count,
			       "register range (%s-%s) is not in increasing order",
			       nanomips_reg_names[32 + regno1].name,
			       nanomips_reg_names[32 + regno2].name);
	  return FALSE;
	}

      if (first_reg == RNUM_MASK + 1)
	first_reg = last_reg = regno1;
      else if (regno1 != ((first_reg & 0x10) | (last_reg + 1) % 32))
	{
	  /* a non-contiguous sequence */
	  if (regno1 == 28 && !mode16 && (nanomips_opts.ase & ASE_xNMS) != 0)
	    /* enable GP special casing if possible */
	    gp = TRUE;
	  else if (regno1 == 28 && (nanomips_opts.ase & ASE_xNMS) == 0)
	    {
	      set_insn_error_ss (count,
				 "non-contiguous %s of $gp is not available "
				 "for nanoMIPS subset%s",
				 arg->insn->insn_mo->name, "");
	      return FALSE;
	    }
	  else if (regno1 == 28 && mode16)
	    {
	      set_insn_error_ss (count,
				 "non-contiguous %s of $gp is not available "
				 "for 16-bit instructions%s",
				 arg->insn->insn_mo->name, "");
	      return FALSE;
	    }
	  else
	    {
	      if (regno1 == 30 && first_reg != 30)
		set_insn_error (count, "$fp must be the first register in "
				"the list");
	      else if (regno1 == 31 && first_reg != 30 && first_reg != 31)
		set_insn_error (count, "$ra must be the first register in "
				"the list");
	      else if (last_reg == 31 && regno1 != 16)
		set_insn_error_ss (count + 1, "%s must be followed by %s",
				   nanomips_reg_names[32 + last_reg].name,
				   nanomips_reg_names[32 + 16].name);
	      else
		set_insn_error_ss (regno1,
				   "register list not contiguous between "
				   "%s and %s",
				   nanomips_reg_names[32 + last_reg].name,
				   nanomips_reg_names[32 + regno1].name);
	      return FALSE;
	    }
	}

      if (regno1 <= 29 && regno2 >= 29)
	{
	  set_insn_error_ss (regno1,
			     "%s register list should not contain $sp%s",
			     arg->insn->insn_mo->name, "");
	  return FALSE;
	}

      last_reg = regno2;

      /* sequence  */
      while (regno1++ <= regno2)
	count += 1;
    }
  while (match_char (arg, ','));

  /* too few or too many registers in list */
  if (count >= 16)
    {
      set_insn_error_si (count,
			 "%s can handle a maximum of 16 register, %d requested",
			 arg->insn->insn_mo->name, count);
      return FALSE;
    }

  if (mode16 && first_reg < 30)
    {
      set_insn_error_ss (count + 1,
			 "first register for 16-bit %s must be $fp or $ra%s",
			 arg->insn->insn_mo->name, "");
      return FALSE;
    }

  if (count * (GPR_SIZE / 8) > arg->last_op_int)
    as_warn ("frame too small for save/restore register list");

  if (mode16)
    opval = ((first_reg & 0x1) << 4) | count;
  else
    opval = ((first_reg << 6) | (count << 1) | gp);

  /* Finally build the instruction.  */
  insn_insert_operand (arg->insn, operand, opval);
  if (nanomips_opts.linkrelax
      && nanomips_opts.pic != NO_PIC
      && gp
      && (arg->insn->insn_opcode & 0x3) != 2)
    {
      symbolS *sym = symbol_find_or_make ("none");
      symbol_table_insert (sym);
      offset_expr.X_op = O_symbol;
      offset_expr.X_add_symbol = sym;
      offset_reloc[0] = BFD_RELOC_NANOMIPS_SAVERESTORE;
    }

  return TRUE;
}

/* OP_NON_ZERO_REG matcher.  */

static bfd_boolean
match_non_zero_reg_operand (struct nanomips_arg_info *arg,
			    const struct nanomips_operand *operand)
{
  unsigned int regno;

  if (!match_reg (arg, OP_REG_GP, &regno))
    return FALSE;

  if (regno == 0)
    {
      const unsigned long pinfo = arg->insn->insn_mo->pinfo;
      unsigned int regtype;
      const char *regstr[] = { "source", "target" };

      if ((arg->opnum == 1 && (pinfo & INSN_WRITE_1) != 0)
	  || (arg->opnum == 2 && (pinfo & INSN_WRITE_2) != 0))
	regtype = 1;
      else
	regtype = 0;

      set_insn_error_ss (arg->argnum, _("the %s register must not be $0%s"),
			 regstr[regtype], "");
      return FALSE;
    }

  arg->last_regno = regno;
  insn_insert_operand (arg->insn, operand, regno);
  return TRUE;
}

/* OP_REPEAT_DEST_REG and OP_REPEAT_PREV_REG matcher.  OTHER_REGNO is the
   register that we need to match.  */

static bfd_boolean
match_tied_reg_operand (struct nanomips_arg_info *arg,
			unsigned int other_regno)
{
  unsigned int regno;

  return match_reg (arg, OP_REG_GP, &regno) && regno == other_regno;
}

/* OP_BASE_CHECK_OFFSET matcher.  */

static bfd_boolean
match_base_checked_offset_operand (struct nanomips_arg_info *arg,
				   const struct nanomips_operand *operand_base)
{
  unsigned int regno;
  const struct nanomips_base_check_offset_operand *operand
    = (const struct nanomips_base_check_offset_operand *) operand_base;

  if (!match_reg (arg, OP_REG_GP, &regno))
    return FALSE;

  if ((operand->const_ok
       && (offset_expr.X_op == O_constant || offset_expr.X_op == O_absent))
      || (operand->expr_ok
	  && (offset_expr.X_op == O_symbol || offset_expr.X_op == O_absent))
      || (regno == 0)
      || lo_reloc_p (offset_reloc[0]))
    {
      arg->last_regno = regno;
      insn_insert_operand (arg->insn, operand_base, regno);
      return TRUE;
    }

  return FALSE;
}


/* Read a floating-point constant from S for LI.S or LI.D.  LENGTH is
   the length of the value in bytes (4 for float, 8 for double) and
   USING_GPRS says whether the destination is a GPR rather than an FPR.

   Return the constant in IMM and OFFSET as follows:

   - If the constant should be loaded via memory, set IMM to O_absent and
     OFFSET to the memory address.

   - Otherwise, if the constant should be loaded into two 32-bit registers,
     set IMM to the O_constant to load into the high register and OFFSET
     to the corresponding value for the low register.

   - Otherwise, set IMM to the full O_constant and set OFFSET to O_absent.

   These constants only appear as the last operand in an instruction,
   and every instruction that accepts them in any variant accepts them
   in all variants.  This means we don't have to worry about backing out
   any changes if the instruction does not match.  We just match
   unconditionally and report an error if the constant is invalid.  */

static bfd_boolean
match_float_constant (struct nanomips_arg_info *arg, expressionS *imm,
		      expressionS *offset, unsigned int length,
		      bfd_boolean using_gprs)
{
  char *p;
  segT seg;
  subsegT subseg;
  unsigned char *data;

  /* Where the constant is placed is based on how the nanoMIPS assembler
     does things:

     length == 4 && using_gprs  -- immediate value only
     length == 8 && using_gprs  -- .rdata or immediate value
     length <= -Gnum -- .sdata
     length >= -Gnum  -- .rodata

     The .sdata sections are only used if permitted by the -G argument.  */
  if (arg->token->type != OT_FLOAT)
    {
      set_insn_error (arg->argnum, _("floating-point expression required"));
      return FALSE;
    }

  gas_assert (arg->token->u.flt.length == (int)length);
  data = arg->token->u.flt.data;
  ++arg->token;

  /* Handle 32-bit constants -- immediate value is best.  */
  if (length == 4
      && !nanomips_disable_float_construction)
    {
      imm->X_op = O_constant;
      if (!target_big_endian)
	imm->X_add_number = bfd_getl32 (data);
      else
	imm->X_add_number = bfd_getb32 (data);
      offset->X_op = O_absent;
      return TRUE;
    }

  /* Handle 64-bit constants for which an immediate value is best.  */
  if (length == 8
      && !nanomips_disable_float_construction
      && ((data[0] == 0 && data[1] == 0)
	  || (data[2] == 0 && data[3] == 0)
	  || ((nanomips_opts.ase & ASE_xNMS) != 0 && using_gprs))
      && ((data[4] == 0 && data[5] == 0)
	  || (data[6] == 0 && data[7] == 0)
	  || ((nanomips_opts.ase & ASE_xNMS) != 0 && using_gprs)))
    {
      /* The value is simple enough to load with a couple of instructions.
	 If using 32-bit registers, set IMM to the high order 32 bits and
	 OFFSET to the low order 32 bits.  Otherwise, set IMM to the entire
	 64 bit constant.  */
      if (GPR_SIZE == 32)
	{
	  imm->X_op = O_constant;
	  offset->X_op = O_constant;
	  if (!target_big_endian)
	    {
	      imm->X_add_number = bfd_getl32 (data + 4);
	      offset->X_add_number = bfd_getl32 (data);
	    }
	  else
	    {
	      imm->X_add_number = bfd_getb32 (data);
	      offset->X_add_number = bfd_getb32 (data + 4);
	    }
	  if (offset->X_add_number == 0)
	    offset->X_op = O_absent;
	}
      else
	{
	  imm->X_op = O_constant;
	  if (!target_big_endian)
	    imm->X_add_number = bfd_getl64 (data);
	  else
	    imm->X_add_number = bfd_getb64 (data);
	  offset->X_op = O_absent;
	}
      return TRUE;
    }

  /* Switch to the right section.  */
  seg = now_seg;
  subseg = now_subseg;

  if (!using_gprs && g_switch_value >= length && nanomips_opts.pic == NO_PIC)
    s_change_sec ('s');
  else
    s_change_sec ('r');

  if (seg == now_seg)
    as_bad (_("cannot use `%s' in this section"), arg->insn->insn_mo->name);

  /* Set the argument to the current address in the section.  */
  imm->X_op = O_absent;
  offset->X_op = O_symbol;
  offset->X_add_symbol = symbol_temp_new_now ();
  offset->X_add_number = 0;

  /* Put the floating point number into the section.  */
  p = frag_more (length);
  memcpy (p, data, length);

  /* Switch back to the original section.  */
  subseg_set (seg, subseg);
  return TRUE;
}

/* Copy bits from one part of an instruction to another part.
   Source bits are specified by size & lsb.  Destination bits
   are specified by size_top and lsb_top.  */
static bfd_boolean
match_copy_bits (struct nanomips_arg_info *arg,
		 const struct nanomips_operand *operand)
{
  const struct nanomips_operand op_src = { OP_INT, operand->size,
					   operand->lsb, 0, 0 };
  const struct nanomips_operand op_dest = { OP_INT, operand->size_top,
					    operand->lsb_top, 0, 0 };
  unsigned int uval;

  uval = nanomips_extract_operand (&op_src, arg->insn->insn_opcode);
  insn_insert_operand (arg->insn, &op_dest, uval);
  return TRUE;
}

/* Select value for a named COP0 register.  */
static bfd_boolean
match_cp0_select (struct nanomips_arg_info *arg,
		  const struct nanomips_operand *operand)
{
  offsetT uval;

  /* Expect an immediate select value between 0 & 31.  */
  if (!match_const_int (arg, &uval)
      || uval < 0
      || uval >= (1 << NANOMIPSOP_SH_CP0SEL))
    return FALSE;

  /* Check if this select value is allowed by the saved mask of the last
     seen CP0 register.  */
  if (((1 << uval) & arg->select_mask) == 0)
    return FALSE;

  insn_insert_operand (arg->insn, operand, uval);
  return TRUE;
}

/* S is the text seen for ARG.  Match it against OPERAND.  Return the end
   of the argument text if the match is successful, otherwise return null.  */

static bfd_boolean
match_operand (struct nanomips_arg_info *arg,
	       const struct nanomips_operand *operand)
{
  switch (operand->type)
    {
    case OP_INT:
      return match_int_operand (arg, operand);

    case OP_MAPPED_INT:
      return match_mapped_int_operand (arg, operand);

    case OP_MSB:
      return match_msb_operand (arg, operand);

    case OP_REG:
    case OP_OPTIONAL_REG:
      return match_reg_operand (arg, operand);

    case OP_REG_PAIR:
      return match_reg_pair_operand (arg, operand);

    case OP_PCREL:
      return match_pcrel_operand (arg);

    case OP_SAVE_RESTORE_LIST:
      return match_save_restore_list_operand (arg, operand);

    case OP_SAVE_RESTORE_FP_LIST:
      return match_save_restore_fp_list_operand (arg, operand);

    case OP_REPEAT_DEST_REG:
      return match_tied_reg_operand (arg, arg->dest_regno);

    case OP_REPEAT_PREV_REG:
      return match_tied_reg_operand (arg, arg->last_regno);

    case OP_CHECK_PREV:
      return match_check_prev_operand (arg, operand);

    case OP_NON_ZERO_REG:
      return match_non_zero_reg_operand (arg, operand);

    case OP_NON_ZERO_PCREL_S1:
      return match_non_zero_pcrel_operand (arg, operand);

    case OP_HI20_PCREL:
      return match_hi20_pcrel_operand (arg);

    case OP_HI20_INT:
      return match_hi20_int_operand (arg, operand);

    case OP_HI20_SCALE:
      return match_hi20_scaled_operand (arg);

    case OP_MAPPED_CHECK_PREV:
      return match_mapped_check_prev_operand (arg, operand);

    case OP_UINT_WORD:
    case OP_INT_WORD:
      return match_int_word (arg, operand);

    case OP_PC_WORD:
      return match_pcrel_word (arg, operand);

    case OP_GPREL_WORD:
      return match_gprel_word (arg, operand);

    case OP_DONT_CARE:
      return FALSE;

    case OP_NEG_INT:
      return match_negative_int_operand (arg, operand);

    case OP_IMM_INT:
      return match_imm_int_operand (arg, operand);

    case OP_IMM_WORD:
      return match_imm_word (arg, operand);

    case OP_BASE_CHECK_OFFSET:
      return match_base_checked_offset_operand (arg, operand);

    case OP_COPY_BITS:
      return match_copy_bits (arg, operand);

    case OP_CP0SEL:
      return match_cp0_select (arg, operand);

    default:
      abort ();
    }
}

/* ARG is the state after successfully matching an instruction.
   Issue any queued-up warnings.  */

static void
check_completed_insn (struct nanomips_arg_info *arg)
{
  if (arg->seen_at)
    {
      if (AT == ATREG)
	as_warn (_("used $at without \".set noat\""));
      else
	as_warn (_("used $%u with \".set at=$%u\""), AT, AT);
    }
}

#define INSN_ERET	0x42000018
#define INSN_DERET	0x4200001f
#define INSN_DMULT	0x1c
#define INSN_DMULTU	0x1d

#define BASE_REG_EQ(INSN1, INSN2) 	\
  ((((INSN1) >> OP_SH_RS) & OP_MASK_RS) \
      == (((INSN2) >> OP_SH_RS) & OP_MASK_RS))

/* For microMIPS macros, we need to generate a local number label
   as the target of branches.  */
#define NANOMIPS_LABEL_CHAR		'\037'
static unsigned long nanomips_target_label;
static char nanomips_target_name[32];

static char *
nanomips_label_name (void)
{
  char *p = nanomips_target_name;
  char symbol_name_temporary[24];
  unsigned long l;
  int i;

  if (*p)
    return p;

  i = 0;
  l = nanomips_target_label;
#ifdef LOCAL_LABEL_PREFIX
  *p++ = LOCAL_LABEL_PREFIX;
#endif
  *p++ = 'L';
  *p++ = NANOMIPS_LABEL_CHAR;
  do
    {
      symbol_name_temporary[i++] = l % 10 + '0';
      l /= 10;
    }
  while (l != 0);
  while (i > 0)
    *p++ = symbol_name_temporary[--i];
  *p = '\0';

  return nanomips_target_name;
}

static void
nanomips_label_expr (expressionS *label_expr)
{
  label_expr->X_op = O_symbol;
  label_expr->X_add_symbol = symbol_find_or_make (nanomips_label_name ());
  label_expr->X_add_number = 0;
}

static void
nanomips_label_inc (void)
{
  nanomips_target_label++;
  *nanomips_target_name = '\0';
}

static void
nanomips_add_label (void)
{
  colon (nanomips_label_name ());
  nanomips_label_inc ();
}

/* If assembling nanoMIPS code, then return the nanoMIPS
   reloc corresponding to the requested one if any.  Otherwise
   return the reloc unchanged.
*/

static bfd_reloc_code_real_type
nanomips_map_reloc (bfd_reloc_code_real_type reloc)
{
  static const bfd_reloc_code_real_type relocs[][2] = {
    /* Keep sorted incrementally by the left-hand key.  */
    {BFD_RELOC_GPREL16, BFD_RELOC_NANOMIPS_GPREL18},
    {BFD_RELOC_HI16, BFD_RELOC_NANOMIPS_HI20},
    {BFD_RELOC_HI16_S, BFD_RELOC_NANOMIPS_HI20},
    {BFD_RELOC_LO16, BFD_RELOC_NANOMIPS_LO12},
  };
  bfd_reloc_code_real_type r;
  size_t i;

  for (i = 0; i < ARRAY_SIZE (relocs); i++)
    {
      r = relocs[i][0];
      if (r > reloc)
	return reloc;
      if (r == reloc)
	return relocs[i][1];
    }
  return reloc;
}

/* Remove first call from call-list and decrement numcalls.  */
static void
stublist_pop_call (struct balc_stub *stub)
{
  struct call_list *ptr = stub->first_call;

  if (ptr)
    {
      if (stub->last_call == ptr)
	stub->last_call = NULL;

      stub->first_call = ptr->next;
      xfree (ptr);
      stub->numcalls -= 1;
    }

  return;
}

/* Remove all calls greater than or equal to CALLSITE
   from call-list and decrement numcalls.  LIST is guaranteed
   to have at least 2 elements when this is called.  */
static void
stublist_trunc_calls (struct balc_stub *stub, bfd_vma callsite)
{
  struct call_list *list = stub->first_call;

  while (list && list->next)
    {
      if (list->next->callsite < callsite)
	list = list->next;
      else
	break;
    }

  if (list)
    {
      stub->last_call = list;
      list = list->next;
      stub->last_call->next = NULL;
      while (list)
	{
	  struct call_list *ptr = list;
	  list = list->next;
	  stub->numcalls -= 1;
	  xfree (ptr);
	}
    }

  return;
}

/* Add call to call-list.  */
static void
stublist_append_call (struct balc_stub *stub, bfd_vma callsite)
{
  struct call_list *next
    = (struct call_list *) xmalloc (sizeof (struct call_list *));
  memset (next, 0, sizeof (struct call_list));
  next->callsite = callsite;

  if (stub->first_call == NULL)
    stub->first_call = stub->last_call = next;
  else if (callsite < stub->first_call->callsite)
    {
      next->next = stub->first_call;
      stub->first_call = next;
    }
  else if (callsite > stub->last_call->callsite)
    {
      stub->last_call->next = next;
      stub->last_call = next;
    }
  else
    {
      struct call_list *list = stub->first_call;

      while (list && list->next)
	{
	  if (list->next->callsite < callsite)
	    list = list->next;
	  else
	    break;
	}

      next->next = list->next;
      list->next = next;
    }

  stub->numcalls += 1;
  return;
}

static void
stublist_merge_forward_calls (struct balc_stub *dest, struct balc_stub *src)
{
  src->last_call->next = dest->first_call;
  dest->first_call = src->first_call;
  if (dest->last_call == NULL)
    dest->last_call = dest->first_call;
  dest->numcalls += src->numcalls;
}

static void
stublist_merge_backward_calls (struct balc_stub *dest, struct balc_stub *src)
{
  dest->last_call->next = src->first_call;
  dest->last_call = src->last_call;
  dest->numcalls += src->numcalls;
}

/* FIXME: Using a hash-table as a stubtable for now. We ideally want
   these to be sorted on first_offset, so a different data structure
   is required to get the best possible results.  */
#define stubtable_find hash_find
#define stubtable_create hash_new
#define stubtable_insert hash_insert
#define stubtable_delete hash_delete
#define stubtable_traverse hash_traverse

static bfd_boolean
balc_in_stub_range (const bfd_vma callsite, const stub_group *stubg)
{
  fragS *fragp;
  bfd_vma minaddr;

  if (stubg == NULL
      || stubg->fragp == NULL
      || stubg->fragp->fr_address + stubg->fragp->fr_fix == 0)
    return FALSE;

  fragp = stubg->fragp;

  /* 10-bit left shifted +ve offset taken from NextPC
     gives a range of 1024 from current call-site.  */
  if (fragp->fr_address + fragp->fr_fix >= 1024)
    minaddr = (fragp->fr_address + fragp->fr_fix - 1024);
  else
    minaddr = 0;

  /* Only the lowest address of the stub needs to be reachable.  */
  if (stubg->next_offset != 0)
    minaddr += (stubg->next_offset - 4);

  /* 10-bit left shifted -ve offset taken from NextPC
     gives a range of 1022 from the current call-site.  */
  if (callsite > (fragp->fr_address + fragp->fr_fix + 1022)
      || callsite < minaddr)
    return FALSE;

  return TRUE;
}

static bfd_boolean
balc_in_stub_group (const char *func, const bfd_vma callsite,
		    const stub_group *stubg, struct balc_stub **stub)
{
  gas_assert (func != NULL && stubg != NULL);

  if (!balc_in_stub_range (callsite, stubg) || (stubg->stubtable == NULL))
    return FALSE;

  *stub = stubtable_find (stubg->stubtable, func);
  return (*stub != NULL);
}

static bfd_boolean
balc_add_stub (symbolS *sym, stub_group *stubg)
{
  struct balc_stub *stub = NULL;
  const char *func = S_GET_NAME (sym);

  gas_assert (func != NULL && stubg != NULL);

  if (!stubg->stubtable)
    stubg->stubtable = stubtable_create ();

  stub = (struct balc_stub *) stubtable_find (stubg->stubtable, func);

  if (stub == NULL)
    {
      stub = (struct balc_stub *) xmalloc (sizeof (struct balc_stub));

      if (stub == NULL)
	return FALSE;

      memset (stub, 0, sizeof (struct balc_stub));
      stub->sym = sym;

      if (stubtable_insert (stubg->stubtable, func, (void *) stub) != NULL)
	return FALSE;
    }

  return TRUE;
}

/* Consolidate this stub with a preceding or succeeding stub if all
   calls to this stub can reach the alternative just as well.  */
static bfd_boolean
balc_merge_stub (const char *func, stub_group *stubg, struct balc_stub *stub)
{
  stub_group *next = stubg->next;
  stub_group *prev = stubg->prev;
  struct balc_stub *prevstub = NULL;
  struct balc_stub *nextstub = NULL;
  bfd_vma callsite = stub->first_call->callsite;

  /* Correction to account for the fact that the 4-byte stub will also move
     forward from its current position to end of target stub-group.  */
  if (stub->fragp && RELAX_NANOMIPS_KEEPSTUB (stub->fragp->fr_subtype))
    callsite += 4;

  /* Any forward stub that we find can be the target for merge.  */
  while (next && next->stubtable && balc_in_stub_range (callsite, next))
    {
      nextstub = (struct balc_stub *) stubtable_find (next->stubtable, func);

      if (nextstub)
	break;
      next = next->next;
    }

  callsite = stub->last_call->callsite;

  /* Correction to account for the fact that the 4-byte stub will also move
     backward from its current position to end of target stub-group.  */
  if (stub->fragp && RELAX_NANOMIPS_KEEPSTUB (stub->fragp->fr_subtype)
      && callsite > stub->fragp->fr_address)
    callsite -= 4;

  /* A previous stub can be a target only if it already has calls.  */
  while (prev && prev->stubtable && balc_in_stub_range (callsite, prev))
    {
      struct balc_stub *pstub
	= (struct balc_stub *) stubtable_find (prev->stubtable, func);

      if (pstub && pstub->numcalls)
	{
	  prevstub = pstub;
	  break;
	}
      prev = prev->prev;
    }

  /* If we have 2 candidates, then we favour the preceding one only if it
     already has more calls than the succeeding one.  */
  if (prevstub)
    {
      if (nextstub && (nextstub->numcalls >= prevstub->numcalls))
	stublist_merge_forward_calls (nextstub, stub);
      else
	stublist_merge_backward_calls (prevstub, stub);
      xfree (stubtable_delete (stubg->stubtable, func, 0));
      return TRUE;
    }
  else if (nextstub)
    {
      stublist_merge_forward_calls (nextstub, stub);
      xfree (stubtable_delete (stubg->stubtable, func, 0));
      return TRUE;
    }
  else
    return FALSE;
}

/* hash traverse - add stub for each function to current stub-group.  */
static void
balc_add_traverse (const char *key, void *value)
{
  struct balc_stub *stub = (struct balc_stub *) value;

  if (stub->fragp != NULL)
    {
      symbolS *sym = stub->fragp->fr_symbol;
      gas_assert (strcmp (key, S_GET_NAME (sym)) == 0);
      balc_add_stub (sym, stubg_now);
    }

  return;
}

/* hash traverse - create a frag stub for each function.  */
static void
balc_frag_traverse (const char *key ATTRIBUTE_UNUSED, void *value)
{
  struct balc_stub *stub = (struct balc_stub *) value;
  symbolS *l;
  fragS *old_frag = stub->fragp;

  if (old_frag)
    {
      old_frag->fr_subtype
	= RELAX_NANOMIPS_CLEAR_KEEPSTUB (old_frag->fr_subtype);
      stub->sym = old_frag->fr_symbol;
    }

  frag_grow (4);
  l = symbol_new (nanomips_label_name (), now_seg, frag_now->fr_fix,
		  frag_now);
  nanomips_label_inc ();
  stub->fragp = frag_now;
  add_relaxed_insn (&nanomips_bc32_insn, 4, 0,
		    RELAX_NANOMIPS_ENCODE (RT_BALC_STUB, 0, RF_VARIABLE),
		    stub->sym, 0);
  stub->sym = l;
  if (stub->numcalls >= 3)
    stub->fragp->fr_subtype
      = RELAX_NANOMIPS_MARK_KEEPSTUB (stub->fragp->fr_subtype);
  if (stubg_now->fragp == NULL)
    stubg_now->fragp = stub->fragp;

  return;
}

/* Find an elligible stub for a function call.  */
static bfd_boolean
balc_find_stub_inrange (const char *func, const bfd_vma callsite,
			stub_group *stubg, struct balc_stub **stub)
{
  stub_group *plink;
  stub_group *nlink;
  struct balc_stub *pstub = NULL;
  struct balc_stub *nstub = NULL;

  /* Search backwards within range.  */
  plink = stubg->prev;
  while (plink != NULL
	 && !balc_in_stub_group (func, callsite, plink, &pstub)
	 && balc_in_stub_range (callsite, plink))
    plink = plink->prev;

  /* Search forwards within range.  */
  nlink = stubg;
  while (nlink != NULL
	 && !balc_in_stub_group (func, callsite, nlink, &nstub)
	 && balc_in_stub_range (callsite, nlink))
    nlink = nlink->next;

  /* When 2 possible stub candidates are available, choose the preceeding one
     only if it already has more associated calls than the suceeding one.  */
  if (pstub)
    {
      if (nstub && (pstub->numcalls <= nstub->numcalls))
	*stub = nstub;
      else
	*stub = pstub;

      return TRUE;
    }
  else if (nstub)
    {
      *stub = nstub;
      return TRUE;
    }

  return FALSE;
}

/* Find closest elligible stub for this function call.  */
static bfd_boolean
balc_get_stub_for_symbol (const char *func, const bfd_vma callsite,
			  stub_group *stubg, symbolS **symbol)
{
  stub_group *plink = stubg->prev;
  stub_group *nlink = stubg;
  struct balc_stub *stub;

  while (plink != NULL || nlink != NULL)
    {
      if (((nlink && balc_in_stub_group (func, callsite, nlink, &stub))
	   || (plink && balc_in_stub_group (func, callsite, plink, &stub)))
	  && stub->numcalls >= 3)
	{
	  *symbol = stub->sym;
	  return TRUE;
	}

      if (plink != NULL)
	plink = plink->prev;
      if (nlink != NULL)
	nlink = nlink->next;
    }

  return FALSE;
}

/* Initialize new stub-group at entry to a function.  */
static void
stubgroup_new (asection *sec)
{
  stub_group *stubg = NULL;

  /* Create the master table.  */
  if (balc_stubgroup_table == NULL)
    balc_stubgroup_table = hash_new ();

  if (stubg_now)
    {
      if (stubg_now->seg != sec)
	{
	  /* Change of sections, find the end of correct list.  */
	  stubg_now = hash_find (balc_stubgroup_table, sec->name);
	  while (stubg_now && stubg_now->next)
	    stubg_now = stubg_now->next;
	}

      /* Re-cycle the previous stubgroup, if unused.  */
      if (stubg_now && stubg_now->stubtable == NULL)
	stubg = stubg_now;
    }

  if (stubg == NULL)
    {
      stubg = (stub_group *) xmalloc (sizeof (stub_group));
      memset (stubg, 0, sizeof (stub_group));
      stubg->seg = sec;
    }

  if (stubg_now == NULL)
    /* First stubgroup for this section, add to master table.  */
    hash_insert (balc_stubgroup_table, sec->name, (void *) stubg);
  else if (stubg_now != stubg)
    {
      /* Link in with existing stub-groups for this section  */
      stubg_now->next = stubg;
      stubg->prev = stubg_now;
    }

  stubg_now = stubg;
}

/* Finalize the stub-group at the end of each function.  */
static void
stubgroup_wane (void)
{
  frag_wane (frag_now);
  frag_new (0);
  /* Carry forward stubs for all previous function calls within
     this section.  */
  if (stubg_now != NULL
      && stubg_now->prev != NULL
      && stubg_now->prev->stubtable != NULL
      && stubg_now->seg == now_seg)
    stubtable_traverse (stubg_now->prev->stubtable, balc_add_traverse);

  /* Create a frag for each stub - this must be done now and for *all*
     possible called functions, because frags can not be inserted in a
     position retroactively. This is also the reason why we include all
     previously called functions within the section - to allow for forward
     consolidation of stubs, knowing that many of these stubs will eventually
     not be instantiated, due to either paucity of calls or consolidation.  */
  if (stubg_now->stubtable && stubg_now->seg == now_seg)
    stubtable_traverse (stubg_now->stubtable, balc_frag_traverse);
}

  /* Table of how many bytes linker relaxation may add for each type
   of relocation.  */
  static const struct
  {
    bfd_reloc_code_real_type rtype;
    bfd_vma rsop_nmf;
    bfd_vma rsop_nmf32;
    bfd_vma rsop_nms;
    bfd_vma rsink;
  } reloc_sops[] = {
    { BFD_RELOC_NANOMIPS_4_PCREL_S1,	8, 12, 12, 0 },
    { BFD_RELOC_NANOMIPS_7_PCREL_S1,	8, 12, 10, 2 },
    { BFD_RELOC_NANOMIPS_10_PCREL_S1,	6, 10, 8, 2 },
    { BFD_RELOC_NANOMIPS_11_PCREL_S1,	8, 12, 10, 4 },
    { BFD_RELOC_NANOMIPS_21_PCREL_S1,	6, 12, 4, 4 },
    { BFD_RELOC_NANOMIPS_25_PCREL_S1,	4, 8, 6, 4 },
    { BFD_RELOC_NANOMIPS_14_PCREL_S1,	8, 12, 10, 4 },
    { BFD_RELOC_NANOMIPS_GPREL19_S2,	6, 8, 8, 2 },
    { BFD_RELOC_NANOMIPS_GPREL18_S3,	6, 8, 8, 0 },
    { BFD_RELOC_NANOMIPS_GPREL16_S2,	6, 8, 8, 0 },
    { BFD_RELOC_NANOMIPS_GPREL18,	6, 8, 8, 0 },
    { BFD_RELOC_NANOMIPS_GPREL17_S1,	6, 8, 8, 0 },
    { BFD_RELOC_NANOMIPS_GPREL7_S2,	8, 10, 10, 0 },
    { BFD_RELOC_NANOMIPS_GOT_CALL,	2, 4, 4, 4 },
    { BFD_RELOC_NANOMIPS_GOT_PAGE,	2, 4, 4, 4 },
    { BFD_RELOC_NANOMIPS_GOT_OFST,	2, 4, 4, 4 },
    { BFD_RELOC_NANOMIPS_GOT_DISP,	2, 4, 4, 4 },
    { BFD_RELOC_NANOMIPS_HI20,		0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_LO12,  	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_PCREL_HI20,	0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_GOTPC_HI20,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_GOT_LO12,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_IMM16, 	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_NEG12, 	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_I32,		0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_HI32,		0, 0, 0, 6 },
    { BFD_RELOC_NANOMIPS_TLS_GD,	2, 8, 0, 0 },
    { BFD_RELOC_NANOMIPS_TLS_GD_I32,	0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_TLS_LD,	2, 8, 0, 0 },
    { BFD_RELOC_NANOMIPS_TLS_LD_I32,	0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_TLS_DTPREL12,	6, 8, 0, 0 },
    { BFD_RELOC_NANOMIPS_TLS_DTPREL16,	6, 8, 0, 4 },
    { BFD_RELOC_NANOMIPS_TLS_DTPREL_I32, 0, 0, 0, 6 },
    { BFD_RELOC_NANOMIPS_TLS_TPREL12,	6, 8, 0, 0 },
    { BFD_RELOC_NANOMIPS_TLS_TPREL16,	6, 8, 0, 4 },
    { BFD_RELOC_NANOMIPS_TLS_TPREL_I32, 0, 0, 0, 6 },
    { BFD_RELOC_NANOMIPS_TLS_GOTTPREL,	2, 4, 0, 4 },
    { BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32, 0, 0, 0, 6 },
    { BFD_RELOC_NANOMIPS_PC_I32,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_GOTPC_I32,	0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_GPREL_I32,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_GPREL_HI20,	0, 0, 0, 2 },
    { BFD_RELOC_NANOMIPS_GPREL_LO12,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_JALR16,	2, 2, 2, 2 },
    { BFD_RELOC_NANOMIPS_JALR32,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_GPREL_LO12,	0, 0, 0, 4 },
    { BFD_RELOC_NANOMIPS_INSN16,	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_INSN32,	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_FIXED, 	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_ALIGN, 	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_RELAX, 	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_NORELAX,	0, 0, 0, 0 },
    { BFD_RELOC_NANOMIPS_SAVERESTORE,	0, 0, 0, 0 },
    { BFD_RELOC_NONE,			32, 32, 32, 4 }  /* Fall-back maximum  */
  };

/* Map a relocation RTYPE to the maximum extra bytes its
   linker relaxation can introduce.  */
static bfd_vma
get_reloc_sop (bfd_reloc_code_real_type rtype)
{
  unsigned int i;

  for (i = 0; i < ARRAY_SIZE (reloc_sops); i++)
    {
      if (reloc_sops[i].rtype == rtype)
	return ((nanomips_opts.ase & ASE_xNMS)
		? (nanomips_opts.insn32
		   ? reloc_sops[i].rsop_nmf32
		   : reloc_sops[i].rsop_nmf)
		: reloc_sops[i].rsop_nms);
    }

  return ((nanomips_opts.ase & ASE_xNMS)
	  ? (nanomips_opts.insn32
	     ? reloc_sops[i-1].rsop_nmf32
	     : reloc_sops[i-1].rsop_nmf)
	  : reloc_sops[i-1].rsop_nms);
}

/* Map a relocation RTYPE to the maximum bytes its linker
   relaxation can remove.  */
static bfd_vma
get_reloc_sink (bfd_reloc_code_real_type rtype)
{
  unsigned int i;

  for (i = 0; i < ARRAY_SIZE (reloc_sops); i++)
    {
      if (reloc_sops[i].rtype == rtype)
	return (reloc_sops[i].rsink);
    }

  return (reloc_sops[i-1].rsink);
}

/* Return the relaxation frag subtype corresponding to RELOC  */

static enum relax_nanomips_subtype
reloc_to_frag_subtype (bfd_reloc_code_real_type reloc)
{
  enum relax_nanomips_subtype rt = 0;
  switch (reloc)
    {
      case BFD_RELOC_NANOMIPS_4_PCREL_S1:
	rt = RT_PC4_S1; break;
      case BFD_RELOC_NANOMIPS_7_PCREL_S1:
	rt = RT_PC7_S1; break;
      case BFD_RELOC_NANOMIPS_10_PCREL_S1:
	rt = RT_PC10_S1; break;
      case BFD_RELOC_NANOMIPS_11_PCREL_S1:
	rt = RT_PC11_S1; break;
      case BFD_RELOC_NANOMIPS_14_PCREL_S1:
	rt = RT_PC14_S1; break;
      case BFD_RELOC_NANOMIPS_21_PCREL_S1:
	rt = RT_PC21_S1; break;
      case BFD_RELOC_NANOMIPS_25_PCREL_S1:
	rt = RT_PC25_S1; break;
      default:
	break;
    }
  return rt;
}

/* Return the BFD relocation corresponding to frag subtype RT.  */

static bfd_reloc_code_real_type
frag_subtype_to_reloc (enum relax_nanomips_subtype rt, bfd_boolean toofar16)
{
  bfd_reloc_code_real_type reloc = BFD_RELOC_NONE;
  switch (rt)
    {
      case RT_PC4_S1:
	reloc = BFD_RELOC_NANOMIPS_4_PCREL_S1; break;
      case RT_PC7_S1:
	reloc = BFD_RELOC_NANOMIPS_7_PCREL_S1; break;
      case RT_PC10_S1:
	reloc = BFD_RELOC_NANOMIPS_10_PCREL_S1; break;
      case RT_PC11_S1:
	reloc = BFD_RELOC_NANOMIPS_11_PCREL_S1; break;
      case RT_PC14_S1:
	reloc = BFD_RELOC_NANOMIPS_14_PCREL_S1; break;
      case RT_PC21_S1:
	reloc = BFD_RELOC_NANOMIPS_21_PCREL_S1; break;
      case RT_PC25_S1:
	reloc = BFD_RELOC_NANOMIPS_25_PCREL_S1; break;
      case RT_BRANCH_UCND:
	reloc = (toofar16
		 ? BFD_RELOC_NANOMIPS_25_PCREL_S1
		 : BFD_RELOC_NANOMIPS_10_PCREL_S1);
	break;
      case RT_BRANCH_CNDZ:
	reloc = (toofar16
		 ? BFD_RELOC_NANOMIPS_14_PCREL_S1
		 : BFD_RELOC_NANOMIPS_7_PCREL_S1);
	break;
      case RT_BRANCH_CND:
	reloc = (toofar16
		 ? BFD_RELOC_NANOMIPS_14_PCREL_S1
		 : BFD_RELOC_NANOMIPS_4_PCREL_S1);
      default:
	break;
    }
  return reloc;
}

/* Output an instruction.  IP is the instruction information.
   ADDRESS_EXPR is an operand of the instruction to be used with
   RELOC_TYPE.  EXPANSIONP is true if the instruction is part of
   a macro expansion.  */

static void
append_insn (struct nanomips_cl_insn *ip, expressionS *address_expr,
	     bfd_reloc_code_real_type *reloc_type,
	     bfd_boolean expansionp ATTRIBUTE_UNUSED)
{
  unsigned long pinfo;

  pinfo = ip->insn_mo->pinfo;

  if (address_expr == NULL)
    ip->complete_p = 1;
  else if (reloc_type[0] <= BFD_RELOC_UNUSED
	   && reloc_type[1] == BFD_RELOC_UNUSED
	   && reloc_type[2] == BFD_RELOC_UNUSED
	   && address_expr->X_op == O_constant)
    {
      switch (*reloc_type)
	{
	case BFD_RELOC_NANOMIPS_HI20:
	case BFD_RELOC_NANOMIPS_GPREL_HI20:
	  ip->insn_opcode |= ((((address_expr->X_add_number >> 12) & 0x1ff)
			       << 12)
			      | (((address_expr->X_add_number >> 21) & 0x3ff)
				 << 2)
			      | ((address_expr->X_add_number >> 31) & 1));
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_LO12:
	case BFD_RELOC_NANOMIPS_GOT_LO12:
	  ip->insn_opcode |= address_expr->X_add_number & 0xfff;
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_IMM16:
	  ip->insn_opcode |= address_expr->X_add_number & 0xffff;
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_NEG12:
	  ip->insn_opcode |= (-address_expr->X_add_number) & 0xfff;
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_HI32:
	  ip->insn_opcode_ext = (((address_expr->X_add_number + 0x80000000)
				  >> 32)
				 & 0xffffffff);
	  ip->insn_opcode_ext = (((ip->insn_opcode_ext >> 16) & 0xffff)
				 | (ip->insn_opcode_ext << 16));
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_I32:
	case BFD_RELOC_NANOMIPS_GPREL_I32:
	  ip->insn_opcode_ext = (((address_expr->X_add_number >> 16) & 0xffff)
				 | (address_expr->X_add_number << 16));
	  ip->complete_p = 1;
	  break;

	case BFD_RELOC_NANOMIPS_GOT_CALL:
	  ip->complete_p = 1;
	case BFD_RELOC_NANOMIPS_PC_I32:
	case BFD_RELOC_NANOMIPS_GOTPC_I32:
	  break;

	default:
	  break;
	}
    }

  dwarf2_emit_insn (0);

  if (compact_branch_p (&history[0])
      && (history[0].insn_mo->pinfo2 & INSN2_CONVERTED_TO_COMPACT)
      && history[0].noreorder_p
      && strcmp (ip->insn_mo->name, "nop") != 0)
    {
      as_bad (_("unable to convert `%s' to its compact form because it has a "
		"non NOP instruction (`%s') in its delay slot.  Please move "
		"the delay slot instruction before the branch and disable "
		"noreorder."), history[0].insn_mo->name, ip->insn_mo->name);
      add_fixed_insn (ip);
    }
  else if (history[0].noreorder_p
	   && (strcmp (history[0].insn_mo->name, "bal") == 0
	       || strcmp (history[0].insn_mo->name, "jal") == 0
	       || strcmp (history[0].insn_mo->name, "bgezal") == 0
	       || strcmp (history[0].insn_mo->name, "bltzal") == 0)
	   && strcmp (ip->insn_mo->name, "nop") == 0)
    {
      as_bad (_("unable to convert `%s' to its compact form because the link "
		"register would have a different value.  Please move the delay "
		"slot instruction before the branch and disable noreorder."),
	      history[0].insn_mo->name);
      add_fixed_insn (ip);
    }
  else if (address_expr
	   && *reloc_type >= BFD_RELOC_UNUSED + RT_BRANCH_UCND)
    {
      int type = *reloc_type - BFD_RELOC_UNUSED;
      int al = pinfo & INSN_WRITE_GPR_31;
      int max = (forced_insn_format? insn_length (ip->insn_mo) : 4);
      enum relax_nanomips_fix_type rf = (nanomips_opts.linkrelax ?
					 RF_VARIABLE : RF_NORELAX);

      gas_assert (address_expr != NULL);
      gas_assert (!nanomips_relax.sequence);

      if (nanomips_opts.minimize_relocs || !forced_insn_format)
	add_relaxed_insn (ip, max, insn_length (ip->insn_mo),
			  RELAX_NANOMIPS_ENCODE (type, al, rf),
			  address_expr->X_add_symbol,
			  address_expr->X_add_number);
      else
	add_fixed_insn (ip);

      if (!forced_insn_format)
	{
	  /* Track this call for balc-to-stub relaxation.  */
	  if (!nanomips_opts.no_balc_stubs
	      && stubg_now != NULL
	      && type == RT_BRANCH_UCND
	      && al != 0)
	    balc_add_stub (address_expr->X_add_symbol, stubg_now);
	  *reloc_type = BFD_RELOC_UNUSED;
	}
      else
	*reloc_type = frag_subtype_to_reloc (type, FALSE);
    }
  else if (address_expr
	   && *reloc_type == BFD_RELOC_UNUSED + RT_ADDIU
	   && address_expr->X_op == O_subtract
	   && !forced_insn_format)
    {
      enum relax_nanomips_subtype type = RT_ADDIU;
      enum relax_nanomips_fix_type fixed = RF_NONE;
      if (nanomips_opts.insn32 || (forced_insn_length == 4))
	fixed = RF_FIXED;

      gas_assert (address_expr != NULL);
      gas_assert (!nanomips_relax.sequence);
      add_relaxed_insn (ip, 4, 4,
			RELAX_NANOMIPS_ENCODE (type, 0, fixed),
			make_expr_symbol (address_expr), 0);
      *reloc_type = BFD_RELOC_UNUSED;
    }
  else
    {
      if (nanomips_relax.sequence)
	{
	  /* If we've reached the end of this frag, turn it into a variant
	     frag and record the information for the instructions we've
	     written so far.  */
	  if (frag_room () < insn_length (ip->insn_mo))
	    relax_close_frag ();
	  nanomips_relax.sizes[nanomips_relax.sequence - 1] +=
	    insn_length (ip->insn_mo);
	}

      if (nanomips_relax.sequence != 2)
	{
	  if (nanomips_macro_warning.first_insn_sizes[0] == 0)
	    nanomips_macro_warning.first_insn_sizes[0] = insn_length (ip->insn_mo);
	  nanomips_macro_warning.sizes[0] += insn_length (ip->insn_mo);
	  nanomips_macro_warning.insns[0]++;
	}
      if (nanomips_relax.sequence != 1)
	{
	  if (nanomips_macro_warning.first_insn_sizes[1] == 0)
	    nanomips_macro_warning.first_insn_sizes[1] = insn_length (ip->insn_mo);
	  nanomips_macro_warning.sizes[1] += insn_length (ip->insn_mo);
	  nanomips_macro_warning.insns[1]++;
	}

      if (nanomips_opts.minimize_relocs
	  && pcrel_branch_reloc_p (*reloc_type)
	  && address_expr->X_op != O_constant)
	{
	  enum relax_nanomips_fix_type fix_type;
	  relax_substateT stype;
	  if (!nanomips_opts.linkrelax || forced_insn_length > 0
	      || forced_insn_format)
	    fix_type = RF_NORELAX;
	  else
	    fix_type = RF_VARIABLE;
	  stype = RELAX_NANOMIPS_ENCODE (reloc_to_frag_subtype (*reloc_type),
					 pinfo & INSN_WRITE_GPR_31,
					 fix_type);

	  add_relaxed_insn (ip, insn_length (ip->insn_mo),
			    insn_length (ip->insn_mo), stype,
			    address_expr->X_add_symbol,
			    address_expr->X_add_number);
	}
      else
	add_fixed_insn (ip);
    }

  if (!ip->complete_p && *reloc_type < BFD_RELOC_UNUSED)
    {
      bfd_reloc_code_real_type final_type[3];
      reloc_howto_type *howto0;
      reloc_howto_type *howto;
      int i;
      unsigned where;

      /* Perform any necessary conversion to nanoMIPS relocations
         and find out how many relocations there actually are.  */
      for (i = 0; i < 3 && reloc_type[i] != BFD_RELOC_UNUSED; i++)
	final_type[i] = nanomips_map_reloc (reloc_type[i]);

      /* In a compound relocation, it is the final (outermost)
         operator that determines the relocated field.  */
      howto = howto0 = bfd_reloc_type_lookup (stdoutput, final_type[i - 1]);
      if (!howto)
	abort ();

      if (i > 1)
	howto0 = bfd_reloc_type_lookup (stdoutput, final_type[0]);

      where = ip->where;
      /* For 48-bit nanoMIPS instructions, we want the relocation
         to be on the lower 32-bits of the instruction.  */
      if (nanomips_48bit_reloc_p (final_type[0]))
	where = ip->where + 2;

      ip->fixp[0] = fix_new_exp (ip->frag, where,
				 bfd_get_reloc_size (howto),
				 address_expr,
				 howto0 && howto0->pc_relative,
				 final_type[0]);
      /* Remember the first fix-up in this frag.  */
      if (ip->frag->tc_frag_data.first_fix == NULL)
	ip->frag->tc_frag_data.first_fix = ip->fixp[0];

      /* These relocations can have an addend that won't fit in
	 4 octets for 64bit assembly.  */
      if (GPR_SIZE == 64
	  && !howto->partial_inplace
	  && (reloc_type[0] == BFD_RELOC_16
	      || reloc_type[0] == BFD_RELOC_32
	      || reloc_type[0] == BFD_RELOC_GPREL16
	      || reloc_type[0] == BFD_RELOC_GPREL32
	      || reloc_type[0] == BFD_RELOC_64
	      || reloc_type[0] == BFD_RELOC_CTOR
	      || reloc_type[0] == BFD_RELOC_NANOMIPS_NEG
	      || hi_reloc_p (reloc_type[0])
	      || lo_reloc_p (reloc_type[0])))
	ip->fixp[0]->fx_no_overflow = 1;

      if (nanomips_relax.sequence)
	{
	  if (nanomips_relax.first_fixup == 0)
	    nanomips_relax.first_fixup = ip->fixp[0];
	}

      /* Add fixups for the second and third relocations, if given.
         Note that the ABI allows the second relocation to be
         against RSS_UNDEF, RSS_GP, RSS_GP0 or RSS_LOC.  At the
         moment we only use RSS_UNDEF, but we could add support
         for the others if it ever becomes necessary.  */
      for (i = 1; i < 3; i++)
	if (reloc_type[i] != BFD_RELOC_UNUSED)
	  {
	    ip->fixp[i] = fix_new (ip->frag, where,
				   ip->fixp[0]->fx_size, NULL, 0,
				   FALSE, final_type[i]);

	    /* Use fx_tcbit to mark compound relocs.  */
	    ip->fixp[0]->fx_tcbit = 1;
	    ip->fixp[i]->fx_tcbit = 1;
	  }

      if (nanomips_opts.linkrelax)
	{
	  if (forced_insn_format)
	    {
	      if (insn_length (ip->insn_mo) == 6)
		fix_new (ip->frag, ip->where+2, 0, &abs_symbol, 0, FALSE,
			 BFD_RELOC_NANOMIPS_FIXED);
	      else
		fix_new (ip->frag, ip->where, 0, &abs_symbol, 0, FALSE,
			 BFD_RELOC_NANOMIPS_FIXED);
	    }
	  else if (forced_insn_length > 0 && forced_insn_length < 6)
	    fix_new (ip->frag, ip->where, 0, &abs_symbol, 0, FALSE,
		     (forced_insn_length == 2 ? BFD_RELOC_NANOMIPS_INSN16
		      : BFD_RELOC_NANOMIPS_INSN32));

	  if (!forced_insn_length
	      && !forced_insn_format
	      && !pcrel_branch_reloc_p (*reloc_type)
	      /* Ignore relocations that don't expand/contract due to
		 linker relaxation. Sneaky!!  */
	      && ((get_reloc_sop (*reloc_type) > 0)
		  || get_reloc_sink (*reloc_type) > 0))
	    {
	      ip->frag->tc_frag_data.link_var = TRUE;
	      ip->frag->tc_frag_data.relax_sop += get_reloc_sop (*reloc_type);
	      ip->frag->tc_frag_data.relax_sink += get_reloc_sink (*reloc_type);
	    }
	}
    }

  install_insn (ip);

  insert_into_history (ip);

  /* If we have just completed an unconditional branch, clear the history.  */
  if ((compact_branch_p (&history[0]) && uncond_branch_p (&history[0]))
      && !(history[0].insn_mo->pinfo2 & INSN2_CONVERTED_TO_COMPACT))
    nanomips_flush_pending_output ();

  /* We just output an insn, so the next one doesn't have a label.  */
  nanomips_clear_insn_labels ();
}

/* Forget that there was any previous instruction or label.
   When BRANCH is true, the branch history is also flushed.  */

void
nanomips_flush_pending_output (void)
{
  prev_nop_frag = NULL;
  insert_into_history (NOP_INSN);
  nanomips_clear_insn_labels ();
}

/* Start a (possibly nested) noreorder block.  */

static void
start_noreorder (void)
{
  nanomips_opts.noreorder++;
}

/* End a nested noreorder block.  */

static void
end_noreorder (void)
{
  nanomips_opts.noreorder--;
}

/* Sign-extend 32-bit mode constants that have bit 31 set and all
   higher bits unset.  */

static void
normalize_constant_expr (expressionS *ex)
{
  if (ex->X_op == O_constant && IS_ZEXT_32BIT_NUM (ex->X_add_number))
    ex->X_add_number = (((ex->X_add_number & 0xffffffff) ^ 0x80000000)
			- 0x80000000);
}

/* Sign-extend 32-bit mode address offsets that have bit 31 set and
   all higher bits unset.  */

static void
normalize_address_expr (expressionS *ex)
{
  if (((ex->X_op == O_constant && HAVE_32BIT_ADDRESSES)
       || (ex->X_op == O_symbol && HAVE_32BIT_SYMBOLS))
      && IS_ZEXT_32BIT_NUM (ex->X_add_number))
    ex->X_add_number = (((ex->X_add_number & 0xffffffff) ^ 0x80000000)
			- 0x80000000);
}

struct gprel_insn_match
{
  /* Instruction.  */
  const char *str;
  /* Arch word size 32/64 if it matters, else 0.  */
  int gpwidth;
  /* Relocation.  */
  bfd_reloc_code_real_type reloc;
};

static const struct gprel_insn_match nanomips_gprel_map[] = {
  {"lw[gp]", 0, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"sw[gp]", 0, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"lh[gp]", 0, BFD_RELOC_NANOMIPS_GPREL17_S1},
  {"lhu[gp]", 0, BFD_RELOC_NANOMIPS_GPREL17_S1},
  {"sh[gp]", 0, BFD_RELOC_NANOMIPS_GPREL17_S1},
  {"lb[gp]", 0, BFD_RELOC_NANOMIPS_GPREL18},
  {"lbu[gp]", 0, BFD_RELOC_NANOMIPS_GPREL18},
  {"sb[gp]", 0, BFD_RELOC_NANOMIPS_GPREL18},
  {"addiu.b", 0, BFD_RELOC_NANOMIPS_GPREL18},
  {"addiu[gp.b]", 0, BFD_RELOC_NANOMIPS_GPREL18},
  {"addiu.w", 0, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"addiu[gp.w]", 0, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"ldc1[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"sdc1[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"l.d[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"s.d[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"swc1[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"lwc1[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"s.s[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"l.s[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"lwu[gp]", 0, BFD_RELOC_NANOMIPS_GPREL16_S2},
  {"ld[gp]", 32, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"sd[gp]", 32, BFD_RELOC_NANOMIPS_GPREL19_S2},
  {"ld[gp]", 64, BFD_RELOC_NANOMIPS_GPREL18_S3},
  {"sd[gp]", 64, BFD_RELOC_NANOMIPS_GPREL18_S3},
};

static bfd_reloc_code_real_type
gprel_for_nanomips_insn (const struct nanomips_opcode *insn)
{
  unsigned int i;

  if (forced_insn_length == 2
      || (forced_insn_format && insn_length (insn) == 2))
    return BFD_RELOC_NANOMIPS_GPREL7_S2;
  if (insn_length (insn) == 6)
    return BFD_RELOC_NANOMIPS_GPREL_I32;

  for (i = 0; i < ARRAY_SIZE (nanomips_gprel_map); i++)
    if (strncasecmp (insn->name, nanomips_gprel_map[i].str,
		     strlen (insn->name)) == 0
	&& strcmp (insn->suffix,
		   nanomips_gprel_map[i].str + strlen (insn->name)) == 0)
      {
	if (nanomips_gprel_map[i].gpwidth
	    && nanomips_gprel_map[i].gpwidth != GPR_SIZE)
	  continue;

	return nanomips_gprel_map[i].reloc;
      }

  return BFD_RELOC_UNUSED;
}

static bfd_reloc_code_real_type
tlsrel_for_nanomips_insn (const struct nanomips_opcode *insn,
			  bfd_reloc_code_real_type rtype)
{
  unsigned int i;
  static const struct {
    bfd_reloc_code_real_type key;
    bfd_reloc_code_real_type value;
  } reloc_map[] = {
    { BFD_RELOC_NANOMIPS_TLS_GD, BFD_RELOC_NANOMIPS_TLS_GD_I32 },
    { BFD_RELOC_NANOMIPS_TLS_LD, BFD_RELOC_NANOMIPS_TLS_LD_I32 },
    { BFD_RELOC_NANOMIPS_TLS_TPREL12, BFD_RELOC_NANOMIPS_TLS_TPREL_I32 },
    { BFD_RELOC_NANOMIPS_TLS_DTPREL12, BFD_RELOC_NANOMIPS_TLS_DTPREL_I32 }
  };

  if (insn_length (insn) == 6)
    for (i = 0; i < ARRAY_SIZE (reloc_map); i++)
      if (rtype == reloc_map[i].key)
	return reloc_map[i].value;

  if (strncmp (insn->name, "addiu", 5) == 0
      || strncmp (insn->name, "li", 2) == 0)
    {
      if (rtype == BFD_RELOC_NANOMIPS_TLS_TPREL12)
	  return BFD_RELOC_NANOMIPS_TLS_TPREL16;
      if (rtype == BFD_RELOC_NANOMIPS_TLS_DTPREL12)
	return BFD_RELOC_NANOMIPS_TLS_DTPREL16;
    }

  return rtype;
}

/* Like match_insn, for nanoMIPS.  */
static bfd_boolean
match_nanomips_insn (struct nanomips_cl_insn *insn,
		     const struct nanomips_opcode *opcode,
		     struct nanomips_operand_token *tokens,
		     unsigned int opcode_extra, bfd_boolean lax_match)
{
  const char *args;
  struct nanomips_arg_info arg;
  const struct nanomips_operand *operand;
  char c;

  imm_expr.X_op = O_absent;
  offset_expr.X_op = O_absent;
  offset_reloc[0] = BFD_RELOC_UNUSED;
  offset_reloc[1] = BFD_RELOC_UNUSED;
  offset_reloc[2] = BFD_RELOC_UNUSED;

  create_insn (insn, opcode);
  /* When no opcode suffix is specified, assume ".xyzw". */
  insn->insn_opcode |= opcode_extra;
  memset (&arg, 0, sizeof (arg));
  arg.insn = insn;
  arg.token = tokens;
  arg.argnum = 1;
  arg.last_regno = ILLEGAL_REG;
  arg.dest_regno = ILLEGAL_REG;
  arg.lax_match = lax_match;
  arg.select_mask = 0;

  if ((insn->insn_mo->pinfo2 & INSN2_MTTGPR_RC1) != 0
      && !nanomips_mttgpr_rc1)
    return FALSE;

  for (args = opcode->args;; ++args)
    {
      if (arg.token->type == OT_END)
	{
	  /* Handle unary instructions in which only one operand is given.
	     The source is then the same as the destination.  */
	  if ((*args == ',')
	      || (arg.opnum == 0 && *args != 0))
	    {
	      operand = decode_nanomips_operand (args + (arg.opnum ? 1 : 0));
	      if (operand && nanomips_optional_operand_p (operand))
		{
		  arg.token = tokens;
		  arg.argnum = 1;
		  continue;
		}
	      /* These optional types appear only as the last operand.  */
	      else if (operand && (operand->type == OP_CP0SEL
				   || operand->type == OP_DONT_CARE))
		return TRUE;
	    }

	  /* Treat elided base registers as $0.  */
	  if (strcmp (args, "(b)") == 0 || strcmp (args, "(c)") == 0)
	    args += 3;

	  if (args[0] == '+')
	    switch (args[1])
	      {
	      case 'K':
	      case 'N':
		/* The register suffix is optional. */
		args += 2;
		break;
	      }

	  /* Fail the match if there were too few operands.  */
	  if (*args)
	    return FALSE;

	  clear_insn_error ();
	  check_completed_insn (&arg);
	  return TRUE;
	}

      /* Fail the match if the line has too many operands.   */
      if (*args == 0)
	return FALSE;

      /* Handle characters that need to match exactly.  */
      if (*args == '(' || *args == ')' || *args == ',')
	{
	  if (match_char (&arg, *args))
	    continue;
	  return FALSE;
	}
      if (*args == '#')
	{
	  ++args;
	  if (arg.token->type == OT_DOUBLE_CHAR && arg.token->u.ch == *args)
	    {
	      ++arg.token;
	      continue;
	    }
	  return FALSE;
	}

      /* Handle special macro operands.  Work out the properties of
         other operands.  */
      arg.opnum += 1;

      switch (*args)
	{
	case 'I':
	  if (!match_const_int (&arg, &imm_expr.X_add_number))
	    return FALSE;
	  imm_expr.X_op = O_constant;
	  if (GPR_SIZE == 32)
	    normalize_constant_expr (&imm_expr);
	  continue;

	case 'A':
	  if (arg.token->type == OT_CHAR && arg.token->u.ch == '(')
	    {
	      /* Assume that the offset has been elided and that what
	         we saw was a base register.  The match will fail later
	         if that assumption turns out to be wrong.  */
	      offset_expr.X_op = O_constant;
	      offset_expr.X_add_number = 0;
	    }
	  else
	    {
	      if (!match_expression (&arg, &offset_expr, offset_reloc))
		return FALSE;
	      normalize_address_expr (&offset_expr);
	    }
	  continue;

	case 'F':
	  if (!match_float_constant (&arg, &imm_expr, &offset_expr, 8, TRUE))
	    return FALSE;
	  continue;

	case 'L':
	  if (!match_float_constant (&arg, &imm_expr, &offset_expr, 8, FALSE))
	    return FALSE;
	  continue;

	case 'f':
	  if (!match_float_constant (&arg, &imm_expr, &offset_expr, 4, TRUE))
	    return FALSE;
	  continue;

	case 'l':
	  if (!match_float_constant (&arg, &imm_expr, &offset_expr, 4, FALSE))
	    return FALSE;
	  continue;
	}

      operand = decode_nanomips_operand (args);
      if (!operand)
	abort ();

      if (operand->type == OP_PCREL
	  || operand->type == OP_NON_ZERO_PCREL_S1
	  || operand->type == OP_HI20_PCREL
	  || operand->type == OP_INT_WORD
	  || operand->type == OP_UINT_WORD
	  || operand->type == OP_PC_WORD
	  || operand->type == OP_INT
	  || operand->type == OP_GPREL_WORD)
	switch (*args)
	  {
	  case '+':
	    switch (args[1])
	      {
	      case '\'':
		*offset_reloc = BFD_RELOC_NANOMIPS_25_PCREL_S1;
		break;

	      case 'r':
		*offset_reloc = BFD_RELOC_NANOMIPS_21_PCREL_S1;
		break;

	      case 'Q':
	      case 'R':
		*offset_reloc = BFD_RELOC_NANOMIPS_I32;
		break;
	      }
	    break;

	  case 'a':
	    *offset_reloc = BFD_RELOC_NANOMIPS_25_PCREL_S1;
	    break;

	  case 'p':
	    *offset_reloc = BFD_RELOC_NANOMIPS_14_PCREL_S1;
	    break;

	  case '~':
	    *offset_reloc = BFD_RELOC_NANOMIPS_11_PCREL_S1;
	    break;

	  case 'm':
	    c = args[1];
	    switch (c)
	      {
	      case 'D':
		*offset_reloc = (forced_insn_length
				 ? BFD_RELOC_NANOMIPS_10_PCREL_S1
				 : BFD_RELOC_UNUSED + RT_BRANCH_UCND);
		break;
	      case 'E':
		*offset_reloc = (forced_insn_length
				 ? BFD_RELOC_NANOMIPS_7_PCREL_S1
				 : BFD_RELOC_UNUSED + RT_BRANCH_CNDZ);
		break;
	      case 'F':
		*offset_reloc = (forced_insn_length
				 ? BFD_RELOC_NANOMIPS_4_PCREL_S1
				 : BFD_RELOC_UNUSED + RT_BRANCH_CND);
		break;
	      }
	    break;
	  }

      /* Skip prefixes.  */
      if (*args == '+' || *args == 'm' || *args == '-' || *args == '`')
	args++;

      if (nanomips_optional_operand_p (operand)
	  && args[1] == ','
	  && (arg.token[0].type != OT_REG || arg.token[1].type == OT_END))
	{
	  /* Assume that the register has been elided and is the
	     same as the first operand.  */
	  arg.token = tokens;
	  arg.argnum = 1;
	}

      if (operand->type == OP_COPY_BITS)
	args++;

      if (!match_operand (&arg, operand))
	return FALSE;

      if (*offset_reloc == BFD_RELOC_NANOMIPS_GPREL18)
	*offset_reloc = gprel_for_nanomips_insn (insn->insn_mo);
      else if (flex_reloc_p (*offset_reloc))
	*offset_reloc = tlsrel_for_nanomips_insn (insn->insn_mo, *offset_reloc);
    }
}

/* Record that the current instruction is invalid for the current ISA.  */

static void
match_invalid_for_isa (void)
{
  const struct nanomips_cpu_info *isa_info;
  const struct nanomips_cpu_info *arch_info;

  isa_info = nanomips_cpu_info_from_isa (nanomips_opts.isa,
				     (nanomips_opts.ase & ASE_xNMS) == 0);
  arch_info = nanomips_cpu_info_from_arch (nanomips_opts.arch);

  if ((arch_info->flags & NANOMIPS_CPU_IS_ISA) != 0)
    {
      if (nanomips_arch_string)
	arch_info = nanomips_parse_cpu (NULL, nanomips_arch_string);
      else
	arch_info = nanomips_parse_cpu (NULL, NANOMIPS_CPU_STRING_DEFAULT);

      if (strcmp (isa_info->name, arch_info->name) == 0
	  || file_nanomips_opts.arch != nanomips_opts.arch)
	set_insn_error_ss (0, _("opcode not supported on this ISA: %s%s"),
			   isa_info->name, "");
      else
	set_insn_error_ss
	  (0, _("opcode not supported on this processor: %s (%s)"),
	   arch_info->name, isa_info->name);
    }
  else
    set_insn_error_ss (0, _("opcode not supported on this processor: %s (%s)"),
		       arch_info->name, isa_info->name);
}

static bfd_boolean
match_nanomips_insns (struct nanomips_cl_insn *insn,
		      const struct nanomips_opcode *first,
		      const struct nanomips_opcode *past,
		      struct nanomips_operand_token *tokens,
		      int opcode_extra, bfd_boolean lax_match)
{
  const struct nanomips_opcode *opcode;
  bfd_boolean seen_valid_for_isa, seen_valid_for_size;
  bfd_boolean seen_valid_for_ase, seen_valid_for_fp;

  seen_valid_for_isa = FALSE;
  seen_valid_for_size = FALSE;
  seen_valid_for_ase = FALSE;
  seen_valid_for_fp = FALSE;
  opcode = first;

  /* Search for a match, ignoring alternatives that don't satisfy the
     current ISA or forced_length.  */
  do
    {
      gas_assert (strcmp (opcode->name, first->name) == 0);
      if (!forced_insn_format || strcmp (opcode->suffix, first->suffix) == 0)
	{
	  if (is_opcode_valid (opcode))
	    {
	      seen_valid_for_isa = TRUE;
	      if (is_size_valid (opcode))
		{
		  seen_valid_for_size = TRUE;
		  if (match_nanomips_insn (insn, opcode, tokens, opcode_extra,
					   lax_match))
		    return TRUE;
		}
	    }
	  else
	    {
	      /* If instruction is not valid for current ISA,  try to guess
		 why for better error reporting.  */
	      if (is_opcode_valid_def_ase (opcode))
		seen_valid_for_ase = TRUE;
	      if (is_opcode_valid_for_fp (opcode))
		seen_valid_for_fp = TRUE;
	    }
	}
      ++opcode;
    }
  while (opcode < past && strcmp (opcode->name, first->name) == 0);

  /* Handle the case where we didn't try to match an instruction because
     all the alternatives were incompatible with the current ISA.  */
  if (!seen_valid_for_isa)
    {
      if (!seen_valid_for_fp)
	set_insn_error (0, _("opcode belongs to disabled FP mode:"));
      else if (seen_valid_for_ase)
	set_insn_error (0, _("opcode belongs to a disabled ASE:"));
      else
	match_invalid_for_isa ();
      return TRUE;
    }

  /* Handle the case where we didn't try to match an instruction because
     all the alternatives were of the wrong size.  */
  if (!seen_valid_for_size)
    {
      if (nanomips_opts.insn32)
	set_insn_error (0, _("opcode not supported in the `insn32' mode"));
      else
	set_insn_error_i
	  (0, _("unrecognized %d-bit version of nanoMIPS opcode"),
	   8 * forced_insn_length);
      return TRUE;
    }

  return FALSE;
}

/* Set up global variables for the start of a new macro.  */

static void
macro_start (void)
{
  memset (&nanomips_macro_warning.sizes, 0,
	  sizeof (nanomips_macro_warning.sizes));
  memset (&nanomips_macro_warning.first_insn_sizes, 0,
	  sizeof (nanomips_macro_warning.first_insn_sizes));
  memset (&nanomips_macro_warning.insns, 0,
	  sizeof (nanomips_macro_warning.insns));
  nanomips_macro_warning.first_frag = NULL;
}

/* Finish up a macro.  Emit warnings as appropriate.  */

static void
macro_end (bfd_boolean allow_expansion)
{
  /* Relaxation warning flags.  */
  relax_substateT subtype = 0;

  /* Check instruction count requirements.  */
  if (nanomips_macro_warning.insns[0] > 1
      || nanomips_macro_warning.insns[1] > 1)
    {
      if (nanomips_macro_warning.insns[1] > nanomips_macro_warning.insns[0])
	subtype |= RELAX_SECOND_LONGER;
      if (nanomips_opts.nomacro)
	subtype |= RELAX_NOMACRO;
    }


  /* If both implementations are longer than 1 instruction, then emit the
     warning now.  */
  if (nanomips_macro_warning.insns[0] > 1
      && nanomips_macro_warning.insns[1] > 1)
    {
      if (nanomips_opts.nomacro)
	{
	  if (allow_expansion)
	    as_warn (_("macro instruction expanded into multiple "
		       "instructions"));
	  else
	    as_bad (_("macro instruction expanded into multiple "
		      "instructions"));
	}

      subtype &= ~RELAX_NOMACRO;
    }

  /* If any flags still set, then one implementation might need a warning
     and the other either will need one of a different kind or none at all.
     Pass any remaining flags over to relaxation.  */
  if (nanomips_macro_warning.first_frag != NULL)
    nanomips_macro_warning.first_frag->fr_subtype |= subtype;
}

static const char *const brk_fmt[2] = { "+K", "+J" };
static const char *const addiu_fmt[2] = { "-t,r,j", "t,r,i" };
static const char *const mfhl_fmt[2] = { "mj", "s" };

#define BRK_FMT (brk_fmt[nanomips_opts.insn32])
#define COP12_FMT "E,+j(b)"
#define JALR_FMT "t,s"
#define LUI_FMT "t,u"

#define ADDIU_FMT (addiu_fmt[HAVE_32BIT_ADDRESSES? 0 : 1])
#define ADDIUGP_FMT "t,ma,."
#define LWGP_FMT "t,.(ma)"
#define LDGP_FMT "t,.(ma)"
#define MEM12_FMT "t,+j(b)"
#define LL_SC_FMT "t,+m(b)"
#define LLP_SCP_FMT "t,mu,(b)"
#define LLD_SCD_FMT "t,+q(b)"
#define LLE_SCE_FMT "t,+m(b)"
#define LWU_FMT "t,o(b)"
#define MFHL_FMT (mfhl_fmt[nanomips_opts.insn32])
#define SHFT_FMT "t,r,<"
#define TRAP_FMT "s,t,|"
#define ACLR_FMT "\\,+j(b)"
#define BCONDZ1_FMT "s,p"
#define BCONDZ2_FMT "t,p"
#define B_FMT "+'"
#define JAL_FMT "+'"
#define OP_IMM_FMT "t,r,i"
#define BITOP_IMM_FMT "t,r,g"
#define PREF_FMT "k,+j(b)"
#define BITW_FMT "d,v,t"
#define DIV_FMT "d,v,t"
#define MOVE_FMT "-p,mj"
#define ISA_OFFBITS 12
#define ISA_ADD_OFFBITS (HAVE_32BIT_ADDRESSES ? 16 : 12)
#define ISA_SIGNED_OFFBITS 9
#define ISA_COP2_OFFBITS 9
#define ISA_LLSC_OFFBITS 9

#define ISA_LLDSCD_OFFBITS 6

#define ISA_CACHE_OFFBITS ISA_LLSC_OFFBITS

#define MAX_PIC_OFFSET 0x1fffc

#define MIN_PIC_OFFSET 0

#define ISA_BFD_RELOC_LOW BFD_RELOC_NANOMIPS_LO12

#define ISA_SIGNED_LDST_FMT "t,+j(b)"
#define ISA_UNSIGNED_LDST_FMT "t,o(b)"
#define ISA_UNSIGNED_COP1_FMT "T,o(b)"
#define ISA_SIGNED_COP1_FMT "T,+j(b)"


/* Read a macro's relocation codes from *ARGS and store them in *R.
   The first argument in *ARGS will be either the code for a single
   relocation or -1 followed by the three codes that make up a
   composite relocation.  */

static void
macro_read_relocs (va_list *args, bfd_reloc_code_real_type *r)
{
  int i, next;

  next = va_arg (*args, int);
  if (next >= 0)
    r[0] = (bfd_reloc_code_real_type) next;
  else
    {
      for (i = 0; i < 3; i++)
	r[i] = (bfd_reloc_code_real_type) va_arg (*args, int);
      /* This function is only used for 16-bit relocation fields.
         To make the macro code simpler, treat an unrelocated value
         in the same way as BFD_RELOC_LO16.  */
      if (r[0] == BFD_RELOC_UNUSED)
	r[0] = BFD_RELOC_LO16;
    }
}

/* Map an <format,reloc> pair to nanoMIPS relocs.  */

static void
macro_match_nanomips_reloc (const char *fmt, bfd_reloc_code_real_type *r)
{
  if (*r == BFD_RELOC_LO16)
    {
      if (*fmt == 'o' || *fmt == 'g')
	*r = BFD_RELOC_NANOMIPS_LO12;
      else if (*fmt == 'j')
	*r = BFD_RELOC_NANOMIPS_IMM16;
      else if (*fmt == 'h')
	*r = BFD_RELOC_NANOMIPS_NEG12;
    }
  else if (*r == BFD_RELOC_GPREL16)
    {
      if (*fmt == '.')
	*r = BFD_RELOC_NANOMIPS_GPREL19_S2;
      else if (*fmt == '+' && *(fmt + 1) == '2')
	*r = BFD_RELOC_NANOMIPS_GPREL16_S2;
      else if (*fmt == '+' && *(fmt + 1) == '1')
	*r = BFD_RELOC_NANOMIPS_GPREL18;
      else if (*fmt == '+' && *(fmt + 1) == '3')
	*r = BFD_RELOC_NANOMIPS_GPREL17_S1;
      else if (*fmt == 'm' && *(fmt + 1) == 'V')
	*r = BFD_RELOC_NANOMIPS_GPREL18_S3;
      else
	gas_assert (FALSE);
    }
  if (*r == _dummy_first_bfd_reloc_code_real)
    *r = BFD_RELOC_UNUSED;
  else if (!nanomips_reloc_p (*r))
    {
      *r = nanomips_map_reloc (*r);
      gas_assert (nanomips_reloc_p (*r));
    }
}

/* Build an instruction created by a macro expansion.  This is passed
   a pointer to the count of instructions created so far, an
   expression, the name of the instruction to build, an operand format
   string, and corresponding arguments.  */

static void
macro_build (expressionS *ep, const char *name, const char *fmt, ...)
{
  const struct nanomips_opcode *mo = NULL;
  bfd_reloc_code_real_type r[3];
  const struct nanomips_opcode *amo;
  const struct nanomips_operand *operand;
  struct hash_control *hash;
  struct nanomips_cl_insn insn;
  va_list args;
  unsigned int uval;

  va_start (args, fmt);

  r[0] = BFD_RELOC_UNUSED;
  r[1] = BFD_RELOC_UNUSED;
  r[2] = BFD_RELOC_UNUSED;
  hash = nanomips_op_hash;

  amo = (struct nanomips_opcode *) hash_find (hash, name);
  gas_assert (amo);
  gas_assert (strcmp (name, amo->name) == 0);

  do
    {
      /* Search until we get a match for NAME.  */
      if (strcmp (fmt, amo->args) == 0
	  && amo->pinfo != INSN_MACRO
	  && is_opcode_valid (amo)
	  && is_size_valid (amo))
	{
	  if (!mo)
	    mo = amo;
	}

      ++amo;
      gas_assert (amo->name);
    }
  while (strcmp (name, amo->name) == 0);

  gas_assert (mo);
  create_insn (&insn, mo);
  for (; *fmt; ++fmt)
    {
      switch (*fmt)
	{
	case ',':
	case '(':
	case ')':
	case 'z':
	  continue;

	case 'i':
	case 'g':
	case 'j':
	case 'h':
	  macro_read_relocs (&args, r);
	  macro_match_nanomips_reloc (fmt, r);
	  continue;

	case '~':
	case 'o':
	  macro_read_relocs (&args, r);
	  macro_match_nanomips_reloc (fmt, r);
	  continue;

	case 'u':
	  macro_read_relocs (&args, r);
	  gas_assert (ep != NULL
		      && (ep->X_op == O_constant
			  || (ep->X_op == O_symbol
			      && hi_reloc_p (*r))));
	  macro_match_nanomips_reloc (fmt, r);
	  continue;

	case '+':
	  if ((*(fmt + 1) == 'm'
	       || *(fmt + 1) == 'j'
	       || *(fmt + 1) == '1'
	       || *(fmt + 1) == '2'
	       || *(fmt + 1) == '3'
	       || *(fmt + 1) == '9'
	       || *(fmt + 1) == 'Q'
	       || *(fmt + 1) == 'R'
	       || *(fmt + 1) == 'S')
	      && ep != NULL)
	    {
	      macro_read_relocs (&args, r);
	      macro_match_nanomips_reloc (fmt, r);
	      if (*(fmt + 1) == 'Q' || *(fmt + 1) == 'R' || *(fmt + 1) == 'S')
		break;
	      fmt++;
	      continue;
	    }

	  if (*(fmt + 1) == '\"' || *(fmt + 1) == '\'')
	    {
	      if (*(fmt + 1) == '\'')
		r[0] = BFD_RELOC_NANOMIPS_25_PCREL_S1;
	      else if (*(fmt + 1) == '\"')
		r[0] = BFD_RELOC_NANOMIPS_21_PCREL_S1;
	      fmt++;
	      continue;
	    }
	  break;

	case 'p':
	  gas_assert (ep != NULL);

	  /*
	   * This allows macro() to pass an immediate expression for
	   * creating short branches without creating a symbol.
	   *
	   * We don't allow branch relaxation for these branches, as
	   * they should only appear in ".set nomacro" anyway.
	   */
	  *r = BFD_RELOC_NANOMIPS_14_PCREL_S1;
	  macro_match_nanomips_reloc (fmt, r);
	  continue;

	case 'm':
	  if (*(fmt + 1) == 'V' || *(fmt + 1) == 'K')
	    {
	      macro_read_relocs (&args, r);
	      macro_match_nanomips_reloc (fmt, r);
	      fmt++;
	      continue;
	    }
	  break;

	case '.':
	  macro_read_relocs (&args, r);
	  macro_match_nanomips_reloc (fmt, r);
	  continue;

	case '-':
	  if (*(fmt + 1) == 'i')
	    macro_read_relocs (&args, r);
	  /* Fall through.  */

	default:
	  break;
	}

      operand = decode_nanomips_operand (fmt);
      if (!operand)
	abort ();

      uval = va_arg (args, int);

      if (operand->type == OP_INT_WORD
	  || operand->type == OP_UINT_WORD
	  || operand->type == OP_PC_WORD
	  || operand->type == OP_GPREL_WORD
	  || operand->type == OP_IMM_WORD)
	insn.insn_opcode_ext = 0;
      else if (operand->type == OP_NEG_INT)
	insn_insert_operand (&insn, operand, -uval);
      else
	insn_insert_operand (&insn, operand, uval);

      if ((*fmt == '+') || *fmt == 'm' || *fmt == '-' || *fmt == '`')
	++fmt;
    }

  va_end (args);
  gas_assert (*r == BFD_RELOC_UNUSED ? ep == NULL : ep != NULL);

  append_insn (&insn, ep, r, TRUE);
}

/*
 * Generate a "lui" instruction.
 */
static void
macro_build_lui (expressionS *ep, int regnum)
{
  if (ep->X_op != O_constant)
    gas_assert (ep->X_op == O_symbol);

  macro_build (ep, "lui", LUI_FMT, regnum, BFD_RELOC_NANOMIPS_HI20);
}

/* Return the high part that should be loaded in order to make the low
   part of VALUE accessible using an offset of OFFBITS bits.  */

static offsetT
offset_high_part (offsetT value, unsigned int offbits)
{
  offsetT bias;
  addressT low_mask;

  if (offbits == 0)
    return value;
  bias = 1 << (offbits - 1);
  low_mask = bias * 2 - 1;
  if (offbits == ISA_OFFBITS)
    /* Low part is 12-bit unsigned, so no bias necessary.  */
    return value & ~low_mask;
  else
    return (value + bias) & ~low_mask;
}

/* Return the high part that should be loaded in order to make the low
   part of VALUE accessible using an offset of OFFBITS bits.  */

static offsetT
offset_high_unsigned (offsetT value, unsigned int offbits)
{
  addressT low_mask;

  if (offbits == 0)
    return value;
  low_mask = (1 << (offbits - 1)) * 2 - 1;
  return value & ~low_mask;
}

/*			set_at()
 * Generates code to set the $at register to true (one)
 * if reg is less than the immediate expression.
 */
static void
set_at (int reg, int unsignedp)
{
  if (offset_high_part (imm_expr.X_add_number, ISA_OFFBITS) == 0)
    macro_build (&imm_expr, unsignedp ? "sltiu" : "slti", OP_IMM_FMT,
		 AT, reg, BFD_RELOC_LO16);
  else
    {
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, unsignedp ? "sltu" : "slt", "d,v,t", AT, reg, AT);
    }
}

/* Count the leading zeroes by performing a binary chop. This is a
   bulky bit of source, but performance is a LOT better for the
   majority of values than a simple loop to count the bits:
       for (lcnt = 0; (lcnt < 32); lcnt++)
         if ((v) & (1 << (31 - lcnt)))
           break;
  However it is not code size friendly, and the gain will drop a bit
  on certain cached systems.
*/
#define COUNT_TOP_ZEROES(v)             \
  (((v) & ~0xffff) == 0                 \
   ? ((v) & ~0xff) == 0                 \
     ? ((v) & ~0xf) == 0                \
       ? ((v) & ~0x3) == 0              \
         ? ((v) & ~0x1) == 0            \
           ? !(v)                       \
             ? 32                       \
             : 31                       \
           : 30                         \
         : ((v) & ~0x7) == 0            \
           ? 29                         \
           : 28                         \
       : ((v) & ~0x3f) == 0             \
         ? ((v) & ~0x1f) == 0           \
           ? 27                         \
           : 26                         \
         : ((v) & ~0x7f) == 0           \
           ? 25                         \
           : 24                         \
     : ((v) & ~0xfff) == 0              \
       ? ((v) & ~0x3ff) == 0            \
         ? ((v) & ~0x1ff) == 0          \
           ? 23                         \
           : 22                         \
         : ((v) & ~0x7ff) == 0          \
           ? 21                         \
           : 20                         \
       : ((v) & ~0x3fff) == 0           \
         ? ((v) & ~0x1fff) == 0         \
           ? 19                         \
           : 18                         \
         : ((v) & ~0x7fff) == 0         \
           ? 17                         \
           : 16                         \
   : ((v) & ~0xffffff) == 0             \
     ? ((v) & ~0xfffff) == 0            \
       ? ((v) & ~0x3ffff) == 0          \
         ? ((v) & ~0x1ffff) == 0        \
           ? 15                         \
           : 14                         \
         : ((v) & ~0x7ffff) == 0        \
           ? 13                         \
           : 12                         \
       : ((v) & ~0x3fffff) == 0         \
         ? ((v) & ~0x1fffff) == 0       \
           ? 11                         \
           : 10                         \
         : ((v) & ~0x7fffff) == 0       \
           ? 9                          \
           : 8                          \
     : ((v) & ~0xfffffff) == 0          \
       ? ((v) & ~0x3ffffff) == 0        \
         ? ((v) & ~0x1ffffff) == 0      \
           ? 7                          \
           : 6                          \
         : ((v) & ~0x7ffffff) == 0      \
           ? 5                          \
           : 4                          \
       : ((v) & ~0x3fffffff) == 0       \
         ? ((v) & ~0x1fffffff) == 0     \
           ? 3                          \
           : 2                          \
         : ((v) & ~0x7fffffff) == 0     \
           ? 1                          \
           : 0)

/*			load_register()
 *  This routine generates the least number of instructions necessary to load
 *  an absolute expression value into a register.
 */
static void
load_register (int reg, expressionS *ep, int dbl)
{
  int freg;
  expressionS hi32, lo32;

  if (ep->X_op != O_big)
    {
      gas_assert (ep->X_op == O_constant);

      /* Sign-extending 32-bit constants makes their handling easier.  */
      if (!dbl)
	normalize_constant_expr (ep);

      if ((int)ep->X_add_number >= -1
	  && ep->X_add_number <= 126
	  && (reg >> 2 == 1 || reg >> 2 == 4))
	{
	  /* 7-bit values loaded using LI[16].  */
	  macro_build (NULL, "li", "md,mI", reg, (int) ep->X_add_number);
	  return;
	}
      if (IS_SEXT_16BIT_UINT (ep->X_add_number))
	{
	  /* We can handle 16 bit unsigned values with an addiu to
	     $zero.  No need to ever use daddiu here, since $zero and
	     the result are always correct in 32 bit mode.  */
	  macro_build (ep, ADDRESS_ADDI_INSN, ADDIU_FMT, reg, 0,
		       BFD_RELOC_NANOMIPS_IMM16);
	  return;
	}
      if (offset_high_unsigned (-ep->X_add_number, ISA_OFFBITS) == 0)
	{
	  macro_build (ep, "addiu", "t,r,h", reg, 0,
		       BFD_RELOC_NANOMIPS_NEG12);
	  return;
	}
      else if ((IS_SEXT_32BIT_NUM (ep->X_add_number)))
	{
	  if ((nanomips_opts.ase & ASE_xNMS) != 0
	      && (ep->X_add_number & 0xfff) != 0
	      && (*offset_reloc == BFD_RELOC_UNUSED
		  || pcrel_reloc_p (*offset_reloc))
	      && !nanomips_opts.insn32)
	    macro_build (ep, "li", "mp,+Q", reg, BFD_RELOC_NANOMIPS_I32);
	  else
	    {
	      /* 32 bit values require an lui.  */
	      macro_build (ep, "lui", "t,u", reg, BFD_RELOC_NANOMIPS_HI20);
	      if ((ep->X_add_number & 0xfff) != 0
		  && !hi_reloc_p (*offset_reloc))
		macro_build (ep, "ori", BITOP_IMM_FMT, reg, reg,
			     BFD_RELOC_NANOMIPS_LO12);
	    }
	  return;
	}
    }

  /* The value is larger than 32 bits.  */

  if (!dbl || GPR_SIZE == 32)
    {
      char value[32];

      sprintf_vma (value, ep->X_add_number);
      as_bad (_("number (0x%s) larger than 32 bits"), value);
      macro_build (ep, "addiu", ADDIU_FMT, reg, 0, BFD_RELOC_LO16);
      return;
    }

  if (ep->X_op != O_big)
    {
      hi32 = *ep;
      hi32.X_add_number = (valueT) hi32.X_add_number >> 16;
      hi32.X_add_number = (valueT) hi32.X_add_number >> 16;
      hi32.X_add_number &= 0xffffffff;
      lo32 = *ep;
      lo32.X_add_number &= 0xffffffff;
    }
  else
    {
      gas_assert (ep->X_add_number > 2);
      if (ep->X_add_number == 3)
	generic_bignum[3] = 0;
      else if (ep->X_add_number > 4)
	as_bad (_("number larger than 64 bits"));
      lo32.X_op = O_constant;
      lo32.X_add_number = generic_bignum[0] + (generic_bignum[1] << 16);
      hi32.X_op = O_constant;
      hi32.X_add_number = generic_bignum[2] + (generic_bignum[3] << 16);
    }

  if (hi32.X_add_number == 0)
    freg = 0;
  else
    {
      int shift, bit;
      unsigned long hi, lo;

      if (hi32.X_add_number == (offsetT) 0xffffffff)
	{
	  if ((lo32.X_add_number & 0xffff8000) == 0xffff8000)
	    {
	      macro_build (&lo32, "addiu", ADDIU_FMT, reg, 0, BFD_RELOC_LO16);
	      return;
	    }
	  if (lo32.X_add_number & 0x80000000)
	    {
	      macro_build (&lo32, "lui", LUI_FMT, reg, BFD_RELOC_HI16);
	      if (lo32.X_add_number & 0xffff)
		macro_build (&lo32, "ori", BITOP_IMM_FMT, reg, reg, 
			     BFD_RELOC_LO16);
	      return;
	    }
	}

      if (!nanomips_opts.insn32)
	{
	  macro_build (ep, "dlui", "mp,+Q", reg, BFD_RELOC_NANOMIPS_HI32);
	  macro_build (ep, "daddiu", "mp,mt,+R", reg, reg,
		       BFD_RELOC_NANOMIPS_I32);
	  return;
	}

      /* Check for 16bit shifted constant.  We know that hi32 is
         non-zero, so start the mask on the first bit of the hi32
         value.  */
      shift = 17;
      do
	{
	  unsigned long himask, lomask;

	  if (shift < 32)
	    {
	      himask = 0xffff >> (32 - shift);
	      lomask = (0xffff << shift) & 0xffffffff;
	    }
	  else
	    {
	      himask = 0xffff << (shift - 32);
	      lomask = 0;
	    }
	  if ((hi32.X_add_number & ~(offsetT) himask) == 0
	      && (lo32.X_add_number & ~(offsetT) lomask) == 0)
	    {
	      expressionS tmp;

	      tmp.X_op = O_constant;
	      if (shift < 32)
		tmp.X_add_number = ((hi32.X_add_number << (32 - shift))
				    | (lo32.X_add_number >> shift));
	      else
		tmp.X_add_number = hi32.X_add_number >> (shift - 32);
	      macro_build (&tmp, "ori", BITOP_IMM_FMT, reg, 0, BFD_RELOC_LO16);
	      macro_build (NULL, (shift >= 32) ? "dsll32" : "dsll", SHFT_FMT,
			   reg, reg, (shift >= 32) ? shift - 32 : shift);
	      return;
	    }
	  ++shift;
	}
      while (shift <= (64 - 16));

      /* Find the bit number of the lowest one bit, and store the
         shifted value in hi/lo.  */
      hi = (unsigned long) (hi32.X_add_number & 0xffffffff);
      lo = (unsigned long) (lo32.X_add_number & 0xffffffff);
      if (lo != 0)
	{
	  bit = 0;
	  while ((lo & 1) == 0)
	    {
	      lo >>= 1;
	      ++bit;
	    }
	  lo |= (hi & (((unsigned long) 1 << bit) - 1)) << (32 - bit);
	  hi >>= bit;
	}
      else
	{
	  bit = 32;
	  while ((hi & 1) == 0)
	    {
	      hi >>= 1;
	      ++bit;
	    }
	  lo = hi;
	  hi = 0;
	}

      /* Optimize if the shifted value is a (power of 2) - 1.  */
      if ((hi == 0 && ((lo + 1) & lo) == 0)
	  || (lo == 0xffffffff && ((hi + 1) & hi) == 0))
	{
	  shift = COUNT_TOP_ZEROES ((unsigned int) hi32.X_add_number);
	  if (shift != 0)
	    {
	      expressionS tmp;

	      /* This instruction will set the register to be all ones.  */
	      tmp.X_op = O_constant;
	      tmp.X_add_number = (offsetT) - 1;
	      macro_build (&tmp, "addiu", ADDIU_FMT, reg, 0, BFD_RELOC_LO16);
	      if (bit != 0)
		{
		  bit += shift;
		  macro_build (NULL, (bit >= 32) ? "dsll32" : "dsll",
			       SHFT_FMT, reg, reg,
			       (bit >= 32) ? bit - 32 : bit);
		}
	      macro_build (NULL, (shift >= 32) ? "dsrl32" : "dsrl", SHFT_FMT,
			   reg, reg, (shift >= 32) ? shift - 32 : shift);
	      return;
	    }
	}

      /* Sign extend hi32 before calling load_register, because we can
         generally get better code when we load a sign extended value.  */
      if ((hi32.X_add_number & 0x80000000) != 0)
	hi32.X_add_number |= ~(offsetT) 0xffffffff;
      load_register (reg, &hi32, 0);
      freg = reg;
    }
  if ((lo32.X_add_number & 0xffff0000) == 0)
    {
      if (freg != 0)
	{
	  macro_build (NULL, "dsll32", SHFT_FMT, reg, freg, 0);
	  freg = reg;
	}
    }
  else
    {
      expressionS mid16;

      if ((freg == 0) && (lo32.X_add_number == (offsetT) 0xffffffff))
	{
	  macro_build (&lo32, "lui", LUI_FMT, reg, BFD_RELOC_HI16);
	  macro_build (NULL, "dsrl32", SHFT_FMT, reg, reg, 0);
	  return;
	}

      if (freg != 0)
	{
	  macro_build (NULL, "dsll", SHFT_FMT, reg, freg, 16);
	  freg = reg;
	}
      mid16 = lo32;
      mid16.X_add_number >>= 16;
      macro_build (&mid16, "ori", BITOP_IMM_FMT, reg, freg, BFD_RELOC_LO16);
      macro_build (NULL, "dsll", SHFT_FMT, reg, reg, 16);
      freg = reg;
    }
  if ((lo32.X_add_number & 0xffff) != 0)
    macro_build (&lo32, "ori", BITOP_IMM_FMT, reg, freg, BFD_RELOC_LO16);
}

/* Move the contents of register SOURCE into register DEST.  */

static void
move_register (int dest, int source)
{
  /* Prefer to use a 16-bit microMIPS instruction unless the previous
     instruction specifically requires a 32-bit one.  */
  if (!nanomips_opts.insn32)
    macro_build (NULL, "move", MOVE_FMT, dest, source);
  else
    macro_build (NULL, "or", "d,v,t", dest, source, 0);
}

/* Emit a two-argument branch macro specified by TYPE, using SREG as
   the register tested.  EP specifies the branch target.  */

static void
macro_build_branch_rs (int type, expressionS *ep, unsigned int sreg)
{
  const char *br;

  switch (type)
    {
    case M_BGEZ:
      br = "bgez";
      break;
    case M_BGTZ:
      br = "bgtz";
      break;
    case M_BLEZ:
      br = "blez";
      break;
    case M_BLTZ:
      br = "bltz";
      break;
    default:
      abort ();
    }

  if (type == M_BGTZ || type == M_BLEZ)
    macro_build (ep, br, BCONDZ2_FMT, sreg);
  else
    macro_build (ep, br, BCONDZ1_FMT, sreg);
}

/* Emit a three-argument branch macro specified by TYPE, using SREG and
   TREG as the registers tested.  EP specifies the branch target.  */

static void
macro_build_branch_rsrt (int type, expressionS *ep,
			 unsigned int sreg, unsigned int treg)
{
  const char *br;

  switch (type)
    {
    case M_BEQ:
    case M_BEQ_I:
      br = "beq";
      break;
    case M_BNE:
    case M_BNE_I:
      br = "bne";
      break;
    default:
      abort ();
    }

  if (treg == 0)
    macro_build (ep, br, "s,t,p", treg, sreg);
  else
    macro_build (ep, br, "s,t,p", sreg, treg);
}

/* Emit a three-argument branch macro specified by TYPE, using SREG and
   TREG as the registers tested.  EP specifies the branch target.  */

static void
macro_build_branch_rtim (int type, expressionS *ep,
			 unsigned int sreg, expressionS *imex)
{
  const char *br;
  int imm = imex->X_add_number;

  switch (type)
    {
    case M_BEQ_I:
      br = "beqic";
      break;
    case M_BGE_I:
      br = "bgeic";
      break;
    case M_BGEU_I:
    case M_BGTU_I:
      br = "bgeiuc";
      break;
    case M_BLT_I:
    case M_BLE_I:
      br = "bltic";
      break;
    case M_BLTU_I:
    case M_BLEU_I:
      br = "bltiuc";
      break;
    case M_BNE_I:
      br = "bneic";
      break;
    default:
      abort ();
    }

  macro_build (ep, br, "t,m9,~", sreg, imm, BFD_RELOC_NANOMIPS_11_PCREL_S1);
}

/* Return true if the value stored in offset_expr and offset_reloc
   fits into a signed offset of OFFBITS bits.  RANGE is the maximum
   amount that the caller wants to add without inducing overflow
   and ALIGN is the known alignment of the value in bytes.  */

static bfd_boolean
small_offset_p (unsigned int range, unsigned int align, unsigned int offbits)
{
  if (offbits == 16)
    {
      /* Accept any relocation operator if overflow isn't a concern.  */
      if (range < align && *offset_reloc != BFD_RELOC_UNUSED)
	return TRUE;

      /* These relocations are guaranteed not to overflow in correct links.  */
      if (gprel16_reloc_p (*offset_reloc))
	return TRUE;
    }

  if (offset_expr.X_op == O_constant
      && offset_high_part (offset_expr.X_add_number, offbits) == 0
      && offset_high_part (offset_expr.X_add_number + range, offbits) == 0
      && offset_expr.X_add_number % align == 0
      && range % align == 0)
    return TRUE;

  return FALSE;
}

static bfd_boolean
small_poffset_p (unsigned int range, unsigned align, unsigned int offbits)
{
  if (offset_expr.X_op == O_constant
      && offset_expr.X_add_number >= 0
      && offset_expr.X_add_number + range < (1 << offbits)
      && offset_expr.X_add_number % align == 0
      && range % align == 0)
    return TRUE;

  if (lo_reloc_p (*offset_reloc))
    return TRUE;

  return FALSE;
}

static bfd_boolean
small_noffset_p (unsigned int range, unsigned int offbits)
{
  if (offset_expr.X_op == O_constant
      && offset_expr.X_add_number < 0
      && -offset_expr.X_add_number + range < (1 << offbits))
    return TRUE;

  return FALSE;
}

static bfd_boolean
small_add_offset_p (unsigned int range)
{
  return (small_poffset_p (range, 1, ISA_ADD_OFFBITS)
	  || (small_noffset_p (range, ISA_OFFBITS)));
}

/* Check if an address offset fits within 32-bit address mode.  */

static bfd_boolean
check_offset_range (offsetT offset)
{
    if (HAVE_32BIT_ADDRESSES && !IS_SEXT_32BIT_NUM (offset))
    {
      char value[32];

      sprintf_vma (value, offset);
      as_bad (_("number (0x%s) larger than 32 bits"), value);
      return FALSE;
    }

    return TRUE;
}

/* Expand the LA macro for PC-relative addressing.  */

static void
nanomips_macro_pcrel_la (unsigned int dest)
{
  if ((nanomips_opts.ase & ASE_xNMS) != 0
      && *offset_reloc == BFD_RELOC_UNUSED
      && !nanomips_opts.insn32)
    macro_build (&offset_expr, "lapc", "mp,+S", dest,
		 BFD_RELOC_NANOMIPS_PC_I32);
  else
    {
      macro_build (&offset_expr, "aluipc", "t,mK", dest,
		   BFD_RELOC_NANOMIPS_PCREL_HI20);
      macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIU_FMT,
		   dest, dest, BFD_RELOC_NANOMIPS_LO12);
    }
}

/* Expand the LA macro for absolute addressing.  */

static void
nanomips_macro_absolute_la (unsigned int dest)
{
  if ((nanomips_opts.ase & ASE_xNMS) != 0
      && *offset_reloc == BFD_RELOC_UNUSED
      && !nanomips_opts.insn32)
    macro_build (&offset_expr, "li", "mp,+Q", dest, BFD_RELOC_NANOMIPS_I32);
  else
    {
      macro_build_lui (&offset_expr, dest);
      if (!hi_reloc_p (*offset_reloc))
	macro_build (&offset_expr, "ori", BITOP_IMM_FMT,
		     dest, dest, ISA_BFD_RELOC_LOW);
    }
}

/* Expand the LA macro.  */

static void
nanomips_macro_la (unsigned int op[], unsigned int breg, int *used_at)
{
  unsigned int tempreg;

  if (small_poffset_p (0, 1, ISA_ADD_OFFBITS))
    {
      macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIU_FMT, op[0], breg,
		   -1, offset_reloc[0], offset_reloc[1], offset_reloc[2]);
      return;
    }
  else if (small_noffset_p (0, ISA_OFFBITS))
    {
      macro_build (&offset_expr, ADDRESS_ADDI_INSN, "t,r,h", op[0], breg,
		   -1, offset_reloc[0], offset_reloc[1], offset_reloc[2]);
      return;
    }

  if (nanomips_opts.at && (op[0] == breg))
    {
      tempreg = AT;
      *used_at = 1;
    }
  else
    tempreg = op[0];

  if ((offset_expr.X_op != O_symbol && offset_expr.X_op != O_constant)
      || (offset_expr.X_op == O_symbol && hi_reloc_p (offset_reloc[0])))
    {
      as_bad (_("expression too complex"));
      offset_expr.X_op = O_constant;
    }

  if (offset_expr.X_op == O_constant && hi_reloc_p (offset_reloc[0]))
    offset_expr.X_add_number = offset_high_part (offset_expr.X_add_number,
						 ISA_OFFBITS);

  if (!check_offset_range (offset_expr.X_add_number))
    return;

  if (offset_expr.X_op == O_constant)
    load_register (tempreg, &offset_expr, HAVE_64BIT_ADDRESSES);
  else if (nanomips_opts.pic == NO_PIC)
    {
      if (HAVE_64BIT_SYMBOLS)
	{
	  if ((valueT) offset_expr.X_add_number <= MAX_GPREL_OFFSET
	      && !nopic_need_relax (offset_expr.X_add_symbol, 1)
	      && (nanomips_opts.mc_model == MC_MEDIUM
		  || nanomips_opts.mc_model == MC_AUTO))
	    {
	      relax_start (offset_expr.X_add_symbol);
	      macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIUGP_FMT,
			   tempreg, nanomips_gp_register, BFD_RELOC_GPREL16);
	      relax_switch ();
	    }

	  macro_build (&offset_expr, "dlui", "mp,+Q",
		       tempreg, BFD_RELOC_NANOMIPS_HI32);
	  macro_build (&offset_expr, "daddiu", "mp,mt,+R",
		       tempreg, tempreg, BFD_RELOC_NANOMIPS_I32);

	  if (nanomips_relax.sequence)
	    relax_end ();
	}
      else
	{
	  if ((valueT) offset_expr.X_add_number <= MAX_GPREL_OFFSET
	      && !nopic_need_relax (offset_expr.X_add_symbol, 1)
	      && (nanomips_opts.mc_model == MC_MEDIUM
		  || nanomips_opts.mc_model == MC_AUTO))
	    {
	      relax_start (offset_expr.X_add_symbol);
	      macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIUGP_FMT,
			   op[0], nanomips_gp_register, BFD_RELOC_GPREL16);
	      relax_switch ();
	    }

	  if (nanomips_opts.pcrel)
	    nanomips_macro_pcrel_la (op[0]);
	  else
	    nanomips_macro_absolute_la (op[0]);

	  if (nanomips_relax.sequence)
	    relax_end ();
	}
    }
  else
    {
      relax_start (offset_expr.X_add_symbol);

      if (nanomips_opts.pic == SVR4_PIC || linkrelax)
	macro_build (&offset_expr, ADDRESS_LOAD_INSN, LWGP_FMT,
		     tempreg, BFD_RELOC_NANOMIPS_GOT_DISP,
		     nanomips_gp_register);
      else if ((nanomips_opts.ase & ASE_xNMS) != 0 && !nanomips_opts.insn32)
	macro_build (&offset_expr, "lwpc", "mp,+S", tempreg,
		     BFD_RELOC_NANOMIPS_GOTPC_I32);
      else
	{
	  macro_build (&offset_expr, "aluipc", "t,mK", op[0],
		       BFD_RELOC_NANOMIPS_GOTPC_HI20);
	  macro_build (&offset_expr, ADDRESS_LOAD_INSN, LWGP_FMT,
		       tempreg, BFD_RELOC_NANOMIPS_GOT_LO12, op[0]);
	}

      relax_switch ();
      /* Local symbols can be PC-relative.  */
      nanomips_macro_pcrel_la (op[0]);
      relax_end ();
    }

  if (breg != 0)
    macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", op[0], tempreg, breg);
}

static void
nanomips_macro_absolute_ld_st (const char *s, const char *fmt,
			       unsigned int op[],
			       unsigned int tempreg, unsigned int breg)
{
  if (breg == 0)
    {
      macro_build_lui (&offset_expr, tempreg);
      macro_build (&offset_expr, s, fmt, op[0], BFD_RELOC_LO16, tempreg);
    }
  else
    {
      macro_build_lui (&offset_expr, tempreg);
      macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", tempreg, tempreg, breg);
      macro_build (&offset_expr, s, fmt, op[0], BFD_RELOC_LO16, tempreg);
    }
}

static void
nanomips_macro_pcrel_ld_st (const char *s, const char *fmt, unsigned int op[],
			    unsigned int tempreg, bfd_boolean coproc)
{
  if ((nanomips_opts.ase & ASE_xNMS) != 0
      && *offset_reloc == BFD_RELOC_UNUSED
      && !nanomips_opts.insn32
      && !coproc)
    macro_build (&offset_expr, "lwpc", "mp,+S", op[0],
		 BFD_RELOC_NANOMIPS_PC_I32);
  else
    {
      macro_build (&offset_expr, "aluipc", "t,mK", tempreg,
		   BFD_RELOC_NANOMIPS_PCREL_HI20);
      macro_build (&offset_expr, s, fmt,
		   op[0], BFD_RELOC_NANOMIPS_LO12, tempreg);
    }
}

static void
nanomips_macro_ld_st (const char *s, const char *fmt, unsigned int op[],
		      const char *gpfmt, int align, int offbits,
		      unsigned int breg, unsigned int tempreg, int *used_at,
		      bfd_boolean coproc)
{
  expressionS expr1;
  expr1.X_op = O_constant;
  expr1.X_op_symbol = NULL;
  expr1.X_add_symbol = NULL;
  expr1.X_add_number = 1;

  if (small_add_offset_p (0))
    {
      /* The first case exists for M_LD_AB and M_SD_AB, which are
         macros for o32 but which should act like normal instructions
         otherwise.  */
      if (offbits == ISA_OFFBITS && small_poffset_p (0, align, offbits))
	macro_build (&offset_expr, s, fmt, op[0], -1, offset_reloc[0],
		     offset_reloc[1], offset_reloc[2], breg);
      else if (small_offset_p (0, align, offbits))
	macro_build (NULL, s, fmt, op[0],
		     (int) offset_expr.X_add_number, breg);
      else
	{
	  /* Source destroying loads do not need AT for expansion.  */
	  if (s[0] == 'l' && op[0] == breg && op[0] != 0)
	    tempreg = breg;
	  else if (tempreg == AT)
	    *used_at = 1;

	  if (small_poffset_p (0, 1, ISA_ADD_OFFBITS))
	    macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIU_FMT,
			 tempreg, breg, -1, offset_reloc[0],
			 offset_reloc[1], offset_reloc[2]);
	  else if (small_noffset_p (0, ISA_OFFBITS))
	    macro_build (&offset_expr, ADDRESS_ADDI_INSN, "t,r,h",
			 tempreg, breg, -1, offset_reloc[0],
			 offset_reloc[1], offset_reloc[2]);
	  macro_build (NULL, s, fmt, op[0], 0, tempreg);
	}
      return;
    }

  if (tempreg == AT)
    *used_at = 1;

  if ((offset_expr.X_op != O_constant && offset_expr.X_op != O_symbol)
      || (offset_expr.X_op == O_symbol && hi_reloc_p (offset_reloc[0])))
    {
      as_bad (_("expression too complex"));
      offset_expr.X_op = O_constant;
    }

  if (offset_expr.X_op == O_constant && hi_reloc_p (offset_reloc[0]))
    offset_expr.X_add_number = offset_high_part (offset_expr.X_add_number,
						 ISA_OFFBITS);

  if (!check_offset_range (offset_expr.X_add_number))
    return;

  /* A constant expression in PIC code can be handled just as it
     is in non PIC code.  */
  if (offset_expr.X_op == O_constant)
    {
      if (op[0] == breg
	  && op[0] != 0
	  && (nanomips_opts.ase & ASE_xNMS) != 0
	  && (offset_high_part (offset_expr.X_add_number, offbits)
	      != offset_expr.X_add_number))
	{
	  *used_at = 0;
	  macro_build (&offset_expr, "addiu", "mp,mt,+R", op[0], op[0],
		       BFD_RELOC_NANOMIPS_I32);
	  macro_build (NULL, s, fmt, op[0], 0, op[0]);
	}
      else
	{
	  expr1.X_add_number = offset_high_part (offset_expr.X_add_number,
						 offbits);
	  if (offbits != ISA_OFFBITS && (expr1.X_add_number & 0xfff) != 0)
	    expr1 = offset_expr;
	  offset_expr.X_add_number -= expr1.X_add_number;

	  load_register (tempreg, &expr1, HAVE_64BIT_ADDRESSES);
	  if (breg != 0)
	    macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", tempreg,
			 tempreg, breg);

	  if (offbits == ISA_OFFBITS)
	    macro_build (&offset_expr, s, fmt, op[0],
			 BFD_RELOC_NANOMIPS_LO12, tempreg);
	  else
	    macro_build (NULL, s, fmt, op[0], (int) offset_expr.X_add_number,
			 tempreg);
	}
    }
  else if (offbits != ISA_OFFBITS)
    {
      /* The offset field is too narrow to be used for a low-part
         relocation, so load the whole address into the auxillary
         register.  */
      nanomips_macro_la (&tempreg, 0, used_at);
      if (breg != 0)
	macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", tempreg, tempreg, breg);
      macro_build (NULL, s, fmt, op[0], 0, tempreg);
    }
  else if (nanomips_opts.pic == NO_PIC)
    {
      if (HAVE_64BIT_SYMBOLS)
	/* Unsupported */
	gas_assert (FALSE);

      if ((valueT) offset_expr.X_add_number <= MAX_GPREL_OFFSET
	  && !nopic_need_relax (offset_expr.X_add_symbol, 1)
	  && (nanomips_opts.mc_model == MC_MEDIUM
	      || nanomips_opts.mc_model == MC_AUTO))
	{
	  relax_start (offset_expr.X_add_symbol);
	  if (gpfmt == NULL)
	    gpfmt = fmt;
	  macro_build (&offset_expr, s, gpfmt, op[0],
		       BFD_RELOC_GPREL16, nanomips_gp_register);
	  relax_switch ();
	}

      if (nanomips_opts.pcrel)
	nanomips_macro_pcrel_ld_st (s, fmt, op, tempreg, coproc);
      else
	nanomips_macro_absolute_ld_st (s, fmt, op, tempreg, breg);

      if (nanomips_relax.sequence)
	relax_end ();
    }
  else
    {
      gas_assert (offset_expr.X_op == O_symbol);

      if (HAVE_64BIT_SYMBOLS)
	gpfmt = "t,mV(ma)";
      else
	gpfmt = "t,.(ma)";
      relax_start (offset_expr.X_add_symbol);

      if (nanomips_opts.pic == SVR4_PIC || linkrelax)
	macro_build (&offset_expr, ADDRESS_LOAD_INSN, gpfmt, tempreg,
		     BFD_RELOC_NANOMIPS_GOT_DISP, nanomips_gp_register);
      else if ((nanomips_opts.ase & ASE_xNMS) != 0 && !nanomips_opts.insn32)
	macro_build (&offset_expr, "lwpc", "mp,+S", tempreg,
		     BFD_RELOC_NANOMIPS_GOTPC_I32);
      else
	{
	  macro_build (&offset_expr, "aluipc", "t,mK", tempreg,
		       BFD_RELOC_NANOMIPS_GOTPC_HI20);
	  macro_build (&offset_expr, ADDRESS_LOAD_INSN, "t,o(b)", tempreg,
		       BFD_RELOC_NANOMIPS_GOT_LO12, tempreg);
	}
      macro_build (NULL, s, fmt, op[0], 0, tempreg);

      relax_switch ();
      nanomips_macro_pcrel_ld_st (s, fmt, op, tempreg, coproc);
      relax_end ();
    }
}

static void
nanomips_macro_ldp_stp (const char *s, const char *fmt, unsigned int op[],
			int align, unsigned int breg,
			unsigned int tempreg, int *used_at)
{
  if (tempreg == AT)
    *used_at = 1;

  if (small_add_offset_p (0) && offset_expr.X_add_number != 0)
    {
      if (breg == 0)
	load_register (tempreg, &offset_expr, HAVE_64BIT_ADDRESSES);
      else if (small_poffset_p (0, 1, ISA_ADD_OFFBITS))
	macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIU_FMT,
		     tempreg, breg, -1, offset_reloc[0],
		     offset_reloc[1], offset_reloc[2]);
      else if (small_noffset_p (0, ISA_OFFBITS))
	macro_build (&offset_expr, ADDRESS_ADDI_INSN, "t,r,h",
		     tempreg, breg, -1, offset_reloc[0],
		     offset_reloc[1], offset_reloc[2]);
      macro_build (NULL, s, fmt, op[0], op[1], tempreg);

      return;
    }

  if ((offset_expr.X_op != O_constant && offset_expr.X_op != O_symbol)
      || (offset_expr.X_op == O_symbol && hi_reloc_p (offset_reloc[0])))
    {
      as_bad (_("expression too complex"));
      offset_expr.X_op = O_constant;
    }

  if (offset_expr.X_op == O_constant && hi_reloc_p (offset_reloc[0]))
    offset_expr.X_add_number = offset_high_part (offset_expr.X_add_number,
						 ISA_OFFBITS);

  if (HAVE_32BIT_ADDRESSES && !IS_SEXT_32BIT_NUM (offset_expr.X_add_number))
    {
      char value[32];

      sprintf_vma (value, offset_expr.X_add_number);
      as_bad (_("number (0x%s) larger than 32 bits"), value);
    }

  /* A constant expression in PIC code can be handled just as it
     is in non PIC code.  */
  if (offset_expr.X_op == O_constant)
    {
      if ((offset_expr.X_add_number & (align - 1)) != 0 && breg == 0)
	{
	  char value[32];

	  sprintf_vma (value, offset_expr.X_add_number);
	  as_bad (_("number (0x%s) not aligned to %d bytes"), value, align);
	}

      if (offset_expr.X_add_number == 0)
	{
	  *used_at = 0;
	  tempreg = breg;
	}
      else
	{
	  load_register (tempreg, &offset_expr, HAVE_64BIT_ADDRESSES);
	  if (breg != 0)
	    macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", tempreg,
			 tempreg, breg);
	}

      macro_build (NULL, s, fmt, op[0], op[1], tempreg);
    }
  else if (nanomips_opts.pic == NO_PIC)
    {
      /* The offset field is too narrow to be used for a low-part
         relocation, so load the whole address into the auxillary
         register.  */
      nanomips_macro_la (&tempreg, 0, used_at);
      if (breg != 0)
	macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", tempreg, tempreg, breg);
      macro_build (NULL, s, fmt, op[0], op[1], tempreg);
    }
  else
    {
      const char *gpfmt;
      gas_assert (offset_expr.X_op == O_symbol);

      if (HAVE_64BIT_SYMBOLS)
	gpfmt = "t,mV(ma)";
      else
	gpfmt = "t,.(ma)";

      if (nanomips_opts.pic == SVR4_PIC || linkrelax)
	macro_build (&offset_expr, ADDRESS_LOAD_INSN, gpfmt, tempreg,
		     BFD_RELOC_NANOMIPS_GOT_DISP, nanomips_gp_register);
      else if ((nanomips_opts.ase & ASE_xNMS) != 0 && !nanomips_opts.insn32)
	macro_build (&offset_expr, "lwpc", "mp,+S", tempreg,
		     BFD_RELOC_NANOMIPS_GOTPC_I32);
      else
	{
	  macro_build (&offset_expr, "aluipc", "t,mK", tempreg,
		       BFD_RELOC_NANOMIPS_GOTPC_HI20);
	  macro_build (&offset_expr, ADDRESS_LOAD_INSN, "t,o(b)", tempreg,
		       BFD_RELOC_NANOMIPS_GOT_LO12, tempreg);
	}
      macro_build (NULL, s, fmt, op[0], op[1], tempreg);
    }
}

static void
nanomips_macro_absolute_ldd_std (const char *s, const char *fmt, unsigned int
				 op[], unsigned int breg, unsigned int coproc)
{
  if (offset_high_part (offset_expr.X_add_number, ISA_OFFBITS)
      != offset_high_part (offset_expr.X_add_number + 4, ISA_OFFBITS))
    {
      if ((nanomips_opts.ase & ASE_xNMS) != 0 && !nanomips_opts.insn32)
	macro_build (&offset_expr, "li", "mp,+Q", AT, BFD_RELOC_NANOMIPS_I32);
      else
	{
	  macro_build_lui (&offset_expr, AT);
	  macro_build (&offset_expr, "ori", BITOP_IMM_FMT, AT, AT,
		       BFD_RELOC_NANOMIPS_LO12);
	}

      offset_expr.X_op = O_constant;
      offset_expr.X_add_number = 0;
    }
  else
    macro_build_lui (&offset_expr, AT);
  if (breg != 0)
    macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", AT, breg, AT);
  macro_build (&offset_expr, s, fmt, coproc ? op[0] + 1 : op[0],
	       BFD_RELOC_NANOMIPS_LO12, AT);
  offset_expr.X_add_number += 4;
  macro_build (&offset_expr, s, fmt, coproc ? op[0] : op[0] + 1,
	       BFD_RELOC_NANOMIPS_LO12, AT);
}

static void
nanomips_macro_pcrel_ldd_std (const char *s, const char *fmt,
			      unsigned int op[], unsigned int coproc)
{
  if ((nanomips_opts.ase & ASE_xNMS) != 0
      && *offset_reloc == BFD_RELOC_UNUSED
      && !nanomips_opts.insn32)
    {
      macro_build (&offset_expr, "lwpc", "mp,+S", coproc ? op[0] + 1 : op[0],
		   BFD_RELOC_NANOMIPS_PC_I32);
      offset_expr.X_add_number += 4;
      macro_build (&offset_expr, "lwpc", "mp,+S", coproc ? op[0] : op[0] + 1,
		   BFD_RELOC_NANOMIPS_PC_I32);
    }
  else
    {
      macro_build (&offset_expr, "aluipc", "t,mK", AT,
		   BFD_RELOC_NANOMIPS_PCREL_HI20);
      macro_build (&offset_expr, s, fmt,
		   coproc ? op[0] + 1 : op[0], BFD_RELOC_NANOMIPS_LO12, AT);
      offset_expr.X_add_number += 4;
      macro_build (&offset_expr, s, fmt,
		   coproc ? op[0] : op[0] + 1, BFD_RELOC_NANOMIPS_LO12, AT);
    }
}

static void
nanomips_macro_ldd_std (const char *s, const char *fmt, unsigned int op[],
			int align, int offbits, unsigned int breg,
			int *used_at, int coproc)
{
  expressionS expr1;
  expressionS *ep;

  expr1.X_op = O_constant;
  expr1.X_op_symbol = NULL;
  expr1.X_add_symbol = NULL;
  expr1.X_add_number = 1;

  /* Even on a big endian machine $fn comes before $fn+1.  We have
     to adjust when loading from memory.  We set coproc if we must
     load $fn+1 first.  */
  /* Itbl support may require additional care here.  */
  if (!target_big_endian)
    coproc = 0;

  if (small_add_offset_p (0))
    {
      ep = &offset_expr;
      if ((offbits != ISA_OFFBITS || !small_poffset_p (4, align, offbits))
	  && !small_offset_p (4, align, offbits))
	{
	  if (small_poffset_p (0, align, ISA_ADD_OFFBITS))
	    macro_build (&offset_expr, ADDRESS_ADDI_INSN, ADDIU_FMT, AT,
			 breg, -1, offset_reloc[0], offset_reloc[1],
			 offset_reloc[2]);
	  else if (small_noffset_p (0, ISA_OFFBITS))
	    macro_build (&offset_expr, ADDRESS_ADDI_INSN, "t,r,h", AT,
			 breg, -1, offset_reloc[0], offset_reloc[1],
			 offset_reloc[2]);

	  expr1.X_add_number = 0;
	  ep = &expr1;
	  breg = AT;
	  *used_at = 1;
	  offset_reloc[0] = BFD_RELOC_NANOMIPS_LO12;
	  offset_reloc[1] = BFD_RELOC_UNUSED;
	  offset_reloc[2] = BFD_RELOC_UNUSED;
	}

      if (strcmp (s, "lw") == 0 && op[0] == breg)
	{
	  ep->X_add_number += 4;
	  macro_build (ep, s, fmt, op[0] + 1, -1, offset_reloc[0],
		       offset_reloc[1], offset_reloc[2], breg);
	  ep->X_add_number -= 4;
	  macro_build (ep, s, fmt, op[0], -1, offset_reloc[0],
		       offset_reloc[1], offset_reloc[2], breg);
	}
      else
	{
	  macro_build (ep, s, fmt, coproc ? op[0] + 1 : op[0], -1,
		       offset_reloc[0], offset_reloc[1], offset_reloc[2],
		       breg);
	  ep->X_add_number += 4;
	  macro_build (ep, s, fmt, coproc ? op[0] : op[0] + 1, -1,
		       offset_reloc[0], offset_reloc[1], offset_reloc[2],
		       breg);
	}
      return;
    }

  if ((offset_expr.X_op != O_symbol && offset_expr.X_op != O_constant)
      || (offset_expr.X_op == O_symbol && hi_reloc_p (offset_reloc[0])))
    {
      as_bad (_("expression too complex"));
      offset_expr.X_op = O_constant;
    }

  if (offset_expr.X_op == O_constant && hi_reloc_p (offset_reloc[0]))
    offset_expr.X_add_number = offset_high_part (offset_expr.X_add_number,
						 ISA_OFFBITS);

  if (!check_offset_range (offset_expr.X_add_number))
    return;

  if (nanomips_opts.pic == NO_PIC || offset_expr.X_op == O_constant)
    {
      /* If this is a reference to a GP relative symbol, we want
	 <op>	op[0],<sym>($gp)	(BFD_RELOC_GPREL16)
	 <op>	op[0]+1,<sym>+4($gp)	(BFD_RELOC_GPREL16)
	 If we have a base register, we use this
	 addu	$at,$breg,$gp
	 <op>	op[0],<sym>($at)	(BFD_RELOC_GPREL16)
	 <op>	op[0]+1,<sym>+4($at)	(BFD_RELOC_GPREL16)
	 If this is not a GP relative symbol, we want
	 lui	$at,<sym>		(BFD_RELOC_HI16_S)
	 <op>	op[0],<sym>($at)	(BFD_RELOC_LO16)
	 <op>	op[0]+1,<sym>+4($at)	(BFD_RELOC_LO16)
	 If there is a base register, we add it to $at after the
	 lui instruction.  If there is a constant, we always use
	 the last case.  */
      if (offset_expr.X_op == O_symbol
	  && (valueT) offset_expr.X_add_number <= MAX_GPREL_OFFSET
	  && (breg == 0
	      && (gprel16_reloc_p (*offset_reloc)
		  || *offset_reloc == BFD_RELOC_UNUSED))
	  && !nopic_need_relax (offset_expr.X_add_symbol, 1))
	{
	  const char *sfmt = fmt;
	  unsigned int tempreg;
	  relax_start (offset_expr.X_add_symbol);
	  if (breg == 0)
	    {
	      tempreg = nanomips_gp_register;
	      sfmt = "t,.(ma)";
	    }
	  else
	    {
	      macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t",
			   AT, breg, nanomips_gp_register);
	      tempreg = AT;
	      *used_at = 1;
	    }

	  macro_build (&offset_expr, s, sfmt, coproc ? op[0] + 1 : op[0],
		       BFD_RELOC_GPREL16, tempreg);
	  offset_expr.X_add_number += 4;

	  macro_build (&offset_expr, s, sfmt, coproc ? op[0] : op[0] + 1,
		       BFD_RELOC_GPREL16, tempreg);
	  relax_switch ();

	  offset_expr.X_add_number -= 4;
	}

      *used_at = 1;
      if (nanomips_opts.pcrel)
	nanomips_macro_pcrel_ldd_std (s, fmt, op, coproc);
      else
	nanomips_macro_absolute_ldd_std (s, fmt, op, breg, coproc);


      if (nanomips_relax.sequence)
	relax_end ();
    }
  else
    {
      *used_at = 1;
      expr1.X_add_number = 0;
      if (offset_expr.X_add_number < MIN_PIC_OFFSET
	  || offset_expr.X_add_number >= MAX_PIC_OFFSET - 4)
	as_bad (_("PIC code offset overflow (max 21 bits)"));

      relax_start (offset_expr.X_add_symbol);
      macro_build (&offset_expr, ADDRESS_LOAD_INSN, "t,.(ma)", AT,
		   BFD_RELOC_NANOMIPS_GOT_DISP, nanomips_gp_register);
      if (breg != 0)
	macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", AT, breg, AT);
      macro_build (&expr1, s, fmt, coproc ? op[0] + 1 : op[0],
		   BFD_RELOC_NANOMIPS_LO12, AT);
      expr1.X_add_number += 4;
      macro_build (&expr1, s, fmt, coproc ? op[0] : op[0] + 1,
		   BFD_RELOC_NANOMIPS_LO12, AT);

      relax_switch ();
      macro_build (&offset_expr, ADDRESS_LOAD_INSN, "t,.(ma)", AT,
		   BFD_RELOC_NANOMIPS_GOT_PAGE, nanomips_gp_register);
      if (breg != 0)
	macro_build (NULL, ADDRESS_ADD_INSN, "d,v,t", AT, breg, AT);

      macro_build (&offset_expr, s, fmt, coproc ? op[0] + 1 : op[0],
		   BFD_RELOC_NANOMIPS_GOT_OFST, AT);
      offset_expr.X_add_number += 4;
      macro_build (&offset_expr, s, fmt, coproc ? op[0] : op[0] + 1,
		   BFD_RELOC_NANOMIPS_GOT_OFST, AT);
      relax_end ();
    }
}

/*
 *			Build macros
 *   This routine implements the seemingly endless macro or synthesized
 * instructions and addressing modes in the mips assembly language. Many
 * of these macros are simple and are similar to each other. These could
 * probably be handled by some kind of table or grammar approach instead of
 * this verbose method. Others are not simple macros but are more like
 * optimizing code generation.
 *   One interesting optimization is when several store macros appear
 * consecutively that would load AT with the upper half of the same address.
 * The ensuing load upper instructions are ommited. This implies some kind
 * of global optimization. We currently only optimize within a single macro.
 *   For many of the load and store macros if the address is specified as a
 * constant expression in the first 64k of memory (ie ld $2,0x4000c) we
 * first load register 'at' with zero and use it as the base register. The
 * mips assembler simply uses register $zero. Just one tiny optimization
 * we're missing.
 */

static void
nanomips_macro (struct nanomips_cl_insn *ip, char *str ATTRIBUTE_UNUSED)
{
  const struct nanomips_operand_array *operands;

  unsigned int breg, i;
  unsigned int tempreg;
  int mask;
  int used_at = 0;
  expressionS label_expr;
  expressionS expr1;
  const char *s = ip->insn_mo->name;
  const char *s2 = NULL;
  const char *fmt;
  const char *gpfmt = NULL;
  int coproc = 0;
  int offbits = ISA_OFFBITS;
  bfd_boolean dbl = FALSE;
  int lp = 0;
  unsigned int align;
  unsigned int op[MAX_OPERANDS];

  operands = insn_operands (ip);
  for (i = 0; i < MAX_OPERANDS; i++)
    if (operands->operand[i])
      op[i] = insn_extract_operand (ip, operands->operand[i]);
    else
      op[i] = -1;

  mask = ip->insn_mo->mask;

  label_expr.X_op = O_constant;
  label_expr.X_op_symbol = NULL;
  label_expr.X_add_symbol = NULL;
  label_expr.X_add_number = 0;

  expr1.X_op = O_constant;
  expr1.X_op_symbol = NULL;
  expr1.X_add_symbol = NULL;
  expr1.X_add_number = 1;
  align = 1;

  switch (mask)
    {
    case M_DABS:
      dbl = TRUE;
      /* Fall through.  */
    case M_ABS:
      /*    bgez    $a0,1f
	    move    v0,$a0
	    sub     v0,$zero,$a0
	 1:
       */

      nanomips_label_expr (&label_expr);
      if (op[0] != op[1])
	move_register (op[0], op[1]);
      macro_build (&label_expr, "bgezc", BCONDZ1_FMT, op[1]);
      macro_build (NULL, dbl ? "dsubu" : "subu", "d,v,t", op[0], 0, op[1]);
      nanomips_add_label ();
      break;

    case M_ADD_I:
      s = "addiu";
      s2 = "add";
      if (imm_expr.X_add_number == 0)
	goto do_addi;
      else
	goto do_addi_i;
    case M_ADDU_I:
      s = "addiu";
      s2 = "addu";
      goto do_addi;
    case M_DADD_I:
      dbl = TRUE;
      s = "daddi";
      s2 = "dadd";
      goto do_addi_i;
    case M_DADDU_I:
      dbl = TRUE;
      s = "daddiu";
      s2 = "daddu";
    do_addi:
      if (offset_high_unsigned (imm_expr.X_add_number, 16) == 0)
	{
	  macro_build (&imm_expr, s, ADDIU_FMT, op[0], op[1],
		       BFD_RELOC_NANOMIPS_IMM16);
	  break;
	}
      else if (offset_high_unsigned (-imm_expr.X_add_number, 12) == 0)
	{
	  macro_build (&imm_expr, s, "t,r,h", op[0], op[1],
		       BFD_RELOC_NANOMIPS_NEG12);
	  break;
	}
      else if ((nanomips_opts.ase & ASE_xNMS) != 0
	       && op[0] == op[1] && !nanomips_opts.insn32)
	{
	  macro_build (&imm_expr, s, "mp,mt,+R", op[0], op[0],
		       BFD_RELOC_NANOMIPS_I32);
	  break;
	}
    do_addi_i:
      used_at = 1;
      load_register (AT, &imm_expr, dbl);
      macro_build (NULL, s2, "d,v,t", op[0], op[1], AT);
      break;

    case M_AND_I:
      s = "andi";
      s2 = "and";
      goto do_bit;
    case M_OR_I:
      s = "ori";
      s2 = "or";
      goto do_bit;
    case M_NOR_I:
      s = "";
      s2 = "nor";
      goto do_load_op;
    case M_XOR_I:
      s = "xori";
      s2 = "xor";
    do_bit:
      if (offset_high_unsigned (imm_expr.X_add_number, 12) == 0)
	{
	  if (mask != M_NOR_I)
	    macro_build (&imm_expr, s, BITOP_IMM_FMT, op[0], op[1], BFD_RELOC_LO16);
	  else
	    {
	      macro_build (&imm_expr, "ori", BITOP_IMM_FMT,
			   op[0], op[1], BFD_RELOC_LO16);
	      macro_build (NULL, "nor", "d,v,t", op[0], op[0], 0);
	    }
	  break;
	}
    do_load_op:
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, s2, "d,v,t", op[0], op[1], AT);
      break;

    case M_BEQ_I:
    case M_BNE_I:
      if (imm_expr.X_add_number == 0)
	op[1] = 0;
      else if (offset_high_unsigned (imm_expr.X_add_number, 7) == 0)
	{
	  macro_build_branch_rtim (mask, &offset_expr, op[0], &imm_expr);
	  break;
	}
      else
	{
	  op[1] = AT;
	  used_at = 1;
	  load_register (op[1], &imm_expr, GPR_SIZE == 64);
	}
      macro_build_branch_rsrt (mask, &offset_expr, op[0], op[1]);
      break;

    case M_BGE:
      if (op[1] == 0)
	macro_build_branch_rs (M_BGEZ, &offset_expr, op[0]);
      else if (op[0] == 0)
	macro_build_branch_rs (M_BLEZ, &offset_expr, op[1]);
      else
	{
	  used_at = 1;
	  macro_build (NULL, "slt", "d,v,t", AT, op[0], op[1]);
	  macro_build_branch_rsrt (M_BEQ, &offset_expr, AT, ZERO);
	}
      break;

    case M_BGT:
      if (op[1] == 0)
	macro_build_branch_rs (M_BGTZ, &offset_expr, op[0]);
      else if (op[0] == 0)
	macro_build_branch_rs (M_BLTZ, &offset_expr, op[1]);
      else
	{
	  used_at = 1;
	  macro_build (NULL, "slt", "d,v,t", AT, op[1], op[0]);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLE:
      if (op[1] == 0)
	macro_build_branch_rs (M_BLEZ, &offset_expr, op[0]);
      else if (op[0] == 0)
	macro_build_branch_rs (M_BGEZ, &offset_expr, op[1]);
      else
	{
	  used_at = 1;
	  macro_build (NULL, "slt", "d,v,t", AT, op[1], op[0]);
	  macro_build_branch_rsrt (M_BEQ, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLT:
      if (op[1] == 0)
	macro_build_branch_rs (M_BLTZ, &offset_expr, op[0]);
      else if (op[0] == 0)
	macro_build_branch_rs (M_BGTZ, &offset_expr, op[1]);
      else
	{
	  used_at = 1;
	  macro_build (NULL, "slt", "d,v,t", AT, op[0], op[1]);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_BGEZAL:
      s = "bltzc";
      goto brcond_al;
    case M_BLTZAL:
      s = "bgezc";
    brcond_al:
      nanomips_label_expr (&label_expr);
      macro_build (&label_expr, s, BCONDZ1_FMT, op[0]);
      macro_build (&offset_expr, "bal", B_FMT);
      nanomips_add_label ();
      break;

    case M_BGT_I:
      /* Check for > max integer.  */
      if (imm_expr.X_add_number >= GPR_SMAX)
	{
	do_false:
	  /* Result is always false.  */
	  macro_build (NULL, "nop", "");
	  break;
	}
      ++imm_expr.X_add_number;
      /* FALLTHROUGH */
    case M_BGE_I:
      if (imm_expr.X_add_number == 0)
	macro_build_branch_rs (M_BGEZ, &offset_expr, op[0]);
      else if (imm_expr.X_add_number == 1)
	macro_build_branch_rs (M_BGTZ, &offset_expr, op[0]);
      else if (imm_expr.X_add_number <= GPR_SMIN)
	{
	do_true:
	  /* result is always true */
	  as_warn (_("branch %s is always true"), ip->insn_mo->name);
	  macro_build (&offset_expr, "b", B_FMT);
	  break;
	}
      else if (offset_high_unsigned (imm_expr.X_add_number, 7) == 0)
	macro_build_branch_rtim (M_BGE_I, &offset_expr, op[0], &imm_expr);
      else
	{
	  used_at = 1;
	  set_at (op[0], 0);
	  macro_build_branch_rsrt (M_BEQ, &offset_expr, AT, ZERO);
	}
      break;

    case M_BGTU_I:
      if (op[0] == 0 || (GPR_SIZE == 32 && imm_expr.X_add_number == -1))
	goto do_false;
      ++imm_expr.X_add_number;
      /* FALLTHROUGH */
    case M_BGEU_I:
      if (imm_expr.X_add_number == 0)
	goto do_true;
      else if (imm_expr.X_add_number == 1)
	macro_build_branch_rsrt (M_BNE, &offset_expr, op[0], ZERO);
      else if (offset_high_unsigned (imm_expr.X_add_number, 7) == 0)
	macro_build_branch_rtim (mask, &offset_expr, op[0], &imm_expr);
      else
	{
	  used_at = 1;
	  set_at (op[0], 1);
	  macro_build_branch_rsrt (M_BEQ, &offset_expr, AT, ZERO);
	}
      break;

    case M_BGTU:
      if (op[1] == 0)
	macro_build_branch_rsrt (M_BNE, &offset_expr, op[0], ZERO);
      else if (op[0] == 0)
	goto do_false;
      else
	{
	  used_at = 1;
	  macro_build (NULL, "sltu", "d,v,t", AT, op[1], op[0]);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLE_I:
      if (imm_expr.X_add_number >= GPR_SMAX)
	goto do_true;
      ++imm_expr.X_add_number;
      /* FALLTHROUGH */
    case M_BLT_I:
      if (imm_expr.X_add_number == 0)
	macro_build_branch_rs (M_BLTZ, &offset_expr, op[0]);
      else if (imm_expr.X_add_number == 1)
	macro_build_branch_rs (M_BLEZ, &offset_expr, op[0]);
      else if (offset_high_unsigned (imm_expr.X_add_number, 7) == 0)
	macro_build_branch_rtim (mask, &offset_expr, op[0], &imm_expr);
      else
	{
	  used_at = 1;
	  set_at (op[0], 0);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLEU:
      if (op[1] == 0)
	macro_build_branch_rsrt (M_BEQ, &offset_expr, op[0], ZERO);
      else if (op[0] == 0)
	goto do_true;
      else
	{
	  used_at = 1;
	  macro_build (NULL, "sltu", "d,v,t", AT, op[1], op[0]);
	  macro_build_branch_rsrt (M_BEQ, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLEU_I:
      if (op[0] == 0 || (GPR_SIZE == 32 && imm_expr.X_add_number == -1))
	goto do_true;
      ++imm_expr.X_add_number;
      /* FALLTHROUGH */
    case M_BLTU_I:
      if (imm_expr.X_add_number == 0)
	goto do_false;
      else if (imm_expr.X_add_number == 1)
	macro_build_branch_rsrt (M_BEQ, &offset_expr, op[0], ZERO);
      else if (offset_high_unsigned (imm_expr.X_add_number, 7) == 0)
	macro_build_branch_rtim (mask, &offset_expr, op[0], &imm_expr);
      else
	{
	  used_at = 1;
	  set_at (op[0], 1);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_BLTU:
      if (op[1] == 0)
	goto do_false;
      else if (op[0] == 0)
	macro_build_branch_rsrt (M_BNE, &offset_expr, ZERO, op[1]);
      else
	{
	  used_at = 1;
	  macro_build (NULL, "sltu", "d,v,t", AT, op[0], op[1]);
	  macro_build_branch_rsrt (M_BNE, &offset_expr, AT, ZERO);
	}
      break;

    case M_EXT:
      if (31 - op[2] - op[3] > 0)
	{
	  macro_build (NULL, "sll", SHFT_FMT, op[0], op[1],
		       31 - op[2] - op[3]);
	  macro_build (NULL, "srl", SHFT_FMT, op[0], op[0], 31 - op[3]);
	}
      else
	macro_build (NULL, "srl", SHFT_FMT, op[0], op[1], op[2]);
      break;

    case M_INS:
      if (op[0] == op[1] && op[2] == 0)
	{
	  macro_build (NULL, "nop", "");
	  break;
	}
      else if (op[0] == op[1])
	{
	  used_at = 1;
	  macro_build (NULL, "extw", "d,s,t,+I", AT, op[0], op[0], op[2]);
	  macro_build (NULL, "extw", "d,s,t,+I", op[0], AT, op[0],
		       1 + op[3] - op[2]);
	}
      else if (op[2] == 0 && op[3] == 31)
	{
	  move_register (op[0], op[1]);
	  break;
	}
      else
	{
	  if (op[2] != 0)
	    macro_build (NULL, "extw", "d,s,t,+I", op[0], op[0],
			 op[0], op[2]);
	  macro_build (NULL, "extw", "d,s,t,+I", op[0], op[0], op[1],
		       1 + op[3] - op[2]);
	}
      if (op[3] < 31)
	macro_build (NULL, "extw", "d,s,t,+I", op[0], op[0], op[0],
		     31 - op[3]);
      break;

    case M_DDIV_I:
    case M_DDIVU_I:
      dbl = TRUE;
      /* fall-through */

    case M_DIV_I:
    case M_DIVU_I:
      goto do_divi;

    case M_REM_3I:
    case M_MOD_I:
      s = "mod";
    do_divi:
      if (imm_expr.X_add_number == 0)
	{
	  as_warn (_("divide by zero"));
	  if (nanomips_trap)
	    macro_build (NULL, "teq", TRAP_FMT, ZERO, ZERO, 7);
	  else
	    macro_build (NULL, "break", BRK_FMT, 7);
	  break;
	}
      if (imm_expr.X_add_number == 1)
	{
	  if (strncmp (s, "div", 3) == 0)
	    move_register (op[0], op[1]);
	  else
	    move_register (op[0], ZERO);
	  break;
	}
      if (imm_expr.X_add_number == -1 && s[strlen (s) - 1] != 'u')
	{
	  if (strncmp (s, "div", 3) == 0)
	    macro_build (NULL, dbl ? "dneg" : "neg", "d,w", op[0], op[1]);
	  else
	    move_register (op[0], ZERO);
	  break;
	}

      used_at = 1;
      load_register (AT, &imm_expr, dbl);
      macro_build (NULL, s, DIV_FMT, op[0], op[1], AT);
      break;

    case M_DMOD_I:
      dbl = TRUE;
      s = "dmod";
      goto do_divi;

    case M_DMODU_I:
      dbl = TRUE;
      s = "dmodu";
      goto do_divi;

    case M_MODU_I:
      s = "modu";
      goto do_divi;

    case M_DLA_AB:
      dbl = TRUE;
      /* Fall through.  */
    case M_LA_AB:
      /* Load the address of a symbol into a register.  If breg is not
         zero, we then add a base register to it.  */
      breg = op[2];
      if (dbl && GPR_SIZE == 32)
	as_warn (_("dla used to load 32-bit register; recommend using la "
		   "instead"));

      if (!dbl && HAVE_64BIT_OBJECTS)
	as_warn (_("la used to load 64-bit address; recommend using dla "
		   "instead"));

      nanomips_macro_la (op, breg, &used_at);
      break;

    case M_J_A:
      /* The j instruction may not be used in PIC code, since it
         requires an absolute address.  We convert it to a b
         instruction.  */
      /* Likewise for nanoMIPS which has no absolute jump instruction.  */
      macro_build (&offset_expr, "bc", B_FMT);
      break;

      /* The jal instructions must be handled as macros because when
         generating PIC code they expand to multi-instruction
         sequences.  Normally they are simple instructions.  */
    case M_JAL_A:
      if (nanomips_opts.pic == NO_PIC)
	macro_build (&offset_expr, "jal", B_FMT);
      else
	{
	  macro_build (&offset_expr, ADDRESS_LOAD_INSN, LWGP_FMT,
		       AT, BFD_RELOC_NANOMIPS_GOT_CALL, nanomips_gp_register);

	  if (nanomips_opts.linkrelax)
	    {
	      if (nanomips_opts.insn32)
		macro_build (&offset_expr, "jalrc", "s,-i", AT,
			     BFD_RELOC_NANOMIPS_JALR32);
	      else
		macro_build (&offset_expr, "jalrc", "mp,-i", AT,
			     BFD_RELOC_NANOMIPS_JALR16);
	    }
	  else
	    macro_build (NULL, "jalrc", (nanomips_opts.insn32 ? "s" : "mp"),
			 AT);
	}

      break;

    case M_LB_AC:
    case M_LBU_AC:
    case M_LH_AC:
    case M_LHU_AC:
    case M_LW_AC:
    case M_LWU_AC:
      fmt = ISA_UNSIGNED_LDST_FMT;
      switch (s[1])
	{
	case 'b':
	  gpfmt = "t,+1(ma)";
	  break;
	case 'd':
	  gpfmt = "t,mV(ma)";
	  break;
	case 'h':
	  gpfmt = "t,+3(ma)";
	  break;
	default:
	  if (s[2] == 'u')
	    gpfmt = "t,+2(ma)";
	  else
	    gpfmt = "t,.(ma)";
	  break;
	}
      goto ld;

    case M_LL_AC:
      fmt = LL_SC_FMT;
      align = 4;
      offbits = ISA_SIGNED_OFFBITS;
      goto ld;

    case M_LLDP_AC:
      dbl = TRUE;
      /* fall through */
    case M_LLWP_AC:
      fmt = LLP_SCP_FMT;
      align = (dbl ? 16 : 8);
      breg = op[3];
      /* We don't want to use $0 as tempreg.  */
      if (op[0] != ZERO && op[0] != breg)
	tempreg = op[0];
      else if (op[1] != ZERO && op[1] != breg)
	tempreg = op[1];
      else
	ldp_stp:
	  tempreg = AT;

      nanomips_macro_ldp_stp (s, fmt, op, align, breg,
			      tempreg, &used_at);
      break;

    case M_LLD_AC:
      fmt = LLD_SCD_FMT;
      offbits = ISA_SIGNED_OFFBITS;
      align = 8;

    ld:
      /* We don't want to use $0 as tempreg.  */
      if (op[2] == op[0] + lp || op[0] + lp == ZERO)
	goto ld_st;
      else
	tempreg = op[0] + lp;
      goto ld_noat;

    case M_LBUE_AC:
    case M_LHUE_AC:
    case M_LBE_AC:
    case M_LHE_AC:
    case M_SHE_AC:
    case M_SWE_AC:
    case M_LWE_AC:
    case M_SBE_AC:
      fmt = ISA_SIGNED_LDST_FMT;
      goto ld_st_signed_off;

    case M_ACLR_AC:
    case M_ASET_AC:
      fmt = ACLR_FMT;
      goto ld_st_signed_off;

    case M_SB_AC:
    case M_SH_AC:
      fmt = ISA_UNSIGNED_LDST_FMT;
      gpfmt = "t,+1(ma)";
      goto ld_st;

    case M_SW_AC:
      fmt = ISA_UNSIGNED_LDST_FMT;
      gpfmt = "t,.(ma)";
      goto ld_st;

    case M_LWC2_AC:
    case M_LDC2_AC:
    case M_SWC2_AC:
    case M_SDC2_AC:
      fmt = COP12_FMT;
      /* Itbl support may require additional care here.  */
      coproc = 1;
      goto ld_st_signed_off;

    case M_LLE_AC:
    case M_SCE_AC:
    case M_SC_AC:
      fmt = LL_SC_FMT;
      align = 4;
      goto ld_st_signed_off;

    case M_SCD_AC:
      fmt = LLD_SCD_FMT;
      align = 8;
      goto ld_st_signed_off;

    case M_SCDP_AC:
      dbl = TRUE;

    case M_SCWP_AC:
      fmt = LLP_SCP_FMT;
      align = (dbl ? 16 : 8);
      offbits = 0;
      breg = op[3];
      goto ldp_stp;

    case M_CACHE_AC:
    case M_PREF_AC:
    case M_CACHEE_AC:
    case M_PREFE_AC:
      fmt = PREF_FMT;
      goto ld_st_signed_off;

    case M_LWC1_AC:
    case M_LDC1_AC:
    case M_SDC1_AC:
    case M_SWC1_AC:
      gpfmt = "T,+2(ma)";
      /* Itbl support may require additional care here.  */
      coproc = 1;
      if (small_noffset_p (0, ISA_SIGNED_OFFBITS - 1))
	{
	  fmt = ISA_SIGNED_COP1_FMT;
	  goto ld_st_signed_off;
	}
      else
	{
	  fmt = ISA_UNSIGNED_COP1_FMT;
	  goto ld_st;
	}
    case M_SWM_AC:
    case M_SDM_AC:
    case M_LWM_AC:
    case M_LDM_AC:
      fmt = ISA_SIGNED_LDST_FMT ",|";

    ld_st_signed_off:
      offbits = ISA_SIGNED_OFFBITS;
    ld_st:
      tempreg = AT;
    ld_noat:
      breg = op[2];
      nanomips_macro_ld_st (s, fmt, op, gpfmt, align, offbits, breg,
			    tempreg, &used_at, coproc);
      break;

    case M_LDX_AB:
      if (GPR_SIZE == 32)
	{
	  s = "lwx";
	  goto ldd_std_indexed;
	}
      s = "ldx";
      goto ld_indexed_gp;

    case M_LWX_AB:
      s = "lwx";
      goto ld_indexed_gp;

    case M_LWUX_AB:
      s = "lwux";
      goto ld_indexed_gp;

    case M_LHX_AB:
      s = "lhx";
      goto ld_indexed_gp;

    case M_LHUX_AB:
      s = "lhux";
      goto ld_indexed_gp;

    case M_LBX_AB:
      s = "lbx";
      goto ld_indexed_gp;

    case M_LBUX_AB:
      s = "lbux";
      /* Fall through  */

    ld_indexed_gp:
      fmt = "d,s(t)";
      if (op[0] == 0 || op[0] == op[2])
	goto st_indexed;
      tempreg = op[0];
      goto ld_st_indexed;

    case M_LWC1X_AB:
      s = "lwc1x";
      fmt = "R,s(t)";
      goto st_indexed;

    case M_LDC1X_AB:
      s = "ldc1x";
      fmt = "R,s(t)";
      goto st_indexed;

    case M_SWC1X_AB:
      s = "swc1x";
      fmt = "R,s(t)";
      goto st_indexed;

    case M_SDC1X_AB:
      s = "sdc1x";
      fmt = "R,s(t)";
      goto st_indexed;

    case M_SDX_AB:
      if (GPR_SIZE == 64)
	{
	  s = "sdx";
	  goto st_indexed_gp;
	}
      s = "swx";
    ldd_std_indexed:
      if (!nanomips_opts.at)
	as_bad (_("macro used $at after \".set noat\""));
      used_at = 1;
      tempreg = AT;
      imm_expr.X_op = O_constant;
      imm_expr.X_add_number = 4;
      nanomips_macro_la (&tempreg, 0, &used_at);
      macro_build (NULL, s, "d,s(t)", op[0], tempreg, op[2]);
      macro_build (&imm_expr, ADDRESS_ADDI_INSN,
		   (nanomips_opts.insn32 ? ADDIU_FMT : "mp,mx,+9"),
		   tempreg, tempreg, BFD_RELOC_NANOMIPS_LO12);
      macro_build (NULL, s, "d,s(t)", op[0]+1, tempreg, op[2]);
      break;

    case M_SWX_AB:
      s = "swx";
      goto st_indexed_gp;

    case M_SHX_AB:
      s = "shx";
      goto st_indexed_gp;

    case M_SBX_AB:
      s = "sbx";
      /* Fall through  */

    st_indexed_gp:
      fmt = "d,s(t)";

    st_indexed:
      if (!nanomips_opts.at)
	as_bad (_("macro used $at after \".set noat\""));
      used_at = 1;
      tempreg = AT;

    ld_st_indexed:
      nanomips_macro_la (&tempreg, 0, &used_at);
      macro_build (NULL, s, fmt, op[0], tempreg, op[2]);
      break;

    case M_JRADDIUSP:
      offset_expr = imm_expr;
      if (small_poffset_p (0, 1, ISA_ADD_OFFBITS))
	macro_build (&imm_expr, "addiu", ADDIU_FMT, SP, SP,
		     BFD_RELOC_NANOMIPS_IMM16);
      else if (small_noffset_p (0, ISA_OFFBITS))
	macro_build (&imm_expr, "addiu", ADDIU_FMT, SP, SP,
		     BFD_RELOC_NANOMIPS_NEG12);
      else
	{
	  used_at = 1;
	  load_register (AT, &imm_expr, GPR_SIZE == 64);
	  macro_build (NULL, "addu", "d,v,t", SP, SP, AT);
	}
      macro_build (NULL, "jrc", (nanomips_opts.insn32 ? "s" : "mp"), RA);
      break;

    case M_LI:
      if (imm_expr.X_op != O_absent)
	load_register (op[0], &imm_expr, 0);
      else
	nanomips_macro_la (op, 0, &used_at);
      break;

    case M_LI_S:
      if (imm_expr.X_op == O_constant)
	{
	  load_register (op[0], &imm_expr, 0);
	  break;
	}

      /* Loading from data section, fall-back to load-from-label
	 macro expansion.  */
      used_at = 1;
      align = 4;
      offbits = ISA_OFFBITS;
      fmt = ISA_UNSIGNED_LDST_FMT;
      op[2] = 0;
      s = "lw";
      gpfmt  = LWGP_FMT;
      tempreg = (op[0] != 0) ? op[0] : AT;
      goto ld_noat;

    case M_DLI:
      load_register (op[0], &imm_expr, 1);
      break;

    case M_LI_SS:
      if (imm_expr.X_op == O_constant)
	{
	  used_at = 1;
	  load_register (AT, &imm_expr, 0);
	  macro_build (NULL, "mtc1", "t,G", AT, op[0]);
	  break;
	}

      /* Loading from data section, fall-back to load-from-label
	 macro expansion.  */
      used_at = 1;
      align = 4;
      offbits = ISA_OFFBITS;
      fmt = ISA_UNSIGNED_COP1_FMT;
      op[2] = 0;
      s = "lwc1";
      gpfmt = "T,+2(ma)";
      coproc = 1;
      goto ld_st;

    case M_LI_D:
      /* Check if we have a constant in IMM_EXPR.  If the GPRs are 64 bits
         wide, IMM_EXPR is the entire value.  Otherwise IMM_EXPR is the high
         order 32 bits of the value and the low order 32 bits are either
         zero or in OFFSET_EXPR.  */
      if (imm_expr.X_op == O_constant)
	{
	  if (GPR_SIZE == 64)
	    load_register (op[0], &imm_expr, 1);
	  else
	    {
	      int hreg, lreg;

	      if (target_big_endian)
		{
		  hreg = op[0];
		  lreg = op[0] + 1;
		}
	      else
		{
		  hreg = op[0] + 1;
		  lreg = op[0];
		}

	      if (hreg <= 31)
		load_register (hreg, &imm_expr, 0);
	      if (lreg <= 31)
		{
		  if (offset_expr.X_op == O_absent)
		    move_register (lreg, 0);
		  else
		    {
		      gas_assert (offset_expr.X_op == O_constant);
		      load_register (lreg, &offset_expr, 0);
		    }
		}
	    }
	  break;
	}

      /* Loading from data section, fall-back to load-from-label
	 macro expansion.  */
      gas_assert (imm_expr.X_op == O_absent);
      used_at = 1;
      align = 4;
      offbits = ISA_OFFBITS;
      fmt = ISA_UNSIGNED_LDST_FMT;
      op[2] = 0;
      if (GPR_SIZE == 64)
	{
	  s = "ld";
	  gpfmt  = LDGP_FMT;
	  tempreg = (op[0] != 0) ? op[0] : AT;
	  goto ld_noat;
	}

      s = "lw";
      gpfmt  = LWGP_FMT;
      tempreg = op[0];
      goto ldd_std;

    case M_LI_DD:
      /* Check if we have a constant in IMM_EXPR.  If the FPRs are 64 bits
         wide, IMM_EXPR is the entire value and the GPRs are known to be 64
         bits wide as well.  Otherwise IMM_EXPR is the high order 32 bits of
         the value and the low order 32 bits are either zero or in
         OFFSET_EXPR.  */
      if (imm_expr.X_op == O_constant)
	{
	  used_at = 1;
	  load_register (AT, &imm_expr, TRUE);
	  if (GPR_SIZE == 64)
	    macro_build (NULL, "dmtc1", "t,S", AT, op[0]);
	  else
	    {
	      macro_build (NULL, "mthc1", "t,G", AT, op[0]);
	      if (offset_expr.X_op == O_absent)
		macro_build (NULL, "mtc1", "t,G", 0, op[0]);
	      else
		{
		  gas_assert (offset_expr.X_op == O_constant);
		  load_register (AT, &offset_expr, 0);
		  macro_build (NULL, "mtc1", "t,G", AT, op[0]);
		}
	    }
	  break;
	}

      /* Loading from data section, fall-back to load-from-label
	 macro expansion.  */
      op[2] = 0;
      align = 8;
      coproc = 1;
      fmt = ISA_UNSIGNED_COP1_FMT;
      gpfmt = "T,+2(ma)";
      s = "ldc1";
      goto ld_st ;

    case M_LD_AC:
      fmt = ISA_UNSIGNED_LDST_FMT;
      gpfmt = "t,+2(ma)";
      if (GPR_SIZE == 64)
	{
	  gpfmt = "t,mV(ma)";
	  goto ld;
	}

      s = "lw";
      goto ldd_std;

    case M_SD_AC:
      fmt = ISA_UNSIGNED_LDST_FMT;
      gpfmt = "t,+2(ma)";
      if (GPR_SIZE == 64)
	{
	  gpfmt = "t,mV(ma)";
	  if (small_noffset_p (0, ISA_SIGNED_OFFBITS - 1))
	    {
	      fmt = ISA_SIGNED_LDST_FMT;
	      goto ld_st_signed_off;
	    }
	  else
	    goto ld_st;
	}
      s = "sw";

    ldd_std:
      breg = op[2];
      nanomips_macro_ldd_std (s, fmt, op, align, offbits, breg,
			      &used_at, coproc);
      break;

    case M_DMUL:
      dbl = TRUE;
      /* Fall through.  */
    case M_MUL:
      macro_build (NULL, dbl ? "dmultu" : "multu", "s,t", op[1], op[2]);
      macro_build (NULL, "mflo", MFHL_FMT, op[0]);
      break;

    case M_DMUL_I:
      dbl = TRUE;
      /* Fall through.  */
    case M_MUL_I:
      used_at = 1;
      load_register (AT, &imm_expr, dbl);
      macro_build (NULL, dbl ? "dmul" : "mul", "d,v,t", op[0], op[1], AT);
      break;

    case M_DROL:
      if (op[0] == op[1])
	{
	  tempreg = AT;
	  used_at = 1;
	}
      else
	tempreg = op[0];
      macro_build (NULL, "dnegu", "d,w", tempreg, op[2]);
      macro_build (NULL, "drorv", BITW_FMT, op[0], op[1], tempreg);
      break;

    case M_ROL:
      if (op[0] == op[1])
	{
	  tempreg = AT;
	  used_at = 1;
	}
      else
	tempreg = op[0];
      macro_build (NULL, "negu", "d,w", tempreg, op[2]);
      macro_build (NULL, "rorv", BITW_FMT, op[0], op[1], tempreg);
      break;

    case M_DROL_I:
      {
	unsigned int rot;

	rot = imm_expr.X_add_number & 0x3f;
	rot = (64 - rot) & 0x3f;
	if (rot >= 32)
	  macro_build (NULL, "dror32", SHFT_FMT, op[0], op[1], rot - 32);
	else
	  macro_build (NULL, "dror", SHFT_FMT, op[0], op[1], rot);
	break;
      }

    case M_ROL_I:
      {
	unsigned int rot;

	rot = imm_expr.X_add_number & 0x1f;
	macro_build (NULL, "ror", SHFT_FMT, op[0], op[1], (32 - rot) & 0x1f);
	break;
      }

    case M_ROR_I:
      {
	unsigned int rot;

	rot = imm_expr.X_add_number & 0x1f;
	macro_build (NULL, "ror", SHFT_FMT, op[0], op[1], rot);
	break;
      }

    case M_SEQ:
      if (op[1] == 0)
	macro_build (&expr1, "sltiu", OP_IMM_FMT, op[0], op[2],
		     BFD_RELOC_LO16);
      else if (op[2] == 0)
	macro_build (&expr1, "sltiu", OP_IMM_FMT, op[0], op[1],
		     BFD_RELOC_LO16);
      else
	{
	  macro_build (NULL, "xor", "d,v,t", op[0], op[1], op[2]);
	  macro_build (&expr1, "sltiu", OP_IMM_FMT, op[0], op[0],
		       BFD_RELOC_LO16);
	}
      break;

    case M_SEQ_I:
      if (imm_expr.X_add_number == 0)
	macro_build (&expr1, "sltiu", OP_IMM_FMT, op[0], op[1],
		     BFD_RELOC_LO16);
      else if (op[1] == 0)
	{
	  as_warn (_("instruction %s: result is always false"),
		   ip->insn_mo->name);
	  move_register (op[0], 0);
	}
      else if (offset_high_unsigned (imm_expr.X_add_number, ISA_OFFBITS) == 0)
	macro_build (&imm_expr, "seqi", OP_IMM_FMT, op[0], op[1],
		     BFD_RELOC_LO16);
      else
	{
	  if (offset_high_unsigned (-imm_expr.X_add_number,
				    ISA_ADD_OFFBITS) == 0)
	    {
	      imm_expr.X_add_number = -imm_expr.X_add_number;
	      macro_build (&imm_expr, GPR_SIZE == 32 ? "addiu" : "daddiu",
			   GPR_SIZE == 32 ? ADDIU_FMT : "t,r,h",
			   op[0], op[1], BFD_RELOC_LO16);
	    }
	  else
	    {
	      used_at = 1;
	      load_register (AT, &imm_expr, GPR_SIZE == 64);
	      macro_build (NULL, "xor", "d,v,t", op[0], op[1], AT);
	    }
	  macro_build (&expr1, "sltiu", OP_IMM_FMT, op[0], op[0],
		       BFD_RELOC_LO16);
	}
      break;

    case M_SGE:		/* X >= Y  <==>  not (X < Y) */
      s = "slt";
      goto sge;
    case M_SGEU:
      s = "sltu";
    sge:
      macro_build (NULL, s, "d,v,t", op[0], op[1], op[2]);
      macro_build (&expr1, "xori", BITOP_IMM_FMT, op[0], op[0],
		   BFD_RELOC_LO16);
      break;

    case M_SGE_I:		/* X >= I  <==>  not (X < I) */
    case M_SGEU_I:
      if (offset_high_unsigned (imm_expr.X_add_number, ISA_OFFBITS) == 0)
	macro_build (&imm_expr, mask == M_SGE_I ? "slti" : "sltiu",
		     OP_IMM_FMT, op[0], op[1], BFD_RELOC_LO16);
      else
	{
	  used_at = 1;
	  load_register (AT, &imm_expr, GPR_SIZE == 64);
	  macro_build (NULL, mask == M_SGE_I ? "slt" : "sltu", "d,v,t",
		       op[0], op[1], AT);
	}
      macro_build (&expr1, "xori", BITOP_IMM_FMT, op[0], op[0],
		   BFD_RELOC_LO16);
      break;

    case M_SGT:		/* X > Y  <==>  Y < X */
      s = "slt";
      goto sgt;
    case M_SGTU:
      s = "sltu";
    sgt:
      macro_build (NULL, s, "d,v,t", op[0], op[2], op[1]);
      break;

    case M_SGT_I:		/* X > I  <==>  I < X */
      s = "slt";
      goto sgti;
    case M_SGTU_I:
      s = "sltu";
    sgti:
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, s, "d,v,t", op[0], AT, op[1]);
      break;

    case M_SLE:		/* X <= Y  <==>  Y >= X  <==>  not (Y < X) */
      s = "slt";
      goto sle;
    case M_SLEU:
      s = "sltu";
    sle:
      macro_build (NULL, s, "d,v,t", op[0], op[2], op[1]);
      macro_build (&expr1, "xori", BITOP_IMM_FMT, op[0], op[0],
		   BFD_RELOC_LO16);
      break;

    case M_SLE_I:	/* X <= I  <==>  I >= X  <==>  not (I < X) */
      s = "slt";
      goto slei;
    case M_SLEU_I:
      s = "sltu";
    slei:
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, s, "d,v,t", op[0], AT, op[1]);
      macro_build (&expr1, "xori", BITOP_IMM_FMT, op[0], op[0],
		   BFD_RELOC_LO16);
      break;

    case M_SLT_I:
      if (offset_high_unsigned (imm_expr.X_add_number, ISA_OFFBITS) == 0)
	{
	  macro_build (&imm_expr, "slti", OP_IMM_FMT, op[0], op[1],
		       BFD_RELOC_LO16);
	  break;
	}
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, "slt", "d,v,t", op[0], op[1], AT);
      break;

    case M_SLTU_I:
      if (offset_high_unsigned (imm_expr.X_add_number, ISA_OFFBITS) == 0)
	{
	  macro_build (&imm_expr, "sltiu", OP_IMM_FMT, op[0], op[1],
		       BFD_RELOC_LO16);
	  break;
	}
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, "sltu", "d,v,t", op[0], op[1], AT);
      break;

    case M_SNE:
      if (op[1] == 0)
	macro_build (NULL, "sltu", "d,v,t", op[0], 0, op[2]);
      else if (op[2] == 0)
	macro_build (NULL, "sltu", "d,v,t", op[0], 0, op[1]);
      else
	{
	  macro_build (NULL, "xor", "d,v,t", op[0], op[1], op[2]);
	  macro_build (NULL, "sltu", "d,v,t", op[0], 0, op[0]);
	}
      break;

    case M_SNE_I:
      if (imm_expr.X_add_number == 0)
	macro_build (NULL, "sltu", "d,v,t", op[0], 0, op[1]);
      else if (op[1] == 0)
	{
	  as_warn (_("instruction %s: result is always true"),
		   ip->insn_mo->name);
	  load_register (op[0], &expr1, GPR_SIZE == 64);
	}
      else
	{
	  if (offset_high_unsigned (imm_expr.X_add_number,
				    ISA_ADD_OFFBITS) == 0)
	  macro_build (&imm_expr, "xori", BITOP_IMM_FMT, op[0], op[1],
		       BFD_RELOC_LO16);
	  else if (offset_high_unsigned (-imm_expr.X_add_number,
					 ISA_ADD_OFFBITS) == 0)
	    {
	      imm_expr.X_add_number = -imm_expr.X_add_number;
	      macro_build (&imm_expr, GPR_SIZE == 32 ? "addiu" : "daddiu",
			   ADDIU_FMT, op[0], op[1], BFD_RELOC_LO16);
	    }
	  else
	    {
	      used_at = 1;
	      load_register (AT, &imm_expr, GPR_SIZE == 64);
	      macro_build (NULL, "xor", "d,v,t", op[0], op[1], op[2]);
	    }
	  macro_build (NULL, "sltu", "d,v,t", op[0], 0, op[0]);
	}
      break;

    case M_SUB_I:
      s = "addiu";
      s2 = "sub";
      goto do_subi_i;
    case M_SUBU_I:
      s = "addiu";
      s2 = "subu";
      goto do_subi;
    case M_DSUB_I:
      dbl = TRUE;
      s = "daddi";
      s2 = "dsub";
      goto do_subi_i;
    case M_DSUBU_I:
      dbl = TRUE;
      s = "daddiu";
      s2 = "dsubu";
    do_subi:
      if (offset_high_unsigned (-imm_expr.X_add_number, 16) == 0)
	{
	  imm_expr.X_add_number = -imm_expr.X_add_number;
	  macro_build (&imm_expr, s, ADDIU_FMT, op[0], op[1],
		       BFD_RELOC_NANOMIPS_IMM16);
	  break;
	}
      else if (offset_high_unsigned (imm_expr.X_add_number, 12) == 0)
	{
	  imm_expr.X_add_number = -imm_expr.X_add_number;
	  macro_build (&imm_expr, s, "t,r,h", op[0], op[1],
		       BFD_RELOC_NANOMIPS_NEG12);
	  break;
	}
      else if ((nanomips_opts.ase & ASE_xNMS) != 0
	       && op[0] == op[1] && !nanomips_opts.insn32)
	{
	  imm_expr.X_add_number = -imm_expr.X_add_number;
	  macro_build (&imm_expr, s, "mp,mt,+R", op[0], op[0],
		       BFD_RELOC_NANOMIPS_I32);
	  break;
	}

    do_subi_i:
      used_at = 1;
      load_register (AT, &imm_expr, dbl);
      macro_build (NULL, s2, "d,v,t", op[0], op[1], AT);
      break;

    case M_TEQ_I:
    case M_TNE_I:
      used_at = 1;
      load_register (AT, &imm_expr, GPR_SIZE == 64);
      macro_build (NULL, s, "s,t", op[0], AT);
      break;

    case M_ULH_AC:
    case M_ULHU_AC:
    case M_ULW_AC:
    case M_USH_AC:
    case M_USW_AC:
      s = s + 1;
      goto uld_st;

    case M_ULD_AC:
      s = "ld";
      s2 = "lw";
      goto uld_st;
    case M_USD_AC:
      s = "sd";
      s2 = "sw";

    uld_st:
      fmt = ISA_UNSIGNED_LDST_FMT;
      switch (s[1])
	{
	case 'w':
	  gpfmt = "t,.(ma)";
	  break;
	case 'd':
	  gpfmt = "t,mV(ma)";
	  break;
	case 'h':
	  gpfmt = "t,+3(ma)";
	  break;
	default:
	  gpfmt = "t,+1(ma)";
	  break;
	}
      if (s[1] == 'd')
	{
	  s = s2;
	  goto ldd_std;
	}
      else if (small_noffset_p (0, ISA_SIGNED_OFFBITS - 1))
	{
	  fmt = ISA_SIGNED_LDST_FMT;
	  goto ld_st_signed_off;
	}
      else
	goto ld_st;
      break;

    default:
      as_bad (_("macro %s not implemented yet"), ip->insn_mo->name);
      break;
    }
  if (!nanomips_opts.at && used_at)
    as_bad (_("macro used $at after \".set noat\""));
}

/* Look up instruction [START, START + LENGTH) in HASH.  Record any extra
   opcode bits in *OPCODE_EXTRA.  */

static struct nanomips_opcode *
nanomips_lookup_insn (struct hash_control *hash, const char *start,
		      ssize_t length,
		      unsigned int *opcode_extra ATTRIBUTE_UNUSED)
{
  char *name, *dot;
  unsigned int suffix;
  ssize_t opend;
  struct nanomips_opcode *insn;

  /* Make a copy of the instruction so that we can fiddle with it.  */
  name = xstrndup (start, length);

  forced_insn_format = (strchr (start, '[') != NULL
			&& strchr (strchr (start, '['), ']') != NULL);

  /* Look up the instruction as-is.  */
  insn = (struct nanomips_opcode *) hash_find (hash, name);
  if (insn)
    return insn;

  if (strchr (name, ']'))
    dot = strchr (strchr (name, ']'), '.');
  else
    dot = strchr (name, '.');

  /* See if there's an instruction size override suffix,
     either `16' or `32', at the end of the mnemonic proper,
     that defines the operation, i.e. before the first `.'
     character if any.  Strip it and retry.  */
  opend = dot != NULL ? dot - name : length;
  if (opend >= 3 && name[opend - 2] == '1' && name[opend - 1] == '6')
    suffix = 2;
  else if (opend >= 3 && name[opend - 2] == '3' && name[opend - 1] == '2')
    suffix = 4;
  else if (opend >= 3 && name[opend - 2] == '4' && name[opend - 1] == '8')
    suffix = 6;
  else
    suffix = 0;
  if (suffix)
    {
      memmove (name + opend - 2, name + opend, length - opend + 1);
      insn = (struct nanomips_opcode *) hash_find (hash, name);
      while (insn)
	if (insn_length (insn) == suffix)
	  {
	    forced_insn_length = suffix;
	    return insn;
	  }
	else if (forced_insn_format)
	  break;
	else
	  insn++;
    }

  return NULL;
}

/* Assemble an instruction into its binary format.  If the instruction
   is a macro, set imm_expr and offset_expr to the values associated
   with "I" and "A" operands respectively.  Otherwise store the value
   of the relocatable field (if any) in offset_expr.  In both cases
   set offset_reloc to the relocation operators applied to offset_expr.  */

static void
nanomips_ip (char *str, struct nanomips_cl_insn *insn)
{
  const struct nanomips_opcode *first, *past;
  struct hash_control *hash;
  char format;
  size_t end;
  struct nanomips_operand_token *tokens;
  unsigned int opcode_extra;

  hash = nanomips_op_hash;
  past = &nanomips_opcodes[bfd_nanomips_num_opcodes];
  forced_insn_length = 0;
  forced_insn_format = FALSE;
  opcode_extra = 0;

  /* We first try to match an instruction up to a space or to the end.  */
  for (end = 0; str[end] != '\0' && !ISSPACE (str[end]); end++)
    continue;

  first = nanomips_lookup_insn (hash, str, end, &opcode_extra);
  if (first == NULL)
    {
      set_insn_error (0, _("unrecognized opcode"));
      return;
    }

  if (strcmp (first->name, "li.s") == 0)
    format = 'f';
  else if (strcmp (first->name, "li.d") == 0)
    format = 'd';
  else
    format = 0;
  tokens = nanomips_parse_arguments (str + end, format);
  if (!tokens)
    return;

  if (!match_nanomips_insns (insn, first, past, tokens, opcode_extra, FALSE)
      && !match_nanomips_insns (insn, first, past, tokens, opcode_extra,
				TRUE))
    set_insn_error (0, _("invalid operands"));

  obstack_free (&nanomips_operand_tokens, tokens);
}


struct percent_op_match
{
  const char *str;
  bfd_reloc_code_real_type reloc;
};

static const struct percent_op_match nanomips_percent_op[] = {
  {"%lo", BFD_RELOC_NANOMIPS_LO12},
  {"%call16", BFD_RELOC_NANOMIPS_GOT_CALL},
  {"%got_call", BFD_RELOC_NANOMIPS_GOT_CALL},
  {"%got_disp", BFD_RELOC_NANOMIPS_GOT_DISP},
  {"%got_page", BFD_RELOC_NANOMIPS_GOT_PAGE},
  {"%got_ofst", BFD_RELOC_NANOMIPS_GOT_OFST},
  {"%got", BFD_RELOC_NANOMIPS_GOT_DISP},
  {"%gp_rel", BFD_RELOC_NANOMIPS_GPREL18},
  {"%gprel", BFD_RELOC_NANOMIPS_GPREL18},
  {"%gprel_hi", BFD_RELOC_NANOMIPS_GPREL_HI20},
  {"%gprel_lo", BFD_RELOC_NANOMIPS_GPREL_LO12},
  {"%gprel32", BFD_RELOC_NANOMIPS_GPREL_I32},
  {"%hi", BFD_RELOC_NANOMIPS_HI20},
  {"%lo32", BFD_RELOC_NANOMIPS_I32},
  {"%hi32", BFD_RELOC_NANOMIPS_HI32},
  {"%pcrel_hi", BFD_RELOC_NANOMIPS_PCREL_HI20},
  {"%pcrel_lo", BFD_RELOC_NANOMIPS_LO12},
  {"%got_pcrel_hi", BFD_RELOC_NANOMIPS_GOTPC_HI20},
  {"%got_pcrel_lo", BFD_RELOC_NANOMIPS_GOT_LO12},
  {"%got_lo", BFD_RELOC_NANOMIPS_GOT_LO12},
  {"%got_pcrel32", BFD_RELOC_NANOMIPS_GOTPC_I32},
  {"%tlsgd", BFD_RELOC_NANOMIPS_TLS_GD},
  {"%tlsld", BFD_RELOC_NANOMIPS_TLS_LD},
  {"%dtprel", BFD_RELOC_NANOMIPS_TLS_DTPREL12},
  {"%tprel", BFD_RELOC_NANOMIPS_TLS_TPREL12},
  {"%gottprel", BFD_RELOC_NANOMIPS_TLS_GOTTPREL},
  {"%gottprel_pc32", BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32},
  /* These are currently not supported for nanoMIPS.  */
  {"%call_hi", BFD_RELOC_UNUSED},
  {"%call_lo", BFD_RELOC_UNUSED}
};


/* Return true if *STR points to a relocation operator.  When returning true,
   move *STR over the operator and store its relocation code in *RELOC.
   Leave both *STR and *RELOC alone when returning false.  */

static bfd_boolean
parse_relocation (char **str, bfd_reloc_code_real_type *reloc)
{
  const struct percent_op_match *percent_op;
  size_t limit, i;

  percent_op = nanomips_percent_op;
  limit = ARRAY_SIZE (nanomips_percent_op);

  for (i = 0; i < limit; i++)
    if (strncasecmp (*str, percent_op[i].str, strlen (percent_op[i].str))
	== 0)
      {
	int len = strlen (percent_op[i].str);

	if (!ISSPACE ((*str)[len]) && (*str)[len] != '(')
	  continue;

	*str += strlen (percent_op[i].str);
	*reloc = percent_op[i].reloc;

	/* Check whether the output BFD supports this relocation.
	   If not, issue an error and fall back on something safe.  */
	if (!bfd_reloc_type_lookup (stdoutput, percent_op[i].reloc))
	  {
	    as_bad (_("relocation %s isn't supported by the current ABI"),
		    percent_op[i].str);
	    *reloc = BFD_RELOC_UNUSED;
	  }
	return TRUE;
      }
  return FALSE;
}


/* Parse string STR as a 16-bit relocatable operand.  Store the
   expression in *EP and the relocations in the array starting
   at RELOC.  Return the number of relocation operators used.

   On exit, EXPR_END points to the first character after the expression.  */

static size_t
my_getSmallExpression (expressionS *ep, bfd_reloc_code_real_type *reloc,
		       char *str)
{
  bfd_reloc_code_real_type reversed_reloc[3];
  size_t reloc_index, i;
  int crux_depth, str_depth;
  char *crux;

  memset (reversed_reloc, 0, sizeof (reversed_reloc));
  /* Search for the start of the main expression, recoding relocations
     in REVERSED_RELOC.  End the loop with CRUX pointing to the start
     of the main expression and with CRUX_DEPTH containing the number
     of open brackets at that point.  */
  reloc_index = -1;
  str_depth = 0;
  do
    {
      reloc_index++;
      crux = str;
      crux_depth = str_depth;

      /* Skip over whitespace and brackets, keeping count of the number
         of brackets.  */
      while (*str == ' ' || *str == '\t' || *str == '(')
	if (*str++ == '(')
	  str_depth++;
    }
  while (*str == '%'
	 && reloc_index < 1
	 && parse_relocation (&str, &reversed_reloc[reloc_index]));

  my_getExpression (ep, crux);
  str = expr_end;

  /* Match every open bracket.  */
  while (crux_depth > 0 && (*str == ')' || *str == ' ' || *str == '\t'))
    if (*str++ == ')')
      crux_depth--;

  if (crux_depth > 0)
    as_bad (_("unclosed '('"));

  expr_end = str;

  if (reloc_index != 0)
    {
      prev_reloc_op_frag = frag_now;
      for (i = 0; i < reloc_index; i++)
	reloc[i] = reversed_reloc[reloc_index - 1 - i];
    }

  return reloc_index;
}

static void
my_getExpression (expressionS *ep, char *str)
{
  char *save_in;

  save_in = input_line_pointer;
  input_line_pointer = str;
  expression (ep);
  expr_end = input_line_pointer;
  input_line_pointer = save_in;
}

const char *
md_atof (int type, char *litP, int *sizeP)
{
  return ieee_md_atof (type, litP, sizeP, target_big_endian);
}

void
md_number_to_chars (char *buf, valueT val, int n)
{
  if (target_big_endian)
    number_to_chars_bigendian (buf, val, n);
  else
    number_to_chars_littleendian (buf, val, n);
}

static int
support_64bit_objects (void)
{
  const char **list, **l;
  int yes;

  list = bfd_target_list ();
  for (l = list; *l != NULL; l++)
    if (strcmp (*l, ELF_NTARGET ("elf64-", "big")) == 0
	|| strcmp (*l, ELF_NTARGET ("elf64-", "little")) == 0)
      break;
  yes = (*l != NULL);
  free (list);
  return yes;
}

/* Set STRING_PTR (either &nanomips_arch_string or &nanomips_tune_string) to
   NEW_VALUE.  Warn if another value was already specified.  Note:
   we have to defer parsing the -march and -mtune arguments in order
   to handle 'from-abi' correctly, since the ABI might be specified
   in a later argument.  */

static void
nanomips_set_option_string (const char **string_ptr, const char *new_value)
{
  if (*string_ptr != 0 && strcasecmp (*string_ptr, new_value) != 0)
    as_warn (_("a different %s was already specified, is now %s"),
	     string_ptr == &nanomips_arch_string ? "-march" : "-mtune",
	     new_value);

  *string_ptr = new_value;
}

static void
nanomips_set_mcmodel (enum mc_model_type *model, const char *arg)
{
  if (strcmp (arg, "large"))
    *model = MC_LARGE;
  else if (strcmp (arg, "medium"))
    *model = MC_LARGE;
  else if (strcmp (arg, "auto"))
    *model = MC_AUTO;
  else
    as_fatal (_("Request for unsupported memory model %s"), arg);
}

int
md_parse_option (int c, const char *arg)
{
  unsigned int i;

  for (i = 0; i < ARRAY_SIZE (nanomips_ases); i++)
    if (c == nanomips_ases[i].option_on || c == nanomips_ases[i].option_off)
      {
	file_ase_explicit |=
	  nanomips_set_ase (&nanomips_ases[i], &file_nanomips_opts,
			    c == nanomips_ases[i].option_on);
	return 1;
      }

  switch (c)
    {
    case OPTION_CONSTRUCT_FLOATS:
      nanomips_disable_float_construction = 0;
      break;

    case OPTION_NO_CONSTRUCT_FLOATS:
      nanomips_disable_float_construction = 1;
      break;

    case OPTION_TRAP:
      nanomips_trap = 1;
      break;

    case OPTION_BREAK:
      nanomips_trap = 0;
      break;

    case OPTION_EB:
      target_big_endian = 1;
      break;

    case OPTION_EL:
      target_big_endian = 0;
      break;

    case 'g':
      if (arg == NULL)
	nanomips_debug = 2;
      else
	nanomips_debug = atoi (arg);
      break;

    case OPTION_MTUNE:
      nanomips_set_option_string (&nanomips_tune_string, arg);
      break;

    case OPTION_MARCH:
      nanomips_set_option_string (&nanomips_arch_string, arg);
      break;

    case OPTION_NO_MICROMIPS:
    case OPTION_NO_MIPS16:
      break;

    case OPTION_INSN32:
      file_nanomips_opts.insn32 = TRUE;
      break;

    case OPTION_NO_INSN32:
      file_nanomips_opts.insn32 = FALSE;
      break;

    case OPTION_PIC:
      file_nanomips_opts.pic = SVR4_PIC;
      break;

    case OPTION_NOPIC:
      file_nanomips_opts.pic = NO_PIC;
      break;

    case OPTION_LARGE_PIC:
      file_nanomips_opts.pic = SVR4_LARGE_PIC;
      break;

    case 'G':
      g_switch_value = atoi (arg);
      g_switch_seen = 1;
      break;

      /* The -32, -n32 and -64 options are shortcuts for -mabi=32, -mabi=n32
         and -mabi=64.  */
    case OPTION_32:
    case OPTION_64:
      as_fatal (_("Request for unsupported ABI"));
      break;

    case OPTION_M32:
      nanomips_abi = P32_ABI;
      break;

    case OPTION_M64:
      nanomips_abi = P64_ABI;
      if (!support_64bit_objects ())
	as_fatal (_("no compiled in support for 64 bit object file format"));
      break;

    case OPTION_BALC_STUBS:
      file_nanomips_opts.no_balc_stubs = FALSE;
      break;

    case OPTION_NO_BALC_STUBS:
      file_nanomips_opts.no_balc_stubs = TRUE;
      break;

    case OPTION_LEGACY_REGS:
      file_nanomips_opts.legacyregs = TRUE;
      break;

    case OPTION_NO_LEGACY_REGS:
      file_nanomips_opts.legacyregs = FALSE;
      break;

    case OPTION_LINKRELAX:
      s_linkrelax (0);
      break;

    case OPTION_SINGLE_FLOAT:
      file_nanomips_opts.single_float = 1;
      break;

    case OPTION_DOUBLE_FLOAT:
      file_nanomips_opts.single_float = 0;
      break;

    case OPTION_SOFT_FLOAT:
      file_nanomips_opts.soft_float = 1;
      break;

    case OPTION_HARD_FLOAT:
      file_nanomips_opts.soft_float = 0;
      break;

    case OPTION_PCREL:
      file_nanomips_opts.pcrel = TRUE;
      break;

    case OPTION_NO_PCREL:
      file_nanomips_opts.pcrel = FALSE;
      break;

    case OPTION_PID:
      file_nanomips_opts.pid = TRUE;
      break;

    case OPTION_NO_PID:
      file_nanomips_opts.pid = FALSE;
      break;

    case OPTION_MCMODEL:
      nanomips_set_mcmodel (&file_nanomips_opts.mc_model, arg);
      break;

    case OPTION_MTTGPR_RC1:
      nanomips_mttgpr_rc1 = TRUE;
      break;

    case OPTION_MINIMIZE_RELOCS:
      file_nanomips_opts.minimize_relocs = TRUE;
      break;

    case OPTION_NO_MINIMIZE_RELOCS:
      file_nanomips_opts.minimize_relocs = FALSE;
      break;

    default:
      return 0;
    }

  return 1;
}

/* Set up globals to tune for the ISA or processor described by INFO.  */

static void
nanomips_set_tune (const struct nanomips_cpu_info *info)
{
  if (info != 0)
    nanomips_tune = info->cpu;
}

void
nanomips_after_parse_args (void)
{
  const struct nanomips_cpu_info *arch_info = 0;
  const struct nanomips_cpu_info *tune_info = 0;

  /* GP relative stuff not working for PE */
  if (strncmp (TARGET_OS, "pe", 2) == 0)
    {
      if (g_switch_seen && g_switch_value != 0)
	as_bad (_("-G not supported in this configuration"));
      g_switch_value = 0;
    }

  /* The following code determines the architecture.
     Similar code was added to GCC 3.3 (see override_options() in
     config/mips/mips.c).  The GAS and GCC code should be kept in sync
     as much as possible.  */

  if (nanomips_arch_string != 0)
    arch_info = nanomips_parse_cpu ("-march", nanomips_arch_string);

  if (arch_info == 0)
    {
      arch_info = nanomips_parse_cpu ("default CPU",
				      NANOMIPS_CPU_STRING_DEFAULT);
      gas_assert (arch_info);
    }

  if (nanomips_abi == NO_ABI)
    nanomips_abi = NANOMIPS_DEFAULT_ABI;

  if (ABI_NEEDS_64BIT_REGS (nanomips_abi)
      && !ISA_HAS_64BIT_REGS (arch_info->isa))
    as_bad (_("-march=%s is not compatible with the selected ABI"),
	    arch_info->name);

  file_nanomips_opts.arch = arch_info->cpu;
  file_nanomips_opts.isa = arch_info->isa;
  file_nanomips_opts.init_ase = arch_info->ase;

  /* Set up initial nanomips_opts state.  */
  nanomips_opts = file_nanomips_opts;

  /* The register size inference code is now placed in
     file_check_options.  */

  /* Optimize for file_nanomips_opts.arch, unless -mtune selects a different
     processor.  */
  if (nanomips_tune_string != 0)
    tune_info = nanomips_parse_cpu ("-mtune", nanomips_tune_string);

  if (tune_info == 0)
    nanomips_set_tune (arch_info);
  else
    nanomips_set_tune (tune_info);
}


/* This is called before the symbol table is processed.  In order to
   work with gcc when using mips-tfile, we must keep all local labels.
   However, in other cases, we want to discard them.  If we were
   called with -g, but we didn't see any debugging information, it may
   mean that gcc is smuggling debugging information through to
   mips-tfile, in which case we must generate all local labels.  */

void
nanomips_frob_file_before_adjust (void)
{
#ifndef NO_ECOFF_DEBUGGING
  if (ECOFF_DEBUGGING && nanomips_debug != 0 && !ecoff_debugging_seen)
    flag_keep_locals = 1;
#endif
}

static bfd_boolean
relaxable_section (asection *sec)
{
  return (sec->flags & SEC_DEBUGGING) == 0;
}

int
nanomips_force_relocation (fixS *fixp)
{
  if (pcrel_branch_reloc_p (fixp->fx_r_type)
      && RELAX_NANOMIPS_FIXED (fixp->fx_frag->fr_subtype))
    return 0;

  if (generic_force_reloc (fixp))
    return 1;

  if (linkrelax_reloc_p (fixp->fx_r_type)
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_INSN32
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_INSN16
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_SAVERESTORE
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_JALR32
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_JALR16)
    return 1;


  /* and for nanoMIPS expansions */
  if (pcrel_branch_reloc_p (fixp->fx_r_type)
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_PCREL_HI20
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_PC_I32
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_GOTPC_HI20
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_GOTPC_I32
      || fixp->fx_r_type == BFD_RELOC_NANOMIPS_GOT_LO12)
    return 1;

  if (linkrelax && fixp->fx_subsy
      && relaxable_section (S_GET_SEGMENT (fixp->fx_addsy))
      && nanomips_validate_fix_sub (fixp))
    return 1;

  return 0;
}

/* Find the size of an instruction relocated by RELOC, default to 4.  */
static unsigned int
get_reloc_size (bfd_reloc_code_real_type reloc)
{
  if (pcrel16_reloc_p (reloc))
    return 2;
  else
    return 4;
}

/* Read the instruction associated with RELOC from BUF.  */

static unsigned int
read_reloc_insn (char *buf, bfd_reloc_code_real_type reloc)
{
  return read_compressed_insn (buf, get_reloc_size (reloc));
}

/* Write instruction INSN to BUF, given that it has been relocated
   by RELOC.  */

static void
write_reloc_insn (char *buf, bfd_reloc_code_real_type reloc,
		  unsigned long insn)
{
  write_compressed_insn (buf, insn, get_reloc_size (reloc));
}

/* Apply a fixup to the object file.  */

void
md_apply_fix (fixS *fixP, valueT *valP, segT seg ATTRIBUTE_UNUSED)
{
  char *buf;
  unsigned long insn;
  reloc_howto_type *howto = NULL;

  if (fixP->fx_pcrel)
    switch (fixP->fx_r_type)
      {
      case BFD_RELOC_32_PCREL:
      case BFD_RELOC_NANOMIPS_4_PCREL_S1:
      case BFD_RELOC_NANOMIPS_7_PCREL_S1:
      case BFD_RELOC_NANOMIPS_10_PCREL_S1:
      case BFD_RELOC_NANOMIPS_11_PCREL_S1:
      case BFD_RELOC_NANOMIPS_14_PCREL_S1:
      case BFD_RELOC_NANOMIPS_21_PCREL_S1:
      case BFD_RELOC_NANOMIPS_25_PCREL_S1:
      case BFD_RELOC_NANOMIPS_PCREL_HI20:
      case BFD_RELOC_NANOMIPS_PC_I32:
      case BFD_RELOC_NANOMIPS_GOTPC_HI20:
      case BFD_RELOC_NANOMIPS_GOTPC_I32:
      case BFD_RELOC_NANOMIPS_GOT_LO12:
      case BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32:
	break;

      case BFD_RELOC_32:
	fixP->fx_r_type = BFD_RELOC_32_PCREL;
	*valP += fixP->fx_frag->fr_address + fixP->fx_where;
	break;

      default:
	as_bad_where (fixP->fx_file, fixP->fx_line,
		      _("PC-relative reference to a different section"));
	break;
      }

  if (linkrelax_reloc_p (fixP->fx_r_type)
      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_INSN32
      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_INSN16
      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_SAVERESTORE
      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_JALR32
      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_JALR16)
    {
      fixP->fx_addnumber = *valP;
      return;
    }

  /* Handle BFD_RELOC_8, since it's easy.  Punt on other bfd relocations
     that have no nanoMIPS ELF equivalent.  */
  if (fixP->fx_r_type != BFD_RELOC_8)
    {
      howto = bfd_reloc_type_lookup (stdoutput, fixP->fx_r_type);
      if (!howto)
	return;
    }

  gas_assert (fixP->fx_size == 2
	      || fixP->fx_size == 4
	      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_I32
	      || fixP->fx_r_type == BFD_RELOC_8
	      || fixP->fx_r_type == BFD_RELOC_16
	      || fixP->fx_r_type == BFD_RELOC_64
	      || fixP->fx_r_type == BFD_RELOC_CTOR
	      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_NEG
	      || fixP->fx_r_type == BFD_RELOC_VTABLE_INHERIT
	      || fixP->fx_r_type == BFD_RELOC_VTABLE_ENTRY
	      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_UNSIGNED_8
	      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_SIGNED_8
	      || fixP->fx_r_type == BFD_RELOC_NANOMIPS_ASHIFTR_1
	      || (fixP->fx_size == 1 && fixP->fx_r_type == BFD_RELOC_32));

  buf = fixP->fx_frag->fr_literal + fixP->fx_where;

  /* Don't treat parts of a composite relocation as done.  There are two
     reasons for this:

     (1) The second and third parts will be against 0 (RSS_UNDEF) but
     should nevertheless be emitted if the first part is.

     (2) In normal usage, composite relocations are never assembly-time
     constants.  The easiest way of dealing with the pathological
     exceptions is to generate a relocation against STN_UNDEF and
     leave everything up to the linker.  */
  if ((fixP->fx_addsy == NULL && !fixP->fx_pcrel && fixP->fx_tcbit == 0)
      || (pcrel_branch_reloc_p (fixP->fx_r_type)
	  && fixP->fx_frag
	  && RELAX_NANOMIPS_FIXED (fixP->fx_frag->fr_subtype)))
    fixP->fx_done = 1;

  switch (fixP->fx_r_type)
    {
    case BFD_RELOC_NANOMIPS_TLS_DTPREL:
    case BFD_RELOC_NANOMIPS_TLS_TPREL:
    case BFD_RELOC_NANOMIPS_TLS_GD:
    case BFD_RELOC_NANOMIPS_TLS_LD:
    case BFD_RELOC_NANOMIPS_TLS_GD_I32:
    case BFD_RELOC_NANOMIPS_TLS_LD_I32:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL12:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL16:
    case BFD_RELOC_NANOMIPS_TLS_DTPREL_I32:
    case BFD_RELOC_NANOMIPS_TLS_TPREL12:
    case BFD_RELOC_NANOMIPS_TLS_TPREL16:
    case BFD_RELOC_NANOMIPS_TLS_TPREL_I32:
    case BFD_RELOC_NANOMIPS_TLS_GOTTPREL:
    case BFD_RELOC_NANOMIPS_TLS_GOTTPREL_PC_I32:
      if (!fixP->fx_addsy)
	{
	  as_bad_where (fixP->fx_file, fixP->fx_line,
			_("TLS relocation against a constant"));
	  break;
	}
      S_SET_THREAD_LOCAL (fixP->fx_addsy);
      /* fall through */

    case BFD_RELOC_HI16:
    case BFD_RELOC_HI16_S:
    case BFD_RELOC_LO16:
    case BFD_RELOC_GPREL16:
    case BFD_RELOC_GPREL32:
    case BFD_RELOC_NANOMIPS_EH:
    case BFD_RELOC_NANOMIPS_NEG:
    case BFD_RELOC_NANOMIPS_GOT_CALL:
    case BFD_RELOC_NANOMIPS_GOT_DISP:
    case BFD_RELOC_NANOMIPS_GOT_PAGE:
    case BFD_RELOC_NANOMIPS_GOT_OFST:
    case BFD_RELOC_NANOMIPS_GPREL19_S2:
    case BFD_RELOC_NANOMIPS_GPREL18_S3:
    case BFD_RELOC_NANOMIPS_GPREL18:
    case BFD_RELOC_NANOMIPS_GPREL16_S2:
    case BFD_RELOC_NANOMIPS_GPREL7_S2:
    case BFD_RELOC_NANOMIPS_GPREL17_S1:
    case BFD_RELOC_NANOMIPS_GOT_LO12:

      if (fixP->fx_done)
	as_bad_where (fixP->fx_file, fixP->fx_line,
		      _("unsupported constant in relocation"));
      break;

    case BFD_RELOC_64:
      /* This is handled like BFD_RELOC_32, but we output a sign
         extended value if we are only 32 bits.  */
      if (fixP->fx_done)
	{
	  if (8 <= sizeof (valueT))
	    md_number_to_chars (buf, *valP, 8);
	  else
	    {
	      valueT hiv;

	      if ((*valP & 0x80000000) != 0)
		hiv = 0xffffffff;
	      else
		hiv = 0;
	      md_number_to_chars (buf + (target_big_endian ? 4 : 0),
				  *valP, 4);
	      md_number_to_chars (buf + (target_big_endian ? 0 : 4), hiv, 4);
	    }
	}
      break;

    case BFD_RELOC_RVA:
    case BFD_RELOC_32:
    case BFD_RELOC_32_PCREL:
    case BFD_RELOC_16:
    case BFD_RELOC_8:
    case BFD_RELOC_NANOMIPS_UNSIGNED_8:
    case BFD_RELOC_NANOMIPS_UNSIGNED_16:
    case BFD_RELOC_NANOMIPS_SIGNED_8:
    case BFD_RELOC_NANOMIPS_SIGNED_16:
      /* If we are deleting this reloc entry, we must fill in the
	 value now.  This can happen if we have a .word which is not
	 resolved when it appears but is later defined.  */
      if (fixP->fx_done)
	md_number_to_chars (buf, *valP, fixP->fx_size);
      break;

    case BFD_RELOC_NANOMIPS_ASHIFTR_1:
      if (fixP->fx_done)
	*valP = (*valP >> 1);
      break;

    case BFD_RELOC_NANOMIPS_HI20:
    case BFD_RELOC_NANOMIPS_GPREL_HI20:
      if (!fixP->fx_done)
	break;

      insn = read_reloc_insn (buf, fixP->fx_r_type);

      insn |= ((*valP >> 12) & 0x1ff) << 12
	      | ((*valP >> 21) & 0x3ff) << 2
	      | ((*valP >> 31) & 1);

      write_reloc_insn (buf, fixP->fx_r_type, insn);
      break;

    case BFD_RELOC_NANOMIPS_I32:
    case BFD_RELOC_NANOMIPS_HI32:
    case BFD_RELOC_NANOMIPS_GPREL_I32:
      if (fixP->fx_done)
	write_compressed_insn (buf, *valP & 0xffffffff, 4);
      break;

    case BFD_RELOC_NANOMIPS_LO12:
    case BFD_RELOC_NANOMIPS_GPREL_LO12:
      if (fixP->fx_done)
	{
	  insn = read_reloc_insn (buf, fixP->fx_r_type);
	  insn |= *valP & 0xfff;
	  write_reloc_insn (buf, fixP->fx_r_type, insn);
	}
      break;

    case BFD_RELOC_NANOMIPS_LO4_S2:
      if (fixP->fx_done)
	{
	  if ((*valP & 0xfc3) != 0)
	    as_bad_where (fixP->fx_file, fixP->fx_line,
			  _("offset out of range (0x%lx)"),
			  (long) fixP->fx_offset);
	  insn = read_reloc_insn (buf, fixP->fx_r_type);
	  insn |= (*valP >> 2) & 0xf;
	  write_reloc_insn (buf, fixP->fx_r_type, insn);
	}
      break;

    case BFD_RELOC_NANOMIPS_NEG12:
      if (fixP->fx_done)
	{
	  insn = read_reloc_insn (buf, fixP->fx_r_type);
	  insn |= (-*valP) & 0xfff;
	  write_reloc_insn (buf, fixP->fx_r_type, insn);
	}
      break;

    case BFD_RELOC_NANOMIPS_IMM16:
      if (fixP->fx_done)
	{
	  insn = read_reloc_insn (buf, fixP->fx_r_type);
	  insn |= *valP & 0xffff;
	  write_reloc_insn (buf, fixP->fx_r_type, insn);
	}
      break;

    case BFD_RELOC_NANOMIPS_PC_I32:
    case BFD_RELOC_NANOMIPS_PCREL_HI20:
    case BFD_RELOC_NANOMIPS_GOTPC_I32:
    case BFD_RELOC_NANOMIPS_GOTPC_HI20:
      gas_assert (!fixP->fx_done);
      break;

    case BFD_RELOC_NANOMIPS_4_PCREL_S1:
      if (!fixP->fx_done)
	break;
      /* Invariable branches can be fixed up now.  */
      {
	unsigned mask;
	howto = bfd_reloc_type_lookup (stdoutput, fixP->fx_r_type);
	if (!IS_SEXT_UINT (*valP, howto->bitsize + 1))
	  {
	    as_bad_where (fixP->fx_file, fixP->fx_line,
			  _("Fixed relocation overflow"));
	    break;
	  }

	mask = ((1 << howto->bitsize) - 1);
	insn = read_reloc_insn (buf, fixP->fx_r_type);
	insn &= ~howto->dst_mask;
	insn |= ((*valP >> 1) & mask);
	write_reloc_insn (buf, fixP->fx_r_type, insn);

	if (fixP->fx_next)
	  {
	    fixS *fnextP = fixP->fx_next;
	    if (fnextP->fx_frag == fixP->fx_frag
		&& fnextP->fx_where == fixP->fx_where
		&& linkrelax_inhibit_reloc_p(fnextP->fx_r_type))
	      fnextP->fx_done = 1;
	  }
      }
      break;

    case BFD_RELOC_NANOMIPS_7_PCREL_S1:
    case BFD_RELOC_NANOMIPS_10_PCREL_S1:
    case BFD_RELOC_NANOMIPS_11_PCREL_S1:
    case BFD_RELOC_NANOMIPS_14_PCREL_S1:
    case BFD_RELOC_NANOMIPS_21_PCREL_S1:
    case BFD_RELOC_NANOMIPS_25_PCREL_S1:
      if (!fixP->fx_done)
	break;
      /* Invariable branches can be fixed up now.  */
      {
	unsigned mask;
	unsigned int sbit = 0;
	howto = bfd_reloc_type_lookup (stdoutput, fixP->fx_r_type);
	if (!IS_SEXT_INT (*valP, howto->bitsize + 1))
	  {
	    as_bad_where (fixP->fx_file, fixP->fx_line,
			  _("Fixed relocation overflow"));
	    break;
	  }

	mask = ((1 << howto->bitsize) - 1) & ~0x1;
	if ((int)*valP < 0)
	  sbit = 1;
	insn = read_reloc_insn (buf, fixP->fx_r_type);
	insn &= ~howto->dst_mask;
	insn |= (*valP & mask) | sbit;
	write_reloc_insn (buf, fixP->fx_r_type, insn);

	if (fixP->fx_next)
	  {
	    fixS *fnextP = fixP->fx_next;
	    if (fnextP->fx_frag == fixP->fx_frag
		&& fnextP->fx_where == fixP->fx_where
		&& linkrelax_inhibit_reloc_p(fnextP->fx_r_type))
	      fnextP->fx_done = 1;
	  }
      }
      break;

   case BFD_RELOC_VTABLE_INHERIT:
      fixP->fx_done = 0;
      if (fixP->fx_addsy
	  && !S_IS_DEFINED (fixP->fx_addsy)
	  && !S_IS_WEAK (fixP->fx_addsy))
	S_SET_WEAK (fixP->fx_addsy);
      break;

    case BFD_RELOC_VTABLE_ENTRY:
      fixP->fx_done = 0;
      break;

    default:
      abort ();
    }

  /* Remember value for tc_gen_reloc.  */
  fixP->fx_addnumber = *valP;
}

static symbolS *
get_symbol (void)
{
  int c;
  char *name;
  symbolS *p;

  c = get_symbol_name (&name);
  p = (symbolS *) symbol_find_or_make (name);
  (void) restore_line_pointer (c);
  return p;
}

/* Create R_NANOMIPS_ALIGN to record the alignment request.  Value of the
   absolute symbol gives alignment requested.  The relocation is created at
   the start of padding bytes.  Create R_NANOMIPS_FILL and R_NANOMIPS_MAX
   to record fill value and maximum alignment respectively.  */

static void
create_align_relocs (fragS *fragp, int align_to, unsigned int fill_value,
		     int fill_length, int max_fill)
{
  static int symidx = 1;
  symbolS *sym;
  char sname[30];
  fixS *fixp;
  int where;

  if (fragp == frag_now)
    where = frag_now_fix ();
  else
    where = fragp->fr_fix;

  /* The '\2' ensures that no other symbol will get the
     same name as this.  */
  sprintf (sname, "__reloc_align_\2_%d", symidx++);
  sym = symbol_find (sname);
  sym = symbol_new (sname, absolute_section, align_to, &zero_address_frag);
  symbol_table_insert (sym);

  fixp = fix_new (fragp, where, 0, sym, 0, FALSE, BFD_RELOC_NANOMIPS_ALIGN);
  if (fragp->tc_frag_data.first_fix == NULL)
    fragp->tc_frag_data.first_fix = fixp;
  frag_now->tc_frag_data.link_var = TRUE;
  frag_now->tc_frag_data.relax_sop = align_to - 2;
  frag_now->tc_frag_data.relax_sink = align_to - 2;

  /* Generate fill reloc.  Default fill value is micromips nop32.  */
  if (fill_length)
    {
      sprintf (sname, "__reloc_fill_\2_%x", fill_value);
      sym = symbol_find (sname);
      if (sym == NULL)
	{
	  sym = symbol_new (sname, absolute_section, fill_value,
			    &zero_address_frag);
	  symbol_table_insert (sym);
	  elf_symbol (symbol_get_bfdsym (sym))->internal_elf_sym.st_size
	    = fill_length;
	}

      fix_new (fragp, where, 0, sym, 0, FALSE, BFD_RELOC_NANOMIPS_FILL);
    }

  /* Generate max reloc.  */
  if (max_fill != 0)
    {
      sprintf (sname, "__reloc_max_\2_%x", max_fill);
      sym = symbol_find (sname);
      if (sym == NULL)
	{
	  sym = symbol_new (sname, absolute_section, max_fill,
			    &zero_address_frag);
	  symbol_table_insert (sym);
	}

      fix_new (fragp, where, 0, sym, 0, FALSE, BFD_RELOC_NANOMIPS_MAX);
    }
}

/* Align the current frag to a given power of two.  If a particular
   fill byte should be used, FILL points to an integer that contains
   that byte, otherwise FILL is null.  */

static void
nanomips_align (int to, int *fill, struct insn_label_list *labels)
{
  nanomips_flush_pending_output ();
  nanomips_record_compressed_mode ();
  if (fill == NULL && subseg_text_p (now_seg))
    frag_align_code (to, 0);
  else
    frag_align (to, fill ? *fill : 0, 0);
  record_alignment (now_seg, to);
  nanomips_move_labels (labels);
}

/* Align to a given power of two.  .align 0 turns off the automatic
   alignment used by the data creating pseudo-ops.  */

static void
s_align (int x ATTRIBUTE_UNUSED)
{
  int temp, fill_value, *fill_ptr;
  long max_alignment = 28;

  /* Note that the assembler pulls down any immediately preceding label
     to the aligned address. */

  temp = get_absolute_expression ();
  if (temp > max_alignment)
    as_bad (_("alignment too large, %d assumed"), temp = max_alignment);
  else if (temp < 0)
    {
      as_warn (_("alignment negative, 0 assumed"));
      temp = 0;
    }
  if (*input_line_pointer == ',')
    {
      ++input_line_pointer;
      fill_value = get_absolute_expression ();
      fill_ptr = &fill_value;
    }
  else
    fill_ptr = 0;
  if (temp)
    {
      segment_info_type *si = seg_info (now_seg);
      struct insn_label_list *l = si->label_list;

      if (nanomips_opts.linkrelax
	  && (bfd_get_section_flags (stdoutput, now_seg) & SEC_CODE) != 0)
	{
	  int fill_length = 0;

	  if (fill_ptr == NULL && subseg_text_p (now_seg))
	    frag_grow (MAX_MEM_FOR_RS_ALIGN_CODE);
	  else
	    {
	      fill_length = 1;
	      frag_grow (1);
	    }

	  create_align_relocs (frag_now, temp, fill_value, fill_length, 0);
	}

      /* Auto alignment should be switched on by next section change.  */
      auto_align = 1;
      nanomips_align (temp, fill_ptr, l);
    }
  else
    {
      auto_align = 0;
    }

  demand_empty_rest_of_line ();
}

static void
s_change_sec (int sec)
{
  segT seg;

  if ((now_seg->flags & SHF_EXECINSTR) != 0
      && stub_funcless_mode
      && !nanomips_opts.no_balc_stubs
      && stubg_now != NULL)
    {
      stub_funcless_mode = FALSE;
      stubgroup_wane ();
    }

  /* The ELF backend needs to know that we are changing sections, so
     that .previous works correctly.  We could do something like check
     for an obj_section_change_hook macro, but that might be confusing
     as it would not be appropriate to use it in the section changing
     functions in read.c, since obj-elf.c intercepts those.  FIXME:
     This should be cleaner, somehow.  */
  obj_elf_section_change_hook ();

  nanomips_flush_pending_output ();

  switch (sec)
    {
    case 't':
      s_text (0);
      break;
    case 'd':
      s_data (0);
      break;
    case 'b':
      subseg_set (bss_section, (subsegT) get_absolute_expression ());
      demand_empty_rest_of_line ();
      break;

    case 'r':
      seg = subseg_new (RDATA_SECTION_NAME,
			(subsegT) get_absolute_expression ());
      bfd_set_section_flags (stdoutput, seg, (SEC_ALLOC | SEC_LOAD
					      | SEC_READONLY | SEC_RELOC
					      | SEC_DATA));
      if (strncmp (TARGET_OS, "elf", 3) != 0)
	record_alignment (seg, 4);
      demand_empty_rest_of_line ();
      break;

    case 's':
      seg = subseg_new (".sdata", (subsegT) get_absolute_expression ());
      bfd_set_section_flags (stdoutput, seg,
			     SEC_ALLOC | SEC_LOAD | SEC_RELOC | SEC_DATA);
      if (strncmp (TARGET_OS, "elf", 3) != 0)
	record_alignment (seg, 4);
      demand_empty_rest_of_line ();
      break;

    case 'B':
      seg = subseg_new (".sbss", (subsegT) get_absolute_expression ());
      bfd_set_section_flags (stdoutput, seg, SEC_ALLOC);
      if (strncmp (TARGET_OS, "elf", 3) != 0)
	record_alignment (seg, 4);
      demand_empty_rest_of_line ();
      break;
    }

  auto_align = 1;
}

void
s_change_section (int ignore ATTRIBUTE_UNUSED)
{
  char *saved_ilp;
  char *section_name;
  char c, endc;
  char next_c = 0;
  int section_type;
  int section_flag;
  int section_entry_size;
  int section_alignment;

  saved_ilp = input_line_pointer;
  endc = get_symbol_name (&section_name);
  c = (endc == '"' ? input_line_pointer[1] : endc);
  if (c)
    next_c = input_line_pointer[(endc == '"' ? 2 : 1)];

  if ((now_seg->flags & SHF_EXECINSTR) != 0
      && stub_funcless_mode
      && !nanomips_opts.no_balc_stubs
      && stubg_now != NULL)
    {
      stub_funcless_mode = FALSE;
      stubgroup_wane ();
    }

  /* Do we have .section Name<,"flags">?  */
  if (c != ',' || (c == ',' && next_c == '"'))
    {
      /* Just after name is now '\0'.  */
      (void) restore_line_pointer (endc);
      input_line_pointer = saved_ilp;
      obj_elf_section (ignore);
      return;
    }
  input_line_pointer++;

  /* Do we have .section Name<,type><,flag><,entry_size><,alignment>  */
  if (c == ',')
    section_type = get_absolute_expression ();
  else
    section_type = 0;
  if (*input_line_pointer++ == ',')
    section_flag = get_absolute_expression ();
  else
    section_flag = 0;
  if (*input_line_pointer++ == ',')
    section_entry_size = get_absolute_expression ();
  else
    section_entry_size = 0;
  if (*input_line_pointer++ == ',')
    section_alignment = get_absolute_expression ();
  else
    section_alignment = 0;
  /* FIXME: really ignore?  */
  (void) section_alignment;

  section_name = xstrdup (section_name);

  if ((now_seg->flags & SHF_EXECINSTR) != 0
      && stub_funcless_mode
      && !nanomips_opts.no_balc_stubs
      && stubg_now != NULL)
    {
      stub_funcless_mode = FALSE;
      stubgroup_wane ();
    }

  obj_elf_change_section (section_name, section_type, 0, section_flag,
			  section_entry_size, 0, 0, 0);

  if (now_seg->name != section_name)
    free (section_name);
}

void
nanomips_enable_auto_align (void)
{
  auto_align = 1;
}

static void
s_cons (int log_size)
{
  segment_info_type *si = seg_info (now_seg);
  struct insn_label_list *l = si->label_list;

  nanomips_flush_pending_output ();
  if (log_size > 0 && auto_align)
    nanomips_align (log_size, 0, l);
  cons (1 << log_size);
  nanomips_clear_insn_labels ();
}

static void
s_sign_cons (int log_size)
{
  sign_cons = TRUE;
  s_cons (log_size);
  sign_cons = FALSE;
}

static void
s_float_cons (int type)
{
  segment_info_type *si = seg_info (now_seg);
  struct insn_label_list *l = si->label_list;

  nanomips_flush_pending_output ();

  if (auto_align)
    {
      if (type == 'd')
	nanomips_align (3, 0, l);
      else
	nanomips_align (2, 0, l);
    }

  float_cons (type);
  nanomips_clear_insn_labels ();
}

/* Handle .globl.  We need to override it because on Irix 5 you are
   permitted to say
       .globl foo .text
   where foo is an undefined symbol, to mean that foo should be
   considered to be the address of a function.  */

static void
s_nanomips_globl (int x ATTRIBUTE_UNUSED)
{
  char *name;
  int c;
  symbolS *symbolP;
  flagword flag;

  do
    {
      c = get_symbol_name (&name);
      symbolP = symbol_find_or_make (name);
      S_SET_EXTERNAL (symbolP);

      *input_line_pointer = c;
      SKIP_WHITESPACE_AFTER_NAME ();

      flag = BSF_OBJECT;

      if (!is_end_of_line[(unsigned char) *input_line_pointer]
	  && (*input_line_pointer != ','))
	{
	  char *secname;
	  asection *sec;

	  c = get_symbol_name (&secname);
	  sec = bfd_get_section_by_name (stdoutput, secname);
	  if (sec == NULL)
	    as_bad (_("%s: no such section"), secname);
	  (void) restore_line_pointer (c);

	  if (sec != NULL && (sec->flags & SEC_CODE) != 0)
	    flag = BSF_FUNCTION;
	}

      symbol_get_bfdsym (symbolP)->flags |= flag;

      c = *input_line_pointer;
      if (c == ',')
	{
	  input_line_pointer++;
	  SKIP_WHITESPACE ();
	  if (is_end_of_line[(unsigned char) *input_line_pointer])
	    c = '\n';
	}
    }
  while (c == ',');

  demand_empty_rest_of_line ();
}

/* Parse the .sleb128 and .uleb128 pseudos.  Only allow constant expressions,
   since these directives break relaxation when used with symbol deltas.  */

static void
s_nanomips_leb128 (int sign)
{
  expressionS exp;
  char *save_in = input_line_pointer;

  expression (&exp);
  if (exp.X_op != O_constant)
    as_bad (_("non-constant .%cleb128 is not supported"), sign ? 's' : 'u');
  demand_empty_rest_of_line ();

  input_line_pointer = save_in;
  return s_leb128 (sign);
}

/* This structure is used to hold a stack of .set values.  */

struct nanomips_option_stack
{
  struct nanomips_option_stack *next;
  struct nanomips_set_options options;
};

static struct nanomips_option_stack *nanomips_opts_stack;

static bfd_boolean
parse_code_option (char *name)
{
  const struct nanomips_ase *ase;
  if (strncmp (name, "at=", 3) == 0)
    {
      char *s = name + 3;

      if (!reg_lookup (&s, RTYPE_NUM | RTYPE_GP, &nanomips_opts.at))
	as_bad (_("unrecognized register name `%s'"), s);
    }
  else if (strcmp (name, "at") == 0)
    nanomips_opts.at = ATREG;
  else if (strcmp (name, "noat") == 0)
    nanomips_opts.at = ZERO;
  else if (strcmp (name, "softfloat") == 0)
    nanomips_opts.soft_float = 1;
  else if (strcmp (name, "hardfloat") == 0)
    nanomips_opts.soft_float = 0;
  else if (strcmp (name, "singlefloat") == 0)
    nanomips_opts.single_float = 1;
  else if (strcmp (name, "doublefloat") == 0)
    nanomips_opts.single_float = 0;
  else if (strcmp (name, "nooddspreg") == 0)
    as_bad (_("nanoMIPS allows odd single-precision FP registers"));
  else if (strcmp (name, "mips16") == 0 || strcmp (name, "MIPS-16") == 0)
    as_bad (_("nanoMIPS does not support MIPS16 ASE"));
  else if (strcmp (name, "micromips") == 0)
    as_bad (_("micromips is incompatible with nanoMIPS"));
  else if (name[0] == 'n'
	   && name[1] == 'o'
	   && (ase = nanomips_lookup_ase (name + 2)))
    nanomips_set_ase (ase, &nanomips_opts, FALSE);
  else if ((ase = nanomips_lookup_ase (name)))
    nanomips_set_ase (ase, &nanomips_opts, TRUE);
  else if (strncmp (name, "mips", 4) == 0)
    as_bad (_("cannot change ISA from nanoMIPS to %s"), name);
  else if (strncmp (name, "arch=mips", 9) == 0)
    as_bad (_("cannot change ISA from nanoMIPS to %s"), name + 5);
  else if (strncmp (name, "arch=", 5) == 0)
    {
      /* Permit the user to change the ISA and architecture on the fly.
         Needless to say, misuse can cause serious problems.  */
      const struct nanomips_cpu_info *p;

      p = nanomips_parse_cpu ("internal use", name + 5);
      if (!p)
	as_bad (_("unknown architecture %s"), name + 5);
      else
	{
	  nanomips_opts.arch = p->cpu;
	  nanomips_opts.isa = p->isa;
	  nanomips_opts.init_ase = p->ase;
	}
    }
  else if (strcmp (name, "insn32") == 0)
    nanomips_opts.insn32 = TRUE;
  else if (strcmp (name, "noinsn32") == 0)
    nanomips_opts.insn32 = FALSE;
  else if (strncmp (name, "mcmodel=", 8) == 0)
    {
      if (strcmp (name + 8, "auto") == 0)
	nanomips_opts.mc_model = MC_AUTO;
      else if (strcmp (name + 8, "medium") == 0)
	nanomips_opts.mc_model = MC_MEDIUM;
      else if (strcmp (name + 8, "large") == 0)
	nanomips_opts.mc_model = MC_LARGE;
      else
	as_bad (_("invalid memory model setting %s"), name);
    }
  else if (strncmp (name, "pic", 3) == 0)
    {
      int i = atoi (name + 3);
      if (i == 0)
	nanomips_opts.pic = NO_PIC;
      else if (i == 1)
	nanomips_opts.pic = SVR4_PIC;
      else if (i == 2)
	nanomips_opts.pic = SVR4_LARGE_PIC;
      else
	as_bad (_(".set pic%d not supported"), i);
    }
  else if (strcmp (name, "nopic") == 0)
    nanomips_opts.pic = NO_PIC;
  else if (strcmp (name, "pid") == 0)
    nanomips_opts.pid = TRUE;
  else if (strcmp (name, "nopic") == 0)
    nanomips_opts.pid = FALSE;
  else if (strcmp (name, "pcrel") == 0)
    nanomips_opts.pcrel = TRUE;
  else if (strcmp (name, "nopcrel") == 0)
    nanomips_opts.pcrel = FALSE;
  else
    return (strcmp (name, "oddspreg") == 0
	    || strcmp (name, "nomips16") == 0
	    || strcmp (name, "noMIPS-16") == 0
	    || strcmp (name, "nomicromips") == 0
	    || strcmp (name, "nobopt") == 0
	    || strcmp (name, "noforbidden-slots") == 0
	    || strcmp (name, "move") == 0
	    || strcmp (name, "nomove") == 0
	    || strcmp (name, "novolatile") == 0
	    || strcmp (name, "volatile") == 0);

  return TRUE;
}

/* Handle the .set pseudo-op.  */

static void
s_nanomipsset (int x ATTRIBUTE_UNUSED)
{
  char *name = input_line_pointer, ch;
  int prev_isa = nanomips_opts.isa;

  file_check_options ();

  while (!is_end_of_line[(unsigned char) *input_line_pointer])
    ++input_line_pointer;
  ch = *input_line_pointer;
  *input_line_pointer = '\0';

  if (strchr (name, ','))
    {
      /* Generic ".set" directive; use the generic handler.  */
      *input_line_pointer = ch;
      input_line_pointer = name;
      s_set (0);
      return;
    }

  if (strcmp (name, "reorder") == 0)
    {
      if (nanomips_opts.noreorder)
	end_noreorder ();
    }
  else if (strcmp (name, "noreorder") == 0)
    {
      if (!nanomips_opts.noreorder)
	start_noreorder ();
    }
  else if (strcmp (name, "macro") == 0)
    nanomips_opts.nomacro = 0;
  else if (strcmp (name, "nomacro") == 0)
    nanomips_opts.nomacro = 1;
  else if (strcmp (name, "arch=default") == 0)
    {
      nanomips_opts.isa = file_nanomips_opts.isa;
      nanomips_opts.arch = file_nanomips_opts.arch;
      nanomips_opts.init_ase = file_nanomips_opts.init_ase;
      nanomips_opts.gp = file_nanomips_opts.gp;
      nanomips_opts.fp = file_nanomips_opts.fp;
    }
  else if (strcmp (name, "push") == 0)
    {
      struct nanomips_option_stack *s;

      s = (struct nanomips_option_stack *) xmalloc (sizeof *s);
      s->next = nanomips_opts_stack;
      s->options = nanomips_opts;
      nanomips_opts_stack = s;
    }
  else if (strcmp (name, "pop") == 0)
    {
      struct nanomips_option_stack *s;

      s = nanomips_opts_stack;
      if (s == NULL)
	as_bad (_(".set pop with no .set push"));
      else
	{
	  /* If we're changing the reorder mode we need to handle
	     delay slots correctly.  */
	  if (s->options.noreorder && !nanomips_opts.noreorder)
	    start_noreorder ();
	  else if (!s->options.noreorder && nanomips_opts.noreorder)
	    end_noreorder ();

	  if (s->options.linkrelax != nanomips_opts.linkrelax)
	    {
	      toggle_linkrelax_p = TRUE;
	      s->options.linkrelax = nanomips_opts.linkrelax;
	    }

	  nanomips_opts = s->options;
	  nanomips_opts_stack = s->next;
	  free (s);
	}
    }
  else if (strcmp (name, "nolinkrelax") == 0)
    toggle_linkrelax_p = (linkrelax && nanomips_opts.linkrelax);
  else if (strcmp (name, "linkrelax") == 0)
    toggle_linkrelax_p = (linkrelax && !nanomips_opts.linkrelax);
  else if (strcmp (name, "legacyregs") == 0)
    nanomips_opts.legacyregs = TRUE;
  else if (strcmp (name, "nolegacyregs") == 0)
    nanomips_opts.legacyregs = FALSE;
  else if (!parse_code_option (name))
    as_warn (_("tried to set unrecognized symbol: %s\n"), name);

  /* The use of .set [arch|cpu]= historically 'fixes' the width of gp and fp
     registers based on what is supported by the arch/cpu.  */
  if (nanomips_opts.isa != prev_isa)
    {
      switch (nanomips_opts.isa)
	{
	case 0:
	  break;
	case ISA_NANOMIPS32R6:
	  nanomips_opts.gp = 32;
	  nanomips_opts.fp = 64;
	  break;
	case ISA_NANOMIPS64R6:
	  nanomips_opts.gp = 64;
	  nanomips_opts.fp = 64;
	  break;
	default:
	  as_bad (_("unknown ISA level %s"), name + 4);
	  break;
	}
    }

  nanomips_check_isa_supports_ases ();
  *input_line_pointer = ch;
  demand_empty_rest_of_line ();
}

/* Handle the .module pseudo-op.  */

static void
s_module (int ignore ATTRIBUTE_UNUSED)
{
  char *name = input_line_pointer, ch;

  while (!is_end_of_line[(unsigned char) *input_line_pointer])
    ++input_line_pointer;
  ch = *input_line_pointer;
  *input_line_pointer = '\0';

  if (!file_nanomips_opts_checked)
    {
      if (!parse_code_option (name))
	as_bad (_(".module used with unrecognized symbol: %s\n"), name);

      /* Update module level settings from nanomips_opts.  */
      file_nanomips_opts = nanomips_opts;
    }
  else
    as_bad (_(".module is not permitted after generating code"));

  *input_line_pointer = ch;
  demand_empty_rest_of_line ();
}

/* Handle the .cpsetup pseudo-op defined for NewABI PIC code.  The syntax is:
     .cpsetup $reg1, offset|$reg2, label

   If offset is given, this results in:
     sd		$gp, offset($sp)
     lui	$gp, %hi(%neg(%gp_rel(label)))
     addiu	$gp, $gp, %lo(%neg(%gp_rel(label)))
     daddu	$gp, $gp, $reg1

   If $reg2 is given, this results in:
     or		$reg2, $gp, $0
     lui	$gp, %hi(%neg(%gp_rel(label)))
     addiu	$gp, $gp, %lo(%neg(%gp_rel(label)))
     daddu	$gp, $gp, $reg1
   $reg1 is normally $25 == $t9.

   The -mno-shared option replaces the last three instructions with
	lui	$gp,%hi(_gp)
	addiu	$gp,$gp,%lo(_gp)  */

static void
s_cpsetup (int ignore ATTRIBUTE_UNUSED)
{
  expressionS ex;
  file_check_options ();

  /* If we are not generating SVR4 PIC code, .cpsetup is ignored.  */
  if (nanomips_opts.pic == NO_PIC)
    {
      s_ignore (0);
      return;
    }

  ex.X_op = O_symbol;
  ex.X_add_symbol = symbol_find_or_make ("_gp");
  ex.X_op_symbol = NULL;
  ex.X_add_number = 0;
  symbol_get_bfdsym (ex.X_add_symbol)->flags |= BSF_OBJECT;

  nanomips_assembling_insn = TRUE;
  macro_start ();

  macro_build (&ex, "aluipc", "t,mK", nanomips_gp_register,
	       BFD_RELOC_NANOMIPS_PCREL_HI20);

  macro_end (TRUE);
  nanomips_assembling_insn = FALSE;
  ignore_rest_of_line ();

  return;
}

/* Handle a .dtprelword, .dtpreldword, .tprelword, or .tpreldword
   pseudo-op; DIRSTR says which. The pseudo-op generates a BYTES-size
   DTP- or TP-relative relocation of type RTYPE, for use in DWARF
   debug information.  */

static void
s_tls_rel_directive (const size_t bytes, const char *dirstr,
		     bfd_reloc_code_real_type rtype)
{
  expressionS ex;
  char *p;

  expression (&ex);

  if (ex.X_op != O_symbol)
    {
      as_bad (_("unsupported use of %s"), dirstr);
      ignore_rest_of_line ();
    }

  p = frag_more (bytes);
  md_number_to_chars (p, 0, bytes);
  fix_new_exp (frag_now, p - frag_now->fr_literal, bytes, &ex, FALSE, rtype);
  demand_empty_rest_of_line ();
  nanomips_clear_insn_labels ();
}

/* Handle .dtprelword.  */

static void
s_dtprelword (int ignore ATTRIBUTE_UNUSED)
{
  s_tls_rel_directive (4, ".dtprelword", BFD_RELOC_NANOMIPS_TLS_DTPREL);
}

/* Handle .dtpreldword.  */

static void
s_dtpreldword (int ignore ATTRIBUTE_UNUSED)
{
  s_tls_rel_directive (8, ".dtpreldword", BFD_RELOC_NANOMIPS_TLS_DTPREL);
}

/* Handle .tprelword.  */

static void
s_tprelword (int ignore ATTRIBUTE_UNUSED)
{
  s_tls_rel_directive (4, ".tprelword", BFD_RELOC_NANOMIPS_TLS_TPREL);
}

/* Handle .tpreldword.  */

static void
s_tpreldword (int ignore ATTRIBUTE_UNUSED)
{
  s_tls_rel_directive (8, ".tpreldword", BFD_RELOC_NANOMIPS_TLS_TPREL);
}

/* Handle the .ehword pseudo-op.  This is used when generating unwinding
   tables.  It generates a PC32 reloc.  */

static void
s_ehword (int ignore ATTRIBUTE_UNUSED)
{
  expressionS ex;
  char *p;

  nanomips_flush_pending_output ();

  expression (&ex);
  nanomips_clear_insn_labels ();

  if (ex.X_op != O_symbol || ex.X_add_number != 0)
    {
      as_bad (_("unsupported use of .ehword"));
      ignore_rest_of_line ();
    }

  p = frag_more (4);
  md_number_to_chars (p, 0, 4);
  fix_new_exp (frag_now, p - frag_now->fr_literal, 4, &ex, FALSE,
	       BFD_RELOC_32_PCREL);

  demand_empty_rest_of_line ();
}

/* Handle the .insn pseudo-op, retained for compatibility.  */

static void
s_insn (int ignore ATTRIBUTE_UNUSED)
{
  demand_empty_rest_of_line ();
}

/* Handle a .stab[snd] directive.  Ideally these directives would be
   implemented in a transparent way, so that removing them would not
   have any effect on the generated instructions.  However, s_stab
   internally changes the section, so in practice we need to decide
   now whether the preceding label marks compressed code.  We do not
   support changing the compression mode of a label after a .stab*
   directive, such as in:

   foo:
	.stabs ...
	.set mips16

   so the current mode wins.  */

static void
s_nanomips_stab (int type)
{
  s_stab (type);
}

/* Handle the .weakext pseudo-op as defined in Kane and Heinrich.  */

static void
s_nanomips_weakext (int ignore ATTRIBUTE_UNUSED)
{
  char *name;
  int c;
  symbolS *symbolP;
  expressionS exp;

  c = get_symbol_name (&name);
  symbolP = symbol_find_or_make (name);
  S_SET_WEAK (symbolP);
  *input_line_pointer = c;

  SKIP_WHITESPACE_AFTER_NAME ();

  if (!is_end_of_line[(unsigned char) *input_line_pointer])
    {
      if (S_IS_DEFINED (symbolP))
	{
	  as_bad (_("ignoring attempt to redefine symbol %s"),
		  S_GET_NAME (symbolP));
	  ignore_rest_of_line ();
	  return;
	}

      if (*input_line_pointer == ',')
	{
	  ++input_line_pointer;
	  SKIP_WHITESPACE ();
	}

      expression (&exp);
      if (exp.X_op != O_symbol)
	{
	  as_bad (_("bad .weakext directive"));
	  ignore_rest_of_line ();
	  return;
	}
      symbol_set_value_expression (symbolP, &exp);
    }

  demand_empty_rest_of_line ();
}

/* Parse a register string into a number.  Called from the ECOFF code
   to parse .frame.  The argument is non-zero if this is the frame
   register, so that we can record it in nanomips_frame_reg.  */

int
tc_get_register (int frame ATTRIBUTE_UNUSED)
{
  unsigned int reg;

  SKIP_WHITESPACE ();
  if (!reg_lookup (&input_line_pointer, RWARN | RTYPE_NUM | RTYPE_GP, &reg))
    reg = 0;

  return reg;
}

valueT
md_section_align (asection *seg, valueT addr)
{
  unsigned int align = bfd_get_section_alignment (stdoutput, seg);

  /* We don't need to align ELF sections to the full alignment.
     However, Irix 5 may prefer that we align them at least to a 16
     byte boundary.  We don't bother to align the sections if we
     are targeted for an embedded system.  */
  if (strncmp (TARGET_OS, "elf", 3) == 0)
    return addr;
  if (align > 4)
    align = 4;

  return ((addr + (1 << align) - 1) & -(1 << align));
}

/* Utility routine, called from above as well.  If called while the
   input file is still being read, it's only an approximation.  (For
   example, a symbol may later become defined which appeared to be
   undefined earlier.)  */

static int
nopic_need_relax (symbolS *sym, int before_relaxing)
{
  if (sym == 0)
    return 0;

  if (g_switch_value > 0)
    {
      const char *symname;
      int change;

      /* Find out whether this symbol can be referenced off the $gp
         register.  It can be if it is smaller than the -G size or if
         it is in the .sdata or .sbss section.  Certain symbols can
         not be referenced off the $gp, although it appears as though
         they can.  */
      symname = S_GET_NAME (sym);
      if (symname != (const char *) NULL
	  && (strcmp (symname, "eprol") == 0
	      || strcmp (symname, "etext") == 0
	      || strcmp (symname, "_gp") == 0
	      || strcmp (symname, "edata") == 0
	      || strcmp (symname, "_fbss") == 0
	      || strcmp (symname, "_fdata") == 0
	      || strcmp (symname, "_ftext") == 0
	      || strcmp (symname, "end") == 0
	      || strcmp (symname, "_gp_disp") == 0))
	change = 1;
      else if ((! S_IS_DEFINED (sym) || S_IS_COMMON (sym))
	       && (0
#ifndef NO_ECOFF_DEBUGGING
		   || (symbol_get_obj (sym)->ecoff_extern_size != 0
		       && (symbol_get_obj (sym)->ecoff_extern_size
			   <= g_switch_value))
#endif
		   /* We must defer this decision until after the whole
		      file has been read, since there might be a .extern
		      after the first use of this symbol.  */
		   || (before_relaxing
#ifndef NO_ECOFF_DEBUGGING
		       && symbol_get_obj (sym)->ecoff_extern_size == 0
#endif
		       && S_GET_VALUE (sym) == 0)
		   || (S_GET_VALUE (sym) != 0
		       && S_GET_VALUE (sym) <= g_switch_value)))
	change = 0;
      else
	{
	  const char *segname;

	  segname = segment_name (S_GET_SEGMENT (sym));
	  change = (strcmp (segname, ".sdata") != 0
		    && strcmp (segname, ".sbss") != 0
		    && strncmp (segname, ".sdata.", 7) != 0
		    && strncmp (segname, ".sbss.", 6) != 0
		    && strncmp (segname, ".gnu.linkonce.sb.", 17) != 0
		    && strncmp (segname, ".gnu.linkonce.s.", 16) != 0);
	}
      return change;
    }
  else
    /* We are not optimizing for the $gp register.  */
    return 1;
}

/* Return true if the given symbol should be considered local for SVR4 PIC.  */

static bfd_boolean
pic_need_relax (symbolS *sym, asection *segtype)
{
  asection *symsec;

  if (nanomips_opts.mc_model == MC_AUTO && linkrelax)
    return FALSE;

  /* Handle the case of a symbol equated to another symbol.  */
  while (symbol_equated_reloc_p (sym))
    {
      symbolS *n;

      /* It's possible to get a loop here in a badly written program.  */
      n = symbol_get_value_expression (sym)->X_add_symbol;
      if (n == sym)
	break;
      sym = n;
    }

  if (symbol_section_p (sym))
    return TRUE;

  symsec = S_GET_SEGMENT (sym);

  /* This must duplicate the test in adjust_reloc_syms.  */
  return (!bfd_is_und_section (symsec)
	  && !bfd_is_abs_section (symsec)
	  && !bfd_is_com_section (symsec)
	  && !s_is_linkonce (sym, segtype)
	  /* A global or weak symbol is treated as external.  */
	  && (!S_IS_WEAK (sym) && !S_IS_EXTERNAL (sym)));
}

/* Check if relocation in HEAD refers to an address immediately following
   instruction in an adjacent frag.  16-bit conditional branches cannot
   reach the immediate next instruction and must be relaxed.  */
static bfd_boolean
nanomips_frag_match (fragS *head, fragS *matchP)
{
  bfd_vma val = S_GET_VALUE (head->fr_symbol);

  /* Typically, a match is as easy as checking that the frags are adjacent
     and the symbol refered to is at the very beginning of the target frag.  */
  if (matchP == head->fr_next && val == matchP->fr_address)
    return TRUE;

  /* The tricky part: when doing assembly listings all sorts of fillers are
     generated between what would be adjacent frags.  So we need to look
     through the frag list, until we come to a non-empty frag that either
     matches or exceeds our target.  */
  if (listing)
    {
      head = head->fr_next;
      while (head && head != matchP && head->fr_fix + head->fr_var == 0)
	{
	  /* Unlikely, but just in case we came too far, bail out!  */
	  if (head->fr_line > matchP->fr_line)
	    break;
	  else
	    head = head->fr_next;
	}

      return (head == matchP);
    }

  return FALSE;
}

/* Get the number of bytes a link-time relaxation can add to this
   subtype of FRAGP.  The subtype maps to a BFD relocation and that
   combined with it toofar16 flag is used to determine the sop.  */

static bfd_vma
frag_subtype_to_relax_sop (relax_substateT fr_subtype)
{
  enum relax_nanomips_subtype rt = RELAX_NANOMIPS_TYPE (fr_subtype);
  bfd_boolean toofar16 = RELAX_NANOMIPS_TOOFAR16 (fr_subtype);
  return (get_reloc_sop (frag_subtype_to_reloc (rt, toofar16)));
}

/* Check if the OFFSET is within the range of the branch relocation
   for this frag subtype.  */

static bfd_boolean
branch_in_range (relax_substateT fr_subtype, bfd_signed_vma offset)
{
  bfd_reloc_code_real_type rtype;
  bfd_signed_vma min_val = 0;
  bfd_signed_vma max_val = 0;
  reloc_howto_type *howto = NULL;

  rtype = frag_subtype_to_reloc (RELAX_NANOMIPS_TYPE (fr_subtype),
				 RELAX_NANOMIPS_TOOFAR16 (fr_subtype));

  switch (rtype)
    {
      case BFD_RELOC_NANOMIPS_4_PCREL_S1:
	/* This type only allows limited unsigned offset.  */
	min_val = 2;
	max_val = 30;
	break;
      default:
	/* All other branches are signed. The relocation howto
	   provides the necessary information, so we don't
	   need to enumerate each one.  */
	howto = bfd_reloc_type_lookup (stdoutput, rtype);
	if (howto)
	  {
	    max_val = (1 << howto->bitsize) - 1;
	    min_val = -max_val - 1;
	  }
	break;
    }

  return (offset >= min_val && offset <= max_val);
}

/* Check if ADDR is within the fixed part of FRAG.  */
static bfd_boolean
addr_in_frag_range (fragS *fragp, addressT addr)
{
  return (addr >= fragp->fr_address
	  && addr <= fragp->fr_address + fragp->fr_fix);
}

/* Check if the branch at FRAGP is already marked as variable.  */
static bfd_boolean
variable_frag_p (fragS *fragp)
{
  return (fragp->tc_frag_data.link_var
	  || (RELAX_NANOMIPS_P (fragp->fr_subtype)
	      && RELAX_NANOMIPS_VARIABLE (fragp->fr_subtype)));
}

/* Check if the branch at FRAGP is link-time invariable and mark it.  */

static bfd_boolean
relaxed_nanomips_invariable_branch_p (fragS *fragp, asection *sec)
{
  addressT addr;
  fragS *nfrag;
  fragS *pfrag = NULL;
  bfd_boolean fixed_p = FALSE;
  bfd_boolean variable_p = FALSE;
  bfd_signed_vma max_offset = 0;
  bfd_signed_vma min_offset = 0;

  gas_assert (fragp != NULL);

  /* Don't bother  */
  if (!nanomips_opts.minimize_relocs
      || RELAX_NANOMIPS_ADDIU_P (fragp->fr_subtype))
    return TRUE;

  /* Trivially mark branches to external symbols as unfixable.  */
  if (fragp->fr_symbol &&
      (S_IS_DEFINED (fragp->fr_symbol) || !S_IS_LOCAL (fragp->fr_symbol))
      && !S_IS_WEAK (fragp->fr_symbol)
      && sec != S_GET_SEGMENT (fragp->fr_symbol))
    {
      if (!RELAX_NANOMIPS_NORELAX (fragp->fr_subtype))
	{
	  fragp->fr_subtype = RELAX_NANOMIPS_MARK_VARIABLE
	    (fragp->fr_subtype);
	  /* External reference will not change over multiple iterations.
	     We can calculate the sop once and store it to short-circuit
	     repeated look-ups below.  */
	  fragp->tc_frag_data.link_var = TRUE;
	  fragp->tc_frag_data.relax_sop
	    += frag_subtype_to_relax_sop (fragp->fr_subtype);
	  fragp->tc_frag_data.relax_sink = fragp->fr_var;

	}
      return FALSE;
    }

  addr = S_GET_VALUE (fragp->fr_symbol);
  max_offset = addr - fragp->fr_address - fragp->fr_fix;
  /* Adjust for next PC.  */
  if (RELAX_NANOMIPS_TYPE (fragp->fr_subtype) >= RT_BRANCH_UCND
      && !RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
    max_offset -= 2;
  else
    max_offset -= fragp->fr_var;
  min_offset = max_offset;

  /* Branching to a location within this frag.  */
  if (addr_in_frag_range (fragp, addr))
    variable_p = fragp->tc_frag_data.link_var;
  /* Branching ahead - this needs extra care.  */
  else if (addr > fragp->fr_address + fragp->fr_fix)
    {
      fragS *ifrag = fragp->fr_next;
      nfrag = symbol_get_frag (fragp->fr_symbol);
      while (ifrag && ifrag != nfrag->fr_next)
      {
	  if (ifrag->tc_frag_data.link_var
	      /* If destination address is the beginning of a frag, then
		 its variability does not affect the branch.  */
	      && addr > ifrag->fr_address)
	    {
	      max_offset += ifrag->tc_frag_data.relax_sop;
	      min_offset -= ifrag->tc_frag_data.relax_sink;
	      variable_p = TRUE;
	    }
	  else if (RELAX_NANOMIPS_P (ifrag->fr_subtype)
		   && RELAX_NANOMIPS_VARIABLE (ifrag->fr_subtype)
		   /* If destination address is the fixed part of the
		      frag and that fixed part has no relocations, then
		      relaxation of this frag will not affect the branch.  */
		   && addr > ifrag->fr_address + ifrag->fr_fix)
	    {
	      max_offset += frag_subtype_to_relax_sop (ifrag->fr_subtype);
	      min_offset -= ifrag->fr_var;
	      variable_p = TRUE;
	    }
	  ifrag = ifrag->fr_next;
      }
    }
  /* Branching back - bit simpler.  */
  else
    {
      fragS *ifrag;
      pfrag = symbol_get_frag (fragp->fr_symbol);
      ifrag = pfrag;
      while (ifrag && ifrag != fragp)
	{
	  if (ifrag->tc_frag_data.link_var)
	    {
	      max_offset -= ifrag->tc_frag_data.relax_sop;
	      min_offset += ifrag->tc_frag_data.relax_sink;
	      variable_p = TRUE;
	    }
	  else if (RELAX_NANOMIPS_P (ifrag->fr_subtype)
		   && RELAX_NANOMIPS_VARIABLE (ifrag->fr_subtype))
	    {
	      max_offset -= frag_subtype_to_relax_sop (ifrag->fr_subtype);
	      min_offset += ifrag->fr_var;
	      variable_p = TRUE;
	    }
	  ifrag = ifrag->fr_next;
	}
    }

  /* If there are no intervening variable frags and the cumulative sop is
     within branch range, then this frag is definitively fixed.  */
  fixed_p = (!variable_p
	     && branch_in_range (fragp->fr_subtype, max_offset));
  /* However, it is only definitively variable if there are intervening
     variable frags and their cumulative sop threatens to put this branch
     out of range, or the cumulative sink threatens to put it within range
     of a smaller equivalent branch.  */
  variable_p = (variable_p
		&& !branch_in_range (fragp->fr_subtype, max_offset));
  if (RELAX_NANOMIPS_TYPE (fragp->fr_subtype) >= RT_BRANCH_UCND
      && RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
    variable_p = (!variable_p
		  && branch_in_range (RELAX_NANOMIPS_CLEAR_TOOFAR16
				       (fragp->fr_subtype), min_offset));

  /* If the branch is found to be definitively fixed or variable, mark it
     so, else clear those bits and leave it for future iterations.  Note
     that a branch that is not definitely variable can be assumed to be of a
     fixed size for the purpose of linker relaxation.  Its PC-relative offset
     may change so it still needs a relocation.  However it will never
     expand to a larger sequence due to being out-of-range, and hence will
     not impede other branches leaping over this branch-point from getting
     fixed.  */
  if (fixed_p)
    fragp->fr_subtype = RELAX_NANOMIPS_MARK_FIXED (fragp->fr_subtype);
  else if (variable_p)
    fragp->fr_subtype = RELAX_NANOMIPS_MARK_VARIABLE (fragp->fr_subtype);
  else
    {
      fragp->fr_subtype = RELAX_NANOMIPS_CLEAR_FIXED (fragp->fr_subtype);
      fragp->fr_subtype = RELAX_NANOMIPS_CLEAR_VARIABLE (fragp->fr_subtype);
    }

  return fixed_p;
}

/* Compute the length of a branch, and adjust the RELAX_NANOMIPS_TOOFAR16
   bit accordingly.  */

static int
relaxed_nanomips_16bit_branch_length (fragS *fragp, asection *sec,
				      int update)
{
  bfd_boolean toofar;

  if (fragp
      && fragp->fr_symbol
      && S_IS_DEFINED (fragp->fr_symbol)
      && !S_IS_WEAK (fragp->fr_symbol)
      && sec == S_GET_SEGMENT (fragp->fr_symbol))
    {
      addressT addr;
      offsetT val;
      int type;

      val = S_GET_VALUE (fragp->fr_symbol) + fragp->fr_offset;

      /* Assume this is a 2-byte branch.  */
      addr = fragp->fr_address + fragp->fr_fix + 2;

      /* We try to avoid the infinite loop by not adding 2 more bytes for
	 long branches.  */
      val -= addr;

      type = RELAX_NANOMIPS_TYPE (fragp->fr_subtype);
      if (type == RT_BRANCH_UCND || type == RT_BALC_STUB)
	toofar = val < -(0x200 << 1) || val >= (0x200 << 1);
      else if (type == RT_BRANCH_CNDZ)
	toofar = val < -(0x40 << 1) || val >= (0x40 << 1);
      else if (type == RT_BRANCH_CND)
	toofar = (val <= 0
		  || val > 30
		  || (val == 2
		      && nanomips_frag_match (fragp, symbol_get_frag
					      (fragp->fr_symbol))));
      else
	toofar = TRUE;
    }
  else
    /* If the symbol is not defined or it's in a different segment,
       we emit a normal 32-bit branch.  */
    toofar = TRUE;

  if (fragp && update
      && toofar != RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
    fragp->fr_subtype
      = (toofar
	 ? RELAX_NANOMIPS_MARK_TOOFAR16 (fragp->fr_subtype)
	 : RELAX_NANOMIPS_CLEAR_TOOFAR16 (fragp->fr_subtype));

  if (toofar)
    return 4;

  return 2;
}

/* Compute the length of a call potentially going through a BALC stub
   and adjust the RELAX_NANOMIPS_USESTUB bit accordingly.  */

static int
relaxed_nanomips_stub_call_length (fragS *fragp, asection *sec,
				   bfd_boolean toofar16, bfd_boolean update)
{
  bfd_boolean usestub = FALSE;
  bfd_boolean keepstub = FALSE;
  addressT callsite;
  struct balc_stub *stub = NULL;

  /* Assume this is a 2-byte branch.  */
  callsite = fragp->fr_address + fragp->fr_fix;

  /* Find start of correct stub-group list, if in different section or
     at end of current list.  */
  if ((stubg_now->seg != sec)
      || (stubg_now->prev != NULL
	  && stubg_now->prev->fragp != NULL
	  && callsite < stubg_now->prev->fragp->fr_address))
    stubg_now = hash_find (balc_stubgroup_table, sec->name);

  /* This is for ugly cases of hand-written assembly where the
     order of .ent and .section directives is reversed.  */
  if (stubg_now == NULL || stubg_now->fragp == NULL)
    return (toofar16 ? 4 : 2);

  while (stubg_now->fragp->fr_address + stubg_now->fragp->fr_fix > 0
	 && stubg_now->fragp->fr_address + stubg_now->fragp->fr_fix < callsite)
    if (stubg_now->next != NULL && stubg_now->next->fragp != NULL)
      stubg_now = stubg_now->next;
    else
      break;

  gas_assert (stubg_now->seg == sec);

  usestub = balc_find_stub_inrange (S_GET_NAME (fragp->fr_symbol),
				    callsite, stubg_now, &stub);

  if (usestub && stub->fragp != NULL)
    keepstub = RELAX_NANOMIPS_KEEPSTUB (stub->fragp->fr_subtype);

  /* We need this to happen only once per call frag, but as early as
     possible in the estimation phase, before actual relaxation.  */
  if (usestub && !toofar16)
    {
      usestub = FALSE;
      if (RELAX_NANOMIPS_ONCESTUB (fragp->fr_subtype))
	{
	  fragp->fr_subtype
	    = RELAX_NANOMIPS_CLEAR_ONCESTUB (fragp->fr_subtype);
	  if (callsite == stub->first_call->callsite)
	    stublist_pop_call (stub);
	  else
	    stublist_trunc_calls (stub, callsite);
	}
    }

  /* Only track calls that cannot fit within 16-bit instruction.  */
  if (usestub && toofar16
      && usestub != RELAX_NANOMIPS_ONCESTUB (fragp->fr_subtype))
    {
      stublist_append_call (stub, callsite);
      fragp->fr_subtype = RELAX_NANOMIPS_MARK_ONCESTUB (fragp->fr_subtype);
    }

  if (update && usestub != RELAX_NANOMIPS_USESTUB (fragp->fr_subtype))
    fragp->fr_subtype
      = ((usestub && keepstub)
	 ? RELAX_NANOMIPS_MARK_USESTUB (fragp->fr_subtype)
	 : RELAX_NANOMIPS_CLEAR_USESTUB (fragp->fr_subtype));

  if ((usestub && keepstub) || !toofar16)
    return 2;
  else
    return 4;
}

/* Compute the length of a BALC stub and adjust the RELAX_NANOMIPS_KEEPSTUB
   bit accordingly. If a stub is not to be instantiated, its length is 0.  */
static int
relaxed_nanomips_stub_length (fragS *fragp, asection *sec,
			      bfd_boolean update)
{
  bfd_boolean keepstub = FALSE;
  addressT stubsite;
  struct balc_stub *stub = NULL;

  /* Assume this is a 2-byte branch.  */
  stubsite = fragp->fr_address + fragp->fr_fix;

  if (stubg_now->fragp)
    {
      /* Section change.  */
      if (stubg_now->seg != sec || (stubg_now->fragp->fr_address > stubsite))
	stubg_now = hash_find (balc_stubgroup_table, sec->name);

      while (stubg_now->fragp->fr_address < stubsite)
	if (stubg_now->next && stubg_now->next->fragp
	    && stubg_now->next->fragp->fr_address <= stubsite)
	  stubg_now = stubg_now->next;
	else
	  break;
    }

  gas_assert (stubg_now->seg == sec);

  /* Retain this stub only if it has sufficient associated
     calls and cannot be merged with another elligible stub.  */
  if (balc_in_stub_group (S_GET_NAME (fragp->fr_symbol),
			  stubsite, stubg_now, &stub)
      && stub->numcalls > 0
      && !balc_merge_stub (S_GET_NAME (fragp->fr_symbol),
			   stubg_now, stub)
      && stub->numcalls >= 3)
    keepstub = TRUE;

  if (keepstub != RELAX_NANOMIPS_KEEPSTUB (fragp->fr_subtype))
    {
      if (update)
	fragp->fr_subtype
	  = keepstub ? RELAX_NANOMIPS_MARK_KEEPSTUB (fragp->fr_subtype)
	  : RELAX_NANOMIPS_CLEAR_KEEPSTUB (fragp->fr_subtype);

      stubg_now->next_offset += (keepstub ? 4 : -4);
    }

  if (keepstub)
    return 4;
  else
    {
      /* A stub that is unused right up to the update stage
         can be summarily pruned from the table.  */
      if (update && stub && stub->numcalls == 0)
	xfree (stubtable_delete (stubg_now->stubtable,
				 S_GET_NAME (fragp->fr_symbol), 0));
      return 0;
    }
}

static bfd_boolean
nanomips_gpr3_reg_p (unsigned long reg)
{
  /* Check for membership in set {16, 17, 18, 19, 4, 5, 6, 7}.  */
  return ((reg >> 2 == 1 || reg >> 2 == 4));
}

/* Compute the length of an ADDIU instruction.  */
static int
relaxed_nanomips_addiu_length (fragS *fragp, bfd_boolean update)
{
  char *buf;
  unsigned long insn;
  offsetT sval;
  unsigned long rt, rs;
  bfd_boolean toofar16 = TRUE;
  bfd_boolean negoff = FALSE;

  sval = S_GET_VALUE (fragp->fr_symbol) + fragp->fr_offset;
  buf = fragp->fr_literal + fragp->fr_fix;
  insn = read_compressed_insn (buf, 4);

  rt = EXTRACT_BITS (insn, NANOMIPSOP_MASK_RT, NANOMIPSOP_SH_RT);
  rs = EXTRACT_BITS (insn, NANOMIPSOP_MASK_RS, NANOMIPSOP_SH_RS);

  if (rt == rs
      && sval >= -8
      && sval <= 7
      && !RELAX_NANOMIPS_FIXED (fragp->fr_subtype))
    {
      toofar16 = FALSE;
      negoff = TRUE;
    }
  else if (nanomips_gpr3_reg_p (rs)
	   && nanomips_gpr3_reg_p (rt)
	   && sval >= 0
	   && sval <= 28
	   && sval % 4 == 0
	   && !RELAX_NANOMIPS_FIXED (fragp->fr_subtype))
    toofar16 = FALSE;
  else if (nanomips_gpr3_reg_p (rt)
	   && rs == 0
	   && (int)sval >= -1
	   && (int)sval <= 126
	   && !RELAX_NANOMIPS_FIXED (fragp->fr_subtype))
    toofar16 = FALSE;
  else
    negoff = (sval < 0);

  if (fragp && update
      && toofar16 != RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
    fragp->fr_subtype
      = (toofar16
	 ? RELAX_NANOMIPS_MARK_TOOFAR16 (fragp->fr_subtype)
	 : RELAX_NANOMIPS_CLEAR_TOOFAR16 (fragp->fr_subtype));

  if (fragp && update && negoff != RELAX_NANOMIPS_NEGOFF (fragp->fr_subtype))
    fragp->fr_subtype
      = negoff ? RELAX_NANOMIPS_MARK_NEGOFF (fragp->fr_subtype)
      : RELAX_NANOMIPS_CLEAR_NEGOFF (fragp->fr_subtype);

  if (toofar16)
    return 4;
  else
    return 2;
}

/* Estimate the size of a frag before relaxing.  Unless this is the
   mips16, we are not really relaxing here, and the final size is
   encoded in the subtype information.  For the mips16, we have to
   decide whether we are using an extended opcode or not.  */

int
md_estimate_size_before_relax (fragS *fragp, asection *segtype)
{
  int change;

  if (RELAX_NANOMIPS_P (fragp->fr_subtype))
    {
      int length = fragp->fr_var;

      if (!nanomips_opts.no_balc_stubs
	  && stubg_now != NULL
	  && RELAX_NANOMIPS_BALC_STUB_P (fragp->fr_subtype))
	length = relaxed_nanomips_stub_length (fragp, segtype, FALSE);
      else if (RELAX_NANOMIPS_ADDIU_P (fragp->fr_subtype))
	length = relaxed_nanomips_addiu_length (fragp, FALSE);
      else if (RELAX_NANOMIPS_TYPE (fragp->fr_subtype) >= RT_BRANCH_UCND)
	length = relaxed_nanomips_16bit_branch_length (fragp, segtype, FALSE);

      /* Try to relax 32-bit call through a stub.  */
      if (!nanomips_opts.no_balc_stubs
	  && stubg_now != NULL
	  && RELAX_NANOMIPS_TYPE (fragp->fr_subtype) == RT_BRANCH_UCND
	  && RELAX_NANOMIPS_LINK (fragp->fr_subtype))
	length = relaxed_nanomips_stub_call_length (fragp, segtype,
						    length > 2, FALSE);

      fragp->fr_var = length;
      return length;
    }

  if (nanomips_opts.pic == NO_PIC)
    change = nopic_need_relax (fragp->fr_symbol, 0);
  else if ((nanomips_opts.pic == SVR4_PIC)
	   || (nanomips_opts.pic == SVR4_LARGE_PIC))
    change = pic_need_relax (fragp->fr_symbol, segtype);
  else
    abort ();

  if (change)
    {
      fragp->fr_subtype |= RELAX_USE_SECOND;
      return -RELAX_FIRST (fragp->fr_subtype);
    }
  else
    return -RELAX_SECOND (fragp->fr_subtype);
}

/* This is called to see whether a reloc against a defined symbol
   should be converted into a reloc against a section.  */

int
nanomips_fix_adjustable (fixS *fixp)
{
  asection *tsect;

  if (fixp->fx_r_type == BFD_RELOC_VTABLE_INHERIT
      || fixp->fx_r_type == BFD_RELOC_VTABLE_ENTRY)
    return 0;

  if (fixp->fx_addsy == NULL)
    return 1;

  /* PC relative relocations for need to be symbol rather than section
     relative to allow linker relaxations to be performed later on.  */
  if (pcrel_reloc_p (fixp->fx_r_type)
      && !RELAX_NANOMIPS_FIXED (fixp->fx_frag->fr_subtype))
    return 0;

  /* Relocations to code sections need to be symbol rather than section
     relative for nanoMIPS, to allow linker expansions and relaxations
     without having to adjust addends.  */

  tsect = S_GET_SEGMENT (fixp->fx_addsy);
  if (tsect != NULL
      && (tsect->flags & SEC_CODE) != 0
      && (linkrelax || symbol_used_p (fixp->fx_addsy)))
    return 0;

  return 1;
}

/* Translate internal representation of relocation info to BFD target
   format.  */

arelent **
tc_gen_reloc (asection *section ATTRIBUTE_UNUSED, fixS *fixp)
{
  static arelent *retval[MAX_RELOC_EXPANSION + 1];
  arelent *reloc;
  bfd_reloc_code_real_type code;

  memset (retval, 0, sizeof (retval));
  reloc = retval[0] = (arelent *) xcalloc (1, sizeof (arelent));
  reloc->sym_ptr_ptr = (asymbol **) xmalloc (sizeof (asymbol *));
  *reloc->sym_ptr_ptr = symbol_get_bfdsym (fixp->fx_addsy);
  reloc->address = fixp->fx_frag->fr_address + fixp->fx_where;
  reloc->addend = fixp->fx_addnumber;

  code = fixp->fx_r_type;

  reloc->howto = bfd_reloc_type_lookup (stdoutput, code);
  if (reloc->howto == NULL)
    {
      as_bad_where (fixp->fx_file, fixp->fx_line,
		    _("cannot represent %s relocation in this object file"
		      " format"), bfd_get_reloc_code_name (code));
      retval[0] = NULL;
    }

  if (linkrelax && fixp->fx_subsy)
    {
      reloc->howto = bfd_reloc_type_lookup (stdoutput, fixp->fx_r_type);
      reloc->addend = 0;
      retval[1] = reloc;

      reloc = retval[0] = (arelent *) xcalloc (1, sizeof (arelent));
      reloc->sym_ptr_ptr = (asymbol **) xmalloc (sizeof (asymbol *));
      *reloc->sym_ptr_ptr = symbol_get_bfdsym (fixp->fx_subsy);
      reloc->address = fixp->fx_frag->fr_address + fixp->fx_where;
      reloc->howto = bfd_reloc_type_lookup (stdoutput,
					    BFD_RELOC_NANOMIPS_NEG);
    }
  else if (linkrelax_reloc_p (fixp->fx_r_type))
    {
      /* For a place-holder relocation, we want any succeeding PC-relative
         relocation at the same offset to be generated first, so that its
         PC-relative address calculation is disassembled correctly.  */
      fixS *fixp_iter = fixp;

      while (fixp_iter->fx_next != NULL)
	{
	  /* Search ahead for PC-relative relocations at same offset.  */
	  fixp_iter = fixp_iter->fx_next;
	  if (!linkrelax_reloc_p (fixp_iter->fx_r_type)
	      && (fixp_iter->fx_frag->fr_address + fixp_iter->fx_where >
		  fixp->fx_frag->fr_address + fixp->fx_where))
	    break;

	  if (fixp_iter->fx_pcrel && !fixp_iter->fx_done)
	    {
	      /* Relocation found, generate it before the place-holder
	         reloc and mark it as done.  */
	      retval[1] = reloc;
	      reloc = retval[0] = (arelent *) xcalloc (1, sizeof (arelent));
	      reloc->sym_ptr_ptr = (asymbol **) xmalloc (sizeof (asymbol *));
	      *reloc->sym_ptr_ptr = symbol_get_bfdsym (fixp_iter->fx_addsy);
	      reloc->address = (fixp_iter->fx_frag->fr_address
				+ fixp_iter->fx_where);
	      reloc->addend = fixp_iter->fx_addnumber;
	      reloc->howto = bfd_reloc_type_lookup (stdoutput,
						    fixp_iter->fx_r_type);

	      fixp_iter->fx_done = TRUE;
	      break;
	    }
	}
    }

  return retval;
}

/* Relax a machine dependent frag.  This returns the amount by which
   the current size of the frag should change.  */

int
nanomips_relax_frag (asection *sec, fragS *fragp,
		     long stretch ATTRIBUTE_UNUSED)
{
  if (RELAX_NANOMIPS_P (fragp->fr_subtype))
    {
      offsetT old_var = fragp->fr_var;
      offsetT new_var = 4;

      if (!nanomips_opts.no_balc_stubs
	  && stubg_now != NULL
	  && RELAX_NANOMIPS_BALC_STUB_P (fragp->fr_subtype))
	new_var = relaxed_nanomips_stub_length (fragp, sec, TRUE);
      else if (RELAX_NANOMIPS_ADDIU_P (fragp->fr_subtype))
	new_var = relaxed_nanomips_addiu_length (fragp, TRUE);
      else if (RELAX_NANOMIPS_TYPE (fragp->fr_subtype) >= RT_BRANCH_UCND)
	new_var = relaxed_nanomips_16bit_branch_length (fragp, sec, TRUE);
      else
	new_var = old_var;

      /* Try to relax 32-bit call through a stub.  */
      if (!nanomips_opts.no_balc_stubs
	  && stubg_now != NULL
	  && RELAX_NANOMIPS_TYPE (fragp->fr_subtype) == RT_BRANCH_UCND
	  && RELAX_NANOMIPS_LINK (fragp->fr_subtype)
	  && RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
	new_var = relaxed_nanomips_stub_call_length (fragp, sec,
						     new_var > 2, TRUE);

      fragp->fr_var = new_var;
      if (!RELAX_NANOMIPS_ADDIU_P (fragp->fr_subtype) != 0
	  && fragp->fr_symbol != 0)
	relaxed_nanomips_invariable_branch_p (fragp, sec);
      return new_var - old_var;
    }

  return 0;
}

/* Convert a machine dependent frag.  */

void
md_convert_frag (bfd *abfd ATTRIBUTE_UNUSED, segT asec, fragS *fragp)
{
  if (RELAX_NANOMIPS_ADDIU_P (fragp->fr_subtype))
    {
      char *buf = fragp->fr_literal + fragp->fr_fix;
      unsigned long insn = read_compressed_insn (buf, 4);
      offsetT sval;
      unsigned long rt, rs;

      rt = EXTRACT_BITS (insn, NANOMIPSOP_MASK_RT, NANOMIPSOP_SH_RT);
      rs = EXTRACT_BITS (insn, NANOMIPSOP_MASK_RS, NANOMIPSOP_SH_RS);
      sval = S_GET_VALUE (fragp->fr_symbol) + fragp->fr_offset;

      if (!RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype))
	{
	  if (RELAX_NANOMIPS_NEGOFF (fragp->fr_subtype))
	    /* ADDIU[32] -> ADDIU[RS5] */
	    insn = (0x9008
		    | (rt << NANOMIPSOP_SH_MP)
		    | (sval & 0x8) << 1
		    | (sval & 0x7));
	  else if (rs == 0)
	    /* LI[32] -> LI[16] */
	    insn = (0xd000
		    | (rt << NANOMIPSOP_SH_MQ)
		    | (sval & 0x7f));
	  else
	    /* ADDIU[32] -> ADDIU[R2] */
	    insn = (0x9000
		    | (rt & 0x7) << NANOMIPSOP_SH_MD
		    | (rs & 0x7) << NANOMIPSOP_SH_MC
		    | (sval & 0x1f) >> 2);
	}
      else if (RELAX_NANOMIPS_NEGOFF (fragp->fr_subtype))
	/* ADDIU[32] -> ADDIU[NEG] */
	insn = (insn & ~0xfff) | 0x80008000 | (-sval & 0xfff);
      else
	insn = (insn & ~0xffff) | (sval & 0xffff);

      buf = write_compressed_insn (buf, insn, fragp->fr_var);
      fragp->fr_fix += fragp->fr_var;
      gas_assert (buf == fragp->fr_literal + fragp->fr_fix);
      return;
    }
  else if (RELAX_NANOMIPS_P (fragp->fr_subtype))
    {
      char *buf = fragp->fr_literal + fragp->fr_fix;
      int type = RELAX_NANOMIPS_TYPE (fragp->fr_subtype);
      unsigned long insn;
      expressionS exp;
      fixS *fixp;
      symbolS *stubsym = NULL;
      const bfd_reloc_code_real_type rtype[]
	= { BFD_RELOC_NANOMIPS_10_PCREL_S1,
	    BFD_RELOC_NANOMIPS_7_PCREL_S1,
	    BFD_RELOC_NANOMIPS_4_PCREL_S1,
	    BFD_RELOC_NANOMIPS_25_PCREL_S1,
	    BFD_RELOC_NANOMIPS_14_PCREL_S1,
	    BFD_RELOC_NANOMIPS_14_PCREL_S1 };

      if (RELAX_NANOMIPS_USESTUB (fragp->fr_subtype)
	  && ((stubg_now->seg != (asection *) asec)
	      || (stubg_now->prev
		  && stubg_now->prev->fragp
		  && (fragp->fr_address + fragp->fr_fix
		      < stubg_now->prev->fragp->fr_address))))
	stubg_now = hash_find (balc_stubgroup_table, asec->name);

      exp.X_op = O_symbol;
      if (RELAX_NANOMIPS_USESTUB (fragp->fr_subtype)
	  && balc_get_stub_for_symbol (S_GET_NAME (fragp->fr_symbol),
				       fragp->fr_address + fragp->fr_fix,
				       stubg_now, &stubsym))
	{
	  /* Resolve call through a stub symbol.  */
	  exp.X_add_symbol = stubsym;
	  exp.X_add_number = 0;
	  fragp->fr_subtype
	    = RELAX_NANOMIPS_CLEAR_TOOFAR16 (fragp->fr_subtype);
	}
      else
	{
	  exp.X_add_symbol = fragp->fr_symbol;
	  exp.X_add_number = fragp->fr_offset;
	}

      fragp->fr_fix += fragp->fr_var;

      /* We generate a fixup instead of applying it right now,
         because if there is linker relaxation, we're going to
         need the relocations.  */
      switch (type)
	{
	case RT_BRANCH_UCND:
	case RT_BRANCH_CNDZ:
	case RT_BRANCH_CND:
	  fixp = fix_new_exp (fragp, buf - fragp->fr_literal, 2, &exp, TRUE,
			      rtype[type - RT_BRANCH_UCND
				    + (RELAX_NANOMIPS_TOOFAR16
				       (fragp->fr_subtype) ? 3 : 0)]);
	  break;
	case RT_BALC_STUB:
	  if (!RELAX_NANOMIPS_KEEPSTUB (fragp->fr_subtype))
	    return;
	  fixp = fix_new_exp (fragp, buf - fragp->fr_literal, 4, &exp, TRUE,
			      rtype[3]);
	  break;
	default:
	  return;
	  break;
	}

      fixp->fx_file = fragp->fr_file;
      fixp->fx_line = fragp->fr_line;

      /* Remember the first fix-up in this frag.  */
      if (fragp->tc_frag_data.first_fix == NULL)
	fragp->tc_frag_data.first_fix = fixp;

      /* These relocations can have an addend that won't fit in
         2 octets.  */
      fixp->fx_no_overflow = 1;

      if (RELAX_NANOMIPS_USESTUB (fragp->fr_subtype) && stubsym != NULL)
	{
	  /* Relax 32-bit call to 16-bit call to stub.  */
	  buf = write_compressed_insn (buf, 0x3800, 2);
	  return;
	}

      /* Nothing left to do for 16-bit branches that fit,
         or for balc stubs */
      if (!RELAX_NANOMIPS_TOOFAR16 (fragp->fr_subtype) || type == RT_BALC_STUB)
	return;

      /* Relax 16-bit branches to 32-bit branches.  */
      insn = read_compressed_insn (buf, 2);

      if ((insn & 0xfc00) == 0xd800)	/* beqc[16]/bnec[16]  */
	{
	  unsigned long rt = (insn & 0x0380) >> 7;
	  unsigned long rs = (insn & 0x0070) >> 4;
	  if (rt > rs)
	    insn = 0x88000000;	/* beqc  */
	  else
	    insn = 0xa8000000;	/* bnec  */
	  rt = nanomips_to_32_reg_d_map[rt];
	  rs = nanomips_to_32_reg_d_map[rs];
	  insn |= (rt << 21);
	  insn |= (rs << 16);
	}
      else if ((insn & 0xdc00) == 0x9800)	/* beqzc[16]/bnezc[16]  */
	{
	  unsigned long rt = (insn & 0x0380) >> 7;
	  rt = nanomips_to_32_reg_d_map[rt];
	  /* beqc: 0x9800 -> 0x88000000
	     bnec: 0xb800 -> 0xa8000000  */
	  insn = 0x88000000 | (((insn & 0x2000) >> 13) << 29);
	  insn |= (rt << 21);
	}
      else if ((insn & 0xdc00) == 0x1800)	/* bc[16]/balc[16]  */
	/* bc:		0x1800 -> 0x28000000
	   balc:	0x3800 -> 0x2a000000  */
	insn = 0x28000000 | (((insn & 0x2000) >> 13) << 25);
      else
	abort ();

      /* Nothing else to do, just write it out.  */
      buf = write_compressed_insn (buf, insn, 4);
      gas_assert (buf == fragp->fr_literal + fragp->fr_fix);
      return;
    }

  {
    relax_substateT subtype = fragp->fr_subtype;
    bfd_boolean second_longer = (subtype & RELAX_SECOND_LONGER) != 0;
    bfd_boolean use_second = (subtype & RELAX_USE_SECOND) != 0;
    int first = RELAX_FIRST (subtype);
    int second = RELAX_SECOND (subtype);
    fixS *fixp = (fixS *) fragp->fr_opcode;

    /* Possibly emit a warning if we've chosen the longer option.  */
    if (use_second == second_longer)
      {
	if ((subtype & RELAX_NOMACRO) != 0)
	  as_bad_where (fixp->fx_file, fixp->fx_line,
			_("macro instruction expanded into multiple instructions"));

	subtype &= ~RELAX_NOMACRO;
      }

    /* Go through all the fixups for the first sequence.  Disable them
       (by marking them as done) if we're going to use the second
       sequence instead.  */
    while (fixp
	   && fixp->fx_frag == fragp
	   && fixp->fx_where < fragp->fr_fix - second)
      {
	if (subtype & RELAX_USE_SECOND)
	  fixp->fx_done = 1;
	fixp = fixp->fx_next;
      }

    /* Go through the fixups for the second sequence.  Disable them if
       we're going to use the first sequence, otherwise adjust their
       addresses to account for the relaxation.  */
    while (fixp && fixp->fx_frag == fragp)
      {
	if (subtype & RELAX_USE_SECOND)
	  fixp->fx_where -= first;
	else
	  fixp->fx_done = 1;
	fixp = fixp->fx_next;
      }

    /* Now modify the frag contents.  */
    if (subtype & RELAX_USE_SECOND)
      {
	char *start;

	start = fragp->fr_literal + fragp->fr_fix - first - second;
	memmove (start, start + first, second);
	fragp->fr_fix -= first;
      }
    else
      fragp->fr_fix -= second;
  }
}

/* This function is called whenever a label is defined, including fake
   labels instantiated off the dot special symbol.  It is used when
   handling branch delays; if a branch has a label, we assume we cannot
   move it.  This also bumps the value of the symbol by 1 in compressed
   code.  */

static void
nanomips_record_label (symbolS *sym)
{
  segment_info_type *si = seg_info (now_seg);
  struct insn_label_list *l;

  if (free_insn_labels == NULL)
    l = (struct insn_label_list *) xmalloc (sizeof *l);
  else
    {
      l = free_insn_labels;
      free_insn_labels = l->next;
    }

  l->label = sym;
  l->next = si->label_list;
  si->label_list = l;
}

/* This function is called as tc_frob_label() whenever a label is defined
   and adds a DWARF-2 record we only want for true labels.  */

void
nanomips_define_label (symbolS *sym)
{
  nanomips_record_label (sym);
  dwarf2_emit_label (sym);
}

/* This function is called by tc_new_dot_label whenever a new dot symbol
   is defined.  */

void
nanomips_add_dot_label (symbolS *sym)
{
  nanomips_record_label (sym);
}

/* Converting ASE flags from internal to .nanoMIPS.abiflags values.  */
static unsigned int
nanomips_convert_ase_flags (int ase)
{
  unsigned int ext_ases = 0;

  if (ase & ASE_CRC)
    ext_ases |= NANOMIPS_ASE_CRC;
  if (ase & ASE_DSP)
    ext_ases |= NANOMIPS_ASE_DSPR3;
  if (ase & ASE_EVA)
    ext_ases |= NANOMIPS_ASE_EVA;
  if (ase & ASE_GINV)
    ext_ases |= NANOMIPS_ASE_GINV;
  if (ase & ASE_MCU)
    ext_ases |= NANOMIPS_ASE_MCU;
  if (ase & ASE_MT)
    ext_ases |= NANOMIPS_ASE_MT;
  if (ase & ASE_MSA)
    ext_ases |= NANOMIPS_ASE_MSA;
  if (ase & ASE_xNMS)
    ext_ases |= NANOMIPS_ASE_xNMS;
  if (ase & ASE_TLB)
    ext_ases |= NANOMIPS_ASE_TLB;
  if (ase & ASE_VIRT)
    ext_ases |= NANOMIPS_ASE_VIRT;

  return ext_ases;
}

/* Some special processing for a nanoMIPS ELF file.  */

void
nanomips_elf_final_processing (void)
{
  Elf_Internal_ABIFlags_v0 flags;

  flags.version = 0;
  flags.isa_rev = 0;
  switch (file_nanomips_opts.isa)
    {
    case INSN_ISAN32R6:
      flags.isa_level = 32;
      flags.isa_rev = 6;
      break;
    case INSN_ISAN64R6:
      flags.isa_level = 64;
      flags.isa_rev = 6;
      break;
    }

  flags.gpr_size = file_nanomips_opts.gp == 32 ? AFL_REG_32 : AFL_REG_64;
  flags.cpr1_size = (file_nanomips_opts.soft_float ? AFL_REG_NONE
		     : ((file_nanomips_opts.ase & ASE_MSA) ? AFL_REG_128
			: AFL_REG_64));
  flags.cpr2_size = AFL_REG_NONE;

  /* If a GNU attribute was explicitly specified, use it.  */
  if (obj_elf_seen_attribute (OBJ_ATTR_GNU, Tag_GNU_NANOMIPS_ABI_FP))
    flags.fp_abi = bfd_elf_get_obj_attr_int (stdoutput, OBJ_ATTR_GNU,
					     Tag_GNU_NANOMIPS_ABI_FP);
  /* Soft-float gets precedence over single-float, the two options should
     not be used together so this should not matter.  */
  else if (file_nanomips_opts.soft_float == 1)
    flags.fp_abi = Val_GNU_NANOMIPS_ABI_FP_SOFT;
  /* Single-float gets precedence over all double_float cases.  */
  else if (file_nanomips_opts.single_float == 1)
    flags.fp_abi = Val_GNU_NANOMIPS_ABI_FP_SINGLE;
  else
    flags.fp_abi = Val_GNU_NANOMIPS_ABI_FP_DOUBLE;

  flags.ases = nanomips_convert_ase_flags (file_nanomips_opts.ase);
  flags.flags1 = 0;
  flags.flags2 = 0;
  flags.isa_ext = 0;

  bfd_mips_elf_swap_abiflags_v0_out (stdoutput, &flags,
				     ((Elf_External_ABIFlags_v0 *)
				      nanomips_flags_frag));

  /* Set the nanoMIPS ELF flag bits.  */
  if (nanomips_opts.pic != NO_PIC)
    elf_elfheader (stdoutput)->e_flags |= EF_NANOMIPS_PIC;

  if (nanomips_opts.pid)
    elf_elfheader (stdoutput)->e_flags |= EF_NANOMIPS_PID;

  if (nanomips_opts.pcrel)
    elf_elfheader (stdoutput)->e_flags |= EF_NANOMIPS_PCREL;

  if (linkrelax == TRUE)
    elf_elfheader (stdoutput)->e_flags |= EF_NANOMIPS_LINKRELAX;

  /* Set the nanoMIPS ELF ABI flags.  */
  if (nanomips_abi == P32_ABI)
    elf_elfheader (stdoutput)->e_flags |= E_NANOMIPS_ABI_P32;
  else if (nanomips_abi == P64_ABI)
    elf_elfheader (stdoutput)->e_flags |= E_NANOMIPS_ABI_P64;

  if (nanomips_32bitmode)
    elf_elfheader (stdoutput)->e_flags |= EF_NANOMIPS_32BITMODE;
}


static procS cur_proc;
static int numprocs;

/* Implement NOP_OPCODE.  We encode a nanoMIPS opcode as "0".  */

#define NOP_OPCODE_NANOMIPS	0

char
nanomips_nop_opcode (void)
{
  return NOP_OPCODE_NANOMIPS;
}

/* Fill in an rs_align_code fragment.  Unlike elsewhere we want to use
   32-bit microMIPS NOPs here (if applicable).  */

void
nanomips_handle_align (fragS *fragp)
{
  char *p;
  int bytes, size, excess;
  valueT opcode;

  bytes = fragp->fr_next->fr_address - fragp->fr_address - fragp->fr_fix;

  /* tc_frag_data.first_fix points to the ALIGN relocation for this frag.
     Update the size of the absolute alignment symbol to match
     the actual padding inserted at this alignment point. */
  if (fragp->tc_frag_data.first_fix != NULL)
    {
      fixS *fixp = fragp->tc_frag_data.first_fix;
      asymbol *sym;

      while (fixp != NULL && fixp->fx_frag == fragp)
	{
	  if (fixp->fx_r_type == BFD_RELOC_NANOMIPS_ALIGN)
	    {
	      sym = symbol_get_bfdsym (fixp->fx_addsy);
	      elf_symbol (sym)->internal_elf_sym.st_size = bytes;
	      break;
	    }
	  fixp = fixp->fx_next;
	}
    }

  if (fragp->fr_type != rs_align_code)
    return;

  p = fragp->fr_literal + fragp->fr_fix;
  opcode = nanomips_nop32_insn.insn_opcode;
  size = 4;

  excess = bytes % size;

  /* Handle the leading part if we're not inserting a whole number of
     instructions, and make it the end of the fixed part of the frag.
     Try to fit in a short NOP if applicable and possible,
     and use zeroes otherwise.  */
  gas_assert (excess < 4);
  fragp->fr_fix += excess;
  switch (excess)
    {
    case 3:
      *p++ = '\0';
      /* Fall through.  */
    case 2:
      if (!nanomips_opts.insn32)
	{
	  p = write_compressed_insn (p, nanomips_nop16_insn.insn_opcode, 2);
	  break;
	}
      *p++ = '\0';
      /* Fall through.  */
    case 1:
      *p++ = '\0';
      /* Fall through.  */
    case 0:
      break;
    }

  write_compressed_insn (p, opcode, size);
  fragp->fr_var = size;
}

static long
get_number (void)
{
  int negative = 0;
  long val = 0;

  if (*input_line_pointer == '-')
    {
      ++input_line_pointer;
      negative = 1;
    }
  if (!ISDIGIT (*input_line_pointer))
    as_bad (_("expected simple number"));
  if (input_line_pointer[0] == '0')
    {
      if (input_line_pointer[1] == 'x')
	{
	  input_line_pointer += 2;
	  while (ISXDIGIT (*input_line_pointer))
	    {
	      val <<= 4;
	      val |= hex_value (*input_line_pointer++);
	    }
	  return negative ? -val : val;
	}
      else
	{
	  ++input_line_pointer;
	  while (ISDIGIT (*input_line_pointer))
	    {
	      val <<= 3;
	      val |= *input_line_pointer++ - '0';
	    }
	  return negative ? -val : val;
	}
    }
  if (!ISDIGIT (*input_line_pointer))
    {
      printf (_(" *input_line_pointer == '%c' 0x%02x\n"),
	      *input_line_pointer, *input_line_pointer);
      as_warn (_("invalid number"));
      return -1;
    }
  while (ISDIGIT (*input_line_pointer))
    {
      val *= 10;
      val += *input_line_pointer++ - '0';
    }
  return negative ? -val : val;
}

/* The .file directive; just like the usual .file directive, but there
   is an initial number which is the ECOFF file index.  In the non-ECOFF
   case .file implies DWARF-2.  */

static void
s_nanomips_file (int x ATTRIBUTE_UNUSED)
{
  static int first_file_directive = 0;

  if (ECOFF_DEBUGGING)
    {
      get_number ();
      s_app_file (0);
    }
  else
    {
      char *filename;

      filename = dwarf2_directive_file (0);

      /* Versions of GCC up to 3.1 start files with a ".file"
         directive even for stabs output.  Make sure that this
         ".file" is handled.  */
      if (filename != NULL && !first_file_directive)
	{
	  (void) new_logical_line (filename, -1);
	  s_app_file_string (filename, 0);
	}
      first_file_directive = 1;
    }
}

/* The .loc directive, implying DWARF-2.  */

static void
s_nanomips_loc (int x ATTRIBUTE_UNUSED)
{
  if (!ECOFF_DEBUGGING)
    dwarf2_directive_loc (0);
}

/* The .linkrelax directive.  */

static void
s_linkrelax (int x ATTRIBUTE_UNUSED)
{
  if (!file_nanomips_opts_checked)
    {
      linkrelax = TRUE;
      nanomips_opts.linkrelax = TRUE;
      file_nanomips_opts.linkrelax = TRUE;
    }
  else
    as_bad (_(".linkrelax is not permitted after generating code"));
}

/* The .end directive.  */

static void
s_nanomips_end (int x ATTRIBUTE_UNUSED)
{
  symbolS *p;

  if (!is_end_of_line[(unsigned char) *input_line_pointer])
    {
      p = get_symbol ();
      demand_empty_rest_of_line ();
    }
  else
    p = NULL;

  if ((bfd_get_section_flags (stdoutput, now_seg) & SEC_CODE) == 0)
    as_warn (_(".end not in text section"));

  if (!cur_proc_ptr)
    {
      as_warn (_(".end directive without a preceding .ent directive"));
      demand_empty_rest_of_line ();
      return;
    }

  if (p != NULL)
    {
      gas_assert (S_GET_NAME (p));
      if (strcmp (S_GET_NAME (p), S_GET_NAME (cur_proc_ptr->func_sym)))
	as_warn (_(".end symbol does not match .ent symbol"));

      if (debug_type == DEBUG_STABS)
	stabs_generate_asm_endfunc (S_GET_NAME (p), S_GET_NAME (p));
    }
  else
    as_warn (_(".end directive missing or unknown symbol"));

  /* Create an expression to calculate the size of the function.  */
  if (p && cur_proc_ptr)
    {
      OBJ_SYMFIELD_TYPE *obj = symbol_get_obj (p);
      expressionS *exp = xmalloc (sizeof (expressionS));

      if (!nanomips_opts.no_balc_stubs && stubg_now != NULL)
	stubgroup_wane ();

      obj->size = exp;
      exp->X_op = O_subtract;
      exp->X_add_symbol = symbol_temp_new_now ();
      exp->X_op_symbol = p;
      exp->X_add_number = 0;

      cur_proc_ptr->func_end_sym = exp->X_add_symbol;
    }

  cur_proc_ptr = NULL;
}

/* The .aent and .ent directives.  */

static void
s_nanomips_ent (int aent)
{
  symbolS *symbolP;

  symbolP = get_symbol ();
  if (*input_line_pointer == ',')
    ++input_line_pointer;
  SKIP_WHITESPACE ();
  if (ISDIGIT (*input_line_pointer) || *input_line_pointer == '-')
    get_number ();

  if ((bfd_get_section_flags (stdoutput, now_seg) & SEC_CODE) == 0)
    as_warn (_(".ent or .aent not in text section"));

  if (!aent && cur_proc_ptr)
    as_warn (_("missing .end"));

  if (!aent)
    {
      cur_proc_ptr = &cur_proc;
      memset (cur_proc_ptr, '\0', sizeof (procS));

      cur_proc_ptr->func_sym = symbolP;

      ++numprocs;

      if (debug_type == DEBUG_STABS)
	stabs_generate_asm_func (S_GET_NAME (symbolP), S_GET_NAME (symbolP));
    }

  symbol_get_bfdsym (symbolP)->flags |= BSF_FUNCTION;

  if (stub_funcless_mode && !nanomips_opts.no_balc_stubs && stubg_now != NULL)
    {
      stub_funcless_mode = FALSE;
      stubgroup_wane ();
    }

  stubgroup_new (now_seg);
  demand_empty_rest_of_line ();
}

static void
s_nanomips_frame (int ignore ATTRIBUTE_UNUSED)
{
  if (ECOFF_DEBUGGING)
    s_ignore (ignore);
  else
    {
      long val;

      if (cur_proc_ptr == (procS *) NULL)
	{
	  as_warn (_(".frame outside of .ent"));
	  demand_empty_rest_of_line ();
	  return;
	}

      cur_proc_ptr->frame_reg = tc_get_register (1);

      SKIP_WHITESPACE ();
      if (*input_line_pointer++ != ','
	  || get_absolute_expression_and_terminator (&val) != ',')
	{
	  as_warn (_("bad .frame directive"));
	  --input_line_pointer;
	  demand_empty_rest_of_line ();
	  return;
	}

      cur_proc_ptr->frame_offset = val;
      cur_proc_ptr->pc_reg = tc_get_register (0);

      demand_empty_rest_of_line ();
    }
}

/* The .fmask and .mask directives.   */

static void
s_nanomips_mask (int reg_type)
{
  if (ECOFF_DEBUGGING)
    s_ignore (reg_type);
  else
    {
      long mask, off;

      if (cur_proc_ptr == (procS *) NULL)
	{
	  as_warn (_(".mask/.fmask outside of .ent"));
	  demand_empty_rest_of_line ();
	  return;
	}

      if (get_absolute_expression_and_terminator (&mask) != ',')
	{
	  as_warn (_("bad .mask/.fmask directive"));
	  --input_line_pointer;
	  demand_empty_rest_of_line ();
	  return;
	}

      off = get_absolute_expression ();

      if (reg_type == 'F')
	{
	  cur_proc_ptr->fpreg_mask = mask;
	  cur_proc_ptr->fpreg_offset = off;
	}
      else
	{
	  cur_proc_ptr->reg_mask = mask;
	  cur_proc_ptr->reg_offset = off;
	}

      demand_empty_rest_of_line ();
    }
}

/* A table describing all the processors gas knows about.  Names are
   matched in the order listed.

   To ease comparison, please keep this table in the same order as
   gcc's nanomips_cpu_info_table[].  */
static const struct nanomips_cpu_info nanomips_cpu_info_table[] = {
  /* Entries for generic ISAs */
  { "32r6",	NANOMIPS_CPU_IS_ISA,
    ASE_xNMS | ASE_TLB, ISA_NANOMIPS32R6, CPU_NANOMIPS32R6 },
  { "32r6s",	NANOMIPS_CPU_IS_ISA,
    0,		ISA_NANOMIPS32R6, CPU_NANOMIPS32R6 },
  { "64r6",    	NANOMIPS_CPU_IS_ISA,
    ASE_xNMS | ASE_TLB, ISA_NANOMIPS64R6, CPU_NANOMIPS64R6 },

  /* 7000 family */
  { "i7200",	0, ASE_xNMS | ASE_TLB | ASE_DSP | ASE_EVA | ASE_MT,
    ISA_NANOMIPS32R6, CPU_NANOMIPS32R6 },
  { "nms1",	0, 0,		ISA_NANOMIPS32R6, CPU_NANOMIPS32R6 },

  /* End marker */
  { NULL, 0, 0, 0, 0 }
};

/* Return true if GIVEN matches CANONICAL, where GIVEN is a user-supplied
   CPU name.  */

static bfd_boolean
nanomips_matching_cpu_name_p (const char *canonical, const char *given)
{
  while (*given != 0 && TOLOWER (*given) == TOLOWER (*canonical))
    given++, canonical++;

  return (*given == 0 && *canonical == 0);
}

/* Parse an option that takes the name of a processor as its argument.
   OPTION is the name of the option and CPU_STRING is the argument.
   Return the corresponding processor enumeration if the CPU_STRING is
   recognized, otherwise report an error and return null.

   A similar function exists in GCC.  */

static const struct nanomips_cpu_info *
nanomips_parse_cpu (const char *option, const char *cpu_string)
{
  const struct nanomips_cpu_info *p;

  if (strcasecmp (cpu_string, "from-abi") == 0)
    {
      if (ABI_NEEDS_32BIT_REGS (nanomips_abi))
	return nanomips_cpu_info_from_isa (ISA_NANOMIPS32R6, FALSE);

      if (ABI_NEEDS_64BIT_REGS (nanomips_abi))
	return nanomips_cpu_info_from_isa (ISA_NANOMIPS64R6, FALSE);

      return nanomips_cpu_info_from_isa (NANOMIPS_DEFAULT_64BIT
					 ? ISA_NANOMIPS64R6
					 : ISA_NANOMIPS32R6,
					 FALSE);
    }

  /* 'default' has traditionally been a no-op.  Probably not very useful.  */
  if (strcasecmp (cpu_string, "default") == 0)
    return 0;

  for (p = nanomips_cpu_info_table; p->name != 0; p++)
    if (nanomips_matching_cpu_name_p (p->name, cpu_string))
      return p;

  if (option != NULL)
    as_bad (_("bad value (%s) for %s"), cpu_string, option);
  return 0;
}

/* Return the canonical processor information for ISA (a member of the
   ISA_NANOMIPS* enumeration).  */

static const struct nanomips_cpu_info *
nanomips_cpu_info_from_isa (int isa, bfd_boolean subset)
{
  int i;

  for (i = 0; nanomips_cpu_info_table[i].name != NULL; i++)
    if ((nanomips_cpu_info_table[i].flags & NANOMIPS_CPU_IS_ISA)
	&& isa == nanomips_cpu_info_table[i].isa)
      {
	if (subset && (nanomips_cpu_info_table[i].ase & ASE_xNMS) != 0)
	  i++;

	return (&nanomips_cpu_info_table[i]);
      }

  return NULL;
}

static const struct nanomips_cpu_info *
nanomips_cpu_info_from_arch (int arch)
{
  int i;
  for (i = 0; nanomips_cpu_info_table[i].name != NULL; i++)
    if (arch == nanomips_cpu_info_table[i].cpu)
      return (&nanomips_cpu_info_table[i]);

  return NULL;
}

static void
show (FILE *stream, const char *string, int *col_p, int *first_p)
{
  if (*first_p)
    {
      fprintf (stream, "%24s", "");
      *col_p = 24;
    }
  else
    {
      fprintf (stream, ", ");
      *col_p += 2;
    }

  if (*col_p + strlen (string) > 72)
    {
      fprintf (stream, "\n%24s", "");
      *col_p = 24;
    }

  fprintf (stream, "%s", string);
  *col_p += strlen (string);

  *first_p = 0;
}

void
md_show_usage (FILE *stream)
{
  int column, first;
  size_t i;

  fprintf (stream, _("\
nanoMIPS options:\n\
-EB			generate big endian output\n\
-EL			generate little endian output\n\
-g, -g2			do not remove unneeded NOPs or swap branches\n\
-G NUM			allow referencing objects up to NUM bytes\n\
			implicitly with the gp register [default 8]\n"));
  fprintf (stream, _("\
-march=CPU/-mtune=CPU	generate code/schedule for CPU, where CPU is one of:\n"));

  first = 1;

  for (i = 0; nanomips_cpu_info_table[i].name != NULL; i++)
    show (stream, nanomips_cpu_info_table[i].name, &column, &first);
  show (stream, "from-abi", &column, &first);
  fputc ('\n', stream);
  fprintf (stream, _("\
-m32			create p32 ABI object file (default)\n\
-m64			create p64 ABI object file\n"));
  fprintf (stream, _("\
-mcmodel=MMODEL		Generate code for a specific memory model,\n\
			where MMODEL is one of: auto, medium, large\n\
-m[no-]pic		[dis]allow Position Independent Code generation\n\
-m[no-]PIC		[dis]allow large model Position Independent Code generation\n\
-m[no-]pid		[dis]allow Position Independent Data access\n\
-m[no-]pcrel		[dis]allow PC-relative address calculations\n"));

  fprintf (stream, _("\
-minsn32		only generate 32-bit nanoMIPS instructions\n\
-mno-insn32		generate all nanoMIPS instructions\n\
-mhard-float		allow floating-point instructions\n\
-msoft-float		do not allow floating-point instructions\n\
-msingle-float		only allow 32-bit floating-point operations\n\
-mdouble-float		allow 32-bit and 64-bit floating-point operations\n\
--[no-]construct-floats	[dis]allow floating point values to be constructed\n"));

  fprintf (stream, _("\
-mcrc			generate Cyclic Redundancy Check (CRC) instructions\n\
-mno-crc		do not generate CRC instructions\n"));
  fprintf (stream, _("\
-mdsp			generate DSP R3 instructions\n\
-mno-dsp		do not generate R3 DSP instructions\n"));
  fprintf (stream, _("\
-mdspr3			generate DSP R3 instructions\n\
-mno-dspr3		do not generate DSP R3 instructions\n"));
  fprintf (stream, _("\
-meva			generate Enhanced Virtual Addressing (EVA) instructions\n\
-mno-eva		do not generate EVA instructions\n"));
  fprintf (stream, _("\
-mginv			generate Global INValidate (GINV) instructions\n\
-mno-ginv		do not generate Global INValidate instructions\n"));
  fprintf (stream, _("\
-mmcu			generate MCU instructions\n\
-mno-mcu		do not generate MCU instructions\n"));
  fprintf (stream, _("\
-mmt			generate MT instructions\n\
-mno-mt			do not generate MT instructions\n"));
  fprintf (stream, _("\
-mtlb			generate Translation Lookaside Buffer (TLB) control instructions\n\
-mno-tlb		do not generate Translation Lookaside Buffer control instructions\n"));
  fprintf (stream, _("\
-mvirt			generate Virtualization instructions\n\
-mno-virt		do not generate Virtualization instructions\n"));
  fprintf (stream, _("\
-m[no-]balc-stubs	enable/disable out-of-range call optimization\n\
			through trampoline stubs\n\
-m[no-]legacyregs	[dis]allow mumerical register formats\n"));
  fprintf (stream, _("\
--linkrelax		allow linker relaxations\n\
--trap, --no-break	trap exception on div by 0 and mult overflow\n\
--break, --no-trap	break exception on div by 0 and mult overflow\n"));
  fprintf (stream, _("\
-mmttgpr-rc1		Revert to RC1 assembly format for MTTGPR instruction\n"));
  fprintf (stream, _("\
-m[no-]minimize-relocs	enable/disable full resolution of link-time invariable\n\
			PC-relative relocations at assembly\n"));
  fputc ('\n', stream);

}

int
nanomips_dwarf2_addr_size (void)
{
  if (HAVE_64BIT_OBJECTS)
    return 8;
  else
    return 4;
}

/* Standard calling conventions leave the CFA at SP on entry.  */
void
nanomips_cfi_frame_initial_instructions (void)
{
  cfi_add_CFA_def_cfa_register (SP);
}

int
tc_nanomips_regname_to_dw2regnum (char *regname)
{
  unsigned int regnum = -1;
  unsigned int reg;

  if (reg_lookup (&regname, RTYPE_GP | RTYPE_NUM, &reg))
    regnum = reg;

  return regnum;
}

/* Implement CONVERT_SYMBOLIC_ATTRIBUTE.
   Given a symbolic attribute NAME, return the proper integer value.
   Returns -1 if the attribute is not known.  */

int
nanomips_convert_symbolic_attribute (const char *name)
{
  static const struct
  {
    const char *name;
    const int tag;
  }
  attribute_table[] =
  {
#define T(tag) {#tag, tag}
    T (Tag_GNU_NANOMIPS_ABI_FP), T (Tag_GNU_NANOMIPS_ABI_MSA),
#undef T
  };
  unsigned int i;

  if (name == NULL)
    return -1;

  for (i = 0; i < ARRAY_SIZE (attribute_table); i++)
    if (streq (name, attribute_table[i].name))
      return attribute_table[i].tag;

  return -1;
}

void
md_nanomips_end (void)
{
  int fpabi = Val_GNU_NANOMIPS_ABI_FP_ANY;

  nanomips_flush_pending_output ();
  if (cur_proc_ptr)
    {
      as_warn (_("missing .end at end of assembly"));
      if (stubg_now != NULL)
	stubgroup_wane ();
    }

  if (stub_funcless_mode && !nanomips_opts.no_balc_stubs && stubg_now != NULL)
    {
      stub_funcless_mode = FALSE;
      stubgroup_wane ();
    }

  /* Just in case no code was emitted, do the consistency check.  */
  file_check_options ();

  /* Set a floating-point ABI if the user did not.  */
  if (obj_elf_seen_attribute (OBJ_ATTR_GNU, Tag_GNU_NANOMIPS_ABI_FP))
    {
      /* Perform consistency checks on the floating-point ABI.  */
      fpabi = bfd_elf_get_obj_attr_int (stdoutput, OBJ_ATTR_GNU,
					Tag_GNU_NANOMIPS_ABI_FP);
      if (fpabi != Val_GNU_NANOMIPS_ABI_FP_ANY)
	check_fpabi (fpabi);
    }
}

/* Map a data slot size to its nanoMIPS relocation.  */
static bfd_reloc_code_real_type
nanomips_bytes_to_reloc (int nbytes, bfd_boolean signed_val)
{
  bfd_reloc_code_real_type rel = BFD_RELOC_NONE;
  switch (nbytes)
    {
    case 1:
      if (signed_val)
	rel = BFD_RELOC_NANOMIPS_SIGNED_8;
      else
	rel = BFD_RELOC_NANOMIPS_UNSIGNED_8;
      break;
    case 2:
      if (signed_val)
	rel = BFD_RELOC_NANOMIPS_SIGNED_16;
      else
	rel = BFD_RELOC_NANOMIPS_UNSIGNED_16;
      break;
    case 4:
      rel = BFD_RELOC_32;
      break;
    case 8:
      rel = BFD_RELOC_64;
      break;
    case 16:
      break;
    default:
      as_bad (_("unsupported BFD relocation size %u"), nbytes);
      rel = BFD_RELOC_NONE;
    }
  return rel;
}

/* Parse a .byte, .word, etc. expression.

   Values for the status register are specified with %st(label).
   `label' will be right shifted by 2.  */

bfd_reloc_code_real_type
nanomips_parse_cons_expression (expressionS *exp, unsigned int nbytes)
{
  bfd_reloc_code_real_type rel = BFD_RELOC_NONE;
  int repeat = 1;
  expression (exp);

  if (*input_line_pointer == ':')
    {
      expressionS count;
      ++input_line_pointer;
      expression (&count);
      if (count.X_op != O_constant || count.X_add_number <= 0)
	{
	  as_warn (_("unresolvable or nonpositive repeat count; using 1"));
	  return BFD_RELOC_NONE;
	}

      /* The cons function is going to output this expression once.  So we
         output it count - 1 times.  */
      repeat = count.X_add_number;
    }

  /* Sometimes subtract expressions containing data labels are deemed
     not-constant by general parse code because they fall in distinct
     frags.  These wouldn't be affected by linker relaxation which only
     touches code, so we skip relocations for those expressions and hope
     that this will not break any valid case.  */
  if (linkrelax
      && exp->X_op != O_constant
      && (exp->X_op != O_subtract
	  || ((S_GET_SEGMENT (exp->X_add_symbol))->flags & SEC_CODE) != 0
	  || ((S_GET_SEGMENT (exp->X_op_symbol))->flags & SEC_CODE) != 0))
    {
      expressionS *iter;
      bfd_boolean done = FALSE;

      rel = nanomips_bytes_to_reloc (nbytes, sign_cons);

      /* Check if we can actually handle this expression.  */
      iter = exp;
      while (iter->X_add_symbol != NULL && !done)
	{
	  switch (iter->X_op)
	    {
	    case O_subtract:
	      /* exp := symbol - exp */
	      if (!symbol_constant_p (iter->X_add_symbol))
		{
		  as_bad ("Expression too complex to relocate!");
		  rel = BFD_RELOC_NONE;
		}
	      iter = symbol_get_value_expression (iter->X_op_symbol);
	      break;

	    case O_right_shift:
	      /* exp := exp >> const */
	      if (!symbol_constant_p (iter->X_op_symbol)
		  || S_GET_SEGMENT (iter->X_op_symbol) != absolute_section
		  || iter->X_add_number != 0)
		{
		  as_bad ("Expression too complex to relocate!");
		  rel = BFD_RELOC_NONE;
		}
	      /* Fall through.  */

	    case O_symbol:
	      /* exp := symbol [ + offset ] */
	      iter = symbol_get_value_expression (iter->X_add_symbol);
	      break;

	    default:
	      /* If the expression contains even one operator that we can't
	         map to relocations, then don't bother.  */
	      rel = BFD_RELOC_NONE;
	      done = TRUE;
	      break;
	    }

	}
    }

  while (repeat-- > 1)
    emit_expr_with_reloc (exp, nbytes, rel);

  return rel;
}

void
nanomips_cons_fix_new (fragS *frag, int where, int nbytes, expressionS *exp,
		       bfd_reloc_code_real_type r)
{
  if (r != BFD_RELOC_NONE)
    {
      /* Assuming 64 entries will be enough.  */
      struct s_rentry
      {
	symbolS *sym;
	offsetT addend;
	bfd_reloc_code_real_type reloc;
      } rentry[64];
      size_t numrelocs = 0;
      bfd_boolean comp_p;
      bfd_reloc_code_real_type sym_reloc = (HAVE_64BIT_SYMBOLS
					    ? BFD_RELOC_64 : BFD_RELOC_32);
      expressionS *iter = exp;

      /* Provisionally fill the outer-most entry.  */
      rentry[numrelocs].sym = NULL;
      rentry[numrelocs].addend = 0;
      rentry[numrelocs].reloc = r;

      /* Dealing with composite relocation.  */
      comp_p = (iter->X_op != O_symbol);

      if (iter->X_op == O_right_shift && r != sym_reloc)
	/* Finalize the outer entry now.  */
	numrelocs++;
      else
	/* Defer the outer entry for further combination.  */
	sym_reloc = r;

      while (iter->X_add_symbol != NULL)
	{

	  if (numrelocs + 1 >= ARRAY_SIZE (rentry))
	    {
	      as_bad ("Expression too complex to relocate!");
	      break;
	    }

	  switch (iter->X_op)
	    {
	    case O_subtract:
	      rentry[numrelocs].sym = iter->X_add_symbol;
	      rentry[numrelocs].addend = 0;
	      rentry[numrelocs++].reloc = sym_reloc;
	      rentry[numrelocs].sym = iter->X_op_symbol;
	      rentry[numrelocs].addend = iter->X_add_number;
	      sym_reloc = BFD_RELOC_NANOMIPS_NEG;
	      break;

	    case O_right_shift:
	      {
		int scount;
		gas_assert (symbol_constant_p (iter->X_op_symbol));
		scount = S_GET_VALUE (iter->X_op_symbol);

		/* Iterate over the shift count and track the
		   required number of relocs.  */
		while (scount-- > 0)
		  {
		    rentry[numrelocs].sym = NULL;
		    rentry[numrelocs].addend = 0;
		    rentry[numrelocs++].reloc = BFD_RELOC_NANOMIPS_ASHIFTR_1;
		  }

		/* We can roll the a shift step in to the expression
		   if it is just a simple symbol reference. This just
		   sets things up for the last-level block below.  */
		if (S_GET_VALUE (iter->X_op_symbol) != 0
		    && sym_reloc != BFD_RELOC_NANOMIPS_NEG)
		  {
		    sym_reloc = BFD_RELOC_NANOMIPS_ASHIFTR_1;
		    numrelocs--;
		  }
	      }
	      /* Fall through */

	    case O_symbol:
	      rentry[numrelocs].sym = iter->X_add_symbol;
	      if (sym_reloc == BFD_RELOC_NANOMIPS_NEG)
		/* S1 - (S2 + A) => S1 + (-S2 + -A) */
		rentry[numrelocs].addend = -iter->X_add_number;
	      else
		rentry[numrelocs].addend = iter->X_add_number;
	      break;

	    default:
	      as_bad ("Expression too complex to relocate!");
	      break;
	    }

	  iter = symbol_get_value_expression (rentry[numrelocs].sym);

	  /* No more levels of nesting?  */
	  if (iter->X_add_symbol == NULL)
	    rentry[numrelocs++].reloc = sym_reloc;
	}

      /* Step through the list in reverse and create relocations.  */
      while (numrelocs > 0)
	{
	  fixS *fixP;
	  --numrelocs;
	  fixP = fix_new (frag, where, nbytes, rentry[numrelocs].sym,
			  rentry[numrelocs].addend, 0,
			  rentry[numrelocs].reloc);

	  if (comp_p)
	    fixP->fx_tcbit = 1;
	}
    }
  else
    {
      reloc_howto_type *reloc_howto;
      int size = nbytes;

      if (r != TC_PARSE_CONS_RETURN_NONE)
	{
	  reloc_howto = bfd_reloc_type_lookup (stdoutput, r);
	  size = bfd_get_reloc_size (reloc_howto);

	  if (size > nbytes)
	    {
	      as_bad (_("%s relocations do not fit in %u bytes\n"),
		      reloc_howto->name, nbytes);
	      return;
	    }
	}
      else
	switch (size)
	  {
	  case 1:
	    r = BFD_RELOC_8;
	    break;
	  case 2:
	    r = BFD_RELOC_16;
	    break;
	  case 3:
	    r = BFD_RELOC_24;
	    break;
	  case 4:
	    r = BFD_RELOC_32;
	    break;
	  case 8:
	    r = BFD_RELOC_64;
	    break;
	  default:
	    as_bad (_("unsupported BFD relocation size %u"), size);
	    return;
	  }

      fix_new_exp (frag, where, size, exp, 0, r);
    }
}

/* Check if subtraction of 2 symbols can be fully evaluated at assembly.  */
static bfd_boolean
nanomips_allow_local_subtract_symbols (symbolS *left, symbolS *right)
{
  /* Check for intervening fixups between symbols within the same frag to
     determine if relaxation could affect the difference.  */
  if (symbol_get_frag (left) == symbol_get_frag (right))
    {
      fixS *fixP;
      fragS *fragP;
      bfd_vma low, high;

      fragP = symbol_get_frag (left);

      high = S_GET_VALUE (left);
      low = S_GET_VALUE (right);

      /* Swap if necessary.  */
      if (high < low)
	{
	  high = high + low;
	  low = high - low;
	  high = high - low;
	}

      /* Start with the first fix-up in this frag.  */
      fixP = fragP->tc_frag_data.first_fix;

      /* Now look for fixups within the range.  */
      while (fixP != NULL
	     && fixP->fx_frag->fr_address + fixP->fx_where < low
	     && fixP->fx_frag->fr_address + fixP->fx_where < high)
	fixP = fixP->fx_next;

      /* No fixup within the range.  */
      if (fixP == NULL
	  || fixP->fx_frag->fr_address + fixP->fx_where >= high)
	return TRUE;
    }
  else if (nanomips_opts.minimize_relocs
	   && S_GET_SEGMENT (left) == S_GET_SEGMENT (right))
    {
      fragS *fragp, *ifragp;
      if (S_GET_VALUE (left) > S_GET_VALUE (right))
	{
	  fragp = symbol_get_frag (left);
	  ifragp = symbol_get_frag (right);
	}
      else
	{
	  fragp = symbol_get_frag (right);
	  ifragp = symbol_get_frag (left);
	}

      while (ifragp && ifragp != fragp && !variable_frag_p (ifragp))
	ifragp = ifragp->fr_next;

      return (ifragp == fragp && !variable_frag_p (ifragp));
    }

  /* We have to assume that there may be instructions between the
     two symbols and that relaxation may increase the distance between
     them.  */
  return FALSE;
}

/* md_allow_local_subtract interface
   Check if a subtraction expression can be fully evaluated.  */
bfd_boolean
nanomips_allow_local_subtract (expressionS *left, expressionS *right,
			       segT section)
{
  /* If the symbols are not in a code section then they are OK.  */
  if ((section->flags & SEC_CODE) == 0)
    return TRUE;

  if ((left->X_add_symbol == right->X_add_symbol))
    return TRUE;

  /* If we are not in assembling mode, subtraction is OK.  */
  if (nanomips_assembling_insn)
    return TRUE;

  if (!linkrelax)
    return TRUE;

  return nanomips_allow_local_subtract_symbols (left->X_add_symbol,
						right->X_add_symbol);
}

/* Create relocations for alignment directives.  */
void
nanomips_md_do_align (int n, const char *fill, int fill_length, int max_fill)
{
  unsigned int fill_value = 0;

  if (nanomips_opts.linkrelax
      && (bfd_get_section_flags (stdoutput, now_seg) & SEC_CODE) != 0)
    {
      fill_value = bfd_get_bits (fill, fill_length * 8, target_big_endian);

      if (fill == NULL && subseg_text_p (now_seg))
	frag_grow (MAX_MEM_FOR_RS_ALIGN_CODE);
      else if (fill_length > 1)
	frag_grow (fill_length);
      else
	frag_grow (1);

      create_align_relocs (frag_now, n, fill_value, fill_length, max_fill);
    }
}

/* TC_VALIDATE_FIX_SUB hook */

int
nanomips_validate_fix_sub (fixS *fix)
{
  segT add_symbol_segment, sub_symbol_segment;

  /* The difference of two symbols should be resolved by the assembler when
     linkrelax is not set.  If the linker may relax the section containing
     the symbols, then composite relocations are generated so that the
     linker knows how to adjust the difference value.  */
  if (!linkrelax || fix->fx_addsy == NULL)
    return 0;

  /* Make sure both symbols are in the same segment, and that segment is
     "normal" and relaxable.  If the segment is not "normal", then the
     fix is not valid.  If the segment is not "relaxable", then the fix
     should have been handled earlier.  */
  add_symbol_segment = S_GET_SEGMENT (fix->fx_addsy);
  if (!SEG_NORMAL (add_symbol_segment) ||
      !relaxable_section (add_symbol_segment))
    return 0;
  sub_symbol_segment = S_GET_SEGMENT (fix->fx_subsy);

  if (sub_symbol_segment != add_symbol_segment)
    return 0;
  else
    {
      fixS *fixP;
      fragS *frag_hi, *frag_lo;
      bfd_vma low, high;

      frag_hi = symbol_get_frag (fix->fx_addsy);
      high = S_GET_VALUE (fix->fx_addsy);
      frag_lo = symbol_get_frag (fix->fx_subsy);
      low = S_GET_VALUE (fix->fx_subsy);

      /* Swap if necessary.  */
      if (high < low)
	{
	  fragS *temp = frag_hi;
	  frag_hi = frag_lo;
	  frag_lo = temp;
	  high = high + low;
	  low = high - low;
	  high = high - low;
	}

      /* Start with the first fix-up in this frag.  */
      fixP = frag_lo->tc_frag_data.first_fix;

      /* Now look for fixups within the range.  */
      while (fixP != NULL
	     && fixP->fx_frag->fr_address + fixP->fx_where < low
	     && fixP->fx_frag->fr_address + fixP->fx_where < high)
	fixP = fixP->fx_next;

      /* No fixup within the range.  */
      return (fixP != NULL
	      && fixP->fx_frag->fr_address + fixP->fx_where < high);
    }
}

/* TC_EH_FRAME_ESTIMATE_SIZE_BEFORE_RELAX hook.
   Check if the rs_cfa frag could be affected by linker relaxation and
   choose a suitable size estimation heuristic. If not, fall back to
   the generic estimation logic.

   The heuristic is currently hard-coded to 4 bytes.
*/
int
nanomips_eh_frame_estimate_size_before_relax (fragS *frag)
{
  expressionS *exp = symbol_get_value_expression (frag->fr_symbol);

  if (linkrelax
      && !nanomips_allow_local_subtract_symbols (exp->X_add_symbol,
						 exp->X_op_symbol))
    {
      int ret;
      gas_assert ((frag->fr_subtype >> 3) > 0);
      ret = 4;
      frag->fr_subtype = (frag->fr_subtype & ~7) | ret;

      return ret;
    }
  else
    return eh_frame_estimate_size_before_relax (frag);
}

/* TC_EH_FRAME_RELAX_FRAG hook  */
int
nanomips_eh_frame_relax_frag (fragS *frag)
{
  int oldsize, newsize;

  oldsize = frag->fr_subtype & 7;
  newsize = nanomips_eh_frame_estimate_size_before_relax (frag);
  return newsize - oldsize;
}

/* TC_EH_FRAME_CONVERT_FRAG hook
   Check if the rs_cfa frag could be affected by linker relaxation and
   generate relocations to fix-up the value after relaxation.
   Then fall-back to the generic convert_frag.  */
void
nanomips_eh_frame_convert_frag (fragS *frag)
{
  expressionS *exp = symbol_get_value_expression (frag->fr_symbol);

  if (linkrelax && !nanomips_allow_local_subtract_symbols (exp->X_add_symbol,
							   exp->X_op_symbol))
    {
      /* Generate label-difference relocations for this frag.  */
      int size = nanomips_eh_frame_estimate_size_before_relax (frag);
      bfd_reloc_code_real_type r = nanomips_bytes_to_reloc (size, FALSE);

      nanomips_cons_fix_new (frag, frag->fr_fix, size, exp, r);
    }

  eh_frame_convert_frag (frag);
}

/* Translate a relocation to a PC-relative offset.  */
long
md_pcrel_from (fixS *fixP)
{
  valueT addr = fixP->fx_where + fixP->fx_frag->fr_address;

  if (pcrel_branch_reloc_p (fixP->fx_r_type)
      && RELAX_NANOMIPS_FIXED (fixP->fx_frag->fr_subtype))
    {
      if (pcrel16_reloc_p (fixP->fx_r_type))
	return addr+2;
      else
	return addr+4;
    }
    else
      return 0;
}
