#name: MIPS16 address mapping to debug line information
#ld: -Ttext 0x400000
#objdump: -dlr
#source: mips16-lineno.s

.*: +file format .*mips.*

Disassembly of section \.text:
00400000 <foo>:
foo\(\):
.*mips16-lineno.c:1
  400000:.*
#...
00400004 <bar>:
bar\(\):
.*mips16-lineno.c:2
  400004:.*
#...
0040000c <baz>:
baz\(\):
.*mips16-lineno.c:3
  40000c:.*
#pass
