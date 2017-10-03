#objdump: -dr -M gpr-names=numeric,cp1-names=32r6
#name: nanoMIPS CP1 register disassembly

# Check objdump's handling of -M cp1-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:

