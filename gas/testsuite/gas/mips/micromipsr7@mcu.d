#objdump: -dr --show-raw-insn --prefix-addresses
#name: MCU for MIPS32r7
#as: -32
#source: mcu.s

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> 2000 d37f 	iret
0+0004 <foo\+0x4> a600 1100 	aclr	0x0,0\(zero\)
0+0008 <foo\+0x8> a600 1100 	aclr	0x0,0\(zero\)
0+000c <foo\+0xc> a600 1100 	aclr	0x0,0\(zero\)
0+0010 <foo\+0x10> a620 1100 	aclr	0x1,0\(zero\)
0+0014 <foo\+0x14> a640 1100 	aclr	0x2,0\(zero\)
0+0018 <foo\+0x18> a660 1100 	aclr	0x3,0\(zero\)
0+001c <foo\+0x1c> a680 1100 	aclr	0x4,0\(zero\)
0+0020 <foo\+0x20> a6a0 1100 	aclr	0x5,0\(zero\)
0+0024 <foo\+0x24> a6c0 1100 	aclr	0x6,0\(zero\)
0+0028 <foo\+0x28> a6e0 1100 	aclr	0x7,0\(zero\)
0+002c <foo\+0x2c> a6e2 1100 	aclr	0x7,0\(v0\)
0+0030 <foo\+0x30> a6ff 1100 	aclr	0x7,0\(ra\)
0+0034 <foo\+0x34> 003f 07ff 	addiu	at,ra,2047
0+0038 <foo\+0x38> a6e1 1100 	aclr	0x7,0\(at\)
0+003c <foo\+0x3c> 003f 9800 	addiu	at,ra,-2048
0+0040 <foo\+0x40> a6e1 1100 	aclr	0x7,0\(at\)
0+0044 <foo\+0x44> 003f 0800 	addiu	at,ra,2048
0+0048 <foo\+0x48> a6e1 1100 	aclr	0x7,0\(at\)
0+004c <foo\+0x4c> 003f 97ff 	addiu	at,ra,-2049
0+0050 <foo\+0x50> a6e1 1100 	aclr	0x7,0\(at\)
0+0054 <foo\+0x54> e020 8000 	lui	at,0x8
0+0058 <foo\+0x58> 23e1 0950 	addu	at,at,ra
0+005c <foo\+0x5c> a6e1 91ff 	aclr	0x7,-1\(at\)
0+0060 <foo\+0x60> e03f 8ffd 	lui	at,0xffff8
0+0064 <foo\+0x64> 23e1 0950 	addu	at,at,ra
0+0068 <foo\+0x68> a6e1 1100 	aclr	0x7,0\(at\)
0+006c <foo\+0x6c> e021 0000 	lui	at,0x10
0+0070 <foo\+0x70> 2081 0950 	addu	at,at,a0
0+0074 <foo\+0x74> a6e1 91ff 	aclr	0x7,-1\(at\)
0+0078 <foo\+0x78> e021 0000 	lui	at,0x10
0+007c <foo\+0x7c> 2081 0950 	addu	at,at,a0
0+0080 <foo\+0x80> a6e1 1100 	aclr	0x7,0\(at\)
0+0084 <foo\+0x84> e03f 0ffd 	lui	at,0xffff0
0+0088 <foo\+0x88> 2081 0950 	addu	at,at,a0
0+008c <foo\+0x8c> a6e1 1100 	aclr	0x7,0\(at\)
0+0090 <foo\+0x90> e03f 8ffd 	lui	at,0xffff8
0+0094 <foo\+0x94> 2081 0950 	addu	at,at,a0
0+0098 <foo\+0x98> a6e1 1100 	aclr	0x7,0\(at\)
0+009c <foo\+0x9c> e03f 0ffd 	lui	at,0xffff0
0+00a0 <foo\+0xa0> 2081 0950 	addu	at,at,a0
0+00a4 <foo\+0xa4> a6e1 1101 	aclr	0x7,1\(at\)
0+00a8 <foo\+0xa8> e03f 8ffd 	lui	at,0xffff8
0+00ac <foo\+0xac> 2081 0950 	addu	at,at,a0
0+00b0 <foo\+0xb0> a6e1 1101 	aclr	0x7,1\(at\)
0+00b4 <foo\+0xb4> e020 0e01 	lui	at,0xf0000
0+00b8 <foo\+0xb8> 2081 0950 	addu	at,at,a0
0+00bc <foo\+0xbc> a6e1 1100 	aclr	0x7,0\(at\)
0+00c0 <foo\+0xc0> a6e4 91ff 	aclr	0x7,-1\(a0\)
0+00c4 <foo\+0xc4> 6020 1234 5600 	li	at,0x12345600
0+00ca <foo\+0xca> 2081 0950 	addu	at,at,a0
0+00ce <foo\+0xce> a6e1 1178 	aclr	0x7,120\(at\)
0+00d2 <foo\+0xd2> 6020 0000 0000 	li	at,0x0
			d4: R_MICROMIPS_32	foo
0+00d8 <foo\+0xd8> 2061 0950 	addu	at,at,v1
0+00dc <foo\+0xdc> a621 1100 	aclr	0x1,0\(at\)
0+00e0 <foo\+0xe0> 6020 0000 0000 	li	at,0x0
			e2: R_MICROMIPS_32	foo
0+00e6 <foo\+0xe6> 2061 0950 	addu	at,at,v1
0+00ea <foo\+0xea> a421 1100 	aset	0x1,0\(at\)
0+00ee <foo\+0xee> a400 1100 	aset	0x0,0\(zero\)
0+00f2 <foo\+0xf2> a400 1100 	aset	0x0,0\(zero\)
0+00f6 <foo\+0xf6> a400 1100 	aset	0x0,0\(zero\)
0+00fa <foo\+0xfa> a420 1100 	aset	0x1,0\(zero\)
0+00fe <foo\+0xfe> a440 1100 	aset	0x2,0\(zero\)
0+0102 <foo\+0x102> a460 1100 	aset	0x3,0\(zero\)
0+0106 <foo\+0x106> a480 1100 	aset	0x4,0\(zero\)
0+010a <foo\+0x10a> a4a0 1100 	aset	0x5,0\(zero\)
0+010e <foo\+0x10e> a4c0 1100 	aset	0x6,0\(zero\)
0+0112 <foo\+0x112> a4e0 1100 	aset	0x7,0\(zero\)
0+0116 <foo\+0x116> a4e2 1100 	aset	0x7,0\(v0\)
0+011a <foo\+0x11a> a4ff 1100 	aset	0x7,0\(ra\)
0+011e <foo\+0x11e> 003f 07ff 	addiu	at,ra,2047
0+0122 <foo\+0x122> a4e1 1100 	aset	0x7,0\(at\)
0+0126 <foo\+0x126> 003f 9800 	addiu	at,ra,-2048
0+012a <foo\+0x12a> a4e1 1100 	aset	0x7,0\(at\)
0+012e <foo\+0x12e> 003f 0800 	addiu	at,ra,2048
0+0132 <foo\+0x132> a4e1 1100 	aset	0x7,0\(at\)
0+0136 <foo\+0x136> 003f 97ff 	addiu	at,ra,-2049
0+013a <foo\+0x13a> a4e1 1100 	aset	0x7,0\(at\)
0+013e <foo\+0x13e> e020 8000 	lui	at,0x8
0+0142 <foo\+0x142> 23e1 0950 	addu	at,at,ra
0+0146 <foo\+0x146> a4e1 91ff 	aset	0x7,-1\(at\)
0+014a <foo\+0x14a> e03f 8ffd 	lui	at,0xffff8
0+014e <foo\+0x14e> 23e1 0950 	addu	at,at,ra
0+0152 <foo\+0x152> a4e1 1100 	aset	0x7,0\(at\)
0+0156 <foo\+0x156> e021 0000 	lui	at,0x10
0+015a <foo\+0x15a> 2081 0950 	addu	at,at,a0
0+015e <foo\+0x15e> a4e1 91ff 	aset	0x7,-1\(at\)
0+0162 <foo\+0x162> e021 0000 	lui	at,0x10
0+0166 <foo\+0x166> 2081 0950 	addu	at,at,a0
0+016a <foo\+0x16a> a4e1 1100 	aset	0x7,0\(at\)
0+016e <foo\+0x16e> e03f 0ffd 	lui	at,0xffff0
0+0172 <foo\+0x172> 2081 0950 	addu	at,at,a0
0+0176 <foo\+0x176> a4e1 1100 	aset	0x7,0\(at\)
0+017a <foo\+0x17a> e03f 8ffd 	lui	at,0xffff8
0+017e <foo\+0x17e> 2081 0950 	addu	at,at,a0
0+0182 <foo\+0x182> a4e1 1100 	aset	0x7,0\(at\)
0+0186 <foo\+0x186> e03f 0ffd 	lui	at,0xffff0
0+018a <foo\+0x18a> 2081 0950 	addu	at,at,a0
0+018e <foo\+0x18e> a4e1 1101 	aset	0x7,1\(at\)
0+0192 <foo\+0x192> e03f 8ffd 	lui	at,0xffff8
0+0196 <foo\+0x196> 2081 0950 	addu	at,at,a0
0+019a <foo\+0x19a> a4e1 1101 	aset	0x7,1\(at\)
0+019e <foo\+0x19e> e020 0e01 	lui	at,0xf0000
0+01a2 <foo\+0x1a2> 2081 0950 	addu	at,at,a0
0+01a6 <foo\+0x1a6> a4e1 1100 	aset	0x7,0\(at\)
0+01aa <foo\+0x1aa> a4e4 91ff 	aset	0x7,-1\(a0\)
0+01ae <foo\+0x1ae> 6020 1234 5600 	li	at,0x12345600
0+01b4 <foo\+0x1b4> 2081 0950 	addu	at,at,a0
0+01b8 <foo\+0x1b8> a4e1 1178 	aset	0x7,120\(at\)
	...
