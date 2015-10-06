#name: undefined weak symbol overflow [umips]
#source: umips-undefweak-overflow.s
#as: -32 -EB
#ld: -melf32btsmip -Ttext=0x20000000 -e start
#objdump: -dr
#...
0*20000000:	805f fffe.*
0*20000004:	a05f fffc.*
0*20000008:	97ff fffa.*
#pass
