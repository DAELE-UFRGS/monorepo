#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  float total, x, arrecadado = 0, media, cont = 0;
  printf("Digite o valor a ser arrecadado: ");
  scanf("%f", &total);
  do {
    printf("Digite o valor doado: ");
    scanf("%f", &x);
    if (x > 0) {
      arrecadado += x;
      cont++;
    }
  } while (arrecadado < total);
  media = arrecadado / cont;
  printf("Valor arrecadado: R$ %.2f\n", arrecadado);
  printf("Média do valores doados: R$ %.2f", media);
}