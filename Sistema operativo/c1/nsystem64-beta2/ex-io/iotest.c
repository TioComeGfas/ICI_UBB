#include "nSystem.h"

char buf[160];
int size=0;

int Reader(fd)
{
  nSetTaskName("lector");
  size= nRead(fd, buf, 160);
}

int nowrites=0;

int nMain(int argc, char **argv)
{
  nTask taskreader;

  nSetNonBlockingStdio();

  nSetTimeSlice(2000);
  taskreader= nEmitTask(Reader, 0);

  while (size==0)
  {
    int i;
    /* Este es un nSleep encubierto */
    for (i=0; i< 1000000; i++)
      if (size>0) break;

    nowrites++;
    nWrite(1, "Ingrese cualquier cosa\n", 23);
  }

  nWaitTask(taskreader);

  nWrite(1,"Ok, muchas gracias\n", 19);
  nWrite(1, buf, size);
  nWrite(1,"\n", 1);

  return 0;
}
