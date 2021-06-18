#include <stdio.h>
#include <stdlib.h>

void main() {
  int cod, quant;

  printf("Produto\t\tCódigo\tValor\n");
  printf("Dog\t\t100\tR$ 13,00\n");
  printf("Dog Especial\t101\tR$ 17,00\n");
  printf("X Salada\t104\tR$ 18,00\n");
  printf("X Lombinho\t105\tR$ 21,00\n");
  printf("Bauru\t\t110\tR$ 24,00\n");
  printf("Refri lata\t120\tR$ 4,00\n");
  printf("Digite o código do item: ");
  scanf("%d", &cod);
  printf("Digite quantos itens você quer: ");
  scanf("%d", &quant);

  switch (cod) {
  case 100:
    printf("Valor total a se pagar: R$ %d", quant * 13);
    break;
  case 101:
    printf("Valor total a se pagar: R$ %d", quant * 17);
    break;
  case 104:
    printf("Valor total a se pagar: R$ %d", quant * 18);
    break;
  case 105:
    printf("Valor total a se pagar: R$ %d", quant * 21);
    break;
  case 110:
    printf("Valor total a se pagar: R$ %d", quant * 24);
    break;
  case 120:
    printf("Valor total a se pagar: R$ %d", quant * 4);
    break;

  default:
    printf("Código de produto inválido");
    break;
  }
}