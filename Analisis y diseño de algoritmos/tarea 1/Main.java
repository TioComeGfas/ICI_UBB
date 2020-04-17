/**
 * Problema de la suma de la subsecuencia maxima
 */

package modelo;

import java.util.Random;

/**
 * @author TioComeGfas
 */
class Main {

    public static void main(String[] args) {
        int[] a10 = new int[10];
        int[] a50 = new int[50];
        int[] a100 = new int[100];
        int[] a500 = new int[500];
        int[] a1000 = new int[1000];

        long x;
        long y;

        System.out.println("---------------------------");
        System.out.println("TRABAJANDO CON 10 NUMEROS");
        rellenarArray(a10, 10);
        System.out.print("SSM1: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm1(a10, 10);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM1: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM2: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm2(a10, 10);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM2: " + (y - x) + " milisegundos");

        System.out.println();
        System.out.println();
        System.out.print("SSM3: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm3(a10, 10);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM3: " + (y - x) + " milisegundos");
        System.out.println();
        System.out.println();

//arreglo con valor 50
        System.out.println("---------------------------");
        System.out.println("TRABAJANDO CON 50 NUMEROS");
        rellenarArray(a50, 50);
        System.out.print("SSM1: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm1(a50, 50);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM1: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM2: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm2(a50, 50);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM2: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM3: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm3(a50, 50);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM3: " + (y - x) + " milisegundos");
        System.out.println();
        System.out.println();
        
//arreglo con valor 100   

        System.out.println("---------------------------");
        System.out.println("TRABAJANDO CON 100 NUMEROS");
        rellenarArray(a100, 100);
        System.out.print("SSM1: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm1(a100, 100);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM1: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM2: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm2(a100, 100);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM2: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM3: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm3(a100, 100);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM3: " + (y - x) + " milisegundos");
        System.out.println();
        System.out.println();
        
//arreglo con valor 500        

        System.out.println("---------------------------");
        System.out.println("TRABAJANDO CON 500 NUMEROS");
        rellenarArray(a500, 500);
        System.out.print("SSM1: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm1(a500, 500);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM1: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM2: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm2(a500, 500);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM2: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM3: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm3(a500, 500);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM3: " + (y - x) + " milisegundos");
        System.out.println();
        System.out.println();
        
//arreglo con valor 1000          

        System.out.println("---------------------------");
        System.out.println("TRABAJANDO CON 1000 NUMEROS");
        rellenarArray(a1000, 1000);
        
        System.out.print("SSM1: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm1(a1000, 1000);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM1: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM2: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm2(a1000, 1000);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM2: " + (y - x) + " milisegundos");
        
        System.out.println();
        System.out.println();
        System.out.print("SSM3: ");
        System.out.println();
        x = System.currentTimeMillis();
        ssm3(a1000, 1000);
        y = System.currentTimeMillis();
        System.out.print("Tiempo SSM3: " + (y - x) + " milisegundos");
        System.out.println();
        System.out.println();
    }

    /**
     * Encargado de insertar numeros en los arreglos
     * @param A arreglo a buscar
     * @param tam tamaño del arreglo
     */
    private static void rellenarArray(int A[], int tam) {
        for (int i = 0; i < tam; i++) A[i] = new Random().nextInt(101) - 50;
    }

    /**
     * Fuerza bruta ( n cubica )
     * @param A arreglo a buscar
     * @param n tamaño del arreglo
     */
    static void ssm1(int A[], int n) {
        int sumaMaxima = 0, mejorI = 0, mejorJ = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int sumaParcial = 0;
                for (int k = i; k <= j; k++) {
                    sumaParcial += A[k];
                }
                if (sumaParcial > sumaMaxima) {
                    sumaMaxima = sumaParcial;
                    mejorI = i;
                    mejorJ = j + 1;
                }
            }
        }
        System.out.print("i: " + mejorI + " j:" + mejorJ + " suma Maxima: " + sumaMaxima + "\n");
    }

    /**
     * Fuerza bruta mejorada ( n cuadratica )
     * @param A arreglo a buscar
     * @param n tamaño del arreglo
     */
    static void ssm2(int A[], int n) {
        int sumaMaxima = 0, mejorI = 0, mejorJ = 0;
        for (int i = 0; i < n; i++) {
            int sumaParcial = 0;
            for (int j = i; j < n; j++) {
                sumaParcial += A[j];
                if (sumaParcial > sumaMaxima) {
                    sumaMaxima = sumaParcial;
                    mejorI = i;
                    mejorJ = j + 1;
                }
            }
        }
        System.out.print("i: " + mejorI + " j:" + mejorJ + " suma Maxima: " + sumaMaxima + "\n");
    }

    /**
     * Optima ( n lineal )
     * @param A arreglo a buscar
     * @param n tamaño del arreglo
     */
    static void ssm3(int A[], int n) {
        int sumaMaxima = 0, mejorI = 0, mejorJ = 0, sumaParcial = 0, tmp = 0;
        for (int i = 0; i < n; i++) {
            sumaParcial += A[i];
            if (sumaParcial > sumaMaxima) {
                sumaMaxima = sumaParcial;
                mejorI = tmp;
                mejorJ = i + 1;
            } else if (sumaParcial < 0) {
                sumaParcial = 0;
                tmp = i + 1;
            }
        }
        System.out.print("i: " + mejorI + " j:" + mejorJ + " suma Maxima: " + sumaMaxima + "\n");
    }
}
