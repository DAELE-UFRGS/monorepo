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