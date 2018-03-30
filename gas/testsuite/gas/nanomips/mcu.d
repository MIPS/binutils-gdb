#objdump: -dr --show-raw-insn --prefix-addresses
#name: MCU for nanoMIPS

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2000 d37f 	iret
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0,0\(zero\)
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0,0\(zero\)
[0-9a-f]+ <[^>]+> a600 1100 	aclr	0,0\(zero\)
[0-9a-f]+ <[^>]+> a620 1100 	aclr	1,0\(zero\)
[0-9a-f]+ <[^>]+> a640 1100 	aclr	2,0\(zero\)
[0-9a-f]+ <[^>]+> a660 1100 	aclr	3,0\(zero\)
[0-9a-f]+ <[^>]+> a680 1100 	aclr	4,0\(zero\)
[0-9a-f]+ <[^>]+> a6a0 1100 	aclr	5,0\(zero\)
[0-9a-f]+ <[^>]+> a6c0 1100 	aclr	6,0\(zero\)
[0-9a-f]+ <[^>]+> a6e0 1100 	aclr	7,0\(zero\)
[0-9a-f]+ <[^>]+> a6e2 1100 	aclr	7,0\(t4\)
[0-9a-f]+ <[^>]+> a6ff 1100 	aclr	7,0\(ra\)
[0-9a-f]+ <[^>]+> 003f 07ff 	addiu	at,ra,2047
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> 803f 8800 	addiu	at,ra,-2048
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 0800 	addiu	at,ra,2048
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> 803f 8801 	addiu	at,ra,-2049
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 7fff 	addiu	at,ra,32767
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1101 	aclr	7,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1101 	aclr	7,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> a6e4 91ff 	aclr	7,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a6e1 1100 	aclr	7,0\(at\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1100 	aset	0,0\(zero\)
[0-9a-f]+ <[^>]+> a420 1100 	aset	1,0\(zero\)
[0-9a-f]+ <[^>]+> a440 1100 	aset	2,0\(zero\)
[0-9a-f]+ <[^>]+> a460 1100 	aset	3,0\(zero\)
[0-9a-f]+ <[^>]+> a480 1100 	aset	4,0\(zero\)
[0-9a-f]+ <[^>]+> a4a0 1100 	aset	5,0\(zero\)
[0-9a-f]+ <[^>]+> a4c0 1100 	aset	6,0\(zero\)
[0-9a-f]+ <[^>]+> a4e0 1100 	aset	7,0\(zero\)
[0-9a-f]+ <[^>]+> a4e2 1100 	aset	7,0\(t4\)
[0-9a-f]+ <[^>]+> a4ff 1100 	aset	7,0\(ra\)
[0-9a-f]+ <[^>]+> 003f 07ff 	addiu	at,ra,2047
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> 803f 8800 	addiu	at,ra,-2048
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 0800 	addiu	at,ra,2048
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> 803f 8801 	addiu	at,ra,-2049
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> 003f 7fff 	addiu	at,ra,32767
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 23e1 0950 	addu	at,at,ra
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1101 	aset	7,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1101 	aset	7,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
[0-9a-f]+ <[^>]+> a4e4 91ff 	aset	7,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a4e1 1100 	aset	7,0\(at\)
#pass
