#source: attr-gnu-4-5.s -mips32r2 -32 -EB
#source: attr-gnu-4-1.s -mips32r2 -32 -EB
#ld: -melf32btsmip 
#warning: warning: cannot find entry symbol __start; defaulting to .*
#readelf: -l
#target: mips*-*-*

Elf file type is EXEC \(Executable file\)
Entry point 0x400090
There are 2 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  REGINFO        0x000074 0x00400074 0x00400074 0x00018 0x00018 R   0x4
  LOAD           0x000000 0x00400000 0x00400000 0x0008c 0x0008c R   0x10000

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo 
   01     .reginfo 
