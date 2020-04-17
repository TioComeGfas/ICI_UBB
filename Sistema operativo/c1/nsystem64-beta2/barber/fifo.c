#include "barber.h"

nSem sem_barber;

void InitBarber()
{
  sem_barber= nMakeSem(2);
}  

void EndBarber()
{
}

void FastHairCut(char child, int row, int delay)
{
  nWaitSem(sem_barber);
  DoHairCut(child, row, delay);
  nSignalSem(sem_barber);
}

int Child(char child, int row, int delay)
{
  nWaitSem(sem_barber);
  DoHairCut(child, row, delay);
  nSignalSem(sem_barber);

  return 0;
}

TICKET OrderHairCut(char child, int row, int delay)
{
  return nEmitTask((nProc)Child, child, row, delay);
}

int Peek(TICKET id)
{
  nWaitTask(id);
}
