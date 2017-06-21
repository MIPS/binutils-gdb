#objdump: -dr --prefix-addresses
#name: nanoMIPS mips4 fp
#source: mips4-fp.s

# Test mips4 fp instructions on nanoMIPS

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> recip\.d	\$f4,\$f6
0+0004 <text_label\+0x4> recip\.s	\$f4,\$f6
0+0008 <text_label\+0x8> rsqrt\.d	\$f4,\$f6
0+000c <text_label\+0xc> rsqrt\.s	\$f4,\$f6
	\.\.\.
