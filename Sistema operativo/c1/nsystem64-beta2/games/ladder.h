#include "tty.h"

/*************************************************************
 * Manejo de objetos en un terminal de 24x80
 *
 * El resto de los servicios se encuentra en `tty.h'.
 *************************************************************/

/* Por simplicidad el taman~o del terminal tiene que ser fijo */

#define TTY_LINES 24
#define TTY_COLS  80

/*
 * InitLadder: Inicializa el terminal, lee un paisaje en el archivo
 * `filename' y lo despliega en terminal.
 *
 * EndLadder: Vuelve el terminal al modo normal.
 */

void InitLadder(char *filename);
void EndLadder();

/*
 * Put: Coloca el objeto `object' en el terminal en la posicion (x,y)
 * y actualiza la pantalla (con 1<=x<=80 y 1<=y<=24).
 *
 * Get: Averigua que' objeto se encuentra actualmente en la posicion (y, x).
 * Se debe verificar: 0<=x<=81 y 0<=y<=25 con Get(0,x)=Get(25,x)='T'
 * y Get(y,0)=Get(y,81)='T'.
 *
 * Restore: Restaura la posicion (y,x) a su valor inicial.
 */

int  Put(char object, int y, int x);
int  Get(int y, int x);
void Restore(int y, int x);

