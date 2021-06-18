#include <stdio.h>
#include <stdlib.h>

int main() {
  int num, i;
  float maior = 0, menor = 0, x;

  printf("Digite a quantidade de valores desejados: ");
  scanf("%d", &num);

  for (i = 1; i <= num; i++) {
    printf("digite o %dº valor: ", i);
    scanf("%f", &x);
    if (i == 1) maior = menor = x;

    if (x > maior) maior = x;

    if (x < menor) menor = x;
  }
  printf("Maior valor: %.2f\n", maior);
  printf("Menor valor: %.2f\n", menor);
}