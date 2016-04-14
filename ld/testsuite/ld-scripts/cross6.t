NOCROSSREFSTO(.text .data)

SECTIONS
{
  .text : { *(.text) }
  .data : { *(.data) *(.opd) }
  .bss : { *(.bss) *(COMMON) }
  /DISCARD/ : { *(*) }
}
