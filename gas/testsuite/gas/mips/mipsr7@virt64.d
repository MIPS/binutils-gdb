#objdump: -dr --prefix-addresses  --show-raw-insn -Mvirt,cp0-names=mips64r2
#name: virt64 instructions
#as: -p64 -mvirt
#source: virt64.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 207d 01b0 	dmfgc0	v1,c0_taghi
[0-9a-f]+ <[^>]+> 2174 29b0 	dmfgc0	t3,\$20,5
[0-9a-f]+ <[^>]+> 22e2 01f0 	dmtgc0	s7,c0_entrylo0
[0-9a-f]+ <[^>]+> 20ee 11f0 	dmtgc0	a3,\$14,2
	\.\.\.
