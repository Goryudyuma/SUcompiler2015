DIGIT [0-9]
ALPHA [a-zA-Z]
OP [+\-*/]
SYM [().;]
%%
"begin"	{return BBEGIN;}
"end"	{return EEND;}
{DIGIT}+	{yylval = atoi(yytext);return NUM;}
{OP}	{return yytext[0];}
{SYM}	{return yytext[0];}
":="	{return BECOME;}
{ALPHA}	{yylval = yytext[0] - 'A'; return IDENT;}
[ \t\n\r]	;
.	{return NUL;}
