//Faça um programa que leia um número inteiro N maior ou igual a 1 (o programa deverá repetidamente pedir um novo número caso o usuário digite um número inválido). Calcule e imprima todos os números primos menores que N. Lembre que número primo é um inteiro só com 2 divisores: o número 1 e ele próprio.

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  int i, numero, isPrimo;

  do {
    printf("Escreva o seu número: ");
    scanf("%d", &numero);
  } while (numero < 1);

  do {
    numero--;
    isPrimo = 1;
    for (i = 2; i < numero; i++) {
      if ((numero % i) == 0)
        isPrimo = 0;
    }

    if (isPrimo == 1)
      printf("%d é primo\n", numero);

  } while (numero > 2);
}