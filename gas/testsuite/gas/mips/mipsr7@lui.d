#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS lui
#as: -p32
#source: lui.s

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> e040 0000 	lui	v0,0x0
0+0004 <foo\+0x4> e05f f1fc 	lui	v0,0xffff
0+0008 <foo\+0x8> e040 8000 	lui	v0,0x8
0+000c <bar> e040 0008 	lui	v0,0x400
0+0010 <bar\+0x4> e040 c000 	lui	v0,0xc
0+0014 <bar\+0x8> e040 000c 	lui	v0,0x600
0+0018 <baz> e040 0000 	lui	v0,0x0
			18: R_NANOMIPS_LO12	bar
0+001c <baz\+0x4> e040 0000 	lui	v0,0x0
			1c: R_NANOMIPS_LO12	ext
0+0020 <\.L31> e040 0000 	lui	v0,0x0
			20: R_NANOMIPS_LO12	\.L31
0+0024 <\.L31\+0x4> e040 0000 	lui	v0,0x0
			24: R_NANOMIPS_LO12	\.L41
0+0028 <\.L41> e040 0000 	lui	v0,0x0
	\.\.\.
#pass
#0+002c <\.L41\+0x4> e040 0fff 	auipc	v0,ffe00030 <max\+0xffdf0030>
