#include "./stdinc.h"
const int	MYPORT = 3490;	/*cliente se conecta en este puerto*/
const int	BACKLOG = 10;	/*max # conexiones pendientes*/
const int	MAXDATASIZE = 100;
main() {
  int sd,numbytes;		/*listen sobre sd*/
  int new_fd;		/*nueva conexion*/ 
  struct sockaddr_in
	myAddr,		/*mi direccion*/
	clAddr;		/*direccion del cliente*/
  char *msg = "Hello World\n";	/*responder msg*/
  char *buf[MAXDATASIZE+1];
  int sinSz = sizeof(struct sockaddr_in);	

  if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
	FatalPerror("socket error");
  myAddr.sin_family = AF_INET;         /*HBO*/ 
  myAddr.sin_port = htons(MYPORT);     /*short, NBO*/ 
  myAddr.sin_addr.s_addr = htonl(INADDR_ANY);
		/*cualquier interface; auto-llenado con mi IP; NBO*/
  bzero(&(myAddr.sin_zero), 8);        /*relleno con ceros*/ 
  if (bind(sd, (struct sockaddr *)&myAddr,
				sizeof(struct sockaddr)) == -1)
	FatalPerror("bind");
  if (listen(sd, BACKLOG) == -1)	
        FatalPerror("listen");
  while(1) { // loop principal para el  accept() 
     new_fd = accept(sd, (struct sockaddr *) &clAddr, &sinSz);
     if (new_fd == -1)  
        FatalPerror("accept");
    if ((numbytes=recv(new_fd, buf, MAXDATASIZE, 0)) == -1)
	FatalPerror("recv");
     printf("server: got connection from %s, %s\n",
				inet_ntoa(clAddr.sin_addr),buf);

  buf[numbytes] = '\0';
  printf("Recivido: %s",buf);
     close(new_fd);
  }
}

