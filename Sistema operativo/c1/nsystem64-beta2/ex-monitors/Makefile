# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem95
#
# Para compilar ingrese make APP=<ejemplo>
#
# Ej: make APP=iotest
#
# Elegir una entre los siguientes ejemplos
#
# msgprodcons iotest test term-serv
#

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

CFLAGS= -O2 -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LFLAGS=
#CFLAGS= -ggdb -I$(NSYSTEM)/include -I$(NSYSTEM)/src
#LFLAGS= -ggdb

all: $(APP)

.SUFFIXES:
.SUFFIXES: .o .c .s

.c.o .s.o:
	gcc -c $(CFLAGS) $<

$(APP): $(APP).o $(LIBNSYS)
	gcc $(LFLAGS) $@.o -o $@ $(LIBNSYS)

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ monprodcons monprodcons2
