# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem97
#
# Para compilar ingrese make <ejemplo>
#
# Ej 1: make pong
# Ej 2: make game
# Ej 3: make ball
#
# No hay mas por ahora
#
# Para Linux/amd64:
# instale previamente como root: apt-get install libncurses5-dev
# y luego use estos flags (curses estandar tiene bugs en linux):
#
CFLAGS= -ggdb -I$(NSYSTEM)/include -I/usr/include/ncurses -DNCURSES -DNODELAY
LFLAGS= -ggdb
#
# CFLAGS= -O2 -I$(NSYSTEM)/include -I/usr/include/ncurses -DNCURSES -DNODELAY
# LFLAGS=
LIBS= $(LIBNSYS) -lncurses -ltermcap -lm
# LIBS= $(LIBNSYS) -lncurses -lm

# Para Linux/x86
# instale previamente como root: apt-get install libncurses5-dev
# y luego use estos flags (curses estandar tiene bugs en linux):
#
# CFLAGS= -ggdb -m32 -I$(NSYSTEM)/include -I/usr/include/ncurses -DNCURSES -DNODELAY
# LFLAGS= -ggdb -m32
# LIBS= $(LIBNSYS) -lncurses -lm

# Si no funciona, pruebe con:
# LIBS= $(LIBNSYS) -lncurses -ltermcap -lm
# En mi Suse 6.2 habia que poner -ltermcap
# En Suse 7.2 no existe -ltermcap
#
# Para Solaris use:
# CFLAGS= -ggdb -I$(NSYSTEM)/include -DNODELAY
# LFLAGS= -ggdb
# LIBS= $(LIBNSYS) -lcurses -ltermcap -lm
#
# Para SunOS use:
# CFLAGS= -ggdb -I$(NSYSTEM)/include
# LFLAGS= -ggdb
# LIBS= $(LIBNSYS) -L/usr/5lib -lcurses -ltermcap -lm

#
LIBNSYS= $(NSYSTEM)/lib/libnSys.a

all: pong game ball ball1

.SUFFIXES:
.SUFFIXES: .o .c .s

.c.o .s.o:
	gcc -c $(CFLAGS) $<

pong: pong.o tty.o $(LIBNSYS)
	gcc $(LFLAGS) pong.o tty.o -o $@ $(LIBS)

ball: ball.o tty.o $(LIBNSYS)
	gcc $(LFLAGS) ball.o tty.o -o $@ $(LIBS)

ball1: ball1.o tty.o $(LIBNSYS)
	gcc $(LFLAGS) ball1.o tty.o -o $@ $(LIBS)

game: game.o ladder.o tty.o $(LIBNSYS)
	gcc $(LFLAGS) game.o ladder.o tty.o -o $@ $(LIBS)

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ game pong ball ball1
