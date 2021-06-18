/**
Você deve escrever um programa para auxiliar uma campanha para arrecadação de doações. O programa deve inicialmente ler o valor que se deseja arrecadar com a campanha. A seguir, o programa deve ler valores doados, até que o valor arrecadado seja igual ou superior ao valor almejado pela campanha. Ao fim do programa, ele deve informar o total arrecadado e a média dos valores arrecadados.

OBS: O programa deve realizar verificação de consistência dos valores informados (i.e. devem ser sempre positivos)


Exemplo de execução:

Informe o valor que se deseja arrecadar: 2500,00

Informe o valor da doação: 100,00

Informe o valor da doação: 300,00

Informe o valor da doação: 50,00

Informe o valor da doação: 1000,00

Informe o valor da doação: 1300,00

Valor total arrecadado: 2750,00

Média das doações: 550,00
*/

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  float total, x, arrecadado = 0, media, cont = 0;
  printf("Digite o valor a ser arrecadado: ");
  scanf("%f", &total);
  do {
    printf("Digite o valor doado: ");
    scanf("%f", &x);
    if (x > 0) {
      arrecadado += x;
      cont++;
    }
  } while (arrecadado < total);
  media = arrecadado / cont;
  printf("Valor arrecadado: R$ %.2f\n", arrecadado);
  printf("Média do valores doados: R$ %.2f", media);
}