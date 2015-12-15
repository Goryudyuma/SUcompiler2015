%{
#include <stdio.h>
int reg[58];
%}
%token NUM IDENT BECOME BBEGIN EEND NUL
%%
prog : prog BBEGIN statement EEND {printf("ans=%d\n",$3);}
	 | BBEGIN statement EEND {printf("ans=%d\n",$2);}
	 ;
statement : statement ';' IDENT BECOME expr {reg[$3] = $5; $$ = $5;}
		  | statement ';' expr {$$ = $3;}
		  | IDENT BECOME expr{reg[$1] = $3; $$ = $3;}
		  | expr {$$ = $1;}
		  ;
expr : expr '+' term {$$ = $1 + $3;}
	 | expr '-' term {$$ = $1 - $3;}
	 | term {$$ = $1;}
	 ;
term : term '*' factor {$$ = $1 * $3;}
	 | term '/' factor {$$ = $1 / $3;}
	 | factor {$$ = $1;}
	 ;
factor : '(' expr ')' {$$ = $2;}
	   | NUM {$$ = $1;}
	   | IDENT {$$ = reg[$1];}
	   ;
%%
#include "lex.yy.c"
main(){
	yyparse();
}
yyerror(char *s){
	printf("ERROR=%s\n",s);
}
