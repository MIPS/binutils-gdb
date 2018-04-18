#objdump: -dr --prefix-addresses --show-raw-insn -Mvirt,cp0-names=32r6
#name: MVH instructions
#as: -mvirt

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2041 0038 	mfhc0	t4,random
[0-9a-f]+ <[^>]+> 2050 0038 	mfhc0	t4,config
[0-9a-f]+ <[^>]+> 2040 1038 	mfhc0	t4,mvpconf0
[0-9a-f]+ <[^>]+> 2040 3838 	mfhc0	t4,\$0,7
[0-9a-f]+ <[^>]+> 2041 0078 	mthc0	t4,random
[0-9a-f]+ <[^>]+> 2050 0078 	mthc0	t4,config
[0-9a-f]+ <[^>]+> 2040 1078 	mthc0	t4,mvpconf0
[0-9a-f]+ <[^>]+> 2040 3878 	mthc0	t4,\$0,7
#pass
