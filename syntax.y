%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "Struct.c"
    extern FILE *yyin;
    extern FILE *yyout;
    extern int yylineno;
    extern char *yytext;
    extern int yylex();
    extern void yyerror(const char *s);
    int currentColumnNum = 1;
    Line *Table_sym;  

%}

%union {
    int val_int;
    double val_float;
    char val_str[255];
}


%token  PROG
%token  L_FOR L_WHILE
%token  INPUT OUTPUT
%token  IF ELSE
%token  DOT
%token <val_str> COMMA
%token  <val_str> SEMICOLON
%token  OPENINGPARENTHESIS CLOSINGPARENTHESIS OPENINGBRACE CLOSINGBRACE OPENINGBRACKET CLOSINGBRACKET
%token  EQUAL NONEQUAL AND OR NON INFERIOR SUPERIOR INFERIOREQUAL SUPERIOREQUAL
%token  ADD SUB MULT DIV MOD POWER
%token  ASSIGN
%token  <val_str> BOOL
%token  <val_int> INTEGER
%token  <val_float> FLOAT
%token  <val_str> INTDEC 
%token  <val_str> STRDEC 
%token  <val_str> BOOLDEC 
%token  <val_str> FLTDEC 
%token  <val_str> S
%token  INLINECOMMENT
%token  NEWLINE
%token  <val_str> STR
%token  <val_str> ID



%left OPENINGPARENTHESIS CLOSINGPARENTHESIS OPENINGBRACKET CLOSINGBRACKET DOT ;
%left NON;
%right POWER;
%left MULT DIV MOD;
%left ADD SUB;
%left INFERIOR INFERIOREQUAL SUPERIOR SUPERIOREQUAL;
%left EQUAL NONEQUAL;
%left AND;
%left OR;
%right ASSIGN;
%left COMMA;
%start Axiom;

%%
/*  The grammar */
Axiom: | PROG ID OPENINGBRACE code CLOSINGBRACE ;
code: code code | affectation | commentaire | tabledeclaration | structdeclaration   | declaration | statements  | expression  | read | write  ;

declaration: type ID SEMICOLON ;
type: INTDEC  | FLTDEC | STRDEC  | BOOLDEC | structure ;

structdeclaration: STRDEC structure OPENINGBRACE declarations CLOSINGBRACE ;
declarations : declaration | declaration declarations;
structure: ID ;

tabledeclaration: type OPENINGBRACKET tablesize CLOSINGBRACKET ID SEMICOLON;
tablesize: ID | expressionAR | INTEGER;

statements : if_stmt | if_else_stmt | for_stmt | while_stmt ;

if_stmt: B1 OPENINGBRACE code CLOSINGBRACE;
B1:IF OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

if_else_stmt: A1 ELSE OPENINGBRACE code CLOSINGBRACE ;
A1: A2 OPENINGBRACE code CLOSINGBRACE ;
A2: IF OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

for_stmt: R1 OPENINGBRACE code CLOSINGBRACE;
R1:R2 SEMICOLON INTEGER;
R2:R3 SEMICOLON expressionLG;
R3:L_FOR ID ASSIGN expressionAR;

while_stmt: C1 OPENINGBRACE code CLOSINGBRACE;
C1:L_WHILE OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

expression : expressionAR | expressionLG;

read: INPUT OPENINGPARENTHESIS ID CLOSINGPARENTHESIS SEMICOLON;
write: OUTPUT OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS SEMICOLON;

commentaire: INLINECOMMENT ;

expressionAR :OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS | expressionAR ADD expressionAR | expressionAR SUB expressionAR| SUB expressionAR| expressionAR MULT expressionAR| expressionAR DIV expressionAR | expressionAR MOD expressionAR | expressionAR POWER expressionAR | item;

item: ID   | INTEGER ;
tableelement : ID OPENINGBRACKET tablesize CLOSINGBRACKET;
champenreg: ID DOT ID ;

expressionLG: OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS 
 | expressionLG AND expressionLG
 | expressionLG OR expressionLG 
 | NON expressionLG 
 | element ;
 
element : ID | BOOL | tableelement | champenreg | expressionAR EQUAL expressionAR | expressionAR NONEQUAL expressionAR | expressionAR INFERIOR expressionAR| expressionAR INFERIOREQUAL expressionAR| expressionAR SUPERIOR expressionAR| expressionAR SUPERIOREQUAL expressionAR;

affectation : ID ASSIGN expressionAR SEMICOLON| type ID ASSIGN expressionAR SEMICOLON;

%%



int main(int argc, char **argv) {
    //Table_sym = insertLine(&Table_sym ,1);
    yyin = fopen(argv[1], "r");
    int value = yyparse();
    if(value==1){
        printf("\nErreur syntaxique dans la ligne :%d  et la colonne : %d\n",yylineno,currentColumnNum);
    }else{
        printf("Compilation reussie!\n");
    }
    fclose(yyin);
    return 0;
}





