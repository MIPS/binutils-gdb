#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS MIPS64 instructions
#source: mips64.s

# Check MIPS64 instruction assembly

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> c022 4b3c 	dclo	at,v0
[0-9a-f]+ <[^>]+> c064 5b3c 	dclz	v1,a0
