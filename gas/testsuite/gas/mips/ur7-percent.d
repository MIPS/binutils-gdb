#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS %-operations in assemblly
#as: -mips32r7

# Check nanoMIPS percent-ops

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <test> 448c 0000 	lwc1	\$f4,0\(gp\)
			0: R_NANOMIPS_GPREL16_S2	\.L0
0+0004 <test\+0x4> 448c 0001 	swc1	\$f4,0\(gp\)
			4: R_NANOMIPS_GPREL16_S2	\.L0
0+0008 <test\+0x8> 448c 0002 	ldc1	\$f4,0\(gp\)
			8: R_NANOMIPS_GPREL16_S2	\.L0
0+000c <test\+0xc> 448c 0003 	sdc1	\$f4,0\(gp\)
			c: R_NANOMIPS_GPREL16_S2	\.L0
