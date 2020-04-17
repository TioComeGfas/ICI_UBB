# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem96
#
# Para compilar ingrese make <ejemplo>
#
# Ej 1: make pong
# Ej 2: make game
# Ej 3: make ball
#
# No hay mas por ahora
#
# Para Linux use (curses estandar tiene bugs en linux):
#
CFLAGS= -ggdb -I$(NSYSTEM)/include -I/usr/include/ncurses -DNCURSES -DNODELAY
LFLAGS= -ggdb -static
#LIBS= $(LIBNSYS) -lncurses -lm
# y si no resulta entonces:
LIBS= $(LIBNSYS) -lncurses -ltermcap -lm
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

all: fifo

.SUFFIXES:
.SUFFIXES: .o .c .s

.c.o .s.o:
	gcc -c $(CFLAGS) $<

fifo: personajes.o fifo.o tty.o main.o $(LIBNSYS)
	gcc $(LFLAGS) personajes.o fifo.o tty.o main.o -o $@ $(LIBS)

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ fifo
