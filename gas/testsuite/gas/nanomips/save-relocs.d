#name: SAVE/RESTORE relocations on nanoMIPS
#PROG: readelf
#readelf: -Wr
#as: --linkrelax -KPIC
#source: nanomips-save.s

#...
Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 9 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000034  00000647 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000038  00000747 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
0000003c  00000847 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000050  00000947 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000054  00000a47 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000058  00000b47 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
0000006c  00000c47 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000070  00000d47 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0
00000074  00000e47 R_NANOMIPS_SAVERESTORE 00000004   none \+ 0

Relocation section '\.rela\.pdr' at offset 0x[0-9a-f]+ contains 1 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000000  00001301 R_NANOMIPS_32          00000000   test \+ 0
#pass
