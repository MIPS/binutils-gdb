cat <<EOF
OUTPUT_FORMAT("a.out-cris")
OUTPUT_ARCH(cris)
ENTRY(_start)
SECTIONS
{
  .text ${RELOCATING+ ${TEXT_START_ADDR}}:
  {
   CREATE_OBJECT_SYMBOLS;
    ${RELOCATING+ __Stext = .;}
    ${RELOCATING+*(.startup)}
    *(.text)
    ${RELOCATING+*(.text.*)}
    ${RELOCATING+*(.gnu.linkonce.t*)}
    ${RELOCATING+*(.rodata)}
    ${RELOCATING+*(.rodata.*)}
    ${RELOCATING+*(.gnu.linkonce.r*)}

    /* Do not "provide" init-start and fini-start symbols; they might be
       referred to weakly, so the linker would not override the zero
       default.
       FIXME: It's somewhat unexpected to have code emitted by the linker
       script.  Some other mechanism could probably do better.  */
    ${RELOCATING+. = ALIGN (2);}
    ${RELOCATING+ ___init__start = .;}
    ${RELOCATING+PROVIDE (___do_global_ctors = .);}
    ${RELOCATING+SHORT (0xe1fc); /* push srp */}
    ${RELOCATING+SHORT (0xbe7e);}
    ${RELOCATING+*(.init)}
    ${RELOCATING+SHORT (0x0d3e); /* jump [sp+] */}
    ${RELOCATING+PROVIDE (__init__end = .);}
    ${RELOCATING+PROVIDE (___init__end = .);}

    ${RELOCATING+. = ALIGN (2);}
    ${RELOCATING+ ___fini__start = .;}
    ${RELOCATING+PROVIDE (___do_global_dtors = .);}
    ${RELOCATING+SHORT (0xe1fc); /* push srp */}
    ${RELOCATING+SHORT (0xbe7e);}
    ${RELOCATING+*(.fini)}
    ${RELOCATING+SHORT (0x0d3e); /* jump [sp+] */}
    ${RELOCATING+PROVIDE (__fini__end = .);}
    ${RELOCATING+ ___fini__end = .;}

    /* Putting constructors in constant store is sane as long as
       there's no need for dynamic fixups.  */
    /* The constructors and destructors set symbols are unused now that
       collect2 has its wicked way.  */
    ${CONSTRUCTING+ ___aout_ctors_dtors_begin = .;}
    ${CONSTRUCTING+ SORT(CONSTRUCTORS);}
    ${CONSTRUCTING+ ___aout_ctors_dtors_end = .;}

    /* Cater to linking from ELF.  */
    ${CONSTRUCTING+ PROVIDE(___ctors = .);}
    ${CONSTRUCTING+ ___elf_ctors_dtors_begin = .;}
    ${CONSTRUCTING+ KEEP (*crtbegin.o(.ctors))}
    ${CONSTRUCTING+ KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))}
    ${CONSTRUCTING+ KEEP (*(SORT(.ctors.*)))}
    ${CONSTRUCTING+ KEEP (*(.ctors))}
    ${CONSTRUCTING+ PROVIDE(___ctors_end = .);}

    ${CONSTRUCTING+ PROVIDE(___dtors = .);}
    ${CONSTRUCTING+ KEEP (*crtbegin.o(.dtors))}
    ${CONSTRUCTING+ KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))}
    ${CONSTRUCTING+ KEEP (*(SORT(.dtors.*)))}
    ${CONSTRUCTING+ KEEP (*(.dtors))}
    ${CONSTRUCTING+ PROVIDE(___dtors_end = .);}
    ${CONSTRUCTING+ ___elf_ctors_dtors_end = .;}

    ${RELOCATING+ __Etext = .;}

    /* Deprecated, use __Etext.  */
    ${RELOCATING+ PROVIDE(_etext = .);}
  }

  /* Any dot-relative start-expression (such as "ALIGN(2)", also including
     the "default" .data alignment expression) will use the initial, raw
     size of .text and will be incorrect if the alignment used is less
     than the alignment for .text (which might depend on input and obj
     format).  FIXME: Seems like a bug in ld.  Seems hard to fix.  Seems
     unimportant.  */
  .data :
  {
    ${RELOCATING+ __Sdata = .;}
    *(.data);
    ${RELOCATING+*(.data.*)}
    ${RELOCATING+*(.gnu.linkonce.d*)}
    ${RELOCATING+*(.eh_frame) /* FIXME: Make .text */}
    ${RELOCATING+*(.gcc_except_table)}
    ${RELOCATING+ __Edata = .;}

    /* Deprecated, use __Edata.  */
    ${RELOCATING+ PROVIDE(_edata = .);}
  }

  .bss :
  {
    /* Deprecated, use __Sbss.  */
    ${RELOCATING+ PROVIDE(_bss_start = .);}

    ${RELOCATING+ __Sbss = .;}
    *(.bss)
    ${RELOCATING+*(.bss.*)}
    *(COMMON)
    ${RELOCATING+ __Ebss = .;}

    /* Deprecated, use __Ebss or __Eall as appropriate.  */
    ${RELOCATING+ PROVIDE(_end = .);}
    ${RELOCATING+ PROVIDE(__end = .);}
  }
  ${RELOCATING+ __Eall = .;}

  /* Unfortunately, stabs are not mappable from ELF to a.out.
     It can probably be fixed with some amount of work.  */
  /DISCARD/ : { *(.stab) *(.stab*) *(.debug) *(.debug*) *(.comment) }

  /* For the rsim and xsim simulators.  */
  ${RELOCATING+ PROVIDE(__Endmem = 0x10000000);}

  /* For elinux.  */
  ${RELOCATING+ PROVIDE(__Stacksize = 0);}
}
EOF
