#objdump: -dr --prefix-addresses
#as: -m64
#name: MIPS III load $zero
#source: ld-zero-3.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> addu	at,at,t4
[0-9a-f]+ <[^>]+> lwu	zero,1656\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> addu	at,t4,at
[0-9a-f]+ <[^>]+> lw	zero,1656\(at\)
[0-9a-f]+ <[^>]+> lw	at,1660\(at\)
[0-9a-f]+ <[^>]+> li	at,0x12345600
[0-9a-f]+ <[^>]+> addu	at,at,t4
[0-9a-f]+ <[^>]+> lld	zero,-64\(at\)
	\.\.\.
