# projeto-logcomp

Linguagem para criação de lista de tarefas

EBNF:

ACAO = criar | alterar | looping | condicional | relatorio
CRIAR = "criar", tarefa, descricao, [tag], data
ALTERAR = "excluir" | "marcar" | "desmarcar", tarefa
LOOPING = "enquanto", expressaoData, criar
CONDICIONAL = "se", expressaoData | expressaoTag, "exibir" | "ocultar"
EXPRESSAODATA = "data", "<" | ">" | "=", data, ["e" | "ou" EXPRESSAODATA]
EXPRESSAOTAG = "tag" "=" tag ["e" | "ou" EXPRESSAOTAG]
RELATORIO = "gerar relatório"
DESCRICAO = LETTER, { LETTER | DIGIT } ;
TAG = LETTER, { LETTER | DIGIT | "_" } ;
TAREFA = DIGIT, { DIGIT } ;
LETTER = ( a | ... | z | A | ... | Z ) ;
DIGIT = ( 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 ) ;
DATA = dia "/" mes "/" ano ;
DIA = "01" | "02" | "03" | ... | "31" ;
MES = "01" | "02" | "03" | ... | "12" ;