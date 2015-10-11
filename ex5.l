DIGIT	[0-9]
ALPHA	[a-zA-Z]
SYM	[+*/\-]
%%
"begin"	|
"if"	|
{SYM}	{printf("%s\n",yytext);}
{DIGIT}	{printf("number\n");}
{ALPHA}{ALPHA}*	{printf("ident\n");}
[ \t\n\r]	;
.	{printf("null\n");}
