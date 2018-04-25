#objdump: -dr --no-show-raw-insn -M gpr-names=numeric
#name: nanoMIPS GPR disassembly (numeric)
#source: gpr-names.s

# Check objdump's handling of -M gpr-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	lui	\$0,0x0
   4:	lui	\$1,0x0
   8:	lui	\$2,0x0
   c:	lui	\$3,0x0
  10:	lui	\$4,0x0
  14:	lui	\$5,0x0
  18:	lui	\$6,0x0
  1c:	lui	\$7,0x0
  20:	lui	\$8,0x0
  24:	lui	\$9,0x0
  28:	lui	\$10,0x0
  2c:	lui	\$11,0x0
  30:	lui	\$12,0x0
  34:	lui	\$13,0x0
  38:	lui	\$14,0x0
  3c:	lui	\$15,0x0
  40:	lui	\$16,0x0
  44:	lui	\$17,0x0
  48:	lui	\$18,0x0
  4c:	lui	\$19,0x0
  50:	lui	\$20,0x0
  54:	lui	\$21,0x0
  58:	lui	\$22,0x0
  5c:	lui	\$23,0x0
  60:	lui	\$24,0x0
  64:	lui	\$25,0x0
  68:	lui	\$26,0x0
  6c:	lui	\$27,0x0
  70:	lui	\$28,0x0
  74:	lui	\$29,0x0
  78:	lui	\$30,0x0
  7c:	lui	\$31,0x0
#pass
