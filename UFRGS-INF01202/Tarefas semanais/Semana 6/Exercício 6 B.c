/**
Faça um programa para simular a corrida de 5 cavalos.

No inicio do programa peça para o usuario informar os nomes de cada cavalo. O programa também deve ler um valor inteiro D, referente ao comprimento da pista; e um valor inteiro DMP, referente à distância máxima do passo de um cavalo.

A posição de cada cavalo na pista é dada por uma variável inteira que começa em 0, sobre a qual serão somadas as distâncias das passadas em cada instante. (Inclusive você pode usar um vetor de 5 inteiros para representar tais posições).

A cada passo de repetição, deve-se sortear um valor aleatório entre 0 e DMP para cada cavalo, que vai indicar o quanto cada cavalo andou naquele passo. Siga atualizando as distâncias percorridas por cada cavalo, até que algum cavalo tenha alcançado o fim da pista.

Quando isso acontecer, indique o cavalo vencedor e imprima os nomes e as distâncias percorridas por todos.
*/

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
