%{
#include <stdio.h>
%}
%token NUM NUL
%%
prog : expr '.'	{printf("ans=%d\n", $1);}
	 ;
expr : expr '+'	term	{$$ = $1 + $3;}
	 | expr '-' term	{$$ = $1 - $3;}
	 | term 	{$$ = $1;}
	 ;
term : term '*'	factor	{$$ = $1 * $3;}
	 | term '/' factor	{$$ = $1 / $3;}
	 | factor 	{$$ = $1;}
	 ;
factor : '(' expr ')'	{$$ = $2;}
	   | NUM	{$$ = $1;}
%%
#include "lex.yy.c"
main(){
	yyparse();
}
yyerror(char *s){
	printf("ERROR=%s\n", s);
}
