.*:     file format .*

Disassembly of section .text:

00001000 <_start-0x10>:
    1000:	e59fc000 	ldr	ip, \[pc, #0\]	; 1008 <_start-0x8>
    1004:	e12fff1c 	bx	ip
    1008:	02001015 	.word	0x02001015
    100c:	00000000 	.word	0x00000000

00001010 <_start>:
    1010:	ebfffffa 	bl	1000 <_start-0x10>
Disassembly of section .foo:

02001014 <bar>:
 2001014:	4770      	bx	lr
