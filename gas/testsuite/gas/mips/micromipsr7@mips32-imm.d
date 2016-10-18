#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 MIPS32 WAIT and SDBBP instructions
#as: -32
#source: mips32-imm.s

# Check MIPS32 WAIT and SDBBP instruction assembly for R7

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 2367 c37f 	wait	0x367
0+0004 <text_label\+0x4> 001d 6789 	sdbbp	0x56789
	\.\.\.
