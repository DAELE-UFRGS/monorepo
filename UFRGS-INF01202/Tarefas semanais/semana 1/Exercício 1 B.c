// Escreva um programa que imprima o resultado da multiplicação de três números inteiros.

#include <stdlib.h>
#include <stdio.h>
#include <locale.h>

void main()
{
  setlocale(LC_ALL, "Portuguese");

  int a, b, c;

  printf("Multiplicador de três dígitos.\n");

  printf("Escolha o 1º número:");
  scanf("%d", &a);
  printf("Escolha o 2º número:");
  scanf("%d", &b);
  printf("Escolha o 3º número:");
  scanf("%d", &c);

  printf("A multiplicação entre %d, %d, %d é %d\n", a, b, c, a * b * c);
}