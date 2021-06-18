/**
Escreva um programa que leia do teclado dois valores inteiros. Seu programa deve, como resultado, exibir a soma dos números pares (considere que um número inteiro é par se o resto da divisão por 2 é zero) entre eles, incluindo os extremos do intervalo. A ordem dos números de entrada pode ser tanto crescente quanto decrescente. Ou seja, você não pode assumir que o primeiro número informado é menor que o segundo.

Exemplo de execução:

Entre com dois valores: 10  -7

Soma dos valores pares entre estes dois numeros: 18



// a conta feita foi 10 + 8 + 6 + 4 + 2 + 0 + -2 + -4 + -6 = 18
*/

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