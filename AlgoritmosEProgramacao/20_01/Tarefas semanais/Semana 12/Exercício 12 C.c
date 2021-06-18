/**
Faça um programa que defina um vetor de elementos da estrutura carta (conforme desenvolvido nos exercícios da semana anterior). Crie uma função carrega_estado que recebe este vetor de cartas e o tamanho do mesmo e retorna um int. Nesta função, peça para o usuário informar um nome de arquivo, depois abra-o para leitura. Se o arquivo não existir, a função deve retornar -1, senão deverá ler os dados do arquivo e retornar a quantidade de elementos lidos. Leia do arquivo um int indicando a quantidade de elementos disponíveis. Depois, preencha o vetor com os elementos lidos do arquivo. Na main, imprima o vetor de cartas.

OBS: Se a quantidade de elementos no arquivo for maior do que o tamanho do vetor, leia somente a quantidade de elementos que caiba no vetor.

DICA: Para imprimir as cartas, use a função imprime_cartas desenvolvida nos exercícios da semana anterior.
*/

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