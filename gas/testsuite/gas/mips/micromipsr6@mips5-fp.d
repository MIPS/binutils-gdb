#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPS mips5 instructions
#stderr: mipsr6@mips5-fp.l

# Check MIPS V instruction assembly

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 5612 213b 	cvt\.s\.pl	\$f16,\$f18
[0-9a-f]+ <[^>]*> 5654 293b 	cvt\.s\.pu	\$f18,\$f20
	\.\.\.
