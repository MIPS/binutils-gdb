# source file to test assembly of mips64 cop2 instructions

      .set noreorder
      .set noat

      .globl text_label .text
text_label:

      # unprivileged coprocessor instructions.
      # these tests use cp2 to avoid other (cp0, fpu, prefetch) opcodes.

      dmfc2   $3, $4
      dmtc2   $6, $7
