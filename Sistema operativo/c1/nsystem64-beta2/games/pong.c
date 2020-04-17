#include "tty.h"

int Ball();
float accy;
float velx;
float vely;

nMain(int argc, char **argv)
{
  int ch;
  nTask ball_task1;
  nTask ball_task2;
  nTask ball_task3;
  double atof();

  velx= argc>=2 ? atof(argv[1]) : 0.01;
  vely= argc>=3 ? atof(argv[2]) : 0.001;
  accy= argc>=4 ? atof(argv[3]) : 0.0001;

  InitTty();

  ClearTty();

  ball_task1= nEmitTask(Ball, 50, 2.0*velx, vely);  
  ball_task2= nEmitTask(Ball, 50, velx, 1.5*vely);
  ball_task3= nEmitTask(Ball, 50, 0.5*velx, 2.0*vely);

  PrintTty(1, LINES-2, "*** tipee un caracter para terminar (%dx%d) ***",
           LINES, COLS);
  RefreshTty();

  ch= GetchTty();
  nPrintf("ch=%d\n", ch);

  CallServer(ball_task1, QUIT);
  nWaitTask(ball_task1);
  CallServer(ball_task2, QUIT);
  nWaitTask(ball_task2);
  CallServer(ball_task3, QUIT);
  nWaitTask(ball_task3);

  ClearToEOL(1, LINES-2);
  PrintTty(1, LINES-2, "Adios");

  EndTty();
}

int Ball(period, vx, vy)
int period;
float vx;
float vy;
{
  int quit_ball= 0;
  float x= 1.0, y= 12.0;
 
  nSetTaskName("Pelota (periodo=%d)", period);

  while ( ! quit_ball )
  {
    nTask sender;
    Request *req;

    PrintTty((int)y, (int)x, "o");
    RefreshTty();
    req= (Request *)nReceive(&sender, period);
    PrintTty((int)y, (int)x, " ");

    if (req!=NULL)
    { 
      quit_ball= 1;
      nReply(sender, 0);
    }

    vy+= (float)period*accy;

    x+= (float)period*vx;
    y+= (float)period*vy;

    if (x<1.0) { vx= -vx; x= 1.0; }
    if ((int)x > COLS) { vx= -vx; x= COLS; }
    if (y<1.0) { vy= -vy; y= 1.0; }
    if ((int)y> LINES-2) { vy= -vy; y= LINES-2; }
  }

  return 0;
}
