#source: abiflags-fake.s -32 -EB -mips32r2
#objcopy_objects: -R .MIPS.abiflags
#ld: -e 0 -melf32btsmip -T mips-lib.ld -e 0
#objcopy_linked_file: --rename-section .rename.me=.MIPS.abiflags
#objdump: -p

#...
