/**
Faça um programa que manipule um arquivo binário. O programa deverá pedir que o usuário indique o nome do arquivo binário (por exemplo, teste.bin). Na primeira execução (considerando um nome específico de arquivo), o programa criará o arquivo, nas demais execuções apenas o lerá.

Se o arquivo não existir, o programa criará este arquivo. Em seguida, pedirá para o usuário digitar um int, um float e um char. E escreverá estes valores no arquivo (nesta respectiva ordem).

Se o arquivo existir, o programa deverá abrí-lo. Depois, deverá-ler um int, um float e um char (nesta respectiva ordem), e imprimir os valores na tela.
*/

#include <stdio.h>
#include <stdlib.h>

int main() {
  system("cls");
  FILE *arq;

  char nome[50], letra;
  int num;
  float floatnum;

  printf("Digite o nome do arquivo: ");
  fgets(nome, 50, stdin);
  nome[strcspn(nome, "\n")] = 0;
  if ((arq = fopen(nome, "rb")) == NULL) {
    fclose(arq);
    arq = fopen(nome, "wb");
    // grava os 3 valores
    printf("Digite um número inteiro: ");
    scanf("%d", &num);
    printf("Digite um float: ");
    scanf("%f", &floatnum);
    fflush(stdin);
    printf("Digite um caracter: ");
    scanf("%c", &letra);
    fwrite(&num, sizeof(num), 1, arq);
    fwrite(&floatnum, sizeof(floatnum), 1, arq);
    fwrite(&letra, sizeof(letra), 1, arq);
    fclose(arq);
  } else {
    fread(&num, sizeof(num), 1, arq);
    printf("Resultado: %d\n", num);
    fread(&floatnum, sizeof(floatnum), 1, arq);
    printf("Resultado: %.2f\n", floatnum);
    fread(&letra, sizeof(letra), 1, arq);
    printf("Resultado: %c", letra);
    fclose(arq);
  }
}