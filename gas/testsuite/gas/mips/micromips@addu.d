#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS addu
#source: addu.s
#as: -32

# Test the addu macro (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 3084 0000 	addiu	a0,a0,0
[0-9a-f]+ <[^>]*> 3084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]*> 5020 8000 	li	at,0x8000
[0-9a-f]+ <[^>]*> 0024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]*> 3084 8000 	addiu	a0,a0,-32768
[0-9a-f]+ <[^>]*> 41a1 0001 	lui	at,0x1
[0-9a-f]+ <[^>]*> 0024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]*> 41a1 0001 	lui	at,0x1
[0-9a-f]+ <[^>]*> 5021 a5a5 	ori	at,at,0xa5a5
[0-9a-f]+ <[^>]*> 0024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0c00      	nop
