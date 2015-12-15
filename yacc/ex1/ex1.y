%{
#include <stdio.h>
%}
%token CAT DOG SLEEPS RUNS NUL
%%
statement: noun verb {printf("success\n");}
noun: CAT | DOG ;
verb: SLEEPS | RUNS ;
%%
#include "lex.yy.c"
main() {
	yyparse();
}
yyerror(char *s) {
	printf("%s\n",s);
}
