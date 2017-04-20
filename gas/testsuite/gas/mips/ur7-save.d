#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 save/restore instructions
#as: -mmicromips -mips32r7
#source: ur7-save.s

# Check MIPSR7 save/restore instructions

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <test> 1c10      	save	16
0+0002 <test\+0x2> 1c80      	save	128
0+0004 <test\+0x4> 1cf0      	save	240
0+0006 <test\+0x6> 1e21      	save	32,ra
0+0008 <test\+0x8> 1c22      	save	32,s8,ra
0+000a <test\+0xa> 1e22      	save	32,s0,ra
0+000c <test\+0xc> 1e25      	save	32,s0-s3,ra
0+000e <test\+0xe> 1ece      	save	192,s0-k1,gp,ra
0+0010 <test\+0x10> 1ccf      	save	192,s0-k1,gp,s8,ra
0+0012 <test\+0x12> 1c8f      	save	128,s0-k1,gp,s8,ra
0+0014 <test\+0x14> 1d10      	restore.jrc	16
0+0016 <test\+0x16> 1d80      	restore.jrc	128
0+0018 <test\+0x18> 1df0      	restore.jrc	240
0+001a <test\+0x1a> 1f21      	restore.jrc	32,ra
0+001c <test\+0x1c> 1d22      	restore.jrc	32,s8,ra
0+001e <test\+0x1e> 1f22      	restore.jrc	32,s0,ra
0+0020 <test\+0x20> 1f25      	restore.jrc	32,s0-s3,ra
0+0022 <test\+0x22> 1fce      	restore.jrc	192,s0-k1,gp,ra
0+0024 <test\+0x24> 1dcf      	restore.jrc	192,s0-k1,gp,s8,ra
0+0026 <test\+0x26> 1d8f      	restore.jrc	128,s0-k1,gp,s8,ra
0+0028 <test\+0x28> 83e1 3028 	save	40,ra
0+002c <test\+0x2c> 83c2 3100 	save	256,s8,ra
0+0030 <test\+0x30> 83e2 3400 	save	1024,s0,ra
0+0034 <test\+0x34> 8205 3044 	save	64,s0-s3,gp
0+0038 <test\+0x38> 808e 3044 	save	64,a0-s0,gp
0+003c <test\+0x3c> 81e4 3084 	save	128,t7-s1,gp
0+0040 <test\+0x40> 810c 3080 	save	128,t0-s3
0+0044 <test\+0x44> 83e1 3032 	restore	48,ra
0+0048 <test\+0x48> 83c2 3102 	restore	256,s8,ra
0+004c <test\+0x4c> 83e2 3402 	restore	1024,s0,ra
0+0050 <test\+0x50> 8205 3046 	restore	64,s0-s3,gp
0+0054 <test\+0x54> 8043 3046 	restore	64,v0-v1,gp
0+0058 <test\+0x58> 83c5 3086 	restore	128,s0-s1,gp,s8,ra
0+005c <test\+0x5c> 83cf 307a 	restore	120,s0-k1,gp,s8,ra
0+0060 <test\+0x60> 83e1 303b 	restore.jrc	56,ra
0+0064 <test\+0x64> 83c2 3103 	restore.jrc	256,s8,ra
0+0068 <test\+0x68> 83e2 3403 	restore.jrc	1024,s0,ra
0+006c <test\+0x6c> 8205 3047 	restore.jrc	64,s0-s3,gp
0+0070 <test\+0x70> 8043 3047 	restore.jrc	64,v0-v1,gp
0+0074 <test\+0x74> 83c5 3087 	restore.jrc	128,s0-s1,gp,s8,ra
0+0078 <test\+0x78> 83cf 307b 	restore.jrc	120,s0-k1,gp,s8,ra
0+007c <test\+0x7c> 1d4a      	restore.jrc	64,s0-s7,s8,ra
0+007e <test\+0x7e> 8010 3040 	savef	64,\$f0
0+0082 <test\+0x82> 801f 3040 	savef	64,\$f0-\$f15
0+0086 <test\+0x86> 8010 3041 	restoref	64,\$f0
0+008a <test\+0x8a> 801f 3041 	restoref	64,\$f0-\$f15
0+008e <test\+0x8e> 9008      	nop
