#objdump: -dr --prefix-addresses  --show-raw-insn -Mvirt,cp0-names=nanomips32r6
#name: virt instructions on nanoMIPS
#as: -mvirt -meva

.*: +file format .*nanomips.*

[0-9A-F]+isassembly of section \.text:
[0-9a-f]+ <[^>]+> 207d 00b0 	mfgc0	t5,itaghi
[0-9a-f]+ <[^>]+> 2174 28b0 	mfgc0	a7,\$20,5
[0-9a-f]+ <[^>]+> 22e2 00f0 	mtgc0	s7,entrylo0
[0-9a-f]+ <[^>]+> 20ee 10f0 	mtgc0	a3,nestedepc
[0-9a-f]+ <[^>]+> 100c      	hypcall
[0-9a-f]+ <[^>]+> 100d      	hypcall	0x1
[0-9a-f]+ <[^>]+> 000c 0256 	hypcall	0x256
[0-9a-f]+ <[^>]+> 2000 057f 	tlbginv
[0-9a-f]+ <[^>]+> 2000 157f 	tlbginvf
[0-9a-f]+ <[^>]+> 2000 017f 	tlbgp
[0-9a-f]+ <[^>]+> 2000 117f 	tlbgr
[0-9a-f]+ <[^>]+> 2000 217f 	tlbgwi
[0-9a-f]+ <[^>]+> 2000 317f 	tlbgwr
#pass
