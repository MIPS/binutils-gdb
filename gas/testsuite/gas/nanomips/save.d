#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS save/restore instructions

# Check nanoMIPS save/restore instructions

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <test> 1c10      	save	16
[0-9a-f]+ <test\+0x[a-f0-9]+> 1c80      	save	128
[0-9a-f]+ <test\+0x[a-f0-9]+> 1cf0      	save	240
[0-9a-f]+ <test\+0x[a-f0-9]+> 1e21      	save	32,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 1c22      	save	32,fp,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 1e22      	save	32,ra,s0
[0-9a-f]+ <test\+0x[a-f0-9]+> 1e25      	save	32,ra,s0-s3
[0-9a-f]+ <test\+0x[a-f0-9]+> 1ece      	save	192,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1ccf      	save	192,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1c8f      	save	128,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d10      	restore.jrc	16
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d80      	restore.jrc	128
[0-9a-f]+ <test\+0x[a-f0-9]+> 1df0      	restore.jrc	240
[0-9a-f]+ <test\+0x[a-f0-9]+> 1f21      	restore.jrc	32,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d22      	restore.jrc	32,fp,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 1f22      	restore.jrc	32,ra,s0
[0-9a-f]+ <test\+0x[a-f0-9]+> 1f25      	restore.jrc	32,ra,s0-s3
[0-9a-f]+ <test\+0x[a-f0-9]+> 1fce      	restore.jrc	192,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1dcf      	restore.jrc	192,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d8f      	restore.jrc	128,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e1 3028 	save	40,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83c2 3100 	save	256,fp,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e2 3400 	save	1024,ra,s0
[0-9a-f]+ <test\+0x[a-f0-9]+> 8002 30a4 	save	160,zero,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 8205 3044 	save	64,s0-s3,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 808e 3044 	save	64,a0-s0,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 81e4 3084 	save	128,t3-s1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 810c 3080 	save	128,a4-s3
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e1 3032 	restore	48,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83c2 3102 	restore	256,fp,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e2 3402 	restore	1024,ra,s0
[0-9a-f]+ <test\+0x[a-f0-9]+> 8002 30a6 	restore	160,zero,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 8205 3046 	restore	64,s0-s3,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 8043 3046 	restore	64,t4-t5,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83c5 3086 	restore	128,fp,ra,s0-s1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83cf 307a 	restore	120,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e1 303b 	restore.jrc	56,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83c2 3103 	restore.jrc	256,fp,ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 83e2 3403 	restore.jrc	1024,ra,s0
[0-9a-f]+ <test\+0x[a-f0-9]+> 8002 30a7 	restore.jrc	160,zero,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 8205 3047 	restore.jrc	64,s0-s3,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 8043 3047 	restore.jrc	64,t4-t5,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83c5 3087 	restore.jrc	128,fp,ra,s0-s1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 83cf 307b 	restore.jrc	120,fp,ra,s0-k1,gp
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d4a      	restore.jrc	64,fp,ra,s0-s7
[0-9a-f]+ <test\+0x[a-f0-9]+> 8010 3040 	savef	64,\$f0
[0-9a-f]+ <test\+0x[a-f0-9]+> 801f 3040 	savef	64,\$f0-\$f15
[0-9a-f]+ <test\+0x[a-f0-9]+> 8015 3040 	savef	64,\$f0-\$f5
[0-9a-f]+ <test\+0x[a-f0-9]+> 8010 3041 	restoref	64,\$f0
[0-9a-f]+ <test\+0x[a-f0-9]+> 801f 3041 	restoref	64,\$f0-\$f15
[0-9a-f]+ <test\+0x[a-f0-9]+> 8015 3041 	restoref	64,\$f0-\$f5
[0-9a-f]+ <test\+0x[a-f0-9]+> 1d60      	restore.jrc	96
[0-9a-f]+ <test\+0x[a-f0-9]+> 8000 3ff3 	restore.jrc	4080
[0-9a-f]+ <test\+0x[a-f0-9]+> 03bd fff0 	addiu	sp,sp,65520
[0-9a-f]+ <test\+0x[a-f0-9]+> dbe0      	jrc	ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 03bd 0800 	addiu	sp,sp,2048
[0-9a-f]+ <test\+0x[a-f0-9]+> dbe0      	jrc	ra
[0-9a-f]+ <test\+0x[a-f0-9]+> 6020 fff0 000f 	li	at,0xffff0
[0-9a-f]+ <test\+0x[a-f0-9]+> 203d e950 	addu	sp,sp,at
[0-9a-f]+ <test\+0x[a-f0-9]+> dbe0      	jrc	ra
