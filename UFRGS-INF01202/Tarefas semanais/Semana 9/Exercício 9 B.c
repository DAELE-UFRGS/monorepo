#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int menor2(int a, int b) {
  return (a < b) ? a : b;
}
int menor3(int a, int b, int c) {
  return (menor2(a, b) < c) ? menor2(a, b) : c;
}

int main() {
  int a, b, c;
  printf("Digite o 1º número: ");
  scanf("%d", &a);
  printf("Digite o 2º número: ");
  scanf("%d", &b);
  printf("Digite o 3º número: ");
  scanf("%d", &c);
  printf("O menor número é: %d", menor3(a, b, c));
}
