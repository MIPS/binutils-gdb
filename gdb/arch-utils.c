/* Dynamic architecture support for GDB, the GNU debugger.

   Copyright 1998, 1999, 2000, 2001, 2002, 2003 Free Software Foundation,
   Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

#include "defs.h"

#if GDB_MULTI_ARCH
#include "arch-utils.h"
#include "gdbcmd.h"
#include "inferior.h"		/* enum CALL_DUMMY_LOCATION et.al. */
#else
/* Just include everything in sight so that the every old definition
   of macro is visible. */
#include "symtab.h"
#include "frame.h"
#include "inferior.h"
#include "breakpoint.h"
#include "gdb_wait.h"
#include "gdbcore.h"
#include "gdbcmd.h"
#include "target.h"
#include "annotate.h"
#endif
#include "gdb_string.h"
#include "regcache.h"
#include "gdb_assert.h"
#include "sim-regno.h"

#include "version.h"

#include "floatformat.h"

/* Implementation of extract return value that grubs around in the
   register cache.  */
void
legacy_extract_return_value (struct type *type, struct regcache *regcache,
			     void *valbuf)
{
  char *registers = deprecated_grub_regcache_for_registers (regcache);
  bfd_byte *buf = valbuf;
  DEPRECATED_EXTRACT_RETURN_VALUE (type, registers, buf); /* OK */
}

/* Implementation of store return value that grubs the register cache.
   Takes a local copy of the buffer to avoid const problems.  */
void
legacy_store_return_value (struct type *type, struct regcache *regcache,
			   const void *buf)
{
  bfd_byte *b = alloca (TYPE_LENGTH (type));
  gdb_assert (regcache == current_regcache);
  memcpy (b, buf, TYPE_LENGTH (type));
  DEPRECATED_STORE_RETURN_VALUE (type, b);
}


int
always_use_struct_convention (int gcc_p, struct type *value_type)
{
  return 1;
}


int
legacy_register_sim_regno (int regnum)
{
  /* Only makes sense to supply raw registers.  */
  gdb_assert (regnum >= 0 && regnum < NUM_REGS);
  /* NOTE: cagney/2002-05-13: The old code did it this way and it is
     suspected that some GDB/SIM combinations may rely on this
     behavour.  The default should be one2one_register_sim_regno
     (below).  */
  if (REGISTER_NAME (regnum) != NULL
      && REGISTER_NAME (regnum)[0] != '\0')
    return regnum;
  else
    return LEGACY_SIM_REGNO_IGNORE;
}

int
generic_frameless_function_invocation_not (struct frame_info *fi)
{
  return 0;
}

int
generic_return_value_on_stack_not (struct type *type)
{
  return 0;
}

CORE_ADDR
generic_skip_trampoline_code (CORE_ADDR pc)
{
  return 0;
}

int
generic_in_solib_call_trampoline (CORE_ADDR pc, char *name)
{
  return 0;
}

int
generic_in_solib_return_trampoline (CORE_ADDR pc, char *name)
{
  return 0;
}

int
generic_in_function_epilogue_p (struct gdbarch *gdbarch, CORE_ADDR pc)
{
  return 0;
}

const char *
legacy_register_name (int i)
{
#ifdef REGISTER_NAMES
  static char *names[] = REGISTER_NAMES;
  if (i < 0 || i >= (sizeof (names) / sizeof (*names)))
    return NULL;
  else
    return names[i];
#else
  internal_error (__FILE__, __LINE__,
		  "legacy_register_name: called.");
  return NULL;
#endif
}

#if defined (CALL_DUMMY)
LONGEST legacy_call_dummy_words[] = CALL_DUMMY;
#else
LONGEST legacy_call_dummy_words[1];
#endif
int legacy_sizeof_call_dummy_words = sizeof (legacy_call_dummy_words);

void
generic_remote_translate_xfer_address (struct gdbarch *gdbarch,
				       struct regcache *regcache,
				       CORE_ADDR gdb_addr, int gdb_len,
				       CORE_ADDR * rem_addr, int *rem_len)
{
  *rem_addr = gdb_addr;
  *rem_len = gdb_len;
}

int
generic_prologue_frameless_p (CORE_ADDR ip)
{
  return ip == SKIP_PROLOGUE (ip);
}

/* New/multi-arched targets should use the correct gdbarch field
   instead of using this global pointer. */
int
legacy_print_insn (bfd_vma vma, disassemble_info *info)
{
  return (*deprecated_tm_print_insn) (vma, info);
}

/* Helper functions for INNER_THAN */

int
core_addr_lessthan (CORE_ADDR lhs, CORE_ADDR rhs)
{
  return (lhs < rhs);
}

int
core_addr_greaterthan (CORE_ADDR lhs, CORE_ADDR rhs)
{
  return (lhs > rhs);
}


/* Helper functions for TARGET_{FLOAT,DOUBLE}_FORMAT */

const struct floatformat *
default_float_format (struct gdbarch *gdbarch)
{
#if GDB_MULTI_ARCH
  int byte_order = gdbarch_byte_order (gdbarch);
#else
  int byte_order = TARGET_BYTE_ORDER;
#endif
  switch (byte_order)
    {
    case BFD_ENDIAN_BIG:
      return &floatformat_ieee_single_big;
    case BFD_ENDIAN_LITTLE:
      return &floatformat_ieee_single_little;
    default:
      internal_error (__FILE__, __LINE__,
		      "default_float_format: bad byte order");
    }
}


const struct floatformat *
default_double_format (struct gdbarch *gdbarch)
{
#if GDB_MULTI_ARCH
  int byte_order = gdbarch_byte_order (gdbarch);
#else
  int byte_order = TARGET_BYTE_ORDER;
#endif
  switch (byte_order)
    {
    case BFD_ENDIAN_BIG:
      return &floatformat_ieee_double_big;
    case BFD_ENDIAN_LITTLE:
      return &floatformat_ieee_double_little;
    default:
      internal_error (__FILE__, __LINE__,
		      "default_double_format: bad byte order");
    }
}

/* Misc helper functions for targets. */

int
deprecated_register_convertible_not (int num)
{
  return 0;
}
  

/* Under some ABI's that specify the `struct convention' for returning
   structures by value, by the time we've returned from the function,
   the return value is sitting there in the caller's buffer, but GDB
   has no way to find the address of that buffer.

   On such architectures, use this function as your
   extract_struct_value_address method.  When asked to a struct
   returned by value in this fashion, GDB will print a nice error
   message, instead of garbage.  */
CORE_ADDR
generic_cannot_extract_struct_value_address (char *dummy)
{
  return 0;
}

CORE_ADDR
core_addr_identity (CORE_ADDR addr)
{
  return addr;
}

int
no_op_reg_to_regnum (int reg)
{
  return reg;
}

CORE_ADDR
init_frame_pc_noop (int fromleaf, struct frame_info *prev)
{
  /* Do nothing, implies return the same PC value.  */
  return get_frame_pc (prev);
}

CORE_ADDR
init_frame_pc_default (int fromleaf, struct frame_info *prev)
{
  if (fromleaf && DEPRECATED_SAVED_PC_AFTER_CALL_P ())
    return DEPRECATED_SAVED_PC_AFTER_CALL (get_next_frame (prev));
  else if (get_next_frame (prev) != NULL)
    return DEPRECATED_FRAME_SAVED_PC (get_next_frame (prev));
  else
    return read_pc ();
}

void
default_elf_make_msymbol_special (asymbol *sym, struct minimal_symbol *msym)
{
  return;
}

void
default_coff_make_msymbol_special (int val, struct minimal_symbol *msym)
{
  return;
}

int
cannot_register_not (int regnum)
{
  return 0;
}

/* Legacy version of target_virtual_frame_pointer().  Assumes that
   there is an DEPRECATED_FP_REGNUM and that it is the same, cooked or
   raw.  */

void
legacy_virtual_frame_pointer (CORE_ADDR pc,
			      int *frame_regnum,
			      LONGEST *frame_offset)
{
  /* FIXME: cagney/2002-09-13: This code is used when identifying the
     frame pointer of the current PC.  It is assuming that a single
     register and an offset can determine this.  I think it should
     instead generate a byte code expression as that would work better
     with things like Dwarf2's CFI.  */
  if (DEPRECATED_FP_REGNUM >= 0 && DEPRECATED_FP_REGNUM < NUM_REGS)
    *frame_regnum = DEPRECATED_FP_REGNUM;
  else if (SP_REGNUM >= 0 && SP_REGNUM < NUM_REGS)
    *frame_regnum = SP_REGNUM;
  else
    /* Should this be an internal error?  I guess so, it is reflecting
       an architectural limitation in the current design.  */
    internal_error (__FILE__, __LINE__, "No virtual frame pointer available");
  *frame_offset = 0;
}

/* Assume the world is sane, every register's virtual and real size
   is identical.  */

int
generic_register_size (int regnum)
{
  gdb_assert (regnum >= 0 && regnum < NUM_REGS + NUM_PSEUDO_REGS);
  if (gdbarch_register_type_p (current_gdbarch))
    return TYPE_LENGTH (gdbarch_register_type (current_gdbarch, regnum));
  else
    /* FIXME: cagney/2003-03-01: Once all architectures implement
       gdbarch_register_type(), this entire function can go away.  It
       is made obsolete by register_size().  */
    return TYPE_LENGTH (REGISTER_VIRTUAL_TYPE (regnum)); /* OK */
}

/* Assume all registers are adjacent.  */

int
generic_register_byte (int regnum)
{
  int byte;
  int i;
  gdb_assert (regnum >= 0 && regnum < NUM_REGS + NUM_PSEUDO_REGS);
  byte = 0;
  for (i = 0; i < regnum; i++)
    {
      byte += generic_register_size (i);
    }
  return byte;
}


int
legacy_pc_in_sigtramp (CORE_ADDR pc, char *name)
{
#if !defined (IN_SIGTRAMP)
  if (SIGTRAMP_START_P ())
    return (pc) >= SIGTRAMP_START (pc) && (pc) < SIGTRAMP_END (pc);
  else
    return name && strcmp ("_sigtramp", name) == 0;
#else
  return IN_SIGTRAMP (pc, name);
#endif
}

int
legacy_convert_register_p (int regnum, struct type *type)
{
  return DEPRECATED_REGISTER_CONVERTIBLE (regnum);
}

void
legacy_register_to_value (struct frame_info *frame, int regnum,
			  struct type *type, void *to)
{
  char from[MAX_REGISTER_SIZE];
  frame_read_register (frame, regnum, from);
  DEPRECATED_REGISTER_CONVERT_TO_VIRTUAL (regnum, type, from, to);
}

void
legacy_value_to_register (struct frame_info *frame, int regnum,
			  struct type *type, const void *tmp)
{
  char to[MAX_REGISTER_SIZE];
  char *from = alloca (TYPE_LENGTH (type));
  memcpy (from, from, TYPE_LENGTH (type));
  DEPRECATED_REGISTER_CONVERT_TO_RAW (type, regnum, from, to);
  put_frame_register (frame, regnum, to);
}


/* Functions to manipulate the endianness of the target.  */

/* ``target_byte_order'' is only used when non- multi-arch.
   Multi-arch targets obtain the current byte order using the
   TARGET_BYTE_ORDER gdbarch method.

   The choice of initial value is entirely arbitrary.  During startup,
   the function initialize_current_architecture() updates this value
   based on default byte-order information extracted from BFD.  */
int target_byte_order = BFD_ENDIAN_BIG;
int target_byte_order_auto = 1;

static const char endian_big[] = "big";
static const char endian_little[] = "little";
static const char endian_auto[] = "auto";
static const char *endian_enum[] =
{
  endian_big,
  endian_little,
  endian_auto,
  NULL,
};
static const char *set_endian_string;

/* Called by ``show endian''.  */

static void
show_endian (char *args, int from_tty)
{
  if (TARGET_BYTE_ORDER_AUTO)
    printf_unfiltered ("The target endianness is set automatically (currently %s endian)\n",
		       (TARGET_BYTE_ORDER == BFD_ENDIAN_BIG ? "big" : "little"));
  else
    printf_unfiltered ("The target is assumed to be %s endian\n",
		       (TARGET_BYTE_ORDER == BFD_ENDIAN_BIG ? "big" : "little"));
}

static void
set_endian (char *ignore_args, int from_tty, struct cmd_list_element *c)
{
  if (set_endian_string == endian_auto)
    {
      target_byte_order_auto = 1;
    }
  else if (set_endian_string == endian_little)
    {
      target_byte_order_auto = 0;
      if (GDB_MULTI_ARCH)
	{
	  struct gdbarch_info info;
	  gdbarch_info_init (&info);
	  info.byte_order = BFD_ENDIAN_LITTLE;
	  if (! gdbarch_update_p (info))
	    {
	      printf_unfiltered ("Little endian target not supported by GDB\n");
	    }
	}
      else
	{
	  target_byte_order = BFD_ENDIAN_LITTLE;
	}
    }
  else if (set_endian_string == endian_big)
    {
      target_byte_order_auto = 0;
      if (GDB_MULTI_ARCH)
	{
	  struct gdbarch_info info;
	  gdbarch_info_init (&info);
	  info.byte_order = BFD_ENDIAN_BIG;
	  if (! gdbarch_update_p (info))
	    {
	      printf_unfiltered ("Big endian target not supported by GDB\n");
	    }
	}
      else
	{
	  target_byte_order = BFD_ENDIAN_BIG;
	}
    }
  else
    internal_error (__FILE__, __LINE__,
		    "set_endian: bad value");
  show_endian (NULL, from_tty);
}

/* Set the endianness from a BFD.  */

static void
set_endian_from_file (bfd *abfd)
{
  int want;
  if (GDB_MULTI_ARCH)
    internal_error (__FILE__, __LINE__,
		    "set_endian_from_file: not for multi-arch");
  if (bfd_big_endian (abfd))
    want = BFD_ENDIAN_BIG;
  else
    want = BFD_ENDIAN_LITTLE;
  if (TARGET_BYTE_ORDER_AUTO)
    target_byte_order = want;
  else if (TARGET_BYTE_ORDER != want)
    warning ("%s endian file does not match %s endian target.",
	     want == BFD_ENDIAN_BIG ? "big" : "little",
	     TARGET_BYTE_ORDER == BFD_ENDIAN_BIG ? "big" : "little");
}


/* Functions to manipulate the architecture of the target */

enum set_arch { set_arch_auto, set_arch_manual };

int target_architecture_auto = 1;

const char *set_architecture_string;

/* Old way of changing the current architecture. */

extern const struct bfd_arch_info bfd_default_arch_struct;
const struct bfd_arch_info *target_architecture = &bfd_default_arch_struct;
int (*target_architecture_hook) (const struct bfd_arch_info *ap);

static int
arch_ok (const struct bfd_arch_info *arch)
{
  if (GDB_MULTI_ARCH)
    internal_error (__FILE__, __LINE__,
		    "arch_ok: not multi-arched");
  /* Should be performing the more basic check that the binary is
     compatible with GDB. */
  /* Check with the target that the architecture is valid. */
  return (target_architecture_hook == NULL
	  || target_architecture_hook (arch));
}

static void
set_arch (const struct bfd_arch_info *arch,
          enum set_arch type)
{
  if (GDB_MULTI_ARCH)
    internal_error (__FILE__, __LINE__,
		    "set_arch: not multi-arched");
  switch (type)
    {
    case set_arch_auto:
      if (!arch_ok (arch))
	warning ("Target may not support %s architecture",
		 arch->printable_name);
      target_architecture = arch;
      break;
    case set_arch_manual:
      if (!arch_ok (arch))
	{
	  printf_unfiltered ("Target does not support `%s' architecture.\n",
			     arch->printable_name);
	}
      else
	{
	  target_architecture_auto = 0;
	  target_architecture = arch;
	}
      break;
    }
  if (gdbarch_debug)
    gdbarch_dump (current_gdbarch, gdb_stdlog);
}

/* Set the architecture from arch/machine (deprecated) */

void
set_architecture_from_arch_mach (enum bfd_architecture arch,
				 unsigned long mach)
{
  const struct bfd_arch_info *wanted = bfd_lookup_arch (arch, mach);
  if (GDB_MULTI_ARCH)
    internal_error (__FILE__, __LINE__,
		    "set_architecture_from_arch_mach: not multi-arched");
  if (wanted != NULL)
    set_arch (wanted, set_arch_manual);
  else
    internal_error (__FILE__, __LINE__,
		    "gdbarch: hardwired architecture/machine not recognized");
}

/* Set the architecture from a BFD (deprecated) */

static void
set_architecture_from_file (bfd *abfd)
{
  const struct bfd_arch_info *wanted = bfd_get_arch_info (abfd);
  if (GDB_MULTI_ARCH)
    internal_error (__FILE__, __LINE__,
		    "set_architecture_from_file: not multi-arched");
  if (target_architecture_auto)
    {
      set_arch (wanted, set_arch_auto);
    }
  else if (wanted != target_architecture)
    {
      warning ("%s architecture file may be incompatible with %s target.",
	       wanted->printable_name,
	       target_architecture->printable_name);
    }
}


/* Called if the user enters ``show architecture'' without an
   argument. */

static void
show_architecture (char *args, int from_tty)
{
  const char *arch;
  arch = TARGET_ARCHITECTURE->printable_name;
  if (target_architecture_auto)
    printf_filtered ("The target architecture is set automatically (currently %s)\n", arch);
  else
    printf_filtered ("The target architecture is assumed to be %s\n", arch);
}


/* Called if the user enters ``set architecture'' with or without an
   argument. */

static void
set_architecture (char *ignore_args, int from_tty, struct cmd_list_element *c)
{
  if (strcmp (set_architecture_string, "auto") == 0)
    {
      target_architecture_auto = 1;
    }
  else if (GDB_MULTI_ARCH)
    {
      struct gdbarch_info info;
      gdbarch_info_init (&info);
      info.bfd_arch_info = bfd_scan_arch (set_architecture_string);
      if (info.bfd_arch_info == NULL)
	internal_error (__FILE__, __LINE__,
			"set_architecture: bfd_scan_arch failed");
      if (gdbarch_update_p (info))
	target_architecture_auto = 0;
      else
	printf_unfiltered ("Architecture `%s' not recognized.\n",
			   set_architecture_string);
    }
  else
    {
      const struct bfd_arch_info *arch
	= bfd_scan_arch (set_architecture_string);
      if (arch == NULL)
	internal_error (__FILE__, __LINE__,
			"set_architecture: bfd_scan_arch failed");
      set_arch (arch, set_arch_manual);
    }
  show_architecture (NULL, from_tty);
}

/* Set the dynamic target-system-dependent parameters (architecture,
   byte-order) using information found in the BFD */

void
set_gdbarch_from_file (bfd *abfd)
{
  if (GDB_MULTI_ARCH)
    {
      struct gdbarch_info info;
      gdbarch_info_init (&info);
      info.abfd = abfd;
      if (! gdbarch_update_p (info))
	error ("Architecture of file not recognized.\n");
    }
  else
    {
      set_architecture_from_file (abfd);
      set_endian_from_file (abfd);
    }
}

/* Initialize the current architecture.  Update the ``set
   architecture'' command so that it specifies a list of valid
   architectures.  */

#ifdef DEFAULT_BFD_ARCH
extern const bfd_arch_info_type DEFAULT_BFD_ARCH;
static const bfd_arch_info_type *default_bfd_arch = &DEFAULT_BFD_ARCH;
#else
static const bfd_arch_info_type *default_bfd_arch;
#endif

#ifdef DEFAULT_BFD_VEC
extern const bfd_target DEFAULT_BFD_VEC;
static const bfd_target *default_bfd_vec = &DEFAULT_BFD_VEC;
#else
static const bfd_target *default_bfd_vec;
#endif

void
initialize_current_architecture (void)
{
  const char **arches = gdbarch_printable_names ();

  /* determine a default architecture and byte order. */
  struct gdbarch_info info;
  gdbarch_info_init (&info);
  
  /* Find a default architecture. */
  if (info.bfd_arch_info == NULL
      && default_bfd_arch != NULL)
    info.bfd_arch_info = default_bfd_arch;
  if (info.bfd_arch_info == NULL)
    {
      /* Choose the architecture by taking the first one
	 alphabetically. */
      const char *chosen = arches[0];
      const char **arch;
      for (arch = arches; *arch != NULL; arch++)
	{
	  if (strcmp (*arch, chosen) < 0)
	    chosen = *arch;
	}
      if (chosen == NULL)
	internal_error (__FILE__, __LINE__,
			"initialize_current_architecture: No arch");
      info.bfd_arch_info = bfd_scan_arch (chosen);
      if (info.bfd_arch_info == NULL)
	internal_error (__FILE__, __LINE__,
			"initialize_current_architecture: Arch not found");
    }

  /* Take several guesses at a byte order.  */
  if (info.byte_order == BFD_ENDIAN_UNKNOWN
      && default_bfd_vec != NULL)
    {
      /* Extract BFD's default vector's byte order. */
      switch (default_bfd_vec->byteorder)
	{
	case BFD_ENDIAN_BIG:
	  info.byte_order = BFD_ENDIAN_BIG;
	  break;
	case BFD_ENDIAN_LITTLE:
	  info.byte_order = BFD_ENDIAN_LITTLE;
	  break;
	default:
	  break;
	}
    }
  if (info.byte_order == BFD_ENDIAN_UNKNOWN)
    {
      /* look for ``*el-*'' in the target name. */
      const char *chp;
      chp = strchr (target_name, '-');
      if (chp != NULL
	  && chp - 2 >= target_name
	  && strncmp (chp - 2, "el", 2) == 0)
	info.byte_order = BFD_ENDIAN_LITTLE;
    }
  if (info.byte_order == BFD_ENDIAN_UNKNOWN)
    {
      /* Wire it to big-endian!!! */
      info.byte_order = BFD_ENDIAN_BIG;
    }

  if (GDB_MULTI_ARCH)
    {
      if (! gdbarch_update_p (info))
	{
	  internal_error (__FILE__, __LINE__,
			  "initialize_current_architecture: Selection of initial architecture failed");
	}
    }
  else
    {
      /* If the multi-arch logic comes up with a byte-order (from BFD)
         use it for the non-multi-arch case.  */
      if (info.byte_order != BFD_ENDIAN_UNKNOWN)
	target_byte_order = info.byte_order;
      initialize_non_multiarch ();
    }

  /* Create the ``set architecture'' command appending ``auto'' to the
     list of architectures. */
  {
    struct cmd_list_element *c;
    /* Append ``auto''. */
    int nr;
    for (nr = 0; arches[nr] != NULL; nr++);
    arches = xrealloc (arches, sizeof (char*) * (nr + 2));
    arches[nr + 0] = "auto";
    arches[nr + 1] = NULL;
    /* FIXME: add_set_enum_cmd() uses an array of ``char *'' instead
       of ``const char *''.  We just happen to know that the casts are
       safe. */
    c = add_set_enum_cmd ("architecture", class_support,
			  arches, &set_architecture_string,
			  "Set architecture of target.",
			  &setlist);
    set_cmd_sfunc (c, set_architecture);
    add_alias_cmd ("processor", "architecture", class_support, 1, &setlist);
    /* Don't use set_from_show - need to print both auto/manual and
       current setting. */
    add_cmd ("architecture", class_support, show_architecture,
	     "Show the current target architecture", &showlist);
  }
}


/* Initialize a gdbarch info to values that will be automatically
   overridden.  Note: Originally, this ``struct info'' was initialized
   using memset(0).  Unfortunatly, that ran into problems, namely
   BFD_ENDIAN_BIG is zero.  An explicit initialization function that
   can explicitly set each field to a well defined value is used.  */

void
gdbarch_info_init (struct gdbarch_info *info)
{
  memset (info, 0, sizeof (struct gdbarch_info));
  info->byte_order = BFD_ENDIAN_UNKNOWN;
  info->osabi = GDB_OSABI_UNINITIALIZED;
}

/* */

extern initialize_file_ftype _initialize_gdbarch_utils; /* -Wmissing-prototypes */

void
_initialize_gdbarch_utils (void)
{
  struct cmd_list_element *c;
  c = add_set_enum_cmd ("endian", class_support,
			endian_enum, &set_endian_string,
			"Set endianness of target.",
			&setlist);
  set_cmd_sfunc (c, set_endian);
  /* Don't use set_from_show - need to print both auto/manual and
     current setting. */
  add_cmd ("endian", class_support, show_endian,
	   "Show the current byte-order", &showlist);
}
