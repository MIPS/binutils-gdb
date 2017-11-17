#objdump: -sr
#name: Compact EH EL #7 with personality id and fallback FDE
#source: compact-eh-7.s
#as: -EL --linkrelax

.*:     file format.*
#...
RELOCATION RECORDS FOR \[.eh_frame\]:
OFFSET   TYPE              VALUE 
0000001c R_NANOMIPS_32     L0


RELOCATION RECORDS FOR \[.eh_frame_entry\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   L0\+0x00000001
00000004 R_NANOMIPS_PC32   L0\+0x00000001
#...
Contents of section .eh_frame:
 0000 10000000 00000000 017a5200 017c1f01  .*
 0010 1b0d1d00 14000000 18000000 00000000  .*
 0020 08000000 00441308 440e0000           .*
Contents of section .eh_frame_entry:
 0000 01000000 15000000                    .*
Contents of section .gnu.attributes:
 0000 410f0000 00676e75 00010700 00000401  .*
