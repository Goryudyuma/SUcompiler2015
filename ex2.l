%%
[0-9]+	{printf("number\n");}
[a-zA-Z][a-zA-Z]*	{printf("ident\n");}
%%

main(){
	while(yylex()!=0);
	printf("finish\n");
}
