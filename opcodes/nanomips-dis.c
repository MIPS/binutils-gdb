/* Print nanoMIPS instructions for GDB, the GNU debugger, or for objdump.
   Copyright (C) 2018 Free Software Foundation, Inc.
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
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
   MA 02110-1301, USA.  */

#include "sysdep.h"
#include "dis-asm.h"
#include "libiberty.h"
#include "opcode/nanomips.h"
#include "opintl.h"
#include "disassemble.h"

#if !defined(EMBEDDED_ENV)
#include "elf-bfd.h"
#include "elf/mips.h"
#include "elf/nanomips.h"
#endif


/* FIXME: These should be shared with gdb somehow.  */

struct nanomips_cp0sel_name
{
  unsigned int cp0reg;
  unsigned int sel;
  const char *const name;
};

static const char * const nanomips_gpr_names_numeric[32] = {
  "$0",   "$1",   "$2",   "$3",   "$4",   "$5",   "$6",   "$7",
  "$8",   "$9",   "$10",  "$11",  "$12",  "$13",  "$14",  "$15",
  "$16",  "$17",  "$18",  "$19",  "$20",  "$21",  "$22",  "$23",
  "$24",  "$25",  "$26",  "$27",  "$28",  "$29",  "$30",  "$31"
};

static const char * const nanomips_gpr_names_symbolic[32] = {
  "zero", "at",   "t4",   "t5",   "a0",   "a1",   "a2",   "a3",
  "a4",   "a5",   "a6",   "a7",   "t0",   "t1",   "t2",   "t3",
  "s0",   "s1",   "s2",   "s3",   "s4",   "s5",   "s6",   "s7",
  "t8",   "t9",   "k0",   "k1",   "gp",   "sp",   "fp",   "ra"
};

static const char * const nanomips_fpr_names_numeric[32] = {
  "$f0",  "$f1",  "$f2",  "$f3",  "$f4",  "$f5",  "$f6",  "$f7",
  "$f8",  "$f9",  "$f10", "$f11", "$f12", "$f13", "$f14", "$f15",
  "$f16", "$f17", "$f18", "$f19", "$f20", "$f21", "$f22", "$f23",
  "$f24", "$f25", "$f26", "$f27", "$f28", "$f29", "$f30", "$f31"
};

static const char * const nanomips_fpr_names_64[32] = {
  "fv0",  "ft12", "fv1",  "ft13", "ft0",  "ft1",  "ft2",  "ft3",
  "ft4",  "ft5",  "ft6",  "ft7",  "fa0",  "fa1",  "fa2",  "fa3",
  "fa4",  "fa5",  "fa6",  "fa7",  "ft8",  "ft9",  "ft10", "ft11",
  "fs0",  "fs1",  "fs2",  "fs3",  "fs4",  "fs5",  "fs6",  "fs7"
};

static const char * const nanomips_cp1_names_numeric[32] = {
  "$0",   "$1",   "$2",   "$3",   "$4",   "$5",   "$6",   "$7",
  "$8",   "$9",   "$10",  "$11",  "$12",  "$13",  "$14",  "$15",
  "$16",  "$17",  "$18",  "$19",  "$20",  "$21",  "$22",  "$23",
  "$24",  "$25",  "$26",  "$27",  "$28",  "$29",  "$30",  "$31"
};

static const char * const nanomips_cp1_names_3264r6[32] = {
  "c1_fir",       "c1_ufr",       "$2",           "$3",
  "c1_unfr",      "$5",           "$6",           "$7",
  "$8",           "$9",           "$10",          "$11",
  "$12",          "$13",          "$14",          "$15",
  "$16",          "$17",          "$18",          "$19",
  "$20",          "$21",          "$22",          "$23",
  "$24",          "c1_fccr",      "c1_fexr",      "$27",
  "c1_fenr",      "$29",          "$30",          "c1_fcsr"
};

static const char * const nanomips_hwr_names_numeric[32] = {
  "$0",   "$1",   "$2",   "$3",   "$4",   "$5",   "$6",   "$7",
  "$8",   "$9",   "$10",  "$11",  "$12",  "$13",  "$14",  "$15",
  "$16",  "$17",  "$18",  "$19",  "$20",  "$21",  "$22",  "$23",
  "$24",  "$25",  "$26",  "$27",  "$28",  "$29",  "$30",  "$31"
};

static const char * const nanomips_hwr_names_3264r6[32] = {
  "hwr_cpunum",   "hwr_synci_step", "hwr_cc",     "hwr_ccres",
  "$4",          "$5",            "$6",           "$7",
  "$8",   "$9",   "$10",  "$11",  "$12",  "$13",  "$14",  "$15",
  "$16",  "$17",  "$18",  "$19",  "$20",  "$21",  "$22",  "$23",
  "$24",  "$25",  "$26",  "$27",  "$28",  "$29",  "$30",  "$31"
};

static const char * const msa_control_names[32] = {
  "msa_ir",	"msa_csr",	"msa_access",	"msa_save",
  "msa_modify",	"msa_request",	"msa_map",	"msa_unmap",
  "$8",   "$9",   "$10",  "$11",  "$12",  "$13",  "$14",  "$15",
  "$16",  "$17",  "$18",  "$19",  "$20",  "$21",  "$22",  "$23",
  "$24",  "$25",  "$26",  "$27",  "$28",  "$29",  "$30",  "$31"
};

/* The empty-list of CP0 registers serves as an indicator to fall-back to
   numeric register names.  */
const struct nanomips_cp0_name nanomips_cp0_numeric[] = { {"", 0, 0} };
const struct nanomips_cp0_select nanomips_cp0sel_numeric[] = { {"", 0, 0} };

struct nanomips_abi_choice
{
  const char *name;
  const char *const *gpr_names;
  const char *const *fpr_names;
};

struct nanomips_abi_choice nanomips_abi_choices[] = {
  {"numeric", nanomips_gpr_names_numeric, nanomips_fpr_names_numeric},
  {"p32", nanomips_gpr_names_symbolic, nanomips_fpr_names_64},
  {"p64", nanomips_gpr_names_symbolic, nanomips_fpr_names_64},
};

struct nanomips_arch_choice
{
  const char *name;
  int bfd_mach_valid;
  unsigned long bfd_mach;
  int processor;
  int isa;
  int ase;
  const struct nanomips_cp0_name *cp0_names;
  const struct nanomips_cp0_select *cp0sel_names;
  const char *const *cp1_names;
  const char *const *hwr_names;
};

const struct nanomips_arch_choice nanomips_arch_choices[] = {
  {"numeric", 0, 0, 0, 0, 0,
   nanomips_cp0_numeric, nanomips_cp0sel_numeric, nanomips_cp1_names_numeric,
   nanomips_hwr_names_numeric},

  {"32r6", 1, bfd_mach_nanomipsisa32r6, CPU_NANOMIPS32R6, ISA_NANOMIPS32R6,
   (ASE_EVA | ASE_MSA | ASE_VIRT | ASE_XPA_VIRT | ASE_XPA | ASE_MCU | ASE_MT
    | ASE_DSP | ASE_xNMS | ASE_TLB | ASE_GINV | ASE_CRC),
   nanomips_cp0_3264r6, nanomips_cp0sel_3264r6, nanomips_cp1_names_3264r6,
   nanomips_hwr_names_3264r6},

  {"32r6s", 1, bfd_mach_nanomipsisa32r6, CPU_NANOMIPS32R6, ISA_NANOMIPS32R6,
   (ASE_EVA | ASE_MSA | ASE_VIRT | ASE_XPA_VIRT | ASE_XPA | ASE_MCU | ASE_MT
    | ASE_DSP | ASE_TLB | ASE_GINV | ASE_CRC),
   nanomips_cp0_3264r6, nanomips_cp0sel_3264r6, nanomips_cp1_names_3264r6,
   nanomips_hwr_names_3264r6},

  {"64r6", 1, bfd_mach_nanomipsisa64r6, CPU_NANOMIPS64R6, ISA_NANOMIPS64R6,
   (ASE_EVA | ASE_MSA | ASE_MSA64 | ASE_VIRT | ASE_XPA_VIRT | ASE_XPA
    | ASE_MCU | ASE_MT | ASE_DSP | ASE_DSP64 | ASE_xNMS | ASE_TLB | ASE_GINV
    | ASE_CRC | ASE_CRC64),
   nanomips_cp0_3264r6, nanomips_cp0sel_3264r6, nanomips_cp1_names_3264r6,
   nanomips_hwr_names_3264r6},
};

/* ISA and processor type to disassemble for, and register names to use.
   set_default_nanomips_dis_options and parse_nanomips_dis_options fill in
   these values.  */
static int nanomips_processor;
static int nanomips_ase;
static int nanomips_isa;
static const char *const *nanomips_gpr_names;
static const char *const *nanomips_fpr_names;
static const struct nanomips_cp0_name *nanomips_cp0_names;
static const struct nanomips_cp0_select *nanomips_cp0sel_names;
static const char *const *nanomips_cp1_names;
static const char *const *nanomips_hwr_names;

/* Other options */
static int no_aliases;	/* If set disassemble as most general inst.  */
static bfd_boolean show_arch_insn; /* Mnemonics with suffix.  */

static const struct nanomips_abi_choice *
choose_abi_by_name (const char *name, unsigned int namelen)
{
  const struct nanomips_abi_choice *c;
  unsigned int i;

  for (i = 0, c = NULL; i < ARRAY_SIZE (nanomips_abi_choices) && c == NULL;
       i++)
    if (strncmp (nanomips_abi_choices[i].name, name, namelen) == 0
	&& strlen (nanomips_abi_choices[i].name) == namelen)
      c = &nanomips_abi_choices[i];

  return c;
}

static const struct nanomips_arch_choice *
choose_arch_by_name (const char *name, unsigned int namelen)
{
  const struct nanomips_arch_choice *c = NULL;
  unsigned int i;

  for (i = 0, c = NULL; i < ARRAY_SIZE (nanomips_arch_choices) && c == NULL;
       i++)
    if (strncmp (nanomips_arch_choices[i].name, name, namelen) == 0
	&& strlen (nanomips_arch_choices[i].name) == namelen)
      c = &nanomips_arch_choices[i];

  return c;
}

static const struct nanomips_arch_choice *
choose_arch_by_number (unsigned long mach)
{
  static unsigned long hint_bfd_mach;
  static const struct nanomips_arch_choice *hint_arch_choice;
  const struct nanomips_arch_choice *c;
  unsigned int i;

  /* We optimize this because even if the user specifies no
     flags, this will be done for every instruction!  */
  if (hint_bfd_mach == mach
      && hint_arch_choice != NULL
      && hint_arch_choice->bfd_mach == hint_bfd_mach)
    return hint_arch_choice;

  for (i = 0, c = NULL; i < ARRAY_SIZE (nanomips_arch_choices) && c == NULL;
       i++)
    {
      if (nanomips_arch_choices[i].bfd_mach_valid
	  && nanomips_arch_choices[i].bfd_mach == mach)
	{
	  c = &nanomips_arch_choices[i];
	  hint_bfd_mach = mach;
	  hint_arch_choice = c;
	}
    }
  return c;
}

/* Check if the object has nanoMIPS code.  */

static inline int
is_nanomips (Elf_Internal_Ehdr *header)
{
  if ((header->e_flags & EF_NANOMIPS_ARCH) == E_NANOMIPS_ARCH_32R6
      || (header->e_flags & EF_NANOMIPS_ARCH) == E_NANOMIPS_ARCH_64R6)
    return 1;

  return 0;
}

static void
set_default_nanomips_dis_options (struct disassemble_info *info)
{
  const struct nanomips_arch_choice *chosen_arch;

  nanomips_isa = ISA_NANOMIPS32R6;
  nanomips_processor = CPU_NANOMIPS32R6;
  nanomips_isa = TRUE;
  nanomips_ase = 0;
  nanomips_fpr_names = nanomips_fpr_names_numeric;
  nanomips_cp0_names = nanomips_cp0_numeric;
  nanomips_cp0sel_names = nanomips_cp0sel_numeric;
  nanomips_cp1_names = nanomips_cp1_names_numeric;
  nanomips_hwr_names = nanomips_hwr_names_numeric;
  no_aliases = 0;
  show_arch_insn = FALSE;

  nanomips_gpr_names = nanomips_gpr_names_symbolic;

  /* Set ISA, architecture, and cp0 register names as best we can.  */
  chosen_arch = choose_arch_by_number (info->mach);
  if (chosen_arch != NULL)
    {
      nanomips_processor = chosen_arch->processor;
      nanomips_isa = chosen_arch->isa;
      nanomips_ase = chosen_arch->ase;
      nanomips_cp0_names = chosen_arch->cp0_names;
      nanomips_cp0sel_names = chosen_arch->cp0sel_names;
      nanomips_cp1_names = chosen_arch->cp1_names;
      nanomips_hwr_names = chosen_arch->hwr_names;
    }
}

static void
parse_nanomips_dis_option (const char *option, unsigned int len)
{
  unsigned int i, optionlen, vallen;
  const char *val;
  const struct nanomips_abi_choice *chosen_abi;
  const struct nanomips_arch_choice *chosen_arch;

  /* Try to match options that are simple flags */
  if (CONST_STRNEQ (option, "show-arch-insn"))
    {
      show_arch_insn = TRUE;
      return;
    }

  if (CONST_STRNEQ (option, "no-aliases"))
    {
      no_aliases = 1;
      return;
    }

  if (CONST_STRNEQ (option, "msa"))
    {
      nanomips_ase |= ASE_MSA;
      if ((nanomips_isa & INSN_ISA_MASK) == ISA_NANOMIPS64R6)
	nanomips_ase |= ASE_MSA64;
      return;
    }

  if (CONST_STRNEQ (option, "virt"))
    {
      nanomips_ase |= ASE_VIRT;

      if (nanomips_isa & ISA_NANOMIPS64R6)
	nanomips_ase |= ASE_VIRT64;

      if (nanomips_ase & ASE_XPA)
	nanomips_ase |= ASE_XPA_VIRT;
      return;

      if (nanomips_ase & ASE_GINV)
	nanomips_ase |= ASE_GINV_VIRT;
    }

  if (CONST_STRNEQ (option, "xpa"))
    {
      nanomips_ase |= ASE_XPA;
      if (nanomips_ase & ASE_VIRT)
	nanomips_ase |= ASE_XPA_VIRT;
      return;
    }

  if (CONST_STRNEQ (option, "ginv"))
    {
      nanomips_ase |= ASE_GINV;
      if (nanomips_ase & ASE_VIRT)
	nanomips_ase |= ASE_GINV_VIRT;
      return;
    }

  /* Look for the = that delimits the end of the option name.  */
  for (i = 0; i < len; i++)
    if (option[i] == '=')
      break;

  if (i == 0)		/* Invalid option: no name before '='.  */
    return;
  if (i == len)		/* Invalid option: no '='.  */
    return;
  if (i == (len - 1))	/* Invalid option: no value after '='.  */
    return;

  optionlen = i;
  val = option + (optionlen + 1);
  vallen = len - (optionlen + 1);

  if (strncmp ("gpr-names", option, optionlen) == 0
      && strlen ("gpr-names") == optionlen)
    {
      chosen_abi = choose_abi_by_name (val, vallen);
      if (chosen_abi != NULL)
	nanomips_gpr_names = chosen_abi->gpr_names;
      return;
    }

  if (strncmp ("fpr-names", option, optionlen) == 0
      && strlen ("fpr-names") == optionlen)
    {
      chosen_abi = choose_abi_by_name (val, vallen);
      if (chosen_abi != NULL)
	nanomips_fpr_names = chosen_abi->fpr_names;
      return;
    }

  if (strncmp ("cp0-names", option, optionlen) == 0
      && strlen ("cp0-names") == optionlen)
    {
      chosen_arch = choose_arch_by_name (val, vallen);
      if (chosen_arch != NULL)
	{
	  nanomips_cp0_names = chosen_arch->cp0_names;
	  nanomips_cp0sel_names = chosen_arch->cp0sel_names;
	}
      return;
    }

  if (strncmp ("cp1-names", option, optionlen) == 0
      && strlen ("cp1-names") == optionlen)
    {
      chosen_arch = choose_arch_by_name (val, vallen);
      if (chosen_arch != NULL)
	nanomips_cp1_names = chosen_arch->cp1_names;
      return;
    }

  if (strncmp ("hwr-names", option, optionlen) == 0
      && strlen ("hwr-names") == optionlen)
    {
      chosen_arch = choose_arch_by_name (val, vallen);
      if (chosen_arch != NULL)
	nanomips_hwr_names = chosen_arch->hwr_names;
      return;
    }

  if (strncmp ("reg-names", option, optionlen) == 0
      && strlen ("reg-names") == optionlen)
    {
      /* We check both ABI and ARCH here unconditionally, so
         that "numeric" will do the desirable thing: select
         numeric register names for all registers.  Other than
         that, a given name probably won't match both.  */
      chosen_abi = choose_abi_by_name (val, vallen);
      if (chosen_abi != NULL)
	{
	  nanomips_gpr_names = chosen_abi->gpr_names;
	  nanomips_fpr_names = chosen_abi->fpr_names;
	}
      chosen_arch = choose_arch_by_name (val, vallen);
      if (chosen_arch != NULL)
	{
	  nanomips_cp0_names = chosen_arch->cp0_names;
	  nanomips_cp0sel_names = chosen_arch->cp0sel_names;
	  nanomips_cp1_names = chosen_arch->cp1_names;
	  nanomips_hwr_names = chosen_arch->hwr_names;
	}
      return;
    }

  /* Invalid option.  */
}

static void
parse_nanomips_dis_options (const char *options)
{
  const char *option_end;

  if (options == NULL)
    return;

  while (*options != '\0')
    {
      /* Skip empty options.  */
      if (*options == ',')
	{
	  options++;
	  continue;
	}

      /* We know that *options is neither NUL or a comma.  */
      option_end = options + 1;
      while (*option_end != ',' && *option_end != '\0')
	option_end++;

      parse_nanomips_dis_option (options, option_end - options);

      /* Go on to the next one.  If option_end points to a comma, it
         will be skipped above.  */
      options = option_end;
    }
}

/* Look-up and print the symbolic name of a named CP0 register with
   a fixed select value.  Fall-back to numeric format if no match is
   found.  */

static void
print_cp0_reg (struct disassemble_info *info, int regno)
{
  int i;
  unsigned int select = regno & NANOMIPSOP_MASK_CP0SEL;
  unsigned int cp0_regno = regno >> NANOMIPSOP_SH_CP0SEL;

  if (nanomips_cp0_names != nanomips_cp0_numeric)
    for (i = cp0_regno; nanomips_cp0_names[i].name; i++)
      {
	if (nanomips_cp0_names[i].num == cp0_regno
	    && nanomips_cp0_names[i].sel == select)
	  {
	    info->fprintf_func (info->stream, "%s",
				nanomips_cp0_names[i].name+1);
	    return;
	  }
      }

  /* A select value of 0 is deemed optional.  */
  if (select == 0)
    info->fprintf_func (info->stream, "$%d", cp0_regno);
  else
    info->fprintf_func (info->stream, "$%d,%d", cp0_regno, select);
}

/* Look-up and print the symbolic name of a named CP0 register with
   a variable select value.  Fall-back to numeric format if no match is
   found.  */

static void
print_cp0sel_reg (struct disassemble_info *info, unsigned int regno,
		  unsigned int select)
{
  int i;

  for (i = 0; nanomips_cp0sel_names[i].name; i++)
    {
      if (nanomips_cp0sel_names[i].num == regno
	  && ((1 << select) & nanomips_cp0sel_names[i].selmask) != 0)
	{
	  info->fprintf_func (info->stream, "%s,%d",
			      nanomips_cp0sel_names[i].name+1,
			      select);
	  return;
	}
    }

  /* A select value of 0 is deemed optional.  */
  if (select == 0)
    info->fprintf_func (info->stream, "$%d", regno);
  else
    info->fprintf_func (info->stream, "$%d,%d", regno, select);
}

/* Print register REGNO, of type TYPE, for instruction OPCODE.  */

static void
print_reg (struct disassemble_info *info,
	   const struct nanomips_opcode *opcode,
	   enum nanomips_reg_operand_type type, int regno)
{
  switch (type)
    {
    case OP_REG_GP:
      info->fprintf_func (info->stream, "%s", nanomips_gpr_names[regno]);
      break;

    case OP_REG_FP:
      info->fprintf_func (info->stream, "%s", nanomips_fpr_names[regno]);
      break;

    case OP_REG_CCC:
      if (opcode->pinfo & (FP_D | FP_S))
	info->fprintf_func (info->stream, "$fcc%d", regno);
      else
	info->fprintf_func (info->stream, "$cc%d", regno);
      break;

    case OP_REG_VEC:
      info->fprintf_func (info->stream, "$v%d", regno);
      break;

    case OP_REG_ACC:
      info->fprintf_func (info->stream, "$ac%d", regno);
      break;

    case OP_REG_COPRO:
      if (opcode->name[strlen (opcode->name) - 1] == '1')
	info->fprintf_func (info->stream, "%s", nanomips_cp1_names[regno]);
      else
	info->fprintf_func (info->stream, "$%d", regno);
      break;

    case OP_REG_HW:
      info->fprintf_func (info->stream, "%s", nanomips_hwr_names[regno]);
      break;

    case OP_REG_VF:
      info->fprintf_func (info->stream, "$vf%d", regno);
      break;

    case OP_REG_VI:
      info->fprintf_func (info->stream, "$vi%d", regno);
      break;

    case OP_REG_MSA:
      info->fprintf_func (info->stream, "$w%d", regno);
      break;

    case OP_REG_MSA_CTRL:
      info->fprintf_func (info->stream, "%s", msa_control_names[regno]);
      break;

    case OP_REG_CP0:
      print_cp0_reg (info, regno);
      break;

    case OP_REG_CP0SEL:
      /* Need to check select bits againt mask, defer output to next operand.  */
      break;
    }
}

/* Used to track the state carried over from previous operands in
   an instruction.  */
struct nanomips_print_arg_state
{
  /* The value of the last OP_INT seen.  We only use this for OP_MSB,
     where the value is known to be unsigned and small.  */
  unsigned int last_int;

  /* The type and number of the last OP_REG seen.  We only use this for
     OP_REPEAT_DEST_REG and OP_REPEAT_PREV_REG.  */
  enum nanomips_reg_operand_type last_reg_type;
  unsigned int last_regno;
  unsigned int dest_regno;
  unsigned int seen_dest;
};

/* Initialize STATE for the start of an instruction.  */

static inline void
init_print_arg_state (struct nanomips_print_arg_state *state)
{
  memset (state, 0, sizeof (*state));
}

/* Record information about a register operand.  */

static void
nanomips_seen_register (struct nanomips_print_arg_state *state,
			unsigned int regno,
			enum nanomips_reg_operand_type reg_type)
{
  state->last_reg_type = reg_type;
  state->last_regno = regno;

  if (!state->seen_dest)
    {
      state->seen_dest = 1;
      state->dest_regno = regno;
    }
}

static void
nanomips_print_save_restore (struct disassemble_info *info,
			     unsigned int uval, bfd_boolean mode16)
{
  const fprintf_ftype infprintf = info->fprintf_func;
  void *is = info->stream;
  char *comma = ",";
  unsigned int pending = 0;
  unsigned int freg, fp, gp, ra;
  int count;
  fp = gp = ra = 0;

  if (mode16)
    {
      freg = 30 | (uval >> 4);
      count = uval & 0xf;
    }
  else
    {
      freg = (uval >> 6) & 0x1f;
      count = (uval >> 1) & 0xf;
      if (count > 0)
	gp = uval & 1;
    }

  if (freg == 30 && count > 0)
    fp = 1;
  if ((freg == 31 && count > 0) || (freg == 30 && count > 1))
    ra = 1;

  if (freg + count == 45)
    gp = 1;

  count = count - gp;
  if (fp && count > 0)
    {
      freg = (freg & 0x10) | ((freg + 1) % 32);
      count--;
    }

  if (ra && count > 0)
    {
      freg = (freg & 0x10) | ((freg + 1) % 32);
      count--;
    }

  if (fp)
    {
      infprintf (is, "%s", nanomips_gpr_names[30]);
      pending = 1;
    }

  if (ra)
    {
      infprintf (is, "%s%s", (pending ? comma : ""), nanomips_gpr_names[31]);
      pending = 1;
    }

  if (count > 0)
    {
      if (count > 1)
	infprintf (is, "%s%s-%s", (pending ? comma : ""),
		   nanomips_gpr_names[freg],
		   nanomips_gpr_names[freg + count - 1]);
      else
	infprintf (is, "%s%s", (pending ? comma : ""),
		   nanomips_gpr_names[freg]);
      pending = 1;
    }

  if (gp)
    infprintf (is, "%s%s", (pending ? comma : ""), nanomips_gpr_names[28]);
}

static void
nanomips_print_save_restore_fp (struct disassemble_info *info,
				unsigned int count)
{
  const fprintf_ftype infprintf = info->fprintf_func;
  void *is = info->stream;

  if (count == 1)
    infprintf (is, "%s", nanomips_fpr_names[0]);
  else
    infprintf (is, "%s-%s", nanomips_fpr_names[0],
	       nanomips_fpr_names[count - 1]);
}

/* Print operand OPERAND of OPCODE, using STATE to track inter-operand state.
   UVAL is the encoding of the operand (shifted into bit 0) and BASE_PC is
   the base address for OP_PCREL operands.  */

static void
print_insn_arg (struct disassemble_info *info,
		struct nanomips_print_arg_state *state,
		const struct nanomips_opcode *opcode,
		const struct nanomips_operand *operand,
		bfd_vma base_pc, unsigned int uval)
{
  const fprintf_ftype infprintf = info->fprintf_func;
  void *is = info->stream;

  switch (operand->type)
    {
    case OP_INT:
    case OP_IMM_INT:
      {
	const struct nanomips_int_operand *int_op;

	int_op = (const struct nanomips_int_operand *) operand;
	uval = nanomips_decode_int_operand (int_op, uval);
	state->last_int = uval;
	if (int_op->print_hex)
	  infprintf (is, "0x%x", uval);
	else
	  infprintf (is, "%d", uval);
      }
      break;

    case OP_MAPPED_INT:
      {
	const struct nanomips_mapped_int_operand *mint_op;

	mint_op = (const struct nanomips_mapped_int_operand *) operand;
	uval = mint_op->int_map[uval];
	state->last_int = uval;
	if (mint_op->print_hex)
	  infprintf (is, "0x%x", uval);
	else
	  infprintf (is, "%d", uval);
      }
      break;

    case OP_MSB:
      {
	const struct nanomips_msb_operand *msb_op;

	msb_op = (const struct nanomips_msb_operand *) operand;
	uval += msb_op->bias;
	if (msb_op->add_lsb)
	  uval -= state->last_int;
	infprintf (is, "%d", uval);
      }
      break;

    case OP_REG:
    case OP_OPTIONAL_REG:
    case OP_MAPPED_CHECK_PREV:
    case OP_BASE_CHECK_OFFSET:
      {
	const struct nanomips_reg_operand *reg_op;

	reg_op = (const struct nanomips_reg_operand *) operand;
	uval = nanomips_decode_reg_operand (reg_op, uval);
	print_reg (info, opcode, reg_op->reg_type, uval);

	nanomips_seen_register (state, uval, reg_op->reg_type);
      }
      break;

    case OP_REG_PAIR:
      {
	const struct nanomips_reg_pair_operand *pair_op;

	pair_op = (const struct nanomips_reg_pair_operand *) operand;
	print_reg (info, opcode, pair_op->reg_type, pair_op->reg1_map[uval]);
	infprintf (is, ",");
	print_reg (info, opcode, pair_op->reg_type, pair_op->reg2_map[uval]);
      }
      break;

    case OP_PCREL:
      {
	const struct nanomips_pcrel_operand *pcrel_op;

	pcrel_op = (const struct nanomips_pcrel_operand *) operand;
	info->target = nanomips_decode_pcrel_operand (pcrel_op, base_pc, uval);

	/* Preserve the ISA bit for the GDB disassembler,
	   otherwise clear it.  */
	if (info->flavour != bfd_target_unknown_flavour)
	  info->target &= -2;

	(*info->print_address_func) (info->target, info);
      }
      break;

    case OP_NON_ZERO_PCREL_S1:
      {
	const struct nanomips_pcrel_operand pcrel_op
	  = { {{OP_PCREL, operand->size, operand->lsb, 0, 0},
	       (1 << operand->size) - 1, 0, 1, TRUE}, 0, 0, 0 };

	if ((info->flags & INSN_HAS_RELOC) == 0)
	  info->target = nanomips_decode_pcrel_operand (&pcrel_op, base_pc, uval);
	else
	  info->target = 0;
	(*info->print_address_func) (info->target, info);
      }
      break;

    case OP_CHECK_PREV:
    case OP_NON_ZERO_REG:
      {
	print_reg (info, opcode, OP_REG_GP, uval & 31);
	nanomips_seen_register (state, uval, OP_REG_GP);
      }
      break;

    case OP_SAVE_RESTORE_LIST:
      nanomips_print_save_restore (info, uval, opcode->mask >> 16 == 0);
      break;

    case OP_SAVE_RESTORE_FP_LIST:
      nanomips_print_save_restore_fp (info, uval + 1);
      break;

    case OP_REPEAT_PREV_REG:
      print_reg (info, opcode, state->last_reg_type, state->last_regno);
      break;

    case OP_REPEAT_DEST_REG:
      print_reg (info, opcode, state->last_reg_type, state->dest_regno);
      break;

    case OP_HI20_PCREL:
      {
	info->target = nanomips_decode_hi20_pcrel_operand (operand, base_pc,
							   uval);

	/* Preserve the ISA bit for the GDB disassembler,
	   otherwise clear it.  */
	if (info->flavour != bfd_target_unknown_flavour)
	  info->target &= -2;

	(*info->print_address_func) (info->target, info);
      }
      break;

    case OP_HI20_SCALE:
      {
	uval = nanomips_decode_hi20_int_operand (operand, uval);
	state->last_int = uval;
	infprintf (is, "0x%x", uval & 0xfffff);
      }
      break;

    case OP_HI20_INT:
      {
	uval = nanomips_decode_hi20_int_operand (operand, uval);
	state->last_int = uval;
	if ((info->flags & INSN_HAS_RELOC) != 0 || uval == 0)
	  infprintf (is, "0x%x", uval & 0xfffff);
	else
	  infprintf (is, "%%hi(0x%x)", (uval & 0xfffff) << 12);
      }
      break;

    case OP_IMM_WORD:
      {
	const struct nanomips_int_operand *int_op;
	int_op = (const struct nanomips_int_operand *) operand;
	state->last_int = ((uval >> 16) & 0xffff) | (uval << 16);
	state->last_int += int_op->bias;
	infprintf (is, "%d", state->last_int);
      }
      break;

    case OP_INT_WORD:
    case OP_GPREL_WORD:
      {
	state->last_int = ((uval >> 16) & 0xffff) | (uval << 16);
	infprintf (is, "%d", state->last_int);
      }
      break;

    case OP_UINT_WORD:
      {
	state->last_int = ((uval >> 16) & 0xffff) | (uval << 16);
	infprintf (is, "0x%x", state->last_int);
      }
      break;

    case OP_PC_WORD:
      {
	info->target = base_pc + (((uval >> 16) & 0xffff) | (uval << 16));
	(*info->print_address_func) (info->target, info);
      }
      break;

    case OP_NEG_INT:
      infprintf (is, "-%d", uval);
      break;

    case OP_CP0SEL:
      print_cp0sel_reg (info, state->last_regno, uval);
      break;

    case OP_DONT_CARE:
    case OP_COPY_BITS:
    default:
      break;
    }
}

static bfd_boolean
validate_cp0_reg_operand (unsigned int uval)
{
  int i;
  unsigned int regno, select;
  regno = uval >> NANOMIPSOP_SH_CP0SEL;
  select = uval & NANOMIPSOP_MASK_CP0SEL;

  for (i = 0; nanomips_cp0_3264r6[i].name; i++)
    if (regno ==  nanomips_cp0_3264r6[i].num
	&& select == nanomips_cp0_3264r6[i].sel)
      break;
    else if (regno < nanomips_cp0_3264r6[i].num)
      return FALSE;

  if (nanomips_cp0_3264r6[i].name == NULL)
    return FALSE;

  return TRUE;
}

/* Validate the arguments for INSN, which is described by OPCODE.
   Use DECODE_OPERAND to get the encoding of each operand.  */

static bfd_boolean
validate_insn_args (const struct nanomips_opcode *opcode,
		    const struct nanomips_operand *(*decode_operand) (const char *),
		    unsigned int insn, struct disassemble_info *info)
{
  struct nanomips_print_arg_state state;
  const struct nanomips_operand *operand;
  const char *s;
  unsigned int uval;

  init_print_arg_state (&state);
  for (s = opcode->args; *s; ++s)
    {
      switch (*s)
	{
	case ',':
	case '(':
	case ')':
	  break;

	case '#':
	  ++s;
	  break;

	default:
	  operand = decode_operand (s);

	  if (!operand)
	    continue;

	  uval = nanomips_extract_operand (operand, insn);
	  switch (operand->type)
	    {
	    case OP_REG:
	    case OP_OPTIONAL_REG:
	    case OP_BASE_CHECK_OFFSET:
	      {
		const struct nanomips_reg_operand *reg_op;

		reg_op = (const struct nanomips_reg_operand *) operand;

		if (operand->type == OP_REG
		    && reg_op->reg_type == OP_REG_CP0
		    && !validate_cp0_reg_operand (uval))
		  return FALSE;

		uval = nanomips_decode_reg_operand (reg_op, uval);
		nanomips_seen_register (&state, uval, reg_op->reg_type);
	      }
	      break;

	    case OP_CHECK_PREV:
	      {
		const struct nanomips_check_prev_operand *prev_op
		  = (const struct nanomips_check_prev_operand *) operand;

		if (!prev_op->zero_ok && uval == 0)
		  return FALSE;

		if (((prev_op->less_than_ok && uval < state.last_regno)
		     || (prev_op->greater_than_ok && uval > state.last_regno)
		     || (prev_op->equal_ok && uval == state.last_regno)))
		  break;

		return FALSE;
	      }

	    case OP_MAPPED_CHECK_PREV:
	      {
		const struct nanomips_mapped_check_prev_operand *prev_op
		  = (const struct nanomips_mapped_check_prev_operand *) operand;
		unsigned int last_uval
		  = nanomips_encode_reg_operand (operand, state.last_regno);

		if (((prev_op->less_than_ok && uval < last_uval)
		     || (prev_op->greater_than_ok && uval > last_uval)
		     || (prev_op->equal_ok && uval == last_uval)))
		  break;

		return FALSE;
	      }

	    case OP_NON_ZERO_REG:
	      if (uval == 0)
		return FALSE;
	      break;

	    case OP_NON_ZERO_PCREL_S1:
	      if (uval == 0 && (info->flags & INSN_HAS_RELOC) == 0)
		return FALSE;
	      break;

	    case OP_SAVE_RESTORE_LIST:
	      {
		/* The operand for SAVE/RESTORE is split into 3 pieces
		   rather than just 2 but we only support a 2-way split
		   decode the last bit of the instruction here.  */
		if (opcode->mask >> 16 != 0 && ((insn >> 20) & 0x1) != 0)
		  return FALSE;
	      }
	      break;

	    case OP_IMM_INT:
	    case OP_IMM_WORD:
	    case OP_NEG_INT:
	    case OP_INT:
	    case OP_MAPPED_INT:
	    case OP_MSB:
	    case OP_REG_PAIR:
	    case OP_PCREL:
	    case OP_REPEAT_PREV_REG:
	    case OP_REPEAT_DEST_REG:
	    case OP_SAVE_RESTORE_FP_LIST:
	    case OP_HI20_INT:
	    case OP_HI20_PCREL:
	    case OP_INT_WORD:
	    case OP_UINT_WORD:
	    case OP_PC_WORD:
	    case OP_GPREL_WORD:
	    case OP_DONT_CARE:
	    case OP_HI20_SCALE:
	    case OP_COPY_BITS:
	    case OP_CP0SEL:
	      break;
	    }

	  if (*s == 'm' || *s == '+' || *s == '-' || *s == '`')
	    ++s;
	}
    }
  return TRUE;
}

/* Print the arguments for INSN, which is described by OPCODE.
   Use DECODE_OPERAND to get the encoding of each operand.  Use BASE_PC
   as the base of OP_PCREL operands, adjusting by LENGTH if the OP_PCREL
   operand is for a branch or jump.  */

static void
print_insn_args (struct disassemble_info *info,
		 const struct nanomips_opcode *opcode,
		 const struct nanomips_operand *(*decode_operand) (const char *),
		 bfd_uint64_t insn, bfd_vma insn_pc, unsigned int length)
{
  const fprintf_ftype infprintf = info->fprintf_func;
  void *is = info->stream;
  struct nanomips_print_arg_state state;
  const struct nanomips_operand *operand;
  const char *s;
  bfd_boolean pending_sep = FALSE;
  bfd_boolean pending_space = TRUE;

  init_print_arg_state (&state);
  for (s = opcode->args; *s; ++s)
    {
      switch (*s)
	{
	case ',':
	  pending_sep = TRUE;
	  break;
	case '(':
	  if (pending_sep)
	    {
	      infprintf (is, ",");
	      pending_sep = FALSE;
	    }
	  /* fall-through */
	case ')':
	  infprintf (is, "%c", *s);
	  break;

	case '#':
	  ++s;
	  infprintf (is, "%c%c", *s, *s);
	  break;

	default:
	  operand = decode_operand (s);
	  if (!operand)
	    {
	      /* xgettext:c-format */
	      infprintf (is,
			 _("# internal error, undefined operand in `%s %s'"),
			 opcode->name, opcode->args);
	      return;
	    }

	  /* Defer printing the comma separator for CP0-select values since
	     the preceding register output is also defered.  */
	  if (operand->type != OP_DONT_CARE
	      && operand->type != OP_CP0SEL
	      && pending_sep)
	    {
	      infprintf (is, ",");
	      pending_sep = FALSE;
	    }

	  if (operand->type != OP_DONT_CARE && pending_space)
	    infprintf (is, "\t");
	  pending_space = FALSE;

	    {
	      bfd_vma base_pc = 0;
	      bfd_boolean have_reloc = ((info->flags & INSN_HAS_RELOC) != 0);

	      if (!have_reloc)
		base_pc = insn_pc;

	      if ((operand->type == OP_PCREL
		   || operand->type == OP_HI20_PCREL
		   || operand->type == OP_NON_ZERO_PCREL_S1
		   || operand->type == OP_PC_WORD)
		  && !have_reloc)
		base_pc += length;

	      if (operand->type == OP_INT_WORD
		  || operand->type == OP_UINT_WORD
		  || operand->type == OP_PC_WORD
		  || operand->type == OP_GPREL_WORD
		  || operand->type == OP_IMM_WORD)
		print_insn_arg (info, &state, opcode, operand, base_pc,
				insn >> 32);
	      else if (operand->type != OP_DONT_CARE)
		print_insn_arg (info, &state, opcode, operand, base_pc,
				nanomips_extract_operand (operand, insn));
	    }
	  if (*s == 'm' || *s == '+' || *s == '-' || *s == '`')
	    ++s;
	  break;
	}
    }
}



enum match_kind
{
  MATCH_NONE,
  MATCH_FULL,
  MATCH_SHORT
};

/* Disassemble nanoMIPS instructions.  */

static int
_print_insn_nanomips (bfd_vma memaddr_base, struct disassemble_info *info)
{
  const fprintf_ftype infprintf = info->fprintf_func;
  const struct nanomips_opcode *op, *opend;
  void *is = info->stream;
  bfd_byte buffer[2];
  bfd_uint64_t higher = 0;
  unsigned int length;
  int status;
  bfd_uint64_t insn;

  bfd_vma memaddr = memaddr_base;

  info->bytes_per_chunk = 2;
  info->display_endian = info->endian;
  info->insn_info_valid = 1;
  info->branch_delay_insns = 0;
  info->data_size = 0;
  info->insn_type = dis_nonbranch;
  info->target = 0;
  info->target2 = 0;

  status = (*info->read_memory_func) (memaddr, buffer, 2, info);
  if (status != 0)
    {
      (*info->memory_error_func) (status, memaddr, info);
      return -1;
    }

  length = 2;

  if (info->endian == BFD_ENDIAN_BIG)
    insn = bfd_getb16 (buffer);
  else
    insn = bfd_getl16 (buffer);

  if ((insn & 0xfc00) == 0x6000)
    {
      unsigned imm;
      /* This is a 48-bit nanoMIPS instruction. */
      status = (*info->read_memory_func) (memaddr + 2, buffer, 4, info);
      if (status != 0)
	{
	  infprintf (is, "0x%x (expected 48 bits): ", (unsigned) insn);
	  (*info->memory_error_func) (status, memaddr + 2, info);
	  return -1;
	}
      if (info->endian == BFD_ENDIAN_BIG)
	imm = bfd_getb16 (buffer);
      else
	imm = bfd_getl16 (buffer);
      higher = (imm << 16);

      status = (*info->read_memory_func) (memaddr + 4, buffer, 2, info);

      if (info->endian == BFD_ENDIAN_BIG)
	imm = bfd_getb16 (buffer);
      else
	imm = bfd_getl16 (buffer);
      higher = higher | imm;

      length += 4;
    }
  else if ((insn & 0x1000) == 0x0)
    {
      /* This is a 32-bit nanoMIPS instruction.  */
      higher = insn;

      status = (*info->read_memory_func) (memaddr + 2, buffer, 2, info);
      if (status != 0)
	{
	  infprintf (is, "0x%x (expected 32 bits): ", (unsigned) higher);
	  (*info->memory_error_func) (status, memaddr + 2, info);
	  return -1;
	}

      if (info->endian == BFD_ENDIAN_BIG)
	insn = bfd_getb16 (buffer);
      else
	insn = bfd_getl16 (buffer);

      insn = insn | (higher << 16);

      length += 2;
    }

  /* FIXME: Should probably use a hash table on the major opcode here.  */
  const struct nanomips_opcode *opcodes;
  int num_opcodes;
  struct nanomips_operand const *(*decode) (const char *);

  opcodes = nanomips_opcodes;
  num_opcodes = bfd_nanomips_num_opcodes;
  decode = decode_nanomips_operand;

  opend = opcodes + num_opcodes;
  for (op = opcodes; op < opend; op++)
    {
      if (op->pinfo != INSN_MACRO
	  && !(no_aliases && (op->pinfo2 & INSN2_ALIAS))
	  && (insn & op->mask) == op->match
	  && ((length == 2 && (op->mask & 0xffff0000) == 0)
	      || (length == 6
		  && (op->mask & 0xffff0000) == 0)
	      || (length == 4 && (op->mask & 0xffff0000) != 0)))
	{
	  if (!nanomips_opcode_is_member (op, nanomips_isa, nanomips_ase,
					  nanomips_processor)
	      || (op->pinfo2 & INSN2_CONVERTED_TO_COMPACT))
	    continue;

	  if (!validate_insn_args (op, decode, insn, info))
	    continue;

	  infprintf (is, "%s%s", op->name,
		     (show_arch_insn ? op->suffix : ""));

	  if (length == 6)
	    insn |= (higher << 32);

	  if (op->args[0])
	    print_insn_args (info, op, decode, insn, memaddr, length);

	  /* Figure out instruction type and branch delay information.  */
	  if ((op->pinfo
	       & (INSN_UNCOND_BRANCH_DELAY | INSN_COND_BRANCH_DELAY)) != 0)
	    info->branch_delay_insns = 1;
	  if (((op->pinfo & INSN_UNCOND_BRANCH_DELAY)
	       | (op->pinfo2 & INSN2_UNCOND_BRANCH)) != 0)
	    {
	      if ((op->pinfo & (INSN_WRITE_GPR_31 | INSN_WRITE_1)) != 0)
		info->insn_type = dis_jsr;
	      else
		info->insn_type = dis_branch;
	    }
	  else if (((op->pinfo & INSN_COND_BRANCH_DELAY)
		    | (op->pinfo2 & INSN2_COND_BRANCH)) != 0)
	    {
	      if ((op->pinfo & INSN_WRITE_GPR_31) != 0)
		info->insn_type = dis_condjsr;
	      else
		info->insn_type = dis_condbranch;
	    }
	  else if ((op->pinfo & (INSN_STORE_MEMORY | INSN_LOAD_MEMORY)) != 0)
	    info->insn_type = dis_dref;

	  return length;
	}
    }

  infprintf (is, "0x%x", (unsigned) insn);
  info->insn_type = dis_noninsn;

  return length;
}

int
print_insn_nanomips (bfd_vma memaddr, struct disassemble_info *info)
{
  set_default_nanomips_dis_options (info);
  parse_nanomips_dis_options (info->disassembler_options);

  return _print_insn_nanomips (memaddr, info);
}

void
print_nanomips_disassembler_options (FILE *stream)
{
  unsigned int i;

  fprintf (stream, _("\n\
The following nanoMIPS specific disassembler options are supported for use\n\
with the -M switch (multiple options should be separated by commas):\n"));

  fprintf (stream, _("\n\
  no-aliases     Use canonical instruction forms.\n"));

  fprintf (stream, _("\n\
  show-arch-insn Print extended mnemonics in disassembly including\n\
                 suffix as in the architecture reference manual.\n"));

  fprintf (stream, _("\n\
  msa            Recognize MSA instructions.\n"));

  fprintf (stream, _("\n\
  virt           Recognize the virtualization ASE instructions.\n"));

  fprintf (stream, _("\n\
  xpa            Recognize the eXtended Physical Address (XPA) ASE instructions.\n"));

  fprintf (stream, _("\n\
  mxu            Recognize the MXU ASE instructions.\n"));

  fprintf (stream, _("\n\
  gpr-names=ABI            Print GPR names according to  specified ABI.\n\
                           Default: based on binary being disassembled.\n"));

  fprintf (stream, _("\n\
  fpr-names=ABI            Print FPR names according to specified ABI.\n\
                           Default: numeric.\n"));

  fprintf (stream, _("\n\
  cp0-names=ARCH           Print CP0 register names according to\n\
                           specified architecture.\n\
                           Default: based on binary being disassembled.\n"));

  fprintf (stream, _("\n\
  hwr-names=ARCH           Print HWR names according to specified \n\
			   architecture.\n\
                           Default: based on binary being disassembled.\n"));

  fprintf (stream, _("\n\
  reg-names=ABI            Print GPR and FPR names according to\n\
                           specified ABI.\n"));

  fprintf (stream, _("\n\
  reg-names=ARCH           Print CP0 register and HWR names according to\n\
                           specified architecture.\n"));

  fprintf (stream, _("\n\
  For the options above, the following values are supported for \"ABI\":\n\
   "));
  for (i = 0; i < ARRAY_SIZE (nanomips_abi_choices); i++)
    fprintf (stream, " %s", nanomips_abi_choices[i].name);
  fprintf (stream, _("\n"));

  fprintf (stream, _("\n\
  For the options above, The following values are supported for \"ARCH\":\n\
   "));
  for (i = 0; i < ARRAY_SIZE (nanomips_arch_choices); i++)
    if (*nanomips_arch_choices[i].name != '\0')
      fprintf (stream, " %s", nanomips_arch_choices[i].name);
  fprintf (stream, _("\n"));

  fprintf (stream, _("\n"));
}
