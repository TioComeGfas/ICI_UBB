# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem95
#
# Para compilar ingrese: make

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

CFLAGS= -ggdb -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LFLAGS= -ggdb $(LIBNSYS)

all: demo

.SUFFIXES:
.SUFFIXES: .o .c .s

.c.o .s.o:
	gcc -c $(CFLAGS) $<

demo: demo.o nSemaforo.o $(LIBNSYS)
	gcc $(LFLAGS) demo.o nSemaforo.o -o $@

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ demo
