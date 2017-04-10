#objdump: -dr -M reg-names=numeric
#name: nanoMIPS insn32 move test
#source: micrmips32-move.s

# Check objdump's disassembly of the move mnenomic for addu, daddu and or.

.*: +file format .*mips.*

Disassembly of section .text:
0+ <[^>]+>:
   0:	201f 6a90 	move	\$13,\$31
   4:	201f 6950 	move	\$13,\$31
   8:	c01f 6950 	move	\$13,\$31
   c:	201f 6a90 	move	\$13,\$31
