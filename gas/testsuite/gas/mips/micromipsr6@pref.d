#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS PREF instruction
#as: -32 --defsym micromips=1 --defsym tpref=1
#source: cache.s

# Check MIPS CACHE instruction assembly (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 60a2 20ff 	pref	0x5,255\(v0\)
[0-9a-f]+ <[^>]*> 60a3 2100 	pref	0x5,-256\(v1\)
	\.\.\.
