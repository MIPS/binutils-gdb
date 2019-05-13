#PROG: readelf
#readelf: -S
#name: Jump-table relaxation with section alignment adjustment

# Check section alignment after jumptable relaxation.

There are [0-9]+ section headers, starting at offset 0x.*

Section Headers:
#...
 +\[ *[0-9]+\] \.rodata +PROGBITS +00000000 [0-9a-f]+ 000010 00   A  0   0  4
#pass