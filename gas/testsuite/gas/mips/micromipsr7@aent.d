#objdump: -dr --prefix-addresses
#name: MIPS R7 .aent directive
#as: -32
#source: aent.s

# Test the .aent directive retains function symbol type annotation.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> sll	v0,a0,a2
0+0004 <foo\+0x4> sra	t0,t2,t4
0+0008 <bar> sll	v0,a0,a2
0+000c <bar\+0x4> sra	t0,t2,t4
	\.\.\.
