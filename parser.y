%{
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

ASTNode* root;

int yylex(void);
void yyerror(const char* s) {
    fprintf(stderr, "Erro: %s\n", s);
}
%}

%union {
    int ival;
    ASTNode* node;
}

%token ID DESCRIPTION STR_DATE TAG TASK
%token NAME STRING DATE
%token NUMBER

%token CREATE EDIT DELETE SHOW
%token IF WEEKLY MONTHLY

%token OR, AND, EQ, GT, LT

%left OR
%left AND
%left EQ GT LT

%type <node> comando
// %type <str> expressao_data expressao_tag

%%

input:
    /* vazio */
    | input comando '\n'
    ;

comando:
      CREATE TAG NAME                   {   char* info = $3;
                                            $$ = create_node(CREATE_TAG, $3, NULL, NULL) }

    | DELETE TAG NAME                   {   char* info = $3;
                                            $$ = create_node(DELETE_TAG, $3, NULL, NULL)}

    | CREATE TASK ID STRING DATE        {   node_left = create_node(STRING, $4, NULL, NULL);
                                            node_right = create_node(DATE, $5, NULL, NULL); 
                                            $$ = create_node(CREATE_TASK, $3, node_left, node_right)}

    | CREATE time TASK STRING DATE DATE {   node_left = create_node(STRING, $4, NULL, NULL);
                                            node_right = create_node(DATE, $5, NULL, NULL);
                                            node_task = create_node(CREATE_TASK, $3, node_left, node_right);
                                            node_end = create_node(DATE, $6, NULL, NULL);
                                            $$ = create_node(REPEAT, $2, node_end, node_task) }

    | DELETE TASK ID                    { $$ = create_node(DELETE_TASK, $3, NULL, NULL) }

    | SHOW TASK                         { $$ = create_node(SHOW_TAG, "show_tag", NULL, NULL) }
    | SHOW TASK expressao_data          { $$ = create_node(SHOW_TASK, "filter_data", $3, NULL) }
    | SHOW TASK expressao_tag           { $$ = create_node(SHOW_TASK, "filter_tag", $3, NULL) }

    | SHOW TAG                          { $$ = create_node(SHOW_TASK, "all", NULL, NULL) }
    ;

expressao_data:
      STR_DATE comp DATE                              { /* Ex: data == "10/10" */ }
    | STR_DATE comp DATE operador_logico expressao_data { /* Ex: data > "01/01" && data < "12/12" */ }
    ;

expressao_tag:
      TAG EQ NAME                                     { /* Ex: tag == importante */ }
    | TAG EQ NAME OR expressao_tag                    { /* Ex: tag == urgente || tag == importante */ }
    ;

time:
    WEEKLY | MONTHLY;

comp:
      EQ | LT | GT
    ;

operador_logico:
      AND | OR
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
