#name: Lable difference with reloc minimization
#PROG: readelf
#readelf: -Wr
#as: -mminimize-relocs

#...
Relocation section '\.rela\.data' at offset 0x[0-9a-f]+ contains 2 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000000  00000603 R_NANOMIPS_NEG         00000000   \$L15 \+ 0
00000000  00000701 R_NANOMIPS_32          0000000a   \$L16 \+ 0
#pass