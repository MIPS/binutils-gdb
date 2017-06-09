#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS lui
#as: -p32
#source: lui.s

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> e040 0000 	lui	t4,0x0
0+0004 <foo\+0x4> e05f 0ffd 	lui	t4,%hi\(0xffff0000\)
0+0008 <foo\+0x8> e048 0000 	lui	t4,%hi\(0x80000\)
#pass

