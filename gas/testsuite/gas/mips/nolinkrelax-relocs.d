#name: No-relax relocations
#PROG: readelf
#readelf: -Wr -A
#source: linkrelax.s

#...
Relocation section '.rela?.text' at offset 0x[0-9a-f]+ contains 4 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name
00000008  [0-9a-f]+ R_MICROMIPS_PC16_S1    00000030   test2
00000010  [0-9a-f]+ R_MICROMIPS_PC10_S1    00000030   test2
00000018  [0-9a-f]+ R_MICROMIPS_PC16_S1    00000030   test2
00000020  [0-9a-f]+ R_MICROMIPS_PC10_S1    00000030   test2

#...
ASEs:
#...
FLAGS 2: 00000000
