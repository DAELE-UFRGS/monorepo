#include <stdio.h>
#include <stdlib.h>
#define VALOR 5

int conjuntos(int v1[5], int v2[5], int *v3[5], int valor) {
  int z = 0;
  for (int aux = 0; aux < valor; aux++) {
    for (int i = 0; i < valor; i++) {
      if (v1[aux] == v2[i]) {
        v3[z] = v1[aux];
        z++;
      }
    }
  }
  return z;
}

int main() {
  int v1[VALOR], v2[VALOR], *v3[VALOR], z;
  for (int aux = 0; aux < VALOR; aux++) {
    printf("Digite o %dº valor de v1: ", aux + 1);
    scanf("%d", &v1[aux]);
  }

  for (int aux = 0; aux < VALOR; aux++) {
    printf("Digite o %dº valor de v2: ", aux + 1);
    scanf("%d", &v2[aux]);
  }

  z = conjuntos(v1, v2, &v3, VALOR);

  printf("\nA intersecção do conjuntos possui %d elementos.\n", z);
  for (int i = 0; i < z; i++) {
    printf("%d\t", v3[i]);
  }
}