#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 MIPS32 instructions
#source: mips32.s
#as: -32 --defsym r6=1

# Check MIPS32 instruction assembly (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 2022 4b3f 	clo	at,v0
0+0004 <text_label\+0x4> 2064 5b3f 	clz	v1,a0
0+0008 <text_label\+0x8> 21ee 6818 	mul	t5,t6,t7
0+000c <text_label\+0xc> a490 1800 	pref	0x4,0\(s0\)
0+0010 <text_label\+0x10> a4a1 1900 	cache	0x5,0\(at\)
0+0014 <text_label\+0x14> 2000 f37f 	eret
0+0018 <text_label\+0x18> 2000 037f 	tlbp
0+001c <text_label\+0x1c> 2000 137f 	tlbr
0+0020 <text_label\+0x20> 2000 237f 	tlbwi
0+0024 <text_label\+0x24> 2000 337f 	tlbwr
0+0028 <text_label\+0x28> 2000 937f 	wait
0+002c <text_label\+0x2c> 2000 c37f 	wait	0x0
0+0030 <text_label\+0x30> 2345 c37f 	wait	0x345
0+0034 <text_label\+0x34> 1010      	break
0+0036 <text_label\+0x36> 1010      	break
0+0038 <text_label\+0x38> 0010 0345 	break	0x345
0+003c <text_label\+0x3c> 1018      	sdbbp	0x0
0+003e <text_label\+0x3e> 1018      	sdbbp	0x0
0+0040 <text_label\+0x40> 0018 0345 	sdbbp	0x345
	...
