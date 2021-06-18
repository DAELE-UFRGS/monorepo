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