%{
	int total;
	int compcount;
%}
DIGIT	[0-9]
ALPHA	[a-zA-Z]
%%
{DIGIT}+	{printf("number\n");total+=atoi(yytext);}
{ALPHA}+	{printf("ident\n");if(strcmp(yytext,"comp")==0)compcount++;}
.	{printf("null\n");}
%%
main(){
	total=0;
	compcount=0;
	yylex();
	printf("total=%d\n",total);
	printf("compcount=%d\n",compcount);
}
