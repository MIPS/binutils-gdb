#objdump: -dr --prefix-addresses --show-raw-insn -Mxpa,virt,cp0-names=mips32r2
#name: XPA instructions
#source: xpa.s
#as: -mxpa -mvirt

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2041 0038 	mfhc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2050 0038 	mfhc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2040 1038 	mfhc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 3838 	mfhc0	v0,\$0,7
[0-9a-f]+ <[^>]+> 2041 0078 	mthc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2050 0078 	mthc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2040 1078 	mthc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 3878 	mthc0	v0,\$0,7
[0-9a-f]+ <[^>]+> 2041 00b8 	mfhgc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2050 00b8 	mfhgc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2040 10b8 	mfhgc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 38b8 	mfhgc0	v0,\$0,7
[0-9a-f]+ <[^>]+> 2041 00f8 	mthgc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2050 00f8 	mthgc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2040 10f8 	mthgc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 38f8 	mthgc0	v0,\$0,7
	\.\.\.
