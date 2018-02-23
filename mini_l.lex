%{
#include<unistd.h>
int lineNumber = 1, current = 0;
%}
COMMENT [##].*
DIGIT [0-9]
INVALID1 [0-9_][a-zA-Z0-9_]+
INVALID2 [a-zA-Z0-9]*[_]+
ID [a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]*

%%
{COMMENT}	;
function	{current += yyleng; return FUNCTION;}
beginparams	{current += yyleng; return BEGIN_PARAMS;}
endparams	{current += yyleng; return END_PARAMS;}
beginlocals	{current += yyleng; return BEGIN_LOCALS;}
endlocals	{current += yyleng; return END_LOCALS;}
beginbody	{current += yyleng; return BEGIN_BODY;}
endbody		{current += yyleng; return END_BODY;}
integer		{current += yyleng; return INTEGER;}
array		{current += yyleng; return ARRAY;}
of		{current += yyleng; return OF;}
if		{current += yyleng; return IF;}
then		{current += yyleng; return THEN;}
endif		{current += yyleng; return ENDIF;}
else		{current += yyleng; return ELSE;}
while		{current += yyleng; return WHILE;}
do		{current += yyleng; return FUNCTION;}
foreach		{current += yyleng; return FOREACH;}
in	{current += yyleng; return IN;}
beginloop	{current += yyleng; return BEGINLOOP;}
endloop		{current += yyleng; return ENDLOOP;}
continue	{current += yyleng; return CONTINUE;}
read		{current += yyleng; return READ;}
write		{current += yyleng; return WRITE;}
and		{current += yyleng; return AND;}
or	 {current += yyleng; return OR;}
not		{current += yyleng; return NOT;}
true	{current += yyleng; return TRUE;}
false		{current += yyleng; return FALSE;}
return	{current += yyleng; return RETURN;}
"-"		{current += yyleng; return SUB;}
"+"		{current += yyleng; return ADD;}
"*" 		{current += yyleng; return MULT;}
"/"		 {current += yyleng; return DIV;}
"%"		 {current += yyleng; return MOD;}
"=="		{current += yyleng; return EQ;}
"<>"		{current += yyleng; return NEQ;}
"<" 		{current += yyleng; return LT;}
">"		{current += yyleng; return GT;}
"<="		{current += yyleng; return LTE;}
">="		{current += yyleng; return GTE;}

";"		{current += yyleng; return SEMICOLON;}
":"		{current += yyleng; return COLON;}
","		{current += yyleng; return COMMA;}
"("		{current += yyleng; return L_PAREN;}
")"		{current += yyleng; return R_PAREN;}
"["		{current += yyleng; return L_SQUARE_BRACKET;}
"]"		{current += yyleng; return R_SQUARE_BRACKET;}
":="	{current += yyleng; return ASSIGN;}

{DIGIT}+ 	{current += yyleng; yylval.val=atoi(yytext); return NUMBER;}
{INVALID1}		{current += yyleng; printf("invalid ID: identifiers can not start with a number or underscore %s line:%d position:%d\n", yytext, lineNumber, current); exit(0);}
{INVALID2}	{current += yyleng; printf("invalid ID: identifiers can not end with number or underscore %s line:%d position:%d\n",yytext, lineNumber, current); exit(0);}
{ID}		{current += yyleng; yylval.op_val=new std::string(yytext); return IDENT;}

[ \t]+	{currPos += yyleng;}
[\n]		{++lineNumber; current = 1;}

.		{printf("unrecognized symbol %s line: %d position %d\n:", yytext, lineNumber, current); exit(0);}

%%


int main(int argc, char** argv) {
	++argv, --argc;
	if(argc > 0 )
		yyin = fopen(argv[0],"r");
	else
		yyin = stdin;
	yylex();
}
