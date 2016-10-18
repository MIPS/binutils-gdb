#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPSR7 MIPS32r2 non-fp instructions
#source: mips32r2.s
#as: -32 --defsym r6=1

# Check MIPS32 Release 2 \\(mips32r2\\) *non-fp* instruction assembly (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 8000 c003 	ehb
0+0004 <text_label\+0x4> 8085 f1c6 	ext	\$4,\$5,0x6,0x8
0+0008 <text_label\+0x8> 8085 e346 	ins	\$4,\$5,0x6,0x8
0+000c <text_label\+0xc> 4be8 1000 	jalrc.hb	\$8
0+0010 <text_label\+0x10> 9008      	nop
0+0012 <text_label\+0x12> 4a89 1000 	jalrc.hb	\$20,\$9
0+0016 <text_label\+0x16> 9008      	nop
0+0018 <text_label\+0x18> 4808 1000 	jrc.hb	\$8
0+001c <text_label\+0x1c> 9008      	nop
0+001e <text_label\+0x1e> 2140 01c0 	rdhwr	\$10,\$0
0+0022 <text_label\+0x22> 2161 01c0 	rdhwr	\$11,\$1
0+0026 <text_label\+0x26> 2182 01c0 	rdhwr	\$12,\$2
0+002a <text_label\+0x2a> 21a3 01c0 	rdhwr	\$13,\$3
0+002e <text_label\+0x2e> 21c4 01c0 	rdhwr	\$14,\$4
0+0032 <text_label\+0x32> 21e5 01c0 	rdhwr	\$15,\$5
0+0036 <text_label\+0x36> 832a c0dc 	rotr	\$25,\$10,0x1c
0+003a <text_label\+0x3a> 832a c0c4 	rotr	\$25,\$10,0x4
0+003e <text_label\+0x3e> 2080 c9d0 	negu	\$25,\$4
0+0042 <text_label\+0x42> 232a c8d0 	rotr	\$25,\$10,\$25
0+0046 <text_label\+0x46> 208a c8d0 	rotr	\$25,\$10,\$4
0+004a <text_label\+0x4a> 208a c8d0 	rotr	\$25,\$10,\$4
0+004e <text_label\+0x4e> 20e7 2b3f 	seb	\$7,\$7
0+0052 <text_label\+0x52> 210a 2b3f 	seb	\$8,\$10
0+0056 <text_label\+0x56> 20e7 3b3f 	seh	\$7,\$7
0+005a <text_label\+0x5a> 210a 3b3f 	seh	\$8,\$10
0+005e <text_label\+0x5e> a7ea 1835 	synci	53\(\$10\)
0+0062 <text_label\+0x62> 20e7 7b3f 	wsbh	\$7,\$7
0+0066 <text_label\+0x66> 210a 7b3f 	wsbh	\$8,\$10
0+006a <text_label\+0x6a> 2000 477f 	di
0+006e <text_label\+0x6e> 2000 477f 	di
0+0072 <text_label\+0x72> 2140 477f 	di	\$10
0+0076 <text_label\+0x76> 2000 577f 	ei
0+007a <text_label\+0x7a> 2000 577f 	ei
0+007e <text_label\+0x7e> 2140 577f 	ei	\$10
0+0082 <text_label\+0x82> 2159 e17f 	rdpgpr	\$10,\$25
0+0086 <text_label\+0x86> 2159 f17f 	wrpgpr	\$10,\$25
0+008a <text_label\+0x8a> 8000 c005 	pause
0+008e <text_label\+0x8e> 9008      	nop
	\.\.\.
