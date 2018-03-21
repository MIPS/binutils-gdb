#name: Relaxation code dump for nanoMIPS big-endian
#objdump: -sj.text
#as: --defsym relaxmode=1 -EB -mno-minimize-relocs
#source: linkrelax.s

#...
Contents of section .text:
 0000 00480004 8000c000 28000000 8000c000  .*
 0010 18009008 00430004 28000000 8000c000  .*
 0020 18009008 8000c000 90089008 8000c000  .*
 0030 904c0a0a 0a0a0a0a 90088000 c0008000  .*
 0040 c000cdcd cdcdcdcd 8000c000 abcdabcd  .*
 0050 8000c000 abcd1234 00430004 0b0b0b0b  .*
 0060 90089008 babababa babababa babababa  .*
 0070 8000c000 dcbadcba dcbadcba dcbadcba  .*
 0080 8000c000 4321dcba 4321dcba 4321dcba  .*
 0090 90089008 8000c000 8000c000 8000c000  .*
