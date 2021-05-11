/* Khaldoun Chtourou 2ème informatique groupe D */

%{

int total = 0 ;

%}

%option noyywrap

%%

("#include ").* {total++; fprintf(yyout,"This is the import pre-processor directive: %s\n\n",yytext);}

#.* {total++; fprintf(yyout,"This is another pre-processor directive: %s\n\n",yytext);}

[''|,|;(|)|{|}|.|_] {total++; fprintf(yyout,"This is a delimiter: %s\n\n",yytext);}

[[]] {total++; fprintf(yyout,"This is a delimiter: %s\n\n",yytext);}

"#"|"@"|"$"|"^"|"%"|"&" {total++; fprintf(yyout,"This is special characters: %s\n\n",yytext);}

"["|"]" {total++; fprintf(yyout,"This is a delimiter: %s\n\n",yytext);}

"=="  {total++; fprintf(yyout,"This is equals relational operator: %s\n\n",yytext);}

"="  {total++; fprintf(yyout,"This is assignment operator: %s\n\n",yytext);}

"<>"|"!=" {total++; fprintf(yyout, "This is the different relational operator: %s\n\n",yytext);}

"<="  {total++; fprintf(yyout,"This is inf or eq relational operator: %s\n\n",yytext);}

">="  {total++; fprintf(yyout,"This is sup or eq relational operator: %s\n\n",yytext);}

"<"  {total++; fprintf(yyout,"This is inf relational operator: %s\n\n",yytext);}

">"  {total++; fprintf(yyout,"This is sup relational operator: %s\n\n",yytext);}

"++"  {total++; fprintf(yyout,"This is increment operator: %s\n\n",yytext);}

"--"  {total++; fprintf(yyout,"This is decrement operator: %s\n\n",yytext);}

"+"|"-"|"*"|"/"  {total++; fprintf(yyout,"This is an arithmatic operator: %s\n\n",yytext);}

"and"|"or"|"not"|"nand"|"xor"|"nor"|"xnor"  {total++; fprintf(yyout,"This is a logical operators: %s\n\n",yytext);}

("int") {total++; fprintf(yyout,"This is declation of an integer variable: %s\n\n",yytext);}

("float") {total++; fprintf(yyout,"This is declation of a real variable: %s\n\n",yytext);}

("if")|if(" ")*?\( {total++; fprintf(yyout,"This is the condition structure: if\n\n");}

("else") {total++; fprintf(yyout,"This is the condition structure: else\n\n");}

("while")|("do")|("break")|("continue")|("double")|("float")|("return")|("EOF") {total++; fprintf(yyout,"This is another keyword: %s\n\n",yytext);}

("return")|("char")|("case")|("sizeof")|("long")|("short")|("typedef")|("switch")|("unsigned")|("void")|("static")|("struct")|("goto") {total++;fprintf(yyout,"This is a keyword: %s\n\n",yytext);}

"main"*\( {total++; fprintf(yyout,"This is the main function: %s\n\n",yytext);}

[a-zA-Z_][a-zA-Z0-9_]*\( {total++; fprintf(yyout,"This is a function: %s\n\n",yytext);}

[a-zA-Z_][a-zA-Z0-9_]* {total++; fprintf(yyout,"This is an identifier: %s\n\n",yytext);}

[0-9]*"."[0-9]+ {total++;fprintf(yyout,"This is a fraction : %s\n\n", yytext);} 

[-][0-9]*"."[0-9]+ {total++;fprintf(yyout,"This is a negative fraction : %s\n\n", yytext);} 

[0-9]+ {total++; fprintf(yyout,"This is an integer: %s\n\n",yytext);}

"-"[0-9]+ {total++; fprintf(yyout,"This is a negative integer: %s\n\n",yytext);}

["]([^"\\\n]|\\.|\\\n)*["] {total++; fprintf(yyout,"this is a string:%s\n\n",yytext);}

"//".*" "*    {total++;fprintf(yyout,"this is single a line commment: %s\n\n",yytext);}

\/\*(.*\n)*.*\*\/    {total++;fprintf(yyout,"this is a multi line comments: %s\n\n",yytext);}


. {fprintf(yyout,"",yytext);}

[\t\n]+

%%

int main()
{
    extern FILE *yyin, *yyout; 
    yyin = fopen("input.c", "r"); 
    yyout = fopen("output.txt", "w"); 
    yylex();
	fprintf(yyout,"\n\n\nTotal Tokens = %d",total);
    return 0; 
}