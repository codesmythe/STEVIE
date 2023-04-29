#
# Makefile for the Atari ST - gcc Compiler
#

CFLAGS = -O2 -fomit-frame-pointer
CC = m68k-atari-mint-gcc-4.6.4
STRIP = m68k-atari-mint-strip
ODIR = obj
OUT=stevie.ttp
SDIR = .

$(ODIR)/%.o: $(SDIR)/%.c 
	$(CC) $(CFLAGS) -g -c -o $@ $<

MACH=	tos.o

_OBJ=	main.o edit.o linefunc.o normal.o cmdline.o hexchars.o \
	misccmds.o help.o ptrfunc.o search.o alloc.o \
	mark.o screen.o fileio.o param.o \
	regexp.o regsub.o $(MACH)
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all : stevie.ttp

#CRT0=/opt/cross-mint/lib/gcc/m68k-atari-mint/4.6.4/../../../../m68k-atari-mint/lib/crt0.o 
CRT0=/opt/cross-mint/m68k-atari-mint/sys-root/usr/lib/crt0.o

#LD_FLAGS=-L/opt/cross-mint/lib/gcc/m68k-atari-mint/4.6.4 -L/opt/cross-mint/lib/gcc/m68k-atari-mint/4.6.4/../../../../m68k-atari-mint/lib
LD_FLAGS=-L/opt/cross-mint/lib/gcc/m68k-atari-mint/4.6.4

$(OUT) : $(OBJ)
	m68k-atari-mint-as font.s -o obj/font.o
	m68k-atari-mint-ld -g -Map stevie.map -o stevie.ttp $(CRT0) $(OBJ) $(ODIR)/font.o $(LD_FLAGS) -lgcc -lc -lgcc
	m68k-atari-mint-objdump --line-numbers --disassemble --source stevie.ttp > stevie.lst
	m68k-atari-mint-strip stevie.ttp

clean :
	$(RM) $(ODIR)/*.o  $(OUT) stevie.lst stevie.map

