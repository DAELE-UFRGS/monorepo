#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  char nome[6][20];
  int linhas, gols[6], aux, pos = 0;

  for (linhas = 0; linhas < 6; linhas++) {
    printf("Digite o nome do %dº jogador: ", linhas + 1);
    fflush(stdin);
    fgets(nome[linhas], 20, stdin);
    nome[linhas][strcspn(nome[linhas], "\n")] = 0;
  }
  for (aux = 0; aux < 6; aux++) {
    printf("Quantos gols o %s fez: ", nome[aux]);
    scanf("%d", &gols[aux]);
    if (gols[pos] < gols[aux]) {
      pos = aux;
    }
  }
  for (aux = 0; aux < 6; aux++) {
    printf("Jogador: %s\nGols: %d\n\n", nome[aux], gols[aux]);
  }
  printf("O goleador foi %s com um total de %d gols.", nome[pos], gols[pos]);
}