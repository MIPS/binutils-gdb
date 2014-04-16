#objdump: -dr --prefix-addresses
#name: MIPS addu
#as: -32

# Test the add macro.

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <[^>]*> addiu	a0,a0,0
0+0004 <[^>]*> addiu	a0,a0,1
0+0008 <[^>]*> li	at,0x8000
0+000c <[^>]*> addu	a0,a0,at
0+0010 <[^>]*> addiu	a0,a0,-32768
0+0014 <[^>]*> lui	at,0x1
0+0018 <[^>]*> addu	a0,a0,at
0+001c <[^>]*> lui	at,0x1
0+0020 <[^>]*> ori	at,at,0xa5a5
0+0024 <[^>]*> addu	a0,a0,at
0+0028 <[^>]*> nop
