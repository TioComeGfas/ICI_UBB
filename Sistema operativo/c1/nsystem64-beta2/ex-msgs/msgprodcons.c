#include "nSystem.h"

/* Este ejemplo no termina nunca.  Solo chequea la robustez de nSystem */

nSem rand_sem;

int myrand()
{
  int ret;
  nWaitSem(rand_sem);
  ret= rand();
  nSignalSem(rand_sem);
  return ret;
}

int Producer( nTask consumer_task, int NoOfItems, int maxdelay )
{
  int i, product, sum=0;

  nSetTaskName("Productor");

  for (i= 0; i < NoOfItems; i++)
  {
    nSleep(maxdelay);
    product= myrand() % 100 + 1; /* random deberia ser una seccion critica */
    sum+= product;
    nSend(consumer_task, &product);
  }

  product = -1;
  nSend(consumer_task, &product);
  return sum;
}

int Consumer(int maxdelay)
{
  int product, sum=0;
  int nonblocking=0;
  int failed=0;

  nSetTaskName("Consumidor");

  for (;;)
  {
    nTask producer_task;
    int *pproduct;
    int product;

    if ((pproduct= (int*)nReceive(&producer_task, 0))==NULL)
    {
      while ((pproduct= (int*)nReceive(&producer_task, maxdelay))==NULL)
        failed++;
    }
    else nonblocking++;

    product= *pproduct;
    nReply(producer_task, 0);

    if ( product < 0 ) break;
    sum+= product;
  }

  /* nPrintf("Consumidor: no bloqueantes= %d, timeout=%d\n", nonblocking, failed); */

  return sum;
}

int ProdCons(int NoOfItems, int maxdelay)
{
  nTask producer_task, consumer_task;
  int sum_prod, sum_cons;

  nSetTaskName("Productor/Consumidor");

  consumer_task = nEmitTask(Consumer, maxdelay);
  producer_task = nEmitTask(Producer, consumer_task, NoOfItems, maxdelay);

  if (nWaitTask(consumer_task)!=nWaitTask(producer_task))
    nFatalError("ProdCons", "la suma no coincide\n");

  return 0;
}

#define NTASKS 10000

nMain(int argc, char **argv)
{
  nTask tasks[NTASKS];
  int i;
  int slice= argc>=2 ? atoi(argv[1]) : 100;
  int ntasks= argc>=3 ? atoi(argv[2]) : 10;
  int NoOfItems= argc>=4 ? atoi(argv[3]) : 100;
  int maxdelay= argc>=5 ? atoi(argv[4]) : 10;

  nSetTimeSlice(slice);
  rand_sem= nMakeSem(1);

  for(i=0; i<ntasks; i++) tasks[i]= NULL;

  for(;;)
  {
    for(i=0; i<ntasks; i++)
    {
      if (tasks[i]!=NULL) nWaitTask(tasks[i]);
      tasks[i]= nEmitTask(ProdCons, NoOfItems, maxdelay);
    }

    { int qlength= nGetQueueLength();
      nPrintf("%d tareas ready, %d cambios de contexto implicitos\n",
               qlength, nGetContextSwitches());
    }
  }
}
