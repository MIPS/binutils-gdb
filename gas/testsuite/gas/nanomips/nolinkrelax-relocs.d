#name: No-relax relocations
#PROG: readelf
#readelf: -Wr -A
#source: linkrelax.s
#as: -mno-minimize-relocs

#...
Relocation section '.rela?.text' at offset 0x[0-9a-f]+ contains 4 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name( \+ Addend|)
00000008  [0-9a-f]+ R_NANOMIPS_PC25_S1     00000030   test2 \+ 0
00000010  [0-9a-f]+ R_NANOMIPS_PC10_S1     00000030   test2 \+ 0
00000018  [0-9a-f]+ R_NANOMIPS_PC25_S1     00000030   test2 \+ 0
00000020  [0-9a-f]+ R_NANOMIPS_PC10_S1     00000030   test2 \+ 0

#...
ASEs:
#...
FLAGS 2: 00000000
