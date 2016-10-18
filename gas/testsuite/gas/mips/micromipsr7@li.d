#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 li
#source: li.s
#as: -32

# Test the li macro (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> d200      	li	a0,0
0+0002 <foo\+0x2> d201      	li	a0,1
0+0004 <foo\+0x4> e080 8000 	lui	a0,0x8
0+0008 <foo\+0x8> e09f 8ffd 	lui	a0,0xffff8
0+000c <foo\+0xc> e081 0000 	lui	a0,0x10
0+0010 <foo\+0x10> e081 a000 	lui	a0,0x1a
0+0014 <foo\+0x14> 8084 05a5 	ori	a0,a0,1445
	\.\.\.
