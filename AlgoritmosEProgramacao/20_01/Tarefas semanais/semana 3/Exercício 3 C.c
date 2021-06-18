/**
Escreva um programa que leia duas notas referentes a atividades práticas de um aluno (AP1 e AP2), e a nota do trabalho final (TF). Calcule a média final (MF) conforme a ponderação usada na disciplina INF01202 neste semestre, ou seja, MF = 0,35 * AP1 + 0,45 * AP2 + 0,20 * TF, e determine o conceito final do aluno da seguinte forma:

MF >= 8,5 : Conceito A
8,5 > MF >= 7,5 : Conceito B
7,5 > MF >= 6,0 : Conceito C
MF < 6,0: Conceito D
Ao final, imprima na tela a nota final (com uma casa decimal) e o conceito
*/

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