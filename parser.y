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

%token END 0 "end of file"

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
  expr ";"
  { printf("result: %d", $1); }
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
  printf("%s\n", e);
}
