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

%token <inum> inum "inum"
%token <dnum> dnum "dnum"
%nterm <inum> inumexpr
%nterm <dnum> dnumexpr

%%

%left "+" "-";
%left "/" "*";

exprlist:
  dnumexpr ";"
  { printf("result: %f", $1); }
| inumexpr ";"
  { printf("result: %d", $1); }
| exprlist dnumexpr ";"
  { printf("result: %f", $2); }
| exprlist inumexpr ";"
  { printf("result: %d", $2); }
;

dnumexpr:
  dnum
  { $$ = $dnum; }
| "(" dnumexpr ")"
  { $$ = $2; }

| dnumexpr[l] "+" dnumexpr[r]
  { $$ = $l + $r; }
| dnumexpr[l] "-" dnumexpr[r]
  { $$ = $l - $r; }
| dnumexpr[l] "*" dnumexpr[r]
  { $$ = $l * $r; }
| dnumexpr[l] "/" dnumexpr[r]
  { $$ = $l / $r; }

| dnumexpr[l] "+" inumexpr[r]
  { $$ = $l + $r; }
| dnumexpr[l] "-" inumexpr[r]
  { $$ = $l - $r; }
| dnumexpr[l] "*" inumexpr[r]
  { $$ = $l * $r; }
| dnumexpr[l] "/" inumexpr[r]
  { $$ = $l / $r; }

| inumexpr[l] "+" dnumexpr[r]
  { $$ = $l + $r; }
| inumexpr[l] "-" dnumexpr[r]
  { $$ = $l - $r; }
| inumexpr[l] "*" dnumexpr[r]
  { $$ = $l * $r; }
| inumexpr[l] "/" dnumexpr[r]
  { $$ = $l / $r; }
;

inumexpr:
  inum
  { $$ = $inum; }
| "(" inumexpr ")"
  { $$ = $2; }
| inumexpr[l] "+" inumexpr[r]
  { $$ = $l + $r; }
| inumexpr[l] "-" inumexpr[r]
  { $$ = $l - $r; }
| inumexpr[l] "*" inumexpr[r]
  { $$ = $l * $r; }
| inumexpr[l] "/" inumexpr[r]
  { $$ = $l / $r; }
;

%%

int main() {
  yyparse();
}

void yyerror (char* e) {
  printf("%s\n", e);
}
