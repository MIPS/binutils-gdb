#objdump: -dr --show-raw-insn --prefix-addresses
#name: nanoMIPS dot-1
#source: dot-1.s

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <foo> 9240      	addiu	a0,a0,0
0+0002 <foo\+0x2> 9008      	nop
0+0004 <foo\+0x4> 9008      	nop
0+0006 <foo\+0x6> 9242      	addiu	a0,a0,8
0+0008 <foo\+0x8> 908c      	addiu	a0,a0,4
0+000a <foo\+0xa> 0084 000a 	addiu	a0,a0,10
0+000e <foo\+0xe> 0084 0000 	addiu	a0,a0,0
0+0012 <foo\+0x12> 0084 000e 	addiu	a0,a0,14
0+0016 <foo\+0x16> 0084 0012 	addiu	a0,a0,18
0+001a <foo\+0x1a> 0084 001a 	addiu	a0,a0,26
#pass
