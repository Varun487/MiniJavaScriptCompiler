%{
// called in case of syntactical errors
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

struct identifier{
    char var_name[31];
	union data {
		char str[100]; 
		double num;
	} data;
} identifier;

// prints a number to stdout
void print_number(double number);

// converts string given in yytext into desired output string
char *convert_string(char *string);

// prints a string to stdout
void print_string(char *string);

// Primitive symbol table implementation
int symbols[52];

// Given symbol character, will look up value int of that in symbol table
int getSymbolVal(char symbol);

// Given symbol and value, will make sure that the respective symbol gets that value
void updateSymbolVal(char symbol, int val);

%}

/* Yacc definitions */

// Specify the different types that the lexical analyser can return
// Similar to union in c
%union 
{
	double num;
	char *id;
	char *str;
}

// Which of the productions are going to be the starting rule or production
%start line

// Expect a token called print, exit_command, etc.
// It tells yacc to generate a header file with these values that the lex can use
%token T_PRINT

%token T_OPEN_BRACKET
%token T_CLOSE_BRACKET
%token T_OPEN_CURLY
%token T_CLOSE_CURLY
%token T_OPEN_SQUARE
%token T_CLOSE_SQUARE

%token T_SEMICOLON
%token T_NEXT_LINE
%token T_SINGLE_COMMENT
%token T_MULTI_COMMENT
%token T_SEPARATOR 

%token T_TRUE 
%token T_FALSE 
%token T_UNDEFINED 
%token T_NULL 
%token T_BREAK 
%token T_FOR 
%token T_LET 
%token T_VAR 
%token T_CONST 
%token T_CONTINUE 

// %token T_NUMBER 
// %token T_STRING 
// %token T_IDENTIFIER 

%token T_ADD 
%token T_SUB 
%token T_MUL 
%token T_DIV 
%token T_REM 
%token T_ASSIGN 
%token T_EQ 
%token T_NEQ 
%token T_LT 
%token T_LTE 
%token T_GT 
%token T_GTE 
%token T_AND 
%token T_OR 
%token T_NOT 
%token T_DOT 
%token T_INCREMENT 
%token T_DECREMENT 
%token T_INC_ASSIGN 
%token T_DEC_ASSIGN 

// token number gets stored in 'num' in the union type
%token <num> T_NUMBER
%token <str> T_STRING
%token <id> T_IDENTIFIER

// Assign types to non terminals on left side of grammar
// %type <num> line exp term
// %type <id> assignment

%%

/* descriptions of expected inputs corresponding actions (in C) */

line    : T_SINGLE_COMMENT end						{;}
		| line T_SINGLE_COMMENT end 				{;}
		| T_PRINT print_exp 						{;}
		| line T_PRINT print_exp 					{;}
		| T_VAR T_IDENTIFIER T_ASSIGN val 			{;}
		| line T_VAR T_IDENTIFIER T_ASSIGN val 		{;}
		;

print_exp 	: T_OPEN_BRACKET T_NUMBER T_CLOSE_BRACKET end {print_number($2);}
			| T_OPEN_BRACKET T_STRING T_CLOSE_BRACKET end {print_string($2);}
			;

val 	: T_NUMBER end								{printf("\nAssigned %lf\n", $1);}
		| T_STRING end 								{printf("\nAssigned ");print_string($1);}
		;

end 	: T_NEXT_LINE								{;}
		| T_NEXT_LINE end							{;}
		| T_SEMICOLON 								{;}
		| T_SEMICOLON end 							{;}
		;

%%                     /* C code */

void print_number(double number) {
	printf("\n\noutput> %0.9lf\n\n", number);
}

char *convert_string(char *string) {
		
	char terminator;

	if (string[0] == '\"') {
		terminator = '\"';
	}
	
	else {
		terminator = '\'';
	}

	int i = 1;
	
	int len = 0;

	while (string[i] != terminator) {
	 	len++;
	 	i++;
	}

	printf("\n");

	char *new_string = malloc(strlen(string)*sizeof(char));
	
	return "\n";

}

void print_string(char *string) {

	printf("\n\noutput> ");

	int i = 1;

	char terminator;

	if (string[0] == '\"') {
		terminator = '\"';
	}
	else {
		terminator = '\'';
	}

	while (string[i] != terminator) {
	 	printf("%c", string[i]);
	 	i++;
	}

	printf("\n\n");

}

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
int   getSymbolVal(char symbol)
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


// line : assignment ';'		{;}
// 		| exit_command ';'		{exit(EXIT_SUCCESS);}
// 		| print exp ';'			{printf("> %d\n", $2);}
// 		| console_log exp ';'	{printf("> %d\n", $2);}
// 		| line assignment ';'	{;}
// 		| line print exp ';'	{printf("> %d\n", $3);}
// 		| line console_log exp ';'	{printf("> %d\n", $3);}
// 		| line exit_command ';'	{exit(EXIT_SUCCESS);}
//         ;

// assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
// 			;

// exp    	: term                  {$$ = $1;}
//        	| exp '+' term          {$$ = $1 + $3;}
//        	| exp '-' term          {$$ = $1 - $3;}
//        	;

// term   	: number                {$$ = $1;}
// 		| identifier			{$$ =   getSymbolVal($1);} 
//         ;

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
