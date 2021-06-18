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