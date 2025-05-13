%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int ival;
    char *sval;
}

%token <sval> STR ID
%token <ival> NUM
%token CRIAR TAREFA_KW TAG_KW EXCLUIR MARCAR DESMARCAR GERAR RELATORIO
%token SE EXIBIR DATA_KW
%token EQ NEQ LT GT AND OR

%%

programa:
      comando_list
    ;

comando_list:
      comando
    | comando_list comando
    ;

comando:
      criacao_tarefa
    | alteracao_tarefa
    | criacao_tag
    | exclusao_tag
    | relatorio
    ;

criacao_tarefa:
      CRIAR TAREFA_KW NUM descricao_opt tag_opt data
    ;

descricao_opt:
      ID ID descricao_cont
    ;

descricao_cont:
      /* vazio */
    | descricao_cont ID
    ;

tag_opt:
      /* vazio */
    | TAG_KW ID
    ;

data:
      NUM '/' NUM '/' NUM
    ;

alteracao_tarefa:
      acao TAREFA_KW NUM
    ;

acao:
      EXCLUIR
    | MARCAR
    | DESMARCAR
    ;

criacao_tag:
      CRIAR TAG_KW ID
    ;

exclusao_tag:
      EXCLUIR TAG_KW ID
    ;

relatorio:
      GERAR RELATORIO condicional_opt
    ;

condicional_opt:
      /* vazio */
    | SE expressao_logica EXIBIR
    ;

expressao_logica:
      expressao
    | expressao_logica AND expressao
    | expressao_logica OR expressao
    ;

expressao:
      DATA_KW comparador data
    | TAG_KW comparador
    ;

comparador:
      EQ
    | NEQ
    | LT
    | GT
    ;

%%

int main(void) {
    if (yyparse() == 0)
        printf("Entrada aceita com sucesso!\n");
    else
        printf("Erro de sintaxe!\n");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\n", s);
}
