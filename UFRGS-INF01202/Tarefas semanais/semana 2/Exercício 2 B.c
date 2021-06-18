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