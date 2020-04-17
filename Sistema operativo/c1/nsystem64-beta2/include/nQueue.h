
/*************************************************************
 * nQueue.c
 *************************************************************/

#define TYPE_QUEUE  1
#define TYPE_SQUEUE 2
/*
 * Manejo de colas FIFO
 */

typedef struct Queue
{
  int   type;
  nTask first;
  nTask *last;
}
  *Queue; /* Atencion, una cola es un puntero */

/* Las siguientes funciones deben ser siempre invocadas con las
 * interrupciones deshabilitadas
 */

Queue MakeQueue();                      /* El constructor */
void PutTask(Queue queue, nTask task);  /* Agrega una tarea al final */
void PushTask(Queue queue, nTask task); /* Agrega una tarea al principio */
nTask GetTask(Queue queue);             /* Extrae la primera tarea */
int EmptyQueue(Queue queue);            /* Verdadero si la cola esta vacia */
int QueueLength(Queue queue);           /* Entrega el largo de la cola */
int QueryTask(Queue queue, nTask task); /* Verdadero si task esta en la cola */
void DeleteTaskQueue(Queue queue, nTask task );
                                        /* Borra una tarea de la cola */
void DestroyQueue(Queue queue);         /* El destructor */

#define DeleteTaskInQueue DeleteTaskQueue

/*
 * Manejo de colas ordenadas por tiempo
 */

typedef struct Squeue
{
  int type;
  nTask first;
}
  *Squeue;

Squeue MakeSqueue();
void PutTaskSqueue(Squeue squeue, nTask task, int wake_time);
nTask GetTaskSqueue(Squeue squeue);
int GetNextTimeSqueue(Squeue squeue);
int EmptySqueue(Squeue squeue);
void DeleteTaskSqueue(Squeue squeue, nTask task);
void DestroySqueue(Squeue squeue);

#define DeleteTaskInSqueue DeleteTaskSqueue
