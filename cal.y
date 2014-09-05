%{
#include <stdio.h>
#include <math.h>
double atof();
extern char *yytext;
extern char sym[26][26];
float val[26];
int i;
%}

%union  {
  int var;
  float flt;
  char *string;
  }
%token <var> IDENT
%token <flt> REAL
%token <var> INT
%type <flt> expr
%token  ASSIGNOP
%left  ADDOP SUBOP 
%left  MULOP DIVOP
%left  MODOP
%%

prog : prog stmt '\n'    
     | 
     ;

stmt : expr      {printf("%f \n", $1);}
     | IDENT ASSIGNOP expr       { 
               i=0;
          while (strcmp(sym[i],$1)!=0) {
            i++;
            if (i==26) break;
          }
          if (i<26) val[i]=$3;
        }
     ;

expr : IDENT      {
          $$ = 0;
          i=0;
          while (strcmp(sym[i],$1)!=0) {
            i++;
            if (i==26) break;
          }
          if (i<26) $$=val[i];
        }
     | INT      {$$ = $1;}
     | REAL        {$$ = $1;}
     | expr ADDOP expr          {$$ = $1 + $3;}
     | expr SUBOP expr          {$$ = $1 - $3;}
     | SUBOP expr          {$$ = -$2;}
     | expr MULOP expr          {$$ = $1 * $3;}
     | expr DIVOP expr          {$$ = $1 / $3;}
     | expr MODOP expr          {$$ = fmodf($1,$3);}
     | '(' expr ')'             {$$ = $2;}
     ;
%%

main()
{ 
  return(yyparse());
}

yyerror(char *s) 
{
  fprintf(stderr, "%s\n", s);
}

