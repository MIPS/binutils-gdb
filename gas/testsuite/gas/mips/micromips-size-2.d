#objdump: -dr --prefix-addresses --show-raw-insn
#name: microMIPS instruction size 2
#as: -32 -march=mips64r6 -mmicromips
#source: micromips-size-2.s
#stderr: micromips-size-1.l

# Test microMIPS instruction size overrides (#1).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0000 0000 	nop
[0-9a-f]+ <[^>]*> 0544      	addu	v0,v0,a0
[0-9a-f]+ <[^>]*> 0544      	addu	v0,v0,a0
[0-9a-f]+ <[^>]*> 0082 1150 	addu	v0,v0,a0
[0-9a-f]+ <[^>]*> 01cc 6150 	addu	t4,t4,t6
[0-9a-f]+ <[^>]*> 01cc 6150 	addu	t4,t4,t6
[0-9a-f]+ <[^>]*> 4c81      	addiu	sp,sp,256
[0-9a-f]+ <[^>]*> 4c81      	addiu	sp,sp,256
[0-9a-f]+ <[^>]*> 448b      	jalrc	a0
[0-9a-f]+ <[^>]*> 448b      	jalrc	a0
[0-9a-f]+ <[^>]*> 03e4 0f3c 	jalrc	a0
[0-9a-f]+ <[^>]*> 470b      	jalrc	t8
[0-9a-f]+ <[^>]*> 470b      	jalrc	t8
[0-9a-f]+ <[^>]*> 03f8 0f3c 	jalrc	t8
[0-9a-f]+ <[^>]*> 44ab      	jalrc	a1
[0-9a-f]+ <[^>]*> 44ab      	jalrc	a1
[0-9a-f]+ <[^>]*> 03e5 0f3c 	jalrc	a1
[0-9a-f]+ <[^>]*> 472b      	jalrc	t9
[0-9a-f]+ <[^>]*> 472b      	jalrc	t9
[0-9a-f]+ <[^>]*> 03f9 0f3c 	jalrc	t9
[0-9a-f]+ <[^>]*> 03da 0f3c 	jalrc	s8,k0
[0-9a-f]+ <[^>]*> 03da 0f3c 	jalrc	s8,k0
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	00000044 <[^>]*>
			44: R_MICROMIPS_PC26_S1	bar
[0-9a-f]+ <[^>]*> cfff      	bc	00000048 <[^>]*>
			48: R_MICROMIPS_PC10_S1	bar
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	0000004a <[^>]*>
			4a: R_MICROMIPS_PC26_S1	bar
[0-9a-f]+ <[^>]*> a0ff fffe 	beqzc	a3,0000004e <[^>]*>
			4e: R_MICROMIPS_PC21_S1	bar
[0-9a-f]+ <[^>]*> 8fff      	beqzc	a3,00000052 <[^>]*>
			52: R_MICROMIPS_PC7_S1	bar
[0-9a-f]+ <[^>]*> a0ff fffe 	beqzc	a3,00000054 <[^>]*>
			54: R_MICROMIPS_PC21_S1	bar
[0-9a-f]+ <[^>]*> a37f fffe 	beqzc	k1,00000058 <[^>]*>
			58: R_MICROMIPS_PC21_S1	bar
[0-9a-f]+ <[^>]*> a37f fffe 	beqzc	k1,0000005c <[^>]*>
			5c: R_MICROMIPS_PC21_S1	bar
[0-9a-f]+ <[^>]*> 253a      	sll	v0,v1,5
[0-9a-f]+ <[^>]*> 253a      	sll	v0,v1,5
[0-9a-f]+ <[^>]*> 0043 2800 	sll	v0,v1,0x5
[0-9a-f]+ <[^>]*> 0043 6800 	sll	v0,v1,0xd
[0-9a-f]+ <[^>]*> 0043 6800 	sll	v0,v1,0xd
[0-9a-f]+ <[^>]*> 014b 2800 	sll	t2,t3,0x5
[0-9a-f]+ <[^>]*> 014b 2800 	sll	t2,t3,0x5
	\.\.\.
