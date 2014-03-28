#source: attr-gnu-4-6.s
#source: attr-gnu-4-7.s -W
#ld: -r
#readelf: -A
#warning: Warning: .* uses -mips32r2 -mfp64 \(set by .*\), .* uses unknown floating point ABI 7
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(MIPS32r2 64-bit FPU\)
