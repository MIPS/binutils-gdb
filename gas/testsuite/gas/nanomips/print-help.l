Usage: .* \[option\.\.\.\] \[asmfile\.\.\.\]
Options:
#...
nanoMIPS options:
-EB			generate big endian output
-EL			generate little endian output
-g, -g2			do not remove unneeded NOPs or swap branches
-G NUM			allow referencing objects up to NUM bytes
			implicitly with the gp register \[default 8\]
-march=CPU/-mtune=CPU	generate code/schedule for CPU, where CPU is one of:
                        32r6, 32r6s, 64r6, i7200, nms1, from-abi
-m32			create p32 ABI object file \(default\)
-m64			create p64 ABI object file
-mcmodel=MMODEL		Generate code for a specific memory model,
			where MMODEL is one of: auto, medium, large
-m\[no-\]pic		\[dis\]allow Position Independent Code generation
-m\[no-\]PIC		\[dis\]allow large model Position Independent Code generation
-m\[no-\]pid		\[dis\]allow Position Independent Data access
-m\[no-\]pcrel		\[dis\]allow PC-relative address calculations
-minsn32		only generate 32-bit nanoMIPS instructions
-mno-insn32		generate all nanoMIPS instructions
-mhard-float		allow floating-point instructions
-msoft-float		do not allow floating-point instructions
-msingle-float		only allow 32-bit floating-point operations
-mdouble-float		allow 32-bit and 64-bit floating-point operations
--\[no-\]construct-floats	\[dis\]allow floating point values to be constructed
-mcrc			generate Cyclic Redundancy Check \(CRC\) instructions
-mno-crc		do not generate CRC instructions
-mdsp			generate DSP R3 instructions
-mno-dsp		do not generate R3 DSP instructions
-mdspr3			generate DSP R3 instructions
-mno-dspr3		do not generate DSP R3 instructions
-meva			generate Enhanced Virtual Addressing \(EVA\) instructions
-mno-eva		do not generate EVA instructions
-mginv			generate Global INValidate \(GINV\) instructions
-mno-ginv		do not generate Global INValidate instructions
-mmcu			generate MCU instructions
-mno-mcu		do not generate MCU instructions
-mmt			generate MT instructions
-mno-mt			do not generate MT instructions
-mtlb			generate Translation Lookaside Buffer \(TLB\) control instructions
-mno-tlb		do not generate Translation Lookaside Buffer control instructions
-mvirt			generate Virtualization instructions
-mno-virt		do not generate Virtualization instructions
-m\[no-\]balc-stubs	enable/disable out-of-range call optimization
			through trampoline stubs
-m\[no-\]legacyregs	\[dis\]allow mumerical register formats
--linkrelax		allow linker relaxations
--trap, --no-break	trap exception on div by 0 and mult overflow
--break, --no-trap	break exception on div by 0 and mult overflow
-mmttgpr-rc1		Revert to RC1 assembly format for MTTGPR instruction
-m\[no-\]minimize-relocs	enable/disable full resolution of link-time invariable
			PC-relative relocations at assembly

Report bugs to .*
