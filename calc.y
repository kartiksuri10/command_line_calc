%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define MAX_VARS 100

typedef struct {
    char name[50];
    double value;
} Variable;

Variable vars[MAX_VARS];
int var_count = 0;

double get_var_value(char *name);
void set_var_value(char *name, double value);

int yylex();
void yyerror(const char *s);
%}

%union {
    double fval;
    char *sval;
}

%token <fval> NUMBER
%token <sval> ID
%token ASSIGN PLUS MINUS MULT DIV POW LPAREN RPAREN EOL
%token SIN COS TAN LOG LN SEC COSEC COT

%type <fval> expr
%type <sval> line

%left PLUS MINUS
%left MULT DIV
%right POW
%nonassoc SIN COS TAN LOG LN SEC COSEC COT

%%

input:
    | input line
    ;

line:
    expr EOL  { printf("Result: %lf\n", $1); }
    | ID ASSIGN expr EOL { set_var_value($1, $3); }
    ;

expr:
    NUMBER  { $$ = $1; }
    | ID { $$ = get_var_value($1); }
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr MULT expr { $$ = $1 * $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | expr POW expr { $$ = pow($1, $3); }
    | SIN expr { $$ = sin($2); }
    | COS expr { $$ = cos($2); }
    | TAN expr { $$ = tan($2); }
    | LOG expr { $$ = log10($2); }
    | LN expr  { $$ = log($2); }
    | SEC expr { $$ = 1 / cos($2); }
    | COSEC expr { $$ = 1 / sin($2); }
    | COT expr { $$ = 1 / tan($2); }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

int main() {
    printf("Extended Calculator (Type expressions and press Enter)\n");
    printf("Type 'exit' to quit.\n");
    yyparse();
    return 0;
}

double get_var_value(char *name) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i].name, name) == 0)
            return vars[i].value;
    }
    printf("Error: Undefined variable %s\n", name);
    return 0;
}

void set_var_value(char *name, double value) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i].name, name) == 0) {
            vars[i].value = value;
            return;
        }
    }
    strcpy(vars[var_count].name, name);
    vars[var_count].value = value;
    var_count++;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
