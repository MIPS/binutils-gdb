#name: MICROMIPS address mapping to debug line information
#ld: -Ttext 0x400000
#objdump: -dlr
#source: micromips-lineno.s

.*: +file format .*mips.*

Disassembly of section \.text:
00400000 <foo>:
foo\(\):
.*micromips-lineno.c:1
  400000:.*
#...
00400004 <bar>:
bar\(\):
.*micromips-lineno.c:2
  400004:.*
#...
0040000c <baz>:
baz\(\):
.*micromips-lineno.c:3
  40000c:.*
#pass
