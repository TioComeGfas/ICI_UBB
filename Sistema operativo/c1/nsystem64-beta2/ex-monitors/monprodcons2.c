#include <nSystem.h>

/************************************************************************
 * Implementacion de un Buffer usando monitores
 *
 * (Este codigo no ha sido aun completamente depurado, de modo que
 * si detecta errores, no vacile en sen~alarlos en uch.ing.cursos.cc41b)
 *
 ************************************************************************/

typedef struct
{
  nMonitor mon;
  nCondition noempty, nofull;
  int size;
  int *pool;
  int in, out, count;
}
  *Buffer;

/*
 * Operaciones:
 */

Buffer MakeBuffer(int size); /* Construye un buffer de taman~o size */
void PutBuffer(Buffer buff, int item); /* Coloca item en el buffer */
int GetBuffer(Buffer buff); /* Extrae un item del buffer */

Buffer MakeBuffer(int size)
{
  Buffer buff= (Buffer)nMalloc(sizeof(*buff));
  buff->mon= nMakeMonitor();
  buff->size= size;
  buff->pool= (int*)nMalloc(size*sizeof(int));
  buff->in= 0;
  buff->out= 0;
  buff->count= 0;

  return buff;
}

void DestroyBuffer(Buffer buff)
{
  nDestroyMonitor(buff->mon);
  nFree(buff->pool);
  nFree(buff);
}

void  PutBuffer(Buffer buff, int item)
{
  nEnter(buff->mon);

  while (buff->count==buff->size)
    nWait(buff->mon);

  buff->pool[buff->in]= item;
  buff->in= (buff->in+1) % buff->size;
  buff->count++;
  nNotifyAll(buff->mon);

  nExit(buff->mon);
}

int GetBuffer(Buffer buff)
{
  int item;
  nEnter(buff->mon);

  while (buff->count==0)
    nWait(buff->mon);

  item= buff->pool[buff->out];
  buff->out= (buff->out+1) % buff->size;
  buff->count--;
  nNotifyAll(buff->mon);

  nExit(buff->mon);

  return item;
}

/************************************************************************
 * Ejemplo de uso de Buffer: Crea un lote de productores/consumidores
 * concurrentes.  Cada par productor/consumidor opera con su propio
 * monitor.  Este ejemplo se corre en modo preemptive, lo que hace
 * la depuracion muy dificil.  Para simplificar la depuracion, suprima
 * la linea nSetTimeSlice del main, para hacer que el scheduling
 * sea non-preemtive.  Pero cuidado, su tarea sera probada en modo preemtive,
 * de modo que una vez que funcione en modo non-preemtive, vuelva a agregar
 * la linea y verifique nuevamente que su tarea funciona.  Si no funciona
 * tendra que depurar en el modo dificil ... 8^(
 ************************************************************************/

nSem rand_sem;

int myrand()
{
  int ret;
  nWaitSem(rand_sem);
  ret= rand();
  nSignalSem(rand_sem);
  return ret;
}

int Producer(Buffer buff, int NoOfItems )
{
  int i, item, sum=0;

  nSetTaskName("Productor");

  for (i= 0; i < NoOfItems; i++)
  {
    item= myrand() % 100 + 1; /* random deberia ser una seccion critica */
    sum+= item;
    PutBuffer(buff, item);
  }

  PutBuffer(buff, -1);
  return sum;
}

int Consumer(Buffer buff)
{
  int item, sum=0;

  nSetTaskName("Consumidor");

  for (;;)
  {
    int item= GetBuffer(buff);
    if ( item < 0 ) break;
    sum+= item;
  }

  return sum;
}

int ProdCons(int NoOfItems)
{
  nTask producer_task, consumer_task;
  Buffer buff= MakeBuffer(10);
  int sum_prod, sum_cons;

  nSetTaskName("Productor/Consumidor");

  consumer_task = nEmitTask(Consumer, buff);
  producer_task = nEmitTask(Producer, buff, NoOfItems);

  if (nWaitTask(consumer_task)!=nWaitTask(producer_task))
    nFatalError("ProdCons", "la suma no coincide\n");

  DestroyBuffer(buff);

  return 0;
}

#define NTASKS 1000

nMain(int argc, char **argv)
{
  nTask tasks[NTASKS];
  int i;
  int slice= argc>=2 ? atoi(argv[1]) : 2;
  int ntasks= argc>=3 ? atoi(argv[2]) : 30;
  int NoOfItems= argc>=4 ? atoi(argv[3]) : 100;
  int rounds= argc>=5 ? atoi(argv[4]) : 40;

  nSetTimeSlice(slice);
  rand_sem= nMakeSem(1);

  for(i=0; i<ntasks; i++) tasks[i]= NULL;

  while (rounds--)
  {
    for(i=0; i<ntasks; i++)
    {
      if (tasks[i]!=NULL) nWaitTask(tasks[i]);
      tasks[i]= nEmitTask(ProdCons, NoOfItems);
    }
    nPrintf(" Ok (restan %d)\n", rounds);
  }

  for(i=0; i<ntasks; i++) nWaitTask(tasks[i]);

  nPrintf(" Good\n");

  return 0;
}
