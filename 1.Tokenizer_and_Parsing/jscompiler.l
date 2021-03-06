%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}

%option yylineno

%%

"console.log"		   {/* printf("T_PRINT "); */ return T_PRINT;}

"("					   {/* printf("T_OPEN_BRACKET "); */ return T_OPEN_BRACKET;}
")"					   {/* printf("T_CLOSE_BRACKET "); */ return T_CLOSE_BRACKET;}
"{"					   {/* printf("T_OPEN_CURLY "); */ return T_OPEN_CURLY;}
"}"					   {/* printf("T_CLOSE_CURLY "); */ return T_CLOSE_CURLY;}
"["					   {/* printf("T_OPEN_SQUARE "); */ return T_OPEN_SQUARE;}
"]"					   {/* printf("T_CLOSE_SQUARE "); */ return T_CLOSE_SQUARE;}

";"					   {/* printf("T_SEMICOLON "); */ return T_SEMICOLON;}
"\n"				   {/* printf("T_NEXT_LINE\n"); printf("\n"); */ return T_NEXT_LINE;}
\/\/.*				   {/* printf("T_SINGLE_COMMENT "); */ return T_SINGLE_COMMENT;}
\/*.*\*\/		   	   {/* printf("T_MULTI_COMMENT "); */ return T_MULTI_COMMENT;}
","					   {/* printf("T_SEPARATOR "); */ return T_SEPARATOR;}

"true"		   		   {/* printf("T_TRUE "); */ return T_TRUE;}
"false"		   		   {/* printf("T_FALSE "); */ return T_FALSE;}
"undefined"			   {/* printf("T_UNDEFINED "); */ return T_UNDEFINED;}
"null"				   {/* printf("T_NULL "); */ return T_NULL;}
"break"				   {/* printf("T_BREAK "); */ return T_BREAK;}
"for"				   {/* printf("T_FOR "); */ return T_FOR;}
"while"				   {/* printf("T_WHILE "); */ return T_WHILE;}
"let"				   {/* printf("T_LET "); */ return T_LET;}
"var"				   {/* printf("T_VAR "); */ return T_VAR;}
"const"				   {/* printf("T_CONST "); */ return T_CONST;}
"continue"			   {/* printf("T_CONTINUE "); */ return T_CONTINUE;}

-?[0-9]+(\.[0-9]+)?		    {/* printf("T_NUMBER "); */ char *ptr; yylval.num = strtod(yytext, &ptr); return T_NUMBER;}
\".*\"		   	   			{/* printf("T_STRING "); */ yylval.str = yytext; return T_STRING;}
\'.*\'		   	   			{/* printf("T_STRING "); */ yylval.str = yytext; return T_STRING;}
[a-zA-z_$][a-zA-z0-9_$]*	{/* printf("T_IDENTIFIER "); */ yylval.id = yytext; return T_IDENTIFIER;}

"+"						{return '+';}
"-"						{return '-';}
"*"						{return '*';}
"/"						{return '/';}
"%"						{return '%';}
"="						{/* printf("T_ASSIGN "); */ return T_ASSIGN;}
"=="					{/* printf("T_EQ "); */ return T_EQ;}
"!="					{/* printf("T_NEQ "); */ return T_NEQ;}
"<"						{/* printf("T_LT "); */ return T_LT;}
"<="					{/* printf("T_LTE "); */ return T_LTE;}
">"						{/* printf("T_GT "); */ return T_GT;}
">="					{/* printf("T_GTE "); */ return T_GTE;}
"&&"					{/* printf("T_AND "); */ return T_AND;}
"||"					{/* printf("T_OR "); */ return T_OR;}
"!"						{/* printf("T_NOT "); */ return T_NOT;}
"."						{/* printf("T_DOT "); */ return T_DOT;}
"++"					{/* printf("T_INCREMENT "); */ return T_INCREMENT;}
"--"					{/* printf("T_DECREMENT "); */ return T_DECREMENT;}
"+="					{/* printf("T_INC_ASSIGN "); */ return T_INC_ASSIGN;}
"-="					{/* printf("T_DEC_ASSIGN "); */ return T_DEC_ASSIGN;}
"*=" 					{/* printf("T_MUL_ASSIGN "); */ return T_MUL_ASSIGN;}
"/=" 					{/* printf("T_DIV_ASSIGN "); */ return T_DIV_ASSIGN;}
"%=" 					{/* printf("T_REM_ASSIGN "); */ return T_REM_ASSIGN;}

[ \t]                  ;
.                      {ECHO; yyerror ("Lexical error: unexpected character");}

%%

int yywrap (void) {return 1;}
