/**
Faça um programa que defina uma estrutura carta contendo número (int) e naipe (int ou char). Crie na main um vetor de 52 cartas. Crie uma função inicializa_baralho (do tipo void) que recebe um vetor de 52 cartas e o inicializa com todos os valores possíveis de cartas: ou seja, cada carta do vetor deve ter um par diferente de valor (dentre 13 possíveis) e naipe (dentre 4 possíveis). Crie outra função imprime_cartas (do tipo void) que receba um vetor de cartas e a quantidade de elementos, e imprime todas as cartas. O programa principal deve chamar as duas funções.

Sugestão: use defines para definir número de valores, naipes, total de cartas...

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define CARTAS 52
#define NAIPES 4 // 1 = Copas, 2 = Ouros, 3 = Paus, 4 = Espadas
#define VALOR  13

typedef struct carta {
  int numero;
  int naipe;
} Carta;

void inicializa_baralho(Carta baralho[CARTAS]) {
  for (int aux = 0; aux < CARTAS; aux++) {
    baralho[aux].numero = (aux % VALOR) + 1;
    baralho[aux].naipe = ((aux) / VALOR) + 1;
  }
}

void imprime_baralho(Carta baralho[CARTAS], int quant) {
  printf("Cartas: \n");
  for (int i = 0; i < quant; i++) {
    printf("\n%d ", baralho[i].numero);
    switch (baralho[i].naipe) {
    case 1:
      printf("de Copas");
      break;
    case 2:
      printf("de Ouros");
      break;
    case 3:
      printf("de Paus");
      break;
    case 4:
      printf("de Espadas");
      break;
    }
  }
}

int main() {
  srand(time(NULL));
  Carta baralho[52];
  int quant;
  quant = CARTAS;
  inicializa_baralho(baralho);
  imprime_baralho(baralho, quant);
}