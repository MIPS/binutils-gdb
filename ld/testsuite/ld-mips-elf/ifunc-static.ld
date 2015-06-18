ENTRY(_start)
SECTIONS
{
  . = 0x80000;
  . = ALIGN (0x400);
  .iplt : { *(.iplt) }

  . = ALIGN (0x400);
  .text : { *(.text) }

  . = ALIGN (0x400);
  .igot : { *(.igot) }

  . = ALIGN (0x400);
  .got : { *(.got) }

  . = ALIGN (0x400);
  .data : { *(.data) }

  . = ALIGN (0x1000);
  .rel.dyn        :
    {
      *(.rel.*)
    }
/*  /DISCARD/ : { *(*) } */

}
