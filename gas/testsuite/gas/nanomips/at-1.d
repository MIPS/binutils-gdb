#objdump: -dr
#name: nanoMIPS at-1

# Test the .set at=REG directive.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <foo>:
.+[0-9a-f]+:	003b 7fff 	addiu	at,k1,32767
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
.+[0-9a-f]+:	2361 0950 	addu	at,at,k1
.+[0-9a-f]+:	8761 8000 	lw	k1,0\(at\)
.+[0-9a-f]+:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
.+[0-9a-f]+:	2361 0950 	addu	at,at,k1
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	003b 8000 	addiu	at,k1,32768
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	005b 7fff 	addiu	t4,k1,32767
.+[0-9a-f]+:	8762 9000 	sw	k1,0\(t4\)
.+[0-9a-f]+:	e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2362 1150 	addu	t4,t4,k1
.+[0-9a-f]+:	8762 8000 	lw	k1,0\(t4\)
.+[0-9a-f]+:	e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2362 1150 	addu	t4,t4,k1
.+[0-9a-f]+:	8762 9000 	sw	k1,0\(t4\)
.+[0-9a-f]+:	005b 8000 	addiu	t4,k1,32768
.+[0-9a-f]+:	8762 9000 	sw	k1,0\(t4\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	007b 7fff 	addiu	t5,k1,32767
.+[0-9a-f]+:	8763 9000 	sw	k1,0\(t5\)
.+[0-9a-f]+:	e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2363 1950 	addu	t5,t5,k1
.+[0-9a-f]+:	8763 8000 	lw	k1,0\(t5\)
.+[0-9a-f]+:	e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2363 1950 	addu	t5,t5,k1
.+[0-9a-f]+:	8763 9000 	sw	k1,0\(t5\)
.+[0-9a-f]+:	007b 8000 	addiu	t5,k1,32768
.+[0-9a-f]+:	8763 9000 	sw	k1,0\(t5\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	009b 7fff 	addiu	a0,k1,32767
.+[0-9a-f]+:	8764 9000 	sw	k1,0\(a0\)
.+[0-9a-f]+:	e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
.+[0-9a-f]+:	2364 2150 	addu	a0,a0,k1
.+[0-9a-f]+:	8764 8000 	lw	k1,0\(a0\)
.+[0-9a-f]+:	e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
.+[0-9a-f]+:	2364 2150 	addu	a0,a0,k1
.+[0-9a-f]+:	8764 9000 	sw	k1,0\(a0\)
.+[0-9a-f]+:	009b 8000 	addiu	a0,k1,32768
.+[0-9a-f]+:	8764 9000 	sw	k1,0\(a0\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	00bb 7fff 	addiu	a1,k1,32767
.+[0-9a-f]+:	8765 9000 	sw	k1,0\(a1\)
.+[0-9a-f]+:	e0bf 8ffd 	lui	a1,%hi\(0xffff8000\)
.+[0-9a-f]+:	2365 2950 	addu	a1,a1,k1
.+[0-9a-f]+:	8765 8000 	lw	k1,0\(a1\)
.+[0-9a-f]+:	e0bf 8ffd 	lui	a1,%hi\(0xffff8000\)
.+[0-9a-f]+:	2365 2950 	addu	a1,a1,k1
.+[0-9a-f]+:	8765 9000 	sw	k1,0\(a1\)
.+[0-9a-f]+:	00bb 8000 	addiu	a1,k1,32768
.+[0-9a-f]+:	8765 9000 	sw	k1,0\(a1\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	00db 7fff 	addiu	a2,k1,32767
.+[0-9a-f]+:	8766 9000 	sw	k1,0\(a2\)
.+[0-9a-f]+:	e0df 8ffd 	lui	a2,%hi\(0xffff8000\)
.+[0-9a-f]+:	2366 3150 	addu	a2,a2,k1
.+[0-9a-f]+:	8766 8000 	lw	k1,0\(a2\)
.+[0-9a-f]+:	e0df 8ffd 	lui	a2,%hi\(0xffff8000\)
.+[0-9a-f]+:	2366 3150 	addu	a2,a2,k1
.+[0-9a-f]+:	8766 9000 	sw	k1,0\(a2\)
.+[0-9a-f]+:	00db 8000 	addiu	a2,k1,32768
.+[0-9a-f]+:	8766 9000 	sw	k1,0\(a2\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	00fb 7fff 	addiu	a3,k1,32767
.+[0-9a-f]+:	8767 9000 	sw	k1,0\(a3\)
.+[0-9a-f]+:	e0ff 8ffd 	lui	a3,%hi\(0xffff8000\)
.+[0-9a-f]+:	2367 3950 	addu	a3,a3,k1
.+[0-9a-f]+:	8767 8000 	lw	k1,0\(a3\)
.+[0-9a-f]+:	e0ff 8ffd 	lui	a3,%hi\(0xffff8000\)
.+[0-9a-f]+:	2367 3950 	addu	a3,a3,k1
.+[0-9a-f]+:	8767 9000 	sw	k1,0\(a3\)
.+[0-9a-f]+:	00fb 8000 	addiu	a3,k1,32768
.+[0-9a-f]+:	8767 9000 	sw	k1,0\(a3\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	011b 7fff 	addiu	a4,k1,32767
.+[0-9a-f]+:	8768 9000 	sw	k1,0\(a4\)
.+[0-9a-f]+:	e11f 8ffd 	lui	a4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2368 4150 	addu	a4,a4,k1
.+[0-9a-f]+:	8768 8000 	lw	k1,0\(a4\)
.+[0-9a-f]+:	e11f 8ffd 	lui	a4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2368 4150 	addu	a4,a4,k1
.+[0-9a-f]+:	8768 9000 	sw	k1,0\(a4\)
.+[0-9a-f]+:	011b 8000 	addiu	a4,k1,32768
.+[0-9a-f]+:	8768 9000 	sw	k1,0\(a4\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	013b 7fff 	addiu	a5,k1,32767
.+[0-9a-f]+:	8769 9000 	sw	k1,0\(a5\)
.+[0-9a-f]+:	e13f 8ffd 	lui	a5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2369 4950 	addu	a5,a5,k1
.+[0-9a-f]+:	8769 8000 	lw	k1,0\(a5\)
.+[0-9a-f]+:	e13f 8ffd 	lui	a5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2369 4950 	addu	a5,a5,k1
.+[0-9a-f]+:	8769 9000 	sw	k1,0\(a5\)
.+[0-9a-f]+:	013b 8000 	addiu	a5,k1,32768
.+[0-9a-f]+:	8769 9000 	sw	k1,0\(a5\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	015b 7fff 	addiu	a6,k1,32767
.+[0-9a-f]+:	876a 9000 	sw	k1,0\(a6\)
.+[0-9a-f]+:	e15f 8ffd 	lui	a6,%hi\(0xffff8000\)
.+[0-9a-f]+:	236a 5150 	addu	a6,a6,k1
.+[0-9a-f]+:	876a 8000 	lw	k1,0\(a6\)
.+[0-9a-f]+:	e15f 8ffd 	lui	a6,%hi\(0xffff8000\)
.+[0-9a-f]+:	236a 5150 	addu	a6,a6,k1
.+[0-9a-f]+:	876a 9000 	sw	k1,0\(a6\)
.+[0-9a-f]+:	015b 8000 	addiu	a6,k1,32768
.+[0-9a-f]+:	876a 9000 	sw	k1,0\(a6\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	017b 7fff 	addiu	a7,k1,32767
.+[0-9a-f]+:	876b 9000 	sw	k1,0\(a7\)
.+[0-9a-f]+:	e17f 8ffd 	lui	a7,%hi\(0xffff8000\)
.+[0-9a-f]+:	236b 5950 	addu	a7,a7,k1
.+[0-9a-f]+:	876b 8000 	lw	k1,0\(a7\)
.+[0-9a-f]+:	e17f 8ffd 	lui	a7,%hi\(0xffff8000\)
.+[0-9a-f]+:	236b 5950 	addu	a7,a7,k1
.+[0-9a-f]+:	876b 9000 	sw	k1,0\(a7\)
.+[0-9a-f]+:	017b 8000 	addiu	a7,k1,32768
.+[0-9a-f]+:	876b 9000 	sw	k1,0\(a7\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	019b 7fff 	addiu	t0,k1,32767
.+[0-9a-f]+:	876c 9000 	sw	k1,0\(t0\)
.+[0-9a-f]+:	e19f 8ffd 	lui	t0,%hi\(0xffff8000\)
.+[0-9a-f]+:	236c 6150 	addu	t0,t0,k1
.+[0-9a-f]+:	876c 8000 	lw	k1,0\(t0\)
.+[0-9a-f]+:	e19f 8ffd 	lui	t0,%hi\(0xffff8000\)
.+[0-9a-f]+:	236c 6150 	addu	t0,t0,k1
.+[0-9a-f]+:	876c 9000 	sw	k1,0\(t0\)
.+[0-9a-f]+:	019b 8000 	addiu	t0,k1,32768
.+[0-9a-f]+:	876c 9000 	sw	k1,0\(t0\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	01bb 7fff 	addiu	t1,k1,32767
.+[0-9a-f]+:	876d 9000 	sw	k1,0\(t1\)
.+[0-9a-f]+:	e1bf 8ffd 	lui	t1,%hi\(0xffff8000\)
.+[0-9a-f]+:	236d 6950 	addu	t1,t1,k1
.+[0-9a-f]+:	876d 8000 	lw	k1,0\(t1\)
.+[0-9a-f]+:	e1bf 8ffd 	lui	t1,%hi\(0xffff8000\)
.+[0-9a-f]+:	236d 6950 	addu	t1,t1,k1
.+[0-9a-f]+:	876d 9000 	sw	k1,0\(t1\)
.+[0-9a-f]+:	01bb 8000 	addiu	t1,k1,32768
.+[0-9a-f]+:	876d 9000 	sw	k1,0\(t1\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	01db 7fff 	addiu	t2,k1,32767
.+[0-9a-f]+:	876e 9000 	sw	k1,0\(t2\)
.+[0-9a-f]+:	e1df 8ffd 	lui	t2,%hi\(0xffff8000\)
.+[0-9a-f]+:	236e 7150 	addu	t2,t2,k1
.+[0-9a-f]+:	876e 8000 	lw	k1,0\(t2\)
.+[0-9a-f]+:	e1df 8ffd 	lui	t2,%hi\(0xffff8000\)
.+[0-9a-f]+:	236e 7150 	addu	t2,t2,k1
.+[0-9a-f]+:	876e 9000 	sw	k1,0\(t2\)
.+[0-9a-f]+:	01db 8000 	addiu	t2,k1,32768
.+[0-9a-f]+:	876e 9000 	sw	k1,0\(t2\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	01fb 7fff 	addiu	t3,k1,32767
.+[0-9a-f]+:	876f 9000 	sw	k1,0\(t3\)
.+[0-9a-f]+:	e1ff 8ffd 	lui	t3,%hi\(0xffff8000\)
.+[0-9a-f]+:	236f 7950 	addu	t3,t3,k1
.+[0-9a-f]+:	876f 8000 	lw	k1,0\(t3\)
.+[0-9a-f]+:	e1ff 8ffd 	lui	t3,%hi\(0xffff8000\)
.+[0-9a-f]+:	236f 7950 	addu	t3,t3,k1
.+[0-9a-f]+:	876f 9000 	sw	k1,0\(t3\)
.+[0-9a-f]+:	01fb 8000 	addiu	t3,k1,32768
.+[0-9a-f]+:	876f 9000 	sw	k1,0\(t3\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	021b 7fff 	addiu	s0,k1,32767
.+[0-9a-f]+:	8770 9000 	sw	k1,0\(s0\)
.+[0-9a-f]+:	e21f 8ffd 	lui	s0,%hi\(0xffff8000\)
.+[0-9a-f]+:	2370 8150 	addu	s0,s0,k1
.+[0-9a-f]+:	8770 8000 	lw	k1,0\(s0\)
.+[0-9a-f]+:	e21f 8ffd 	lui	s0,%hi\(0xffff8000\)
.+[0-9a-f]+:	2370 8150 	addu	s0,s0,k1
.+[0-9a-f]+:	8770 9000 	sw	k1,0\(s0\)
.+[0-9a-f]+:	021b 8000 	addiu	s0,k1,32768
.+[0-9a-f]+:	8770 9000 	sw	k1,0\(s0\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	023b 7fff 	addiu	s1,k1,32767
.+[0-9a-f]+:	8771 9000 	sw	k1,0\(s1\)
.+[0-9a-f]+:	e23f 8ffd 	lui	s1,%hi\(0xffff8000\)
.+[0-9a-f]+:	2371 8950 	addu	s1,s1,k1
.+[0-9a-f]+:	8771 8000 	lw	k1,0\(s1\)
.+[0-9a-f]+:	e23f 8ffd 	lui	s1,%hi\(0xffff8000\)
.+[0-9a-f]+:	2371 8950 	addu	s1,s1,k1
.+[0-9a-f]+:	8771 9000 	sw	k1,0\(s1\)
.+[0-9a-f]+:	023b 8000 	addiu	s1,k1,32768
.+[0-9a-f]+:	8771 9000 	sw	k1,0\(s1\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	025b 7fff 	addiu	s2,k1,32767
.+[0-9a-f]+:	8772 9000 	sw	k1,0\(s2\)
.+[0-9a-f]+:	e25f 8ffd 	lui	s2,%hi\(0xffff8000\)
.+[0-9a-f]+:	2372 9150 	addu	s2,s2,k1
.+[0-9a-f]+:	8772 8000 	lw	k1,0\(s2\)
.+[0-9a-f]+:	e25f 8ffd 	lui	s2,%hi\(0xffff8000\)
.+[0-9a-f]+:	2372 9150 	addu	s2,s2,k1
.+[0-9a-f]+:	8772 9000 	sw	k1,0\(s2\)
.+[0-9a-f]+:	025b 8000 	addiu	s2,k1,32768
.+[0-9a-f]+:	8772 9000 	sw	k1,0\(s2\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	027b 7fff 	addiu	s3,k1,32767
.+[0-9a-f]+:	8773 9000 	sw	k1,0\(s3\)
.+[0-9a-f]+:	e27f 8ffd 	lui	s3,%hi\(0xffff8000\)
.+[0-9a-f]+:	2373 9950 	addu	s3,s3,k1
.+[0-9a-f]+:	8773 8000 	lw	k1,0\(s3\)
.+[0-9a-f]+:	e27f 8ffd 	lui	s3,%hi\(0xffff8000\)
.+[0-9a-f]+:	2373 9950 	addu	s3,s3,k1
.+[0-9a-f]+:	8773 9000 	sw	k1,0\(s3\)
.+[0-9a-f]+:	027b 8000 	addiu	s3,k1,32768
.+[0-9a-f]+:	8773 9000 	sw	k1,0\(s3\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	029b 7fff 	addiu	s4,k1,32767
.+[0-9a-f]+:	8774 9000 	sw	k1,0\(s4\)
.+[0-9a-f]+:	e29f 8ffd 	lui	s4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2374 a150 	addu	s4,s4,k1
.+[0-9a-f]+:	8774 8000 	lw	k1,0\(s4\)
.+[0-9a-f]+:	e29f 8ffd 	lui	s4,%hi\(0xffff8000\)
.+[0-9a-f]+:	2374 a150 	addu	s4,s4,k1
.+[0-9a-f]+:	8774 9000 	sw	k1,0\(s4\)
.+[0-9a-f]+:	029b 8000 	addiu	s4,k1,32768
.+[0-9a-f]+:	8774 9000 	sw	k1,0\(s4\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	02bb 7fff 	addiu	s5,k1,32767
.+[0-9a-f]+:	8775 9000 	sw	k1,0\(s5\)
.+[0-9a-f]+:	e2bf 8ffd 	lui	s5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2375 a950 	addu	s5,s5,k1
.+[0-9a-f]+:	8775 8000 	lw	k1,0\(s5\)
.+[0-9a-f]+:	e2bf 8ffd 	lui	s5,%hi\(0xffff8000\)
.+[0-9a-f]+:	2375 a950 	addu	s5,s5,k1
.+[0-9a-f]+:	8775 9000 	sw	k1,0\(s5\)
.+[0-9a-f]+:	02bb 8000 	addiu	s5,k1,32768
.+[0-9a-f]+:	8775 9000 	sw	k1,0\(s5\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	02db 7fff 	addiu	s6,k1,32767
.+[0-9a-f]+:	8776 9000 	sw	k1,0\(s6\)
.+[0-9a-f]+:	e2df 8ffd 	lui	s6,%hi\(0xffff8000\)
.+[0-9a-f]+:	2376 b150 	addu	s6,s6,k1
.+[0-9a-f]+:	8776 8000 	lw	k1,0\(s6\)
.+[0-9a-f]+:	e2df 8ffd 	lui	s6,%hi\(0xffff8000\)
.+[0-9a-f]+:	2376 b150 	addu	s6,s6,k1
.+[0-9a-f]+:	8776 9000 	sw	k1,0\(s6\)
.+[0-9a-f]+:	02db 8000 	addiu	s6,k1,32768
.+[0-9a-f]+:	8776 9000 	sw	k1,0\(s6\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	02fb 7fff 	addiu	s7,k1,32767
.+[0-9a-f]+:	8777 9000 	sw	k1,0\(s7\)
.+[0-9a-f]+:	e2ff 8ffd 	lui	s7,%hi\(0xffff8000\)
.+[0-9a-f]+:	2377 b950 	addu	s7,s7,k1
.+[0-9a-f]+:	8777 8000 	lw	k1,0\(s7\)
.+[0-9a-f]+:	e2ff 8ffd 	lui	s7,%hi\(0xffff8000\)
.+[0-9a-f]+:	2377 b950 	addu	s7,s7,k1
.+[0-9a-f]+:	8777 9000 	sw	k1,0\(s7\)
.+[0-9a-f]+:	02fb 8000 	addiu	s7,k1,32768
.+[0-9a-f]+:	8777 9000 	sw	k1,0\(s7\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	031b 7fff 	addiu	t8,k1,32767
.+[0-9a-f]+:	8778 9000 	sw	k1,0\(t8\)
.+[0-9a-f]+:	e31f 8ffd 	lui	t8,%hi\(0xffff8000\)
.+[0-9a-f]+:	2378 c150 	addu	t8,t8,k1
.+[0-9a-f]+:	8778 8000 	lw	k1,0\(t8\)
.+[0-9a-f]+:	e31f 8ffd 	lui	t8,%hi\(0xffff8000\)
.+[0-9a-f]+:	2378 c150 	addu	t8,t8,k1
.+[0-9a-f]+:	8778 9000 	sw	k1,0\(t8\)
.+[0-9a-f]+:	031b 8000 	addiu	t8,k1,32768
.+[0-9a-f]+:	8778 9000 	sw	k1,0\(t8\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	033b 7fff 	addiu	t9,k1,32767
.+[0-9a-f]+:	8779 9000 	sw	k1,0\(t9\)
.+[0-9a-f]+:	e33f 8ffd 	lui	t9,%hi\(0xffff8000\)
.+[0-9a-f]+:	2379 c950 	addu	t9,t9,k1
.+[0-9a-f]+:	8779 8000 	lw	k1,0\(t9\)
.+[0-9a-f]+:	e33f 8ffd 	lui	t9,%hi\(0xffff8000\)
.+[0-9a-f]+:	2379 c950 	addu	t9,t9,k1
.+[0-9a-f]+:	8779 9000 	sw	k1,0\(t9\)
.+[0-9a-f]+:	033b 8000 	addiu	t9,k1,32768
.+[0-9a-f]+:	8779 9000 	sw	k1,0\(t9\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	035b 7fff 	addiu	k0,k1,32767
.+[0-9a-f]+:	877a 9000 	sw	k1,0\(k0\)
.+[0-9a-f]+:	e35f 8ffd 	lui	k0,%hi\(0xffff8000\)
.+[0-9a-f]+:	237a d150 	addu	k0,k0,k1
.+[0-9a-f]+:	877a 8000 	lw	k1,0\(k0\)
.+[0-9a-f]+:	e35f 8ffd 	lui	k0,%hi\(0xffff8000\)
.+[0-9a-f]+:	237a d150 	addu	k0,k0,k1
.+[0-9a-f]+:	877a 9000 	sw	k1,0\(k0\)
.+[0-9a-f]+:	035b 8000 	addiu	k0,k1,32768
.+[0-9a-f]+:	877a 9000 	sw	k1,0\(k0\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	037a 7fff 	addiu	k1,k0,32767
.+[0-9a-f]+:	875b 9000 	sw	k0,0\(k1\)
.+[0-9a-f]+:	e37f 8ffd 	lui	k1,%hi\(0xffff8000\)
.+[0-9a-f]+:	235b d950 	addu	k1,k1,k0
.+[0-9a-f]+:	875b 8000 	lw	k0,0\(k1\)
.+[0-9a-f]+:	e37f 8ffd 	lui	k1,%hi\(0xffff8000\)
.+[0-9a-f]+:	235b d950 	addu	k1,k1,k0
.+[0-9a-f]+:	875b 9000 	sw	k0,0\(k1\)
.+[0-9a-f]+:	037a 8000 	addiu	k1,k0,32768
.+[0-9a-f]+:	875b 9000 	sw	k0,0\(k1\)
.+[0-9a-f]+:	6341 7fff 	addiu	k0,k0,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	875a 9000 	sw	k0,0\(k0\)
.+[0-9a-f]+:	039b 7fff 	addiu	gp,k1,32767
.+[0-9a-f]+:	877c 9000 	sw	k1,0\(gp\)
.+[0-9a-f]+:	e39f 8ffd 	lui	gp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237c e150 	addu	gp,gp,k1
.+[0-9a-f]+:	877c 8000 	lw	k1,0\(gp\)
.+[0-9a-f]+:	e39f 8ffd 	lui	gp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237c e150 	addu	gp,gp,k1
.+[0-9a-f]+:	877c 9000 	sw	k1,0\(gp\)
.+[0-9a-f]+:	039b 8000 	addiu	gp,k1,32768
.+[0-9a-f]+:	877c 9000 	sw	k1,0\(gp\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	03db 7fff 	addiu	fp,k1,32767
.+[0-9a-f]+:	877e 9000 	sw	k1,0\(fp\)
.+[0-9a-f]+:	e3df 8ffd 	lui	fp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237e f150 	addu	fp,fp,k1
.+[0-9a-f]+:	877e 8000 	lw	k1,0\(fp\)
.+[0-9a-f]+:	e3df 8ffd 	lui	fp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237e f150 	addu	fp,fp,k1
.+[0-9a-f]+:	877e 9000 	sw	k1,0\(fp\)
.+[0-9a-f]+:	03db 8000 	addiu	fp,k1,32768
.+[0-9a-f]+:	877e 9000 	sw	k1,0\(fp\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	03bb 7fff 	addiu	sp,k1,32767
.+[0-9a-f]+:	877d 9000 	sw	k1,0\(sp\)
.+[0-9a-f]+:	e3bf 8ffd 	lui	sp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237d e950 	addu	sp,sp,k1
.+[0-9a-f]+:	877d 8000 	lw	k1,0\(sp\)
.+[0-9a-f]+:	e3bf 8ffd 	lui	sp,%hi\(0xffff8000\)
.+[0-9a-f]+:	237d e950 	addu	sp,sp,k1
.+[0-9a-f]+:	877d 9000 	sw	k1,0\(sp\)
.+[0-9a-f]+:	03bb 8000 	addiu	sp,k1,32768
.+[0-9a-f]+:	877d 9000 	sw	k1,0\(sp\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	03fb 7fff 	addiu	ra,k1,32767
.+[0-9a-f]+:	877f 9000 	sw	k1,0\(ra\)
.+[0-9a-f]+:	e3ff 8ffd 	lui	ra,%hi\(0xffff8000\)
.+[0-9a-f]+:	237f f950 	addu	ra,ra,k1
.+[0-9a-f]+:	877f 8000 	lw	k1,0\(ra\)
.+[0-9a-f]+:	e3ff 8ffd 	lui	ra,%hi\(0xffff8000\)
.+[0-9a-f]+:	237f f950 	addu	ra,ra,k1
.+[0-9a-f]+:	877f 9000 	sw	k1,0\(ra\)
.+[0-9a-f]+:	03fb 8000 	addiu	ra,k1,32768
.+[0-9a-f]+:	877f 9000 	sw	k1,0\(ra\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
.+[0-9a-f]+:	003b 7fff 	addiu	at,k1,32767
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
.+[0-9a-f]+:	2361 0950 	addu	at,at,k1
.+[0-9a-f]+:	8761 8000 	lw	k1,0\(at\)
.+[0-9a-f]+:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
.+[0-9a-f]+:	2361 0950 	addu	at,at,k1
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	003b 8000 	addiu	at,k1,32768
.+[0-9a-f]+:	8761 9000 	sw	k1,0\(at\)
.+[0-9a-f]+:	6361 7fff 	addiu	k1,k1,-32769
.+[0-9a-f]+:	ffff 
.+[0-9a-f]+:	877b 9000 	sw	k1,0\(k1\)
#pass
