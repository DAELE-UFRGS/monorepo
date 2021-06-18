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