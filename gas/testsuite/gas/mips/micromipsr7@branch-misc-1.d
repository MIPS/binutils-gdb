#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 branch-misc-1
#source: branch-misc-1.s
#as: -32

# Test the branches to local symbols in current file (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
0+003c <x> 3800      	balc	0000003e <x\+0x2>
			3c: R_MICROMIPS_PC10_S1	l1-0x2
0+003e <x\+0x2> 3800      	balc	00000054 <x\+0x18>
			3e: R_MICROMIPS_PC10_S1	l2-0x2
0+0040 <x\+0x4> 3800      	balc	0000006a <l4\+0xe>
			40: R_MICROMIPS_PC10_S1	l3-0x2
0+0042 <x\+0x6> 3800      	balc	000000a0 <l6\+0x1c>
			42: R_MICROMIPS_PC10_S1	l4-0x2
0+0044 <x\+0x8> 3800      	balc	000000b6 <l6\+0x32>
			44: R_MICROMIPS_PC10_S1	l5-0x2
0+0046 <x\+0xa> 3800      	balc	000000cc <l6\+0x48>
			46: R_MICROMIPS_PC10_S1	l6-0x2
	\.\.\.
	\.\.\.
	\.\.\.
	\.\.\.
