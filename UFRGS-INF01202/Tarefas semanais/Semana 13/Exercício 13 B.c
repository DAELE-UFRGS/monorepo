#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  FILE *arq, *imp, *par;

  char nome[50], numeros[50];
  printf("Digite o nome do arquivo: ");
  fgets(nome, 50, stdin);
  nome[strcspn(nome, "\n")] = 0;
  arq = fopen(nome, "r");
  par = fopen("pares.txt", "w");
  imp = fopen("impares.txt", "w");
  while (fgets(numeros, 50, arq)) {
    printf("%s", numeros);
    numeros[strcspn(numeros, "\n")] = 0;
    if ((atoi(numeros) % 2) == 0) {
      fprintf(par, "%s\n", &numeros);
    } else {
      fprintf(imp, "%s\n", &numeros);
    }
  }
  fclose(par);
  fclose(imp);
  fclose(arq);
}