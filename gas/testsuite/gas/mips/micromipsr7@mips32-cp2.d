#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 MIPS32 cop2 instructions
#source: mips32-cp2.s
#as: -32 --defsym r6=1

# Check MIPS32 cop2 instruction assembly (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 2022 cd3f 	cfc2	at,\$2
0+0004 <text_label\+0x4> 2043 dd3f 	ctc2	v0,\$3
0+0008 <text_label\+0x8> 2064 4d3f 	mfc2	v1,\$4
0+000c <text_label\+0xc> 20c7 5d3f 	mtc2	a2,\$7
