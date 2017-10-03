# Test disassembly with debug location info
	.file 1 "debug-dis.s"
	.text
foo:
	.loc 1 10 0
.L3:
	b foo
.L4:
	nop
	.loc 1 20 0
b:
	.word .L4  # this should remain symbol-relative.
