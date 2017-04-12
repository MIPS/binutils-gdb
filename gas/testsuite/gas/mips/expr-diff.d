#name: Symbol difference expression
#PROG: readelf
#readelf: -Wr

Relocation section '\.rel\.text' at offset 0x[0-9a-f]+ contains 10 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   \.text
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_HI16    +[0-9a-f]+   \.L2
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_LO16    +[0-9a-f]+   \.L2
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   c
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   c
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   c
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   c
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_GPREL16 +[0-9a-f]+   \.text
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_HI16    +[0-9a-f]+   \.L6
[0-9a-f]+  [0-9a-f]+ R_(MICRO|)MIPS_LO16    +[0-9a-f]+   \.L6

#pass
