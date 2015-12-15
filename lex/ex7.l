%{
	int total;
%}
DIGIT	[0-9]
ALPHA	[a-zA-Z]
%%
{DIGIT}+	{fprintf(yyout,"number\n");total+=atoi(yytext);}
{ALPHA}+	{fprintf(yyout,"ident\n");}
.	{fprintf(yyout,"null\n");}
%%
main(int argc,char *argv[]){
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
	total=0;
	yylex();
	fprintf(yyout,"total=%d\n",total);
}
