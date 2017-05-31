#name: Symbol difference expression on r7
#PROG: readelf
#readelf: -Wr
#source: expr-diff.s

Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 20 entries:
 Offset     Info    Type                Sym\. Value  Symbol's Name \+ Addend
00000000  000010c5 R_MICROMIPS_GPREL19_S2 0000002c   \.L5 \+ 0
00000006  00000ab6 R_MICROMIPS_HI20       00000028   \.L2 \+ 0
0000000a  00000ab7 R_MICROMIPS_LO12       00000028   \.L2 \+ 0
00000012  000016c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000001a  000016c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000001e  000016c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
00000024  000016c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000002c  00000802 R_MIPS_32              00000012   \.L3 \+ 0
0000002c  00000a18 R_MIPS_SUB             00000028   \.L2 \+ 0
0000002c  00000002 R_MIPS_32                         0
00000030  00000902 R_MIPS_32              0000001e   \.L4 \+ 0
00000030  00000a18 R_MIPS_SUB             00000028   \.L2 \+ 0
00000030  00000002 R_MIPS_32                         0
00000034  000011c5 R_MICROMIPS_GPREL19_S2 00000060   \.L9 \+ 0
0000003a  00000fb6 R_MICROMIPS_HI20       0000005e   \.L6 \+ 0
0000003e  00000fb7 R_MICROMIPS_LO12       0000005e   \.L6 \+ 0
00000052  00000ddd R_MICROMIPS_ALIGN      00000002   __reloc_align_\^B_1 \+ 0
00000060  00000e02 R_MIPS_32              00000054   \.L8 \+ 0
00000060  00000c18 R_MIPS_SUB             00000046   \.L7 \+ 0
00000060  00000002 R_MIPS_32                         0
#pass
