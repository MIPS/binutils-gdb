#name: uMIPSr6 JALX contraction
#source: ur6-jalx.s
#as: -march=mips64r6
#ld: -T ur6-jalx.ld --relax
#objdump: -d

.*: +file format .*mips.*

Disassembly of section \.text:

80010000 <test>:
80010000:	b400 005f 	balc	800100c2 <Unear>
80010004:	783e 0000 	auipc	at,0x0
80010008:	a401 00c4 	jialc	at,196
8001000c:	f780 806a 	jalc	870100d4 <Ufar>
80010010:	783e 0800 	auipc	at,0x800
80010014:	a401 00c8 	jialc	at,200
80010018:	783e 0c00 	auipc	at,0xc00
8001001c:	a401 00c9 	jialc	at,201
80010020:	783e 1000 	auipc	at,0x1000
80010024:	a401 00c8 	jialc	at,200
80010028:	9400 004b 	bc	800100c2 <Unear>
8001002c:	783e 0000 	auipc	at,0x0
80010030:	a001 009c 	jic	at,156
80010034:	d780 806a 	jc	870100d4 <Ufar>
80010038:	783e 0800 	auipc	at,0x800
8001003c:	a001 00a0 	jic	at,160
80010040:	783e 0c00 	auipc	at,0xc00
80010044:	a001 00a1 	jic	at,161
80010048:	783e 1000 	auipc	at,0x1000
8001004c:	a001 00a0 	jic	at,160

80010050 <testmips>:
80010050:	ec3e0000 	auipc	at,0x0
80010054:	f8010073 	jialc	at,115
80010058:	e800001b 	balc	800100c8 <Mnear>
8001005c:	ec3e0700 	auipc	at,0x700
80010060:	f8010079 	jialc	at,121
80010064:	0e004036 	jal	880100d8 <Mfar>
80010068:	00000000 	nop
8001006c:	ec3e0c00 	auipc	at,0xc00
80010070:	f8010075 	jialc	at,117
80010074:	ec3e1000 	auipc	at,0x1000
80010078:	f8010074 	jialc	at,116
8001007c:	ec3e0000 	auipc	at,0x0
80010080:	d8010047 	jic	at,71
80010084:	c8000010 	bc	800100c8 <Mnear>
80010088:	ec3e0700 	auipc	at,0x700
8001008c:	d801004d 	jic	at,77
80010090:	0a004036 	j	880100d8 <Mfar>
80010094:	00000000 	nop
80010098:	ec3e0c00 	auipc	at,0xc00
8001009c:	d8010049 	jic	at,73
800100a0:	ec3e1000 	auipc	at,0x1000
800100a4:	d8010048 	jic	at,72

800100a8 <testrel>:
800100a8:	cc0b      	bc	800100c0 <L1>
800100aa:	0c00      	nop
800100ac:	b400 0009 	balc	800100c2 <Unear>
800100b0:	cc07      	bc	800100c0 <L1>
800100b2:	0c00      	nop
800100b4:	cc05      	bc	800100c0 <L1>
800100b6:	0c00      	nop
800100b8:	9400 0003 	bc	800100c2 <Unear>
800100bc:	cc01      	bc	800100c0 <L1>
800100be:	0c00      	nop

800100c0 <L1>:
800100c0:	6db2      	addiu	v1,v1,4

800100c2 <Unear>:
800100c2:	4fe8      	addiu	ra,ra,4
800100c4:	47e3      	jrc	ra
	\.\.\.

800100c8 <Mnear>:
800100c8:	27ff0008 	addiu	ra,ra,8
800100cc:	03e00009 	jr	ra
800100d0:	00000000 	nop
	\.\.\.

870100d4 <Ufar>:
870100d4:	4fe8      	addiu	ra,ra,4
870100d6:	47e3      	jrc	ra
	\.\.\.

880100d8 <Mfar>:
880100d8:	27ff0008 	addiu	ra,ra,8
880100dc:	03e00009 	jr	ra
880100e0:	00000000 	nop
	\.\.\.

8c0100e0 <Urfar>:
8c0100e0:	33ff 0008 	addiu	ra,ra,8
8c0100e4:	47e3      	jrc	ra
	\.\.\.

900100e8 <Mrfar>:
900100e8:	27ff0004 	addiu	ra,ra,4
900100ec:	03e00009 	jr	ra
900100f0:	00000000 	nop
900100f4:	00000000 	nop
