#objdump: -dr --prefix-addresses
#as: -mabi=p64
#name: MIPS III load $zero
#source: ld-zero-3.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> addu	at,at,v0
[0-9a-f]+ <[^>]+> lwu	zero,1656\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> addu	at,v0,at
[0-9a-f]+ <[^>]+> lw	zero,1656\(at\)
[0-9a-f]+ <[^>]+> lw	at,1660\(at\)
[0-9a-f]+ <[^>]+> li	at,0x12345600
[0-9a-f]+ <[^>]+> addu	at,at,v0
[0-9a-f]+ <[^>]+> lld	zero,-64\(at\)
	\.\.\.
