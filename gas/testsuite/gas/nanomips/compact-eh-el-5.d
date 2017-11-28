#objdump: -sr
#name: Compact EH EL #5 with personality routine, FDE data and LSDA
#source: compact-eh-5.s
#as: -EL --linkrelax -minsn32

.*:     file format.*
#...
RELOCATION RECORDS FOR \[.data.DW.ref.__gnu_compact_pr2\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_32     __gnu_compact_pr2


RELOCATION RECORDS FOR \[.gnu_extab\]:
OFFSET   TYPE              VALUE 
00000001 R_NANOMIPS_PC32   DW.ref.__gnu_compact_pr2


RELOCATION RECORDS FOR \[.eh_frame_entry\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   L0\+0x00000001
00000004 R_NANOMIPS_PC32   L0
#...
Contents of section .data.DW.ref.__gnu_compact_pr2:
 0000 00000000                             .*
Contents of section .gnu_extab:
 0000 00000000 0004405c 020a0104 7f050404  .*
 0010 0005047f                             .*
Contents of section .eh_frame_entry:
 0000 01000000 00000000                    .*
Contents of section .gnu.attributes:
 0000 410f0000 00676e75 00010700 00000401  .*
