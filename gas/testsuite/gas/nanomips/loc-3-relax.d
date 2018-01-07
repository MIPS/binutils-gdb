#PROG: readelf
#readelf: -wl
#as: --linkrelax
#name: nanoMIPS DWARF-2 location information test-3 with relaxation
#source: loc-3.s
#...
 Line Number Statements:
  [0x[0-9a-f]+]  Set prologue_end to true
  [0x[0-9a-f]+]  Extended opcode 2: set Address to 0x0
  [0x[0-9a-f]+]  Copy
  [0x[0-9a-f]+]  Advance Line by 1 to 2
  [0x[0-9a-f]+]  Advance PC by fixed size amount 0 to 0x0
  [0x[0-9a-f]+]  Copy
  [0x[0-9a-f]+]  Advance PC by fixed size amount 2 to 0x2
  [0x[0-9a-f]+]  Extended opcode 1: End of Sequence
