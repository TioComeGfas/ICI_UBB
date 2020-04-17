#include "./stdinc.h"
const int	PORT = 3490; /*puerto de conexion del cliente*/
const int	MAXDATASIZE = 100; /*tamagno del buffer de entrada*/

int main(int argc, char *argv[]) {
  char	*usage = "Usar:  IP del servidor\n";
  int	sd, numbytes;
  char	buf[MAXDATASIZE+1];
  struct hostent	*he;
  struct sockaddr_in	srvAddr; /* direccion de servidor*/

  if (argc != 3)	
    Fatal(usage);
  if ((he=gethostbyname(argv[1])) == NULL) /*info del server*/ 
    Fatal("gethostbyname");
  if ((sd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    FatalPerror("socket");

  srvAddr.sin_family = AF_INET;		/*NBO*/ 
  srvAddr.sin_port = htons(PORT);	/*short, NBO*/ 
  srvAddr.sin_addr = *((struct in_addr *)he->h_addr);
  bzero(&(srvAddr.sin_zero), 8);	/* relleno con cero*/

  if (connect(sd, (struct sockaddr *)&srvAddr,
                                  sizeof(struct sockaddr)) ==-1)

	FatalPerror("connect");
if (send(sd,argv[2], strlen(argv[2]),0) == -1)
	FatalPerror("send");
  close(sd);
  return 0;
}

