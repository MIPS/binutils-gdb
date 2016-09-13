#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 save/restore instructions
#as: -mmicromips -mips32r7
#source: ur7-save.s

# Check MIPSR7 save/restore instructions

.*: +file format .*mips.*

Disassembly of section .text:
^0+0000 <test> 1c08      	save	32,ra
^0+0002 <test\+0x2> 83c0 3020 	save	32,s8
^0+0006 <test\+0x6> 8200 3020 	save	32,s0
^0+000a <test\+0xa> 8266 3020 	save	32,s0-s3
^0+000e <test\+0xe> 83d2 3081 	save	128,s8,s0-s7,gp
^0+0012 <test\+0x12> 8064 3081 	save	128,v1,s0,gp
^0+0016 <test\+0x16> 8381 3020 	restore	32,gp
^0+001a <test\+0x1a> 83c1 3020 	restore	32,s8
^0+001e <test\+0x1e> 8201 3020 	restore	32,s0
^0+0022 <test\+0x22> 8267 3020 	restore	32,s0-s3
^0+0026 <test\+0x26> 83d3 3081 	restore	128,s8,s0-s7,gp
^0+002a <test\+0x2a> 8065 3081 	restore	128,v1,s0,gp
^0+002e <test\+0x2e> 8381 3024 	restore.jrc	32,gp
^0+0032 <test\+0x32> 83c1 3024 	restore.jrc	32,s8
^0+0036 <test\+0x36> 8201 3024 	restore.jrc	32,s0
^0+003a <test\+0x3a> 8267 3024 	restore.jrc	32,s0-s3
^0+003e <test\+0x3e> 83d3 3085 	restore.jrc	128,s8,s0-s7,gp
^0+0042 <test\+0x42> 8065 3085 	restore.jrc	128,v1,s0,gp
^0+0046 <test\+0x46> 1c08      	save	32,ra
^0+0048 <test\+0x48> 1c48      	save	32,ra,s0
^0+004a <test\+0x4a> 1d08      	save	32,ra,s0-s3
^0+004c <test\+0x4c> 1e50      	save	64,ra,s0-s7,s8
^0+004e <test\+0x4e> 1c50      	save	64,ra,s0
^0+0050 <test\+0x50> 83e1 3020 	restore	32,ra
^0+0054 <test\+0x54> 83e3 3020 	restore	32,ra,s0
^0+0058 <test\+0x58> 83e9 3020 	restore	32,ra,s0-s3
^0+005c <test\+0x5c> 83f3 3042 	restore	64,ra,s0-s7,s8
^0+0060 <test\+0x60> 83e3 3040 	restore	64,ra,s0
^0+0064 <test\+0x64> 1c28      	restore.jrc	32,ra
^0+0066 <test\+0x66> 1c68      	restore.jrc	32,ra,s0
^0+0068 <test\+0x68> 1d28      	restore.jrc	32,ra,s0-s3
^0+006a <test\+0x6a> 1e70      	restore.jrc	64,ra,s0-s7,s8
^0+006c <test\+0x6c> 1c70      	restore.jrc	64,ra,s0
^0+006e <test\+0x6e> 1fd0      	save	64
^0+0070 <test\+0x70> 1f50      	save	64,ra,s0-gp
^0+0072 <test\+0x72> 807e 3042 	save	64,v1,s0-sp,s8
^0+0076 <test\+0x76> 807e 3042 	save	64,v1,s0-sp,s8
^0+007a <test\+0x7a> 807e 3041 	save	64,v1,s0-sp,gp
^0+007e <test\+0x7e> 807a 3041 	save	64,v1,s0-k1,gp
^0+0082 <test\+0x82> 83ff 3042 	restore	64,ra,s0-sp,s8
^0+0086 <test\+0x86> 83fb 3041 	restore	64,ra,s0-k1,gp
^0+008a <test\+0x8a> 807f 3042 	restore	64,v1,s0-sp,s8
^0+008e <test\+0x8e> 807f 3042 	restore	64,v1,s0-sp,s8
^0+0092 <test\+0x92> 807f 3041 	restore	64,v1,s0-sp,gp
^0+0096 <test\+0x96> 807b 3041 	restore	64,v1,s0-k1,gp
^0+009a <test\+0x9a> 1ff0      	restore	64
^0+009c <test\+0x9c> 1f70      	restore.jrc	64,ra,s0-gp
^0+009e <test\+0x9e> 807f 3046 	restore.jrc	64,v1,s0-sp,s8
^0+00a2 <test\+0xa2> 807f 3046 	restore.jrc	64,v1,s0-sp,s8
^0+00a6 <test\+0xa6> 807f 3045 	restore.jrc	64,v1,s0-sp,gp
^0+00aa <test\+0xaa> 807b 3045 	restore.jrc	64,v1,s0-k1,gp
^0+00ae <test\+0xae> 1ffe      	restore	120
^0+00b0 <test\+0xb0> 8000 7040 	savef	64,\$f0
^0+00b4 <test\+0xb4> 801e 7040 	savef	64,\$f0-\$f15
^0+00b8 <test\+0xb8> 8001 7040 	restoref	64,\$f0
^0+00bc <test\+0xbc> 801f 7040 	restoref	64,\$f0-\$f15
