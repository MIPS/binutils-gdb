#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS MIPS64 cop2 instructions
#source: mips64-cp2.s

# Check MIPS64 cop2 instruction assembly

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2064 6d3f 	dmfc2	t5,\$4
[0-9a-f]+ <[^>]+> 20c7 7d3f 	dmtc2	a2,\$7
