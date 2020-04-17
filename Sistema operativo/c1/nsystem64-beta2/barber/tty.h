#include <stdarg.h>
#ifdef NCURSES /* Porque ncurses funciona mejor que curses */
#include <ncurses.h>
#else
#include <curses.h>
#endif
#include "nSystem.h"

/*************************************************************
 * Servidor de pantalla completa para nSystem
 *
 *     Lista de servicios disponibles
 *************************************************************/

/*
 * InitTty : Inicializa el terminal.  Hay que invocarlo en el nMain
 * EndTty : Vuelve el terminal al estado original.
 */

void InitTty();
void EndTty();

/*
 * PrintTty: Escribe un texto formateado en la file 'y' y la columna 'x'.
 * Las filas y columnas comienzan en (1,1) en la esquina superior izquierda.
 *
 * ClearTty: Borra la pantalla.
 *
 * ClearToEOF: Borra de (x,y) hasta el final de la linea.
 *
 * ClearToBot: Borra de (x,y) hasta el final de la pantalla.
 *
 * Los cambios introducidos por estos procedimientos en el terminal
 * no se hacen realmente hasta que se invoque RefreshTty.
 *
 * RefreshTty: Actualiza la pantalla. 
 */

void PrintTty( int y, int x, char *fmt, ... );
void ClearTty();
void ClearToEOL(int y, int x);
void ClearToBot(int y, int x);
void RefreshTty();

/*
 * GetchTty: Lee un caracter del terminal.  Solo bloquea la tarea
 * que lo invoca.
 */

int GetchTty();

/*************************************************************
 * Para implementar servidores (ver tty.c)
 *************************************************************/

int CallServerExt(nTask server_task, int op, int y, int x,
                  char *format, va_list ap);
int CallServer(nTask server_task, int op);

#define QUIT (-1)

typedef struct
{
  int op;
  int y, x;
  char *format;
  va_list ap;
}
  Request;
