#objdump: -dr --prefix-addresses  --show-raw-insn
#nam[0-9a-f]+: nanoMIPS 32-bit ABI
#as: -EB

.*: +file format.*

Disassembly of section \.text:
[0-9a-f]+ <func> e094 5244 	lui	a0,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8084 0678 	ori	a0,a0,0x678
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8084 0000 	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	end
[0-9a-f]+ <[^>]+> 8084 0000 	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	end
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	end
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	end
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> 40a0 0002 	lw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	end
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	end\+0x4
[0-9a-f]+ <[^>]+> 4080 0003 	sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 4080 0003 	sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata
[0-9a-f]+ <[^>]+> 40a0 0003 	sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sdata\+0x4
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x4
[0-9a-f]+ <[^>]+> e090 07fc 	lui	a0,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> 10a0      	move	a1,zero
[0-9a-f]+ <[^>]+> e020 0000 	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.rodata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.rodata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.rodata\+0x4
[0-9a-f]+ <[^>]+> e030 07fc 	lui	at,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> a020 383b 	mthc1	at,\$f0
[0-9a-f]+ <[^>]+> a000 283b 	mtc1	zero,\$f0
[0-9a-f]+ <[^>]+> 4418 0002 	ldc1	\$f0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	\.sdata\+0x4
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 8084 5001 	sltiu	a0,a0,1
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 2080 2390 	sltu	a0,zero,a0
[0-9a-f]+ <[^>]+> 1085      	move	a0,a1
#pass
