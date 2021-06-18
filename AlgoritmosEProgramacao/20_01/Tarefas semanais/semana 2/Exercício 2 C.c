/**
Faça um programa que calcula a quantidade de latas de tinta necessária e o custo para pintar uma quantidade de chapas de madeira retangulares. O algoritmo deve ler:

a quantidade de chapas que devem ser pintadas

as dimensões de cada chapa (largura e comprimento)

o custo da lata de tinta

a quantidade de metros quadrados que podem ser pintados com uma lata de tinta.
*/

#include <locale.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  setlocale(LC_ALL, "");

  int quant, latas;
  float altura, largura, custo, area, tamanho, preco;

  printf("Quantas chapas serão pintadas: ");
  scanf("%d", &quant);
  printf("Qual a altura das chapas: ");
  scanf("%f", &altura);
  printf("Qual a largura das chapas: ");
  scanf("%f", &largura);
  printf("Qual o custo das latas de tintas: ");
  scanf("%f", &custo);
  printf("Quantos metros quadrados podem ser pintados com uma lata: ");
  scanf("%f", &area);

  tamanho = (largura * altura) * quant;
  latas = ceil(tamanho / area);
  preco = latas * custo;

  printf("Preço final: R$%.2f\n", preco);
  printf("A quantidade de latas: %d", latas);
}