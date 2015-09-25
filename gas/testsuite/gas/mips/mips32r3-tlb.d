#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS32r3 TLB instructions
#as: -32
#source: mips32r3-tlb.s

# Check MIPS32r3 TLB instructions assembly and disassembly

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 42000003 	tlbinv
[0-9a-f]+ <[^>]*> 42000004 	tlbinvf
	\.\.\.
