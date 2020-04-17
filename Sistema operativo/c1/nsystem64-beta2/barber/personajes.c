#include "barber.h"
#include <stdlib.h>

#define LEFTCOL  20
#define RIGHTCOL 60
#define TIMESTEP 50

int Mother(char mother, char child, int row, int delay)
{
  int col;

  PrintTty(row, 10, "Madre");

  /* Caminar hasta la peluqueria */
  for (col= LEFTCOL; col<=RIGHTCOL; col++)
  {
    PrintTty(row,   col, " %c~%c", mother, child);
    nSleep(TIMESTEP); /* Hace una pausa */
  }

  /* Corte de pelo */
  FastHairCut(child, row, delay);

  /* Regresar */
  for (col= RIGHTCOL; col>=LEFTCOL; col--)
  {
    PrintTty(row,   col, "%c%c  ", mother, child);
    nSleep(TIMESTEP); /* Solo para dar una pausa */
  }

  return 0;
}

int Father(char father, char child, int row, int delay, int worksecs)
{
  TICKET id;
  int col;

  PrintTty(row, 10, "Padre");

  /* Caminar hasta la peluqueria */
  for (col= LEFTCOL; col<=RIGHTCOL; col++)
  {
    PrintTty(row,   col, " %c~%c", father, child);
    nSleep(TIMESTEP); /* Hace una pausa */
  }

  /* Ordenar el corte de pelo */
  id= OrderHairCut(child, row, delay);

  /* Regresar a trabajar */
  for (col= RIGHTCOL; col>=LEFTCOL; col--)
  {
    PrintTty(row,   col, "%c ", father);
    nSleep(TIMESTEP);
  }

  /* Trabajar */
  nSleep(worksecs*1000);

  for (col= LEFTCOL; col<=RIGHTCOL; col++)
  {
    PrintTty(row,   col, " %c", father);
    nSleep(TIMESTEP); /* Solo para dar una pausa */
  }

  Peek(id);

  for (col= RIGHTCOL; col>=LEFTCOL; col--)
  {
    PrintTty(row,   col, "%c%c  ", father, child);
    nSleep(TIMESTEP); /* Solo para dar una pausa */
  }

  return 0;
}

void DoHairCut(char child, int row, int delay)
{
  int time= 0;

  while (time<delay*1000)
  {
    PrintTty(row, RIGHTCOL+5,">%%"); /* Una tijera abierta */
    nSleep(TIMESTEP*2);
    PrintTty(row, RIGHTCOL+5,"-%%"); /* Una tijera cerrada */
    nSleep(TIMESTEP*2);
    time+= TIMESTEP*4;
  }

  PrintTty(row, RIGHTCOL+2, " ");   /* Borra el ~ que representa */
                                   /* el pelo largo */
  PrintTty(row, RIGHTCOL+5, "  ");  /* Borra la tijera */
}
