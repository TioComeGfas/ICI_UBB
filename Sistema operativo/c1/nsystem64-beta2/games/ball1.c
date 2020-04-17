#include "tty.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>

int Ball();
int Kbd();

float ACCY;
int MINX, MAXX, MINY, MAXY;

nMain(int argc, char **argv)
{
  nTask kbd_task;
  nTask ball_task;

  InitTty();
  ClearTty();

  PrintTty(6,2, " B O U N C E");
  PrintTty(7,2, "   G A M E  ");
  PrintTty(10,2,"j: izquierda");
  PrintTty(11,2,"k: derecha");
  PrintTty(13,2,"espacio: fuego");
  PrintTty(15,2,"q: fin");
  PrintTty(20,2,"bolas: 1");

  MINX= 1+strlen("espacio: fuego")+18;
  MINY= 1;
  MAXX= COLS-1;
  MAXY= LINES;

  { int i, j;
    for (j= MINY; j<=MAXY; j++)
    {
      PrintTty(j, MINX-1, "H");
      PrintTty(j, MAXX+1, "H");
  } }

  RefreshTty();

  ACCY  = argc>=4 ? atoi(argv[3]) : 60.0;

  ball_task= nEmitTask(Ball, MINX, MAXY, 30, 40);

  kbd_task= nEmitTask(Kbd, nCurrentTask());

  { char ch;
    do
    { /* Esperamos recibir un mensaje de kbd_task */
      ch= *(char*)nReceive(NULL, -1);
      nReply(kbd_task, 0);
    } while (ch!='q');
  }
  /* se envia cualquier cosa no nula */
  nSend(ball_task, (void*)&ball_task);
  nWaitTask(ball_task);

  EndTty();
}

int Ball(int ix, int iy, int ivx, int ivy)
{
  float x= ix;
  float y= iy;
  float vx= ivx;
  float vy= ivy;

  nSetTaskName("Ball");

  for (;;)
  {
    nTask sender;

    float absvx= fabs(vx);
    float absvy= fabs(vy);
    float dtx= absvx>0.00001 ? 1.0/absvx : 1000.0;
    float dty= absvy>0.00001 ? 1.0/absvy : 1000.0;
    float dt= dtx<dty ? dtx : dty;
    int ix= floor(x);
    int iy= floor(y);

    if (ix<MINX) ix= MINX;
    else if (ix>MAXX) ix= MAXX;
    if (iy<MINY) iy= MINY;
    else if (iy>MAXY) iy= MAXY;

    PrintTty(iy, ix, "o");
    RefreshTty();
    if (nReceive(&sender, (int)(1000.0*dt))!=NULL) /* Sirve de sleep */
    {
      nReply(sender,0);
      nExitTask(0);
    }
    PrintTty(iy, ix, " ");

    if ( x>=MAXX && vx>0.0 ) vx= -vx;
    if ( x<(MINX+1) && vx<0.0 ) vx= -vx;
    if ( y>=MAXY && vy>0.0 ) vy= -vy;
    if ( y<(MINY+1) && vy<0.0) vy= -vy;

    /* Calculamos nuevos x, y, vy */
    x += vx*dt; /* aceleracion horizontal==0 */
    y += vy*dt + ACCY*dt*dt/2.0;
    vy += ACCY*dt;
  }
}

int Kbd(nTask receiver)
{
  char ch;

  nSetTaskName("lector");

  do
  {
    ch=GetchTty();
    nSend(receiver, (void*)&ch);
  }
    while (ch!='q');
}
