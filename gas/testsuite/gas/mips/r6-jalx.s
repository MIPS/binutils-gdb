# Tests the new 'jalx' expansions introduced in release 6

  .text

  .set micromips
L1:
  jalx Urfar
  jalx Mrfar

  j Urfar
  j Mrfar

  .set nomicromips
L2:
  jalx Urfar
  jalx Mrfar

  j Urfar
  j Mrfar


  .skip 0x4000000
  .set micromips
Urfar:
  nop

  .set nomicromips
  .align 3
Mrfar:
  nop
