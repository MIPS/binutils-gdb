#source: attr-gnu-4-3.s
#source: attr-gnu-4-6.s
#ld: -r
#readelf: -A
#warning: Warning: .* uses -msoft-float \(set by .*\), .* uses -mhard-float
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Soft float
