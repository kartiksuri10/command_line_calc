%{
#include "calc.tab.h"  
#include <math.h>
%}

/* Define Tokens */
DIGIT       [0-9]+(\.[0-9]+)?
ID          [a-zA-Z_][a-zA-Z0-9_]*
WHITESPACE  [ \t]+

%%

{DIGIT}     { yylval.fval = atof(yytext); return NUMBER; }
"="         { return ASSIGN; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }
"^"         { return POW; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"sin"       { return SIN; }
"cos"       { return COS; }
"tan"       { return TAN; }
{ID}        { yylval.sval = strdup(yytext); return ID; }
\n          { return EOL; }
{WHITESPACE} { /* Ignore whitespace */ }

%%

int yywrap() { return 1; }
