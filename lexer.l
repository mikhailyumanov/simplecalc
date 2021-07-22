%{

#include "parser.h"

%}

number [0-9]+
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

{number} { yylval.inum = strtol(yytext, NULL, 10); return number; }

.        { printf("Error with '%s'", yytext); }

<<EOF>>  { return END; }

%%
