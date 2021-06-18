/**
Leia um determinado número inteiro M. A seguir leia um número indeterminado de valores inteiros até que o usuário digite o valor 0 (zero é sinal de parada de leitura de números). O programa deve exibir o número lido da lista que mais se aproxima do número M dado no início. Note que o número zero, usado para marcar o fim da leitura de valores, não deve ser considerado para definir o número mais próximo de M.

Exemplo de execução:

Entre com o numero M: 5

Entre com o numero da lista: -1
Entre com o numero da lista: 2
Entre com o numero da lista: -3
Entre com o numero da lista: -4
Entre com o numero da lista: 15
Entre com o numero da lista: 0
Numero mais proximo de 5: 2
*/

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void main() {
  int ref, closest, closestDelta = 2147483647, temp, delta;
  printf("Digite o valor de referência: ");
  scanf("%d", &ref);

  do {
    printf("Digite algum valor inteiro: ");
    scanf("%d", &temp);

    delta = abs(ref - temp);
    if (temp != 0 && (delta < closestDelta)) {
      closestDelta = delta;
      closest = temp;
    }

  } while (temp != 0);

  printf("O valor mais próximo de %d é %d", ref, closest);
}