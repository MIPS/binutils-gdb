#objdump: --dwarf=frames
# This test is only valid on ELF based ports.
#notarget: *-*-*coff *-*-pe *-*-wince *-*-*aout* *-*-netbsd

## ARMv8.3 adds support for a new security feature named Pointer Authentication.
## The main idea behind this is to use the unused bits in the pointer values.
## Each pointer is patched with a PAC before writing to memory, and is verified
## before using it.
## When the pointers are mangled, the stack trace generator needs to know so it
## can mask off the PAC from the pointer value to recover the return address,
## and conversely, skip doing so if the pointers are not mangled.
##
## .cfi_negate_ra_state CFI directive is usually used to convey this information.
## .cfi_negate_ra_state and .cfi_window_save are both in the processor-specific
## numbering space, but use the same code value in the dwarf tables.
## In GCC 14 and older, the Sparc DWARF extension .cfi_window_save is emitted
## instead of .cfi_negate_ra_state, but it mapped to the same value. GCC 15 fixed
## this naming issue and there is no change to the object file created when the
## source is assembled. Nevertheless the support for the SPARC directive is
## preserved in binutils for backward compatibility with existing GCC releases,
## hence this test.

.+:     file .+

Contents of the \.eh_frame section:

0+ 0+10 0+ CIE
  Version:               1
  Augmentation:          "zR"
  Code alignment factor: 4
  Data alignment factor: -8
  Return address column: 30
  Augmentation data:     1b
  DW_CFA_def_cfa: r31 \(sp\) ofs 0

0+14 0+18 0+18 FDE cie=0+ pc=0+\.\.0+8
  DW_CFA_advance_loc: 4 to 0+4
  DW_CFA_AARCH64_negate_ra_state
  DW_CFA_advance_loc: 4 to 0+8
  DW_CFA_def_cfa_offset: 16
  DW_CFA_offset: r29 \(x29\) at cfa-16
  DW_CFA_offset: r30 \(x30\) at cfa-8
  DW_CFA_nop
  DW_CFA_nop
