#objdump: -dr --prefix-addresses  --show-raw-insn
#as: -EB -mabi=32 -mips32r7 -mmicromips -mno-xlp
#name: MIPSR7 -mabi=32
#source: mips-abi32.s

.*: +file format.*

Disassembly of section \.text:
[0-9a-f]+ <func> e094 5244 	lui	a0,0x12345
[0-9a-f]+ <[^>]+> 8084 0678 	ori	a0,a0,1656
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			8: R_MICROMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			c: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			10: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			14: R_MICROMIPS_HI20	end
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			18: R_MICROMIPS_LO12	end
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			1c: R_MICROMIPS_PC25_S1	end-0x4
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <[^>]+>
			20: R_MICROMIPS_PC25_S1	end-0x4
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			24: R_MICROMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			28: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			2c: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			30: R_MICROMIPS_HI20	end
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			34: R_MICROMIPS_LO12	end
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			38: R_MICROMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> 40a0 0002 	lw	a1,0\(gp\)
			3c: R_MICROMIPS_GPREL19_S2	\.sdata\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			40: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			44: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			48: R_MICROMIPS_LO12	\.data\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			4c: R_MICROMIPS_HI20	end
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			50: R_MICROMIPS_LO12	end
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			54: R_MICROMIPS_LO12	end\+0x4
[0-9a-f]+ <[^>]+> 4080 0003 	sw	a0,0\(gp\)
			58: R_MICROMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			5c: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			60: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 4080 0003 	sw	a0,0\(gp\)
			64: R_MICROMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> 40a0 0003 	sw	a1,0\(gp\)
			68: R_MICROMIPS_GPREL19_S2	\.sdata\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			6c: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			70: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			74: R_MICROMIPS_LO12	\.data\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			78: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 4000 	lh	a0,0\(at\)
			7c: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			80: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 5000 	sh	a0,0\(at\)
			84: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			88: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			8c: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			90: R_MICROMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			94: R_MICROMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e090 07fc 	lui	a0,0x3ff00
[0-9a-f]+ <[^>]+> 10a0      	move	a1,zero
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			9e: R_MICROMIPS_HI20	\.rodata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			a2: R_MICROMIPS_LO12	\.rodata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			a6: R_MICROMIPS_LO12	\.rodata\+0x4
[0-9a-f]+ <[^>]+> e030 07fc 	lui	at,0x3ff00
[0-9a-f]+ <[^>]+> a020 383b 	mthc1	at,\$f0
[0-9a-f]+ <[^>]+> a000 283b 	mtc1	zero,\$f0
[0-9a-f]+ <[^>]+> 841c e000 	ldc1	\$f0,0\(gp\)
			b6: R_MICROMIPS_LITERAL	\.lit8
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 8084 5001 	sltiu	a0,a0,1
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 2080 2390 	sltu	a0,zero,a0
[0-9a-f]+ <[^>]+> 1085      	move	a0,a1
	\.\.\.
