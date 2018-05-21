// nanomips.h -- ELF definitions specific to EM_NANOMIPS  -*- C++ -*-

// Copyright (C) 2018 Free Software Foundation, Inc.
// Written by Vladimir Radosavljevic <vladimir.radosavljevic@mips.com>

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
  R_NANOMIPS_GOT_DISP = 33,
  R_NANOMIPS_GOTPC_I32 = 34,
  R_NANOMIPS_GOTPC_HI20 = 35,
  R_NANOMIPS_GOT_LO12 = 36,
  R_NANOMIPS_GOT_CALL = 37,
  R_NANOMIPS_GOT_PAGE = 38,
  R_NANOMIPS_GOT_OFST = 39,
  R_NANOMIPS_LO4_S2 = 40,
  R_NANOMIPS_HI32 = 41,
  R_NANOMIPS_GPREL_LO12 = 42,
  R_NANOMIPS_SCN_DISP = 43,
  R_NANOMIPS_COPY = 44,
  R_NANOMIPS_ALIGN = 64,
  R_NANOMIPS_FILL = 65,
  R_NANOMIPS_MAX = 66,
  R_NANOMIPS_INSN32 = 67,
  R_NANOMIPS_FIXED = 68,
  R_NANOMIPS_NORELAX = 69,
  R_NANOMIPS_RELAX = 70,
  R_NANOMIPS_SAVERESTORE = 71,
  R_NANOMIPS_INSN16 = 72,
  R_NANOMIPS_JALR32 = 73,
  R_NANOMIPS_JALR16 = 74,
  R_NANOMIPS_TLS_DTPMOD = 80,
  R_NANOMIPS_TLS_DTPREL = 81,
  R_NANOMIPS_TLS_TPREL = 82,
  R_NANOMIPS_TLS_GD = 83,
  R_NANOMIPS_TLS_GD_I32 = 84,
  R_NANOMIPS_TLS_LD = 85,
  R_NANOMIPS_TLS_LD_I32 = 86,
  R_NANOMIPS_TLS_DTPREL12 = 87,
  R_NANOMIPS_TLS_DTPREL16 = 88,
  R_NANOMIPS_TLS_DTPREL_I32 = 89,
  R_NANOMIPS_TLS_GOTTPREL = 90,
  R_NANOMIPS_TLS_GOTTPREL_PC_I32 = 91,
  R_NANOMIPS_TLS_TPREL12 = 92,
  R_NANOMIPS_TLS_TPREL16 = 93,
  R_NANOMIPS_TLS_TPREL_I32 = 94,
  R_NANOMIPS_PC32 = 248
};

// Processor specific flags for the ELF header e_flags field.

enum
{
  // File may be relaxed by the linker.
  EF_NANOMIPS_LINKRELAX = 0x00000001,
  // File contains position independent code.
  EF_NANOMIPS_PIC = 0x00000002,
  // Indicates code compiled for a 64-bit machine in 32-bit mode
  // (regs are 32-bits wide).
  EF_NANOMIPS_32BITMODE = 0x00000004,
  // Indicate that all data access in this object is GP-relative
  EF_NANOMIPS_PID = 0x00000008,
  // Indicate that this object does not use absolute addressing.
  EF_NANOMIPS_PCREL = 0x00000010
};

// nanoMIPS architecture
enum
{
  // Four bit nanoMIPS architecture field.
  EF_NANOMIPS_ARCH = 0xf0000000,

  // -march=32r6 code.
  E_NANOMIPS_ARCH_32R6 = 0x00000000,
  // -march=64r6 code.
  E_NANOMIPS_ARCH_64R6 = 0x10000000
};

enum
{
  // The ABI of the file.
  EF_NANOMIPS_ABI = 0x0000f000,

  // nanoMIPS ABI in 32 bit mode.
  E_NANOMIPS_ABI_P32 = 0x00001000,
  // nanoMIPS ABI in 64 bit mode.
  E_NANOMIPS_ABI_P64 = 0x00002000
};

// Machine variant if we know it.  This field was invented at Cygnus
// for MIPS.  It may be used similarly for nanoMIPS.
enum
{
  EF_NANOMIPS_MACH = 0x00ff0000
};

// Object attribute tags.
enum
{
  // 0-3 are generic.
  // Floating-point ABI used by this object file.
  Tag_GNU_NANOMIPS_ABI_FP = 4,
  // MSA ABI used by this object file.
  Tag_GNU_NANOMIPS_ABI_MSA = 8
};

// Object attribute values.
enum
{
  // Values defined for Tag_GNU_NANOMIPS_ABI_FP.
  // Not tagged or not using any ABIs affected by the differences.
  Val_GNU_NANOMIPS_ABI_FP_ANY = 0,
  // Using hard-float -mdouble-float.
  Val_GNU_NANOMIPS_ABI_FP_DOUBLE = 1,
  // Using hard-float -msingle-float.
  Val_GNU_NANOMIPS_ABI_FP_SINGLE = 2,
  // Using soft-float.
  Val_GNU_NANOMIPS_ABI_FP_SOFT = 3,

  // Values defined for Tag_GNU_NANOMIPS_ABI_MSA.
  // Not tagged or not using any ABIs affected by the differences.
  Val_GNU_NANOMIPS_ABI_MSA_ANY = 0,
  // Using 128-bit MSA.
  Val_GNU_NANOMIPS_ABI_MSA_128 = 1
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

// Values for the isa_ext word of an ABI flags structure.
enum
{
  // No processor-specific extension.
  AFL_EXT_NONE = 0
};

// Masks for the ases word of an ABI flags structure.
enum
{
  // TLB control ASE.
  AFL_ASE_TLB = 0x00000001,
  // was DSP R2 ASE.
  AFL_ASE_UNUSED1 = 0x00000002,
  // Enhanced VA Scheme.
  AFL_ASE_EVA = 0x00000004,
  // MCU (MicroController) ASE.
  AFL_ASE_MCU = 0x00000008,
  // was MDMX ASE.
  AFL_ASE_UNUSED2 = 0x00000010,
  // was MIPS-3D ASE.
  AFL_ASE_UNUSED3 = 0x00000020,
  // MT ASE.
  AFL_ASE_MT = 0x00000040,
  // was SmartMIPS ASE.
  AFL_ASE_UNUSED4 = 0x00000080,
  // VZ ASE.
  AFL_ASE_VIRT = 0x00000100,
  // MSA ASE.
  AFL_ASE_MSA = 0x00000200,
  // was MIPS16 ASE.
  AFL_ASE_RESERVED1 = 0x00000400,
  // was MICROMIPS ASE.
  AFL_ASE_RESERVED2 = 0x00000800,
  // XPA ASE.
  AFL_ASE_XPA = 0x00001000,
  // DSP R3 ASE.
  AFL_ASE_DSPR3 = 0x00002000,
  // was MIPS16 E2 Extension.
  AFL_ASE_UNUSED5 = 0x00004000,
  // CRC extension.
  AFL_ASE_CRC = 0x00008000,
  // CRYPTO extension.
  AFL_ASE_CRYPTO = 0x00010000,
  // GINV ASE.
  AFL_ASE_GINV = 0x00020000,
  // not nanoMIPS Subset.
  AFL_ASE_xNMS = 0x00040000,
  // All ASEs.
  AFL_ASE_MASK = 0x0007ffff
};

} // End namespace elfcpp.

#endif // !defined(ELFCPP_NANOMIPS_H)
