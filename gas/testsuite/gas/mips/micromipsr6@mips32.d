#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS MIPS32 instructions
#source: mips32.s
#as: -32

# Check MIPS32 instruction assembly (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 0022 4b3c 	clo	at,v0
[0-9a-f]+ <[^>]*> 0064 5b3c 	clz	v1,a0
[0-9a-f]+ <[^>]*> 01ee 6818 	mul	t5,t6,t7
[0-9a-f]+ <[^>]*> 6090 2000 	pref	0x4,0\(s0\)
[0-9a-f]+ <[^>]*> 0000 0800 	ssnop
[0-9a-f]+ <[^>]*> 20a1 6000 	cache	0x5,0\(at\)
[0-9a-f]+ <[^>]*> 0000 f37c 	eret
[0-9a-f]+ <[^>]*> 0000 037c 	tlbp
[0-9a-f]+ <[^>]*> 0000 137c 	tlbr
[0-9a-f]+ <[^>]*> 0000 237c 	tlbwi
[0-9a-f]+ <[^>]*> 0000 337c 	tlbwr
[0-9a-f]+ <[^>]*> 0000 937c 	wait
[0-9a-f]+ <[^>]*> 0000 937c 	wait
[0-9a-f]+ <[^>]*> 0345 937c 	wait	0x345
[0-9a-f]+ <[^>]*> 441b      	break
[0-9a-f]+ <[^>]*> 441b      	break
[0-9a-f]+ <[^>]*> 0345 0007 	break	0x345
[0-9a-f]+ <[^>]*> 0048 d147 	break	0x48,0x345
[0-9a-f]+ <[^>]*> 443b      	sdbbp
[0-9a-f]+ <[^>]*> 443b      	sdbbp
[0-9a-f]+ <[^>]*> 0345 db7c 	sdbbp	0x345
	\.\.\.
