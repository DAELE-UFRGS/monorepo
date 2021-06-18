/**
Escreva um programa que leia um valor inteiro positivo N, que representa o número de valores que deverão ser lidos. A seguir, o programa deve ler N valores reais. Ao fim, o programa deve informar o menor e o maior valor dentre os informados. O programa deve funcionar para qualquer valor de N.

Exemplo de execução:

Informe a quantidade de valores considerados: 5

Informe o valor 1: 10.2

Informe o valor 2: 12.4

Informe o valor 3: 20.82

Informe o valor 4: 30.12

Informe o valor 5: 8.0

Menor valor: 8.0

Maior valor: 30.12
*/

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