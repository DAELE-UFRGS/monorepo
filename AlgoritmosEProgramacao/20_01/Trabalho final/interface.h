// Arquivo destinado para as funções que lidam com a interface do jogo

#include "rlutil.h"
#include "struct.h"
#include "utils.h"
#include "validate.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef INTERFACE_H
#define INTERFACE_H

/**
 * @brief Função principal que gerencia a tela atual do jogador.
 * 
 * @param jogo Instância atual do jogo
 */
void rodaJogo(Jogo *jogo) {
  while (1) {

    switch (jogo->telaAtual) {
    case TELA_INICIO:
      cls();
      printMainMenu(jogo);
      break;

    case TELA_GET_DATA:
      cls();
      renderizaGetData(jogo);
      break;

    case TELA_PAUSE:
      cls();
      renderizaPause(jogo);
      break;

    case TELA_JOGO:
      cls();
      criaInterfaceMesa(jogo);
      renderizaMesa(jogo);
      break;

    case TELA_LEADERBOARD:
      cls();
      renderizaLeaderboard(jogo);
      break;

    default:
      break;
    }
  }
}

/**
 * @brief Renderiza a tela das pontuações máximas.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaLeaderboard(Jogo *jogo) {
  criaQuadrado(74, 25);
  gotoxy(14, 3);
  printf(" __        ___                           ");
  gotoxy(14, 4);
  printf(" \\ \\      / (_)_ __  _ __   ___ _ __ ___ ");
  gotoxy(14, 5);
  printf("  \\ \\ /\\ / /| | '_ \\| '_ \\ / _ \\ '__/ __|");
  gotoxy(14, 6);
  printf("   \\ V  V / | | | | | | | |  __/ |  \\__ \\");
  gotoxy(14, 7);
  printf("    \\_/\\_/  |_|_| |_|_| |_|\\___|_|  |___/");

  printaScores(35, 10);

  gotoxy(14, 23);
  system("pause");
  jogo->telaAtual = TELA_INICIO;
}

/**
 * @brief Renderiza a tela de pause.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaPause(Jogo *jogo) {
  criaQuadrado(74, 30);
  printMenuOption("1 - Salvar e Sair", 25, 5);
  printMenuOption("2 - Sair", 30, 8);
  printMenuOption("3 - Continuar", 27, 11);

  while (1) {
    if (kbhit()) {
      char k = getkey();
      switch (k) {
      case '1':
        cls();
        criaQuadrado(74, 30);
        gotoxy(25, 5);
        printf("Nome do arquivo do save: ");

        char arquivo[30];
        fflush(stdin);
        fgets(arquivo, 30, stdin);
        arquivo[strcspn(arquivo, "\n")] = 0;
        salvaJogo(jogo, arquivo);

        jogo->telaAtual = TELA_INICIO;
        return;

      case '2':
        salvaScore(jogo);
        jogo->telaAtual = TELA_INICIO;
        return;

      case '3':
        jogo->telaAtual = TELA_JOGO;
        return;

      default:
        break;
      }
    }
  }
}

/**
 * @brief Renderiza a tela que pega alguns dados.
 * Faz algumas validações para assegurar que o jogo não comece sem nome
 * ou carregue um arquivo que não exista
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaGetData(Jogo *jogo) {
  criaQuadrado(74, 30);
  printMenuOption("1 - Novo Jogo", 25, 5);
  printMenuOption("2 - Carregar save", 23, 8);

  while (1) {
    if (kbhit()) {
      char k = getkey();
      switch (k) {
      case '1':
        do {
          setup(jogo);
          criaQuadrado(74, 30);
          gotoxy(25, 5);
          printf("Nome do jogador: ");
          fflush(stdin);
          fgets(jogo->jogador, 30, stdin);
          jogo->jogador[strcspn(jogo->jogador, "\n")] = 0;
        } while (!strlen(jogo->jogador));
        jogo->telaAtual = TELA_JOGO;
        return;

      case '2':
        cls();
        criaQuadrado(74, 30);
        gotoxy(25, 5);
        printf("Nome do arquivo do save: ");

        char arquivo[30];
        fflush(stdin);
        fgets(arquivo, 30, stdin);
        arquivo[strcspn(arquivo, "\n")] = 0;
        if (!carregaJogo(jogo, arquivo)) {
          gotoxy(27, 8);
          printf("Arquivo nao encontrado");
          gotoxy(20, 11);
          system("pause");
          jogo->telaAtual = TELA_INICIO;
          return;
        }

        jogo->telaAtual = TELA_JOGO;
        return;

      default:
        break;
      }
    }
  }
}

/**
 * @brief Chama a função que cria a mesa e controla as teclas pressionadas.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaMesa(Jogo *jogo) {
  while (jogo->vitoria == false) {
    if (kbhit()) {
      char k = getkey();
      switch (tolower(k)) {
      case 0:  // Código do ESC do cmd
      case 27: // Código ESC da tabela ASCII
        jogo->telaAtual = TELA_PAUSE;
        return;
      case ' ':
        trocaCartas(jogo);
        break;
      case DIREITA:
        movimentaCursor(jogo, 1, 0);
        break;
      case ESQUERDA:
        movimentaCursor(jogo, -1, 0);
        break;
      case CIMA:
        movimentaCursor(jogo, 0, -1);
        break;
      case BAIXO:
        movimentaCursor(jogo, 0, 1);
        break;

      default:
        break;
      }

      cls();
      criaInterfaceMesa(jogo);
    }
  }
}

/**
 * @brief Função que cria o quadrado de borda das telas.
 * 
 * @param x largura do quadrado
 * @param y altura do quadrado
 */
void criaQuadrado(int x, int y) {
  printf("%c", Q_ES);
  for (int i = 0; i < (x - 2); i++)
    printf("%c", T_HO);
  printf("%c", Q_DS);
  for (int i = 2; i < y; i++) {
    gotoxy(1, i);
    printf("%c", T_VE);
    gotoxy(x, i);
    printf("%c\n", T_VE);
  }

  printf("%c", Q_EI);
  for (int i = 0; i < (x - 2); i++)
    printf("%c", T_HO);
  printf("%c", Q_DI);
}

/**
 * @brief Renderiza os labels da mesa
 * 
 * @param jogo Instância atual do jogo
 */
void aplicaLabels(Jogo *jogo) {
  gotoxy(4, Y_INFORMACOES_JOGADOR);
  printf("Jogador: %s", jogo->jogador);
  gotoxy(54, Y_INFORMACOES_JOGADOR);
  printf("Score: %d", jogo->score);

  gotoxy(4, Y_CABECALHOS - 1);
  printf("Estoque");
  gotoxy(14, Y_CABECALHOS - 1);
  printf("Descarte");
  gotoxy(34, Y_CABECALHOS - 1);
  printf("Fundacao");

  gotoxy(4, 8);
  printf("Tableau");
}

/**
 * @brief Verifica se a cor da carta é vermelha ou preta.
 * 
 * @param naipe Valor numérico do naipe
 * @return int Código da cor preto ou vermelho
 */
int getCorCarta(int naipe) {
  return naipe % 2 ? RED : BLACK;
}

/**
 * @brief Verifica qual o símbolo do naipe.
 * 
 * @param naipe Valor numérico do naipe
 * @return char Código ASCII do naipe
 */
char getNaipeCarta(int naipe) {
  switch (naipe) {
  case COPAS:
    return 3;

  case PAUS:
    return 5;

  case OUROS:
    return 4;

  case ESPADAS:
    return 6;
  }
}

/**
 * @brief Função que renderiza uma carta.
 * Possui validações para ver qual a cor do naipe e se está virada para cima ou para baixo.
 * 
 * @param carta Struct da carta
 * @param x Coordenada inicial X
 * @param y Coordenada inicial Y
 */
void renderizaCarta(Carta *carta, int x, int y) {
  if (carta->visivel) {
    gotoxy(x, y);
    setColor(getCorCarta(carta->naipe));
    setBackgroundColor(WHITE);
    // if (carta->numero < 10) printf(" "); // Pra deixar a largura igual com cartas de 1 ou 2 caracteres
    switch (carta->numero) {
    case (1):
      printf("  A %c  ", getNaipeCarta(carta->naipe));
      break;
    case (10):
      printf(" 10 %c  ", getNaipeCarta(carta->naipe));
      break;
    case (11):
      printf("  J %c  ", getNaipeCarta(carta->naipe));
      break;
    case (12):
      printf("  Q %c  ", getNaipeCarta(carta->naipe));
      break;
    case (13):
      printf("  K %c  ", getNaipeCarta(carta->naipe));
      break;
    default:
      printf("  %d %c  ", carta->numero, getNaipeCarta(carta->naipe));
      break;
    }

  } else {
    gotoxy(x, y);
    setColor(WHITE);
    setBackgroundColor(BLUE);
    printf(" -- -- ");
  }
  resetColor();
}

/**
 * @brief Função que renderiza o tableau.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaTableau(Jogo *jogo) {
  for (int i = 0; i < TAM_TABLEAU_L; i++) {
    for (int j = 0; j < TAM_TABLEAU_C; j++) {
      if (jogo->tableau[i][j].numero != 0)
        renderizaCarta(&jogo->tableau[i][j], 4 + (10 * j), 9 + i);
    }
  }
}

/**
 * @brief Função que renderiza o estoque.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaEstoque(Jogo *jogo) {
  int descarte = jogo->pos_estoque - 1;
  int ncartas = 0;
  int ultimaCarta = 0;
  for (int aux = 0; aux < 24; aux++) { // Conta quantas cartas existem no estoque/descarte
    if (jogo->estoque[aux].numero != 0) ncartas++;
  }
  for (int aux = 0; aux < 24; aux++) { // Encontra a posição da última carta
    if (jogo->estoque[aux].numero != 0) ultimaCarta = aux + 1;
  }

  while (jogo->estoque[descarte].numero == 0 && jogo->pos_estoque > 0 && jogo->pos_estoque <= 24) { // cartas removidas tem valor 0, e são puladas. menos a posição inicial que também é 0
    jogo->pos_estoque++;
    descarte++;
  }

  if (jogo->pos_estoque > 24) { // quando chega na posição 25 ou maior ele volta para o começo
    jogo->pos_estoque = 0;
    descarte = -1;
    somaScore(jogo, PONT_FLIP_ESTOQUE);
  }

  if (descarte >= 0) jogo->estoque[descarte].visivel = true; // Toda carta no descarte deve estar visível
  jogo->estoque[jogo->pos_estoque].visivel = false;

  if (jogo->pos_estoque != ultimaCarta && ncartas != 0) renderizaCarta(&jogo->estoque[jogo->pos_estoque], 4, 6); // renderiza o estoque atualizado
  if (descarte >= 0) renderizaCarta(&jogo->estoque[descarte], 14, 6);                                            // renderiza o descarte atualizado
}

/**
 * @brief Função que renderiza a fundação.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaFundacao(Jogo *jogo) {
  int index;
  for (int col = 0; col < TAM_FUNDACAO_C; col++) {
    index = -1;
    for (int linha = 0; linha < TAM_FUNDACAO_L; linha++) {
      if (jogo->fundacao[linha][col].numero) {
        index = linha;
      };
    }
    if (index >= 0)
      renderizaCarta(&jogo->fundacao[index][col], 34 + (col * 10), Y_CABECALHOS);
    else {
      gotoxy(34 + (col * 10), Y_CABECALHOS);
      printf("-------");
    }
  }
}

/**
 * @brief Função que renderiza um cursor em uma dada posição.
 *  
 * @param x Coordenada X
 * @param y Coordenada y
 * @param cor Cor do cursor
 */
void renderizaCursorTroca(int x, int y, int cor) {
  gotoxy(x, y);
  setColor(cor);
  printf(">");
  resetColor();
}

/**
 * @brief Função que gerencia a posição atual atual do cursor.
 * A função também verifica se há uma carta selecionada, para então
 * desenhar um cursor amarelo na posição.
 * 
 * @param jogo Instância atual do jogo
 */
void renderizaCursor(Jogo *jogo) {
  int x = jogo->cursor.x;
  int y = jogo->cursor.y;
  if (y == 0) {
    switch (x) {
    case 0:
    case 1:
      renderizaCursorTroca(2 + 10 * x, Y_CABECALHOS, WHITE);

      break;
    default:
      renderizaCursorTroca(2 + 10 + 10 * x, Y_CABECALHOS, WHITE);
      break;
    }
  } else
    renderizaCursorTroca(2 + 10 * x, Y_TABLEAU + y - 1, WHITE);

  //renderiza cursor de troca
  if (jogo->pos_inicial.x || jogo->pos_inicial.y) {
    if (jogo->pos_inicial.y == 0) {
      switch (jogo->pos_inicial.x) {
      case 0:
      case 1:
        renderizaCursorTroca(2 + 10 * jogo->pos_inicial.x, Y_CABECALHOS, YELLOW);

        break;
      default:
        renderizaCursorTroca(2 + 10 + 10 * jogo->pos_inicial.x, Y_CABECALHOS, YELLOW);
        break;
      }
      return;
    } else
      renderizaCursorTroca(2 + 10 * jogo->pos_inicial.x, Y_TABLEAU + jogo->pos_inicial.y - 1, YELLOW);
  }
}

/**
 * @brief Função que renderiza a mesa de jogo.
 * Essa função chama todas as funções que compõem a tela de jogo.
 * 
 * @param jogo Instância atual do jogo
 */
void criaInterfaceMesa(Jogo *jogo) {
  criaQuadrado(74, 30);
  renderizaEstoque(jogo);
  renderizaTableau(jogo);
  renderizaFundacao(jogo);
  renderizaCursor(jogo);
  aplicaLabels(jogo);
}

/**
 * @brief Função que printa uma opção de seleção
 * 
 * @param texto Descritivo da opção
 * @param startX Coordenada inicial X
 * @param startY Coordenada inicial Y
 */
void printMenuOption(char *texto, int startX, int startY) {
  int tamanho = strlen(texto) + 4;
  for (int linha = 0; linha < tamanho; linha++) {
    switch (linha) {
    case 0:
      gotoxy(startX, startY);
      printf("%c", Q_ES);
      for (int i = 0; i < tamanho - 2; i++) {
        printf("%c", T_HO);
      }
      printf("%c", Q_DS);
      break;

    case 1:
      gotoxy(startX, startY + 1);
      printf("%c %s %c", T_VE, texto, T_VE);
      break;

    case 2:
      gotoxy(startX, startY + 2);
      printf("%c", Q_EI);
      for (int i = 0; i < tamanho - 2; i++) {
        printf("%c", T_HO);
      }
      printf("%c", Q_DI);
      break;

    default:
      break;
    }
  }
}

/**
 * @brief Renderiza o menu principal
 * 
 * @param jogo Instância atual do jogo
 */
void printMainMenu(Jogo *jogo) {
  gotoxy(7, 1);
  printf(" _______                 _    _                     _          \n");
  gotoxy(7, 2);
  printf("|_   __ \\               (_)  / \\                   (_)         \n");
  gotoxy(7, 3);
  printf("  | |__) |,--.   .---.  __  .---.  _ .--.   .---.  __   ,--.   \n");
  gotoxy(7, 4);
  printf("  |  ___/`'_\\ : / /'`\\][  |/ /__\\\\[ `.-. | / /'`\\][  | `'_\\ :  \n");
  gotoxy(7, 5);
  printf(" _| |_   // | |,| \\__.  | || \\__., | | | | | \\__.  | | // | |, \n");
  gotoxy(7, 6);
  printf("|_____|  \\'-;__/'.___.'[___]'.__.'[___||__]'.___.'[___]\\'-;__/ \n\n\n");
  printMenuOption("(1) Jogar", 21, 10);
  printMenuOption("(2) Recordes", 37, 10);
  printMenuOption("(3) Sair", 30, 13);

  while (1) {
    if (kbhit()) {
      char k = getkey();
      switch (k) {
      case '1':
        cls();
        jogo->telaAtual = TELA_GET_DATA;
        return;

      case '2':
        cls();
        jogo->telaAtual = TELA_LEADERBOARD;
        return;

      case '3':
        exit(1);

      default:
        break;
      }
    }
  }
}

#endif