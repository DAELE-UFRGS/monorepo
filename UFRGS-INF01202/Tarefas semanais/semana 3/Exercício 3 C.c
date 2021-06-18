#include <stdio.h>
#include <stdlib.h>

void main() {
  float ap1, ap2, tf, mf;

  printf("Digite a nota de AP1:");
  scanf("%f", &ap1);
  printf("Digite a nota de AP2:");
  scanf("%f", &ap2);
  printf("Digite a nota de TF:");
  scanf("%f", &tf);

  mf = 0.35 * ap1 + 0.45 * ap2 + 0.2 * tf;

  printf("A média é %.1f\n", mf);

  if (mf >= 8.5) printf("Conceito A");
  if (8.5 > mf && mf >= 7.5) printf("Conceito B");
  if (7.5 > mf && mf >= 6) printf("Conceito C");
  if (mf < 6) printf("Conceito D");
}