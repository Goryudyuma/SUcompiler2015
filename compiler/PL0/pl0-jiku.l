%{
/* これはPL0のLexソースファイルです。*/

char *tname;

%}

DIGIT [0-9]
ALPHA [a-zA-Z]
DELIM [ \t\n]
SYMBOL [.;,()]
OP   [+*/\-]

%%
"begin"  {return BBEGIN;}
"call"   {return CALL;}
"const"  {return CONST;}
"end"    {return EEND;}
"if"     {return IF;}
"odd"    {return ODD;}
"procedure"  {return PROCEDURE;}
"then"       {return THEN;}
"else"       {return ELSE;}
"var"        {return VAR;}
"while"     {return WHILE;}
"do"        {return DO;}
"write"     {return WRITE;}
">"         {return GT;;}
"<"         {return LT;}
">="        {return GEQ;}
"<="        {return LEQ;}
"!="        {return NEQ;}
"="         {return EQ;}
":="        {return BECOME;}
{SYMBOL}    {return yytext[0];}
{OP}        {return yytext[0];}
{DIGIT}+    {yylval.val = atoi(yytext); return NUM;}
{ALPHA}({ALPHA}|{DIGIT})*   {tname = (char *)malloc(strlen(yytext)+1);
                             strcpy(tname,yytext); yylval.name = tname;
                             return IDENT;}
{DELIM}+  ;
.                  {return NUL;}

