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
                        32r6, 32r6s, 64r6, i7200, m7000, from-abi
-mdsp			generate DSP R3 instructions
-mno-dsp		do not generate R3 DSP instructions
-mdspr3			generate DSP R3 instructions
-mno-dspr3		do not generate DSP R3 instructions
-mmt			generate MT instructions
-mno-mt			do not generate MT instructions
-mmcu			generate MCU instructions
-mno-mcu		do not generate MCU instructions
-mmsa			generate MSA instructions
-mno-msa		do not generate MSA instructions
-mxpa			generate eXtended Physical Address \(XPA\) instructions
-mno-xpa		do not generate eXtended Physical Address \(XPA\) instructions
-mvirt			generate Virtualization instructions
-mno-virt		do not generate Virtualization instructions
-mginv			generate Global INValidate \(GINV\) instructions
-mno-ginv		do not generate Global INValidate instructions
-mtlb			generate Translation Lookaside Buffer \(TLB\) control instructions
-mno-tlb		do not generate Translation Lookaside Buffer control instructions
-minsn32		only generate 32-bit microMIPS instructions
-mno-insn32		generate all microMIPS instructions
-msym32			assume all symbols have 32-bit values
-O0			remove unneeded NOPs, do not swap branches
-O			remove unneeded NOPs and swap branches
--trap, --no-break	trap exception on div by 0 and mult overflow
--break, --no-trap	break exception on div by 0 and mult overflow
-mhard-float		allow floating-point instructions
-msoft-float		do not allow floating-point instructions
-msingle-float		only allow 32-bit floating-point operations
-mdouble-float		allow 32-bit and 64-bit floating-point operations
-m\[no-\]balc-stubs	enable/disable out-of-range call optimization
			through trampoline stubs
-m\[no-\]legacyregs	\[dis\]allow mumerical register formats
--\[no-\]construct-floats	\[dis\]allow floating point values to be constructed
--\[no-\]relax-branch	\[dis\]allow out-of-range branches to be relaxed
-m\[no-\]pcrel		\[dis\]allow PC-relative address calculations
-m\[no-\]pic		\[dis\]allow Position Independent Code generation
-m\[no-\]pid		\[dis\]allow Position Independent Data access
-mpdr, -mno-pdr		enable/disable creation of .pdr sections
-m32			create p32 ABI object file \(default\)
-m64			create p64 ABI object file


Report bugs to <http://www.sourceware.org/bugzilla/>
