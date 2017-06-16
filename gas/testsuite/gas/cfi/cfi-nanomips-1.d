#readelf: -wf
#name: CFI on nanoMIPS, 1
#source: cfi-mips-1.s
#as: -march=32r6 -mlegacyregs
Contents of the .eh_frame section:

0+0000 0+0014 0+0000 CIE
  Version:               1
  Augmentation:          "zR"
  Code alignment factor: 1
  Data alignment factor: -4
  Return address column: 31
  Augmentation data:     0b

  DW_CFA_def_cfa_register: r29
  DW_CFA_def_cfa: r29 ofs 0
  DW_CFA_nop
  DW_CFA_nop

0+0018 0+001c 0+001c FDE cie=0+0000 pc=0+0000..0+0018
  DW_CFA_advance_loc: 2 to 0+0002
  DW_CFA_def_cfa_offset: 8
  DW_CFA_advance_loc: 2 to 0+0004
  DW_CFA_offset: r30 at cfa-8
  DW_CFA_advance_loc: 2 to 0+0006
  DW_CFA_def_cfa: r30 ofs 8
  DW_CFA_advance_loc: 14 to 0+0014
  DW_CFA_def_cfa: r29 ofs 0
  DW_CFA_nop
