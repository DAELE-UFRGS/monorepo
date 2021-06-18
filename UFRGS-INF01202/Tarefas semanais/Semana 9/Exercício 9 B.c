//Faça uma função chamada menor2 que recebe como parâmetros dois números inteiros e retorna o menor deles. A seguir, faça uma função chamada menor3 que recebe como parâmetro três números inteiros e retorna o menor deles. A função menor3 deve necessariamente usar a função menor2 em sua lógica interna. Escreva um programa principal que leia 3 números, computa qual deles é o menor usando a função menor3 e imprima na tela qual dos números é o menor.

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
