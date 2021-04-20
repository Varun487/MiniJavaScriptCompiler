jscompiler: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o jscompiler

lex.yy.c: y.tab.c jscompiler.l
	lex jscompiler.l

y.tab.c: jscompiler.y
	yacc -d jscompiler.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h jscompiler jscompiler.dSYM
