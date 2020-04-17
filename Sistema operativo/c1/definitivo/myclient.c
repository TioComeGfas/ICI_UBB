#include "./stdinc.h"
const int	PORT = 3490; /*puerto de conexion del server, ahi está escuchando*/
const int	MAXDATASIZE = 100; /*tamanio del buffer de entrada*/
char matriz[3][3];  /*la  matriz */	
void mostrar_matriz(char matriz[3][3]);
void jugada(char matriz[3][3]);
int contarJugadas(char matriz[3][3]);
int verificarGanador(char matriz[3][3]);

int main(int argc, char *argv[]) {
	char *usage = "Usar:  IP del servidor\n nombre";
	int	sd; //descriptor de archivo... 
	char buf[MAXDATASIZE+1]; //el buffer donde llegan los datos del server
	char *ipServer=argv[1]; //la ip del server
	char *msg = argv[2]; //el Nombre o mensaje 
	
	if (argc != 3){	
		Fatal(usage);
	}
	sd = conectate(ipServer, PORT);
	int status= enviaMensaje(msg,sd);  //envia mensaje con el nombre al servidor 
	if(status==-1){
		FatalPerror("Fallo el envio del mensaje. DRAMA!");	
	}
    printf("BUSCANDO RIVAL.......\n");
    printf("RIVAL ENCONTRADO, EMPEZAMOS EL JUEGO\n");
	while(1){
	
	read(sd, matriz, sizeof(matriz));   //recibe la matriz que le envia el servidor
    mostrar_matriz(matriz);             // funcion para mostrar la matriz con el formato del juego
    if(verificarGanador(matriz)==1){ printf("HAS PERDIDO\n");exit(0);}   //verifica si la matriz recibida con la jugada del rival ya cumple la condicion para ser ganador, en ese caso el jugador pierde 
	jugada(matriz);                     // funcion que se encarga de pedir la posicion donde se desea ingresar nuestro 'X' u 'O' y verificar si la posicion es valida, luego procede a llenar la posicion de la matriz
    mostrar_matriz(matriz);             // muestra la matriz por pantalla con la jugada que acaba de realizar el jugador
    write(sd, matriz, sizeof(matriz));  //envia la matriz al servidor para que este se la envie al otro jugador, si la matriz ya cumple con la condicion de que ha ganado, el jugador rival perdio el juego y se le indicara por pantalla
    if(verificarGanador(matriz)==1){ printf("FELICIDADES HAS GANADO \n");exit(0);} //verifica si con la ultima jugada ya se cumple la condicion para ser ganador, en ese caso el jugador ha ganado
	}  //fin del while
	close(sd);
	return 0;

}

//A continuacion las funciones empleadas son para la logica del juego

void mostrar_matriz(char matriz[3][3])//funcion que se encarga de mostrar la matriz por pantalla al jugador
{
  int i; 

  for(i=0; i<3; i++) {
    printf(" %c | %c | %c ",matriz[i][0],
            matriz[i][1], matriz[i][2]);
    if(i!=2) printf("\n---|---|---\n");
  }
  printf("\n");
}

void jugada(char matriz[3][3])  //esta funcion se encarga de recibir las coordenadas del tablero donde el jugador quiere ingresar su posicion y le indica si la jugada es valida o no, de ser valida se llena la matriz en la posicion x,y
{
  int x, y;
  int contador=0;

  printf("Escribe X,Y para tu movida (separadas por un espacio): \n");
  scanf("%d%*c%d", &x, &y);     //formato para ingresar la coordenada 

  x--; y--;

  if(matriz[x][y]!= ' '){
	
    printf("jugada invalida ,vuelva a intertarlo\n");
  		jugada(matriz);
  }
  contador=contarJugadas(matriz);
  if(contador==0|| contador==2 ||contador==4||  contador==6||  contador==8){
     matriz[x][y]='X';
	}else{
     matriz[x][y]='O';
    }
}

int contarJugadas(char matriz[3][3]){  //esta funcion cuenta las jugadas es impórtante para la funcion en donde se debe ingresar la jugada ya que nos ayuda a saber si se debe llenar con 'O' u 'X'
 int cont=0;
 int i;
 for(i=0; i<3; i++) {
    if (matriz[i][0] != ' ')cont++;
    if (matriz[i][1] != ' ')cont++;
    if (matriz[i][2] != ' ')cont++;
  }
 return cont;
}
int verificarGanador(char matriz[3][3]){  //funcion que verifica las columnas, filas y diagonales en caso de cumplir la condicion para ser ganador retornara un 1 
  int i;

  for(i=0; i<3; i++)  /* verifica filas */
    if(matriz[i][0]==matriz[i][1] &&
       matriz[i][0]==matriz[i][2] && matriz[i][0]!=' ') return 1;

  for(i=0; i<3; i++)  /* verifica columnas  */
    if(matriz[0][i]==matriz[1][i] &&
       matriz[0][i]==matriz[2][i] && matriz[0][i]!=' ') return 1;

  /* verifica diagonales */
  if(matriz[0][0]==matriz[1][1] &&
     matriz[1][1]==matriz[2][2] && matriz[2][2]!=' ')
       return 1;

  if(matriz[0][2]==matriz[1][1] &&
     matriz[1][1]==matriz[2][0] && matriz[1][1]!=' ')
       return 1;

  return 0;
}



