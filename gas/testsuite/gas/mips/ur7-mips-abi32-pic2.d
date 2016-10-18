#objdump: -dr --prefix-addresses --show-raw-insn
#as: -mabi=32 -KPIC -mips32r7 -mmicromips
#name: MIPS -mabi=32 test 2 (SVR4 PIC) R7
#source: mips-abi32-pic2.s

dump.o:     file format elf32-tradbigmips

Disassembly of section \.text:
0+0000 <func1> e001 0002 	aluipc	gp,00000010 <_gp\+0x10>
			0: R_MICROMIPS_PCHI20_M12	_gp
0+0004 <func1\+0x4> 873c 8000 	lw	t9,0\(gp\)
			4: R_MICROMIPS_GOT_DISP	.text\+0x30
0+0008 <func1\+0x8> 4bf9 0000 	jalrc	t9
			8: R_MICROMIPS_CALL_HI20	.text\+0x30
0+000c <func1\+0xc> 9008      	nop
0+000e <func1\+0xe> db30      	jalrc	t9
0+0010 <func2> e001 0002 	aluipc	gp,00000020 <_gp\+0x20>
			10: R_MICROMIPS_PCHI20_M12	_gp
0+0014 <func2\+0x4> 873c 8000 	lw	t9,0\(gp\)
			14: R_MICROMIPS_GOT_DISP	.text\+0x30
0+0018 <func2\+0x8> 4bf9 0000 	jalrc	t9
			18: R_MICROMIPS_CALL_HI20	.text\+0x30
0+001c <func2\+0xc> 9008      	nop
0+001e <func2\+0xe> db30      	jalrc	t9
0+0020 <func3> e001 0002 	aluipc	gp,00000030 <_gp\+0x30>
			20: R_MICROMIPS_PCHI20_M12	_gp
0+0024 <func3\+0x4> 873c 8000 	lw	t9,0\(gp\)
			24: R_MICROMIPS_GOT_DISP	.text\+0x30
0+0028 <func3\+0x8> 4bf9 0000 	jalrc	t9
			28: R_MICROMIPS_CALL_HI20	.text\+0x30
0+002c <func3\+0xc> 9008      	nop
0+002e <func3\+0xe> db30      	jalrc	t9
	...
