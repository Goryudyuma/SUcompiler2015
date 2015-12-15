/* 任意の長さ変数に対応 */
%union {
	char *name;
	int val;
}
%{
#include <stdio.h>
struct vnode {
	char *name; /* 変数名を格納 */
	int val; /* 値を格納 */
	struct vnode *next; /* 次の変数に対するvnodeのアドレス */
};
struct vnode *top, *tail; /* vnodeリストの最初と最後を示す */
extern int getval();
extern void putval();
%}
%token <val> NUM
%token <name> IDENT
%token BECOME BBEGIN EEND NUL
%type <val> statement expr term factor
%%
prog : prog BBEGIN statement EEND {printf("ans=%d\n",$3);}
	 | BBEGIN statement EEND {printf("ans=%d\n", $2);}
;
statement: statement ';' IDENT BECOME expr {putval($3,$5); $$ = $5;}
	| IDENT BECOME expr {putval($1,$3); $$ = $3;}
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
	| IDENT {$$ =getval($1);}
;
%%

#include "lex.yy.c"
main() {
	top = (struct vnode*)malloc(sizeof(struct vnode));
	tail = top;
	top->next = NULL;
	yyparse();
}
yyerror(char *s) {
	printf("ERROR=%s\n", s);
}
int getval(char *vname)
{
	//vnodeリストから変数vnameを探し，対応する値を返す。もしなければ0を返す
	struct vnode *now = top;
	while(now->next != NULL){
		if(!strcmp(now->name, vname)){
			return now->val;
		}
		now=now->next;
	}
	return 0;
}
void putval(char *vname, int vval)
{
	//vnodeリストからvnameを探し，対応する個所にvvalを格納する。もしvnameが見つからなければ，新たにvnodeを作成し，そこにvname, vvalを格納する。新たに作成したvnodeはリストの最後につける。
	struct vnode *now = top;
	while(now->next != NULL){
		if(strcmp(now->name, vname) == 0){
			now->val = vval;
			return;
		}
		now=now->next;
	}
	struct vnode *push = (struct vnode*)malloc(sizeof(struct vnode));
	push->next=NULL;
	tail->name=vname;
	tail->val=vval;
	tail->next=push;
	tail=push;
	return;
}
