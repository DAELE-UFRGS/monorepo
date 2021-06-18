#include "struct.h"
#include <stdio.h>
#include <stdlib.h>
#ifndef VALIDATE_H // Esses dois ifs servem pra permitir que esse aquivo seja importa múltiplas vezes
#define VALIDATE_H

/**
 * @brief Localiza a posição da última carta em uma certa coluna do tableau.
 * 
 * @param jogo Instância atual do jogo
 * @param x Coluna do tableau
 * @return int Linha da última carta
 */
int encontraUltimaCartaCol(Jogo *jogo, int x) {
  for (int counter = TAM_TABLEAU_L - 1; counter >= 0; counter--) {
    if (jogo->tableau[counter][x].numero != 0) {
      return counter;
    };
  }
}

/**
 * @brief Função que verifica se a carta deve ser virada e aumenta o score.
 * 
 * @param jogo Instância atual do jogo
 * @param x Coluna do tableau
 * @param y Linha do tableau
 */
void revelaTableau(Jogo *jogo, int x, int y) {
  if (!jogo->tableau[y][x].visivel && y >= 0) {
    jogo->tableau[y][x].visivel = true;
    somaScore(jogo, PONT_FLIP_TABLEAU);
  }
}

/**
 * @brief Verifica se o jogador ganhou.
 * 
 * @param jogo Instância atual do jogo
 */
void verificaVitoria(Jogo *jogo) {
  int win = 0;

  for (int i = 0; i < 4; i++) { // Verifica se os 4 reis estão no estoque
    if (jogo->fundacao[12][i].numero == 13) win++;
  }

  if (win == 4) {
    jogo->vitoria = true;
    somaScore(jogo, PONT_WIN);
    salvaScore(jogo);
    jogo->telaAtual = TELA_LEADERBOARD;
  }
}

/**
 * @brief Função que valida todas as movimentações de cartas e as executa.
 * Essa função é responsável por validar todos os tipos de movimentos: \n
 *  Troca dentro do tableau \n
 *  Descarte -> Tableau \n
 *  Fundação -> Tableau \n
 *  Tableau -> Fundação \n
 *  Descarte -> Fundação
 * 
 * @param jogo Instância atual do jogo
 */
void trocaCartas(Jogo *jogo) {
  int posX = jogo->pos_inicial.x, posY = jogo->pos_inicial.y; // Origem da troca
  int cursorX = jogo->cursor.x, cursorY = jogo->cursor.y;     // Destino da troca

  if (cursorX == 0 && cursorY == 0)
    jogo->pos_estoque++; // inteiro que muda aa posição do estoque a ser renderizado

  if (posX != 0 || posY != 0) {
    if (cursorY > 0 && posY > 0) { // Troca dentro do tableau

      const int bothVisible = jogo->tableau[posY - 1][posX].visivel && jogo->tableau[cursorY - 1][cursorX].visivel;           // Verifica se as duas cartas estão visíveis
      const int blackAndRed = (jogo->tableau[posY - 1][posX].naipe % 2 + jogo->tableau[cursorY - 1][cursorX].naipe % 2) == 1; // Verifica se há um naipe preto e outro vermelho
      const int isSequence = jogo->tableau[cursorY - 1][cursorX].numero == (jogo->tableau[posY - 1][posX].numero + 1);        // Verifica se o número do destino é o seguinte
      const int isEmpty = jogo->tableau[cursorY - 1][cursorX].numero == 0;

      if ((cursorY - 1) == 0 && jogo->tableau[posY - 1][posX].numero == 13 && isEmpty) { // Mover o rei para uma nova coluna
        for (int count = 0; count <= (encontraUltimaCartaCol(jogo, posX) - (posY - 1)); count++) {
          jogo->tableau[cursorY + count - 1][cursorX] = jogo->tableau[posY - 1 + count][posX];
          jogo->tableau[posY - 1 + count][posX].numero = 0;
        }
        revelaTableau(jogo, posX, posY - 2);
      }

      if (bothVisible && blackAndRed && isSequence && posX != cursorX) {
        for (int count = 0; count <= (encontraUltimaCartaCol(jogo, posX) - (posY - 1)); count++) {
          jogo->tableau[cursorY + count][cursorX] = jogo->tableau[posY - 1 + count][posX];
          jogo->tableau[posY - 1 + count][posX].numero = 0;
        }
        revelaTableau(jogo, posX, posY - 2);
      }

      jogo->pos_inicial.x = 0;
      jogo->pos_inicial.y = 0;
      return;
    }

    if (posY == 0 && posX == 1 && cursorY != 0) { // Descarte -> Tableau
      const int descarte = jogo->pos_estoque - 1;
      const int bothVisible = jogo->estoque[descarte].visivel && jogo->tableau[cursorY - 1][cursorX].visivel;           // Verifica se as duas cartas estão visíveis
      const int blackAndRed = (jogo->estoque[descarte].naipe % 2 + jogo->tableau[cursorY - 1][cursorX].naipe % 2) == 1; // Verifica se há um naipe preto e outro vermelho
      const int isSequence = jogo->estoque[descarte].numero == (jogo->tableau[cursorY - 1][cursorX].numero - 1);        // Verifica se o número do destino é o seguinte

      if ((cursorY - 1) == 0 && jogo->estoque[descarte].numero == 13) { // Mover o rei para uma nova coluna
        jogo->tableau[cursorY - 1][cursorX] = jogo->estoque[descarte];
        jogo->estoque[descarte].numero = 0;
        jogo->pos_estoque--;
        somaScore(jogo, PONT_DESC_TABLEAU);
      }

      if ((bothVisible && blackAndRed && isSequence)) {
        jogo->tableau[cursorY][cursorX] = jogo->estoque[descarte];
        jogo->estoque[descarte].numero = 0;
        jogo->pos_estoque--;
        somaScore(jogo, PONT_DESC_TABLEAU);
      }

      jogo->pos_inicial.x = 0;
      jogo->pos_inicial.y = 0;
      return;
    }

    if (posY == 0 && cursorY >= 1) { // Fundação -> Tableau
      int lastPosition = 0;
      for (int linha = TAM_FUNDACAO_L - 1; linha > 0; linha--) {
        if (jogo->fundacao[linha][posX - 2].numero) {
          lastPosition = linha;
          break;
        };
      }
      const int isVisible = jogo->tableau[cursorY][cursorX].visivel;
      const int blackAndRed = (jogo->fundacao[lastPosition][posX - 2].naipe % 2 + jogo->tableau[cursorY - 1][cursorX].naipe % 2) == 1;
      const int isSequence = jogo->fundacao[lastPosition][posX - 2].numero + 1 == jogo->tableau[cursorY - 1][cursorX].numero;

      if (isVisible && blackAndRed && isSequence) {
        jogo->tableau[cursorY][cursorX] = jogo->fundacao[lastPosition][posX - 2];
        jogo->fundacao[lastPosition][posX - 2].numero = 0;
        somaScore(jogo, PONT_FUND_TABLEAU);
      }

      jogo->pos_inicial.x = 0;
      jogo->pos_inicial.y = 0;
      return;
    }

    if (posY > 0 && cursorY == 0 && cursorX >= 2) { // Tableau -> Fundação
      int lastPosition = -1;
      for (int linha = TAM_FUNDACAO_L - 1; linha >= 0; linha--) { //Encontra a última carta na pilha da funcação
        if (jogo->fundacao[linha][cursorX - 2].numero) {
          lastPosition = linha;
          break;
        };
      }
      if (lastPosition == -1 && jogo->tableau[posY - 1][posX].numero == 1) { // Caso a fundação esteja vazia
        jogo->fundacao[0][cursorX - 2] = jogo->tableau[posY - 1][posX];
        jogo->tableau[posY - 1][posX].numero = 0;
        revelaTableau(jogo, posX, posY - 2);
        somaScore(jogo, PONT_TO_FUND);
      } else {

        const int isSequence = jogo->fundacao[lastPosition][cursorX - 2].numero + 1 == jogo->tableau[posY - 1][posX].numero;
        const int isSameNaipe = jogo->fundacao[lastPosition][cursorX - 2].naipe == jogo->tableau[posY - 1][posX].naipe;

        if (isSequence && isSameNaipe) {
          jogo->fundacao[lastPosition + 1][cursorX - 2] = jogo->tableau[posY - 1][posX];
          jogo->tableau[posY - 1][posX].numero = 0;
          revelaTableau(jogo, posX, posY - 2);
          somaScore(jogo, PONT_TO_FUND);
        }
      }

      verificaVitoria(jogo);
      jogo->pos_inicial.x = 0;
      jogo->pos_inicial.y = 0;
      return;
    }

    if (posY == 0 && posX == 1 && cursorY == 0) { // Descarte -> Fundação
      const int descarte = jogo->pos_estoque - 1;
      int lastPosition = -1;
      for (int linha = TAM_FUNDACAO_L - 1; linha >= 0; linha--) {
        if (jogo->fundacao[linha][cursorX - 2].numero) {
          lastPosition = linha;
          break;
        };
      }

      if (lastPosition == -1 && jogo->estoque[descarte].numero == 1) {
        jogo->fundacao[0][cursorX - 2] = jogo->estoque[descarte];
        jogo->estoque[descarte].numero = 0;
        somaScore(jogo, PONT_TO_FUND);
      } else {

        const int isSequence = jogo->estoque[descarte].numero == jogo->fundacao[lastPosition][cursorX - 2].numero + 1;
        const int isSameNaipe = jogo->fundacao[lastPosition][cursorX - 2].naipe == jogo->estoque[descarte].naipe;

        if (isSequence && isSameNaipe) {
          jogo->fundacao[lastPosition + 1][cursorX - 2] = jogo->estoque[descarte];
          jogo->estoque[descarte].numero = 0;
          somaScore(jogo, PONT_TO_FUND);
        }
      }

      verificaVitoria(jogo);
      jogo->pos_inicial.x = 0;
      jogo->pos_inicial.y = 0;
      return;
    }
  }
  jogo->pos_inicial.x = cursorX;
  jogo->pos_inicial.y = cursorY;
}

/**
 * @brief Função que verifica se a movimentação do cursor é válida e faz alguns
 * tratamentos para casos especiais.
 * 
 * @param jogo Instância atual do jogo
 * @param x delta X de movimentação 
 * @param y delta Y de movimentação 
 */
void movimentaCursor(Jogo *jogo, int x, int y) {
  int curX = jogo->cursor.x;
  int curY = jogo->cursor.y;

  if ((curX + x) < 0 || (curY + y) < 0 || (curX + x) > 6) return; // Se o movimento for inválido não faz nada

  //Movimentos especiais do estoque || Descarte || Fundacao
  if (curY == 0) {
    if ((curX + x) > 5) return;                      // Se tentar mover o curso para a direita além da mesa
    if ((curX + x) == 1 && jogo->pos_estoque == 0) { // Caso o estoque esteja vazio o cursor pula essa posição
      if (x > 0) x++;
      else
        x--;
    }
    if ((curY + y) > 0 && curX > 1) x++;
  }

  //Movimentos especiais do tableau
  if (curY > 0) {
    curY--; //Normaliza a posição Y para que comece no 0

    if ((curY + y) > curY) { //Movimento para baixo
      if (jogo->tableau[curY + 1][curX].numero == 0) return;
    }

    if ((curX + x) < curX) { //Movimento para esquerda
      if (jogo->tableau[curY][curX - 1].numero == 0) y = encontraUltimaCartaCol(jogo, curX - 1) - curY;
    }

    if ((curX + x) > curX) { //Movimento para direita
      if (jogo->tableau[curY][curX + 1].numero == 0) y = encontraUltimaCartaCol(jogo, curX + 1) - curY;
    }

    if ((curY + y) < curY) { //Movimento para cima
      if ((curY + y + 1) == 0 && curX > 1) x--;
    }
  }

  jogo->cursor.x += x;
  jogo->cursor.y += y;
}

#endif