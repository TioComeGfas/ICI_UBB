/* Crea varios productores/consumidores que trabajan en paralelo.
 * Invocacion:
 *   prodcons <tajada> <nro. de prod/cons> <nro. de items> <taman~o del buffer>
 *
 * Este programa no termina nunca, pero no deberia caerse.  En cada
 * iteracion imprime el numero de cambios de contexto que han ocurrido
 * desde el lanzamiento del programa.
 *
 * Util para chequear la robustez de nSystem.
 */

#include "nSystem.h"

#define MAXQUEUESIZE 100

extern long lrand48( void );

typedef struct Buff
{
  int front, back;
  int size;
  nSem full, empty;
  int queue[MAXQUEUESIZE];
} Buff;

nSem rand_sem;

int myrand()
{
  int ret;
  nWaitSem(rand_sem);
  ret= lrand48();
  nSignalSem(rand_sem);
  return ret;
}

int Producer( Buff *q, int NoOfItems )
{
  int i, product, sum=0;

  for (i= 0; i < NoOfItems; i++)
  {
    product= myrand() % 100 + 1; /* lrand deberia ser una seccion critica */
    sum+= product;
    nWaitSem( q->empty );
    q->queue[q->back] = product;
    q->back = ( q->back + 1 ) % q->size;
    nSignalSem( q->full );
  }

  product = -1;
  nWaitSem( q->empty );
  q->queue[q->back] = product;
  q->back = ( q->back + 1 ) % q->size;
  nSignalSem( q->full );
  return sum;
}

int Consumer( Buff *q )
{
  int product, sum=0;

  for (;;)
  {
    nWaitSem( q->full );
    product = q->queue[q->front];
    q->front = ( q->front + 1 ) % q->size;
    nSignalSem( q->empty);
    if ( product < 0 ) break;
    sum+= product;
  }

  return sum;
}

int ProdCons(int NoOfItems, int size)
{
  Buff Q;
  nTask task_prod, task_cons;
  int sum_prod, sum_cons;

  Q.front= Q.back= 0;
  Q.size= size;
  Q.full= nMakeSem(0);
  Q.empty= nMakeSem(Q.size);

  task_prod = nEmitTask(Producer, &Q, NoOfItems);
  task_cons = nEmitTask(Consumer, &Q);

  if (nWaitTask(task_prod)!=nWaitTask(task_cons))
    nFatalError("ProdCons", "la suma no coincide\n");

  nDestroySem(Q.full);
  nDestroySem(Q.empty);

  return 0;
}

nMain(int argc, char **argv)
{
  int i;
  int slice= argc>=2 ? atoi(argv[1]) : 2;
  int ntasks= argc>=3 ? atoi(argv[2]) : 10;
  int NoOfItems= argc>=4 ? atoi(argv[3]) : 100;
  int size= argc>=5 ? atoi(argv[4]) : 10;
  nTask *tasks= nMalloc(ntasks*sizeof(nTask));

  nSetTimeSlice(slice);
  rand_sem= nMakeSem(1);

  for(i=0; i<ntasks; i++) tasks[i]= NULL;

  for(;;)
  {
    for(i=0; i<ntasks; i++)
    {
      if (tasks[i]!=NULL) nWaitTask(tasks[i]);
      tasks[i]= nEmitTask(ProdCons, NoOfItems, size);
    }

    nPrintf("cambios de contexto=%d\n", nGetContextSwitches());
  }
}
