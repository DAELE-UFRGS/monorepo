#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

  FILE *arq;

  char nome[50], numeros[50], quebra[2] = ";";
  char *x, *y;
  printf("Digite o nome do arquivo: ");
  fgets(nome, 50, stdin);
  nome[strcspn(nome, "\n")] = 0;
  arq = fopen(nome, "r");
  while (fgets(numeros, 50, arq)) {
    numeros[strcspn(numeros, "\n")] = 0;
    x = strtok(numeros, quebra);
    y = strtok(NULL, quebra);
    printf("%.4f\n", atof(x) * atof(y));
  }
  fclose(arq);
}