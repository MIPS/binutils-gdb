#objdump: -sr
#name: Compact EH EL #1 with personality ID and FDE data
#source: compact-eh-1.s
#as: -EL --linkrelax

.*:     file format.*
#...
RELOCATION RECORDS FOR \[.eh_frame_entry\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   L0
#...
Contents of section .eh_frame_entry:
 0000 00000000 0104405c                    .*
Contents of section .gnu.attributes:
 0000 410f0000 00676e75 00010700 00000401  .*
