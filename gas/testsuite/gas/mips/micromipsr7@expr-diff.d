#name: Symbol difference expression on r7
#PROG: readelf
#readelf: -Wr
#source: expr-diff.s

Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 19 entries:
 Offset     Info    Type                Sym\. Value  Symbol's Name \+ Addend
00000000  [0-9a-f]+c4 R_MICROMIPS_GPREL18    0000002c   \.L5 \+ 0
00000006  [0-9a-f]+b6 R_MICROMIPS_HI20       00000028   \.L2 \+ 0
0000000a  [0-9a-f]+b7 R_MICROMIPS_LO12       00000028   \.L2 \+ 0
00000012  [0-9a-f]+c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000001a  [0-9a-f]+c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000001e  [0-9a-f]+c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
00000024  [0-9a-f]+c5 R_MICROMIPS_GPREL19_S2 00000000   c \+ 0
0000002c  [0-9a-f]+02 R_MIPS_32              00000012   \.L3 \+ 0
0000002c  [0-9a-f]+18 R_MIPS_SUB             00000028   \.L2 \+ 0
0000002c  [0-9a-f]+02 R_MIPS_32                         0
00000030  [0-9a-f]+02 R_MIPS_32              0000001e   \.L4 \+ 0
00000030  [0-9a-f]+18 R_MIPS_SUB             00000028   \.L2 \+ 0
00000030  [0-9a-f]+02 R_MIPS_32                         0
00000034  [0-9a-f]+c4 R_MICROMIPS_GPREL18    00000060   \.L9 \+ 0
0000003a  [0-9a-f]+b6 R_MICROMIPS_HI20       0000005e   \.L6 \+ 0
0000003e  [0-9a-f]+b7 R_MICROMIPS_LO12       0000005e   \.L6 \+ 0
00000060  [0-9a-f]+02 R_MIPS_32              00000054   \.L8 \+ 0
00000060  [0-9a-f]+18 R_MIPS_SUB             00000046   \.L7 \+ 0
00000060  [0-9a-f]+02 R_MIPS_32                         0
#pass
