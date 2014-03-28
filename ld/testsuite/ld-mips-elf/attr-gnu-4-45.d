#source: attr-gnu-4-4.s -W
#source: attr-gnu-4-5.s
#ld: -r
#readelf: -A
#error: \A[^\n]*: Warning: .* uses -mips32r2 -mfp64 \(12 callee-saved\) \(set by .*\), .* uses -mfpxx\n
#error:   [^\n]*: [^\n]* linking -mfp32 module with previous -mfp64 modules\n
#error:   [^\n]*: failed to merge target specific data of file [^\n]*\.o\Z
#target: mips*-*-*

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(MIPS32r2 64-bit FPU 12 callee-saved\)
