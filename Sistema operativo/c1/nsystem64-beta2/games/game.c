#include "ladder.h"
#include <stdlib.h>
#include <math.h>

#define BALL 'o'
#define CLIMBER 'P'

int BallGen();
int Climber();

float accy;
int quit_game= 0;
nTask climber;

nSem rand_sem;

int myrand()
{
  int ret;
  nWaitSem(rand_sem);
  ret= rand();
  nSignalSem(rand_sem);
  return ret;
}

int nMain(int argc, char **argv)
{
  int ch;
  nTask ball_gen;
  int balls;
  float vel;

  nSetTimeSlice(2);
  rand_sem= nMakeSem(1);

  balls= argc>=2 ? atoi(argv[1]) : 3;
  vel= argc>=3 ? atof(argv[2]) : 0.02;
  accy= argc>=4 ? atof(argv[3]) : 0.0001;

  InitLadder("ladder-screen.txt");

  ball_gen= nEmitTask(BallGen, balls, vel);

  climber= nEmitTask(Climber, 1, 24, vel);
  nWaitTask(climber);

  quit_game= 1;
  CallServer(ball_gen, QUIT);
  nWaitTask(ball_gen);

  EndLadder();

  return 0;
}

int Ball();

#define MAXBALLS 20

nTask balls[MAXBALLS];
int curr_ball=0;

int BallGen(nballs, vel)
int nballs;
float vel;
{
  int wakeup=0;
  Request *req;
  nTask sender;

  nSetTaskName("Generador de rocas");

  while ((req= (Request *) nReceive( &sender, wakeup ))==NULL)
  {
    float rand_vel= ((float)(myrand() & 1023)/1024.0 + 0.3)*vel;

    if (curr_ball>=nballs) curr_ball=0;
    if (balls[curr_ball]!=NULL) nWaitTask(balls[curr_ball]);

    balls[curr_ball]= nEmitTask(Ball, 1, 1, rand_vel);

    curr_ball++;
    wakeup= myrand() & (4096-1);
  }

  nReply(sender, 0);

  curr_ball=0;
  while (curr_ball<nballs && balls[curr_ball]!=NULL)
  {
    /* CallServer(balls[curr_ball], QUIT); */
    nWaitTask(balls[curr_ball]);
    curr_ball++;
  }
}

int Ball(x, y, vel)
int x, y;
float vel;
{
  float rx= (float)x;
  float ry= (float)y;
  float vx= vel;
  float vy= 0.0;

  float abs_vx= fabs(vx);

  nSetTaskName("Roca");

  while ( ! quit_game )
  {
    float pause;

    if (Get(y+1, x)=='T')
    {
      vy= 0.0;
      if (vx==0.0) vx= myrand()&1==1 ? vel : -vel;
    }
    else if (Get(y+1, x)=='H')
    {
      if (myrand()&1==1)
      {
        vy= vel/2.0;
        vx= 0.0;
      }
      else vy= 0.0;
    }

    if (vx>0.0 && Get(y, x+1)=='T' || vy<0.0 & Get(y, x-1)=='T')
       vx= -vx;

    { float xpause= 1000.0;
      float ypause= 1000.0;

      if (vx>0.0)
        xpause= (floor(rx+1.0)-rx)/vx;
      else if (vx<0.0)
        xpause= (rx-ceil(rx-1.0))/-vx;

      if (vy>0.0) ypause= (floor(ry+1.0)-ry)/vy;

      pause= xpause<ypause ? xpause : ypause;
    }

    rx += vx * pause;
    ry += vy * pause;

    x= (int)rx; y= (int)ry;

    if (Get(y, x)=='T')
    {
      vx= -vx;
      rx += vx * pause;
      x= (int)rx;
    }

    vy += accy * pause;

    if (vx==0.0 && vy==0.0 || pause<0.0 || pause>1000.0)
      nFatalError("Ball", "Malo\n");

    { nTask sender;
      Request *req;
      int curr_obj;
      int kill= 'x';

      if (Get(y, x)=='@') nExitTask(0);

      curr_obj= Put(BALL, y, x);

      if (curr_obj==CLIMBER)
        nSend(climber, &kill);

      req= (Request *)nReceive(&sender, (int)pause);
      Restore(y, x);
  } }

  return 0;
}

int Kbd(nTask climber_task)
{
  int ch;

  nSetTaskName("lector");

  do
  {
    ch=GetchTty();
    nSend(climber_task, &ch);
  }
    while (ch!='q');
}
 
int Climber(ix, iy, vel)
float vel;
int ix, iy;
{
  nTask kbd_task= nEmitTask(Kbd, nCurrentTask());
  float waketime, currtime;
  int ydir= 0;
  float rx= (float)ix, ry= (float)iy;
  float vx= 0.0, vy= 0.0;
  float pause=0.0;
  char *endmsg= "*** Perdiste ***";
  int *pcmd;
  nTask sender;

  nSetTaskName("Escalador");

  currtime= (float)nGetTime();

  for(;;)
  {
    float waketime;
    int curr_obj;

    pcmd= (int *) nReceive(&sender, (int)pause);

    waketime= (float)nGetTime();
    if (waketime-currtime<pause) pause= waketime-currtime;

    currtime= waketime;
    
    rx += vx * pause;
    ry += vy * pause;

    Restore(iy, ix);
    ix= (int)rx; iy= (int)ry;
    curr_obj= Put(CLIMBER, iy, ix);

    /* Revisamos si llego un comando del jugador */
    if (pcmd!=NULL)
    {
      int cmd= *pcmd;

      nReply(sender, 0);

      if (cmd=='x') break;
      else if (cmd=='q')
      {
        nWaitTask(kbd_task);
        nExitTask(0);
      }
      else if (cmd=='i')
      {
        if (curr_obj=='H')
        { vy= vy<=0.0 ? -vel/2.0 : 0.0; vx= 0.0; }
        else ydir= -1;
      }
      else if (cmd=='k')
      {
        if (curr_obj=='H') { vy= vy>=0.0 ? vel/2.0 : 0.0; vx= 0.0; }
        else ydir= 1;
      }
      else if (Get(iy+1, ix)=='T' || Get(iy+1, ix)=='H')
      {
        ydir= 0;
        if (cmd=='j') vx= vx<=0.0 ? -vel : 0.0;
        if (cmd=='l') vx= vx>=0.0 ? vel : 0.0;
        if (cmd==' ') vy= -vel;
      }
      waketime= currtime;
    }

    if (curr_obj=='#')
    {
      endmsg= "*** Ganaste ***";
      break;
    }
    else if (curr_obj==BALL) break;

    /* Calculamos la proximo movida */

    if (ydir!=0)
    {
      if (ydir>0 && Get(iy+1, ix)=='H') { vy= vel/2; vx= 0.0; ydir=0; }
      else if (ydir<0 && curr_obj=='H') { vy= -vel/2; vx= 0.0; ydir= 0; }
    }

    { int nexty= Get(iy + (vy>=0.0 ? 1 : -1), ix);
      if (nexty=='T') vy= 0.0;
    }

    { int nextx= Get(iy, ix + (vx>=0.0 ? 1 : -1));
      if (nextx=='T') vx= 0.0;
    }

    if (curr_obj!='H' && Get(iy+1, ix)==' ') vy+= accy*pause;
    if (vy<0.0 && vx==0.0 && curr_obj==' ' && Get(iy+1, ix)=='H') vy= 0.0;

    { float xpause= 1000.0;
      float ypause= 1000.0;

      if (vx!=0.0)
        xpause= vx>0.0 ? (floor(rx+1.0)-rx)/vx : (rx-ceil(rx-1.0))/-vx; 

      if (vy!=0.0)
        ypause= vy>0.0 ? (floor(ry+1.0)-ry)/vy : (ry-ceil(ry-1.0))/-vy;

      pause= xpause<ypause ? xpause : ypause;
    }

    { int ix= (int)(rx+vx*pause);
      int iy= (int)(ry+vy*pause);
      if (Get(iy, ix)=='T') vx= vy= 0.0;
  } }

  {
    int count=1;
    int *pcmd;
    int cmd= ' ';

    while (cmd!='q')
    {
      ClearToEOL(3, 38);
      if (count++&1) PrintTty(3, 48, endmsg);
      RefreshTty();

      pcmd= (int *)nReceive(&sender, (int)1000);
      if (pcmd!=NULL)
      {
        cmd= *pcmd;
        nReply(sender, 0);
  } } }

  nWaitTask(kbd_task);
}
