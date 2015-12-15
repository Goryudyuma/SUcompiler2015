/*アクションが途中に出現する場合の例*/
%{
int x,y;
%}
%token CAT DOG SLEEPS RUNS NUL
%%
statement: noun {$$=1;} verb {x=$2; y=$3;}
noun: CAT | DOG
verb: SLEEPS | RUNS {$$ = 100;}
%%
#include "lex.yy.c"
main(){
	yyparse();
	printf("x=%d,y=%d",x,y);
}
yyerror(char *s){
	printf("%s\n",s);
}
