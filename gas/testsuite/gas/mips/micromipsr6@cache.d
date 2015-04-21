#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS CACHE instruction
#as: -32 --defsym micromips=1
#source: cache.s

# Check MIPS CACHE instruction assembly (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 20a2 60ff 	cache	0x5,255\(v0\)
[0-9a-f]+ <[^>]*> 20a3 6100 	cache	0x5,-256\(v1\)
	\.\.\.
