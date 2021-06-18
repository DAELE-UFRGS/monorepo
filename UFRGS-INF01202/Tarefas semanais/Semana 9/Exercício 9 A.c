#include <math.h>
#include <stdio.h>
#include <stdlib.h>

float decimal(int hr, int min, float seg) {
  float res;
  if ((hr >= 0 && min >= 0 && seg >= 0) && (hr < 24 && min < 60 && seg < 60))
    res = (hr * 60) + min + (seg / 60);
  else
    res = -1;

  return (res);
}

int main() {
  int hr, min, seg;
  float res;
  printf("Digite hora: ");
  scanf("%d", &hr);
  printf("Digite min: ");
  scanf("%d", &min);
  printf("Digite seg: ");
  scanf("%d", &seg);
  res = decimal(hr, min, seg);
  if (res == -1) printf("Horário inválido", res);
  else
    printf("%.2f", res);
}