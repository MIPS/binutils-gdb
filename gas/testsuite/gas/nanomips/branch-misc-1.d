#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS branch-misc-1

# Test the branches to local symbols in current file (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
0+003c <x> 3800      	balc	00000000 <l1>
			3c: R_NANOMIPS_PC10_S1	l1
0+003e <x\+0x2> 3800      	balc	00000014 <l2>
			3e: R_NANOMIPS_PC10_S1	l2
0+0040 <x\+0x4> 3800      	balc	00000028 <l3>
			40: R_NANOMIPS_PC10_S1	l3
0+0042 <x\+0x6> 3800      	balc	0000005c <l4>
			42: R_NANOMIPS_PC10_S1	l4
0+0044 <x\+0x8> 3800      	balc	00000070 <l5>
			44: R_NANOMIPS_PC10_S1	l5
0+0046 <x\+0xa> 3800      	balc	00000084 <l6>
			46: R_NANOMIPS_PC10_S1	l6
	\.\.\.
	\.\.\.
	\.\.\.
	\.\.\.
