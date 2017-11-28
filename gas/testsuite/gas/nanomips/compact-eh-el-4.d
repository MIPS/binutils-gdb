#objdump: -sr
#name: Compact EH EL #4 with personality id, FDE data and LSDA
#source: compact-eh-4.s
#as: -EL --linkrelax -minsn32

.*:     file format.*
#...
RELOCATION RECORDS FOR \[.eh_frame_entry\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   L0\+0x00000001
00000004 R_NANOMIPS_PC32   L0
#...
Contents of section .gnu_extab:
 0000 0204405c 020a0104 7f050404 0005047f  .*
Contents of section .eh_frame_entry:
 0000 01000000 00000000                    .*
Contents of section .gnu.attributes:
 0000 410f0000 00676e75 00010700 00000401  .*
