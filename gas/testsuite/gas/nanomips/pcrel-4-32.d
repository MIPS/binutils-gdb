#objdump: -sr
#name: Valid cross-section PC-relative references (P32)
#as: -EB
#source: pcrel-4.s

.*:     file format .*

RELOCATION RECORDS FOR \[\.data\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   foo
00000004 R_NANOMIPS_PC32   foo\+0x00000004
00000008 R_NANOMIPS_PC32   foo\+0x00000008
0000000c R_NANOMIPS_PC32   foo-0x00000010

#...
Contents of section \.data:
 0000 00000000 00000004 00000008 fffffff0  ................
#pass
