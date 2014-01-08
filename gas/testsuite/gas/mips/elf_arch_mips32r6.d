# name: ELF MIPS32r6 markings
# source: empty.s
# objdump: -p
# as: -32 -march=mips32r6

.*:.*file format.*elf.*mips.*
private flags = 9.......: .*\[mips32r6\].*

