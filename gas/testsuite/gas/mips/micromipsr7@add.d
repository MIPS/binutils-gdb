#objdump: -dr --prefix-addresses
#name: MIPS32R7 add
#source: add.s
#as: -32

# Test the add macro for R7

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> addiu	a0,a0,0
0+0004 <foo\+0x4> addiu	a0,a0,1
0+0008 <foo\+0x8> li	at,32768
0+000c <foo\+0xc> add	a0,a0,at
0+0010 <foo\+0x10> lui	at,0xffff8
0+0014 <foo\+0x14> add	a0,a0,at
0+0018 <foo\+0x18> lui	at,0x10
0+001c <foo\+0x1c> add	a0,a0,at
0+0020 <foo\+0x20> li	at,0x1a5a5
0+0026 <foo\+0x26> add	a0,a0,at
0+002a <foo\+0x2a> addiu	a0,a0,1
0+002e <foo\+0x2e> nop
	\.\.\.
