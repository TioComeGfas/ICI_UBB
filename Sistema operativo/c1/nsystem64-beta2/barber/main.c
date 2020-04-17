#include "barber.h"

void Prompt1(char* msg)
{
  PrintTty(2, 10, "                                                         ");
  PrintTty(2, 10, msg);
}

void Prompt2(char* msg)
{
 PrintTty(4, 10, "                                                          ");
 PrintTty(4, 10, msg);
}

int nMain(int argc, char** argv)
{
  nTask p1, p2, p3, p4, p5, p6;

  InitTty();
  ClearTty();

  InitBarber();

  Prompt1("Las madres esperan en la peluqueria");
  p1= nEmitTask((nProc)Mother, 'M', 'm', 8, 5);
  nSleep(1000);
  p2= nEmitTask((nProc)Mother, 'N', 'n', 10, 5);
  nSleep(1000);
  p3= nEmitTask((nProc)Mother, 'O', 'o', 12, 5);
  nSleep(1000);
  p4= nEmitTask((nProc)Mother,  'L', 'l', 14, 5);
  Prompt2("Deben haber 2 peluqueros trabajando");
  nSleep(2000);
  Prompt2("Las madres se atienden en orden FIFO: M N O L");
  nWaitTask(p1);
  nWaitTask(p2);
  nWaitTask(p3);
  nWaitTask(p4);

  ClearTty();

  Prompt1("Los padres dejan a los hijos en la peluqueria");
  p1= nEmitTask((nProc)Father, 'P', 'p', 8, 5, 3);
  nSleep(2000);
  Prompt2("P se va a trabajar");
  nSleep(5000);
  Prompt2("El corte de p esta listo. P regresa a buscar al hijo.");
  nSleep(2000);
  Prompt2("P se lleva al hijo");
  nWaitTask(p1);

  p2= nEmitTask((nProc)Father, 'Q', 'q', 10, 8, 1);
  nSleep(5000);
  Prompt2("Q tiene que esperar a que termine el corte del hijo");
  nWaitTask(p2);

  ClearTty();
  Prompt1("Prioridad a los padres con mayor permanencia en la peluqueria");
  p1= nEmitTask((nProc)Mother, 'M', 'm', 8, 24);
  nSleep(2000);
  Prompt2("Este pelo esta largo.  Tomara muuuuucho tiempo");
  p2= nEmitTask((nProc)Mother, 'N', 'n', 10, 10);
  nSleep(2000);
  p3= nEmitTask((nProc)Father, 'P', 'p', 12, 4, 2);
  nSleep(4000);
  p4= nEmitTask((nProc)Mother, 'O', 'o', 14, 3);
  nSleep(6000);
  Prompt2("Se atiende primero a O, porque llego antes que P regresara");
  nSleep(3000);
  p5= nEmitTask((nProc)Mother, 'L', 'L', 16, 3);
  nSleep(3000);
  Prompt2("Ahora si se atiende a P, porque volvio antes que llegara L");

  nWaitTask(p1);
  nWaitTask(p2);
  nWaitTask(p3);
  nWaitTask(p4);
  nWaitTask(p5);

  EndBarber();
  EndTty();
  return 0;
}
