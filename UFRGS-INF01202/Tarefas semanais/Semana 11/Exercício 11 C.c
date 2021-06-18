/**
Aproveitando o que foi desenvolvido no exercício 11.b, faça um programa que defina um vetor de ponteiros da estrutura carta (definida anteriormente). O tamanho deste vetor também será 52 elementos. Todos os elementos desse vetor devem ser inicializados com valor NULL (isto é, originalmente não apontam para nenhum endereço de memória). Crie uma função verifica_baralho que recebe um vetor de cartas v_in, um vetor de ponteiros de cartas v_out e o tamanho dos vetores. A função deverá copiar para o vetor de saída o endereço das cartas do vetor de entrada que possuem valor par e naipe de copas. Na main imprima todas as cartas apontadas pelo vetor de ponteiros de cartas (não imprima elementos com valor NULL).

? DICA de como copiar endereço de elemento de um vetor para um vetor de ponteiros:

v_out[indice_vout] = &(v_in[indice_vin])

? DICA de como inicializar todos elementos de um vetor de ponteiros como NULL:

tipo* vetor_de_ponteiros[TAMANHO] = {NULL}
*/

#include <stdio.h>
#include <stdlib.h>
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

void verifica_baralho(Carta baralho[CARTAS], Carta *pbaralho[CARTAS], int num) {
  int aux = 0;
  for (int i = 0; i < num; i++) {
    if (baralho[i].numero % 2 == 0 && baralho[i].naipe == 1) {
      pbaralho[aux] = &baralho[i];
      aux++;
    }
  }
}

int main() {
  Carta *pbaralho[CARTAS] = {NULL};
  Carta baralho[CARTAS];
  inicializa_baralho(baralho);
  verifica_baralho(baralho, &pbaralho, CARTAS);
  for (int i = 0; i < 52; i++) {
    if (pbaralho[i] != NULL) {
      printf("Carta: %d ", pbaralho[i]->numero);
      if (pbaralho[i]->naipe == 1) {
        printf("de Copas\n");
      }
    }
  }
}