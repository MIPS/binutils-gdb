#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPSR7 mips5 instructions
#source: micromipsr6@mips5-fp.s
#stderr: mipsr6@mips5-fp.l

# Check MIPS V instruction assembly on R7

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a212 213b 	cvt\.s\.pl	\$f16,\$f18
0+0004 <text_label\+0x4> a254 293b 	cvt\.s\.pu	\$f18,\$f20
	\.\.\.
