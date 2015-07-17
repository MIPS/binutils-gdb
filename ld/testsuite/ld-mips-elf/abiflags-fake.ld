OUTPUT_FORMAT("elf32-tradbigmips", "elf32-tradbigmips",
	      "elf32-tradlittlemips")
OUTPUT_ARCH(mips)
SECTIONS
{
  /DISCARD/ : { *(.MIPS.abiflags) }
}
