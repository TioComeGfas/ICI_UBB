# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem97
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

CFLAGS= -ggdb -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LFLAGS= -ggdb

# Linux x86
#CFLAGS= -ggdb -m32 -I$(NSYSTEM)/include -I$(NSYSTEM)/src
#LFLAGS= -ggdb -m32

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
	rm -f *.o *~ msgprodcons
