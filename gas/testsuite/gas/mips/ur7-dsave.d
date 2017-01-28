#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 save/restore instructions
#as: -mmicromips -mips64r7
#source: ur7-dsave.s

# Check MIPSR7 save/restore instructions

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 1c09      	dsave	32
[0-9a-f]+ <[^>]+> 83c0 b024 	dsave	32,s8
[0-9a-f]+ <[^>]+> 8200 b024 	dsave	32,s0
[0-9a-f]+ <[^>]+> 8266 b024 	dsave	32,s0-s3
[0-9a-f]+ <[^>]+> 83d2 b085 	dsave	128,s8,s0-s7,gp
[0-9a-f]+ <[^>]+> 8064 b085 	dsave	128,v1,s0,gp
[0-9a-f]+ <[^>]+> 8381 b024 	drestore	32,gp
[0-9a-f]+ <[^>]+> 83c1 b024 	drestore	32,s8
[0-9a-f]+ <[^>]+> 8201 b024 	drestore	32,s0
[0-9a-f]+ <[^>]+> 8267 b024 	drestore	32,s0-s3
[0-9a-f]+ <[^>]+> 83d3 b085 	drestore	128,s8,s0-s7,gp
[0-9a-f]+ <[^>]+> 8065 b085 	drestore	128,v1,s0,gp
[0-9a-f]+ <[^>]+> 1c09      	dsave	32
[0-9a-f]+ <[^>]+> 1c49      	dsave	32,ra,s0
[0-9a-f]+ <[^>]+> 1d09      	dsave	32,ra,s0-s3
[0-9a-f]+ <[^>]+> 1e51      	dsave	64,ra,s0-s7,s8
[0-9a-f]+ <[^>]+> 1c51      	dsave	64,ra,s0
[0-9a-f]+ <[^>]+> 1c0b      	drestore	32
[0-9a-f]+ <[^>]+> 1c4b      	drestore	32,ra,s0
[0-9a-f]+ <[^>]+> 1d0b      	drestore	32,ra,s0-s3
[0-9a-f]+ <[^>]+> 1e53      	drestore	64,ra,s0-s7,s8
[0-9a-f]+ <[^>]+> 1c53      	drestore	64,ra,s0
[0-9a-f]+ <[^>]+> 1fd1      	dsave	64,s0-ra
[0-9a-f]+ <[^>]+> 1f51      	dsave	64,ra,s0-gp
[0-9a-f]+ <[^>]+> 807e b046 	dsave	64,v1,s0-sp,s8
[0-9a-f]+ <[^>]+> 807e b046 	dsave	64,v1,s0-sp,s8
[0-9a-f]+ <[^>]+> 807e b045 	dsave	64,v1,s0-sp,gp
[0-9a-f]+ <[^>]+> 807a b045 	dsave	64,v1,s0-k1,gp
[0-9a-f]+ <[^>]+> 1fd3      	drestore	64,s0-ra
[0-9a-f]+ <[^>]+> 1f53      	drestore	64,ra,s0-gp
[0-9a-f]+ <[^>]+> 807f b046 	drestore	64,v1,s0-sp,s8
[0-9a-f]+ <[^>]+> 807f b046 	drestore	64,v1,s0-sp,s8
[0-9a-f]+ <[^>]+> 807f b045 	drestore	64,v1,s0-sp,gp
[0-9a-f]+ <[^>]+> 807b b045 	drestore	64,v1,s0-k1,gp
[0-9a-f]+ <[^>]+> 1c23      	drestore	128
[0-9a-f]+ <[^>]+> 8000 7040 	savef	64,\$f0
[0-9a-f]+ <[^>]+> 801e 7040 	savef	64,\$f0-\$f15
[0-9a-f]+ <[^>]+> 8001 7040 	restoref	64,\$f0
[0-9a-f]+ <[^>]+> 801f 7040 	restoref	64,\$f0-\$f15
