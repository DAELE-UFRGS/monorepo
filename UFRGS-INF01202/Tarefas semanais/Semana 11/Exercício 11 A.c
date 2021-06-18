#include <stdio.h>
#include <stdlib.h>
#define PESSOAS 5

typedef struct {
  char nome[30];
  int pontuacao;
} Pessoas;

void bubblesort(Pessoas jogador[PESSOAS]) {
  int true = 1;
  Pessoas temp;
  do {
    true = 0;
    for (int aux = 0; aux < 4; aux++) {
      if (jogador[aux].pontuacao < jogador[aux + 1].pontuacao) {
        temp = jogador[aux];
        jogador[aux] = jogador[aux + 1];
        jogador[aux + 1] = temp;
        true = 1;
      }
    }
  } while (true == 1);
}

int main() {
  Pessoas jogador[PESSOAS];
  for (int aux = 0; aux < PESSOAS; aux++) {
    printf("Digite o nome do jogador %d: ", aux + 1);
    fflush(stdin);
    fgets(jogador[aux].nome, 30, stdin);
    printf("Digite a pontuação do jogador %d: ", aux + 1);
    scanf("%d", &jogador[aux].pontuacao);
  }
  bubblesort(jogador);
  for (int i = 0; i < PESSOAS; i++) {
    printf("%d - %s", jogador[i].pontuacao, jogador[i].nome);
  }
}
