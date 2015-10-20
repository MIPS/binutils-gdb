tmpdir/ifunc-iplt-micromips:     file format elf32-tradbigmips


Disassembly of section .iplt:

004001c0 <.iplt.func1>:
  4001c0:	41a3 0041 	lui	v1,0x41
  4001c4:	ff23 01d0 	lw	t9,464\(v1\)
  4001c8:	45b9      	jrc	t9
