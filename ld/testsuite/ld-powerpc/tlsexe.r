#source: tls.s
#source: tlslib.s
#as: -a64
#ld: -melf64ppc
#readelf: -WSsrl
#target: powerpc64*-*-*

There are 20 section headers.*

Section Headers:
 +\[Nr\] Name +Type +Address +Off +Size +ES Flg Lk Inf Al
 +\[ 0\] +NULL +0+ 0+ 0+ 0+ +0 +0 +0
 +\[ 1\] \.interp +.*
 +\[ 2\] \.hash +.*
 +\[ 3\] \.dynsym +.*
 +\[ 4\] \.dynstr +.*
 +\[ 5\] \.rela\.dyn +.*
 +\[ 6\] \.rela\.plt +.*
 +\[ 7\] \.text +PROGBITS +0+10000388 0+388 0+fc 0+ +AX +0 +0 +4
 +\[ 8\] \.tdata +PROGBITS +0+10010488 0+488 0+38 0+ WAT +0 +0 +8
 +\[ 9\] \.tbss +NOBITS +0+100104c0 0+4c0 0+38 0+ WAT +0 +0 +8
 +\[10\] \.dynamic +DYNAMIC +0+100104c0 0+4c0 0+150 10 +WA +4 +0 +8
 +\[11\] \.data +PROGBITS +0+10010610 0+610 0+ 0+ +WA +0 +0 +1
 +\[12\] \.branch_lt +.*
 +\[13\] \.got +PROGBITS +0+10010610 0+610 0+30 08 +WA +0 +0 +8
 +\[14\] \.sbss +.*
 +\[15\] \.plt +.*
 +\[16\] \.bss +.*
 +\[17\] \.shstrtab +.*
 +\[18\] \.symtab +.*
 +\[19\] \.strtab +.*
#...

Elf file type is EXEC \(Executable file\)
Entry point 0x100003a4
There are 6 program headers.*

Program Headers:
 +Type +Offset +VirtAddr +PhysAddr +FileSiz +MemSiz +Flg Align
 +PHDR +0x0+40 0x0+10000040 0x0+10000040 0x0+150 0x0+150 R E 0x8
 +INTERP +0x0+190 0x0+10000190 0x0+10000190 0x0+11 0x0+11 R +0x1
 +\[Requesting program interpreter: .*\]
 +LOAD +0x0+ 0x0+10000000 0x0+10000000 0x0+484 0x0+484 R E 0x10000
 +LOAD +0x0+488 0x0+10010488 0x0+10010488 0x0+1b8 0x0+1e8 RW +0x10000
 +DYNAMIC +0x0+4c0 0x0+100104c0 0x0+100104c0 0x0+150 0x0+150 RW +0x8
 +TLS +0x0+488 0x0+10010488 0x0+10010488 0x0+38 0x0+70 R +0x8

 Section to Segment mapping:
 +Segment Sections\.\.\.
 +0+ +
 +01 +\.interp 
 +02 +\.interp \.hash \.dynsym \.dynstr \.rela\.dyn \.rela\.plt \.text 
 +03 +\.tdata \.tbss \.dynamic \.got \.plt 
 +04 +\.tbss \.dynamic 
 +05 +\.tdata \.tbss 

Relocation section '\.rela\.dyn' at offset .* contains 3 entries:
 +Offset +Info +Type +Symbol's Value +Symbol's Name \+ Addend
0+10010620 +0+200000049 R_PPC64_TPREL64 +0+ gd \+ 0
0+10010628 +0+500000044 R_PPC64_DTPMOD64 +0+ ld \+ 0
0+10010638 +0+60000004e R_PPC64_DTPREL64 +0+50 ld2 \+ 0

Relocation section '\.rela\.plt' at offset .* contains 1 entries:
 +Offset +Info +Type +Symbol's Value +Symbol's Name \+ Addend
0+10010658 +0+300000015 R_PPC64_JMP_SLOT +0+ __tls_get_addr \+ 0

Symbol table '\.dynsym' contains 10 entries:
 +Num: +Value +Size Type +Bind +Vis +Ndx Name
 +0: 0+ +0 NOTYPE +LOCAL +DEFAULT +UND 
 +1: 0+100104c0 +0 OBJECT +GLOBAL DEFAULT +ABS _DYNAMIC
 +2: 0+ +0 TLS +GLOBAL DEFAULT +UND gd
 +3: 0+ +0 FUNC +GLOBAL DEFAULT +UND __tls_get_addr
 +4: 0+ +0 FUNC +GLOBAL DEFAULT +UND \.__tls_get_addr
 +5: 0+ +0 TLS +GLOBAL DEFAULT +UND ld
 +6: 0+50 +0 TLS +GLOBAL DEFAULT +9 ld2
 +7: 0+10010640 +0 NOTYPE +GLOBAL DEFAULT +ABS __bss_start
 +8: 0+10010640 +0 NOTYPE +GLOBAL DEFAULT +ABS _edata
 +9: 0+10010670 +0 NOTYPE +GLOBAL DEFAULT +ABS _end

Symbol table '\.symtab' contains 43 entries:
 +Num: +Value +Size Type +Bind +Vis +Ndx Name
 +0: 0+ +0 NOTYPE +LOCAL +DEFAULT +UND 
 +1: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +1 
 +2: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +2 
 +3: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +3 
 +4: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +4 
 +5: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +5 
 +6: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +6 
 +7: 0+10000388 +0 SECTION LOCAL +DEFAULT +7 
 +8: 0+10010488 +0 SECTION LOCAL +DEFAULT +8 
 +9: 0+100104c0 +0 SECTION LOCAL +DEFAULT +9 
 +10: 0+100104c0 +0 SECTION LOCAL +DEFAULT +10 
 +11: 0+10010610 +0 SECTION LOCAL +DEFAULT +11 
 +12: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +12 
 +13: 0+10010610 +0 SECTION LOCAL +DEFAULT +13 
 +14: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +14 
 +15: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +15 
 +16: [0-9a-f]+ +0 SECTION LOCAL +DEFAULT +16 
 +17: 0+ +0 SECTION LOCAL +DEFAULT +17 
 +18: 0+ +0 SECTION LOCAL +DEFAULT +18 
 +19: 0+ +0 SECTION LOCAL +DEFAULT +19 
 +20: 0+ +0 TLS +LOCAL +DEFAULT +8 gd4
 +21: 0+8 +0 TLS +LOCAL +DEFAULT +8 ld4
 +22: 0+10 +0 TLS +LOCAL +DEFAULT +8 ld5
 +23: 0+18 +0 TLS +LOCAL +DEFAULT +8 ld6
 +24: 0+20 +0 TLS +LOCAL +DEFAULT +8 ie4
 +25: 0+28 +0 TLS +LOCAL +DEFAULT +8 le4
 +26: 0+30 +0 TLS +LOCAL +DEFAULT +8 le5
 +27: 0+100104c0 +0 OBJECT +GLOBAL DEFAULT +ABS _DYNAMIC
 +28: 0+ +0 TLS +GLOBAL DEFAULT +UND gd
 +29: 0+60 +0 TLS +GLOBAL DEFAULT +9 le0
 +30: 0+ +0 FUNC +GLOBAL DEFAULT +UND __tls_get_addr
 +31: 0+ +0 FUNC +GLOBAL DEFAULT +UND \.__tls_get_addr
 +32: 0+40 +0 TLS +GLOBAL DEFAULT +9 ld0
 +33: 0+68 +0 TLS +GLOBAL DEFAULT +9 le1
 +34: 0+ +0 TLS +GLOBAL DEFAULT +UND ld
 +35: [0-9a-f]+ +0 NOTYPE +GLOBAL DEFAULT +7 _start
 +36: 0+50 +0 TLS +GLOBAL DEFAULT +9 ld2
 +37: 0+48 +0 TLS +GLOBAL DEFAULT +9 ld1
 +38: [0-9a-f]+ +0 NOTYPE +GLOBAL DEFAULT +ABS __bss_start
 +39: [0-9a-f]+ +0 NOTYPE +GLOBAL DEFAULT +ABS _edata
 +40: [0-9a-f]+ +0 NOTYPE +GLOBAL DEFAULT +ABS _end
 +41: 0+38 +0 TLS +GLOBAL DEFAULT +9 gd0
 +42: 0+58 +0 TLS +GLOBAL DEFAULT +9 ie0
