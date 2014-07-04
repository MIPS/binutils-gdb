#PROG: readelf
#source: empty.s
#as: -32 -mips32 -mno-odd-spreg
#readelf: -A
#name: -mno-odd-spreg test

Attribute Section: gnu
File Attributes
  Tag_GNU_MIPS_ABI_FP: Hard float \(double precision\)

MIPS ABI Flags Version: 0

ISA: MIPS.*
GPR size: .*
CPR1 size: .*
CPR2 size: 0
FP ABI: Hard float \(double precision\)
ISA Extension: .*
ASEs:
#...
FLAGS 1: 00000000
FLAGS 2: 00000000
