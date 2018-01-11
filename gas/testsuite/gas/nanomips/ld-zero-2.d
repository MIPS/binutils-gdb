#objdump: -dr --prefix-addresses
#name: nanoMIPS II load $zero

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <foo> lui	at,%hi\(0x12345000\)
0+0004 <foo\+0x4> ori	at,at,0x678
0+0008 <foo\+0x8> addu	at,at,t4
0+000c <foo\+0xc> ll	zero,0\(at\)
	\.\.\.
