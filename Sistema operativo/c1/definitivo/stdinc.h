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

int conectate(char *ip, int PORT){
	struct hostent	*he;
	struct sockaddr_in	srvAddr; /* direccion de servidor*/
	int sd;
	if ((he=gethostbyname(ip)) == NULL) /*info del server*/ 
		Fatal("gethostbyname");
	if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
		FatalPerror("socket");
	srvAddr.sin_family = AF_INET;		/*NBO*/ 
	srvAddr.sin_port = htons(PORT);	/*short, NBO*/ 
	srvAddr.sin_addr = *((struct in_addr *)he->h_addr);
	bzero(&(srvAddr.sin_zero), 8);	/* relleno con cero*/

	if (connect(sd, (struct sockaddr *)&srvAddr,sizeof(struct sockaddr)) ==-1)
		FatalPerror("connect");
	return sd;
}

int enviaMensaje(char *msg, int sd){
	if (send(sd, msg, strlen(msg), 0) == -1)
		return -1;
	return 0;
}

int esperaRespuesta(int sd, char* buf){
	int numbytes;
	size_t n= sizeof(buf)/sizeof(buf[0]);
	if ((numbytes=recv(sd, buf, n-1, 0)) == -1)
		return -1;
	buf[numbytes] = '\0';
return numbytes;

}
int conectaServer(int MYPORT, int BACKLOG){
	int sd;		/*listen sobre sd*/
	struct sockaddr_in myAddr;		/*mi direccion*/

	if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
		return -1;
	myAddr.sin_family = AF_INET;         /*HBO*/ 
	myAddr.sin_port = htons(MYPORT);     /*short, NBO*/ 
	myAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	/*cualquier interface; auto-llenado con mi IP; NBO*/
	bzero(&(myAddr.sin_zero), 8);        /*relleno con ceros*/ 
	if (bind(sd, (struct sockaddr *)&myAddr,sizeof(struct sockaddr)) == -1) //asignar socket a puerto
		return -1;
	if (listen(sd, BACKLOG) == -1)	
		return -1;
return sd;

}


