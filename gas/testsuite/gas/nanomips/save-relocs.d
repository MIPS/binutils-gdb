#name: SAVE/RESTORE relocations on nanoMIPS
#PROG: readelf
#readelf: -Wr
#as: --linkrelax -KPIC
#source: save.s

#...
Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 6 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000034  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000038  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
0000003c  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
0000006c  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000070  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000074  00000b47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
#pass