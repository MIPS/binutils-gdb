#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPS32r2 fp instructions on nanoMIPS
#source: mips32r2-fp32.s
#as: -m32

# Check MIPS32 Release 2 (mips32r2) FP instruction assembly (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a220 303b 	mfhc1	\$17,\$f0
0+0004 <text_label\+0x4> a220 383b 	mthc1	\$17,\$f0
#pass
