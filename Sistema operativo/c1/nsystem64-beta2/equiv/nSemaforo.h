/*************************************************************
 * nSemaforo.c
 *************************************************************/

typedef nTask Sem;

Sem MakeSem(int n);
void Wait(Sem S);
void Signal(Sem S);
void DeleteSem(Sem S);
int SemAdm(int n);
