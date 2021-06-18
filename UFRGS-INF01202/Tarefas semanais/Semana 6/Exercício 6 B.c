#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  char nome[5][20];
  int passo, tamanho, pos[5] = {0}, aux, vencedor = 0;
  srand(time(NULL));
  for (aux = 0; aux < 5; aux++) {
    printf("Digite os nomes dos cavalos: ");
    fflush(stdin);
    fgets(nome[aux], 20, stdin);
  }
  printf("Digite o tamanho máximo do passo de um cavalo: ");
  scanf("%d", &passo);
  printf("Digite o comprimento da pista: ");
  scanf("%d", &tamanho);

  while (vencedor == 0) {
    for (aux = 0; aux < 5 && !vencedor; aux++) {
      pos[aux] += rand() % (passo + 1);
      if (pos[aux] >= tamanho) {
        vencedor = 1;
        printf("\nCavalo vencedor: %s", nome[aux]);
      }
    }
  }
  for (aux = 0; aux < 5; aux++) {
    printf("\n\nCavalo: %sDistância percorrida: %d", nome[aux], pos[aux]);
  }
}
