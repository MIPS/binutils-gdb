#name: Symbolic expression evaluation
#PROG: readelf
#readelf: -Wr

Relocation section '\.rel\.text' at offset 0x[0-9a-f]+ contains 7 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name
00000000  0000053d R_MIPS_PC26_S2 +[0-9a-f]+   foo
00000004  0000053d R_MIPS_PC26_S2 +[0-9a-f]+   foo
00000008  00000505 R_MIPS_HI16    +[0-9a-f]+   foo
0000000c  00000202 R_MIPS_32              [0-9a-f]+   \.text
00000010  00000201 R_MIPS_16              [0-9a-f]+   \.text
00000014  00000202 R_MIPS_32              [0-9a-f]+   \.text
00000018  00000201 R_MIPS_16              [0-9a-f]+   \.text
