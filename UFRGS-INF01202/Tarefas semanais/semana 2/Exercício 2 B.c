// Faça um algoritmo que leia um valor inteiro positivo de 3 dígitos, armazene-o em uma variável inteira e determine a soma dos dígitos que formam o valor. Exemplo: o valor 453 tem soma dos dígitos igual a 12 (4 + 5 + 3).


#include <stdio.h>
#include <stdlib.h>

int main() {

  int total = 0, num = 0;
  printf("Programa para ver a somatória de um número de 3 dígitos\n");
  printf("Informe um valor de 3 dígitos: ");
  scanf("%d", &num);

  while (num > 0) {
    total += (num % 10);
    num = num / 10;
  };

  printf("A soma dos digitos é: %d\n", total);
}