#objdump: -dr --show-raw-insn --prefix-addresses
#name: nanoMIPS -mgp32 -mfp64 (SVR4 PIC)
#as: -EB

.*: +file format.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> e380 0002 	aluipc	gp,[0-9a-f]+ <[^>]+>
			0: R_NANOMIPS_PCHI20	_gp
[0-9a-f]+ <[^>]+> e094 5244 	lui	a0,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8084 0678 	ori	a0,a0,1656
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <shared>
			c: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			10: R_NANOMIPS_LO12	.sdata
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <unshared>
			14: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			18: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,000000e6 <end>
			1c: R_NANOMIPS_PCHI20	end
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			20: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 2800 0000 	bc	000000e6 <end>
			24: R_NANOMIPS_PC25_S1	end
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			28: R_NANOMIPS_GOT_DISP	end
[0-9a-f]+ <[^>]+> d830      	jalrc	at
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,00000000 <shared>
			2e: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			32: R_NANOMIPS_LO12	.sdata
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,00000000 <unshared>
			36: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			3a: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,000000e6 <end>
			3e: R_NANOMIPS_PCHI20	end
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			42: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			46: R_NANOMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			4a: R_NANOMIPS_GOT_OFST	\.sdata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			4e: R_NANOMIPS_GOT_OFST	.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			52: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			56: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			5a: R_NANOMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			5e: R_NANOMIPS_GOT_PAGE	end
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			62: R_NANOMIPS_GOT_OFST	end
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			66: R_NANOMIPS_GOT_OFST	end\+0x4
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <shared>
			6a: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			6e: R_NANOMIPS_LO12	\.sdata
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			72: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			76: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			7a: R_NANOMIPS_GOT_PAGE	.sdata
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			7e: R_NANOMIPS_GOT_OFST	.sdata
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			82: R_NANOMIPS_GOT_OFST	.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			86: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			8a: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			8e: R_NANOMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			92: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 4000 	lh	a0,0\(at\)
			96: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			9a: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 5000 	sh	a0,0\(at\)
			9e: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			a2: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			a6: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			aa: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			ae: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e090 07fc 	lui	a0,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> 10a0      	move	a1,zero
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			b8: R_NANOMIPS_GOT_DISP	.rodata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> 84a1 8004 	lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> e030 07fc 	lui	at,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> a020 383b 	mthc1	at,\$f0
[0-9a-f]+ <[^>]+> a000 283b 	mtc1	zero,\$f0
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 8084 5001 	sltiu	a0,a0,1
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 2080 2390 	sltu	a0,zero,a0
[0-9a-f]+ <[^>]+> 1085      	move	a0,a1
[0-9a-f]+ <[^>]+> a062 0930 	add.d	\$f1,\$f2,\$f3
	...
[0-9a-f]+ <[^>]+> 9008      	nop
