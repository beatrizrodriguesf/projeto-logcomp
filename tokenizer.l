%{
#include "parser.tab.h"
#include <string.h>
%}

%%
[ \t\n\r]+                ; // Ignora espaços em branco

// Palavras-chave
"id"                     return ID;
"description"            return DESCRIPTION;
"data"                   return STR_DATE;
"tag"                    return TAG;
"task"                   return TASK;

"create"                 return CREATE;
"edit"                   return EDIT;
"delete"                 return DELETE;
"show"                   return SHOW;

"if"                     return IF;
"weekly"                 return WEEKLY;
"monthly"                return MONTHLY;

// Operadores
"||"                     return OR;
"&&"                     return AND;
"=="                     return EQ;
"<"                      return LT;
">"                      return GT;

// Datas : numero/numero
[0-9]+\/[0-9]+           { yylval.str = strdup(yytext); return DATE; }

// Números
[0-9]+                   { yylval.num = atoi(yytext); return NUMBER; }

// Strings
\"[^\"]*\"               { yylval.str = strdup(yytext); return STRING; }

// Nomes
[a-zA-Z_][a-zA-Z_0-9]*   { yylval.str = strdup(yytext); return NAME; }

%%

int yywrap() { return 1; }
