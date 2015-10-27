/*
   学籍番号:13T5074D
   名前:松本圭威


 */
%{
	int count[8];
	float floatsum;
	int integersum;
%}
sisuubu		[eE]{sisuuinshi}	
sisuuinshi	[+-]?{kazu}
kazu		{suuzi}{suuzi}*
suuzi		[0-9]
eizi		[a-zA-Z]
%%

	/*
	   \/\*(!\*|\*\**(!(\*\/)))*(\*)*\*\/	{printf("!");}
	 */
\/\*([^\*]|\*\**[^\*\/])*(\*)*\*\/	|
[ \n\t]								{}	
"begin"								|
"call"								|
"const"								|
"do"								|
"else"								|
"end"								|
"if"								|
"odd"								|
"procedure"							|
"then"								|
"var"								|
"while"								{count[0]++;}
{kazu}"."{kazu}{sisuubu}?			{count[7]++;fprintf(yyout,"float(%f)\n",atof(yytext));floatsum+=atof(yytext);}
{kazu}								{count[6]++;fprintf(yyout,"integer(%d)\n",atoi(yytext));integersum+=atoi(yytext);}
[\+\-\*\/]							{count[1]++;}
[.,;()]								{count[2]++;}
[<>]=?								|
!?=									{count[3]++;}
":="								{count[4]++;}
{eizi}({eizi}|{suuzi})*				{count[5]++;}
.									{}
%%
main(int argc, char *argv[]){
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
	
	floatsum=0.0;
	integersum=0;

	int i;
	for(i=0;i<8;i++){
		count[i]=0;
	}

	yylex();

	fprintf(yyout,"予約語=%d\n",		count[0]);
	fprintf(yyout,"算術演算子=%d\n",	count[1]);
	fprintf(yyout,"記号=%d\n",			count[2]);
	fprintf(yyout,"関係演算子=%d\n",	count[3]);
	fprintf(yyout,"代入記号=%d\n",		count[4]);
	fprintf(yyout,"識別子=%d\n",		count[5]);
	fprintf(yyout,"整数定数=%d\n",		count[6]);
	fprintf(yyout,"実数定数=%d\n",		count[7]);

	fprintf(yyout,"\n");

	fprintf(yyout,"整数定数合計=%d\n",integersum);
	fprintf(yyout,"実数定数合計=%f\n",floatsum);

	return 0;
}
