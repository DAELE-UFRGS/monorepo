#include <stdio.h>
#include <stdlib.h>
#define N 5

int main() {
  int aux, ordem[N], isValid = 1, pos, oldPos = 0;
  int matriz[N][N] = {
      {0, 33, -1, -1, 15},
      {33, 0, 60, 20, 32},
      {-1, 60, 0, 50, -1},
      {-1, 20, 50, 0, 50},
      {15, 32, -1, 50, 0},
  };

  printf("Informe o trajeto: \n");
  for (aux = 0; aux < N; aux++) {
    do {
      printf("Cidade %d: ", aux + 1);
      scanf("%d", &pos);
      if (pos > (N - 1)) {
        printf("Por favor, coloque um número entre 0 e 4!\n");
      }
    } while (pos > (N - 1));

    if (!aux) oldPos = pos;
    if (matriz[pos][oldPos] < 0) isValid = 0;
    oldPos = pos;
  }

  if (isValid) printf("O caminho é possível.");
  else
    printf("O caminho não é possível.");
}