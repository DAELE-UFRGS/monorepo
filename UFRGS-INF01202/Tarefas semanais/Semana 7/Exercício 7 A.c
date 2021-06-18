/**
Faça um programa que lê 2 vetores de 5 posições: v1,v2. O programa deve criar uma matriz 4X5, de tal modo que:

os elementos da 1ª linha da matriz sejam os elementos do vetor v1
os elementos da 2ª linha sejam os quadrados dos elementos do vetor v2
os elementos da 3ª linha sejam a multiplicação dos elementos de v1 pelos elementos de v2
os elementos da 4ª linha sejam:
0 quando os elementos dos dois vetores forem pares
1 quando os dois elementos forem ímpares
2 quando um deles for par e o outro ímpar
Ao final, imprima a matriz.

Exemplo de execução:
v1: 5, 3, -7, 2, 6
v2: 2, 5, 3, 4, 1
matriz:
5, 3, -7, 2, 6
4, 25, 9, 16, 1
10, 15, -21, 8, 6
2, 1, 1, 0, 2
*/

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  int v1[5], v2[5], matriz[4][5], cont = 0, aux, i;

  for (aux = 0; aux < 5; aux++) {
    printf("Digite o %dº valor de v1: ", aux + 1);
    scanf("%d", &v1[aux]);
  }

  for (aux = 0; aux < 5; aux++) {
    printf("Digite o %dº valor de v2: ", aux + 1);
    scanf("%d", &v2[aux]);
  }

  for (aux = 0; aux < 5; aux++) {
    matriz[0][aux] = v1[aux];
    matriz[1][aux] = pow(v2[aux], 2);
    matriz[2][aux] = v1[aux] * v2[aux];

    cont = 0;
    if (v1[aux] % 2) cont++;
    if (v2[aux] % 2) cont++;

    switch (cont) {
    case 0:
      matriz[3][aux] = 0;
      break;
    case 1:
      matriz[3][aux] = 2;
      break;
    case 2:
      matriz[3][aux] = 1;
      break;
    }
  }

  printf("\nMatriz:");
  for (i = 0; i < 4; i++) {
    printf("\n");
    for (aux = 0; aux < 5; aux++) {
      printf("%d\t", matriz[i][aux]);
    }
  }
}