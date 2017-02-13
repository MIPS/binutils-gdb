#name: Symbolic expression evaluation
#PROG: readelf
#readelf: -Wr
#source: expr-sym.s

Relocation section '\.rel\.text' at offset 0x[0-9a-f]+ contains 7 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name
00000000  000006af R_MICROMIPS_PC26_S1 +[0-9a-f]+   foo
00000006  00000686 R_MICROMIPS_HI16    +[0-9a-f]+   foo
0000000c  00000302 R_MIPS_32              [0-9a-f]+   \.text
00000010  00000301 R_MIPS_16              [0-9a-f]+   \.text
00000014  00000302 R_MIPS_32              [0-9a-f]+   \.text
00000018  00000301 R_MIPS_16              [0-9a-f]+   \.text
00000004  0000068c R_MICROMIPS_PC10_S1 +[0-9a-f]+   foo
