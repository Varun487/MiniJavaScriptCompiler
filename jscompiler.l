%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}

%%

"console.log"		   {printf("T_PRINT ");}

"("					   {printf("T_OPEN_BRACKET ");}
")"					   {printf("T_CLOSE_BRACKET ");}
"{"					   {printf("T_OPEN_CURLY ");}
"}"					   {printf("T_CLOSE_CURLY ");}
"["					   {printf("T_OPEN_SQUARE ");}
"]"					   {printf("T_CLOSE_SQUARE ");}

";"					   {printf("T_SEMICOLON ");}
"\n"				   {printf("T_NEXT_LINE\n");}
\/\/.*				   {printf("T_SINGLE_COMMENT ");}
\/*.\*\/		   	   {printf("T_MULTI_COMMENT ");}
","					   {printf("T_SEPARATOR ");}

"true"		   		   {printf("T_TRUE ");}
"false"		   		   {printf("T_FALSE ");}
"undefined"			   {printf("T_UNDEFINED ");}
"null"				   {printf("T_NULL ");}
"break"				   {printf("T_BREAK ");}
"for"				   {printf("T_FOR ");}
"let"				   {printf("T_LET ");}
"var"				   {printf("T_VAR ");}
"const"				   {printf("T_CONST ");}
"continue"			   {printf("T_CONTINUE ");}

[0-9]+(\.[0-9]+)?		    {printf("T_NUMBER ");}
\"(.*?)\"		   	   		{printf("T_STRING ");}
[a-zA-z_$][a-zA-z0-9_$]*	{printf("T_IDENTIFIER ");}

"+"						{printf("T_ADD ");}
"-"						{printf("T_SUB ");}
"*"						{printf("T_MUL ");}
"/"						{printf("T_DIV ");}
"%"						{printf("T_REM ");}
"="						{printf("T_ASSIGN ");}
"=="					{printf("T_EQ ");}
"!="					{printf("T_NEQ ");}
"<"						{printf("T_LT ");}
"<="					{printf("T_LTE ");}
">"						{printf("T_GT ");}
">="					{printf("T_GTE ");}
"&&"					{printf("T_AND ");}
"||"					{printf("T_OR ");}
"!"						{printf("T_NOT ");}
"."						{printf("T_DOT ");}
"++"					{printf("T_INCREMENT ");}
"--"					{printf("T_DECREMENT ");}
"+="					{printf("T_INC_ASSIGN ");}
"-="					{printf("T_DEC_ASSIGN ");}

[ \t]                  ;
.                      {ECHO; yyerror ("unexpected character");}

%%

int yywrap (void) {return 1;}

// [a-zA-Z]			   	   {yylval.id = yytext[0]; return identifier;}
// [0-9]+                  {yylval.num = atoi(yytext); return number;}
// "print"				   {return print;}
// "exit"				   {return exit_command;}
// [0-9]+				   {printf("T_NUMBER\n");}
// [ \t\n]                 ;
// [-+=;]           	   {return yytext[0];}
