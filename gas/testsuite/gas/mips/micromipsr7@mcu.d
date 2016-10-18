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
0+0034 <foo\+0x34> a6ff 17ff 	0xa6ff17ff
0+0038 <foo\+0x38> 003f 9800 	addiu	at,ra,-2048
0+003c <foo\+0x3c> a6e1 1100 	aclr	0x7,0\(at\)
0+0040 <foo\+0x40> a6ff 1900 	cache	0x17,0\(ra\)
0+0044 <foo\+0x44> 003f 97ff 	addiu	at,ra,-2049
0+0048 <foo\+0x48> a6e1 1100 	aclr	0x7,0\(at\)
0+004c <foo\+0x4c> e020 7000 	lui	at,0x7
0+0050 <foo\+0x50> 23e1 0950 	addu	at,at,ra
0+0054 <foo\+0x54> a6e1 1fff 	0xa6e11fff
0+0058 <foo\+0x58> e03f 8ffd 	lui	at,0xffff8
0+005c <foo\+0x5c> 23e1 0950 	addu	at,at,ra
0+0060 <foo\+0x60> a6e1 1100 	aclr	0x7,0\(at\)
0+0064 <foo\+0x64> e020 f000 	lui	at,0xf
0+0068 <foo\+0x68> 2081 0950 	addu	at,at,a0
0+006c <foo\+0x6c> a6e1 1fff 	0xa6e11fff
0+0070 <foo\+0x70> e021 0000 	lui	at,0x10
0+0074 <foo\+0x74> 2081 0950 	addu	at,at,a0
0+0078 <foo\+0x78> a6e1 1100 	aclr	0x7,0\(at\)
0+007c <foo\+0x7c> e03f 0ffd 	lui	at,0xffff0
0+0080 <foo\+0x80> 2081 0950 	addu	at,at,a0
0+0084 <foo\+0x84> a6e1 1100 	aclr	0x7,0\(at\)
0+0088 <foo\+0x88> e03f 8ffd 	lui	at,0xffff8
0+008c <foo\+0x8c> 2081 0950 	addu	at,at,a0
0+0090 <foo\+0x90> a6e1 1100 	aclr	0x7,0\(at\)
0+0094 <foo\+0x94> e03f 0ffd 	lui	at,0xffff0
0+0098 <foo\+0x98> 2081 0950 	addu	at,at,a0
0+009c <foo\+0x9c> a6e1 1101 	aclr	0x7,1\(at\)
0+00a0 <foo\+0xa0> e03f 8ffd 	lui	at,0xffff8
0+00a4 <foo\+0xa4> 2081 0950 	addu	at,at,a0
0+00a8 <foo\+0xa8> a6e1 1101 	aclr	0x7,1\(at\)
0+00ac <foo\+0xac> e020 0e01 	lui	at,0xf0000
0+00b0 <foo\+0xb0> 2081 0950 	addu	at,at,a0
0+00b4 <foo\+0xb4> a6e1 1100 	aclr	0x7,0\(at\)
0+00b8 <foo\+0xb8> 0024 9fff 	addiu	at,a0,-1
0+00bc <foo\+0xbc> a6e1 1100 	aclr	0x7,0\(at\)
0+00c0 <foo\+0xc0> e034 5244 	lui	at,0x12345
0+00c4 <foo\+0xc4> 2081 0950 	addu	at,at,a0
0+00c8 <foo\+0xc8> a6e1 1778 	0xa6e11778
0+00cc <foo\+0xcc> e020 0000 	lui	at,0x0
			cc: R_MICROMIPS_HI20	foo
0+00d0 <foo\+0xd0> 2061 0950 	addu	at,at,v1
0+00d4 <foo\+0xd4> a621 1100 	aclr	0x1,0\(at\)
			d4: R_MICROMIPS_LO12	foo
0+00d8 <foo\+0xd8> e020 0000 	lui	at,0x0
			d8: R_MICROMIPS_HI20	foo
0+00dc <foo\+0xdc> 2061 0950 	addu	at,at,v1
0+00e0 <foo\+0xe0> a421 1100 	aset	0x1,0\(at\)
			e0: R_MICROMIPS_LO12	foo
0+00e4 <foo\+0xe4> a400 1100 	aset	0x0,0\(zero\)
0+00e8 <foo\+0xe8> a400 1100 	aset	0x0,0\(zero\)
0+00ec <foo\+0xec> a400 1100 	aset	0x0,0\(zero\)
0+00f0 <foo\+0xf0> a420 1100 	aset	0x1,0\(zero\)
0+00f4 <foo\+0xf4> a440 1100 	aset	0x2,0\(zero\)
0+00f8 <foo\+0xf8> a460 1100 	aset	0x3,0\(zero\)
0+00fc <foo\+0xfc> a480 1100 	aset	0x4,0\(zero\)
0+0100 <foo\+0x100> a4a0 1100 	aset	0x5,0\(zero\)
0+0104 <foo\+0x104> a4c0 1100 	aset	0x6,0\(zero\)
0+0108 <foo\+0x108> a4e0 1100 	aset	0x7,0\(zero\)
0+010c <foo\+0x10c> a4e2 1100 	aset	0x7,0\(v0\)
0+0110 <foo\+0x110> a4ff 1100 	aset	0x7,0\(ra\)
0+0114 <foo\+0x114> a4ff 17ff 	0xa4ff17ff
0+0118 <foo\+0x118> 003f 9800 	addiu	at,ra,-2048
0+011c <foo\+0x11c> a4e1 1100 	aset	0x7,0\(at\)
0+0120 <foo\+0x120> a4ff 1900 	cache	0x7,0\(ra\)
0+0124 <foo\+0x124> 003f 97ff 	addiu	at,ra,-2049
0+0128 <foo\+0x128> a4e1 1100 	aset	0x7,0\(at\)
0+012c <foo\+0x12c> e020 7000 	lui	at,0x7
0+0130 <foo\+0x130> 23e1 0950 	addu	at,at,ra
0+0134 <foo\+0x134> a4e1 1fff 	0xa4e11fff
0+0138 <foo\+0x138> e03f 8ffd 	lui	at,0xffff8
0+013c <foo\+0x13c> 23e1 0950 	addu	at,at,ra
0+0140 <foo\+0x140> a4e1 1100 	aset	0x7,0\(at\)
0+0144 <foo\+0x144> e020 f000 	lui	at,0xf
0+0148 <foo\+0x148> 2081 0950 	addu	at,at,a0
0+014c <foo\+0x14c> a4e1 1fff 	0xa4e11fff
0+0150 <foo\+0x150> e021 0000 	lui	at,0x10
0+0154 <foo\+0x154> 2081 0950 	addu	at,at,a0
0+0158 <foo\+0x158> a4e1 1100 	aset	0x7,0\(at\)
0+015c <foo\+0x15c> e03f 0ffd 	lui	at,0xffff0
0+0160 <foo\+0x160> 2081 0950 	addu	at,at,a0
0+0164 <foo\+0x164> a4e1 1100 	aset	0x7,0\(at\)
0+0168 <foo\+0x168> e03f 8ffd 	lui	at,0xffff8
0+016c <foo\+0x16c> 2081 0950 	addu	at,at,a0
0+0170 <foo\+0x170> a4e1 1100 	aset	0x7,0\(at\)
0+0174 <foo\+0x174> e03f 0ffd 	lui	at,0xffff0
0+0178 <foo\+0x178> 2081 0950 	addu	at,at,a0
0+017c <foo\+0x17c> a4e1 1101 	aset	0x7,1\(at\)
0+0180 <foo\+0x180> e03f 8ffd 	lui	at,0xffff8
0+0184 <foo\+0x184> 2081 0950 	addu	at,at,a0
0+0188 <foo\+0x188> a4e1 1101 	aset	0x7,1\(at\)
0+018c <foo\+0x18c> e020 0e01 	lui	at,0xf0000
0+0190 <foo\+0x190> 2081 0950 	addu	at,at,a0
0+0194 <foo\+0x194> a4e1 1100 	aset	0x7,0\(at\)
0+0198 <foo\+0x198> 0024 9fff 	addiu	at,a0,-1
0+019c <foo\+0x19c> a4e1 1100 	aset	0x7,0\(at\)
0+01a0 <foo\+0x1a0> e034 5244 	lui	at,0x12345
0+01a4 <foo\+0x1a4> 2081 0950 	addu	at,at,a0
0+01a8 <foo\+0x1a8> a4e1 1778 	0xa4e11778
	\.\.\.
