CC=gcc

compiler: lex.yy.c header.h
	$(CC) lex.yy.c -ll -o icg -w

lex.yy.c: y.tab.c lex.l
	lex lex.l

y.tab.c: par.y
	yacc -d par.y

clean:
	$(RM) lex.yy.c asticg y.tab.c y.tab.h
