#include <stdio.h>
#include <stdlib.h>

void main() {
  int banc;
  float saldo;
  printf("Qual o numero da sua conta bancaria: ");
  scanf("%d", &banc);
  printf("Qual o saldo da sua conta: ");
  scanf("%f", &saldo);

  if (saldo < 0) {
    printf("CONTA NEGATIVA");
  } else {
    printf("NORMAL");
  }
}