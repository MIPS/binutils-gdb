.module fp=xx
.module doublefloat
.module hardfloat

add.s $f1,$f1,$f1
.set push
.set fp=32
add.s $f1,$f1,$f1
.set pop

.set push
.set fp=64
add.s $f1,$f1,$f1
.set pop
