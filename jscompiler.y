%{
// called in case of syntactical errors
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

// prints a number to stdout
void print_number(double number);

// converts string given in yytext into desired output string
char *convert_string(char *string);

// prints a string to stdout
void print_string(char *string);

// struct for identifer
struct identifier{
    char *id;
	int datatype_flag;
	int occupied;
	union data {
		char *str; 
		double num;
	} data;
} identifier;

/*
In datatype flag
0 -> double
1 -> str
2 -> true
3 -> false
4 -> undefined
5 -> null
*/

// symbol table
struct identifier symbol_table[100];

// Makes identifier string
char *convert_identifer(char *identifer);

// get the index of an existing entry or to add a new entry
int compute_symbol_index(char *symbol);

// Updates symbol table with a variable of number type
void update_symbol_table_number(char *symbol, double val);

// Updates symbol table with a variable of string type
void update_symbol_table_string(char *symbol, char *val);

// Updates symbol table with a variable of boolean type
void update_symbol_table_bool(char *symbol, int type);

// Given symbol character, will look up value int of that in symbol table
int  getSymbolVal(char symbol);

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
%token T_WHILE
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

line    : T_SINGLE_COMMENT end									{;}
		| line T_SINGLE_COMMENT end 							{;}
		| T_PRINT print_exp 									{;}
		| line T_PRINT print_exp 								{;}
		| T_VAR identifier_exp 									{;}
		| line T_VAR identifier_exp 							{;}
		| identifier_exp 										{;}
		| line identifier_exp 									{;}
		;

print_exp 	: T_OPEN_BRACKET print_val T_CLOSE_BRACKET end 		{;}
			;

print_val 	: T_NUMBER 								{print_number($1);}
			| T_STRING								{print_string($1);}
			| T_TRUE								{printf("output> true\n");}
			| T_FALSE								{printf("output> false\n");}
			| T_UNDEFINED							{printf("output> undefined\n");}
			| T_NULL								{printf("output> null\n");}
			;

identifier_exp 	: T_IDENTIFIER T_ASSIGN T_NUMBER end 		{update_symbol_table_number($1, $3);}
				| T_IDENTIFIER T_ASSIGN T_STRING end 		{update_symbol_table_string($1, $3);}
				| T_IDENTIFIER T_ASSIGN T_TRUE end 			{update_symbol_table_bool($1, 2);}
				| T_IDENTIFIER T_ASSIGN T_FALSE end 		{update_symbol_table_bool($1, 3);}
				| T_IDENTIFIER T_ASSIGN T_NULL end 			{update_symbol_table_bool($1, 4);}
				| T_IDENTIFIER T_ASSIGN T_UNDEFINED end 	{update_symbol_table_bool($1, 5);}
				;

end 	: T_NEXT_LINE								{;}
		| T_NEXT_LINE end							{;}
		| T_SEMICOLON 								{;}
		| T_SEMICOLON end 							{;}
		;

%%                     /* C code */

void print_number(double number) {
	printf("output> %0.9lf\n", number);
}

char *convert_string(char *string) {
		
	char terminator;

	if (string[0] == '\"') {
		terminator = '\"';
	}
	
	else {
		terminator = '\'';
	}

	// printf("\n\nconvert_string -> %s : %c\n", string, terminator);

	int len = 1;
	
	while (string[len] != terminator) {
	 	len++;
	}

	// printf("len: %d\n", len);

	char *new_string = malloc(len*sizeof(char));

	for (int i = 0; i < len-1; i++) {
		new_string[i] = string[i+1];
	}

	new_string[len-1] = '\0';

	// printf("new_string: %s\n", new_string);

	return new_string;

}

void print_string(char *string) {
	printf("output> %s\n", convert_string(string));
}

char *convert_identifer(char *identifer) {
	
	char *new_identifier = malloc(31*sizeof(char));

	int i;

	for (i = 0; i < 31 && identifer[i] != ' '; i++) {
		new_identifier[i] = identifer[i];
	}
	
	// printf("new_identifier: %s\n", new_identifier);

	return new_identifier;
}

int compute_symbol_index(char *symbol) {
	
	// printf("symbol: %s\n", symbol);

	for (int i = 0; i < 100; i++) {
		if (symbol_table[i].occupied == 1) {
			if (strcmp(symbol, symbol_table[i].id) == 0) {
				return i;
			}
		}
		else {
			return i;
		}
	}
}

void update_symbol_table_number(char *symbol, double val) {

	symbol = convert_identifer(symbol);

	int index = compute_symbol_index(symbol);

	symbol_table[index].occupied = 1;
	symbol_table[index].id = symbol;
	symbol_table[index].datatype_flag = 0;
	symbol_table[index].data.num = val;

	printf("Assigned> %s = %lf\n", symbol, val);
	// printf("symbol: %s\n", symbol);
	// printf("index: %d\n", index);

	// printf("occupied: %d\n", symbol_table[index].occupied);
	// printf("id: %s\n", symbol_table[index].id);
	// printf("datatype_flag: %d\n", symbol_table[index].datatype_flag);
	// printf("num: %lf\n", symbol_table[index].data.num);
}

void update_symbol_table_string(char *symbol, char *val) {

	symbol = convert_identifer(symbol);
	val = convert_string(val);

	int index = compute_symbol_index(symbol);

	symbol_table[index].occupied = 1;
	symbol_table[index].id = symbol;
	symbol_table[index].datatype_flag = 1;
	symbol_table[index].data.str = val;

	printf("Assigned> %s = %s\n", symbol, val);
	// printf("symbol: %s\n", symbol);
	// printf("index: %d\n", index);

	// printf("occupied: %d\n", symbol_table[index].occupied);
	// printf("id: %s\n", symbol_table[index].id);
	// printf("datatype_flag: %d\n", symbol_table[index].datatype_flag);
	// printf("str: %s\n", symbol_table[index].data.str);
}

void update_symbol_table_bool(char *symbol, int type) {
	
	symbol = convert_identifer(symbol);
	int index = compute_symbol_index(symbol);

	symbol_table[index].occupied = 1;
	symbol_table[index].id = symbol;
	symbol_table[index].datatype_flag = type;

	printf("Assigned> %s = dt_%d\n", symbol, type);
	// printf("symbol: %s\n", symbol);
	// printf("index: %d\n", index);

	// printf("occupied: %d\n", symbol_table[index].occupied);
	// printf("id: %s\n", symbol_table[index].id);
	// printf("datatype_flag: %d\n", symbol_table[index].datatype_flag);
}

int main (void) {
	// init symbol table
	int i;
	
	for(i=0; i<100; i++) {
		symbol_table[i].occupied = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

// int computeSymbolIndex(char token)
// {
// 	int idx = -1;
// 	if(islower(token)) {
// 		idx = token - 'a' + 26;
// 	} else if(isupper(token)) {
// 		idx = token - 'A';
// 	}
// 	return idx;
// } 

/* returns the value of a given symbol */
// int   getSymbolVal(char symbol)
// {
// 	int bucket = computeSymbolIndex(symbol);
// 	return symbols[bucket];
// }

/* updates the value of a given symbol */
// void updateSymbolVal(char symbol, int val)
// {
// 	int bucket = computeSymbolIndex(symbol);
// 	symbols[bucket] = val;
// }

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
