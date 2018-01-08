#name: SAVE/RESTORE relocations on nanoMIPS
#PROG: readelf
#readelf: -Wr
#as: --linkrelax -mpic
#source: save.s

#...
Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 8 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000034  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000038  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
0000003c  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000040  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000074  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000078  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
0000007c  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
00000080  [0-9a-f]+47 R_NANOMIPS_SAVERESTORE 00000000   none \+ 0
#pass