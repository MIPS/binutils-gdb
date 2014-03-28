#source: attr-gnu-4-1.s
#source: attr-gnu-4-6.s
#ld: -r
#readelf: -A
#warning: Warning: .* uses -mdouble-float \(set by .*\), .* uses -mips32r2 -mfp64
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(double precision\)
