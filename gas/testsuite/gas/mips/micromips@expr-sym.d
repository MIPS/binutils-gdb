#name: Symbolic expression evaluation
#PROG: objdump
#objdump: -sj.text
#source: expr-sym.s

.*: +file format .*mips

Contents of section \.text:
.*
 0010 00000010 00000010 00000c05 00000012  .*
 0020 00000402 0000000b 000df400 fffffff4  .*
