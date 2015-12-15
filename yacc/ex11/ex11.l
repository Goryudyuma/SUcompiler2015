%{
char *tname;
%}
DIGIT [0-9]
ALPHA [a-zA-Z]
OP [+\-*/]
SYM [().;]
%%
"begin" {return BBEGIN;}
"end" {return EEND;}
{DIGIT}+ {yylval.val = atoi(yytext);return NUM;}
{OP} {return yytext[0];}
{SYM} {return yytext[0];}
":=" {return BECOME;}
{ALPHA}({ALPHA}|{DIGIT})* {tname = (char *)malloc(strlen(yytext)+1); strcpy(tname,yytext); yylval.name = tname; return IDENT;}
[ \t\n\r] ;
. {return NUL;}
