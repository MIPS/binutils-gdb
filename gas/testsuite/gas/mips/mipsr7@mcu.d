#objdump: -dr --show-raw-insn --prefix-addresses
#name: MCU for MIPS32r7
#as: -p32
#source: mcu.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2000 d37f 	iret
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a620 1100 	aclr	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> a640 1100 	aclr	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> a660 1100 	aclr	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> a680 1100 	aclr	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> a6a0 1100 	aclr	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> a6c0 1100 	aclr	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> a6e0 1100 	aclr	0x7,0\(zero\)
[0-9a-f]+ <[^>]+> a6e2 1100 	aclr	0x7,0\(v0\)
[0-9a-f]+ <[^>]+> a6ff 1100 	aclr	0x7,0\(ra\)
[0-9a-f]+ <[^>]+> 003f 07ff 	addiu	at,ra,2047
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 9800 	addiu	at,ra,-2048
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 0800 	addiu	at,ra,2048
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 97ff 	addiu	at,ra,-2049
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a6e1 91ff 	aclr	0x7,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 91ff 	aclr	0x7,-1\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1101 	aclr	0x7,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1101 	aclr	0x7,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	0x7,0\(at\)
[0-9a-f]+ <[^>]+> a6e4 91ff 	aclr	0x7,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5600 1234 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1178 	aclr	0x7,120\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	foo
[0-9a-f]+ <[^>]+> a621 1100 	aclr	0x1,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	foo
[0-9a-f]+ <[^>]+> a421 1100 	aset	0x1,0\(at\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a420 1100 	aset	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> a440 1100 	aset	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> a460 1100 	aset	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> a480 1100 	aset	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> a4a0 1100 	aset	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> a4c0 1100 	aset	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> a4e0 1100 	aset	0x7,0\(zero\)
[0-9a-f]+ <[^>]+> a4e2 1100 	aset	0x7,0\(v0\)
[0-9a-f]+ <[^>]+> a4ff 1100 	aset	0x7,0\(ra\)
[0-9a-f]+ <[^>]+> 003f 07ff 	addiu	at,ra,2047
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 9800 	addiu	at,ra,-2048
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 0800 	addiu	at,ra,2048
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 97ff 	addiu	at,ra,-2049
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a4e1 91ff 	aset	0x7,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 91ff 	aset	0x7,-1\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1101 	aset	0x7,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1101 	aset	0x7,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	0x7,0\(at\)
[0-9a-f]+ <[^>]+> a4e4 91ff 	aset	0x7,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5600 1234 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1178 	aset	0x7,120\(at\)
	\.\.\.
