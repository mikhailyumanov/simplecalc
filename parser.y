%{

#include "stdio.h"

%}

%code requires {

int yylex(void);
void yyerror (char* e);

}

%union {
  char   op;
  int    inum;
  double dnum;
}

%token
  <op> ADD "+"
  <op> SUB "-"
  <op> MUL "*"
  <op> DIV "/"
  <op> LBR "("
  <op> RBR ")"
  <op> SMC ";"

%token <inum> number "number"
%nterm <inum> expr

%%

%left "/" "*";
%left "+" "-";

exprlist:
  %empty
  {}
| exprlist expr ";"
  { printf("result: %d", $2); }
;

expr:
  number
  { $$ = $number; }
| "(" expr ")"
  { $$ = $2; }
| expr[l] "+" expr[r]
  { $$ = $l + $r; }
| expr[l] "-" expr[r]
  { $$ = $l - $r; }
| expr[l] "*" expr[r]
  { $$ = $l * $r; }
| expr[l] "/" expr[r]
  { $$ = $l / $r; }
;

%%

int main() {
  yyparse();
}

void yyerror (char* e) {
  fprintf(stderr, "%s\n", e);
}
