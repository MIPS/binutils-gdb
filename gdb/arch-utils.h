/* Dynamic architecture support for GDB, the GNU debugger.

   Copyright 1998, 1999, 2000, 2002 Free Software Foundation, Inc.

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

#ifndef GDBARCH_UTILS_H
#define GDBARCH_UTILS_H

struct gdbarch;
struct frame_info;
struct minimal_symbol;
struct type;
struct gdbarch_info;

/* gdbarch trace variable */
extern int gdbarch_debug;

/* Fallback for register convertible. */
extern gdbarch_register_convertible_ftype generic_register_convertible_not;

extern CORE_ADDR generic_cannot_extract_struct_value_address (char *dummy);

/* Helper function for targets that don't know how my arguments are
   being passed */
extern gdbarch_frame_num_args_ftype frame_num_args_unknown;

/* Implementation of extract return value that grubs around in the
   register cache.  */
extern gdbarch_extract_return_value_ftype legacy_extract_return_value;

/* Implementation of store return value that grubs the register cache.  */
extern gdbarch_store_return_value_ftype legacy_store_return_value;

/* Frameless functions not identifable. */
extern gdbarch_frameless_function_invocation_ftype generic_frameless_function_invocation_not;

/* Only structures, unions, and arrays are returned using the struct
   convention.  Note that arrays are never passed by value in the C
   language family, so that case is irrelevant for C.  */
extern gdbarch_return_value_on_stack_ftype generic_return_value_on_stack_not;

/* Map onto old REGISTER_NAMES. */
extern const char *legacy_register_name (int i);

/* Accessor for old global function pointer for disassembly. */
extern int legacy_print_insn (bfd_vma vma, disassemble_info *info);

/* Backward compatible call_dummy_words. */
extern LONGEST legacy_call_dummy_words[];
extern int legacy_sizeof_call_dummy_words;

/* Typical remote_translate_xfer_address */
extern gdbarch_remote_translate_xfer_address_ftype generic_remote_translate_xfer_address;

/* Generic implementation of prologue_frameless_p.  Just calls
   SKIP_PROLOG and checks the return value to see if it actually
   changed. */
extern gdbarch_prologue_frameless_p_ftype generic_prologue_frameless_p;

/* The only possible cases for inner_than. */
extern int core_addr_lessthan (CORE_ADDR lhs, CORE_ADDR rhs);
extern int core_addr_greaterthan (CORE_ADDR lhs, CORE_ADDR rhs);

/* Floating point values. */
extern const struct floatformat *default_float_format (struct gdbarch *gdbarch);
extern const struct floatformat *default_double_format (struct gdbarch *gdbarch);

/* Helper function for targets that don't know how my arguments are
   being passed */
extern int frame_num_args_unknown (struct frame_info *fi);


/* The following DEPRECATED interfaces are for pre- multi-arch legacy
   targets. */

/* DEPRECATED pre- multi-arch interface.  Explicitly set the dynamic
   target-system-dependent parameters based on bfd_architecture and
   machine.  This function is deprecated, use
   set_gdbarch_from_arch_machine(). */

extern void set_architecture_from_arch_mach (enum bfd_architecture, unsigned long);

/* DEPRECATED pre- multi-arch interface.  Notify the target dependent
   backend of a change to the selected architecture. A zero return
   status indicates that the target did not like the change. */

extern int (*target_architecture_hook) (const struct bfd_arch_info *);

/* Identity function on a CORE_ADDR.  Just returns its parameter.  */

extern CORE_ADDR core_addr_identity (CORE_ADDR addr);

/* No-op conversion of reg to regnum. */

extern int no_op_reg_to_regnum (int reg);

/* Default prepare_to_procced. */

extern int default_prepare_to_proceed (int select_it);

extern int generic_prepare_to_proceed (int select_it);

/* Versions of init_frame_pc().  Do nothing; do the default. */

extern CORE_ADDR init_frame_pc_noop (int fromleaf, struct frame_info *prev);

extern CORE_ADDR init_frame_pc_default (int fromleaf, struct frame_info *prev);

/* Do nothing version of elf_make_msymbol_special. */

void default_elf_make_msymbol_special (asymbol *sym, struct minimal_symbol *msym);

/* Do nothing version of coff_make_msymbol_special. */

void default_coff_make_msymbol_special (int val, struct minimal_symbol *msym);

/* Version of cannot_fetch_register() / cannot_store_register() that
   always fails. */

int cannot_register_not (int regnum);

/* Legacy version of target_virtual_frame_pointer().  Assumes that
   there is an DEPRECATED_FP_REGNUM and that it is the same, cooked or
   raw.  */

extern gdbarch_virtual_frame_pointer_ftype legacy_virtual_frame_pointer;

extern CORE_ADDR generic_skip_trampoline_code (CORE_ADDR pc);

extern int generic_in_solib_call_trampoline (CORE_ADDR pc, char *name);

extern int generic_in_solib_return_trampoline (CORE_ADDR pc, char *name);

extern int generic_in_function_epilogue_p (struct gdbarch *gdbarch, CORE_ADDR pc);

/* Assume that the world is sane, a registers raw and virtual size
   both match its type.  */

extern int generic_register_size (int regnum);

/* Assume that the world is sane, the registers are all adjacent.  */
extern int generic_register_byte (int regnum);

/* Prop up old targets that use various IN_SIGTRAMP() macros.  */
extern int legacy_pc_in_sigtramp (CORE_ADDR pc, char *name);

/* The orginal register_convert*() functions were overloaded.  They
   were used to both: convert between virtual and raw register formats
   (something that is discouraged); and to convert a register to the
   type of a corresponding variable.  These legacy functions preserve
   that overloaded behavour in existing targets.  */
extern int legacy_convert_register_p (int regnum, struct type *type);
extern void legacy_register_to_value (struct frame_info *frame, int regnum,
				      struct type *type, void *to);
extern void legacy_value_to_register (struct frame_info *frame, int regnum,
				      struct type *type, const void *from);

/* For compatibility with older architectures, returns
   (LEGACY_SIM_REGNO_IGNORE) when the register doesn't have a valid
   name.  */

extern int legacy_register_sim_regno (int regnum);

/* Initialize a ``struct info''.  Can't use memset(0) since some
   default values are not zero.  */
extern void gdbarch_info_init (struct gdbarch_info *info);

#endif
