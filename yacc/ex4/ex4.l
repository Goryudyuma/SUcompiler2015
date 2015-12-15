DIGIT [0-9]
OP [+\-*/]
SYM [().]
%%
{DIGIT}+	{yylval = atoi(yytext);return NUM;}
{OP}		{return yytext[0];}
{SYM}		{return yytext[0];}
[ \t\n\r]	;
.			{return NUL;}
