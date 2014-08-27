#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS uMIPSr6 JALX expansions

.*: +file format .*mips.*

Disassembly of section .text:
00000000 <L1> 783e 0000 	auipc	at,0x0
			0: R_MIPS_PCHI16	Urfar
00000004 <[^>]*> a401 0004 	jialc	at,4
			4: R_MIPS_PCLO16	Urfar
00000008 <[^>]*> 783e 0000 	auipc	at,0x0
			8: R_MIPS_PCHI16	Mrfar
0000000c <[^>]*> a401 0004 	jialc	at,4
			c: R_MIPS_PCLO16	Mrfar
00000010 <[^>]*> 783e 0000 	auipc	at,0x0
			10: R_MIPS_PCHI16	Urfar
00000014 <[^>]*> a001 0004 	jic	at,4
			14: R_MIPS_PCLO16	Urfar
00000018 <[^>]*> 783e 0000 	auipc	at,0x0
			18: R_MIPS_PCHI16	Mrfar
0000001c <[^>]*> a001 0004 	jic	at,4
			1c: R_MIPS_PCLO16	Mrfar
00000020 <L2> ec3e0000 	auipc	at,0x0
			20: R_MIPS_PCHI16	Urfar
00000024 <[^>]*> f8010004 	jialc	at,4
			24: R_MIPS_PCLO16	Urfar
00000028 <[^>]*> ec3e0000 	auipc	at,0x0
			28: R_MIPS_PCHI16	Mrfar
0000002c <[^>]*> f8010004 	jialc	at,4
			2c: R_MIPS_PCLO16	Mrfar
00000030 <[^>]*> ec3e0000 	auipc	at,0x0
			30: R_MIPS_PCHI16	Urfar
00000034 <[^>]*> d8010004 	jic	at,4
			34: R_MIPS_PCLO16	Urfar
00000038 <[^>]*> ec3e0000 	auipc	at,0x0
			38: R_MIPS_PCHI16	Mrfar
0000003c <[^>]*> d8010004 	jic	at,4
			3c: R_MIPS_PCLO16	Mrfar
	\.\.\.
04000040 <[^>]*> 0c00      	nop
04000042 <[^>]*> 0000 0000 	nop
	\.\.\.
	\.\.\.
