#objdump: -dr --prefix-addresses --show-raw-insn
#name: Test MIPS32r5 instructions on MIPS R7
#source: r5.s

.*: +file format .*mips.*

Disassembly of section \.text:
00000000 <test_r5> 2001 f37f 	eretnc
	\.\.\.
