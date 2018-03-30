#objdump: -r -j .text
#name MIPS .ehword
#source ehword.s

.*: +file format .*nanomips.*

RELOCATION RECORDS FOR \[\.text\]:
OFFSET   TYPE              VALUE 
00000000 R_NANOMIPS_PC32   _ZTI5myExc
