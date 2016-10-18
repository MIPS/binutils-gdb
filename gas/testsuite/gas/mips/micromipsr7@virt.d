#objdump: -dr --prefix-addresses  --show-raw-insn -Mvirt,cp0-names=mips32r7
#name: virt instructions on R7
#source: virt.s
#as: -32 -mvirt -meva

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> 207d 00b0 	mfgc0	v1,c0_taghi
0+0004 <foo\+0x4> 2174 28b0 	mfgc0	t3,\$20,5
0+0008 <foo\+0x8> 22e2 00f0 	mtgc0	s7,c0_entrylo0
0+000c <foo\+0xc> 20ee 10f0 	mtgc0	a3,\$14,2
0+0010 <foo\+0x10> 100c      	hypcall
0+0012 <foo\+0x12> 000c 0256 	hypcall	0x256
0+0016 <foo\+0x16> 2000 057f 	tlbginv
0+001a <foo\+0x1a> 2000 157f 	tlbginvf
0+001e <foo\+0x1e> 2000 017f 	tlbgp
0+0022 <foo\+0x22> 2000 117f 	tlbgr
0+0026 <foo\+0x26> 2000 217f 	tlbgwi
0+002a <foo\+0x2a> 2000 317f 	tlbgwr
0+002e <foo\+0x2e> 9008      	nop
	\.\.\.
