// nanomips.h -- ELF definitions specific to EM_NANOMIPS  -*- C++ -*-

// Copyright (C) 2017 Free Software Foundation, Inc.
// Written by Vladimir Radosavljevic <vladimir.radosavljevic@imgtec.com>

// This file is part of elfcpp.

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Library General Public License
// as published by the Free Software Foundation; either version 2, or
// (at your option) any later version.

// In addition to the permissions in the GNU Library General Public
// License, the Free Software Foundation gives you unlimited
// permission to link the compiled version of this file into
// combinations with other programs, and to distribute those
// combinations without any restriction coming from the use of this
// file.  (The Library Public License restrictions do apply in other
// respects; for example, they cover modification of the file, and
/// distribution when not linked into a combined executable.)

// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Library General Public License for more details.

// You should have received a copy of the GNU Library General Public
// License along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
// 02110-1301, USA.

#ifndef ELFCPP_NANOMIPS_H
#define ELFCPP_NANOMIPS_H

namespace elfcpp
{

//
// nanoMIPS Relocation Codes
//

enum
{
  R_NANOMIPS_NONE = 0,
  R_NANOMIPS_32 = 1,
  R_NANOMIPS_64 = 2,
  R_NANOMIPS_NEG = 3,
  R_NANOMIPS_ASHIFTR_1 = 4,
  R_NANOMIPS_UNSIGNED_8 = 5,
  R_NANOMIPS_SIGNED_8 = 6,
  R_NANOMIPS_UNSIGNED_16 = 7,
  R_NANOMIPS_SIGNED_16 = 8,
  R_NANOMIPS_RELATIVE = 9,
  R_NANOMIPS_GLOBAL = 10,
  R_NANOMIPS_JUMP_SLOT = 11,
  R_NANOMIPS_IRELATIVE = 12,
  R_NANOMIPS_PC25_S1 = 13,
  R_NANOMIPS_PC21_S1 = 14,
  R_NANOMIPS_PC14_S1 = 15,
  R_NANOMIPS_PC11_S1 = 16,
  R_NANOMIPS_PC10_S1 = 17,
  R_NANOMIPS_PC7_S1 = 18,
  R_NANOMIPS_PC4_S1 = 19,
  R_NANOMIPS_GPREL19_S2 = 20,
  R_NANOMIPS_GPREL18_S3 = 21,
  R_NANOMIPS_GPREL18 = 22,
  R_NANOMIPS_GPREL17_S1 = 23,
  R_NANOMIPS_GPREL16_S2 = 24,
  R_NANOMIPS_GPREL7_S2 = 25,
  R_NANOMIPS_GPREL_HI20 = 26,
  R_NANOMIPS_PC_HI20 = 27,
  R_NANOMIPS_HI20 = 28,
  R_NANOMIPS_LO12 = 29,
  R_NANOMIPS_GPREL_I32 = 30,
  R_NANOMIPS_PC_I32 = 31,
  R_NANOMIPS_I32 = 32,
  R_NANOMIPS_ALIGN = 64,
  R_NANOMIPS_FILL = 65,
  R_NANOMIPS_MAX = 66,
  R_NANOMIPS_INSN32 = 67,
  R_NANOMIPS_FIXED = 68,
  R_NANOMIPS_NORELAX = 69,
  R_NANOMIPS_RELAX = 70,
  R_NANOMIPS_SAVERESTORE = 71,
  R_NANOMIPS_INSN16 = 72,
  R_NANOMIPS_GPREL_LO12 = 100,
  R_NANOMIPS_LO4_S2 = 101,
};

// Processor specific flags for the ELF header e_flags field.
enum
{
  // At least one .noreorder directive appears in the source.
  EF_MIPS_NOREORDER = 0x00000001,
  // File contains position independent code.
  EF_MIPS_PIC = 0x00000002,
  // Code in file uses the standard calling sequence for calling
  // position independent code.
  EF_MIPS_CPIC = 0x00000004,
  // ???  Unknown flag, set in IRIX 6's BSDdup2.o in libbsd.a.
  EF_MIPS_XGOT = 0x00000008,
  // Code in file uses UCODE (obsolete)
  EF_MIPS_UCODE = 0x00000010,
  // Code in file uses new ABI (-n32 on Irix 6).
  EF_MIPS_ABI2 = 0x00000020,
  // Process the .MIPS.options section first by ld
  EF_MIPS_OPTIONS_FIRST = 0x00000080,
  // Architectural Extensions used by this file
  EF_MIPS_ARCH_ASE = 0x0f000000,
  // Use MDMX multimedia extensions
  EF_MIPS_ARCH_ASE_MDMX = 0x08000000,
  // Use MIPS-16 ISA extensions
  EF_MIPS_ARCH_ASE_M16 = 0x04000000,
  // Use MICROMIPS ISA extensions.
  EF_MIPS_ARCH_ASE_MICROMIPS = 0x02000000,
  // Indicates code compiled for a 64-bit machine in 32-bit mode.
  // (regs are 32-bits wide.)
  EF_MIPS_32BITMODE = 0x00000100,
  // 32-bit machine but FP registers are 64 bit (-mfp64).
  EF_MIPS_FP64 = 0x00000200,
  /// Code in file uses the IEEE 754-2008 NaN encoding convention.
  EF_MIPS_NAN2008 = 0x00000400,
  // MIPS dynamic
  EF_MIPS_DYNAMIC = 0x40
};

// Machine variant if we know it.  This field was invented at Cygnus,
// but it is hoped that other vendors will adopt it.  If some standard
// is developed, this code should be changed to follow it.
enum
{
  EF_MIPS_MACH = 0x00FF0000,

// Cygnus is choosing values between 80 and 9F;
// 00 - 7F should be left for a future standard;
// the rest are open.

  E_MIPS_MACH_3900 = 0x00810000,
  E_MIPS_MACH_4010 = 0x00820000,
  E_MIPS_MACH_4100 = 0x00830000,
  E_MIPS_MACH_4650 = 0x00850000,
  E_MIPS_MACH_4120 = 0x00870000,
  E_MIPS_MACH_4111 = 0x00880000,
  E_MIPS_MACH_SB1 = 0x008a0000,
  E_MIPS_MACH_OCTEON = 0x008b0000,
  E_MIPS_MACH_XLR = 0x008c0000,
  E_MIPS_MACH_OCTEON2 = 0x008d0000,
  E_MIPS_MACH_OCTEON3 = 0x008e0000,
  E_MIPS_MACH_5400 = 0x00910000,
  E_MIPS_MACH_5900 = 0x00920000,
  E_MIPS_MACH_5500 = 0x00980000,
  E_MIPS_MACH_9000 = 0x00990000,
  E_MIPS_MACH_LS2E = 0x00A00000,
  E_MIPS_MACH_LS2F = 0x00A10000,
  E_MIPS_MACH_LS3A = 0x00A20000,
};

// MIPS architecture
enum
{
  // Four bit MIPS architecture field.
  EF_MIPS_ARCH = 0xf0000000,
  // -mips1 code.
  E_MIPS_ARCH_1 = 0x00000000,
  // -mips2 code.
  E_MIPS_ARCH_2 = 0x10000000,
  // -mips3 code.
  E_MIPS_ARCH_3 = 0x20000000,
  // -mips4 code.
  E_MIPS_ARCH_4 = 0x30000000,
  // -mips5 code.
  E_MIPS_ARCH_5 = 0x40000000,
  // -mips32 code.
  E_MIPS_ARCH_32 = 0x50000000,
  // -mips64 code.
  E_MIPS_ARCH_64 = 0x60000000,
  // -mips32r2 code.
  E_MIPS_ARCH_32R2 = 0x70000000,
  // -mips64r2 code.
  E_MIPS_ARCH_64R2 = 0x80000000,
  // -mips32r6 code.
  E_MIPS_ARCH_32R6 = 0x90000000,
  // -mips64r6 code.
  E_MIPS_ARCH_64R6 = 0xa0000000,
  // -mnanomips32r6 code
  E_NANOMIPS_ARCH_32R6 = 0xb0000000,
  // -mnanomips64r6 code.
  E_NANOMIPS_ARCH_64R6 = 0xc0000000
};

// Values for the xxx_size bytes of an ABI flags structure.
enum
{
  // No registers.
  AFL_REG_NONE = 0x00,
  // 32-bit registers.
  AFL_REG_32 = 0x01,
  // 64-bit registers.
  AFL_REG_64 = 0x02,
  // 128-bit registers.
  AFL_REG_128 = 0x03
};

// Masks for the ases word of an ABI flags structure.
enum
{
  // DSP ASE.
  AFL_ASE_DSP = 0x00000001,
  // DSP R2 ASE.
  AFL_ASE_DSPR2 = 0x00000002,
  // Enhanced VA Scheme.
  AFL_ASE_EVA = 0x00000004,
  // MCU (MicroController) ASE.
  AFL_ASE_MCU = 0x00000008,
  // MDMX ASE.
  AFL_ASE_MDMX = 0x00000010,
  // MIPS-3D ASE.
  AFL_ASE_MIPS3D = 0x00000020,
  // MT ASE.
  AFL_ASE_MT  = 0x00000040,
  // SmartMIPS ASE.
  AFL_ASE_SMARTMIPS = 0x00000080,
  // VZ ASE.
  AFL_ASE_VIRT = 0x00000100,
  // MSA ASE.
  AFL_ASE_MSA = 0x00000200,
  // MIPS16 ASE.
  AFL_ASE_MIPS16 = 0x00000400,
  // MICROMIPS ASE.
  AFL_ASE_MICROMIPS = 0x00000800,
  // XPA ASE.
  AFL_ASE_XPA = 0x00001000
};

// Values for the isa_ext word of an ABI flags structure.
enum
{
  // RMI Xlr instruction.
  AFL_EXT_XLR = 1,
  // Cavium Networks Octeon2.
  AFL_EXT_OCTEON2 = 2,
  // Cavium Networks OcteonP.
  AFL_EXT_OCTEONP = 3,
  // Loongson 3A.
  AFL_EXT_LOONGSON_3A = 4,
  // Cavium Networks Octeon.
  AFL_EXT_OCTEON = 5,
  // MIPS R5900 instruction.
  AFL_EXT_5900 = 6,
  // MIPS R4650 instruction.
  AFL_EXT_4650 = 7,
  // LSI R4010 instruction.
  AFL_EXT_4010 = 8,
  // NEC VR4100 instruction.
  AFL_EXT_4100 = 9,
  // Toshiba R3900 instruction.
  AFL_EXT_3900 = 10,
  // MIPS R10000 instruction.
  AFL_EXT_10000 = 11,
  // Broadcom SB-1 instruction.
  AFL_EXT_SB1 = 12,
  // NEC VR4111/VR4181 instruction.
  AFL_EXT_4111 = 13,
  // NEC VR4120 instruction.
  AFL_EXT_4120 = 14,
  // NEC VR5400 instruction.
  AFL_EXT_5400 = 15,
  // NEC VR5500 instruction.
  AFL_EXT_5500 = 16,
  // ST Microelectronics Loongson 2E.
  AFL_EXT_LOONGSON_2E = 17,
  // ST Microelectronics Loongson 2F.
  AFL_EXT_LOONGSON_2F = 18,
  // Cavium Networks Octeon3.
  AFL_EXT_OCTEON3 = 19
};

// Masks for the flags1 word of an ABI flags structure.
enum
{
  // Uses odd single-precision registers.
  AFL_FLAGS1_ODDSPREG = 1
};

// Masks for the flags2 word of an ABI flags structure.
enum
{
  // Module is safe to relax.
  AFL_FLAGS2_LINKRELAX = 2
};

// Object attribute tags.
enum
{
  // 0-3 are generic.
  // Floating-point ABI used by this object file.
  Tag_GNU_MIPS_ABI_FP = 4,
  // MSA ABI used by this object file.
  Tag_GNU_MIPS_ABI_MSA = 8
};

// Object attribute values.
enum
{
  // Values defined for Tag_GNU_MIPS_ABI_FP.
  // Not tagged or not using any ABIs affected by the differences.
  Val_GNU_MIPS_ABI_FP_ANY = 0,
  // Using hard-float -mdouble-float.
  Val_GNU_MIPS_ABI_FP_DOUBLE = 1,
  // Using hard-float -msingle-float.
  Val_GNU_MIPS_ABI_FP_SINGLE = 2,
  // Using soft-float.
  Val_GNU_MIPS_ABI_FP_SOFT = 3,
  // Using -mips32r2 -mfp64.
  Val_GNU_MIPS_ABI_FP_OLD_64 = 4,
  // Using -mfpxx
  Val_GNU_MIPS_ABI_FP_XX = 5,
  // Using -mips32r2 -mfp64.
  Val_GNU_MIPS_ABI_FP_64 = 6,
  // Using -mips32r2 -mfp64 -mno-odd-spreg.
  Val_GNU_MIPS_ABI_FP_64A = 7,
  // This is reserved for backward-compatibility with an earlier
  // implementation of the MIPS NaN2008 functionality.
  Val_GNU_MIPS_ABI_FP_NAN2008 = 8,

  // Values defined for Tag_GNU_MIPS_ABI_MSA.
  // Not tagged or not using any ABIs affected by the differences.
  Val_GNU_MIPS_ABI_MSA_ANY = 0,
  // Using 128-bit MSA.
  Val_GNU_MIPS_ABI_MSA_128 = 1
};

enum
{
  // Mask to extract ABI version, not really a flag value.
  EF_MIPS_ABI = 0x0000F000,

  // The original o32 abi.
  E_MIPS_ABI_O32 = 0x00001000,
  // O32 extended to work on 64 bit architectures
  E_MIPS_ABI_O64 = 0x00002000,
  // EABI in 32 bit mode
  E_MIPS_ABI_EABI32 = 0x00003000,
  // EABI in 64 bit mode
  E_MIPS_ABI_EABI64 = 0x00004000,
};

// Special values for the st_other field in the symbol table.
enum
{
  // Two topmost bits denote the MIPS ISA for .text symbols:
  // + 00 -- standard MIPS code,
  // + 10 -- microMIPS code,
  // + 11 -- MIPS16 code; requires the following two bits to be set too.
  // Note that one of the MIPS16 bits overlaps with STO_MIPS_PIC.
  STO_MIPS_ISA = 0xc0,

  // The mask spanning the rest of MIPS psABI flags.  At most one is expected
  // to be set except for STO_MIPS16.
  STO_MIPS_FLAGS = ~(STO_MIPS_ISA | 0x3),

  // The MIPS psABI was updated in 2008 with support for PLTs and copy
  // relocs.  There are therefore two types of nonzero SHN_UNDEF functions:
  // PLT entries and traditional MIPS lazy binding stubs.  We mark the former
  // with STO_MIPS_PLT to distinguish them from the latter.
  STO_MIPS_PLT = 0x8,

  // This value is used to mark PIC functions in an object that mixes
  // PIC and non-PIC.  Note that this bit overlaps with STO_MIPS16,
  // although MIPS16 symbols are never considered to be MIPS_PIC.
  STO_MIPS_PIC = 0x20,

  // This value is used for a mips16 .text symbol.
  STO_MIPS16 = 0xf0,

  // This value is used for a microMIPS .text symbol.  To distinguish from
  // STO_MIPS16, we set top two bits to be 10 to denote STO_MICROMIPS.  The
  // mask is STO_MIPS_ISA.
  STO_MICROMIPS  = 0x80
};

inline bool
elf_st_is_micromips(unsigned char st_other)
{ return (st_other & elfcpp::STO_MIPS_ISA) == elfcpp::STO_MICROMIPS; }

// Values which may appear in the kind field of an Elf_Options structure.
enum
{
  // Undefined.
  ODK_NULL = 0,
  // Register usage and GP value.
  ODK_REGINFO = 1,
  // Exception processing information.
  ODK_EXCEPTIONS = 2,
  // Section padding information.
  ODK_PAD = 3,
  // Hardware workarounds performed.
  ODK_HWPATCH = 4,
  // Fill value used by the linker.
  ODK_FILL = 5,
  // Reserved space for desktop tools.
  ODK_TAGS = 6,
  // Hardware workarounds, AND bits when merging.
  ODK_HWAND = 7,
  // Hardware workarounds, OR bits when merging.
  ODK_HWOR = 8,
  // GP group to use for text/data sections.
  ODK_GP_GROUP = 9,
  // ID information.
  ODK_IDENT = 10
};

} // End namespace elfcpp.

#endif // !defined(ELFCPP_NANOMIPS_H)
