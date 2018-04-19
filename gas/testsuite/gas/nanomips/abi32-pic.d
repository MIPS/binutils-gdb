#objdump: -dr --prefix-addresses --show-raw-insn
#nam[0-9a-f]+: nanoMIPS -m32 (SVR4 PIC)
#as: -EB -mno-minimize-relocs

.*: +file format.*

Disassembly of section .text\:
[0-9a-f]+ <[^>]+> e380 0002 	aluipc	gp,[0-9a-f]+ <_gp>
			[0-9a-f]+: R_NANOMIPS_PCHI20	_gp
[0-9a-f]+ <[^>]+> e094 5244 	lui	a0,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8084 0678 	ori	a0,a0,0x678
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <shared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	.sdata
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <unshared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <end>
			[0-9a-f]+: R_NANOMIPS_PCHI20	end
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <end>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	end
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	end
[0-9a-f]+ <[^>]+> d830      	jalrc	at
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,00000000 <shared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_LO12	.sdata
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,00000000 <unshared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <end>
			[0-9a-f]+: R_NANOMIPS_PCHI20	end
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_LO12	end
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.sdata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	end
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	end
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	end\+0x4
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <shared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	shared
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	.sdata
[0-9a-f]+ <[^>]+> e020 0002 	aluipc	at,00000000 <unshared>
			[0-9a-f]+: R_NANOMIPS_PCHI20	unshared
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.sdata
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.sdata
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> e090 07fc 	lui	a0,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> 10a0      	move	a1,zero
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.rodata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.rodata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.rodata\+0x4
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 8084 5001 	sltiu	a0,a0,1
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 2080 2390 	sltu	a0,zero,a0
[0-9a-f]+ <[^>]+> 1085      	move	a0,a1
#pass
