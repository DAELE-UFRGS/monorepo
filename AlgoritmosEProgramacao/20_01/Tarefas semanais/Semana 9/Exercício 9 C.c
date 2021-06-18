/**
Faça uma função tipada que recebe como entrada 6 números (3 pares ordenados) como parâmetros: x1, y1, x2, y2, x3, y3. Nesta sequência de parâmetros, os primeiros 2 pares ordenados representam coordenadas de 2 pontos (P1 e P2) no plano cartesiano que definem 2 cantos de um retângulo: P1 representa o canto inferior esquerdo e P2 representa o canto superior direito. O último par ordenado representa um outro ponto P3 arbitrário. A função deve verificar se o ponto P3 está dentro da área do retângulo definido pelos 2 primeiros pontos. Caso o ponto esteja dentro do retângulo, a função deve retornar 1, caso contrário, deve retornar 0 (zero). Escreva um programa principal que leia 6 números, chame a função desenvolvida e imprima na tela se o ponto P3 está dentro do retângulo ou não.

Exemplo de execução:
Entre as coordenadas x e y do ponto 1: 2 2
Entre as coordenadas x e y do ponto 2: 8 6
Entre as coordenadas x e y do ponto 3: 5 4
O ponto 3 esta dentro do retângulo.
Abaixo, veja uma representação gráfica dos dados acima, incluindo também um quarto ponto (10,4), que não estaria dentro do retângulo
*/

#include <stdio.h>
#include <stdlib.h>

int pares(int matriz[3][2]) {
  if (matriz[2][0] >= matriz[0][0] && matriz[2][0] <= matriz[1][0] && matriz[2][1] >= matriz[0][1] && matriz[2][1] <= matriz[1][1]) return 1;
  return 0;
}

int main() {
  int pos[3][2];
  for (int linhas = 0; linhas < 3; linhas++) {
    printf("Digite o par ordenado do %dº ponto: ", linhas + 1);
    scanf("%d %d", &pos[linhas][0], &pos[linhas][1]);
  }
  if (pares(pos)) printf("O 3º ponto está dentro do retângulo.");
  else
    printf("O 3º ponto não está dentro do retângulo.");
}
