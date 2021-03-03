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

// Given symbol character, will look up value of identifier in symbol table
// returns a void pointer to the value of the symbol and
// sets the type value to the datatype of the value
void *get_symbol_value(char *symbol, int *type);

// print the value of an identifier
void print_identifier(char *symbol);

// Given symbol character, will look up value int of that in symbol table
int  getSymbolVal(char symbol);

// Given symbol and value, will make sure that the respective symbol gets that value
void updateSymbolVal(char symbol, int val);

// Get % of 2 numbers
double rem(double a, double b);

// Gets the double value of an identifier
double get_id_num(char *symbol);

// Increment the value of a number identifier by 1
void increment(char *symbol);

// Decrement the value of a number identifier by 1
void decrement(char *symbol);

// Increment the value of a number identifier by val
void inc_assign(char *symbol, double val);

// Decrement the value of a number identifier by val
void dec_assign(char *symbol, double val);

// Multiply the value of a number identifier by val
void mul_assign(char *symbol, double val);

// Divide the value of a number identifier by val
void div_assign(char *symbol, double val);

// Remainder of the value of a number identifier by val
void rem_assign(char *symbol, double val);

// returns whether the 2 numbers are equal
double eq(double val1, double val2);

// returns whether the 2 numbers are not equal
double neq(double val1, double val2);

// returns whether one number is lesser than the other
double lt(double val1, double val2);

double lte(double val1, double val2);

double gt(double val1, double val2);

double gte(double val1, double val2);

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
%token T_MUL_ASSIGN 
%token T_DIV_ASSIGN 
%token T_REM_ASSIGN 

// token number gets stored in 'num' in the union type
%token <num> T_NUMBER
%token <str> T_STRING
%token <id> T_IDENTIFIER

// Assign types to non terminals on left side of grammar
%type <num> math_exp boolean_exp
// %type <id> assignment

%%

/* descriptions of expected inputs corresponding actions (in C) */

line    : T_SINGLE_COMMENT end									{;}
		| line T_SINGLE_COMMENT end 							{;}
		| T_PRINT print_exp 									{;}
		| line T_PRINT print_exp 								{;}
		| T_VAR identifier_exp end 								{;}
		| line T_VAR identifier_exp end 						{;}
		| identifier_exp end 									{;}
		| line identifier_exp end 								{;}
		| math_exp end											{;}
		| line math_exp end										{;}
		| boolean_exp end 										{;}
		| line boolean_exp end 									{;}
		| T_FOR for_exp 										{;}
		| line T_FOR for_exp 									{;}
		| T_WHILE while_exp 									{;}
		| line T_WHILE while_exp 								{;}
		;


while_exp 	: T_OPEN_BRACKET while_condition T_CLOSE_BRACKET   		T_OPEN_CURLY 		 line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET   		T_OPEN_CURLY 		 line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET   		T_OPEN_CURLY for_sep line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET   		T_OPEN_CURLY for_sep line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET for_sep T_OPEN_CURLY 		 line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET for_sep T_OPEN_CURLY 		 line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET for_sep T_OPEN_CURLY for_sep line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET while_condition T_CLOSE_BRACKET for_sep T_OPEN_CURLY for_sep line for_sep T_CLOSE_CURLY end {;}
			;

while_condition : 	boolean_exp 		{;}
				;



for_exp 	: T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET   		T_OPEN_CURLY 		 line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET   		T_OPEN_CURLY 		 line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET   		T_OPEN_CURLY for_sep line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET   		T_OPEN_CURLY for_sep line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET for_sep T_OPEN_CURLY 		 line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET for_sep T_OPEN_CURLY 		 line for_sep T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET for_sep T_OPEN_CURLY for_sep line 		  T_CLOSE_CURLY end {;}
			| T_OPEN_BRACKET for_conditions T_CLOSE_BRACKET for_sep T_OPEN_CURLY for_sep line for_sep T_CLOSE_CURLY end {;}
			;

for_sep 	: T_NEXT_LINE 										{;}
			| for_sep T_NEXT_LINE 								{;}
			;

for_conditions	: identifier_exp T_SEMICOLON boolean_exp T_SEMICOLON identifier_exp {;}
				;

print_exp 	: T_OPEN_BRACKET print_val T_CLOSE_BRACKET end 		{;}
			;

print_val 	: T_NUMBER 								{print_number($1);}
			| T_STRING								{print_string($1);}
			| T_TRUE								{printf("output> true\n");}
			| T_FALSE								{printf("output> false\n");}
			| T_UNDEFINED							{printf("output> undefined\n");}
			| T_NULL								{printf("output> null\n");}
			| T_IDENTIFIER							{print_identifier($1);}
			| math_exp 								{print_number($1);}
			;

boolean_exp 	: T_NUMBER T_EQ T_NUMBER 			{$$ = eq($1, $3);}
				| T_IDENTIFIER T_EQ T_NUMBER 		{$$ = eq(get_id_num($1), $3);}
				| T_NUMBER T_EQ T_IDENTIFIER 		{$$ = eq($1, get_id_num($3));}
				| T_IDENTIFIER T_EQ T_IDENTIFIER 	{$$ = eq(get_id_num($1), get_id_num($3));}
				| T_NUMBER T_NEQ T_NUMBER 			{$$ = neq($1, $3);}
				| T_IDENTIFIER T_NEQ T_NUMBER 		{$$ = neq(get_id_num($1), $3);}
				| T_NUMBER T_NEQ T_IDENTIFIER 		{$$ = neq($1, get_id_num($3));}
				| T_IDENTIFIER T_NEQ T_IDENTIFIER 	{$$ = neq(get_id_num($1), get_id_num($3));}
				| T_NUMBER T_LT T_NUMBER 			{$$ = lt($1, $3);}
				| T_IDENTIFIER T_LT T_NUMBER 		{$$ = lt(get_id_num($1), $3);}
				| T_NUMBER T_LT T_IDENTIFIER 		{$$ = lt($1, get_id_num($3));}
				| T_IDENTIFIER T_LT T_IDENTIFIER 	{$$ = lt(get_id_num($1), get_id_num($3));}
				| T_NUMBER T_LTE T_NUMBER 			{$$ = lte($1, $3);}
				| T_IDENTIFIER T_LTE T_NUMBER 		{$$ = lte(get_id_num($1), $3);}
				| T_NUMBER T_LTE T_IDENTIFIER 		{$$ = lte($1, get_id_num($3));}
				| T_IDENTIFIER T_LTE T_IDENTIFIER 	{$$ = lte(get_id_num($1), get_id_num($3));}
				| T_NUMBER T_GT T_NUMBER 			{$$ = gt($1, $3);}
				| T_IDENTIFIER T_GT T_NUMBER 		{$$ = gt(get_id_num($1), $3);}
				| T_NUMBER T_GT T_IDENTIFIER 		{$$ = gt($1, get_id_num($3));}
				| T_IDENTIFIER T_GT T_IDENTIFIER 	{$$ = gt(get_id_num($1), get_id_num($3));}
				| T_NUMBER T_GTE T_NUMBER 			{$$ = gte($1, $3);}
				| T_IDENTIFIER T_GTE T_NUMBER 		{$$ = gte(get_id_num($1), $3);}
				| T_NUMBER T_GTE T_IDENTIFIER 		{$$ = gte($1, get_id_num($3));}
				| T_IDENTIFIER T_GTE T_IDENTIFIER 	{$$ = gte(get_id_num($1), get_id_num($3));}
				;

identifier_exp 	: T_IDENTIFIER T_ASSIGN T_NUMBER 		{update_symbol_table_number($1, $3);}
				| T_IDENTIFIER T_ASSIGN T_STRING 		{update_symbol_table_string($1, $3);}
				| T_IDENTIFIER T_ASSIGN T_TRUE 			{update_symbol_table_bool($1, 2);}
				| T_IDENTIFIER T_ASSIGN T_FALSE 		{update_symbol_table_bool($1, 3);}
				| T_IDENTIFIER T_ASSIGN T_NULL 			{update_symbol_table_bool($1, 4);}
				| T_IDENTIFIER T_ASSIGN T_UNDEFINED 	{update_symbol_table_bool($1, 5);}
				| T_IDENTIFIER T_ASSIGN math_exp 		{update_symbol_table_number($1, $3);}
				| T_IDENTIFIER T_INCREMENT				{increment($1);}
				| T_IDENTIFIER T_DECREMENT 				{decrement($1);}
				| T_INCREMENT T_IDENTIFIER  			{increment($2);}
				| T_DECREMENT T_IDENTIFIER				{decrement($2);}
				| T_IDENTIFIER T_INC_ASSIGN T_NUMBER 	{inc_assign($1, $3);}
				| T_IDENTIFIER T_DEC_ASSIGN T_NUMBER 	{dec_assign($1, $3);}
				| T_IDENTIFIER T_MUL_ASSIGN T_NUMBER 	{mul_assign($1, $3);}
				| T_IDENTIFIER T_DIV_ASSIGN T_NUMBER 	{div_assign($1, $3);}
				| T_IDENTIFIER T_REM_ASSIGN T_NUMBER 	{rem_assign($1, $3);}
				;

math_exp 	: T_NUMBER '+' T_NUMBER 				{$$ = $1 + $3;}
			| T_NUMBER '-' T_NUMBER 				{$$ = $1 - $3;}
			| T_NUMBER '*' T_NUMBER 				{$$ = $1 * $3;}			
			| T_NUMBER '/' T_NUMBER 				{$$ = $1 / $3;}
			| T_NUMBER '%' T_NUMBER 				{$$ = rem($1, $3);}
			| math_exp '+' T_NUMBER 				{$$ = $1 + $3;}
			| math_exp '-' T_NUMBER 				{$$ = $1 - $3;}
			| math_exp '*' T_NUMBER 				{$$ = $1 * $3;}			
			| math_exp '/' T_NUMBER 				{$$ = $1 / $3;}
			| math_exp '%' T_NUMBER 				{$$ = rem($1, $3);}
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

	for (i = 0; i < 31 && identifer[i] != ' ' && identifer[i] != '+' && identifer[i] != '-'; i++) {
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

void *get_symbol_value(char *symbol, int *type) {

	// printf("getsymbol> %s\n", symbol);

	int index = compute_symbol_index(symbol);

	void *dummy;

	if (symbol_table[index].occupied == 0) {
		*type = -1;
		return dummy;
	}

	*type = symbol_table[index].datatype_flag;

	switch(*type) {
		case 0:
			return (void*) &symbol_table[index].data.num;
			break;
		
		case 1:
			return (void*) symbol_table[index].data.str;
			break;
		
		default:
			return dummy;
			break;
	}

}

// print the value of an identifier
void print_identifier(char *symbol) {
	
	symbol = convert_identifer(symbol);

	int type = 0;
	
	void *void_val = get_symbol_value(symbol, &type);

	if (type == 0) {
		double *int_val = (double *) void_val;
		printf("printidentifier> %s -> %lf\n", symbol, *int_val);
	}
	else if (type == 1) {
		char *char_val = (char *) void_val;
		printf("printidentifier> %s -> %s\n", symbol, char_val);
	}
	else if (type == 2) {
		printf("printidentifier> %s -> true\n", symbol);
	}
	else if (type == 3) {
		printf("printidentifier> %s -> false\n", symbol);
	}
	else if (type == 4) {
		printf("printidentifier> %s -> null\n", symbol);
	}
	else if (type == 5) {
		printf("printidentifier> %s -> undefined\n", symbol);
	}
	else {
		printf("printidentifier> ERROR: No variable called %s\n", symbol);
	}

}

double rem(double a, double b) {
	return (int)a % (int)b;
}

double get_id_num(char *symbol) {
	symbol = convert_identifer(symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *val = (double *) void_val;
	return *val;
}

// Increment the value of a number identifier by 1
void increment(char *symbol) {
	double val = get_id_num(symbol);
	// printf("val: %lf\n", val);
	val += 1;
	update_symbol_table_number(symbol, val);
}

// Decrement the value of a number identifier by 1
void decrement(char *symbol){
	double val = get_id_num(symbol);
	// printf("val: %lf\n", val);
	val -= 1;
	update_symbol_table_number(symbol, val);
}

// Increment the value of a number identifier by val
void inc_assign(char *symbol, double val){
	symbol = convert_identifer(symbol);
	// printf("symbol: %s\n", symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *prev_val = (double *) void_val;
	// printf("before increment: %lf\n", *val);
	*prev_val += val;
	// printf("after increment: %lf\n", *val);
	update_symbol_table_number(symbol, *prev_val);
}

// Decrement the value of a number identifier by val
void dec_assign(char *symbol, double val){
	symbol = convert_identifer(symbol);
	// printf("symbol: %s\n", symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *prev_val = (double *) void_val;
	// printf("before increment: %lf\n", *val);
	*prev_val -= val;
	// printf("after increment: %lf\n", *val);
	update_symbol_table_number(symbol, *prev_val);
}

// Multiply the value of a number identifier by val
void mul_assign(char *symbol, double val) {
	symbol = convert_identifer(symbol);
	// printf("symbol: %s\n", symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *prev_val = (double *) void_val;
	// printf("before increment: %lf\n", *val);
	*prev_val *= val;
	// printf("after increment: %lf\n", *val);
	update_symbol_table_number(symbol, *prev_val);
}

// Divide the value of a number identifier by val
void div_assign(char *symbol, double val) {
	symbol = convert_identifer(symbol);
	// printf("symbol: %s\n", symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *prev_val = (double *) void_val;
	// printf("before increment: %lf\n", *val);
	*prev_val /= val;
	// printf("after increment: %lf\n", *val);
	update_symbol_table_number(symbol, *prev_val);
}

// Remainder of the value of a number identifier by val
void rem_assign(char *symbol, double val) {
	symbol = convert_identifer(symbol);
	// printf("symbol: %s\n", symbol);
	int type = 0;
	void *void_val = get_symbol_value(symbol, &type);
	double *prev_val = (double *) void_val;
	// printf("before increment: %lf\n", *val);
	*prev_val = (int)*prev_val % (int)val;
	// printf("after increment: %lf\n", *val);
	update_symbol_table_number(symbol, *prev_val);
}

// returns whether the 2 numbers are equal
double eq(double val1, double val2) {
	if (val1 == val2) {
		printf("booleanexp> %lf == %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf == %lf -> false\n", val1, val2);
	return 0.0;
}

// returns whether the 2 numbers are not equal
double neq(double val1, double val2){
	if (val1 != val2) {
		printf("booleanexp> %lf != %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf != %lf -> false\n", val1, val2);
	return 0.0;
}

// returns whether one number is lesser than the other
double lt(double val1, double val2){
	if (val1 < val2) {
		printf("booleanexp> %lf < %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf < %lf -> false\n", val1, val2);
	return 0.0;
}

double lte(double val1, double val2){
	if (val1 <= val2) {
		printf("booleanexp> %lf <= %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf <= %lf -> false\n", val1, val2);
	return 0.0;
}

double gt(double val1, double val2){
	if (val1 > val2) {
		printf("booleanexp> %lf > %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf > %lf -> false\n", val1, val2);
	return 0.0;
}

double gte(double val1, double val2){
	if (val1 >= val2) {
		printf("booleanexp> %lf >= %lf -> true\n", val1, val2);
		return 1.0;
	}
	printf("booleanexp> %lf >= %lf -> false\n", val1, val2);
	return 0.0;
}

int main (void) {
	// init symbol table
	int i;
	
	for(i=0; i<100; i++) {
		symbol_table[i].occupied = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s at line\n", s);}
