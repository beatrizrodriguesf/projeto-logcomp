# Caminho para Bison com nome curto do Windows (evita espaços)
BISON = "C:\Progra~2\GnuWin32\bin\bison.exe"
FLEX  = flex
CC    = gcc
OUT   = parser.exe

all: $(OUT)

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d parser.y

lex.yy.c: tokenizer.l
	$(FLEX) tokenizer.l

$(OUT): parser.tab.c lex.yy.c
	$(CC) -o $(OUT) parser.tab.c lex.yy.c

clean:
	del /Q parser.exe parser.tab.c parser.tab.h lex.yy.c
