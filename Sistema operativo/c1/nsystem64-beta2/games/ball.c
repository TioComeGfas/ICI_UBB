#include "tty.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>

float ACCY;

int MINX, MAXX, MINY, MAXY;
char screen[30][81];

#define MAXBALLS 1000
int ball_count=1;
nTask ball_tasks[MAXBALLS];
int quit= 0;

nMain(int argc, char **argv)
{
  nSetTimeSlice(2);

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
  MAXY= LINES-1;

  { int i, j;
    for (j= MINY; j<=MAXY; j++)
    {
      PrintTty(j, MINX-1, "H");
      PrintTty(j, MAXX+1, "H");
      for (i= MINX; i<=MAXX; i++) screen[j][i]= ' ';
  } }

  RefreshTty();

  ACCY  = argc>=4 ? atoi(argv[3]) : 60.0;

  {
    int ivx= argc>=2 ? atoi(argv[1]) : 30;
    int ivy= argc>=3 ? atoi(argv[2]) : 40;
    int ix = argc>=5 ? atoi(argv[4]) : MINX;
    int iy = argc>=6 ? atoi(argv[5]) : MAXY;
    int Ball();

    ball_tasks[0]= nEmitTask(Ball, ix, iy, ivx, ivy);
  }

  {
    int Kbd(), Shot();
    nTask kbd_task= nEmitTask(Kbd, nCurrentTask());
    nTask shot_task= nEmitTask(Shot);
    int xpos= (MINX+MAXX+1)/2;
    char ch;

    while(!quit)
    {
      PrintTty(MAXY, xpos, "$");
      RefreshTty();
      ch= *(char*) nReceive(NULL, -1);
      nReply(kbd_task, 0);
      PrintTty(MAXY, xpos, " ");
      if (ch=='j')
      {
        screen[MAXY][xpos]= ' ';
        if (xpos>MINX+4) xpos-=4;
        screen[MAXY][xpos]= '$';
      }
      else if (ch=='k')
      {
        screen[MAXY][xpos]= ' ';
        if (xpos<MAXX-4) xpos+=4;
        screen[MAXY][xpos]= '$';
      }
      else if (ch==' ') { nSend(shot_task, &xpos); }
      else if (ch=='q') { kbd_task= NULL; break; }
    }

    if (kbd_task!=NULL)
    {
      do
      {
        ch= *(char*)nReceive(NULL, -1);
        nReply(kbd_task, 0);
      } while (ch!='q');
    }

    xpos= 0;
    nSend(shot_task, &xpos);
  }

  while (ball_count-->0)
  { /* se envia cualquier cosa no nula */
    nSend(ball_tasks[ball_count], (void*)&ball_count);
    nWaitTask(ball_tasks[ball_count]);
  }

  EndTty();
}

int Ball(int ix, int iy, int ivx, int ivy)
{
  float x= ix;
  float y= iy;
  float vx= ivx;
  float vy= ivy;

  nSetTaskName("Ball");
#ifdef NCURSES
  beep();
#endif

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
    char *pscr;

    if (ix<MINX) ix= MINX;
    else if (ix>MAXX) ix= MAXX;
    if (iy<MINY) iy= MINY;
    else if (iy>MAXY) iy= MAXY;

    pscr= &screen[iy][ix];
    if (*pscr=='$')
    {
      quit= 1;
      PrintTty(22,2,"GAME OVER");
    }
    else if (*pscr!='*') *pscr= 'o';
    PrintTty(iy, ix, "%c", 'o');
    RefreshTty();
    if (nReceive(&sender, (int)(1000.0*dt))!=NULL) /* Sirve de sleep */
    {
      nReply(sender,0);
      nExitTask(0);
    }
    if (*pscr=='*')
    {
      int nix= ix + (vx<0 ? -1 : 1);
      ball_tasks[ball_count++]= nEmitTask(Ball, nix, iy, -(int)vx, (int)vy);
      PrintTty(20,2,"bolas: %d", ball_count);
      PrintTty(iy, ix, "*");
    }
    else PrintTty(iy, ix, " ");
    *pscr= ' ';

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

int Shot()
{
  int dt= 1000/48;
  int y= MAXY-1;
  int x;
  nTask sender;

  for(;;)
  {
    y = MAXY-1;
    if (x<=0)
    {
      x= *(int*)nReceive(&sender, -1);
      nReply(sender, 0);
    }
    if (x<=0) nExitTask(0);
    else
    {
      int newx= 0;

      for(;;)
      {
        int *px;
        if (screen[y][x]=='o') { screen[y][x]= '*'; break; }
        if (screen[y-1][x]=='o') { screen[y-1][x]= '*'; break; }
        if (screen[y-2][x]=='o') { screen[y-2][x]= '*'; break; }
        if (screen[y-3][x]=='o') { screen[y-3][x]= '*'; break; }
        PrintTty(y,x,"^");
        RefreshTty();
        px= (int*)nReceive(&sender, dt);
        PrintTty(y,x," ");
        if (px!=NULL)
        {
          newx= *px;
          nReply(sender,0);
          if (x<=0) nExitTask(0);
        }
        if (--y<MINY) break;
      }
      x= newx;
} } }

int Kbd(nTask receiver)
{
  char ch;

  nSetTaskName("lector");

  do
  {
    ch=GetchTty();
    nSend(receiver, &ch);
  }
    while (ch!='q');
}
