#source: attr-gnu-4-3.s -32 -EB
#source: attr-gnu-4-5.s -32 -EB
#ld: -r -melf32btsmip
#readelf: -A
#warning: Warning: .* uses -msoft-float \(set by .*\), .* uses -mhard-float
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Soft float
