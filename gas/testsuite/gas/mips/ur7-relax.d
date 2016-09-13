#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 16-bit branch relaxation
#as: -mmicromips -mips32r7
#source: ur7-relax.s

# Check MIPSR7 16-bit branch relaxations

.*: +file format .*mips.*

Disassembly of section .text:
