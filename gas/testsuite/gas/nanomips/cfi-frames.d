#objdump: -Wf
#name: nanoMIPS decoding DWARF frame
#as: -mno-minimize-relocs

dump.o:     .*nanomips.*

Contents of the .eh_frame section:

00000000 00000010 00000000 CIE
  Version:               1
  Augmentation:          "zR"
  Code alignment factor: 1
  Data alignment factor: -4
  Return address column: 31
  Augmentation data:     1b

  DW_CFA_def_cfa_register: r29
  DW_CFA_nop

00000014 00000058 00000018 FDE cie=00000000 pc=00000000..00000036
  DW_CFA_advance_loc4: 4 to 00000004
  DW_CFA_def_cfa_offset: 16
  DW_CFA_offset: r30 at cfa-4
  DW_CFA_offset: r31 at cfa-8
  DW_CFA_advance_loc4: 2 to 00000006
  DW_CFA_def_cfa: r30 ofs 4096
  DW_CFA_advance_loc4: 22 to 0000001c
  DW_CFA_def_cfa: r29 ofs 16
  DW_CFA_advance_loc4: 4 to 00000020
  DW_CFA_def_cfa_offset: 32
  DW_CFA_offset: r30 at cfa-4
  DW_CFA_offset: r31 at cfa-8
  DW_CFA_advance_loc4: 6 to 00000026
  DW_CFA_def_cfa: r30 ofs 4096
  DW_CFA_advance_loc4: 6 to 0000002c
  DW_CFA_def_cfa: r29 ofs 16
  DW_CFA_advance_loc4: 4 to 00000030
  DW_CFA_def_cfa: r28 ofs 4096
  DW_CFA_advance_loc4: 6 to 00000036
  DW_CFA_def_cfa: r27 ofs 32
  DW_CFA_nop
  DW_CFA_nop

