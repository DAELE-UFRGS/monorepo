/**
Faça um programa que lê e armazena 5 valores em um arranjo de inteiros arr1, depois lê e armazena 5 valores em outro arranjo de inteiros arr2.

Este programa deve criar um terceiro arranjo de inteiros arr3 de 10 posições, que deve armazenar os valores dos outros 2 arranjos, de modo que os 5 primeiros elementos são de arr2 e os demais são elementos de arr1. No fim, imprima todos os elementos de arr3.

Ex:

Digite elemento 0 de arr1: 3

Digite elemento 1 de arr1: 80

Digite elemento 2 de arr1: -2

Digite elemento 3 de arr1: 51

Digite elemento 4 de arr1: 12

Digite elemento 0 de arr2: 68

Digite elemento 1 de arr2: -45

Digite elemento 2 de arr2: 21

Digite elemento 3 de arr2: 2

Digite elemento 4 de arr2: 3

Valores de arr3: 68 -45 21 2 3 3 80 -2 51 12
*/

#include <stdio.h>
#include <stdlib.h>
int main() {
  int arr1[5], arr2[5], arr3[10], aux;
  for (aux = 0; aux < 5; aux++) {
    printf("Digite o elemento %d de arr1: ", aux);
    scanf("%d", &arr1[aux]);
  }
  for (aux = 0; aux < 5; aux++) {
    printf("Digite o elemento %d de arr2: ", aux);
    scanf("%d", &arr2[aux]);
  }
  printf("Valores de arr3: ", arr3[0]);
  for (aux = 0; aux < 10; aux++) {
    if (aux < 5) arr3[aux] = arr2[aux];
    else
      arr3[aux] = arr1[aux - 5];

    printf("%d ", arr3[aux]);
  }
}