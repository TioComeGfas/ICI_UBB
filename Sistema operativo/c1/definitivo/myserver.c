#include "./stdinc.h"
const int	MYPORT = 3490;	/*cliente se conecta en este puerto*/
const int	BACKLOG = 6;	/*max # conexiones pendientes*/
const int	MAXDATASIZE = 100; /*tamagno del buffer de entrada*/
char matriz[3][3];  /*la  matriz */	
void iniciaMatriz(char matriz[3][3]); // corresponde a una funcion para inciar la matriz, que sera enviada a los clientes 

main() {
	int sd;		/*listen sobre sd*/
	int new_fd;	/*nueva conexion*/ 
    int new_fd2;  // corresponde a una segunda conexion, ya que en la logica de nuestro programa recibe las 2 conexiones y luego incia un fork() donde juegan esos 2 jugadores y y el proceso padre sigue esperando nuevos jugadores
    char buf[MAXDATASIZE+1]; //buffer donde se almacena el nombre del cliente 1
    char buf2[MAXDATASIZE+1];  //buffer donde se almacenara el nombre del cliente 2
	int sinSz = sizeof(struct sockaddr_in);	//tamaño de la estructura de entrada (datos del cliente que se conecta) ...
   
	struct sockaddr_in clAddr;		/*direccion del cliente*/
	sd=conectaServer(MYPORT,BACKLOG);  // sd recibe el descriptor del socket habilitado para listen
	if(sd ==-1){
		FatalPerror("NO CONECTO EL SERVER!. DRAMA!");	
	}
	while(1) { // loop principal para el  accept() 
		new_fd = accept(sd, (struct sockaddr *) &clAddr, &sinSz);  //new_fd es llenado con el descriptor obtenido de la primera conexion 
		if (new_fd == -1)  
			FatalPerror("accept");
		int statusRespuesta=esperaRespuesta(new_fd,buf);
		if(statusRespuesta==-1)	{
			FatalPerror("Fallo la recepción del mensaje. DRAMA!");
			close(new_fd);
			break;
		}
        new_fd2=accept(sd, (struct sockaddr *) &clAddr, &sinSz);  //new_fd2 es llenado con el descriptor obtenido de la segunda conexion (para no alargar mucho el codigo nos saltamos esta verificacion) 
        //en este espacio se debe comprobar algun error en el accept como en el primer descriptor
        esperaRespuesta(new_fd2,buf2);
        //en este espacio se debe ver si se pudo recibir el mensaje como en la primera conexion (para no alargar mucho el codigo nos saltamos esta verificacion)
		iniciaMatriz(matriz);  //inicia la matriz para empezar el juego entre los 2 clientes conectados
        if(fork()==0){   //uso del fork para crear un proceso hijo que entre al ciclo while para manejar el juego de los 2 clientes y el proceso padre sigue recibiendo conexiones 
		 while(1){
		 printf("SERVIDOR: Obtuvo conexión de: %s, y su nombre es: %s\n",inet_ntoa(clAddr.sin_addr),buf);  // mensaje que muestra la direccion de la conexion y el nombre del cliente 
         printf("SERVIDOR: Obtuvo conexión de: %s, y su nombre es: %s\n",inet_ntoa(clAddr.sin_addr),buf2); // mensaje que muestra la direccion de la conexion y el nombre del cliente 

		 write(new_fd, matriz, sizeof(matriz));     //manda la matriz al primer jugador quien iniciara la partida
         read(new_fd, matriz, sizeof(matriz));      //recibe la matriz actualizada con la jugada del primer jugador
 
         write(new_fd2, matriz, sizeof(matriz));   //manda la matriz al segundo jugador con la jugada que realizo su rival
		 read(new_fd2, matriz, sizeof(matriz));    //recibe la matriz actualizada con la jugada del segundo jugador
      
		}
        }
		close(new_fd);
	}//fin while
	printf("Apagando el server...");
	close(sd);
}
void iniciaMatriz(char matriz[3][3]){//iniciar la  matriz
  int i, j;
  for(i=0; i<3; i++)
    for(j=0; j<3; j++) matriz[i][j] =  ' ';
}




