/**
Considere N cidades (utilize #define N 5). Faça um programa que utilize uma matriz para representar as distâncias entre essas cidades, de tal modo que a célula (i,j) da matriz representa a distância entre a cidade i e a cidade j. Nesta matriz, distâncias menores que zero indicam que não há via direta que conecta duas cidades.

OBS: Para facilitar inicialize a matriz com os valores fixos mostrados no exemplo abaixo (você pode alterar os valores da matriz para testar, mas envie o exercicio com estes valores). Não é para pedir para o usuário informar os valores dela (a matriz deve ser inicializada no código).
Imagem de Exemplo
A seguir, o programa deve pedir para o usuario uma sequência de N valores (cada valor entre 0 e N-1), que indica um trajeto que alguém gostaria de realizar para visitar um conjunto dessas cidades. O programa deve informar se o trajeto pretendido é possível ou não. Um trajeto não é possível se ele incluir uma sequência de cidades que não estão conectadas entre si.

Exemplo de execução:
Informe um trajeto:
Cidade 1: 0
Cidade 2: 1
Cidade 3: 2
Cidade 4: 3
Cidade 5: 4
O trajeto é possível

Exemplo de execução:
Informe um trajeto:
Cidade 1: 0
Cidade 2: 2
Cidade 3: 3
Cidade 4: 1
Cidade 5: 4
O trajeto não é possível
*/

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