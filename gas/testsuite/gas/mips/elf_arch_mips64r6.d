# name: ELF MIPS64r6 markings
# source: empty.s
# objdump: -p
# as: -march=mips64r6

.*:.*file format.*elf.*mips.*
private flags = a.......: .*\[mips64r6\].*

