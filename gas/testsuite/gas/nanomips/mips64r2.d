#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPS MIPS64r2 instructions
#source: mips64r2.s

# Check MIPS64r2 instruction assembly

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 8043 f820 	dext	\$2,\$3,0x0,0x1
[0-9a-f]+ <[^>]+> 8043 ffe0 	dext	\$2,\$3,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 f800 	dext	\$2,\$3,0x0,0x21
[0-9a-f]+ <[^>]+> 8043 ffc0 	dext	\$2,\$3,0x0,0x40
[0-9a-f]+ <[^>]+> 8043 f83f 	dext	\$2,\$3,0x1f,0x1
[0-9a-f]+ <[^>]+> 8043 ffff 	dext	\$2,\$3,0x1f,0x20
[0-9a-f]+ <[^>]+> 8043 f81f 	dext	\$2,\$3,0x1f,0x21
[0-9a-f]+ <[^>]+> 8043 f020 	dext	\$2,\$3,0x20,0x1
[0-9a-f]+ <[^>]+> 8043 f7e0 	dext	\$2,\$3,0x20,0x20
[0-9a-f]+ <[^>]+> 8043 f03f 	dext	\$2,\$3,0x3f,0x1
[0-9a-f]+ <[^>]+> 8043 faca 	dext	\$2,\$3,0xa,0x2c
[0-9a-f]+ <[^>]+> 8043 f2ea 	dext	\$2,\$3,0x2a,0xc
[0-9a-f]+ <[^>]+> 8043 e820 	dins	\$2,\$3,0x0,0x1
[0-9a-f]+ <[^>]+> 8043 efe0 	dins	\$2,\$3,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 e800 	dins	\$2,\$3,0x0,0x21
[0-9a-f]+ <[^>]+> 8043 efc0 	dins	\$2,\$3,0x0,0x40
[0-9a-f]+ <[^>]+> 8043 efff 	dins	\$2,\$3,0x1f,0x1
[0-9a-f]+ <[^>]+> 8043 e81f 	dins	\$2,\$3,0x1f,0x2
[0-9a-f]+ <[^>]+> 8043 efdf 	dins	\$2,\$3,0x1f,0x21
[0-9a-f]+ <[^>]+> 8043 e020 	dins	\$2,\$3,0x20,0x1
[0-9a-f]+ <[^>]+> 8043 e7e0 	dins	\$2,\$3,0x20,0x20
[0-9a-f]+ <[^>]+> 8043 e7ff 	dins	\$2,\$3,0x3f,0x1
[0-9a-f]+ <[^>]+> 8043 ed4a 	dins	\$2,\$3,0xa,0x2c
[0-9a-f]+ <[^>]+> 8043 e56a 	dins	\$2,\$3,0x2a,0xc
[0-9a-f]+ <[^>]+> 832a c1fc 	drotr32	\$25,\$10,0x1c
[0-9a-f]+ <[^>]+> 832a c1c4 	drotr	\$25,\$10,0x4
[0-9a-f]+ <[^>]+> 832a c1dc 	drotr	\$25,\$10,0x1c
[0-9a-f]+ <[^>]+> c080 c9d0 	dnegu	\$25,\$4
[0-9a-f]+ <[^>]+> c32a c8d0 	drotrv	\$25,\$10,\$25
[0-9a-f]+ <[^>]+> 832a c1e4 	drotr32	\$25,\$10,0x4
[0-9a-f]+ <[^>]+> c08a c8d0 	drotrv	\$25,\$10,\$4
[0-9a-f]+ <[^>]+> c0e7 7b3c 	dsbh	\$7,\$7
[0-9a-f]+ <[^>]+> c10a 7b3c 	dsbh	\$8,\$10
[0-9a-f]+ <[^>]+> c0e7 fb3c 	dshd	\$7,\$7
[0-9a-f]+ <[^>]+> c10a fb3c 	dshd	\$8,\$10
	\.\.\.
