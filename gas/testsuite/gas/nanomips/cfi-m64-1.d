#as: -march=from-abi -m64 -EB -mlegacyregs
#objdump: -sj.eh_frame

.*

Contents of section \.eh_frame:
 0000 00000010 00000000 017a5200 017c1f01  .*
 0010 0c0d1d00 00000018 00000018 00000000  .*
 0020 00000000 00000000 00000004 00000000  .*
