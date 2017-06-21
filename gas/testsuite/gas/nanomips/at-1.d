#objdump: -dr
#name: nanoMIPS at-1

# Test the .set at=REG directive.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <foo>:
   0:	003b 7fff 	addiu	at,k1,32767
   4:	8761 8000 	lw	k1,0\(at\)
   8:	003b 7fff 	addiu	at,k1,32767
   c:	8761 9000 	sw	k1,0\(at\)
  10:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
  14:	2361 0950 	addu	at,at,k1
  18:	8761 8000 	lw	k1,0\(at\)
  1c:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
  20:	2361 0950 	addu	at,at,k1
  24:	8761 9000 	sw	k1,0\(at\)
  28:	003b 8000 	addiu	at,k1,32768
  2c:	8761 8000 	lw	k1,0\(at\)
  30:	003b 8000 	addiu	at,k1,32768
  34:	8761 9000 	sw	k1,0\(at\)
  38:	e03f 7ffd 	lui	at,%hi\(0xffff7000\)
  3c:	2361 0950 	addu	at,at,k1
  40:	8761 8fff 	lw	k1,4095\(at\)
  44:	e03f 7ffd 	lui	at,%hi\(0xffff7000\)
  48:	2361 0950 	addu	at,at,k1
  4c:	8761 9fff 	sw	k1,4095\(at\)
  50:	e020 0000 	lui	at,0x0
			50: R_NANOMIPS_HI20	symbol
  54:	2361 0950 	addu	at,at,k1
  58:	8761 8000 	lw	k1,0\(at\)
			58: R_NANOMIPS_LO12	symbol
  5c:	e020 0000 	lui	at,0x0
			5c: R_NANOMIPS_HI20	symbol
  60:	2361 0950 	addu	at,at,k1
  64:	8761 9000 	sw	k1,0\(at\)
			64: R_NANOMIPS_LO12	symbol
  68:	005b 7fff 	addiu	t4,k1,32767
  6c:	8762 8000 	lw	k1,0\(t4\)
  70:	005b 7fff 	addiu	t4,k1,32767
  74:	8762 9000 	sw	k1,0\(t4\)
  78:	e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
  7c:	2362 1150 	addu	t4,t4,k1
  80:	8762 8000 	lw	k1,0\(t4\)
  84:	e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
  88:	2362 1150 	addu	t4,t4,k1
  8c:	8762 9000 	sw	k1,0\(t4\)
  90:	005b 8000 	addiu	t4,k1,32768
  94:	8762 8000 	lw	k1,0\(t4\)
  98:	005b 8000 	addiu	t4,k1,32768
  9c:	8762 9000 	sw	k1,0\(t4\)
  a0:	e05f 7ffd 	lui	t4,%hi\(0xffff7000\)
  a4:	2362 1150 	addu	t4,t4,k1
  a8:	8762 8fff 	lw	k1,4095\(t4\)
  ac:	e05f 7ffd 	lui	t4,%hi\(0xffff7000\)
  b0:	2362 1150 	addu	t4,t4,k1
  b4:	8762 9fff 	sw	k1,4095\(t4\)
  b8:	e040 0000 	lui	t4,0x0
			b8: R_NANOMIPS_HI20	symbol
  bc:	2362 1150 	addu	t4,t4,k1
  c0:	8762 8000 	lw	k1,0\(t4\)
			c0: R_NANOMIPS_LO12	symbol
  c4:	e040 0000 	lui	t4,0x0
			c4: R_NANOMIPS_HI20	symbol
  c8:	2362 1150 	addu	t4,t4,k1
  cc:	8762 9000 	sw	k1,0\(t4\)
			cc: R_NANOMIPS_LO12	symbol
  d0:	007b 7fff 	addiu	t5,k1,32767
  d4:	8763 8000 	lw	k1,0\(t5\)
  d8:	007b 7fff 	addiu	t5,k1,32767
  dc:	8763 9000 	sw	k1,0\(t5\)
  e0:	e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
  e4:	2363 1950 	addu	t5,t5,k1
  e8:	8763 8000 	lw	k1,0\(t5\)
  ec:	e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
  f0:	2363 1950 	addu	t5,t5,k1
  f4:	8763 9000 	sw	k1,0\(t5\)
  f8:	007b 8000 	addiu	t5,k1,32768
  fc:	8763 8000 	lw	k1,0\(t5\)
 100:	007b 8000 	addiu	t5,k1,32768
 104:	8763 9000 	sw	k1,0\(t5\)
 108:	e07f 7ffd 	lui	t5,%hi\(0xffff7000\)
 10c:	2363 1950 	addu	t5,t5,k1
 110:	8763 8fff 	lw	k1,4095\(t5\)
 114:	e07f 7ffd 	lui	t5,%hi\(0xffff7000\)
 118:	2363 1950 	addu	t5,t5,k1
 11c:	8763 9fff 	sw	k1,4095\(t5\)
 120:	e060 0000 	lui	t5,0x0
			120: R_NANOMIPS_HI20	symbol
 124:	2363 1950 	addu	t5,t5,k1
 128:	8763 8000 	lw	k1,0\(t5\)
			128: R_NANOMIPS_LO12	symbol
 12c:	e060 0000 	lui	t5,0x0
			12c: R_NANOMIPS_HI20	symbol
 130:	2363 1950 	addu	t5,t5,k1
 134:	8763 9000 	sw	k1,0\(t5\)
			134: R_NANOMIPS_LO12	symbol
 138:	009b 7fff 	addiu	a0,k1,32767
 13c:	8764 8000 	lw	k1,0\(a0\)
 140:	009b 7fff 	addiu	a0,k1,32767
 144:	8764 9000 	sw	k1,0\(a0\)
 148:	e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
 14c:	2364 2150 	addu	a0,a0,k1
 150:	8764 8000 	lw	k1,0\(a0\)
 154:	e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
 158:	2364 2150 	addu	a0,a0,k1
 15c:	8764 9000 	sw	k1,0\(a0\)
 160:	009b 8000 	addiu	a0,k1,32768
 164:	8764 8000 	lw	k1,0\(a0\)
 168:	009b 8000 	addiu	a0,k1,32768
 16c:	8764 9000 	sw	k1,0\(a0\)
 170:	e09f 7ffd 	lui	a0,%hi\(0xffff7000\)
 174:	2364 2150 	addu	a0,a0,k1
 178:	8764 8fff 	lw	k1,4095\(a0\)
 17c:	e09f 7ffd 	lui	a0,%hi\(0xffff7000\)
 180:	2364 2150 	addu	a0,a0,k1
 184:	8764 9fff 	sw	k1,4095\(a0\)
 188:	e080 0000 	lui	a0,0x0
			188: R_NANOMIPS_HI20	symbol
 18c:	2364 2150 	addu	a0,a0,k1
 190:	8764 8000 	lw	k1,0\(a0\)
			190: R_NANOMIPS_LO12	symbol
 194:	e080 0000 	lui	a0,0x0
			194: R_NANOMIPS_HI20	symbol
 198:	2364 2150 	addu	a0,a0,k1
 19c:	8764 9000 	sw	k1,0\(a0\)
			19c: R_NANOMIPS_LO12	symbol
 1a0:	00bb 7fff 	addiu	a1,k1,32767
 1a4:	8765 8000 	lw	k1,0\(a1\)
 1a8:	00bb 7fff 	addiu	a1,k1,32767
 1ac:	8765 9000 	sw	k1,0\(a1\)
 1b0:	e0bf 8ffd 	lui	a1,%hi\(0xffff8000\)
 1b4:	2365 2950 	addu	a1,a1,k1
 1b8:	8765 8000 	lw	k1,0\(a1\)
 1bc:	e0bf 8ffd 	lui	a1,%hi\(0xffff8000\)
 1c0:	2365 2950 	addu	a1,a1,k1
 1c4:	8765 9000 	sw	k1,0\(a1\)
 1c8:	00bb 8000 	addiu	a1,k1,32768
 1cc:	8765 8000 	lw	k1,0\(a1\)
 1d0:	00bb 8000 	addiu	a1,k1,32768
 1d4:	8765 9000 	sw	k1,0\(a1\)
 1d8:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
 1dc:	2365 2950 	addu	a1,a1,k1
 1e0:	8765 8fff 	lw	k1,4095\(a1\)
 1e4:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
 1e8:	2365 2950 	addu	a1,a1,k1
 1ec:	8765 9fff 	sw	k1,4095\(a1\)
 1f0:	e0a0 0000 	lui	a1,0x0
			1f0: R_NANOMIPS_HI20	symbol
 1f4:	2365 2950 	addu	a1,a1,k1
 1f8:	8765 8000 	lw	k1,0\(a1\)
			1f8: R_NANOMIPS_LO12	symbol
 1fc:	e0a0 0000 	lui	a1,0x0
			1fc: R_NANOMIPS_HI20	symbol
 200:	2365 2950 	addu	a1,a1,k1
 204:	8765 9000 	sw	k1,0\(a1\)
			204: R_NANOMIPS_LO12	symbol
 208:	00db 7fff 	addiu	a2,k1,32767
 20c:	8766 8000 	lw	k1,0\(a2\)
 210:	00db 7fff 	addiu	a2,k1,32767
 214:	8766 9000 	sw	k1,0\(a2\)
 218:	e0df 8ffd 	lui	a2,%hi\(0xffff8000\)
 21c:	2366 3150 	addu	a2,a2,k1
 220:	8766 8000 	lw	k1,0\(a2\)
 224:	e0df 8ffd 	lui	a2,%hi\(0xffff8000\)
 228:	2366 3150 	addu	a2,a2,k1
 22c:	8766 9000 	sw	k1,0\(a2\)
 230:	00db 8000 	addiu	a2,k1,32768
 234:	8766 8000 	lw	k1,0\(a2\)
 238:	00db 8000 	addiu	a2,k1,32768
 23c:	8766 9000 	sw	k1,0\(a2\)
 240:	e0df 7ffd 	lui	a2,%hi\(0xffff7000\)
 244:	2366 3150 	addu	a2,a2,k1
 248:	8766 8fff 	lw	k1,4095\(a2\)
 24c:	e0df 7ffd 	lui	a2,%hi\(0xffff7000\)
 250:	2366 3150 	addu	a2,a2,k1
 254:	8766 9fff 	sw	k1,4095\(a2\)
 258:	e0c0 0000 	lui	a2,0x0
			258: R_NANOMIPS_HI20	symbol
 25c:	2366 3150 	addu	a2,a2,k1
 260:	8766 8000 	lw	k1,0\(a2\)
			260: R_NANOMIPS_LO12	symbol
 264:	e0c0 0000 	lui	a2,0x0
			264: R_NANOMIPS_HI20	symbol
 268:	2366 3150 	addu	a2,a2,k1
 26c:	8766 9000 	sw	k1,0\(a2\)
			26c: R_NANOMIPS_LO12	symbol
 270:	00fb 7fff 	addiu	a3,k1,32767
 274:	8767 8000 	lw	k1,0\(a3\)
 278:	00fb 7fff 	addiu	a3,k1,32767
 27c:	8767 9000 	sw	k1,0\(a3\)
 280:	e0ff 8ffd 	lui	a3,%hi\(0xffff8000\)
 284:	2367 3950 	addu	a3,a3,k1
 288:	8767 8000 	lw	k1,0\(a3\)
 28c:	e0ff 8ffd 	lui	a3,%hi\(0xffff8000\)
 290:	2367 3950 	addu	a3,a3,k1
 294:	8767 9000 	sw	k1,0\(a3\)
 298:	00fb 8000 	addiu	a3,k1,32768
 29c:	8767 8000 	lw	k1,0\(a3\)
 2a0:	00fb 8000 	addiu	a3,k1,32768
 2a4:	8767 9000 	sw	k1,0\(a3\)
 2a8:	e0ff 7ffd 	lui	a3,%hi\(0xffff7000\)
 2ac:	2367 3950 	addu	a3,a3,k1
 2b0:	8767 8fff 	lw	k1,4095\(a3\)
 2b4:	e0ff 7ffd 	lui	a3,%hi\(0xffff7000\)
 2b8:	2367 3950 	addu	a3,a3,k1
 2bc:	8767 9fff 	sw	k1,4095\(a3\)
 2c0:	e0e0 0000 	lui	a3,0x0
			2c0: R_NANOMIPS_HI20	symbol
 2c4:	2367 3950 	addu	a3,a3,k1
 2c8:	8767 8000 	lw	k1,0\(a3\)
			2c8: R_NANOMIPS_LO12	symbol
 2cc:	e0e0 0000 	lui	a3,0x0
			2cc: R_NANOMIPS_HI20	symbol
 2d0:	2367 3950 	addu	a3,a3,k1
 2d4:	8767 9000 	sw	k1,0\(a3\)
			2d4: R_NANOMIPS_LO12	symbol
 2d8:	011b 7fff 	addiu	a4,k1,32767
 2dc:	8768 8000 	lw	k1,0\(a4\)
 2e0:	011b 7fff 	addiu	a4,k1,32767
 2e4:	8768 9000 	sw	k1,0\(a4\)
 2e8:	e11f 8ffd 	lui	a4,%hi\(0xffff8000\)
 2ec:	2368 4150 	addu	a4,a4,k1
 2f0:	8768 8000 	lw	k1,0\(a4\)
 2f4:	e11f 8ffd 	lui	a4,%hi\(0xffff8000\)
 2f8:	2368 4150 	addu	a4,a4,k1
 2fc:	8768 9000 	sw	k1,0\(a4\)
 300:	011b 8000 	addiu	a4,k1,32768
 304:	8768 8000 	lw	k1,0\(a4\)
 308:	011b 8000 	addiu	a4,k1,32768
 30c:	8768 9000 	sw	k1,0\(a4\)
 310:	e11f 7ffd 	lui	a4,%hi\(0xffff7000\)
 314:	2368 4150 	addu	a4,a4,k1
 318:	8768 8fff 	lw	k1,4095\(a4\)
 31c:	e11f 7ffd 	lui	a4,%hi\(0xffff7000\)
 320:	2368 4150 	addu	a4,a4,k1
 324:	8768 9fff 	sw	k1,4095\(a4\)
 328:	e100 0000 	lui	a4,0x0
			328: R_NANOMIPS_HI20	symbol
 32c:	2368 4150 	addu	a4,a4,k1
 330:	8768 8000 	lw	k1,0\(a4\)
			330: R_NANOMIPS_LO12	symbol
 334:	e100 0000 	lui	a4,0x0
			334: R_NANOMIPS_HI20	symbol
 338:	2368 4150 	addu	a4,a4,k1
 33c:	8768 9000 	sw	k1,0\(a4\)
			33c: R_NANOMIPS_LO12	symbol
 340:	013b 7fff 	addiu	a5,k1,32767
 344:	8769 8000 	lw	k1,0\(a5\)
 348:	013b 7fff 	addiu	a5,k1,32767
 34c:	8769 9000 	sw	k1,0\(a5\)
 350:	e13f 8ffd 	lui	a5,%hi\(0xffff8000\)
 354:	2369 4950 	addu	a5,a5,k1
 358:	8769 8000 	lw	k1,0\(a5\)
 35c:	e13f 8ffd 	lui	a5,%hi\(0xffff8000\)
 360:	2369 4950 	addu	a5,a5,k1
 364:	8769 9000 	sw	k1,0\(a5\)
 368:	013b 8000 	addiu	a5,k1,32768
 36c:	8769 8000 	lw	k1,0\(a5\)
 370:	013b 8000 	addiu	a5,k1,32768
 374:	8769 9000 	sw	k1,0\(a5\)
 378:	e13f 7ffd 	lui	a5,%hi\(0xffff7000\)
 37c:	2369 4950 	addu	a5,a5,k1
 380:	8769 8fff 	lw	k1,4095\(a5\)
 384:	e13f 7ffd 	lui	a5,%hi\(0xffff7000\)
 388:	2369 4950 	addu	a5,a5,k1
 38c:	8769 9fff 	sw	k1,4095\(a5\)
 390:	e120 0000 	lui	a5,0x0
			390: R_NANOMIPS_HI20	symbol
 394:	2369 4950 	addu	a5,a5,k1
 398:	8769 8000 	lw	k1,0\(a5\)
			398: R_NANOMIPS_LO12	symbol
 39c:	e120 0000 	lui	a5,0x0
			39c: R_NANOMIPS_HI20	symbol
 3a0:	2369 4950 	addu	a5,a5,k1
 3a4:	8769 9000 	sw	k1,0\(a5\)
			3a4: R_NANOMIPS_LO12	symbol
 3a8:	015b 7fff 	addiu	a6,k1,32767
 3ac:	876a 8000 	lw	k1,0\(a6\)
 3b0:	015b 7fff 	addiu	a6,k1,32767
 3b4:	876a 9000 	sw	k1,0\(a6\)
 3b8:	e15f 8ffd 	lui	a6,%hi\(0xffff8000\)
 3bc:	236a 5150 	addu	a6,a6,k1
 3c0:	876a 8000 	lw	k1,0\(a6\)
 3c4:	e15f 8ffd 	lui	a6,%hi\(0xffff8000\)
 3c8:	236a 5150 	addu	a6,a6,k1
 3cc:	876a 9000 	sw	k1,0\(a6\)
 3d0:	015b 8000 	addiu	a6,k1,32768
 3d4:	876a 8000 	lw	k1,0\(a6\)
 3d8:	015b 8000 	addiu	a6,k1,32768
 3dc:	876a 9000 	sw	k1,0\(a6\)
 3e0:	e15f 7ffd 	lui	a6,%hi\(0xffff7000\)
 3e4:	236a 5150 	addu	a6,a6,k1
 3e8:	876a 8fff 	lw	k1,4095\(a6\)
 3ec:	e15f 7ffd 	lui	a6,%hi\(0xffff7000\)
 3f0:	236a 5150 	addu	a6,a6,k1
 3f4:	876a 9fff 	sw	k1,4095\(a6\)
 3f8:	e140 0000 	lui	a6,0x0
			3f8: R_NANOMIPS_HI20	symbol
 3fc:	236a 5150 	addu	a6,a6,k1
 400:	876a 8000 	lw	k1,0\(a6\)
			400: R_NANOMIPS_LO12	symbol
 404:	e140 0000 	lui	a6,0x0
			404: R_NANOMIPS_HI20	symbol
 408:	236a 5150 	addu	a6,a6,k1
 40c:	876a 9000 	sw	k1,0\(a6\)
			40c: R_NANOMIPS_LO12	symbol
 410:	017b 7fff 	addiu	a7,k1,32767
 414:	876b 8000 	lw	k1,0\(a7\)
 418:	017b 7fff 	addiu	a7,k1,32767
 41c:	876b 9000 	sw	k1,0\(a7\)
 420:	e17f 8ffd 	lui	a7,%hi\(0xffff8000\)
 424:	236b 5950 	addu	a7,a7,k1
 428:	876b 8000 	lw	k1,0\(a7\)
 42c:	e17f 8ffd 	lui	a7,%hi\(0xffff8000\)
 430:	236b 5950 	addu	a7,a7,k1
 434:	876b 9000 	sw	k1,0\(a7\)
 438:	017b 8000 	addiu	a7,k1,32768
 43c:	876b 8000 	lw	k1,0\(a7\)
 440:	017b 8000 	addiu	a7,k1,32768
 444:	876b 9000 	sw	k1,0\(a7\)
 448:	e17f 7ffd 	lui	a7,%hi\(0xffff7000\)
 44c:	236b 5950 	addu	a7,a7,k1
 450:	876b 8fff 	lw	k1,4095\(a7\)
 454:	e17f 7ffd 	lui	a7,%hi\(0xffff7000\)
 458:	236b 5950 	addu	a7,a7,k1
 45c:	876b 9fff 	sw	k1,4095\(a7\)
 460:	e160 0000 	lui	a7,0x0
			460: R_NANOMIPS_HI20	symbol
 464:	236b 5950 	addu	a7,a7,k1
 468:	876b 8000 	lw	k1,0\(a7\)
			468: R_NANOMIPS_LO12	symbol
 46c:	e160 0000 	lui	a7,0x0
			46c: R_NANOMIPS_HI20	symbol
 470:	236b 5950 	addu	a7,a7,k1
 474:	876b 9000 	sw	k1,0\(a7\)
			474: R_NANOMIPS_LO12	symbol
 478:	019b 7fff 	addiu	t0,k1,32767
 47c:	876c 8000 	lw	k1,0\(t0\)
 480:	019b 7fff 	addiu	t0,k1,32767
 484:	876c 9000 	sw	k1,0\(t0\)
 488:	e19f 8ffd 	lui	t0,%hi\(0xffff8000\)
 48c:	236c 6150 	addu	t0,t0,k1
 490:	876c 8000 	lw	k1,0\(t0\)
 494:	e19f 8ffd 	lui	t0,%hi\(0xffff8000\)
 498:	236c 6150 	addu	t0,t0,k1
 49c:	876c 9000 	sw	k1,0\(t0\)
 4a0:	019b 8000 	addiu	t0,k1,32768
 4a4:	876c 8000 	lw	k1,0\(t0\)
 4a8:	019b 8000 	addiu	t0,k1,32768
 4ac:	876c 9000 	sw	k1,0\(t0\)
 4b0:	e19f 7ffd 	lui	t0,%hi\(0xffff7000\)
 4b4:	236c 6150 	addu	t0,t0,k1
 4b8:	876c 8fff 	lw	k1,4095\(t0\)
 4bc:	e19f 7ffd 	lui	t0,%hi\(0xffff7000\)
 4c0:	236c 6150 	addu	t0,t0,k1
 4c4:	876c 9fff 	sw	k1,4095\(t0\)
 4c8:	e180 0000 	lui	t0,0x0
			4c8: R_NANOMIPS_HI20	symbol
 4cc:	236c 6150 	addu	t0,t0,k1
 4d0:	876c 8000 	lw	k1,0\(t0\)
			4d0: R_NANOMIPS_LO12	symbol
 4d4:	e180 0000 	lui	t0,0x0
			4d4: R_NANOMIPS_HI20	symbol
 4d8:	236c 6150 	addu	t0,t0,k1
 4dc:	876c 9000 	sw	k1,0\(t0\)
			4dc: R_NANOMIPS_LO12	symbol
 4e0:	01bb 7fff 	addiu	t1,k1,32767
 4e4:	876d 8000 	lw	k1,0\(t1\)
 4e8:	01bb 7fff 	addiu	t1,k1,32767
 4ec:	876d 9000 	sw	k1,0\(t1\)
 4f0:	e1bf 8ffd 	lui	t1,%hi\(0xffff8000\)
 4f4:	236d 6950 	addu	t1,t1,k1
 4f8:	876d 8000 	lw	k1,0\(t1\)
 4fc:	e1bf 8ffd 	lui	t1,%hi\(0xffff8000\)
 500:	236d 6950 	addu	t1,t1,k1
 504:	876d 9000 	sw	k1,0\(t1\)
 508:	01bb 8000 	addiu	t1,k1,32768
 50c:	876d 8000 	lw	k1,0\(t1\)
 510:	01bb 8000 	addiu	t1,k1,32768
 514:	876d 9000 	sw	k1,0\(t1\)
 518:	e1bf 7ffd 	lui	t1,%hi\(0xffff7000\)
 51c:	236d 6950 	addu	t1,t1,k1
 520:	876d 8fff 	lw	k1,4095\(t1\)
 524:	e1bf 7ffd 	lui	t1,%hi\(0xffff7000\)
 528:	236d 6950 	addu	t1,t1,k1
 52c:	876d 9fff 	sw	k1,4095\(t1\)
 530:	e1a0 0000 	lui	t1,0x0
			530: R_NANOMIPS_HI20	symbol
 534:	236d 6950 	addu	t1,t1,k1
 538:	876d 8000 	lw	k1,0\(t1\)
			538: R_NANOMIPS_LO12	symbol
 53c:	e1a0 0000 	lui	t1,0x0
			53c: R_NANOMIPS_HI20	symbol
 540:	236d 6950 	addu	t1,t1,k1
 544:	876d 9000 	sw	k1,0\(t1\)
			544: R_NANOMIPS_LO12	symbol
 548:	01db 7fff 	addiu	t2,k1,32767
 54c:	876e 8000 	lw	k1,0\(t2\)
 550:	01db 7fff 	addiu	t2,k1,32767
 554:	876e 9000 	sw	k1,0\(t2\)
 558:	e1df 8ffd 	lui	t2,%hi\(0xffff8000\)
 55c:	236e 7150 	addu	t2,t2,k1
 560:	876e 8000 	lw	k1,0\(t2\)
 564:	e1df 8ffd 	lui	t2,%hi\(0xffff8000\)
 568:	236e 7150 	addu	t2,t2,k1
 56c:	876e 9000 	sw	k1,0\(t2\)
 570:	01db 8000 	addiu	t2,k1,32768
 574:	876e 8000 	lw	k1,0\(t2\)
 578:	01db 8000 	addiu	t2,k1,32768
 57c:	876e 9000 	sw	k1,0\(t2\)
 580:	e1df 7ffd 	lui	t2,%hi\(0xffff7000\)
 584:	236e 7150 	addu	t2,t2,k1
 588:	876e 8fff 	lw	k1,4095\(t2\)
 58c:	e1df 7ffd 	lui	t2,%hi\(0xffff7000\)
 590:	236e 7150 	addu	t2,t2,k1
 594:	876e 9fff 	sw	k1,4095\(t2\)
 598:	e1c0 0000 	lui	t2,0x0
			598: R_NANOMIPS_HI20	symbol
 59c:	236e 7150 	addu	t2,t2,k1
 5a0:	876e 8000 	lw	k1,0\(t2\)
			5a0: R_NANOMIPS_LO12	symbol
 5a4:	e1c0 0000 	lui	t2,0x0
			5a4: R_NANOMIPS_HI20	symbol
 5a8:	236e 7150 	addu	t2,t2,k1
 5ac:	876e 9000 	sw	k1,0\(t2\)
			5ac: R_NANOMIPS_LO12	symbol
 5b0:	01fb 7fff 	addiu	t3,k1,32767
 5b4:	876f 8000 	lw	k1,0\(t3\)
 5b8:	01fb 7fff 	addiu	t3,k1,32767
 5bc:	876f 9000 	sw	k1,0\(t3\)
 5c0:	e1ff 8ffd 	lui	t3,%hi\(0xffff8000\)
 5c4:	236f 7950 	addu	t3,t3,k1
 5c8:	876f 8000 	lw	k1,0\(t3\)
 5cc:	e1ff 8ffd 	lui	t3,%hi\(0xffff8000\)
 5d0:	236f 7950 	addu	t3,t3,k1
 5d4:	876f 9000 	sw	k1,0\(t3\)
 5d8:	01fb 8000 	addiu	t3,k1,32768
 5dc:	876f 8000 	lw	k1,0\(t3\)
 5e0:	01fb 8000 	addiu	t3,k1,32768
 5e4:	876f 9000 	sw	k1,0\(t3\)
 5e8:	e1ff 7ffd 	lui	t3,%hi\(0xffff7000\)
 5ec:	236f 7950 	addu	t3,t3,k1
 5f0:	876f 8fff 	lw	k1,4095\(t3\)
 5f4:	e1ff 7ffd 	lui	t3,%hi\(0xffff7000\)
 5f8:	236f 7950 	addu	t3,t3,k1
 5fc:	876f 9fff 	sw	k1,4095\(t3\)
 600:	e1e0 0000 	lui	t3,0x0
			600: R_NANOMIPS_HI20	symbol
 604:	236f 7950 	addu	t3,t3,k1
 608:	876f 8000 	lw	k1,0\(t3\)
			608: R_NANOMIPS_LO12	symbol
 60c:	e1e0 0000 	lui	t3,0x0
			60c: R_NANOMIPS_HI20	symbol
 610:	236f 7950 	addu	t3,t3,k1
 614:	876f 9000 	sw	k1,0\(t3\)
			614: R_NANOMIPS_LO12	symbol
 618:	021b 7fff 	addiu	s0,k1,32767
 61c:	8770 8000 	lw	k1,0\(s0\)
 620:	021b 7fff 	addiu	s0,k1,32767
 624:	8770 9000 	sw	k1,0\(s0\)
 628:	e21f 8ffd 	lui	s0,%hi\(0xffff8000\)
 62c:	2370 8150 	addu	s0,s0,k1
 630:	8770 8000 	lw	k1,0\(s0\)
 634:	e21f 8ffd 	lui	s0,%hi\(0xffff8000\)
 638:	2370 8150 	addu	s0,s0,k1
 63c:	8770 9000 	sw	k1,0\(s0\)
 640:	021b 8000 	addiu	s0,k1,32768
 644:	8770 8000 	lw	k1,0\(s0\)
 648:	021b 8000 	addiu	s0,k1,32768
 64c:	8770 9000 	sw	k1,0\(s0\)
 650:	e21f 7ffd 	lui	s0,%hi\(0xffff7000\)
 654:	2370 8150 	addu	s0,s0,k1
 658:	8770 8fff 	lw	k1,4095\(s0\)
 65c:	e21f 7ffd 	lui	s0,%hi\(0xffff7000\)
 660:	2370 8150 	addu	s0,s0,k1
 664:	8770 9fff 	sw	k1,4095\(s0\)
 668:	e200 0000 	lui	s0,0x0
			668: R_NANOMIPS_HI20	symbol
 66c:	2370 8150 	addu	s0,s0,k1
 670:	8770 8000 	lw	k1,0\(s0\)
			670: R_NANOMIPS_LO12	symbol
 674:	e200 0000 	lui	s0,0x0
			674: R_NANOMIPS_HI20	symbol
 678:	2370 8150 	addu	s0,s0,k1
 67c:	8770 9000 	sw	k1,0\(s0\)
			67c: R_NANOMIPS_LO12	symbol
 680:	023b 7fff 	addiu	s1,k1,32767
 684:	8771 8000 	lw	k1,0\(s1\)
 688:	023b 7fff 	addiu	s1,k1,32767
 68c:	8771 9000 	sw	k1,0\(s1\)
 690:	e23f 8ffd 	lui	s1,%hi\(0xffff8000\)
 694:	2371 8950 	addu	s1,s1,k1
 698:	8771 8000 	lw	k1,0\(s1\)
 69c:	e23f 8ffd 	lui	s1,%hi\(0xffff8000\)
 6a0:	2371 8950 	addu	s1,s1,k1
 6a4:	8771 9000 	sw	k1,0\(s1\)
 6a8:	023b 8000 	addiu	s1,k1,32768
 6ac:	8771 8000 	lw	k1,0\(s1\)
 6b0:	023b 8000 	addiu	s1,k1,32768
 6b4:	8771 9000 	sw	k1,0\(s1\)
 6b8:	e23f 7ffd 	lui	s1,%hi\(0xffff7000\)
 6bc:	2371 8950 	addu	s1,s1,k1
 6c0:	8771 8fff 	lw	k1,4095\(s1\)
 6c4:	e23f 7ffd 	lui	s1,%hi\(0xffff7000\)
 6c8:	2371 8950 	addu	s1,s1,k1
 6cc:	8771 9fff 	sw	k1,4095\(s1\)
 6d0:	e220 0000 	lui	s1,0x0
			6d0: R_NANOMIPS_HI20	symbol
 6d4:	2371 8950 	addu	s1,s1,k1
 6d8:	8771 8000 	lw	k1,0\(s1\)
			6d8: R_NANOMIPS_LO12	symbol
 6dc:	e220 0000 	lui	s1,0x0
			6dc: R_NANOMIPS_HI20	symbol
 6e0:	2371 8950 	addu	s1,s1,k1
 6e4:	8771 9000 	sw	k1,0\(s1\)
			6e4: R_NANOMIPS_LO12	symbol
 6e8:	025b 7fff 	addiu	s2,k1,32767
 6ec:	8772 8000 	lw	k1,0\(s2\)
 6f0:	025b 7fff 	addiu	s2,k1,32767
 6f4:	8772 9000 	sw	k1,0\(s2\)
 6f8:	e25f 8ffd 	lui	s2,%hi\(0xffff8000\)
 6fc:	2372 9150 	addu	s2,s2,k1
 700:	8772 8000 	lw	k1,0\(s2\)
 704:	e25f 8ffd 	lui	s2,%hi\(0xffff8000\)
 708:	2372 9150 	addu	s2,s2,k1
 70c:	8772 9000 	sw	k1,0\(s2\)
 710:	025b 8000 	addiu	s2,k1,32768
 714:	8772 8000 	lw	k1,0\(s2\)
 718:	025b 8000 	addiu	s2,k1,32768
 71c:	8772 9000 	sw	k1,0\(s2\)
 720:	e25f 7ffd 	lui	s2,%hi\(0xffff7000\)
 724:	2372 9150 	addu	s2,s2,k1
 728:	8772 8fff 	lw	k1,4095\(s2\)
 72c:	e25f 7ffd 	lui	s2,%hi\(0xffff7000\)
 730:	2372 9150 	addu	s2,s2,k1
 734:	8772 9fff 	sw	k1,4095\(s2\)
 738:	e240 0000 	lui	s2,0x0
			738: R_NANOMIPS_HI20	symbol
 73c:	2372 9150 	addu	s2,s2,k1
 740:	8772 8000 	lw	k1,0\(s2\)
			740: R_NANOMIPS_LO12	symbol
 744:	e240 0000 	lui	s2,0x0
			744: R_NANOMIPS_HI20	symbol
 748:	2372 9150 	addu	s2,s2,k1
 74c:	8772 9000 	sw	k1,0\(s2\)
			74c: R_NANOMIPS_LO12	symbol
 750:	027b 7fff 	addiu	s3,k1,32767
 754:	8773 8000 	lw	k1,0\(s3\)
 758:	027b 7fff 	addiu	s3,k1,32767
 75c:	8773 9000 	sw	k1,0\(s3\)
 760:	e27f 8ffd 	lui	s3,%hi\(0xffff8000\)
 764:	2373 9950 	addu	s3,s3,k1
 768:	8773 8000 	lw	k1,0\(s3\)
 76c:	e27f 8ffd 	lui	s3,%hi\(0xffff8000\)
 770:	2373 9950 	addu	s3,s3,k1
 774:	8773 9000 	sw	k1,0\(s3\)
 778:	027b 8000 	addiu	s3,k1,32768
 77c:	8773 8000 	lw	k1,0\(s3\)
 780:	027b 8000 	addiu	s3,k1,32768
 784:	8773 9000 	sw	k1,0\(s3\)
 788:	e27f 7ffd 	lui	s3,%hi\(0xffff7000\)
 78c:	2373 9950 	addu	s3,s3,k1
 790:	8773 8fff 	lw	k1,4095\(s3\)
 794:	e27f 7ffd 	lui	s3,%hi\(0xffff7000\)
 798:	2373 9950 	addu	s3,s3,k1
 79c:	8773 9fff 	sw	k1,4095\(s3\)
 7a0:	e260 0000 	lui	s3,0x0
			7a0: R_NANOMIPS_HI20	symbol
 7a4:	2373 9950 	addu	s3,s3,k1
 7a8:	8773 8000 	lw	k1,0\(s3\)
			7a8: R_NANOMIPS_LO12	symbol
 7ac:	e260 0000 	lui	s3,0x0
			7ac: R_NANOMIPS_HI20	symbol
 7b0:	2373 9950 	addu	s3,s3,k1
 7b4:	8773 9000 	sw	k1,0\(s3\)
			7b4: R_NANOMIPS_LO12	symbol
 7b8:	029b 7fff 	addiu	s4,k1,32767
 7bc:	8774 8000 	lw	k1,0\(s4\)
 7c0:	029b 7fff 	addiu	s4,k1,32767
 7c4:	8774 9000 	sw	k1,0\(s4\)
 7c8:	e29f 8ffd 	lui	s4,%hi\(0xffff8000\)
 7cc:	2374 a150 	addu	s4,s4,k1
 7d0:	8774 8000 	lw	k1,0\(s4\)
 7d4:	e29f 8ffd 	lui	s4,%hi\(0xffff8000\)
 7d8:	2374 a150 	addu	s4,s4,k1
 7dc:	8774 9000 	sw	k1,0\(s4\)
 7e0:	029b 8000 	addiu	s4,k1,32768
 7e4:	8774 8000 	lw	k1,0\(s4\)
 7e8:	029b 8000 	addiu	s4,k1,32768
 7ec:	8774 9000 	sw	k1,0\(s4\)
 7f0:	e29f 7ffd 	lui	s4,%hi\(0xffff7000\)
 7f4:	2374 a150 	addu	s4,s4,k1
 7f8:	8774 8fff 	lw	k1,4095\(s4\)
 7fc:	e29f 7ffd 	lui	s4,%hi\(0xffff7000\)
 800:	2374 a150 	addu	s4,s4,k1
 804:	8774 9fff 	sw	k1,4095\(s4\)
 808:	e280 0000 	lui	s4,0x0
			808: R_NANOMIPS_HI20	symbol
 80c:	2374 a150 	addu	s4,s4,k1
 810:	8774 8000 	lw	k1,0\(s4\)
			810: R_NANOMIPS_LO12	symbol
 814:	e280 0000 	lui	s4,0x0
			814: R_NANOMIPS_HI20	symbol
 818:	2374 a150 	addu	s4,s4,k1
 81c:	8774 9000 	sw	k1,0\(s4\)
			81c: R_NANOMIPS_LO12	symbol
 820:	02bb 7fff 	addiu	s5,k1,32767
 824:	8775 8000 	lw	k1,0\(s5\)
 828:	02bb 7fff 	addiu	s5,k1,32767
 82c:	8775 9000 	sw	k1,0\(s5\)
 830:	e2bf 8ffd 	lui	s5,%hi\(0xffff8000\)
 834:	2375 a950 	addu	s5,s5,k1
 838:	8775 8000 	lw	k1,0\(s5\)
 83c:	e2bf 8ffd 	lui	s5,%hi\(0xffff8000\)
 840:	2375 a950 	addu	s5,s5,k1
 844:	8775 9000 	sw	k1,0\(s5\)
 848:	02bb 8000 	addiu	s5,k1,32768
 84c:	8775 8000 	lw	k1,0\(s5\)
 850:	02bb 8000 	addiu	s5,k1,32768
 854:	8775 9000 	sw	k1,0\(s5\)
 858:	e2bf 7ffd 	lui	s5,%hi\(0xffff7000\)
 85c:	2375 a950 	addu	s5,s5,k1
 860:	8775 8fff 	lw	k1,4095\(s5\)
 864:	e2bf 7ffd 	lui	s5,%hi\(0xffff7000\)
 868:	2375 a950 	addu	s5,s5,k1
 86c:	8775 9fff 	sw	k1,4095\(s5\)
 870:	e2a0 0000 	lui	s5,0x0
			870: R_NANOMIPS_HI20	symbol
 874:	2375 a950 	addu	s5,s5,k1
 878:	8775 8000 	lw	k1,0\(s5\)
			878: R_NANOMIPS_LO12	symbol
 87c:	e2a0 0000 	lui	s5,0x0
			87c: R_NANOMIPS_HI20	symbol
 880:	2375 a950 	addu	s5,s5,k1
 884:	8775 9000 	sw	k1,0\(s5\)
			884: R_NANOMIPS_LO12	symbol
 888:	02db 7fff 	addiu	s6,k1,32767
 88c:	8776 8000 	lw	k1,0\(s6\)
 890:	02db 7fff 	addiu	s6,k1,32767
 894:	8776 9000 	sw	k1,0\(s6\)
 898:	e2df 8ffd 	lui	s6,%hi\(0xffff8000\)
 89c:	2376 b150 	addu	s6,s6,k1
 8a0:	8776 8000 	lw	k1,0\(s6\)
 8a4:	e2df 8ffd 	lui	s6,%hi\(0xffff8000\)
 8a8:	2376 b150 	addu	s6,s6,k1
 8ac:	8776 9000 	sw	k1,0\(s6\)
 8b0:	02db 8000 	addiu	s6,k1,32768
 8b4:	8776 8000 	lw	k1,0\(s6\)
 8b8:	02db 8000 	addiu	s6,k1,32768
 8bc:	8776 9000 	sw	k1,0\(s6\)
 8c0:	e2df 7ffd 	lui	s6,%hi\(0xffff7000\)
 8c4:	2376 b150 	addu	s6,s6,k1
 8c8:	8776 8fff 	lw	k1,4095\(s6\)
 8cc:	e2df 7ffd 	lui	s6,%hi\(0xffff7000\)
 8d0:	2376 b150 	addu	s6,s6,k1
 8d4:	8776 9fff 	sw	k1,4095\(s6\)
 8d8:	e2c0 0000 	lui	s6,0x0
			8d8: R_NANOMIPS_HI20	symbol
 8dc:	2376 b150 	addu	s6,s6,k1
 8e0:	8776 8000 	lw	k1,0\(s6\)
			8e0: R_NANOMIPS_LO12	symbol
 8e4:	e2c0 0000 	lui	s6,0x0
			8e4: R_NANOMIPS_HI20	symbol
 8e8:	2376 b150 	addu	s6,s6,k1
 8ec:	8776 9000 	sw	k1,0\(s6\)
			8ec: R_NANOMIPS_LO12	symbol
 8f0:	02fb 7fff 	addiu	s7,k1,32767
 8f4:	8777 8000 	lw	k1,0\(s7\)
 8f8:	02fb 7fff 	addiu	s7,k1,32767
 8fc:	8777 9000 	sw	k1,0\(s7\)
 900:	e2ff 8ffd 	lui	s7,%hi\(0xffff8000\)
 904:	2377 b950 	addu	s7,s7,k1
 908:	8777 8000 	lw	k1,0\(s7\)
 90c:	e2ff 8ffd 	lui	s7,%hi\(0xffff8000\)
 910:	2377 b950 	addu	s7,s7,k1
 914:	8777 9000 	sw	k1,0\(s7\)
 918:	02fb 8000 	addiu	s7,k1,32768
 91c:	8777 8000 	lw	k1,0\(s7\)
 920:	02fb 8000 	addiu	s7,k1,32768
 924:	8777 9000 	sw	k1,0\(s7\)
 928:	e2ff 7ffd 	lui	s7,%hi\(0xffff7000\)
 92c:	2377 b950 	addu	s7,s7,k1
 930:	8777 8fff 	lw	k1,4095\(s7\)
 934:	e2ff 7ffd 	lui	s7,%hi\(0xffff7000\)
 938:	2377 b950 	addu	s7,s7,k1
 93c:	8777 9fff 	sw	k1,4095\(s7\)
 940:	e2e0 0000 	lui	s7,0x0
			940: R_NANOMIPS_HI20	symbol
 944:	2377 b950 	addu	s7,s7,k1
 948:	8777 8000 	lw	k1,0\(s7\)
			948: R_NANOMIPS_LO12	symbol
 94c:	e2e0 0000 	lui	s7,0x0
			94c: R_NANOMIPS_HI20	symbol
 950:	2377 b950 	addu	s7,s7,k1
 954:	8777 9000 	sw	k1,0\(s7\)
			954: R_NANOMIPS_LO12	symbol
 958:	031b 7fff 	addiu	t8,k1,32767
 95c:	8778 8000 	lw	k1,0\(t8\)
 960:	031b 7fff 	addiu	t8,k1,32767
 964:	8778 9000 	sw	k1,0\(t8\)
 968:	e31f 8ffd 	lui	t8,%hi\(0xffff8000\)
 96c:	2378 c150 	addu	t8,t8,k1
 970:	8778 8000 	lw	k1,0\(t8\)
 974:	e31f 8ffd 	lui	t8,%hi\(0xffff8000\)
 978:	2378 c150 	addu	t8,t8,k1
 97c:	8778 9000 	sw	k1,0\(t8\)
 980:	031b 8000 	addiu	t8,k1,32768
 984:	8778 8000 	lw	k1,0\(t8\)
 988:	031b 8000 	addiu	t8,k1,32768
 98c:	8778 9000 	sw	k1,0\(t8\)
 990:	e31f 7ffd 	lui	t8,%hi\(0xffff7000\)
 994:	2378 c150 	addu	t8,t8,k1
 998:	8778 8fff 	lw	k1,4095\(t8\)
 99c:	e31f 7ffd 	lui	t8,%hi\(0xffff7000\)
 9a0:	2378 c150 	addu	t8,t8,k1
 9a4:	8778 9fff 	sw	k1,4095\(t8\)
 9a8:	e300 0000 	lui	t8,0x0
			9a8: R_NANOMIPS_HI20	symbol
 9ac:	2378 c150 	addu	t8,t8,k1
 9b0:	8778 8000 	lw	k1,0\(t8\)
			9b0: R_NANOMIPS_LO12	symbol
 9b4:	e300 0000 	lui	t8,0x0
			9b4: R_NANOMIPS_HI20	symbol
 9b8:	2378 c150 	addu	t8,t8,k1
 9bc:	8778 9000 	sw	k1,0\(t8\)
			9bc: R_NANOMIPS_LO12	symbol
 9c0:	033b 7fff 	addiu	t9,k1,32767
 9c4:	8779 8000 	lw	k1,0\(t9\)
 9c8:	033b 7fff 	addiu	t9,k1,32767
 9cc:	8779 9000 	sw	k1,0\(t9\)
 9d0:	e33f 8ffd 	lui	t9,%hi\(0xffff8000\)
 9d4:	2379 c950 	addu	t9,t9,k1
 9d8:	8779 8000 	lw	k1,0\(t9\)
 9dc:	e33f 8ffd 	lui	t9,%hi\(0xffff8000\)
 9e0:	2379 c950 	addu	t9,t9,k1
 9e4:	8779 9000 	sw	k1,0\(t9\)
 9e8:	033b 8000 	addiu	t9,k1,32768
 9ec:	8779 8000 	lw	k1,0\(t9\)
 9f0:	033b 8000 	addiu	t9,k1,32768
 9f4:	8779 9000 	sw	k1,0\(t9\)
 9f8:	e33f 7ffd 	lui	t9,%hi\(0xffff7000\)
 9fc:	2379 c950 	addu	t9,t9,k1
 a00:	8779 8fff 	lw	k1,4095\(t9\)
 a04:	e33f 7ffd 	lui	t9,%hi\(0xffff7000\)
 a08:	2379 c950 	addu	t9,t9,k1
 a0c:	8779 9fff 	sw	k1,4095\(t9\)
 a10:	e320 0000 	lui	t9,0x0
			a10: R_NANOMIPS_HI20	symbol
 a14:	2379 c950 	addu	t9,t9,k1
 a18:	8779 8000 	lw	k1,0\(t9\)
			a18: R_NANOMIPS_LO12	symbol
 a1c:	e320 0000 	lui	t9,0x0
			a1c: R_NANOMIPS_HI20	symbol
 a20:	2379 c950 	addu	t9,t9,k1
 a24:	8779 9000 	sw	k1,0\(t9\)
			a24: R_NANOMIPS_LO12	symbol
 a28:	035b 7fff 	addiu	k0,k1,32767
 a2c:	877a 8000 	lw	k1,0\(k0\)
 a30:	035b 7fff 	addiu	k0,k1,32767
 a34:	877a 9000 	sw	k1,0\(k0\)
 a38:	e35f 8ffd 	lui	k0,%hi\(0xffff8000\)
 a3c:	237a d150 	addu	k0,k0,k1
 a40:	877a 8000 	lw	k1,0\(k0\)
 a44:	e35f 8ffd 	lui	k0,%hi\(0xffff8000\)
 a48:	237a d150 	addu	k0,k0,k1
 a4c:	877a 9000 	sw	k1,0\(k0\)
 a50:	035b 8000 	addiu	k0,k1,32768
 a54:	877a 8000 	lw	k1,0\(k0\)
 a58:	035b 8000 	addiu	k0,k1,32768
 a5c:	877a 9000 	sw	k1,0\(k0\)
 a60:	e35f 7ffd 	lui	k0,%hi\(0xffff7000\)
 a64:	237a d150 	addu	k0,k0,k1
 a68:	877a 8fff 	lw	k1,4095\(k0\)
 a6c:	e35f 7ffd 	lui	k0,%hi\(0xffff7000\)
 a70:	237a d150 	addu	k0,k0,k1
 a74:	877a 9fff 	sw	k1,4095\(k0\)
 a78:	e340 0000 	lui	k0,0x0
			a78: R_NANOMIPS_HI20	symbol
 a7c:	237a d150 	addu	k0,k0,k1
 a80:	877a 8000 	lw	k1,0\(k0\)
			a80: R_NANOMIPS_LO12	symbol
 a84:	e340 0000 	lui	k0,0x0
			a84: R_NANOMIPS_HI20	symbol
 a88:	237a d150 	addu	k0,k0,k1
 a8c:	877a 9000 	sw	k1,0\(k0\)
			a8c: R_NANOMIPS_LO12	symbol
 a90:	037a 7fff 	addiu	k1,k0,32767
 a94:	875b 8000 	lw	k0,0\(k1\)
 a98:	037a 7fff 	addiu	k1,k0,32767
 a9c:	875b 9000 	sw	k0,0\(k1\)
 aa0:	e37f 8ffd 	lui	k1,%hi\(0xffff8000\)
 aa4:	235b d950 	addu	k1,k1,k0
 aa8:	875b 8000 	lw	k0,0\(k1\)
 aac:	e37f 8ffd 	lui	k1,%hi\(0xffff8000\)
 ab0:	235b d950 	addu	k1,k1,k0
 ab4:	875b 9000 	sw	k0,0\(k1\)
 ab8:	037a 8000 	addiu	k1,k0,32768
 abc:	875b 8000 	lw	k0,0\(k1\)
 ac0:	037a 8000 	addiu	k1,k0,32768
 ac4:	875b 9000 	sw	k0,0\(k1\)
 ac8:	e37f 7ffd 	lui	k1,%hi\(0xffff7000\)
 acc:	235b d950 	addu	k1,k1,k0
 ad0:	875b 8fff 	lw	k0,4095\(k1\)
 ad4:	e37f 7ffd 	lui	k1,%hi\(0xffff7000\)
 ad8:	235b d950 	addu	k1,k1,k0
 adc:	875b 9fff 	sw	k0,4095\(k1\)
 ae0:	e360 0000 	lui	k1,0x0
			ae0: R_NANOMIPS_HI20	symbol
 ae4:	235b d950 	addu	k1,k1,k0
 ae8:	875b 8000 	lw	k0,0\(k1\)
			ae8: R_NANOMIPS_LO12	symbol
 aec:	e360 0000 	lui	k1,0x0
			aec: R_NANOMIPS_HI20	symbol
 af0:	235b d950 	addu	k1,k1,k0
 af4:	875b 9000 	sw	k0,0\(k1\)
			af4: R_NANOMIPS_LO12	symbol
 af8:	039b 7fff 	addiu	gp,k1,32767
 afc:	877c 8000 	lw	k1,0\(gp\)
 b00:	039b 7fff 	addiu	gp,k1,32767
 b04:	877c 9000 	sw	k1,0\(gp\)
 b08:	e39f 8ffd 	lui	gp,%hi\(0xffff8000\)
 b0c:	237c e150 	addu	gp,gp,k1
 b10:	877c 8000 	lw	k1,0\(gp\)
 b14:	e39f 8ffd 	lui	gp,%hi\(0xffff8000\)
 b18:	237c e150 	addu	gp,gp,k1
 b1c:	877c 9000 	sw	k1,0\(gp\)
 b20:	039b 8000 	addiu	gp,k1,32768
 b24:	877c 8000 	lw	k1,0\(gp\)
 b28:	039b 8000 	addiu	gp,k1,32768
 b2c:	877c 9000 	sw	k1,0\(gp\)
 b30:	e39f 7ffd 	lui	gp,%hi\(0xffff7000\)
 b34:	237c e150 	addu	gp,gp,k1
 b38:	877c 8fff 	lw	k1,4095\(gp\)
 b3c:	e39f 7ffd 	lui	gp,%hi\(0xffff7000\)
 b40:	237c e150 	addu	gp,gp,k1
 b44:	877c 9fff 	sw	k1,4095\(gp\)
 b48:	e380 0000 	lui	gp,0x0
			b48: R_NANOMIPS_HI20	symbol
 b4c:	237c e150 	addu	gp,gp,k1
 b50:	877c 8000 	lw	k1,0\(gp\)
			b50: R_NANOMIPS_LO12	symbol
 b54:	e380 0000 	lui	gp,0x0
			b54: R_NANOMIPS_HI20	symbol
 b58:	237c e150 	addu	gp,gp,k1
 b5c:	877c 9000 	sw	k1,0\(gp\)
			b5c: R_NANOMIPS_LO12	symbol
 b60:	03db 7fff 	addiu	fp,k1,32767
 b64:	877e 8000 	lw	k1,0\(fp\)
 b68:	03db 7fff 	addiu	fp,k1,32767
 b6c:	877e 9000 	sw	k1,0\(fp\)
 b70:	e3df 8ffd 	lui	fp,%hi\(0xffff8000\)
 b74:	237e f150 	addu	fp,fp,k1
 b78:	877e 8000 	lw	k1,0\(fp\)
 b7c:	e3df 8ffd 	lui	fp,%hi\(0xffff8000\)
 b80:	237e f150 	addu	fp,fp,k1
 b84:	877e 9000 	sw	k1,0\(fp\)
 b88:	03db 8000 	addiu	fp,k1,32768
 b8c:	877e 8000 	lw	k1,0\(fp\)
 b90:	03db 8000 	addiu	fp,k1,32768
 b94:	877e 9000 	sw	k1,0\(fp\)
 b98:	e3df 7ffd 	lui	fp,%hi\(0xffff7000\)
 b9c:	237e f150 	addu	fp,fp,k1
 ba0:	877e 8fff 	lw	k1,4095\(fp\)
 ba4:	e3df 7ffd 	lui	fp,%hi\(0xffff7000\)
 ba8:	237e f150 	addu	fp,fp,k1
 bac:	877e 9fff 	sw	k1,4095\(fp\)
 bb0:	e3c0 0000 	lui	fp,0x0
			bb0: R_NANOMIPS_HI20	symbol
 bb4:	237e f150 	addu	fp,fp,k1
 bb8:	877e 8000 	lw	k1,0\(fp\)
			bb8: R_NANOMIPS_LO12	symbol
 bbc:	e3c0 0000 	lui	fp,0x0
			bbc: R_NANOMIPS_HI20	symbol
 bc0:	237e f150 	addu	fp,fp,k1
 bc4:	877e 9000 	sw	k1,0\(fp\)
			bc4: R_NANOMIPS_LO12	symbol
 bc8:	03bb 7fff 	addiu	sp,k1,32767
 bcc:	877d 8000 	lw	k1,0\(sp\)
 bd0:	03bb 7fff 	addiu	sp,k1,32767
 bd4:	877d 9000 	sw	k1,0\(sp\)
 bd8:	e3bf 8ffd 	lui	sp,%hi\(0xffff8000\)
 bdc:	237d e950 	addu	sp,sp,k1
 be0:	877d 8000 	lw	k1,0\(sp\)
 be4:	e3bf 8ffd 	lui	sp,%hi\(0xffff8000\)
 be8:	237d e950 	addu	sp,sp,k1
 bec:	877d 9000 	sw	k1,0\(sp\)
 bf0:	03bb 8000 	addiu	sp,k1,32768
 bf4:	877d 8000 	lw	k1,0\(sp\)
 bf8:	03bb 8000 	addiu	sp,k1,32768
 bfc:	877d 9000 	sw	k1,0\(sp\)
 c00:	e3bf 7ffd 	lui	sp,%hi\(0xffff7000\)
 c04:	237d e950 	addu	sp,sp,k1
 c08:	877d 8fff 	lw	k1,4095\(sp\)
 c0c:	e3bf 7ffd 	lui	sp,%hi\(0xffff7000\)
 c10:	237d e950 	addu	sp,sp,k1
 c14:	877d 9fff 	sw	k1,4095\(sp\)
 c18:	e3a0 0000 	lui	sp,0x0
			c18: R_NANOMIPS_HI20	symbol
 c1c:	237d e950 	addu	sp,sp,k1
 c20:	877d 8000 	lw	k1,0\(sp\)
			c20: R_NANOMIPS_LO12	symbol
 c24:	e3a0 0000 	lui	sp,0x0
			c24: R_NANOMIPS_HI20	symbol
 c28:	237d e950 	addu	sp,sp,k1
 c2c:	877d 9000 	sw	k1,0\(sp\)
			c2c: R_NANOMIPS_LO12	symbol
 c30:	03fb 7fff 	addiu	ra,k1,32767
 c34:	877f 8000 	lw	k1,0\(ra\)
 c38:	03fb 7fff 	addiu	ra,k1,32767
 c3c:	877f 9000 	sw	k1,0\(ra\)
 c40:	e3ff 8ffd 	lui	ra,%hi\(0xffff8000\)
 c44:	237f f950 	addu	ra,ra,k1
 c48:	877f 8000 	lw	k1,0\(ra\)
 c4c:	e3ff 8ffd 	lui	ra,%hi\(0xffff8000\)
 c50:	237f f950 	addu	ra,ra,k1
 c54:	877f 9000 	sw	k1,0\(ra\)
 c58:	03fb 8000 	addiu	ra,k1,32768
 c5c:	877f 8000 	lw	k1,0\(ra\)
 c60:	03fb 8000 	addiu	ra,k1,32768
 c64:	877f 9000 	sw	k1,0\(ra\)
 c68:	e3ff 7ffd 	lui	ra,%hi\(0xffff7000\)
 c6c:	237f f950 	addu	ra,ra,k1
 c70:	877f 8fff 	lw	k1,4095\(ra\)
 c74:	e3ff 7ffd 	lui	ra,%hi\(0xffff7000\)
 c78:	237f f950 	addu	ra,ra,k1
 c7c:	877f 9fff 	sw	k1,4095\(ra\)
 c80:	e3e0 0000 	lui	ra,0x0
			c80: R_NANOMIPS_HI20	symbol
 c84:	237f f950 	addu	ra,ra,k1
 c88:	877f 8000 	lw	k1,0\(ra\)
			c88: R_NANOMIPS_LO12	symbol
 c8c:	e3e0 0000 	lui	ra,0x0
			c8c: R_NANOMIPS_HI20	symbol
 c90:	237f f950 	addu	ra,ra,k1
 c94:	877f 9000 	sw	k1,0\(ra\)
			c94: R_NANOMIPS_LO12	symbol
 c98:	003b 7fff 	addiu	at,k1,32767
 c9c:	8761 8000 	lw	k1,0\(at\)
 ca0:	003b 7fff 	addiu	at,k1,32767
 ca4:	8761 9000 	sw	k1,0\(at\)
 ca8:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
 cac:	2361 0950 	addu	at,at,k1
 cb0:	8761 8000 	lw	k1,0\(at\)
 cb4:	e03f 8ffd 	lui	at,%hi\(0xffff8000\)
 cb8:	2361 0950 	addu	at,at,k1
 cbc:	8761 9000 	sw	k1,0\(at\)
 cc0:	003b 8000 	addiu	at,k1,32768
 cc4:	8761 8000 	lw	k1,0\(at\)
 cc8:	003b 8000 	addiu	at,k1,32768
 ccc:	8761 9000 	sw	k1,0\(at\)
 cd0:	e03f 7ffd 	lui	at,%hi\(0xffff7000\)
 cd4:	2361 0950 	addu	at,at,k1
 cd8:	8761 8fff 	lw	k1,4095\(at\)
 cdc:	e03f 7ffd 	lui	at,%hi\(0xffff7000\)
 ce0:	2361 0950 	addu	at,at,k1
 ce4:	8761 9fff 	sw	k1,4095\(at\)
 ce8:	e020 0000 	lui	at,0x0
			ce8: R_NANOMIPS_HI20	symbol
 cec:	2361 0950 	addu	at,at,k1
 cf0:	8761 8000 	lw	k1,0\(at\)
			cf0: R_NANOMIPS_LO12	symbol
 cf4:	e020 0000 	lui	at,0x0
			cf4: R_NANOMIPS_HI20	symbol
 cf8:	2361 0950 	addu	at,at,k1
 cfc:	8761 9000 	sw	k1,0\(at\)
			cfc: R_NANOMIPS_LO12	symbol
	\.\.\.
