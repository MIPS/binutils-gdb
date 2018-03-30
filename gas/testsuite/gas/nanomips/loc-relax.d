#PROG: readelf
#readelf: -wl
#name: nanoMIPS DWARF-2 location information with relaxation
#as: --linkrelax -minsn32
#source: loc.s

# Verify that DWARF-2 location information for instructions reordered
# into a branch delay slot is updated to point to the branch instead.

Raw dump of debug contents of section \.debug_line:

  Offset:                      0x0
  Length:                      138
  DWARF Version:               2
  Prologue Length:             28
  Minimum Instruction Length:  1
  Initial value of 'is_stmt':  1
  Line Base:                   -5
  Line Range:                  14
  Opcode Base:                 13

 Opcodes:
  Opcode 1 has 0 args
  Opcode 2 has 1 args
  Opcode 3 has 1 args
  Opcode 4 has 1 args
  Opcode 5 has 1 args
  Opcode 6 has 0 args
  Opcode 7 has 0 args
  Opcode 8 has 0 args
  Opcode 9 has 1 args
  Opcode 10 has 0 args
  Opcode 11 has 0 args
  Opcode 12 has 1 args

 The Directory Table is empty\.

 The File Name Table \(offset 0x.*\):
  Entry	Dir	Time	Size	Name
  1	0	0	0	loc\.s

 Line Number Statements:
  \[0x.*\]  Extended opcode 2: set Address to 0x0
  \[0x.*\]  Special opcode 11: advance Address by 0 to 0x0 and Line by 6 to 7
  \[0x.*\]  Advance Line by 2 to 9
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x4
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 12
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x8
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 14
  \[0x.*\]  Advance PC by fixed size amount 4 to 0xc
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 17
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x10
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 19
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x14
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 22
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x18
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 24
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x1c
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 27
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x20
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 29
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x24
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 32
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x28
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 34
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x2c
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 37
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x30
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 39
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x34
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 3 to 42
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x38
  \[0x.*\]  Copy
  \[0x.*\]  Advance Line by 2 to 44
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x3c
  \[0x.*\]  Copy
  \[0x.*\]  Advance PC by fixed size amount 4 to 0x40
  \[0x.*\]  Extended opcode 1: End of Sequence
