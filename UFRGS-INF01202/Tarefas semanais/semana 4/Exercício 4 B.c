#include <stdio.h>
#include <stdlib.h>

void main() {
  int a, b, c, soma = 0, aux = 0;

  printf("Digite o primeiro número: ");
  scanf("%d", &a);
  printf("Digite o segundo número: ");
  scanf("%d", &b);

  if (b > a) {
    c = a;
    a = b;
    b = c;
  }

  for (aux = a; b <= aux; aux--) {
    if ((aux % 2) == 0) {
      soma = soma + aux;
    }
  }
  printf("%d\n", soma);
}