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