#include "struct.h"
#include <stdio.h>
#include <stdlib.h>

#ifndef UTILS_H // Esses dois ifs servem pra permitir que esse aquivo seja importa múltiplas vezes
#define UTILS_H

#define ARQ_LEADERBOARD   "top scores" // Nome do arquivo das pontuações
#define PONT_DESC_TABLEAU 5            // Descarte -> Tableau
#define PONT_FLIP_TABLEAU 5            // revelar carta tableau
#define PONT_TO_FUND      10           // Mover para a fundação
#define PONT_FUND_TABLEAU -15          // Fundação -> Tableau
#define PONT_FLIP_ESTOQUE -50          // Reiniciar o estoque
#define PONT_WIN          300          // Vencer

#define TELA_INICIO      0 // Tela do menu principal
#define TELA_JOGO        1 // Tela principal
#define TELA_LEADERBOARD 2 // Tela das pontuações
#define TELA_GET_DATA    3 // Tela de pegar o nome do jogador e do arquivo
#define TELA_PAUSE       4 // Tela de pause

#define Q_ES 218 // Quina esquerda superior
#define Q_EI 192 // Quina esquerda inferior
#define Q_DS 191 // Quina direita superior
#define Q_DI 217 // Quina direita inferior
#define T_HO 196 // Traço horizontal
#define T_VE 179 // Traço vertical

#define CIMA     'w'
#define BAIXO    's'
#define DIREITA  'd'
#define ESQUERDA 'a'

#define Y_INFORMACOES_JOGADOR 3
#define Y_CABECALHOS          6
#define Y_TABLEAU             9

/**
 * @brief Função que inicializa toda a struct
 * 
 * @param jogo Instância atual do jogo
 */
void setup(Jogo *jogo) {
  jogo->telaAtual = TELA_INICIO;
  jogo->pos_estoque = 0; // posição do estoque começa em 0
  jogo->cursor.x = 0;
  jogo->cursor.y = 0;
  jogo->score = 0;
  jogo->pos_inicial.x = 0;
  jogo->pos_inicial.y = 0;
  jogo->vitoria = false;
  cls();
  hidecursor();
  saveDefaultColor();
  iniciaCartas(jogo);
}

/**
 * @brief Função que salva o estado atual do jogo em um arquivo.
 * 
 * @param jogo Instância atual do jogo
 * @param nome Nome do arquivo a ser salvo o jogo
 */
void salvaJogo(Jogo *jogo, char nome[30]) {
  FILE *arq;
  arq = fopen(nome, "wb");
  fwrite(jogo, sizeof(Jogo), 1, arq);
  fclose(arq);
}

/**
 * @brief Função que carrega o jogo a partir de um arquivo.
 * 
 * @param jogo Instância atual do jogo
 * @param nome Nome do arquivo a ser salvo o jogo
 * @return true Caso o arquivo exista
 * @return false Caso o arquivo dê erro na leitura
 */
bool carregaJogo(Jogo *jogo, char nome[30]) {
  FILE *arq;
  arq = fopen(nome, "rb");
  if (arq == NULL) return false;

  fread(jogo, sizeof(Jogo), 1, arq);
  fclose(arq);
  return true;
}

/**
 * @brief Função que lê o arquivo de pontuações e exibe-as.
 * 
 * @param x Offset X da lista de pontuações
 * @param y Offset Y da lista de pontuações
 */
void printaScores(int x, int y) {
  FILE *arq;
  char listNomes[10][30];
  char textoLinha[50];
  int listPontos[10] = {0};

  char tempNome[30];
  int tempPontos = 0;

  int index = 0;
  int offsetX;

  arq = fopen(ARQ_LEADERBOARD, "rt");
  if (arq == NULL) {
    gotoxy(x - 12, y);
    printf("Nao ha nenhuma pontuacao");
  };

  while (fgets(textoLinha, 50, arq)) {
    index++;
    strcpy(tempNome, strtok(textoLinha, " - "));
    tempPontos = atoi(strtok(NULL, " - "));

    for (int i = 0; i < 10; i++) {
      if (tempPontos >= listPontos[i]) {
        for (int aux = 9; aux > i; aux--) {
          listPontos[aux] = listPontos[aux - 1];
          strcpy(listNomes[aux], listNomes[aux - 1]);
        }
        listPontos[i] = tempPontos;
        strcpy(listNomes[i], tempNome);
        break;
      }
    }
  }

  index = index > 10 ? 10 : index;

  for (int i = 0; i < index; i++) {
    snprintf(textoLinha, sizeof(textoLinha), "%s - %d\n", listNomes[i], listPontos[i]); // Monta a string q vai ser printada
    offsetX = strlen(textoLinha) / 2;                                                   // Mede o tamanho da string q vai ser printada
    gotoxy(x - offsetX, y + i);
    printf("%s - %d\n", listNomes[i], listPontos[i]);
  }

  fclose(arq);
}

/**
 * @brief Função que salva a pontuação atual no arquivo padrão.
 * 
 * @param jogo Instância atual do jogo
 */
void salvaScore(Jogo *jogo) {
  FILE *arq;
  arq = fopen(ARQ_LEADERBOARD, "a+");
  fread(jogo, sizeof(Jogo), 1, arq);
  fprintf(arq, "%s - %d\n", jogo->jogador, jogo->score);
  fclose(arq);
}

/**
 * @brief Função que modifica a pontuação atual do jogador.
 * 
 * @param jogo Instância atual do jogo
 * @param pontuacao Pontuação a ser somada ou subtraida
 */
void somaScore(Jogo *jogo, int pontuacao) {
  if ((jogo->score + pontuacao) < 0) jogo->score = 0;
  else
    jogo->score += pontuacao;
}

#endif
