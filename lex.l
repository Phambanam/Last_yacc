%{
#include "y.tab.h"
%}

%%
-?[0-9]+(\.[0-9]+)?        	   { yylval.fval = atoi(yytext);return  NUM; }
"("                                    {return LPAREN;}
")"                                    {return RPAREN;}
\,		                               { return COMMA ; }
[ \n\t\v\f]                       ;
"start\n" { return ST; }
(.|\n)      { return yytext[0]; }
%%
 
#ifndef yywrap
int yywrap () { return 1; }
#endif
