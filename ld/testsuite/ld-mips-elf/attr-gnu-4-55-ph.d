#source: attr-gnu-4-5.s
#source: attr-gnu-4-5.s
#ld: 
#warning: warning: cannot find entry symbol __start; defaulting to .*
#readelf: -l
#target: mips*-*-*

Elf file type is EXEC \(Executable file\)
Entry point 0x4000b0
There are 3 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  REGINFO        0x000094 0x00400094 0x00400094 0x00018 0x00018 R   0x4
  LOAD           0x000000 0x00400000 0x00400000 0x000ac 0x000ac R   0x10000
  FPMODE         0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4
      \[O32 FPXX ABI\]

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo 
   01     .reginfo 
   02     
