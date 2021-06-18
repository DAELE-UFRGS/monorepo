#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define CARTAS 52
#define VALOR  13

typedef struct carta {
  int numero;
  int naipe;
} Carta;

void imprime_baralho(Carta baralho[], int quant) {
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

int carrega_estado(Carta baralho[]) {
  FILE *arq;
  char nome[50];
  int lidos;
  printf("Digite o nome do arquivo: ");
  fgets(nome, 50, stdin);
  nome[strcspn(nome, "\n")] = 0;
  arq = fopen(nome, "rb");
  if (arq == NULL) {
    fclose(arq);
    return (-1);
  }

  fread(&lidos, sizeof(lidos), 1, arq);
  fread(baralho, sizeof(Carta) * lidos, 1, arq);
  fclose(arq);
  return (lidos);
}

int main() {
  system("cls");
  Carta baralho[CARTAS];
  int tamanho = carrega_estado(baralho);
  if (tamanho == -1) {
    printf("Erro, arquivo corrompido ou com erro.");
  } else {
    imprime_baralho(baralho, tamanho);
  }
}