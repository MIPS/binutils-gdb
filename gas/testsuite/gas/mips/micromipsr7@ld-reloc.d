#as: -32
#objdump: -dr --prefix-addresses --show-raw-insn -Mgpr-names=numeric
#name: LD with relocation operators for R7
#source: ld-reloc.s

.*file format.*

Disassembly of section \.text:
0+0000 <func> 84a4 8004 	lw	\$5,4\(\$4\)
0+0004 <func\+0x4> 8484 8000 	lw	\$4,0\(\$4\)
0+0008 <func\+0x8> e020 7000 	lui	\$1,0x7
0+000c <func\+0xc> 2024 0950 	addu	\$1,\$4,\$1
0+0010 <func\+0x10> 8481 8ffb 	lw	\$4,4091\(\$1\)
0+0014 <func\+0x14> 84a1 8fff 	lw	\$5,4095\(\$1\)
0+0018 <func\+0x18> e020 7000 	lui	\$1,0x7
0+001c <func\+0x1c> 8021 0ffc 	ori	\$1,\$1,4092
0+0020 <func\+0x20> 2024 0950 	addu	\$1,\$4,\$1
0+0024 <func\+0x24> 8481 8000 	lw	\$4,0\(\$1\)
0+0028 <func\+0x28> 84a1 8004 	lw	\$5,4\(\$1\)
0+002c <func\+0x2c> e020 7000 	lui	\$1,0x7
0+0030 <func\+0x30> 8021 0fff 	ori	\$1,\$1,4095
0+0034 <func\+0x34> 2024 0950 	addu	\$1,\$4,\$1
0+0038 <func\+0x38> 8481 8000 	lw	\$4,0\(\$1\)
0+003c <func\+0x3c> 84a1 8004 	lw	\$5,4\(\$1\)
0+0040 <func\+0x40> e020 8000 	lui	\$1,0x8
0+0044 <func\+0x44> 2024 0950 	addu	\$1,\$4,\$1
0+0048 <func\+0x48> 8481 8000 	lw	\$4,0\(\$1\)
0+004c <func\+0x4c> 84a1 8004 	lw	\$5,4\(\$1\)
0+0050 <func\+0x50> 8485 8000 	lw	\$4,0\(\$5\)
0+0054 <func\+0x54> 84a5 8004 	lw	\$5,4\(\$5\)
0+0058 <func\+0x58> e020 7000 	lui	\$1,0x7
0+005c <func\+0x5c> 2025 0950 	addu	\$1,\$5,\$1
0+0060 <func\+0x60> 8481 8ffb 	lw	\$4,4091\(\$1\)
0+0064 <func\+0x64> 84a1 8fff 	lw	\$5,4095\(\$1\)
0+0068 <func\+0x68> e020 7000 	lui	\$1,0x7
0+006c <func\+0x6c> 8021 0ffc 	ori	\$1,\$1,4092
0+0070 <func\+0x70> 2025 0950 	addu	\$1,\$5,\$1
0+0074 <func\+0x74> 8481 8000 	lw	\$4,0\(\$1\)
0+0078 <func\+0x78> 84a1 8004 	lw	\$5,4\(\$1\)
0+007c <func\+0x7c> e020 7000 	lui	\$1,0x7
0+0080 <func\+0x80> 8021 0fff 	ori	\$1,\$1,4095
0+0084 <func\+0x84> 2025 0950 	addu	\$1,\$5,\$1
0+0088 <func\+0x88> 8481 8000 	lw	\$4,0\(\$1\)
0+008c <func\+0x8c> 84a1 8004 	lw	\$5,4\(\$1\)
0+0090 <func\+0x90> e020 8000 	lui	\$1,0x8
0+0094 <func\+0x94> 2025 0950 	addu	\$1,\$5,\$1
0+0098 <func\+0x98> 8481 8000 	lw	\$4,0\(\$1\)
0+009c <func\+0x9c> 84a1 8004 	lw	\$5,4\(\$1\)
0+00a0 <func\+0xa0> e023 7000 	lui	\$1,0x37
0+00a4 <func\+0xa4> 2025 0950 	addu	\$1,\$5,\$1
0+00a8 <func\+0xa8> 8481 8ffb 	lw	\$4,4091\(\$1\)
0+00ac <func\+0xac> 84a1 8fff 	lw	\$5,4095\(\$1\)
0+00b0 <func\+0xb0> e023 7000 	lui	\$1,0x37
0+00b4 <func\+0xb4> 8021 0ffc 	ori	\$1,\$1,4092
0+00b8 <func\+0xb8> 2025 0950 	addu	\$1,\$5,\$1
0+00bc <func\+0xbc> 8481 8000 	lw	\$4,0\(\$1\)
0+00c0 <func\+0xc0> 84a1 8004 	lw	\$5,4\(\$1\)
0+00c4 <func\+0xc4> e023 7000 	lui	\$1,0x37
0+00c8 <func\+0xc8> 8021 0fff 	ori	\$1,\$1,4095
0+00cc <func\+0xcc> 2025 0950 	addu	\$1,\$5,\$1
0+00d0 <func\+0xd0> 8481 8000 	lw	\$4,0\(\$1\)
0+00d4 <func\+0xd4> 84a1 8004 	lw	\$5,4\(\$1\)
0+00d8 <func\+0xd8> e023 8000 	lui	\$1,0x38
0+00dc <func\+0xdc> 2025 0950 	addu	\$1,\$5,\$1
0+00e0 <func\+0xe0> 8481 8000 	lw	\$4,0\(\$1\)
0+00e4 <func\+0xe4> 84a1 8004 	lw	\$5,4\(\$1\)
0+00e8 <func\+0xe8> e020 0000 	lui	\$1,0x0
			e8: R_MICROMIPS_HI20	foo
0+00ec <func\+0xec> 8481 8000 	lw	\$4,0\(\$1\)
			ec: R_MICROMIPS_LO12	foo
0+00f0 <func\+0xf0> 84a1 8000 	lw	\$5,0\(\$1\)
			f0: R_MICROMIPS_LO12	foo\+0x4
0+00f4 <func\+0xf4> e020 0000 	lui	\$1,0x0
			f4: R_MICROMIPS_HI20	foo
0+00f8 <func\+0xf8> 8481 8000 	lw	\$4,0\(\$1\)
			f8: R_MICROMIPS_LO12	foo
0+00fc <func\+0xfc> 84a1 8000 	lw	\$5,0\(\$1\)
			fc: R_MICROMIPS_LO12	foo\+0x4
0+0100 <func\+0x100> e020 0000 	lui	\$1,0x0
			100: R_MICROMIPS_HI20	foo
0+0104 <func\+0x104> 8481 8000 	lw	\$4,0\(\$1\)
			104: R_MICROMIPS_LO12	foo
0+0108 <func\+0x108> 84a1 8000 	lw	\$5,0\(\$1\)
			108: R_MICROMIPS_LO12	foo\+0x4
0+010c <func\+0x10c> e034 8244 	lui	\$1,0x12348
0+0110 <func\+0x110> 8481 8765 	lw	\$4,1893\(\$1\)
0+0114 <func\+0x114> 84a1 8769 	lw	\$5,1897\(\$1\)
0+0118 <func\+0x118> e034 8244 	lui	\$1,0x12348
0+011c <func\+0x11c> 8481 8765 	lw	\$4,1893\(\$1\)
0+0120 <func\+0x120> 84a1 8769 	lw	\$5,1897\(\$1\)
0+0124 <func\+0x124> e020 0000 	lui	\$1,0x0
			124: R_MICROMIPS_HI20	foo
0+0128 <func\+0x128> 2024 0950 	addu	\$1,\$4,\$1
0+012c <func\+0x12c> 8481 8000 	lw	\$4,0\(\$1\)
			12c: R_MICROMIPS_LO12	foo
0+0130 <func\+0x130> 84a1 8000 	lw	\$5,0\(\$1\)
			130: R_MICROMIPS_LO12	foo\+0x4
0+0134 <func\+0x134> e020 0000 	lui	\$1,0x0
			134: R_MICROMIPS_HI20	foo
0+0138 <func\+0x138> 2024 0950 	addu	\$1,\$4,\$1
0+013c <func\+0x13c> 8481 8000 	lw	\$4,0\(\$1\)
			13c: R_MICROMIPS_LO12	foo
0+0140 <func\+0x140> 84a1 8000 	lw	\$5,0\(\$1\)
			140: R_MICROMIPS_LO12	foo\+0x4
0+0144 <func\+0x144> e020 0000 	lui	\$1,0x0
			144: R_MICROMIPS_HI20	foo
0+0148 <func\+0x148> 2024 0950 	addu	\$1,\$4,\$1
0+014c <func\+0x14c> 8481 8000 	lw	\$4,0\(\$1\)
			14c: R_MICROMIPS_LO12	foo
0+0150 <func\+0x150> 84a1 8000 	lw	\$5,0\(\$1\)
			150: R_MICROMIPS_LO12	foo\+0x4
0+0154 <func\+0x154> e020 0000 	lui	\$1,0x0
			154: R_MICROMIPS_HI20	foo
0+0158 <func\+0x158> 2025 0950 	addu	\$1,\$5,\$1
0+015c <func\+0x15c> 8481 8000 	lw	\$4,0\(\$1\)
			15c: R_MICROMIPS_LO12	foo
0+0160 <func\+0x160> 84a1 8000 	lw	\$5,0\(\$1\)
			160: R_MICROMIPS_LO12	foo\+0x4
0+0164 <func\+0x164> e020 0000 	lui	\$1,0x0
			164: R_MICROMIPS_HI20	foo
0+0168 <func\+0x168> 2025 0950 	addu	\$1,\$5,\$1
0+016c <func\+0x16c> 8481 8000 	lw	\$4,0\(\$1\)
			16c: R_MICROMIPS_LO12	foo
0+0170 <func\+0x170> 84a1 8000 	lw	\$5,0\(\$1\)
			170: R_MICROMIPS_LO12	foo\+0x4
0+0174 <func\+0x174> e020 0000 	lui	\$1,0x0
			174: R_MICROMIPS_HI20	foo
0+0178 <func\+0x178> 2025 0950 	addu	\$1,\$5,\$1
0+017c <func\+0x17c> 8481 8000 	lw	\$4,0\(\$1\)
			17c: R_MICROMIPS_LO12	foo
0+0180 <func\+0x180> 84a1 8000 	lw	\$5,0\(\$1\)
			180: R_MICROMIPS_LO12	foo\+0x4
0+0184 <func\+0x184> e034 8244 	lui	\$1,0x12348
0+0188 <func\+0x188> 2025 0950 	addu	\$1,\$5,\$1
0+018c <func\+0x18c> 8481 8765 	lw	\$4,1893\(\$1\)
0+0190 <func\+0x190> 84a1 8769 	lw	\$5,1897\(\$1\)
0+0194 <func\+0x194> e034 8244 	lui	\$1,0x12348
0+0198 <func\+0x198> 2025 0950 	addu	\$1,\$5,\$1
0+019c <func\+0x19c> 8481 8765 	lw	\$4,1893\(\$1\)
0+01a0 <func\+0x1a0> 84a1 8769 	lw	\$5,1897\(\$1\)
0+01a4 <func\+0x1a4> e020 0000 	lui	\$1,0x0
			1a4: R_MICROMIPS_HI20	foo\+0x12348765
0+01a8 <func\+0x1a8> 2025 0950 	addu	\$1,\$5,\$1
0+01ac <func\+0x1ac> 8481 8000 	lw	\$4,0\(\$1\)
			1ac: R_MICROMIPS_LO12	foo\+0x12348765
0+01b0 <func\+0x1b0> 84a1 8000 	lw	\$5,0\(\$1\)
			1b0: R_MICROMIPS_LO12	foo\+0x12348769
0+01b4 <func\+0x1b4> e020 0000 	lui	\$1,0x0
			1b4: R_MICROMIPS_HI20	foo\+0x12348765
0+01b8 <func\+0x1b8> 2025 0950 	addu	\$1,\$5,\$1
0+01bc <func\+0x1bc> 8481 8000 	lw	\$4,0\(\$1\)
			1bc: R_MICROMIPS_LO12	foo\+0x12348765
0+01c0 <func\+0x1c0> 84a1 8000 	lw	\$5,0\(\$1\)
			1c0: R_MICROMIPS_LO12	foo\+0x12348769
