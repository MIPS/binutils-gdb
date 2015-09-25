#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS32r3 TLB instructions
#as: -32
#source: mips32r3-tlb.s

# Check MIPS32r3 TLB instructions assembly and disassembly (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 0000 437c 	tlbinv
[0-9a-f]+ <[^>]*> 0000 537c 	tlbinvf
	\.\.\.
