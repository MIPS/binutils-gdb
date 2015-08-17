#objdump: -dr
#name: MIPS move disassembly test
#source: move.s

# Check objdump's disassembly of the move menomic for addu, daddu and or.

.*: +file format .*mips.*

Disassembly of section .text:
0+ <.*>:
   0:	03e08025 	move	s0,ra
   4:	03e08021 	move	s0,ra
   8:	03e0802d 	move	s0,ra
   c:	03e08025 	move	s0,ra
