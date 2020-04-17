/*
 * compile con : make
 * 
 * Programa Demostrativo: 2 tareas leen el valor de una variable compartida 
 * del uso de             y si es menor que 40 la incrementan en 1.
 * semaforos              De esta manera, la variable debiera terminar con
 *                        valor 40. Por que queda con 41????
 *
 * Nota: Ver el comportamiento con y sin usar semaforos para sincronizar.
 *       Por que se produce la diferencia??
 */

#include "nSystem.h"
#include "nSemaforo.h"

int i = 0;   /* variable compartida */

int Funcion(int Num, Sem S) 
{
    int inc = 0; /* Incremento hecho solo por esta tarea */
    int j;

    nSetTaskName("Tarea %d", Num);

    for (;i<40;) {

        Wait(S);
            /* Seccion Critica */
            if (i< 40){
                for(j=0; j<10000; j++)  /* gasta tajada de CPU */
                    ;

                i++;    
                inc++;
            }
        Signal(S);
    }
    return inc;
}


nMain()
{
    Sem             S = MakeSem(1);
    nTask           T_1, T_2;
    int             veces1, veces2;

    nSetTimeSlice(1); /* Esquema Round_Robin (El Cambio de Contexto puede
                         llegar en cualquier parte de la ejecucion) */

    T_1 = nEmitTask(Funcion, 1, S);
    T_2 = nEmitTask(Funcion, 2, S);

    veces1 = nWaitTask(T_1);
    veces2 = nWaitTask(T_2);

    DeleteSem(S);

    nPrintf("\n\tRESULTADOS\n\nLa variable i quedo con el valor %d\n", i);
    nPrintf("La tarea 1 incremento en %d la variable i\n", veces1);
    nPrintf("La tarea 2 incremento en %d la variable i\n\n\n", veces2);
}
