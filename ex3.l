DIGIT	[0-9]
ALPHA	[a-zA-Z]
SYM	[+*/\-]
%%
("begin"|"if"|{SYM})	{printf("%s\n",yytext);}
{DIGIT}+	{printf("number %s\n",yytext);}
{ALPHA}({ALPHA}|{DIGIT})*	{printf("ident %s\n",yytext);}
.	{printf("null\n");}
