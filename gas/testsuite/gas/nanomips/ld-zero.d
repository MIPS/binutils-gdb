#objdump: -dr --prefix-addresses
#name: nanoMIPS load $zero
#source: ld-zero.s


.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <foo> lui	at,%hi\(0x12345000\)
0+0004 <foo\+0x4> addu	at,at,t4
0+0008 <foo\+0x8> lb	zero,1656\(at\)
0+000c <foo\+0xc> lui	at,%hi\(0x12345000\)
0+0010 <foo\+0x10> addu	at,at,t4
0+0014 <foo\+0x14> lbu	zero,1656\(at\)
0+0018 <foo\+0x18> lui	at,%hi\(0x12345000\)
0+001c <foo\+0x1c> addu	at,at,t4
0+0020 <foo\+0x20> lh	zero,1656\(at\)
0+0024 <foo\+0x24> lui	at,%hi\(0x12345000\)
0+0028 <foo\+0x28> addu	at,at,t4
0+002c <foo\+0x2c> lhu	zero,1656\(at\)
0+0030 <foo\+0x30> lui	at,%hi\(0x12345000\)
0+0034 <foo\+0x34> addu	at,at,t4
0+0038 <foo\+0x38> lw	zero,1656\(at\)
	\.\.\.
