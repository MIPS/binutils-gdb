#name: MIPSr6 link branch to unaligned symbol 1
#as: -EB -n32 -march=mips64r6
#ld: -EB -Ttext 0x1c000000 -e 0x1c000000
#source: ../../../gas/testsuite/gas/mips/unaligned-branch-r6-3.s
#error: \A[^\n]*: In function `foo':\n
#error:   \(\.text\+0x101c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1024\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x102c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1034\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x103c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1044\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x104c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1054\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x105c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x107c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1084\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x108c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x1094\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x109c\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x10a4\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x10ac\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x10b4\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x10bc\): Branch to a non-instruction-aligned address\n
#error:   \(\.text\+0x10dc\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x10e4\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x10ec\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x10f4\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x10fc\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1104\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x110c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1114\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x111c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1124\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x112c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1134\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x113c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1144\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x114c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1154\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x115c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1164\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x116c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x1174\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\n
#error:   \(\.text\+0x117c\): Unsupported branch or jump between ISA modes; MIPS R6 does not support the JALX instruction\Z
