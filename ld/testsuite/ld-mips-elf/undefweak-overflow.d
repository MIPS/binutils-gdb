#name: undefined weak symbol overflow
#source: undefweak-overflow.s
#ld: -Ttext=0x20000000 -e start
#objdump: -dr --show-raw-insn
#...
[0-9a-f]+ <_ftext>:
[ 0-9a-f]+:	1000ffff 	b	20000000 <_ftext>
[ 0-9a-f]+:	00000000 	nop
[ 0-9a-f]+:	0411fffd 	bal	20000000 <_ftext>
[ 0-9a-f]+:	3c...... 	lui	a0,0x....
[ 0-9a-f]+:	0c000000 	jal	20000000 <_ftext>
[ 0-9a-f]+:	00000000 	nop
[ 0-9a-f]+:	08000000 	j	20000000 <_ftext>
[ 0-9a-f]+:	00000000 	nop

[0-9a-f]+ <micro>:
[ 0-9a-f]+:	8e6f      	beqz	a0,20000000 <_ftext>
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	cfed      	b	20000000 <_ftext>
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	9400 ffea 	b	20000000 <_ftext>
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4060 ffe7 	bal	20000000 <_ftext>
[ 0-9a-f]+:	0000 0000 	nop
[ 0-9a-f]+:	f400 0000 	jal	20000000 <_ftext>
[ 0-9a-f]+:	0000 0000 	nop
[ 0-9a-f]+:	d400 0000 	j	20000000 <_ftext>
[ 0-9a-f]+:	0c00      	nop

[0-9a-f]+ <mips16>:
[ 0-9a-f]+:	f7df 101c 	b	20000000 <_ftext>
[ 0-9a-f]+:	1800 0000 	jal	20000000 <_ftext>
[ 0-9a-f]+:	6500      	nop
#pass
