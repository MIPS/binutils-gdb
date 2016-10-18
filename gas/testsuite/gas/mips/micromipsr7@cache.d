#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 CACHE instruction
#as: -32 --defsym micromips=1 --defsym r6=1
#source: cache.s

# Check MIPS CACHE instruction assembly (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a4a2 19ff 	cache	0x5,255\(v0\)
0+0004 <text_label\+0x4> a4a3 9900 	cache	0x5,-256\(v1\)
	\.\.\.
