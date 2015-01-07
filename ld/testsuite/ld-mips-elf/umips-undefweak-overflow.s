# relocs against undefined weak symbols should not be treated as
# overflowing


      .globl  start
      .weak   foo
start:
       .set mips32r6
       .set micromips
       beqzc   $2, foo
       bnezc   $2, foo
       bc      foo
