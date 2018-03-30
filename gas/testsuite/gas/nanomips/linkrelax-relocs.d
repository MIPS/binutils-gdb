#name: Relaxation relocations on nanoMIPS
#PROG: readelf
#readelf: -Wr -Ws
#as: --defsym relaxmode=1 -mno-minimize-relocs
#source: linkrelax.s

#...
Relocation section '\.rela\.text' at offset 0x[0-9a-f]+ contains 40 entries:
 Offset     Info    Type                Sym. Value  Symbol's Name \+ Addend
00000004  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_1 \+ 0
00000008  [0-9a-f]+ R_NANOMIPS_PC25_S1     00000030   test2 \+ 0
00000008  [0-9a-f]+ R_NANOMIPS_INSN32                 0
0000000c  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_2 \+ 0
00000010  [0-9a-f]+ R_NANOMIPS_PC10_S1     00000030   test2 \+ 0
00000010  [0-9a-f]+ R_NANOMIPS_INSN16                 0
00000012  [0-9a-f]+ R_NANOMIPS_ALIGN       00000001   __reloc_align_\^B_3 \+ 0
00000014  [0-9a-f]+ R_NANOMIPS_NORELAX                0
00000018  [0-9a-f]+ R_NANOMIPS_PC25_S1     00000030   test2 \+ 0
00000020  [0-9a-f]+ R_NANOMIPS_PC10_S1     00000030   test2 \+ 0
0000002a  [0-9a-f]+ R_NANOMIPS_RELAX                  0
0000002c  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_4 \+ 0
00000032  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_5 \+ 0
00000032  [0-9a-f]+ R_NANOMIPS_FILL        0000000a   __reloc_fill_\^B_a \+ 0
0000003a  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_6 \+ 0
0000003a  [0-9a-f]+ R_NANOMIPS_FILL        000000ab   __reloc_fill_\^B_ab \+ 0
0000003a  [0-9a-f]+ R_NANOMIPS_MAX         00000005   __reloc_max_\^B_5 \+ 0
00000042  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_7 \+ 0
00000042  [0-9a-f]+ R_NANOMIPS_FILL        000000cd   __reloc_fill_\^B_cd \+ 0
00000042  [0-9a-f]+ R_NANOMIPS_MAX         00000006   __reloc_max_\^B_6 \+ 0
0000004c  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_8 \+ 0
0000004c  [0-9a-f]+ R_NANOMIPS_FILL        0000abcd   __reloc_fill_\^B_abcd \+ 0
0000004c  [0-9a-f]+ R_NANOMIPS_MAX         00000006   __reloc_max_\^B_6 \+ 0
00000054  [0-9a-f]+ R_NANOMIPS_ALIGN       00000003   __reloc_align_\^B_9 \+ 0
00000054  [0-9a-f]+ R_NANOMIPS_FILL        abcd1234   __reloc_fill_\^B_abcd1234 \+ 0
00000054  [0-9a-f]+ R_NANOMIPS_MAX         00000006   __reloc_max_\^B_6 \+ 0
0000005c  [0-9a-f]+ R_NANOMIPS_ALIGN       00000004   __reloc_align_\^B_10 \+ 0
0000005c  [0-9a-f]+ R_NANOMIPS_FILL        0000000b   __reloc_fill_\^B_b \+ 0
00000062  [0-9a-f]+ R_NANOMIPS_ALIGN       00000004   __reloc_align_\^B_11 \+ 0
00000062  [0-9a-f]+ R_NANOMIPS_FILL        000000ba   __reloc_fill_\^B_ba \+ 0
00000062  [0-9a-f]+ R_NANOMIPS_MAX         00000005   __reloc_max_\^B_5 \+ 0
00000064  [0-9a-f]+ R_NANOMIPS_ALIGN       00000004   __reloc_align_\^B_12 \+ 0
00000064  [0-9a-f]+ R_NANOMIPS_FILL        000000ba   __reloc_fill_\^B_ba \+ 0
00000064  [0-9a-f]+ R_NANOMIPS_MAX         0000000c   __reloc_max_\^B_c \+ 0
00000074  [0-9a-f]+ R_NANOMIPS_ALIGN       00000004   __reloc_align_\^B_13 \+ 0
00000074  [0-9a-f]+ R_NANOMIPS_FILL        0000dcba   __reloc_fill_\^B_dcba \+ 0
00000074  [0-9a-f]+ R_NANOMIPS_MAX         00000010   __reloc_max_\^B_10 \+ 0
00000084  [0-9a-f]+ R_NANOMIPS_ALIGN       00000004   __reloc_align_\^B_14 \+ 0
00000084  [0-9a-f]+ R_NANOMIPS_FILL        4321dcba   __reloc_fill_\^B_4321dcba \+ 0
00000084  [0-9a-f]+ R_NANOMIPS_MAX         00000010   __reloc_max_\^B_10 \+ 0
#...
Symbol table '.symtab' contains [0-9]+ entries:
#...
 +[0-9]+: 00000003     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_1
.*
 +[0-9]+: 00000003     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_2
 +[0-9]+: 00000001     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_3
 +[0-9]+: 00000003     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_4
 +[0-9]+: 00000003     6 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_5
 +[0-9]+: 0000000a     1 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_a
 +[0-9]+: 00000003     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_6
 +[0-9]+: 000000ab     1 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_ab
 +[0-9]+: 00000005     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_max_\^B_5
 +[0-9]+: 00000003     6 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_7
 +[0-9]+: 000000cd     1 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_cd
 +[0-9]+: 00000006     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_max_\^B_6
 +[0-9]+: 00000003     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_8
 +[0-9]+: 0000abcd     2 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_abcd
 +[0-9]+: 00000003     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_9
 +[0-9]+: abcd1234     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_abcd1234
 +[0-9]+: 00000004     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_10
 +[0-9]+: 0000000b     1 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_b
 +[0-9]+: 00000004     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_11
 +[0-9]+: 000000ba     1 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_ba
 +[0-9]+: 00000004    12 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_12
 +[0-9]+: 0000000c     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_max_\^B_c
 +[0-9]+: 00000004    12 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_13
 +[0-9]+: 0000dcba     2 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_dcba
 +[0-9]+: 00000010     0 NOTYPE  LOCAL  DEFAULT  ABS __reloc_max_\^B_10
 +[0-9]+: 00000004    12 NOTYPE  LOCAL  DEFAULT  ABS __reloc_align_\^B_14
 +[0-9]+: 4321dcba     4 NOTYPE  LOCAL  DEFAULT  ABS __reloc_fill_\^B_4321dcba
#pass
