// Faça um algoritmo que lê o peso (em kg) e a altura (em m) de uma pessoa e determina (e escreve) o imc (índice de massa corporal), que é dado pela fórmula: IMC = peso/(altura²)

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  float altura, peso, imc;

  printf("Programa para calcular seu IMC\n");
  printf("Qual sua altura (em metros): ");
  scanf("%f", &altura);
  printf("Qual seu peso (em kg): ");
  scanf("%f", &peso);

  imc = peso / pow(altura, 2);

  printf("Seu imc é %.2f", imc);
}