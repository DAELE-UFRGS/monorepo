/**
Faça uma função que recebe 3 vetores (v1, v2 e v3) de números inteiros de mesmo tamanho, e um valor inteiro que representa o tamanho deles. A função deve retornar em v3 a intersecção dos elementos em v1 e v2, ou seja, os elementos que estão simultaneamente em ambos os vetores. Para facilitar, considere que dentro de um mesmo vetor não há elementos repetidos. A função deve também retornar (através de return) o número de elementos da intersecção. O programa principal deve ler os vetores v1 e v2, chamar a função criada e depois imprimir v3 (somente os elementos relevantes dele, ou seja, sem imprimir “lixo” de memória).

Exemplo de execução:
V1: 12 20 3 18 90
V2: 90 65 12 36 20
A intersecção dos conjuntos possui 3 elementos.
V3: 12 20 90
*/

#include <stdio.h>
#include <stdlib.h>
#define VALOR 5

int conjuntos(int v1[5], int v2[5], int *v3[5], int valor) {
  int z = 0;
  for (int aux = 0; aux < valor; aux++) {
    for (int i = 0; i < valor; i++) {
      if (v1[aux] == v2[i]) {
        v3[z] = v1[aux];
        z++;
      }
    }
  }
  return z;
}

int main() {
  int v1[VALOR], v2[VALOR], *v3[VALOR], z;
  for (int aux = 0; aux < VALOR; aux++) {
    printf("Digite o %dº valor de v1: ", aux + 1);
    scanf("%d", &v1[aux]);
  }

  for (int aux = 0; aux < VALOR; aux++) {
    printf("Digite o %dº valor de v2: ", aux + 1);
    scanf("%d", &v2[aux]);
  }

  z = conjuntos(v1, v2, &v3, VALOR);

  printf("\nA intersecção do conjuntos possui %d elementos.\n", z);
  for (int i = 0; i < z; i++) {
    printf("%d\t", v3[i]);
  }
}