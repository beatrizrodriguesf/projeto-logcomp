%{
#include "parser.tab.h"
#include <string.h>
%}

DIGIT      [0-9]
LETTER     [a-zA-Z]
WORD       {LETTER}+

%%

"criar"                         return CRIAR;
"tarefa"                        return TAREFA_KW;
"tag"                           return TAG_KW;
"excluir"                       return EXCLUIR;
"marcar"                        return MARCAR;
"desmarcar"                     return DESMARCAR;
"gerar"                         return GERAR;
"relatorio"                     return RELATORIO;
"se"                            return SE;
"exibir"                        return EXIBIR;
"data"                          return DATA_KW;
"="                             return EQ;
"!="                            return NEQ;
"<"                             return LT;
">"                             return GT;
"&"                             return AND;
"|"                             return OR;

{DIGIT}+                        { yylval.ival = atoi(yytext); return NUM; }

{LETTER}({LETTER}|{DIGIT}|"_")* {
                                  yylval.sval = strdup(yytext);
                                  return ID;
}

\"[^\"]+\"                      { yylval.sval = strdup(yytext+1); yytext[yyleng-1] = '\0'; return STR; }

[ \t\n\r]+                      /* Ignorar espaços e quebras de linha */

.                               return yytext[0];

%%

int yywrap() {
    return 1;
}
