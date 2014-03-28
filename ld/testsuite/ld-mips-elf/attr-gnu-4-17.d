#source: attr-gnu-4-1.s
#source: attr-gnu-4-7.s -W
#ld: -r
#readelf: -A
#warning: Warning: .* uses -mdouble-float \(set by .*\), .* uses unknown floating point ABI 7
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(double precision\)
