%{

#include "stdio.h"

%}

number [0-9]+
blank  [ \t\r]

%%

{blank}+ {}

"+"      { return 1; }
"-"      { return 2; }
"*"      { return 3; }
"/"      { return 4; }
"("      { return 5; }
")"      { return 6; }

{number} { return strtol(yytext, NULL, 10); 
         }

.        { printf("Error with '%s'", yytext); }

%%

int main() {
  int tok;
  while (tok = yylex()) {
    printf("%d ", tok);
  }
}
