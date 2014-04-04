#ld: -Tnote-1.t
#readelf: -l --wide
#xfail: hppa64-*-* mips-*-*
# mips and hppa64 add PHDR

#...
 Section to Segment mapping:
  Segment Sections...
   00     .foo 
   01     .note 
