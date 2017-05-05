#objdump: -dr --show-raw-insn --prefix-addresses
#name: MIPSR7 -mgp32 -mfp64 \(SVR4 PIC\)
#source: mips-gp32-fp64-pic.s
#as: -mno-xlp

.*: +file format.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> e380 0002 	aluipc	gp,[0-9a-f]+ <[^>]+>
			[0-9A-F]+: R_MICROMIPS_PCHI20	_gp-0x4
[0-9a-f]+ <[^>]+> e094 5244 	lui	a0,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8084 0678 	ori	a0,a0,1656
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.sdata
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_DISP	\.data
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_DISP	end
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9A-F]+: R_MICROMIPS_PC25_S1	end-0x4
[0-9a-f]+ <[^>]+> 4320 0002 	lw	t9,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	end
[0-9a-f]+ <[^>]+> db30      	jalrc	t9
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.sdata
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	end
[0-9a-f]+ <[^>]+> 8484 8000 	lw	a0,0\(a0\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	end
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.sdata
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	end
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	end
[0-9a-f]+ <[^>]+> 84a1 8000 	lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	end\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.sdata
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.sdata
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.sdata
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.sdata\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 84a1 9000 	sw	a1,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.data\+0x4
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 4000 	lh	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 5000 	sh	a0,0\(at\)
			[0-9A-F]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9A-F]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	\.data
[0-9a-f]+ <[^>]+> 8481 9000 	sw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.data
[0-9a-f]+ <[^>]+> e090 07fc 	lui	a0,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> 10a0      	move	a1,zero
[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.rodata
[0-9a-f]+ <[^>]+> 8481 8000 	lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> 84a1 8004 	lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> e030 07fc 	lui	at,%hi\(0x3ff00000\)
[0-9a-f]+ <[^>]+> a020 383b 	mthc1	at,\$f0
[0-9a-f]+ <[^>]+> a000 283b 	mtc1	zero,\$f0
#[0-9a-f]+ <[^>]+> 4020 0002 	lw	at,0\(gp\)
#			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.rodata\+0x8
#[0-9a-f]+ <[^>]+> 8401 e000 	ldc1	\$f0,0\(at\)
#			[0-9a-f]+: R_MICROMIPS_GOT_OFST	\.rodata\+0x8
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 8084 5001 	sltiu	a0,a0,1
[0-9a-f]+ <[^>]+> 0085 0064 	addiu	a0,a1,100
[0-9a-f]+ <[^>]+> 2080 2390 	sltu	a0,zero,a0
[0-9a-f]+ <[^>]+> 1085      	move	a0,a1
[0-9a-f]+ <[^>]+> a062 0930 	add\.d	\$f1,\$f2,\$f3
	\.\.\.
#pass
