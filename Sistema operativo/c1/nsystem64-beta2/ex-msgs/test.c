#include "nSystem.h"

/*************************************************************
 * Programa de test. Invocacion:
 *
 *   test <tajada> <tareas> <simul> <items> <sleep>
 *
 * en donde:
 *
 * <tajada> : la tajada de tiempo del scheduler.
 * <tareas> : total de productores/consumidores que seran lanzados.
 * <simul>  : nro. de productores/consumidores que corren simultanemente.
 * <items>  : nro. de items que genera el productor.
 * <sleep>  : tiempo maximo de produccion y consumo
 *
 * Algunos ejemplos del tiempo que debe tomar test:
 *
 * time ./test 0 1 1 10 500         -> poco mas de 5 segundos
 * time ./test 0 10 10 10 500       -> poco mas de 5 segundos
 * time ./test 0 10 5 10 500        -> poco mas de 10 segundos
 * time ./test 0 10 1 10 500        -> poco mas de 50 segundos
 * time ./test 2 1000 25 100 0   -> mucho tiempo pero no se cae!
 *************************************************************/


/* Atencion: hecho solo para probar tareas,
 *           no fijarse en la elegancia del codigo 8^)
 */

int Producer( nTask consumer_task, int NoOfItems, int sleep_time )
{
  int i, product, sum=0;

  nSetTaskName("Productor");

  for (i= 0; i < NoOfItems; i++)
  {
    nTask dummy_task;
    product= (myrand() % 100)*sleep_time/100;
                       /* random deberia ser una seccion critica */
    nReceive(&dummy_task, product);
    if (dummy_task!=NULL) nFatalError("Producer", "??\n");
    sum+= product;
    nSend(consumer_task, &product);
  }

  product = -1;
  nSend(consumer_task, &product);
  return sum;
}

int Consumer(int sleep_time )
{
  int product, sum=0;

  nSetTaskName("Consumidor");

  for (;;)
  {
    nTask producer_task;
    nTask dummy_task;
    int *pproduct;
    int product;

    pproduct= (int*)nReceive(&producer_task, -1);
    product= *pproduct;
    nReceive(&dummy_task, sleep_time-product); /* un sleep encubierto */
    if (dummy_task!=NULL) nFatalError("Consumer", "??\n");
    nReply(producer_task, 0);

    if ( product < 0 ) break;
    sum+= product;
  }

  return sum;
}

int ProdCons(int NoOfItems, int sleep_time )
{
  nTask producer_task, consumer_task;
  int sum_prod, sum_cons;

  nSetTaskName("Productor/Consumidor");

  consumer_task = nEmitTask(Consumer, sleep_time);
  producer_task = nEmitTask(Producer, consumer_task, NoOfItems, sleep_time);

  sum_prod=nWaitTask(consumer_task);
  sum_cons=nWaitTask(producer_task);
  if (sum_prod!=sum_cons)
    nFatalError("ProdCons", "la suma no coincide\n");

  return 0;
}

#define NTASKS 1000

nSem rand_sem;

int myrand()
{
  int ret;
  nWaitSem(rand_sem);
  ret= rand();
  nSignalSem(rand_sem);
  return ret;
}

nMain(int argc, char **argv)
{
  nTask tasks[NTASKS];
  int i;
  int slice= argc>=2 ? atoi(argv[1]) : 10;
  int tottasks= argc>=3 ? atoi(argv[2]) : 100;
  int ntasks= argc>=4 ? atoi(argv[3]) : 10;
  int NoOfItems= argc>=5 ? atoi(argv[4]) : 100;
  int sleep_time= argc>=6 ? atoi(argv[5]) : 1000;

  if (ntasks>NTASKS) ntasks= NTASKS;

  nSetTimeSlice(slice);
  rand_sem= nMakeSem(1);

  for(i=0; i<ntasks; i++) tasks[i]= NULL;

  while (tottasks>0)
  {
    for(i=0; i<ntasks && tottasks>0; i++)
    {
      if (tasks[i]!=NULL) nWaitTask(tasks[i]);
      tasks[i]= nEmitTask(ProdCons, NoOfItems, sleep_time);
      tottasks--;
    }

    nPrintf("cambios de contexto=%d\n", nGetContextSwitches());
  }

  for(i=0; i<ntasks; i++) if (tasks[i]!=NULL) nWaitTask(tasks[i]);

  return 0;
}
