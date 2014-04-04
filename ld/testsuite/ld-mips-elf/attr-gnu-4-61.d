#source: attr-gnu-4-6.s -32 -EB
#source: attr-gnu-4-1.s -32 -EB
#ld: -r -melf32btsmip
#readelf: -A
#warning: Warning: .* uses -mips32r2 -mfp64 \(set by .*\), .* uses -mdouble-float
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(MIPS32r2 64-bit FPU\)
