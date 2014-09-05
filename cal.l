%{
#include "y.tab.h"
#include <stdlib.h>
void yyerror(char *);
extern YYSTYPE yylval;
char sym[26][26];
int count=0;
%}
%%

[ \t]		;
[a-zA-Z][a-zA-Z0-9_]*	{
				strcpy(sym[count],yytext);
				yylval.string=sym[count];
				count++;
				if (count==26) {count=0;}
				return(IDENT);
			}
[0-9]*\.[0-9]+	{yylval.flt = atof(yytext); return(REAL);}
[0-9]+		{yylval.var = atoi(yytext); return(INT);}
"+"		{return(ADDOP);}
"-"		{return(SUBOP);}
"*"		{return(MULOP);}
"/"		{return(DIVOP);}
"%"		{return(MODOP);}
=		{return(ASSIGNOP);}
"("		{return(yytext[0]);}
")"		{return(yytext[0]);}
\n		{return(yytext[0]);}
.           	{yyerror("invalid character");}
%%
