%{

#include "parser.h"

%}

inum   [0-9]+
dnum   [0-9]+"."[0-9]*|[0-9]*"."[0-9]+
blank  [ \t\r]

%%

{blank}+ {}

"+"      { return ADD; }
"-"      { return SUB; }
"*"      { return MUL; }
"/"      { return DIV; }
"("      { return LBR; }
")"      { return RBR; }
";"      { return SMC; }

{inum}   { yylval.inum = strtol(yytext, NULL, 10); return inum; }
{dnum}   { yylval.dnum = strtod(yytext, NULL);     return dnum; }

.        { printf("Error with '%s'", yytext); }

<<EOF>>  { return END; }

%%
