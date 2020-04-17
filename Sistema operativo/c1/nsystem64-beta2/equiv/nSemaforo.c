/*
 * Implementacion de Semaforos para nSystem, usando Mensajes
 *
 * Ej de uso: 
 * 
 * en Tarea X:
 *   
 *  Sem S = MakeSem(1);
 *  nTask Ty = nEmitTask( Funcion, .. , S, ...);
 *  nTask Tz = nEmitTask( Funcion, .. , S, ...);
 *  nWaitTask(Ty);  
 *  nWaitTask(Tz);
 *  DeleteSem(S);
 *
 * en Funcion:
 *
 *  ....
 *  Wait(S);
 *  <S.C.>
 *  Signal(S);
 *  ...
 * 
 * (OJO : Es solo un ejemplo, muchas cosas se pueden hacer de
 * manera de diferente)
 */

#include "nSysimp.h"
#include "nSemaforo.h"


/*
 * Se crea una tarea que actuara como Administrador (un servidor por cada
 * semaforo), para responder a las solicitudes de Wait y Signal que 
 * hagan las tareas que usan el semaforo
 */


Sem MakeSem(int n)
{
    return (Sem) nEmitTask(SemAdm, n);
}

void Wait(Sem S)
{
    char c = 'w';
    nSend(S, &c);
}
    
void Signal(Sem S)
{
    char c = 's';
    nSend(S, &c);
}

void DeleteSem(Sem S)
{
    char c = 'q';
    nSend(S, &c);
    nWaitTask(S);
}

/* Administrador de Semaforos */

int SemAdm(int n)
{
    int count = n;
    char op, *pop;
    nTask Task_id;

    Queue waitqueue = MakeQueue(); /* Creamos una cola para las tareas
                                      que estan bloqueadas por hacer
                                      Wait y encontrar count == 0 */

    for(;;){
        pop = (char *) nReceive(&Task_id, -1);
        op = *pop;

        if (op == 'w')
            if (count == 0)
                /* la tarea que hizo Wait queda bloqueada,
                   pues no hacemos reply */
                PutTask(waitqueue, Task_id);
            else{
                nReply(Task_id, 0);
                count--;
            }
        else if (op == 's'){
            nReply(Task_id, 0);     /* hacemos reply de inmediato, pues
                                       Signal no es bloqueante */
            if (EmptyQueue(waitqueue))
                count++;
            else
                /* desbloqueamos la primera tarea en la cola */ 
                nReply(GetTask(waitqueue), 0);
        }
        else if (op == 'q'){
            nReply(Task_id, 0);
            break;
        }
    }
    return 0;
}
