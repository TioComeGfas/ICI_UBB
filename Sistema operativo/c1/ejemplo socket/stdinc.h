#include <unistd.h> 	    // symbolic constants, sys svc protos
#include <stdio.h> 	    // standard I/O library
#include <stdlib.h> 	    // utility function protos
#include <errno.h> 	    // error handling
#include <string.h> 	    // char string functions
#include <strings.h> 	    // function prototypes like bzero, ...
#include <netdb.h>	    // gethostbyname
#include <sys/types.h>     // socket, bind, accept, connect, send, recv
#include <netinet/in.h>    // socket address struct
#include <sys/socket.h>    // same as sys/types.h, listen
#include <arpa/inet.h>     // prototypes like inet_ntoa

static inline void
	Fatal(char *msg) { fprintf(stderr, "%s", msg); exit(1); }
static inline void
	FatalPerror(char *msg) { perror(msg); exit(1); }

