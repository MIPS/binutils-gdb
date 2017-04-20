#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 %-operations in assemblly
#as: -mmicromips -mips32r7

# Check MIPSR7 percent-ops

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <test> 4498 0000 	lwc1	\$f4,0\(gp\)
			0: R_MICROMIPS_GPREL16_S2	\.L0
0+0004 <test\+0x4> 4498 0001 	swc1	\$f4,0\(gp\)
			4: R_MICROMIPS_GPREL16_S2	\.L0
0+0008 <test\+0x8> 4498 0002 	ldc1	\$f4,0\(gp\)
			8: R_MICROMIPS_GPREL16_S2	\.L0
0+000c <test\+0xc> 4498 0003 	sdc1	\$f4,0\(gp\)
			c: R_MICROMIPS_GPREL16_S2	\.L0
