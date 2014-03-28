#source: attr-gnu-4-2.s
#source: attr-gnu-4-7.s -W
#ld: -r
#readelf: -A
#warning: Warning: .* uses -msingle-float \(set by .*\), .* uses unknown floating point ABI 7
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(single precision\)
