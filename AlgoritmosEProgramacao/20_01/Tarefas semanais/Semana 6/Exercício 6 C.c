/**
Em um campeonato de futebol foram informados o nome de 6 atletas e o número de gols que cada um marcou. Faça um programa que, a partir da leitura destas informações, forneça o nome do goleador do campeonato, e o número de gols feitos por ele.

Observação: Se houver mais de um goleador com a mesma quantidade de gols, considere que o primeiro nome a aparecer será o indicado.

Ex:

Digite nome do atleta: Badico
Digite gols do atleta : 21
Digite nome do atleta: Gustavo Papa
Digite gols do atleta : 16
Digite nome do atleta: Sandro Sotilli
Digite gols do atleta : 22
Digite nome do atleta: Ernestina
Digite gols do atleta : 16
Digite nome do atleta: Claudio Milar
Digite gols do atleta : 17
Digite nome do atleta: João Paulo
Digite gols do atleta : 19
Goleador foi Sandro Sotilli com 22 gols
*/

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