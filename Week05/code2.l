/* 2. If the lexime start with a letter followed by letter/digit klein clousre, display it as an identifier. If the lexime is an id, then insert it into the symbol table if it is not existing in the symbol table. If the lexime is an integer display it and an integer, if the lexime is an floating point display it as floating point. In the above process discard the single line comments (//...) and multiline comments (/* ... */) */
digit [0-9]*
id [a-zA-Z][a-zA-Z0-9]*
num [0-9]*.[0-9]*
%{
	#include <stdio.h>
	#include <string.h>

	int cnt = 0, i = 0, j = 0;
	char st[10][10];

	int lookup(char st[10][10], char *id, int n);
%}

%%
int|float|char|double|void|main		{ printf("n %s is Keyword", yytext); }
{num}					          { printf("n %s is float", yytext); }
{id}					               {
						               printf("n %s is identifier", yytext);
						               cnt++;
						               if (!lookup(st, yytext, i))
                                                  strcpy(st[i++], yytext);
					               }
{digit}					          { printf("n %s is integer", yytext); }
@					               yyterminate();
%%

int main()
{
	yylex();
	printf(" No of id are : %d ", cnt);
	printf("n the contents of the symbol table are :n");
	for (j = 0; j < i; j++)
		printf("n %s", st[j]);
	getchar();
}

int yywrap()
{
	return 1;
}

int lookup(char st[10][10], char *id, int n)
{
	for (j = 0; j < n; j++)
	{
		if (!strcmp(st[j], id))
		{
			return 1;
		}
	}

	return 0;
}