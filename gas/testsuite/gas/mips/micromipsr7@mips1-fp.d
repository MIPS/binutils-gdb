#objdump: -M reg-names=numeric -dr --show-raw-insn --prefix-addresses
#as: -32
#name: MIPS1 FP instructions
#source mips1-fp.s

.*:     file format .*

Disassembly of section \.text:
0+0000 <foo> a082 0030 	add.s	\$f0,\$f2,\$f4
0+0004 <foo\+0x4> a040 203b 	mfc1	v0,\$f0
