
Dynamic section .*
#...
 0x00000003 \(PLTGOT\)                     0x1021000
#...
 0x70000013 \(MIPS_GOTSYM\)                0x9
 0x00000014 \(PLTREL\)                     REL
 0x00000017 \(JMPREL\)                     0x1004000
 0x00000002 \(PLTRELSZ\)                   48 \(bytes\)
 0x70000032 \(MIPS_PLTGOT\)                0x1020000
#...
Relocation section '\.rel\.plt' .*
 Offset     Info    Type            Sym\.Value  Sym\. Name
01020008  [^ ]+ R_MIPS_JUMP_SLOT  01010021   f_lo_ic
0102000c  [^ ]+ R_MIPS_JUMP_SLOT  01010031   f_lo_dc
01020010  [^ ]+ R_MIPS_JUMP_SLOT  00000000   f_dc
01020014  [^ ]+ R_MIPS_JUMP_SLOT  00000000   f_ic_dc
01020018  [^ ]+ R_MIPS_JUMP_SLOT  01010061   f_lo_ic_dc
0102001c  [^ ]+ R_MIPS_JUMP_SLOT  01010071   f_lo

Symbol table '\.dynsym' .*
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
# _lo symbols have their address taken, so their PLT symbols need to have
# a nonzero value.  They must also have STO_MIPS_PLT in order to distinguish
# them from old-style lazy-binding stubs.  Non-_lo symbols are only called,
# so their PLT symbols should have a zero value and no STO_MIPS_PLT annotation.
#
# All PLTs should be microMIPS.
#...
    .*: 01010021     0 FUNC    GLOBAL DEFAULT \[MIPS PLT\]   UND f_lo_ic
    .*: 01010031     0 FUNC    GLOBAL DEFAULT \[MIPS PLT\]   UND f_lo_dc
    .*: 00000000     0 FUNC    GLOBAL DEFAULT  UND f_dc
    .*: 00000000     0 FUNC    GLOBAL DEFAULT  UND f_ic_dc
#...
    .*: 01010061     0 FUNC    GLOBAL DEFAULT \[MIPS PLT\]   UND f_lo_ic_dc
    .*: 01010071     0 FUNC    GLOBAL DEFAULT \[MIPS PLT\]   UND f_lo
# The start of the GOT-mapped area.  This should only contain functions that
# are accessed purely via the traditional psABI scheme.  The symbol value
# is the address of the lazy-binding stub.
     9: 01011001     0 FUNC    GLOBAL DEFAULT  UND f_ic

Symbol table '\.symtab' .*
#...
Primary GOT:
 Canonical gp value: 01028ff0

 Reserved entries:
   Address     Access  Initial Purpose
  01021000 -32752\(gp\) 00000000 Lazy resolver
  01021004 -32748\(gp\) 80000000 Module pointer \(GNU extension\)

# See the disassembly output for the meaning of each entry.
 Local entries:
   Address     Access  Initial
  01021008 -32744\(gp\) 01010051
  0102100c -32740\(gp\) 01010021
  01021010 -32736\(gp\) 01010061

 Global entries:
   Address     Access  Initial Sym\.Val\. Type    Ndx Name
  01021014 -32732\(gp\) 01011001 01011001 FUNC    UND f_ic


PLT GOT:

 Reserved entries:
   Address  Initial Purpose
  01020000 00000000 PLT lazy resolver
  01020004 00000000 Module pointer

 Entries:
   Address  Initial Sym\.Val\. Type    Ndx Name
  01020008 01010001 01010021 FUNC    UND f_lo_ic
  0102000c 01010001 01010031 FUNC    UND f_lo_dc
  01020010 01010001 00000000 FUNC    UND f_dc
  01020014 01010001 00000000 FUNC    UND f_ic_dc
  01020018 01010001 01010061 FUNC    UND f_lo_ic_dc
  0102001c 01010001 01010071 FUNC    UND f_lo


