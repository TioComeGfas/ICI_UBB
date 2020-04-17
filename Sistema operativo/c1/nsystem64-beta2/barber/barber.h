#include <nSystem.h>

/* TICKET: Este es el ticket que recibe el padre cuando ordena un corte
 * de pelo. Necesita presentar este ticket cuando lo pasa a buscar.
 */

typedef nTask TICKET; /* Cambie esto si lo desea */

/************************************************************
 * Procedimientos ya implementados en personajes.c
 *************************************************************/

/* La madre: la madre lleva a su hijo con el pelo largo y espera
 *   a que el peluquero atienda a su hijo.
 *
 *   mother es la madre y debe corresponder a una letra mayuscula,
 *   child es el hijo y debe ser la misma letra que la madre pero en minuscula,
 *   row es una fila en la pantalla (un nro. entre 1 y 24),
 *   delay son los segundos que toma cortarle el pelo al nin~o.
 */

int Mother(char mother, char child, int row, int delay);

/* El padre: el padre deja a su hijo en la peluqueria y regresa a trabajar.
 *   Recibe un ticket que tiene que mostrar mas tarde cuando pasa a
 *   retirar al hijo.  Eventualmente, tendra que esperar si el peluquero
 *   todavia no atiene a su hijo.  Esto es probable, puesto que el
 *   peluquero da prioridad a los padres o madres que estan presentes en
 *   la peluqueria.
 *
 *   father es el padre y debe corresponder a una letra mayuscula,
 *   child es el hijo y debe ser la misma letra que el padre pero en minuscula,
 *   row es una fila en la pantalla (un nro. entre 1 y 24),
 *   delay son los segundos que toma cortarle el pelo al nin~o.
 *   worksecs son los segundos que trabaja el padre antes de regresar
 *   a buscar el hijo.
 */

int Father(char father, char child, int row, int delay, int worksecs);

/* El peluquero:
 *   row es la fila de la pantalla, child es el hijo y
 *   delay son los segundos que toma el peluquero en cortar el pelo.
 */

void DoHairCut(char child, int row, int delay);

/************************************************************
 * Procedimientos y tipos por implementar.
 * Los que se proveen en single.c solo funcionan con un padre y nin~o.
 * Hay que reimplementarlos para que funcionen con varios padres y nin~os.
 *************************************************************/

/* InitBarber: Inicializa la peluqueria */

void InitBarber();

/* FastHairCut: Pide un corte de pelo para child, que se encuentra en
 * la fila row.  Este procedimiento se bloquea por los delay segundos
 * que toma el corte de pelo, mas el tiempo que corresponda esperar
 * a que se desocupe un peluquero.
 */

void FastHairCut(char child, int row, int delay);

/* OrderHairCut: Ordena un corte de pelo para child que se encuentra
 * en la fila row.  El corte de pelo necesita delay segundos de trabajo.
 * Retorna un ticket identificador para que el
 * padre pueda pasar a buscar a su hijo mas tarde.
 */

TICKET OrderHairCut(char child, int row, int delay);

/* Peek: Pasa a buscar el hijo.  Eventualmente se bloquea si el corte
 * no esta listo hasta que el peluquero termine.
 */

int Peek(TICKET id);
