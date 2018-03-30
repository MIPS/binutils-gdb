#objdump: -dr -M reg-names=numeric -mnanomips:isa64r6
#name: nanoMIPS insn32 move test
#as: -minsn32

# Check objdump's disassembly of the move mnenomic for addu, daddu and or.

.*: +file format .*nanomips.*

Disassembly of section .text:
0+ <[^>]+>:
   0:	201f 6a90 	move	\$13,\$31
   4:	201f 6950 	move	\$13,\$31
   8:	201f 6a90 	move	\$13,\$31
   c:	c01f 6950 	move	\$13,\$31
#pass
