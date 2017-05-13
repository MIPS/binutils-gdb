#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS branch-misc-2-64
#source: branch-misc-2.s
#as: -p64 -call_shared

# Test backward branches to global symbols in current file (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
0+003c <x> 3800      	balc	0+3e <x\+0x2>
			3c: R_NANOMIPS_PC10_S1	g1-0x2
0+003e <x\+0x2> 3800      	balc	0+54 <x\+0x18>
			3e: R_NANOMIPS_PC10_S1	g2-0x2
0+0040 <x\+0x4> 3800      	balc	0+6a <g4\+0xe>
			40: R_NANOMIPS_PC10_S1	g3-0x2
0+0042 <x\+0x6> 3800      	balc	0+a0 <g6\+0x1c>
			42: R_NANOMIPS_PC10_S1	g4-0x2
0+0044 <x\+0x8> 3800      	balc	0+b6 <g6\+0x32>
			44: R_NANOMIPS_PC10_S1	g5-0x2
0+0046 <x\+0xa> 3800      	balc	0+cc <g6\+0x48>
			46: R_NANOMIPS_PC10_S1	g6-0x2
	\.\.\.
	\.\.\.
	\.\.\.
0+0084 <g6> 2800 0000 	bc	0+88 <x1\+0x88>
			84: R_NANOMIPS_PC25_S1	x1-0x4
0+0088 <g6\+0x4> 2800 0000 	bc	0+8c <x2\+0x8c>
			88: R_NANOMIPS_PC25_S1	x2-0x4
0+008c <g6\+0x8> 2800 0000 	bc	0+90 <g6\+0xc>
			8c: R_NANOMIPS_PC25_S1	.Ldata-0x4
	\.\.\.
