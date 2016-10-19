#objdump: -dr --prefix-addresses  --show-raw-insn
#as: -EB -mabi=32 -mips32r7 -mmicromips
#name: MIPSR7 -mabi=32
#source: mips-abi32.s

.*: +file format.*

Disassembly of section \.text:
0+0000 <func> e094 5244 	lui	a0,0x12345
0+0004 <func\+0x4> 8084 0678 	ori	a0,a0,1656
0+0008 <func\+0x8> 4080 0000 	addiu	a0,gp,0
			8: R_MICROMIPS_GPREL19_S2	\.sdata
0+000c <func\+0xc> e080 0000 	lui	a0,0x0
			c: R_MICROMIPS_HI20	\.data
0+0010 <func\+0x10> 0084 0000 	addiu	a0,a0,0
			10: R_MICROMIPS_LO12	\.data
0+0014 <func\+0x14> e080 0000 	lui	a0,0x0
			14: R_MICROMIPS_HI20	end
0+0018 <func\+0x18> 0084 0000 	addiu	a0,a0,0
			18: R_MICROMIPS_LO12	end
0+001c <func\+0x1c> 2800 0000 	bc	000000f4 <end\+0x20>
			1c: R_MICROMIPS_PC25_S1	end-0x4
0+0020 <func\+0x20> 2a00 0000 	balc	000000f8 <end\+0x24>
			20: R_MICROMIPS_PC25_S1	end-0x4
0+0024 <func\+0x24> 4080 0002 	lw	a0,0\(gp\)
			24: R_MICROMIPS_GPREL19_S2	\.sdata
0+0028 <func\+0x28> e080 0000 	lui	a0,0x0
			28: R_MICROMIPS_HI20	\.data
0+002c <func\+0x2c> 8484 8000 	lw	a0,0\(a0\)
			2c: R_MICROMIPS_LO12	\.data
0+0030 <func\+0x30> e080 0000 	lui	a0,0x0
			30: R_MICROMIPS_HI20	end
0+0034 <func\+0x34> 8484 8000 	lw	a0,0\(a0\)
			34: R_MICROMIPS_LO12	end
0+0038 <func\+0x38> 4080 0002 	lw	a0,0\(gp\)
			38: R_MICROMIPS_GPREL19_S2	\.sdata
0+003c <func\+0x3c> 40a0 0002 	lw	a1,0\(gp\)
			3c: R_MICROMIPS_GPREL19_S2	\.sdata\+0x4
0+0040 <func\+0x40> e020 0000 	lui	at,0x0
			40: R_MICROMIPS_HI20	\.data
0+0044 <func\+0x44> 8481 8000 	lw	a0,0\(at\)
			44: R_MICROMIPS_LO12	\.data
0+0048 <func\+0x48> 84a1 8000 	lw	a1,0\(at\)
			48: R_MICROMIPS_LO12	\.data\+0x4
0+004c <func\+0x4c> e020 0000 	lui	at,0x0
			4c: R_MICROMIPS_HI20	end
0+0050 <func\+0x50> 8481 8000 	lw	a0,0\(at\)
			50: R_MICROMIPS_LO12	end
0+0054 <func\+0x54> 84a1 8000 	lw	a1,0\(at\)
			54: R_MICROMIPS_LO12	end\+0x4
0+0058 <func\+0x58> 4080 0003 	sw	a0,0\(gp\)
			58: R_MICROMIPS_GPREL19_S2	\.sdata
0+005c <func\+0x5c> e020 0000 	lui	at,0x0
			5c: R_MICROMIPS_HI20	\.data
0+0060 <func\+0x60> 8481 9000 	sw	a0,0\(at\)
			60: R_MICROMIPS_LO12	\.data
0+0064 <func\+0x64> 4080 0003 	sw	a0,0\(gp\)
			64: R_MICROMIPS_GPREL19_S2	\.sdata
0+0068 <func\+0x68> 40a0 0003 	sw	a1,0\(gp\)
			68: R_MICROMIPS_GPREL19_S2	\.sdata\+0x4
0+006c <func\+0x6c> e020 0000 	lui	at,0x0
			6c: R_MICROMIPS_HI20	\.data
0+0070 <func\+0x70> 8481 9000 	sw	a0,0\(at\)
			70: R_MICROMIPS_LO12	\.data
0+0074 <func\+0x74> 84a1 9000 	sw	a1,0\(at\)
			74: R_MICROMIPS_LO12	\.data\+0x4
0+0078 <func\+0x78> e020 0000 	lui	at,0x0
			78: R_MICROMIPS_HI20	\.data
0+007c <func\+0x7c> 8481 4000 	lh	a0,0\(at\)
			7c: R_MICROMIPS_LO12	\.data
0+0080 <func\+0x80> e020 0000 	lui	at,0x0
			80: R_MICROMIPS_HI20	\.data
0+0084 <func\+0x84> 8481 5000 	sh	a0,0\(at\)
			84: R_MICROMIPS_LO12	\.data
0+0088 <func\+0x88> e020 0000 	lui	at,0x0
			88: R_MICROMIPS_HI20	\.data
0+008c <func\+0x8c> 8481 8000 	lw	a0,0\(at\)
			8c: R_MICROMIPS_LO12	\.data
0+0090 <func\+0x90> e020 0000 	lui	at,0x0
			90: R_MICROMIPS_HI20	\.data
0+0094 <func\+0x94> 8481 9000 	sw	a0,0\(at\)
			94: R_MICROMIPS_LO12	\.data
0+0098 <func\+0x98> e090 07fc 	lui	a0,0x3ff00
0+009c <func\+0x9c> 10a0      	move	a1,zero
0+009e <func\+0x9e> e020 0000 	lui	at,0x0
			9e: R_MICROMIPS_HI20	\.rodata
0+00a2 <func\+0xa2> 8481 8000 	lw	a0,0\(at\)
			a2: R_MICROMIPS_LO12	\.rodata
0+00a6 <func\+0xa6> 84a1 8000 	lw	a1,0\(at\)
			a6: R_MICROMIPS_LO12	\.rodata\+0x4
0+00aa <func\+0xaa> e030 07fc 	lui	at,0x3ff00
0+00ae <func\+0xae> a020 383b 	mthc1	at,\$f0
0+00b2 <func\+0xb2> a000 283b 	mtc1	zero,\$f0
0+00b6 <func\+0xb6> e020 0000 	lui	at,0x0
			b6: R_MICROMIPS_HI20	\.lit8
0+00ba <func\+0xba> 2381 0950 	addu	at,at,gp
0+00be <func\+0xbe> 8401 e000 	ldc1	\$f0,0\(at\)
			be: R_MICROMIPS_LO12	\.lit8
0+00c2 <func\+0xc2> 0085 0064 	addiu	a0,a1,100
0+00c6 <func\+0xc6> 8084 5001 	sltiu	a0,a0,1
0+00ca <func\+0xca> 0085 0064 	addiu	a0,a1,100
0+00ce <func\+0xce> 2080 2390 	sltu	a0,zero,a0
0+00d2 <func\+0xd2> 1085      	move	a0,a1
	\.\.\.
