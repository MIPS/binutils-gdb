#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS local PC-relative relocations 4
#as: -32
#source: pcrel-reloc-4.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> cfff      	bc	00000000 <foo>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	00000002 <foo\+0x2>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	00000004 <foo\+0x4>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	00000006 <foo\+0x6>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	00000008 <foo\+0x8>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	0000000a <foo\+0xa>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	0000000c <foo\+0xc>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	0000000e <foo\+0xe>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,00000010 <foo\+0x10>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	bar
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,00000012 <foo\+0x12>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	bar
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,00000014 <foo\+0x14>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	bar
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,00000016 <foo\+0x16>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	bar
[0-9a-f]+ <[^>]*> 7848 0000 	lwpc	v0,00000018 <foo\+0x18>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	bar
[0-9a-f]+ <[^>]*> 7848 0000 	lwpc	v0,0000001c <foo\+0x1c>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	bar
[0-9a-f]+ <[^>]*> 7848 0000 	lwpc	v0,00000020 <foo\+0x20>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	bar
[0-9a-f]+ <[^>]*> 7848 0000 	lwpc	v0,00000024 <foo\+0x24>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	bar
[0-9a-f]+ <[^>]*> 7858 0000 	ldpc	v0,00000028 <foo\+0x28>
[	]*[0-9a-f]+: R_MICROMIPS_PC18_S3	bar
[0-9a-f]+ <[^>]*> 7858 0000 	ldpc	v0,00000028 <foo\+0x28>
[	]*[0-9a-f]+: R_MICROMIPS_PC18_S3	bar
[0-9a-f]+ <[^>]*> 7858 0000 	ldpc	v0,00000030 <foo\+0x30>
[	]*[0-9a-f]+: R_MICROMIPS_PC18_S3	bar
[0-9a-f]+ <[^>]*> 7858 0000 	ldpc	v0,00000030 <foo\+0x30>
[	]*[0-9a-f]+: R_MICROMIPS_PC18_S3	bar
[0-9a-f]+ <[^>]*> 785e 0001 	auipc	v0,0x1
[	]*[0-9a-f]+: R_MICROMIPS_PCHI16	\.text
[0-9a-f]+ <[^>]*> 3042 0015 	addiu	v0,v0,21
[	]*[0-9a-f]+: R_MICROMIPS_PCLO16	\.text
[0-9a-f]+ <[^>]*> 785e 0001 	auipc	v0,0x1
[	]*[0-9a-f]+: R_MICROMIPS_PCHI16	\.text
[0-9a-f]+ <[^>]*> 3042 0015 	addiu	v0,v0,21
[	]*[0-9a-f]+: R_MICROMIPS_PCLO16	\.text
[0-9a-f]+ <[^>]*> 785e 0001 	auipc	v0,0x1
[	]*[0-9a-f]+: R_MICROMIPS_PCHI16	\.text
[0-9a-f]+ <[^>]*> 3042 0015 	addiu	v0,v0,21
[	]*[0-9a-f]+: R_MICROMIPS_PCLO16	\.text
[0-9a-f]+ <[^>]*> 785e 0001 	auipc	v0,0x1
[	]*[0-9a-f]+: R_MICROMIPS_PCHI16	\.text
[0-9a-f]+ <[^>]*> 3042 0015 	addiu	v0,v0,21
[	]*[0-9a-f]+: R_MICROMIPS_PCLO16	\.text
	\.\.\.
[0-9a-f]+ <[^>]*> 001f 0f3c 	jrc	ra
	\.\.\.
[0-9a-f]+ <[^>]*> 001f 0f3c 	jrc	ra
	\.\.\.
