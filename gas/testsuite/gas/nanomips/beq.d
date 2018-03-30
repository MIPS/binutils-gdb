#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS beq

# Test the beq macro on nanoMIPS

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <text_label> 88a4 0000 	beqc	a0,a1,00000000 <text_label>
			0: R_NANOMIPS_PC14_S1	text_label
0+0004 <text_label\+0x4> 8880 0000 	beqzc	a0,00000000 <text_label>
			4: R_NANOMIPS_PC14_S1	text_label
0+0008 <text_label\+0x8> c880 0800 	beqic	a0,1,00000000 <text_label>
			8: R_NANOMIPS_PC11_S1	text_label
0+000c <text_label\+0xc> 0020 8000 	li	at,32768
0+0010 <text_label\+0x10> 8824 0000 	beqc	a0,at,00000000 <text_label>
			10: R_NANOMIPS_PC14_S1	text_label
0+0014 <text_label\+0x14> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
0+0018 <text_label\+0x18> 8824 0000 	beqc	a0,at,00000000 <text_label>
			18: R_NANOMIPS_PC14_S1	text_label
0+001c <text_label\+0x1c> e021 0000 	lui	at,%hi\(0x10000\)
0+0020 <text_label\+0x20> 8824 0000 	beqc	a0,at,00000000 <text_label>
			20: R_NANOMIPS_PC14_S1	text_label
0+0024 <text_label\+0x24> e021 a000 	lui	at,%hi\(0x1a000\)
0+0028 <text_label\+0x28> 8021 05a5 	ori	at,at,0x5a5
0+002c <text_label\+0x2c> 8824 0000 	beqc	a0,at,00000000 <text_label>
			2c: R_NANOMIPS_PC14_S1	text_label
0+0030 <text_label\+0x30> a880 0000 	bnezc	a0,00000000 <text_label>
			30: R_NANOMIPS_PC14_S1	text_label
	\.\.\.
[0-9a-f]+ <text_label\+0x20034> 2800 0000 	bc	00000000 <text_label>
			20034: R_NANOMIPS_PC25_S1	text_label
[0-9a-f]+ <text_label\+0x20038> 2a00 0000 	balc	00000000 <text_label>
			20038: R_NANOMIPS_PC25_S1	text_label
[0-9a-f]+ <text_label\+0x2003c> 2800 0000 	bc	00000000 <external_label>
			2003c: R_NANOMIPS_PC25_S1	external_label
[0-9a-f]+ <text_label\+0x20040> 2a00 0000 	balc	00000000 <external_label>
			20040: R_NANOMIPS_PC25_S1	external_label
#pass
