#include <iostream>
#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <ctime> 

int **m;
int **s;
int *data;
int n;

//recursivo
int me(int i, int j){
	if(i == j) return 0;
	int pos;
	int min = INT_MAX;
	int count;
	
	for(pos = i; pos < j; pos++){
		count = me(i,pos) + me(pos+1,j) + (data[i-1] * data[pos] * data[j]);
		if(count < min) {
			min = count;
		}
	}
	return min;
}

//dinamico  
void me2(int *dims, int n) {
    int len, i, j, k, temp, cost;
    n--;
    m = (int **)malloc(n * sizeof(int *));
    for (i = 0; i < n; ++i) {
        m[i] = (int *)calloc(n, sizeof(int));
    }
    
 	//almacena las letras para mostrar 
    s = (int **)malloc(n * sizeof(int *));
    for (i = 0; i < n; ++i) {
        s[i] = (int *)calloc(n, sizeof(int));
    }
 
    for (len = 1; len < n; ++len) {
        for (i = 0; i < n - len; ++i) {
            j = i + len;
            m[i][j] = INT_MAX;
            for (k = i; k < j; ++k) {
                temp = dims[i] * dims[k + 1] * dims[j + 1];
                cost = m[i][k] + m[k + 1][j] + temp;
                if (cost < m[i][j]) {
                    m[i][j] = cost;
                    s[i][j] = k; //letra a guardar
                }
            }
        }
    }
}  

//impresion de parentesis
void pp(int i, int j) {
    if (i == j)
        printf("%c", i + 65);
    else {
        printf("(");
        pp(i, s[i][j]);
        pp(s[i][j] + 1, j);
        printf(")");
    }
}

//menu
int main(){
	clock_t t;
	float f;
	int i, j,nSize;
    int a1[5]  = {5, 10, 15, 20,25};
    int a2[10] = {1, 5, 25, 30, 100, 70, 2, 1, 100, 250};
    int a3[15] = {2500, 3, 2, 5, 14, 10,46,78,13,12,78,34,12,20,30};
    int a4[20] = {300,100,5,48,125,96,16,29,4,78,12,3,67,34,16,6,9,12,45,20};
    int a5[25] = {1, 5, 25, 30, 100, 70, 2, 1, 100, 250, 1, 1000, 2, 12, 1, 700, 2500, 3, 2, 5, 14,39,100,477,500};
    int a6[30] = {1000, 1, 500, 12, 1, 700, 2500, 3, 2, 5, 14, 10,46,78,13,12,78,34,12,20,1, 5, 25, 30, 100, 70, 2, 1, 100, 250};
    int *dims_list[6] = {a1, a2, a3,a4,a5,a6};
    int sizes[6] = {5,10,15,20,25,30};
    for (i = 0; i < 6; ++i) {
        printf("Dims  : [");
        n = sizes[i];
        for (j = 0; j < n; ++j) {
            printf("%d", dims_list[i][j]);
            if (j < n - 1) printf(", "); else printf("]\n");
        }
		t = clock(); 
        me2(dims_list[i], n);
        t = clock()-t;
        f = ((float)t)/CLOCKS_PER_SEC;
        printf("orden : ");
        pp(0, n - 2);
        printf("\ncosto dinamico: %d , ", m[0][n-2]);
        printf("tiempo: %f segundos \n",f);
        data = dims_list[i];
        t = clock();
        printf("costo recursivo: %d , ",me(1,n-1));
        t = clock()-t;
        printf("tiempo: %f segundos \n\n", ((float)t)/CLOCKS_PER_SEC );
        
        for (j = 0; j <= n - 2; ++j) free(m[j]);
        free(m);
        for (j = 0; j <= n - 2; ++j) free(s[j]);
        free(s);
    }
    system("PAUSE");
    return 0;
}


