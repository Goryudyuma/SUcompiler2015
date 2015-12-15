%{
#include <stdio.h>
%}
%token NUM NUL
%right '+' '-'
%right '*' '/'
%%
prog : prog expr '.' {printf("ans=%d\n", $2);}
	| expr '.' {printf("ans=%d\n", $1);}
	;
expr : expr '+' expr {$$ = $1 + $3;}
	 | expr '-' expr {$$ = $1 - $2;}
	| expr '*' expr {$$ = $1 * $3;}
	| expr '/' expr {$$ = $1 / $3;}
	| '(' expr ')' {$$ = $2;}
	| NUM {$$ = $1;}
	;
%%
#include "lex.yy.c"
main() {
	yyparse();
}
yyerror(char *s) {
	printf("ERROR=%s\n", s);
}
