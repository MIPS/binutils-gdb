#objdump: -dr --prefix-addresses --show-raw-insn
#as: -KPIC -mabi=32 -mips32r7 -mmicromips -mno-xlp
#name: MIPSR7 -mabi=32 \(SVR4 PIC\)
#source: mips-abi32-pic.s

.*: +file format.*

Disassembly of section .text\:
0+0000 <func> e000 0002 	aluipc	gp,00000004 <_gp\+0x4>
			0: R_MICROMIPS_PCHI20_M12	_gp
0+0004 <func\+0x4> e094 5244 	lui	a0,0x12345
0+0008 <func\+0x8> 8084 0678 	ori	a0,a0,1656
0+000c <func\+0xc> 849c 8000 	lw	a0,0\(gp\)
			c: R_MICROMIPS_GOT_DISP	\.sdata
0+0010 <func\+0x10> 849c 8000 	lw	a0,0\(gp\)
			10: R_MICROMIPS_GOT_DISP	\.data
0+0014 <func\+0x14> 849c 8000 	lw	a0,0\(gp\)
			14: R_MICROMIPS_GOT_DISP	\.text\+0xe6
0+0018 <func\+0x18> 2800 0000 	bc	00000102 <end\+0x1c>
			18: R_MICROMIPS_PC25_S1	end-0x4
0+001c <func\+0x1c> 873c 8000 	lw	t9,0\(gp\)
			1c: R_MICROMIPS_GOT_DISP	\.text\+0xe6
0+0020 <func\+0x20> db30      	jalrc	t9
0+0022 <func\+0x22> 849c 8000 	lw	a0,0\(gp\)
			22: R_MICROMIPS_GOT_PAGE	\.sdata
0+0026 <func\+0x26> 8484 8000 	lw	a0,0\(a0\)
			26: R_MICROMIPS_GOT_OFST	\.sdata
0+002a <func\+0x2a> 849c 8000 	lw	a0,0\(gp\)
			2a: R_MICROMIPS_GOT_PAGE	\.data
0+002e <func\+0x2e> 8484 8000 	lw	a0,0\(a0\)
			2e: R_MICROMIPS_GOT_OFST	\.data
0+0032 <func\+0x32> 849c 8000 	lw	a0,0\(gp\)
			32: R_MICROMIPS_GOT_PAGE	\.text\+0xe6
0+0036 <func\+0x36> 8484 8000 	lw	a0,0\(a0\)
			36: R_MICROMIPS_GOT_OFST	\.text\+0xe6
0+003a <func\+0x3a> 843c 8000 	lw	at,0\(gp\)
			3a: R_MICROMIPS_GOT_PAGE	\.sdata
0+003e <func\+0x3e> 8481 8000 	lw	a0,0\(at\)
			3e: R_MICROMIPS_GOT_OFST	\.sdata
0+0042 <func\+0x42> 84a1 8000 	lw	a1,0\(at\)
			42: R_MICROMIPS_GOT_OFST	\.sdata\+0x4
0+0046 <func\+0x46> 843c 8000 	lw	at,0\(gp\)
			46: R_MICROMIPS_GOT_PAGE	\.data
0+004a <func\+0x4a> 8481 8000 	lw	a0,0\(at\)
			4a: R_MICROMIPS_GOT_OFST	\.data
0+004e <func\+0x4e> 84a1 8000 	lw	a1,0\(at\)
			4e: R_MICROMIPS_GOT_OFST	\.data\+0x4
0+0052 <func\+0x52> 843c 8000 	lw	at,0\(gp\)
			52: R_MICROMIPS_GOT_PAGE	\.text\+0xe6
0+0056 <func\+0x56> 8481 8000 	lw	a0,0\(at\)
			56: R_MICROMIPS_GOT_OFST	\.text\+0xe6
0+005a <func\+0x5a> 84a1 8000 	lw	a1,0\(at\)
			5a: R_MICROMIPS_GOT_OFST	\.text\+0xea
0+005e <func\+0x5e> 843c 8000 	lw	at,0\(gp\)
			5e: R_MICROMIPS_GOT_PAGE	\.sdata
0+0062 <func\+0x62> 8481 9000 	sw	a0,0\(at\)
			62: R_MICROMIPS_GOT_OFST	\.sdata
0+0066 <func\+0x66> 843c 8000 	lw	at,0\(gp\)
			66: R_MICROMIPS_GOT_PAGE	\.data
0+006a <func\+0x6a> 8481 9000 	sw	a0,0\(at\)
			6a: R_MICROMIPS_GOT_OFST	\.data
0+006e <func\+0x6e> 843c 8000 	lw	at,0\(gp\)
			6e: R_MICROMIPS_GOT_PAGE	\.sdata
0+0072 <func\+0x72> 8481 9000 	sw	a0,0\(at\)
			72: R_MICROMIPS_GOT_OFST	\.sdata
0+0076 <func\+0x76> 84a1 9000 	sw	a1,0\(at\)
			76: R_MICROMIPS_GOT_OFST	\.sdata\+0x4
0+007a <func\+0x7a> 843c 8000 	lw	at,0\(gp\)
			7a: R_MICROMIPS_GOT_PAGE	\.data
0+007e <func\+0x7e> 8481 9000 	sw	a0,0\(at\)
			7e: R_MICROMIPS_GOT_OFST	\.data
0+0082 <func\+0x82> 84a1 9000 	sw	a1,0\(at\)
			82: R_MICROMIPS_GOT_OFST	\.data\+0x4
0+0086 <func\+0x86> 843c 8000 	lw	at,0\(gp\)
			86: R_MICROMIPS_GOT_PAGE	\.data
0+008a <func\+0x8a> 8481 4000 	lh	a0,0\(at\)
			8a: R_MICROMIPS_GOT_OFST	\.data
0+008e <func\+0x8e> 843c 8000 	lw	at,0\(gp\)
			8e: R_MICROMIPS_GOT_PAGE	\.data
0+0092 <func\+0x92> 8481 5000 	sh	a0,0\(at\)
			92: R_MICROMIPS_GOT_OFST	\.data
0+0096 <func\+0x96> 843c 8000 	lw	at,0\(gp\)
			96: R_MICROMIPS_GOT_PAGE	\.data
0+009a <func\+0x9a> 8481 8000 	lw	a0,0\(at\)
			9a: R_MICROMIPS_GOT_OFST	\.data
0+009e <func\+0x9e> 843c 8000 	lw	at,0\(gp\)
			9e: R_MICROMIPS_GOT_PAGE	\.data
0+00a2 <func\+0xa2> 8481 9000 	sw	a0,0\(at\)
			a2: R_MICROMIPS_GOT_OFST	\.data
0+00a6 <func\+0xa6> e090 07fc 	lui	a0,0x3ff00
0+00aa <func\+0xaa> 10a0      	move	a1,zero
0+00ac <func\+0xac> 843c 8000 	lw	at,0\(gp\)
			ac: R_MICROMIPS_GOT_DISP	\.rodata
0+00b0 <func\+0xb0> 8481 8000 	lw	a0,0\(at\)
			b0: R_MICROMIPS_LO12	\.rodata
0+00b4 <func\+0xb4> 84a1 8000 	lw	a1,0\(at\)
			b4: R_MICROMIPS_LO12	\.rodata\+0x4
0+00b8 <func\+0xb8> e030 07fc 	lui	at,0x3ff00
0+00bc <func\+0xbc> a020 383b 	mthc1	at,\$f0
0+00c0 <func\+0xc0> a000 283b 	mtc1	zero,\$f0
0+00c4 <func\+0xc4> 843c 8000 	lw	at,0\(gp\)
			c4: R_MICROMIPS_GOT_DISP	\.rodata\+0x8
0+00c8 <func\+0xc8> 843c 8000 	lw	at,0\(gp\)
			c8: R_MICROMIPS_GOT_PAGE	\.rodata\+0x8
0+00cc <func\+0xcc> 2021 0950 	addu	at,at,at
0+00d0 <func\+0xd0> 8401 e000 	ldc1	\$f0,0\(at\)
			d0: R_MICROMIPS_GOT_OFST	\.rodata\+0x8
0+00d4 <func\+0xd4> 0085 0064 	addiu	a0,a1,100
0+00d8 <func\+0xd8> 8084 5001 	sltiu	a0,a0,1
0+00dc <func\+0xdc> 0085 0064 	addiu	a0,a1,100
0+00e0 <func\+0xe0> 2080 2390 	sltu	a0,zero,a0
0+00e4 <func\+0xe4> 1085      	move	a0,a1
	...
#pass
