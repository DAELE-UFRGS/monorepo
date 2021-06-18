// Faça um programa que lê o peso de 3 pessoas e um valor que indica um peso de referência. O programa deve informar quantas pessoas possuem um peso superior ou igual ao peso de referência.

#include <stdio.h>
#include <stdlib.h>
#define QUANTIDADE 3

void main() {
  float a, ref;
  int num = 0;

  printf("Digite o peso de referência:");
  scanf("%f", &ref);

  for (int aux = 1; aux <= QUANTIDADE; aux++) {
    printf("Digite o peso da %dª pessoa:", aux);
    scanf("%f", &a);
    if (a >= ref) num++;
  }

  printf("O número de pessoas com peso acima ou igual ao peso de referência é %d", num);
}