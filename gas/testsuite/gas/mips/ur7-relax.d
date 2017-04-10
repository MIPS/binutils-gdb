#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS 16-bit branch relaxation
#as: -mips32r7
#source: ur7-relax.s

# Check nanoMIPS 16-bit branch relaxations

.*: +file format .*mips.*

Disassembly of section .text:
