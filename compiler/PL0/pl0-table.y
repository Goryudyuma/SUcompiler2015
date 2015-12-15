/*
  $B9=J82r@O!\5-9fI=(B
*/

%union {
  char *name;
  int   val;
}

%{
#include <stdio.h>

#define MAXTABLE 1000 // $B5-9fI=$X$NEPO?2DG=:GBg?t(B
#define MAXLEVEL 10   // $B@EE*%l%Y%k$N:GBgCM(B

#define constant  1  
#define variable  2
#define procedure 3

struct record { 
  char name[10];  // $B<1JL;R$NL>A0(B
  int kind;       // $B<1JL;R$N<oN`(B
  int val;        // $B<1JL;R$,Dj?t$N>l9g$NCM(B
  int level;      // $B<1JL;R$N%l%Y%k(B
  int addr;       // $BJQ?t!"<jB3$-$K3d$jEv$F$i$l$?HVCO(B
} *table[MAXTABLE];

struct env { 
  int dx;    // $BJQ?t$K3d$jEv$F$k%a%b%j$NHVCO(B
  int lev;   // $B%V%m%C%/$N@EE*%l%Y%k(B
  int base;  // $BEv3:%V%m%C%/$KBP$9$k5-9fI=$N%Y!<%9%$%s%G%C%/%9(B
  int top;   // $BEv3:%V%m%C%/$KBP$9$k5-9fI=$N%H%C%W%$%s%G%C%/%9(B
} *envptr[MAXLEVEL];


static int level; // $B%V%m%C%/$N@EE*%l%Y%k(B
static int codeIndex = 0; // $BL?Na%3!<%I$NHVCO(B

void enter();
void setinitialenv();
void setnewenv();
void outofblock();

%}

%token <val> NUM 
%token <name> IDENT 
%token CONST VAR PROCEDURE 
%token CALL IF THEN ELSE WHILE DO ODD BECOME BBEGIN EEND WRITE
%token EQ NEQ GT LT GEQ LEQ
%token NUL

%%
program  : {setinitialenv();} 
            block '.' 
;

block :  constpart varpart procpart statement 
           {outofblock();}
;

constpart : CONST constdecl ';'
          | 
;

constdecl : constdecl ',' IDENT EQ NUM {enter(constant,$3,$5);}
          | IDENT EQ NUM {enter(constant,$1,$3);}
;

varpart : VAR vardecl ';' 
        | 
;

vardecl : vardecl ',' IDENT {enter(variable,$3,0);}
        | IDENT {enter(variable,$1,0);}
;

procpart : procpart procdecl 
         | 
;

procdecl : PROCEDURE IDENT ';' {enter(procedure,$2,codeIndex); setnewenv();} 
           block ';'
;

statement : IDENT BECOME expr 
          | CALL IDENT         
          | BBEGIN statementlist EEND 
          | IF condition THEN statement elsepart 
          | WHILE condition DO statement
          | WRITE '(' exprlist ')'
          | 
;

elsepart : ELSE
           statement
         |
;

statementlist : statementlist ';' statement 
              | statement
              | error ';' statement   {yyerror("statement error\n");}
;

exprlist : exprlist ',' expr
         | expr
;

condition : ODD expr 
          | expr rop expr
;

rop : EQ   
    | NEQ  
    | GT   
    | GEQ  
    | LT   
    | LEQ  
;

expr : '+' term
     | '-' term
     | expr '+' term 
     | expr '-' term 
     | term               
;

term : term '*' factor
     | term '/' factor
     | factor 
;

factor : '(' expr ')'  
       |  NUM         
       |  IDENT  
;
%%

#include "lex.yy.c"

main(int argc, char *argv[]) 
{
  if (argc >= 2) {
    yyin = fopen(argv[1],"r");
    if (argc == 3) {yyout = fopen(argv[2],"w");}
    if (argc > 3) {printf("too many arg\n"); exit(1);}
  }

  level = 0;
  yyparse();

}

yyerror(char *s) {
  printf("ERROR=%s\n", s);
}

