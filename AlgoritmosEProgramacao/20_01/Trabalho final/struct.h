#include <stdbool.h>
#ifndef STRUCT_H // Esses dois ifs servem pra permitir que esse aquivo seja importa múltiplas vezes
#define STRUCT_H

#define COPAS   1
#define PAUS    2
#define OUROS   3
#define ESPADAS 4

#define TAM_ESTOQUE    52
#define TAM_DESCARTE   25
#define TAM_TABLEAU_L  19
#define TAM_TABLEAU_C  7
#define TAM_FUNDACAO_L 13
#define TAM_FUNDACAO_C 4
#define TAM_JOGADOR    30

/**
 * @brief Struct das cartas.
 * Por definição quando o número da carta for 0 significa que aquela posição 
 * está vazia e deve ser ignorada
 */
typedef struct carta {
  int numero;   ///< 1 - Às até 13 - Rei;
  int naipe;    ///< 1 - Copas, 2 - Paus, 3 - Ouros, 4 -Espadas
  bool visivel; ///< Indica se a carta está virada para cima ou para baixo
} Carta;

/**
 * @brief Struct para o cursor.
 */
typedef struct cursor {
  int x; ///< Coordenada X
  int y; ///< Coordenada Y
} Cursor;

/**
 * @brief Struct global do jogo.
 * Foi criada com o intuito de simplicar a passagem de parâmetros para
 * as funções e também para facilitar o salvamento do jogo 
 */
typedef struct jogo {
  Carta estoque[TAM_ESTOQUE];                     ///< Cartas do estoque
  Carta tableau[TAM_TABLEAU_L][TAM_TABLEAU_C];    ///< Cartas no tableau
  Carta fundacao[TAM_FUNDACAO_L][TAM_FUNDACAO_C]; ///< Cartas na fundação
  Cursor cursor;                                  ///< Posição atual do cursor
  Cursor pos_inicial;                             ///< Posição inicial de uma troca
  bool vitoria;                                   ///< Indicador do término de um jogo
  char jogador[TAM_JOGADOR];                      ///< Nome do jogador
  int score;                                      ///< Pontuação atual do jogo
  int telaAtual;                                  ///< Tela atual
  int pos_estoque;                                ///< Índice do estoque
} Jogo;
#endif
