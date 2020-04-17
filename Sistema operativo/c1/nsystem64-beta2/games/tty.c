#include "tty.h"
#include "string.h"

static int TtyServer();
static int KbdServer();

static nTask tty_task;
static nTask kbd_task;

#define PRINT    1
#define CLR      2
#define CLREOL   3
#define CLRBOT   4
#define GETCH    5
#define REFRESH  6

void InitTty()
{
  int old_ss;

  initscr();

  cbreak();
  noecho();
  nonl();
  /* Cuidado, esta instruccion hace que getch() nunca se bloquee a la
   * espera de un caracter.  Si no hay nada que leer retorna un
   * codigo de error */
#ifdef NODELAY
  nodelay(stdscr, 1);
  /* algunos curses tienen nodelay(), que funciona mejor que
   * la E/S no bloqueante */
#else
  /* En SunOS no hay nodelay(), pero funciona bien en modo bloqueante */
  nSetNonBlockingStdio();
#endif

  old_ss= nSetStackSize(32*1024);
  tty_task= nEmitTask(TtyServer);
  nSetStackSize(old_ss);

  kbd_task= nEmitTask(KbdServer);
}

int CallServerExt(nTask server_task, int op, int y, int x,
               char *format, va_list ap)
{
  Request Req;
  int rc;

  Req.op= op;
  Req.y= y;
  Req.x= x;
  Req.format= format;
  if (format!=NULL)
    va_copy(Req.ap, ap);
  rc= nSend(server_task, &Req);
  return rc;
}

int CallServer(nTask server_task, int op)
{
  Request Req;

  Req.op= op;
  return nSend(server_task, &Req);
}

void PrintTty(int y, int x, char *format, ...)
{
  va_list ap;

  va_start(ap, format);
  CallServerExt(tty_task, PRINT, y, x, format, ap);
  va_end(ap);
}

void ClearTty()
{
  CallServer(tty_task, CLR);
}

void ClearToEOL(int y, int x)
{
  CallServerExt(tty_task, CLREOL, y, x, NULL, NULL);
}

void ClearToBot(int y, int x)
{
  CallServerExt(tty_task, CLRBOT, y, x, NULL, NULL);
}

void RefreshTty()
{
  CallServer(tty_task, REFRESH);
}

int GetchTty()
{
  return CallServer(kbd_task, GETCH);
}

void EndTty()
{
  CallServer(kbd_task, QUIT);
  nWaitTask(kbd_task);

  CallServer(tty_task, QUIT);
  nWaitTask(tty_task);

  endwin();
}

static int TtyServer()
{
  int refresh_tty= 0;
  int quit_tty= 0;

  nSetTaskName("Servidor para el despliegue en la tty");

  while ( !quit_tty )
  {
    nTask sender;
    Request *req= (Request*)nReceive(&sender, -1);

    if (req->op==CLR)
    {
      clear();
      refresh_tty= 1;
    }
    else if (req->op==CLREOL)
    {
      move(req->y-1, req->x-1);
      clrtoeol();
    }
    else if (req->op==CLRBOT)
    {
      move(req->y-1, req->x-1);
      clrtobot();
    }
    if (req->op==REFRESH)
    {
      move(LINES-1, 0);
      refresh();
      refresh_tty= 0;
    }
    else if (req->op==PRINT)
    {
      char buff[160];
      vsprintf(buff, req->format, req->ap);

      if (req->y<1 || req->y>LINES || req->x<0 || req->x>COLS)
        nFatalError("TtyServer", "Se escribio fuera del terminal\n");

      if (strlen(buff)>160-1)
        nFatalError("TtyServer", "Se excede la capacidad del buffer\n");

      /* mvaddnstr(req->y-1, req->x-1, buff, 81-req->x); */
      buff[81-req->x]= '\0';
      mvaddstr(req->y-1, req->x-1, buff);
      refresh_tty= 1; /* Para que se haga el refresh en algun momento */
    }
    else if (req->op==QUIT)
      quit_tty= 1;

    nReply(sender, 0);
  }

  return 0;
}

static int KbdServer()
{
  int ch= 0;
  nTask reader_task= NULL;

  nSetTaskName("Servidor para la lectura del teclado");

  for(;;)
  {
    int chpoll;
    nTask sender;
    Request *req;

    req= (Request *) nReceive(&sender, 1000/30 );

    if (req!=NULL)
    {
      if (req->op==GETCH)
        if (reader_task!=NULL)
          nFatalError("KbdServer",
                  "Dos tareas tratan de leer simultaneamente el teclado\n");
        else reader_task= sender;
      else if (req->op==QUIT)
      {
        nReply(sender, 0);
        if (reader_task!=NULL) nReply(reader_task, ERR);
        break;
      }
      else
        nFatalError("KbdServer", "Codigo de operacion erroneo\n");
    }

    chpoll= getch(); /* Nunca espera porque la E/S es no bloqueante */
    if (chpoll>0) ch= chpoll;
    /* Lamentablemente no podemos cambiar curses/ncurses para que
     * llame a nRead en vez de read.  Esto significa que no
     * podemos llamar a getch() de modo que se bloquee hasta leer
     * algo, pero sin bloquear el resto de los threads.  Por lo
     * tanto getch usara read() estandar de Unix, pero como la E/S
     * fue puesta en modo no bloqueante, si no hay nada para leer
     * retornara de inmediato con un codigo de error. Curses entonces
     * retorna ERR que puede ser 0 o -1 dependiendo de la instalacion */

    if (ch>0 && reader_task!=NULL)
    {
      nReply(reader_task, ch);
      reader_task= NULL;
      ch= 0;
    }
  }

  return 0;
}
