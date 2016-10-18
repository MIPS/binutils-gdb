#objdump: -d --show-raw-insn --prefix-addresses
#as: -32 -mgp32 -mfp64 -KPIC -mips32r7 -mmicromips
#name: MIPSR7 -mgp32 -mfp64 (SVR4 PIC)
#source: mips-gp32-fp64-pic.s

.*: +file format.*

Disassembly of section \.text:
0+0000 <func> e001 0002 	aluipc	gp,00000010 <_gp\+0x10>
			0: R_MICROMIPS_PCHI20_M12	_gp
0+0004 <func\+0x4> 2384 2150 	addu	a0,a0,gp
0+0008 <func\+0x8> e094 5244 	lui	a0,0x12345
0+000c <func\+0xc> 8084 0678 	ori	a0,a0,1656
0+0010 <func\+0x10> 849c 8000 	lw	a0,0\(gp\)
			10: R_MICROMIPS_GOT_DISP	.sdata
0+0014 <func\+0x14> 849c 8000 	lw	a0,0\(gp\)
			14: R_MICROMIPS_GOT_DISP	.data
0+0018 <func\+0x18> 849c 8000 	lw	a0,0\(gp\)
			18: R_MICROMIPS_GOT_DISP	.text\+0xf0
0+001c <func\+0x1c> 2800 0000 	bc	00000110 <end\+0x20>
			1c: R_MICROMIPS_PC25_S1	end-0x4
0+0020 <func\+0x20> 873c 8000 	lw	t9,0\(gp\)
			20: R_MICROMIPS_GOT_DISP	.text\+0xf0
0+0024 <func\+0x24> 4bf9 0000 	jalrc	t9
			24: R_MICROMIPS_CALL_HI20	.text\+0xf0
0+0028 <func\+0x28> 849c 8000 	lw	a0,0\(gp\)
			28: R_MICROMIPS_GOT_PAGE	.sdata
0+002c <func\+0x2c> 8484 8000 	lw	a0,0\(a0\)
			2c: R_MICROMIPS_GOT_OFST	.sdata
0+0030 <func\+0x30> 849c 8000 	lw	a0,0\(gp\)
			30: R_MICROMIPS_GOT_PAGE	.data
0+0034 <func\+0x34> 8484 8000 	lw	a0,0\(a0\)
			34: R_MICROMIPS_GOT_OFST	.data
0+0038 <func\+0x38> 849c 8000 	lw	a0,0\(gp\)
			38: R_MICROMIPS_GOT_PAGE	.text\+0xf0
0+003c <func\+0x3c> 8484 8000 	lw	a0,0\(a0\)
			3c: R_MICROMIPS_GOT_OFST	.text\+0xf0
0+0040 <func\+0x40> 843c 8000 	lw	at,0\(gp\)
			40: R_MICROMIPS_GOT_DISP	.sdata
0+0044 <func\+0x44> 8481 8000 	lw	a0,0\(at\)
			44: R_MICROMIPS_LO12	.sdata
0+0048 <func\+0x48> 84a1 8000 	lw	a1,0\(at\)
			48: R_MICROMIPS_LO12	.sdata\+0x4
0+004c <func\+0x4c> 843c 8000 	lw	at,0\(gp\)
			4c: R_MICROMIPS_GOT_DISP	.data
0+0050 <func\+0x50> 8481 8000 	lw	a0,0\(at\)
			50: R_MICROMIPS_LO12	.data
0+0054 <func\+0x54> 84a1 8000 	lw	a1,0\(at\)
			54: R_MICROMIPS_LO12	.data\+0x4
0+0058 <func\+0x58> 843c 8000 	lw	at,0\(gp\)
			58: R_MICROMIPS_GOT_DISP	.text\+0xf0
0+005c <func\+0x5c> 8481 8000 	lw	a0,0\(at\)
			5c: R_MICROMIPS_LO12	.text\+0xf0
0+0060 <func\+0x60> 84a1 8000 	lw	a1,0\(at\)
			60: R_MICROMIPS_LO12	.text\+0xf4
0+0064 <func\+0x64> 843c 8000 	lw	at,0\(gp\)
			64: R_MICROMIPS_GOT_PAGE	.sdata
0+0068 <func\+0x68> 8481 9000 	sw	a0,0\(at\)
			68: R_MICROMIPS_GOT_OFST	.sdata
0+006c <func\+0x6c> 843c 8000 	lw	at,0\(gp\)
			6c: R_MICROMIPS_GOT_PAGE	.data
0+0070 <func\+0x70> 8481 9000 	sw	a0,0\(at\)
			70: R_MICROMIPS_GOT_OFST	.data
0+0074 <func\+0x74> 843c 8000 	lw	at,0\(gp\)
			74: R_MICROMIPS_GOT_DISP	.sdata
0+0078 <func\+0x78> 8481 9000 	sw	a0,0\(at\)
			78: R_MICROMIPS_LO12	.sdata
0+007c <func\+0x7c> 84a1 9000 	sw	a1,0\(at\)
			7c: R_MICROMIPS_LO12	.sdata\+0x4
0+0080 <func\+0x80> 843c 8000 	lw	at,0\(gp\)
			80: R_MICROMIPS_GOT_DISP	.data
0+0084 <func\+0x84> 8481 9000 	sw	a0,0\(at\)
			84: R_MICROMIPS_LO12	.data
0+0088 <func\+0x88> 84a1 9000 	sw	a1,0\(at\)
			88: R_MICROMIPS_LO12	.data\+0x4
0+008c <func\+0x8c> 843c 8000 	lw	at,0\(gp\)
			8c: R_MICROMIPS_GOT_PAGE	.data
0+0090 <func\+0x90> 8481 4000 	lh	a0,0\(at\)
			90: R_MICROMIPS_GOT_OFST	.data
0+0094 <func\+0x94> 843c 8000 	lw	at,0\(gp\)
			94: R_MICROMIPS_GOT_PAGE	.data
0+0098 <func\+0x98> 8481 5000 	sh	a0,0\(at\)
			98: R_MICROMIPS_GOT_OFST	.data
0+009c <func\+0x9c> 843c 8000 	lw	at,0\(gp\)
			9c: R_MICROMIPS_GOT_PAGE	.data
0+00a0 <func\+0xa0> 8481 8000 	lw	a0,0\(at\)
			a0: R_MICROMIPS_GOT_OFST	.data
0+00a4 <func\+0xa4> 843c 8000 	lw	at,0\(gp\)
			a4: R_MICROMIPS_GOT_PAGE	.data
0+00a8 <func\+0xa8> 8481 9000 	sw	a0,0\(at\)
			a8: R_MICROMIPS_GOT_OFST	.data
0+00ac <func\+0xac> e090 07fc 	lui	a0,0x3ff00
0+00b0 <func\+0xb0> 10a0      	move	a1,zero
0+00b2 <func\+0xb2> 843c 8000 	lw	at,0\(gp\)
			b2: R_MICROMIPS_GOT_DISP	.rodata
0+00b6 <func\+0xb6> 8481 8000 	lw	a0,0\(at\)
			b6: R_MICROMIPS_LO12	.rodata
0+00ba <func\+0xba> 84a1 8000 	lw	a1,0\(at\)
			ba: R_MICROMIPS_LO12	.rodata\+0x4
0+00be <func\+0xbe> e030 07fc 	lui	at,0x3ff00
0+00c2 <func\+0xc2> a020 383b 	mthc1	at,\$f0
0+00c6 <func\+0xc6> a000 283b 	mtc1	zero,\$f0
0+00ca <func\+0xca> 843c 8000 	lw	at,0\(gp\)
			ca: R_MICROMIPS_GOT_DISP	.rodata\+0x8
0+00ce <func\+0xce> 843c 8000 	lw	at,0\(gp\)
			ce: R_MICROMIPS_GOT_PAGE	.rodata\+0x8
0+00d2 <func\+0xd2> 2021 0950 	addu	at,at,at
0+00d6 <func\+0xd6> 8401 e000 	ldc1	\$f0,0\(at\)
			d6: R_MICROMIPS_GOT_OFST	.rodata\+0x8
0+00da <func\+0xda> 0085 0064 	addiu	a0,a1,100
0+00de <func\+0xde> 8084 5001 	sltiu	a0,a0,1
0+00e2 <func\+0xe2> 0085 0064 	addiu	a0,a1,100
0+00e6 <func\+0xe6> 2080 2390 	sltu	a0,zero,a0
0+00ea <func\+0xea> 1085      	move	a0,a1
0+00ec <func\+0xec> a062 0930 	add.d	\$f1,\$f2,\$f3
	\.\.\.
