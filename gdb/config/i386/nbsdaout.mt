# Target: Intel 386 running NetBSD
TDEPFILES= i386-tdep.o i387-tdep.o i386bsd-tdep.o i386nbsd-tdep.o corelow.o \
	nbsd-tdep.o
TM_FILE= tm-nbsdaout.h
