#include "ladder.h"

#define TTY_CHARS ((3+TTY_LINES+1)*(3+TTY_COLS+2))

static struct { char txt[TTY_CHARS]; } s_read_ladder, s_ladder;
static char *ladder[1+TTY_LINES+1];
static char *read_ladder[1+TTY_LINES+1];

void InitLadder(char *filename)
{
  int fd;
  int y, disp;

  InitTty();
  ClearTty();

  if (LINES!=24 || COLS!=80)
  {
    EndTty();
    nFatalError("InitLadder", "%s\n(%s %dx%d)\n",
                "Ud. debe correr este programa en una ventana de 24x80.",
                "Su ventana es de ", LINES, COLS);
  }

  fd= nOpen(filename, O_RDONLY);
  if (fd<0)
    nFatalError("ReadLadder", "No se pudo abrir el archivo %s\n", filename);

  if (nRead(fd, s_read_ladder.txt, TTY_CHARS) < TTY_CHARS)
    nFatalError("ReadLadder", "No se pudo leer el archivo %s\n", filename);

  s_ladder= s_read_ladder; /* copia todo el arreglo */

  disp= 2*(3+TTY_COLS+2)+2;
  for (y=0; y<1+TTY_LINES+1; y++)
  {
    ladder[y]= &s_ladder.txt[disp];
    ladder[y][82]= '\0';
    read_ladder[y]= &s_read_ladder.txt[disp];
    disp += 3+TTY_COLS+2;
  }
  for(y=1; y<=TTY_LINES; y++)
    PrintTty(y, 1, "%s", &ladder[y][1]);
  RefreshTty();
}

int Put(char new_object, int y, int x)
{
  char old_object= ladder[y][x];
  ladder[y][x]= new_object;
  PrintTty(y, x, "%c", new_object);
  RefreshTty();
  return old_object;
}

int Get(int y, int x)
{
  return ladder[y][x];
}

void Restore(int y, int x)
{
  int old_object= read_ladder[y][x];
  ladder[y][x]= old_object;

  PrintTty(y, x, "%c", old_object);
}

void EndLadder()
{
  EndTty();
}
