#objdump: -dr --prefix-addresses
#as: -32
#name: MIPS R7 II load $zero
#source: ld-zero-2.s

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> lui	at,0x12345
0+0004 <foo\+0x4> ori	at,at,1536
0+0008 <foo\+0x8> addu	at,at,v0
0+000c <foo\+0xc> ll	zero,-32\(at\)
	\.\.\.
