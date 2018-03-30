#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS branch-misc-2pic
#source: branch-misc-2.s

# Test the backward branches to global symbols in current file (nanoMIPS).

.*: +file format .*nanomips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
0+003c <x> 3800      	balc	00000000 <g1>
			3c: R_NANOMIPS_PC10_S1	g1
0+003e <x\+0x2> 3800      	balc	00000014 <g2>
			3e: R_NANOMIPS_PC10_S1	g2
0+0040 <x\+0x4> 3800      	balc	00000028 <g3>
			40: R_NANOMIPS_PC10_S1	g3
0+0042 <x\+0x6> 3800      	balc	0000005c <g4>
			42: R_NANOMIPS_PC10_S1	g4
0+0044 <x\+0x8> 3800      	balc	00000070 <g5>
			44: R_NANOMIPS_PC10_S1	g5
0+0046 <x\+0xa> 3800      	balc	00000084 <g6>
			46: R_NANOMIPS_PC10_S1	g6
	\.\.\.
	\.\.\.
	\.\.\.
0+0084 <g6> 2800 0000 	bc	00000000 <x1>
			84: R_NANOMIPS_PC25_S1	x1
0+0088 <g6\+0x4> 2800 0000 	bc	00000000 <x2>
			88: R_NANOMIPS_PC25_S1	x2
0+008c <g6\+0x8> 2800 0000 	bc	00000000 <\.Ldata>
			8c: R_NANOMIPS_PC25_S1	.Ldata
#pass
