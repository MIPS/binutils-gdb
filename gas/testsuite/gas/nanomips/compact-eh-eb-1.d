#objdump: -sr
#name: Compact EH EB #1 with personality ID and FDE data
#source: compact-eh-1.s
#as: -EB --linkrelax

.*:     file format.*
#...
RELOCATION RECORDS FOR \[.eh_frame_entry\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   L0
#...
Contents of section .eh_frame_entry:
 0000 00000000 0104405c                    .*
Contents of section .gnu.attributes:
 0000 41000000 0f676e75 00010000 00070401  .*
