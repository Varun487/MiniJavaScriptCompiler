%{
	#include "y.tab.h"
	#include <string.h>
	#include <stdlib.h>

	char *justparsed;
%}

%%

[0-9]+                              {yylval.rvalues.value = strdup(yytext); return T_NUM;}
:									{yylval.rvalues.value = strdup(yytext); return T_COLON;}
label                               {yylval.rvalues.value = strdup(yytext); return T_LABEL;}
iffalse                             {yylval.rvalues.value = strdup(yytext); return T_FALSE;}
iftrue                              {yylval.rvalues.value = strdup(yytext); return T_TRUE;}
goto                                {yylval.rvalues.value = strdup(yytext); return T_GOTO;}
l[0-9]+                             {yylval.rvalues.value = strdup(yytext); return T_LVAR;}
t[0-9]+                             {yylval.rvalues.value = strdup(yytext); return T_TVAR;}
([a-zA-Z]|\_)([a-zA-Z0-9]|\_)*      {yylval.rvalues.value = strdup(yytext); return T_AVAR;}
(\[|\])								{return(yytext[0]);}

\"([^"]|\\\")*\"|\'([^']|\\\')*\' 	{yylval.rvalues.value = strdup(yytext); return T_STR;}
=                                   {yylval.rvalues.value = strdup(yytext); return T_ASSIGN;}
(&&|\|\|)							{yylval.rvalues.value = strdup(yytext); return T_BOOLOP;}
(\<|\>|\=)\=?						{yylval.rvalues.value = strdup(yytext); return T_LOGOP;}
(\+|\-|\*|\/)                       {yylval.rvalues.value = strdup(yytext); return T_MATOP;}
[\n]								{yylval.rvalues.value = strdup(yytext); return T_DELIM;}
[\t ]	                            {}	


%%
