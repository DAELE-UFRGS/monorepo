// Faça um programa que defina e inicialize um vetor de elementos da estrutura carta (conforme desenvolvido nos exercícios da semana anterior). Crie uma função salva_estado que recebe um vetor de cartas e o tamanho do mesmo. Nesta função, peça para o usuário informar um nome de arquivo, depois abra-o para escrita (criando-o se ele não existir, ou sobrescrevendo-o se existir). Escreva no arquivo um int indicando a quantidade de elementos do vetor. Depois, escreva nele todos os elementos do vetor, ou seja, todas as cartas.

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define CARTAS 52
#define VALOR  13

typedef struct carta {
  int numero;
  int naipe;
} Carta;

void inicializa_baralho(Carta cartas[]) {
  for (int aux = 0; aux < CARTAS; aux++) {
    cartas[aux].numero = (aux % VALOR) + 1;
    cartas[aux].naipe = ((aux) / VALOR) + 1;
  }
}

int salva_estado(Carta cartas[], int tamanho) {
  FILE *arq;
  char nome[50];
  printf("Digite o nome do arquivo: ");
  fgets(nome, 50, stdin);
  nome[strcspn(nome, "\n")] = 0;
  arq = fopen(nome, "wb");
  fwrite(&tamanho, sizeof(int), 1, arq);
  fwrite(cartas, sizeof(Carta) * tamanho, 1, arq);
  fclose(arq);
}

int main() {
  system("cls");
  Carta cartas[CARTAS];
  inicializa_baralho(cartas);
  salva_estado(cartas, CARTAS);
}
