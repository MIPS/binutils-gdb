#source: attr-gnu-4-6.s
#source: attr-gnu-4-6.s
#ld: 
#warning: warning: cannot find entry symbol __start; defaulting to .*
#objdump: -p
#target: mips*-*-*

[^:]*:     file format elf32-tradbigmips

Program Header:
0x70000000 off    0x00000094 vaddr 0x00400094 paddr 0x00400094 align 2\*\*2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00400000 paddr 0x00400000 align 2\*\*16
         filesz 0x000000ac memsz 0x000000ac flags r--
0x70000003 off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2\*\*2
         filesz 0x00000000 memsz 0x00000000 flags --- 20000000
private flags = 70001000: \[abi=O32\] \[mips32r2\] \[not 32bitmode\] \[FP64\]

