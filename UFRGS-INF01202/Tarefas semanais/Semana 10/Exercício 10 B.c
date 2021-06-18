/**
Faça uma função que receba uma matriz de inteiros positivos (m_in), uma matriz de floats (m_out) de mesmo tamanho de m_in, e a quantidade de linhas (L) e colunas (C) das matrizes. A função deve colocar em m_out os elementos normalizados de m_in, ou seja, cada elemento de m_in deve ser dividido pela soma de todos os elementos dela (portanto, a soma de todos os elementos de m_out deve ser igual a 1). O programa principal deve ler a matriz de inteiros positivos (se o usuário informar um número inválido, peça para ele informar novamente), chamar a função e depois imprimir a matriz de floats, com duas casas decimais.

OBS: a passagem de matrizes (arrays multidimensionais) por parametro em uma função permite que a primeira dimensão da matriz seja variavel, mas que as demais dimensões sejam fixas. 

ex: void funcao(int matriz[][COLS], ...)    // onde COLS vem de um define
Exemplo de execução:
m_in:
5   10   2   4
6     9   8   6
m_out:
0.10   0.20   0.04   0.08
0.12   0.18   0.16   0.12
*/

#include <stdio.h>
#include <stdlib.h>
#define L 2
#define C 4

float normaliza(int m_in[L][C], float m_out[L][C], int l, int c) {
  float soma = 0;
  for (l = 0; l < L; l++) {
    for (c = 0; c < C; c++) {
      soma += m_in[l][c];
    }
  }
  for (l = 0; l < L; l++) {
    for (c = 0; c < C; c++) {
      m_out[l][c] = ((float)m_in[l][c] / soma);
    }
  }
}

int main() {
  int m_in[L][C], l, c;
  float m_out[L][C];

  for (l = 0; l < L; l++) {
    for (c = 0; c < C; c++) {
      do {
        printf("Preencha a %dº coluna da %dº linha: ", c + 1, l + 1);
        scanf("%d", &m_in[l][c]);
        if (m_in[l][c] < 0) {
          printf("Valor inválido. Os valores aceitos são maiores ou iguais a zero.\n");
        }
      } while (m_in[l][c] < 0);
    }
  }

  normaliza(m_in, m_out, L, C);

  for (l = 0; l < L; l++) {
    printf("\n");
    for (c = 0; c < C; c++) {
      printf("%.2f\t", m_out[l][c]);
    }
  }
}