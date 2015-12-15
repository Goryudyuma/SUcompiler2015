delim [ \t\n\r]
%%
CAT	{return CAT;}
DOG	{return DOG;}
SLEEPS	{return SLEEPS;}
RUNS	{return RUNS;}
{delim}	;
.	{return NUL;}
