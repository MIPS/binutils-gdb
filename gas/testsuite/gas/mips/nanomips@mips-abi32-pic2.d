#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS -mabi=32 test 2 \(SVR4 PIC\) nanoMIPS
#source: mips-abi32-pic2.s
#as:

dump.o:     file format .*mips.*

Disassembly of section \.text:
0+0000 <func1> e380 0002 	aluipc	gp,00000000 <_gp>
			0: R_NANOMIPS_PCHI20	_gp
0+0004 <func1\+0x4> 4320 0002 	lw	t9,0\(gp\)
			4: R_NANOMIPS_GOT_DISP	end
0+0008 <func1\+0x8> db30      	jalrc	t9
0+000a <func1\+0xa> 9008      	nop
0+000c <func1\+0xc> db30      	jalrc	t9
0+000e <func2> e380 0002 	aluipc	gp,00000000 <_gp>
			e: R_NANOMIPS_PCHI20	_gp
0+0012 <func2\+0x4> 4320 0002 	lw	t9,0\(gp\)
			12: R_NANOMIPS_GOT_DISP	end
0+0016 <func2\+0x8> db30      	jalrc	t9
0+0018 <func2\+0xa> 9008      	nop
0+001a <func2\+0xc> db30      	jalrc	t9
0+001c <func3> e380 0002 	aluipc	gp,00000000 <_gp>
			1c: R_NANOMIPS_PCHI20	_gp
0+0020 <func3\+0x4> 4320 0002 	lw	t9,0\(gp\)
			20: R_NANOMIPS_GOT_DISP	end
0+0024 <func3\+0x8> db30      	jalrc	t9
0+0026 <func3\+0xa> 9008      	nop
0+0028 <func3\+0xc> db30      	jalrc	t9
	\.\.\.
#pass