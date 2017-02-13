#objdump: -dr --prefix-addresses --show-raw-insn
#as: -mabi=32 -KPIC -mips32r7 -mmicromips
#name: MIPS -mabi=32 test 2 \(SVR4 PIC\) R7
#source: mips-abi32-pic2.s

dump.o:     file format elf32-tradbigmips

Disassembly of section \.text:
0+0000 <func1> e000 0002 	aluipc	gp,00000004 <_gp\+0x4>
			0: R_MICROMIPS_PCHI20_M12	_gp
0+0004 <func1\+0x4> 4320 0002 	lw	t9,0\(gp\)
			4: R_MICROMIPS_GOT_DISP	end
0+0008 <func1\+0x8> db30      	jalrc	t9
0+000a <func1\+0xa> 9008      	nop
0+000c <func1\+0xc> db30      	jalrc	t9
0+000e <func2> e000 0002 	aluipc	gp,00000012 <_gp\+0x12>
			e: R_MICROMIPS_PCHI20_M12	_gp
0+0012 <func2\+0x4> 4320 0002 	lw	t9,0\(gp\)
			12: R_MICROMIPS_GOT_DISP	end
0+0016 <func2\+0x8> db30      	jalrc	t9
0+0018 <func2\+0xa> 9008      	nop
0+001a <func2\+0xc> db30      	jalrc	t9
0+001c <func3> e000 0002 	aluipc	gp,00000020 <_gp\+0x20>
			1c: R_MICROMIPS_PCHI20_M12	_gp
0+0020 <func3\+0x4> 4320 0002 	lw	t9,0\(gp\)
			20: R_MICROMIPS_GOT_DISP	end
0+0024 <func3\+0x8> db30      	jalrc	t9
0+0026 <func3\+0xa> 9008      	nop
0+0028 <func3\+0xc> db30      	jalrc	t9
	\.\.\.
#pass