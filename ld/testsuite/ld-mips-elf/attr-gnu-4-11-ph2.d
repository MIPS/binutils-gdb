#source: attr-gnu-4-1.s -mips32r2 -32 -EB
#source: attr-gnu-4-1.s -mips32r2 -32 -EB
#ld: -melf32btsmip
#warning: warning: cannot find entry symbol __start; defaulting to .*
#objdump: -p
#target: mips*-*-*

[^:]*:     file format elf32-tradbigmips

Program Header:
0x70000000 off    0x00000074 vaddr 0x00400074 paddr 0x00400074 align 2\*\*2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00400000 paddr 0x00400000 align 2\*\*16
         filesz 0x0000008c memsz 0x0000008c flags r--
private flags = 70001000: \[abi=O32\] \[mips32r2\] \[not 32bitmode\]

