#name: Symbol difference expression on nanoMIPS
#PROG: readelf
#readelf: -Wr
#source: expr-diff.s

Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 17 entries:
 Offset     Info    Type                Sym\. Value  Symbol's Name \+ Addend
00000000  [0-9a-f]+16 R_NANOMIPS_GPREL18     00000028   \.L5 \+ 0
00000006  [0-9a-f]+1c R_NANOMIPS_HI20        00000026   \.L2 \+ 0
0000000a  [0-9a-f]+1d R_NANOMIPS_LO12        00000026   \.L2 \+ 0
00000012  [0-9a-f]+14 R_NANOMIPS_GPREL19_S2  00000000   c \+ 0
00000018  [0-9a-f]+14 R_NANOMIPS_GPREL19_S2  00000000   c \+ 0
0000001c  [0-9a-f]+14 R_NANOMIPS_GPREL19_S2  00000000   c \+ 0
00000022  [0-9a-f]+14 R_NANOMIPS_GPREL19_S2  00000000   c \+ 0
00000028  [0-9a-f]+03 R_NANOMIPS_NEG         00000012   \.L3 \+ 0
00000028  [0-9a-f]+01 R_NANOMIPS_32          00000026   \.L2 \+ 0
0000002c  [0-9a-f]+03 R_NANOMIPS_NEG         0000001c   \.L4 \+ 0
0000002c  [0-9a-f]+01 R_NANOMIPS_32          00000026   \.L2 \+ 0
00000030  [0-9a-f]+16 R_NANOMIPS_GPREL18     00000050   \.L9 \+ 0
00000036  [0-9a-f]+1c R_NANOMIPS_HI20        0000004e   \.L6 \+ 0
0000003a  [0-9a-f]+1d R_NANOMIPS_LO12        0000004e   \.L6 \+ 0
00000048  [0-9a-f]+40 R_NANOMIPS_ALIGN       00000002   __reloc_align_\^B_1 \+ 0
00000050  [0-9a-f]+03 R_NANOMIPS_NEG         00000048   \.L8 \+ 0
00000050  [0-9a-f]+01 R_NANOMIPS_32          00000042   \.L7 \+ 0
#pass
