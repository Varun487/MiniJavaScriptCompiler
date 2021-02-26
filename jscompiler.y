%{
// called in case of syntactical errors
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

// Primitive symbol table implementation - max of 52 vars
// Each var can be a single upper case / lower case letter
int symbols[52];

// Given symbol character, will look up value int of that in symbol table
int symbolVal(char symbol);

// Given symbol and value, will make sure that the respective symbol gets that value
void updateSymbolVal(char symbol, int val);
%}

/* Yacc definitions */

// Specify the different types that the lexical analyser can return
// Similar to union in c
%union {int num; char id;}

// Which of the productions are going to be the starting rule or production
%start line

// Expect a token called print, exit_command, etc.
// It tells yacc to generate a header file with these values that the lex can use
%token print
%token exit_command
// token number gets stored in 'num' in the union type
%token <num> number
%token <id> identifier

// Assign types to non terminals on left side of grammar
%type <num> line exp term 
%type <id> assignment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    : assignment ';'		{;}
		| exit_command ';'		{exit(EXIT_SUCCESS);}
		| print exp ';'			{printf("> Printing %d\n", $2);}
		| line assignment ';'	{;}
		| line print exp ';'	{printf("> Printing %d\n", $3);}
		| line exit_command ';'	{exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
			;
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: number                {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
