#readelf: -Wr
#name: relocatable debug-line info with linkrelax

# Check debug-line relocations with linkrelax

#...
Relocation section '\.rela\.debug_line' at offset 0x[0-9a-f]+ contains 7 entries:
 Offset     Info    Type                Sym\. Value  Symbol's Name \+ Addend
0000002a  00000901 R_NANOMIPS_32          00000000   \.Loc\.7\.1 \+ 0
00000032  00000903 R_NANOMIPS_NEG         00000000   \.Loc\.7\.1 \+ 0
00000032  00000c07 R_NANOMIPS_UNSIGNED_16 00000006   \.Loc\.8\.1 \+ 0
00000038  00000c03 R_NANOMIPS_NEG         00000006   \.Loc\.8\.1 \+ 0
00000038  00000d07 R_NANOMIPS_UNSIGNED_16 00000012   \.Loc\.9\.1 \+ 0
0000003e  00000d03 R_NANOMIPS_NEG         00000012   \.Loc\.9\.1 \+ 0
0000003e  00000e07 R_NANOMIPS_UNSIGNED_16 00000018   \.Loc\.10\.1 \+ 0
#pass
