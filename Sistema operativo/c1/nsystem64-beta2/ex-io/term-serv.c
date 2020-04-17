#include "nSystem.h"

int mainfdout;
char *ttyout;

int Reader(char *ttyin)
{
  int winfd= nOpen(ttyin, O_RDWR, 0);
  char buff[80];
  int size;

  nSetTaskName("Reader %s", ttyin);

  nFprintf(winfd, "******************************************************\n");
  nFprintf(winfd, "Esta es : %s\n", ttyin);
  nFprintf(winfd, "Cualquier cosa que escriba aparecera en %s\n", ttyout);
  nFprintf(winfd, "Termine con quit\n");

  do
  {
    size= nRead(winfd, buff, 80);
    buff[size]='\0';
    nFprintf(mainfdout, "Tipeado desde %s : %s", ttyin, buff);
  }
    while (strncmp(buff,"quit\n",5)!=0);

  nFprintf(winfd,"Lista esta ventana, no tipee nada mas\n");
  nClose(winfd);

  return 0;
}

int nMain(int argc, char **argv)
{
  nTask taskreader1;
  nTask taskreader2;

  nSetTimeSlice(2);

  ttyout= argv[1];
  mainfdout= nOpen(argv[1], O_WRONLY, 0);
  nFprintf(mainfdout, "Esta es %s\n", ttyout);
  nFprintf(mainfdout,"Aqui se refleja lo tipeado en las dos otras ventanas\n");

  taskreader1= nEmitTask(Reader, argv[2]);
  taskreader2= nEmitTask(Reader, argv[3]);

  nWaitTask(taskreader1);
  nWaitTask(taskreader2);

  nFprintf(mainfdout, "Listas las dos ventanas.  Adios\n");
  nClose(mainfdout);

  return 0;
}
