#name: Relaxation code dump little-endian
#objdump: -sj.text
#source: linkrelax.s
#as: -EL

dump.o:     file format .*mips.*

Contents of section \.text:
 0000 48300400 00000000 0094feff 000c000c  .*
 0010 ffcf000c 000c326d 0094feff 000c000c  .*
 0020 ffcf000c 00000000 000c000c 00000000  .*
 0030 226d0a0a 0a0a0a0a 000c0000 00000000  .*
 0040 0000cdcd cdcdcdcd 00000000 cdabcdab  .*
 0050 00000000 3412cdab 326d0b0b 0b0b0b0b  .*
 0060 000c000c babababa babababa babababa  .*
 0070 00000000 badcbadc badcbadc badcbadc  .*
 0080 00000000 badc2143 badc2143 badc2143  .*
 0090 000c000c 00c00080 00c00080 00c00080  .*
