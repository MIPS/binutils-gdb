#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS lui
#as: -32
#source: lui.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[0-9a-f]+ <[^>]*> 1040 ffff 	lui	v0,0xffff
[0-9a-f]+ <[^>]*> 1040 0008 	lui	v0,0x8
[0-9a-f]+ <[^>]*> 1040 0008 	lui	v0,0x8
[0-9a-f]+ <[^>]*> 1040 000c 	lui	v0,0xc
[0-9a-f]+ <[^>]*> 1040 000c 	lui	v0,0xc
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	bar
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	ext
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	\.L31
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	\.L41
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[0-9a-f]+ <[^>]*> 1040 ffff 	lui	v0,0xffff
	\.\.\.
