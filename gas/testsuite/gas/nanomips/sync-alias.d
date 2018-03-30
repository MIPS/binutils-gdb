#objdump: -dr
#name: Light weight sync aliases

# Check assembly/disassembly of sync aliases

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	8000 c006 	sync
   4:	8004 c006 	sync_wmb
   8:	8010 c006 	sync_mb
   c:	8011 c006 	sync_acquire
  10:	8012 c006 	sync_release
  14:	8013 c006 	sync_rmb
  18:	8014 c006 	sync_ginv
#pass
