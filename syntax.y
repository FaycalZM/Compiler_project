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
    
    int i =25;
    int ri=1;
    typedef struct quad{
        char op[20];
        char opr1[20];
        char opr2[20];
        char res[20];
    }quad;
    int sauv_if_fin = 0;
    int sauv_else =0;
    int sauv_else_fin=0;
    int  sauv_for_test=0;
    int sauv_for_init_id=0;
    quad tab_quad[1000];
    int taille;
    char pas[20];

%}

%union {
    int val_int;
    double val_float;
    char val_str[255];
    char val_char;
}


%token  PROG
%token  L_FOR L_WHILE
%token  INPUT OUTPUT
%token  IF ELSE
%token  DOT
%token <val_char> COMMA
%token  <val_char> SEMICOLON
%token  OPENINGPARENTHESIS CLOSINGPARENTHESIS OPENINGBRACE CLOSINGBRACE OPENINGBRACKET CLOSINGBRACKET
%token  EQUAL NONEQUAL AND OR NON INFERIOR SUPERIOR INFERIOREQUAL SUPERIOREQUAL
%token  ADD SUB MULT DIV MOD POWER
%token  ASSIGN
%token  <val_str> BOOL
%token  <val_int> INTEGER
%token  <val_float> FLOAT
%token  <val_char> CHAR
%token  <val_str> INTDEC 
%token  <val_str> STRDEC 
%token  <val_str> BOOLDEC 
%token  <val_str> FLTDEC 
%token  <val_str> CHRDEC
%token  <val_str> STRUCTDEC
%token  INLINECOMMENT
%token  BLOCCOMMENT
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
code: code code | affectation | commentaire | tabledeclaration | structdeclaration   | declaration | statements  | expression  | read | write | ;

declaration: type ID SEMICOLON ;
type: INTDEC  | FLTDEC | STRDEC  | BOOLDEC | CHRDEC | structure ;

structdeclaration: STRUCTDEC structure OPENINGBRACE declarations CLOSINGBRACE ;
declarations : declaration | declaration declarations;
structure: ID ;

tableelement : ID OPENINGBRACKET item CLOSINGBRACKET;


tabledeclaration: type OPENINGBRACKET tablesize CLOSINGBRACKET ID SEMICOLON;
tablesize: ID | expressionAR | INTEGER;

statements : if_stmt | if_else_stmt | for_stmt | while_stmt ;

if_stmt: B1 OPENINGBRACE code CLOSINGBRACE;
B1:IF OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

if_else_stmt: A1 ELSE OPENINGBRACE code CLOSINGBRACE | A1 ELSE B1 OPENINGBRACE code CLOSINGBRACE;
A1: B1 OPENINGBRACE code CLOSINGBRACE  ;


for_stmt: R1 OPENINGBRACE code CLOSINGBRACE;
R1:R2 SEMICOLON INTEGER CLOSINGPARENTHESIS;
R2:R3 SEMICOLON expressionLG;
R3:L_FOR OPENINGPARENTHESIS ID ASSIGN expressionAR;

while_stmt: C1 OPENINGBRACE code CLOSINGBRACE;
C1:L_WHILE OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

expression : expressionAR | expressionLG;

read: INPUT OPENINGPARENTHESIS ID CLOSINGPARENTHESIS SEMICOLON;
write: OUTPUT OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS SEMICOLON;

commentaire: INLINECOMMENT | BLOCCOMMENT ;

expressionAR :OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS | expressionAR ADD expressionAR | expressionAR SUB expressionAR| SUB expressionAR| expressionAR MULT expressionAR| expressionAR DIV expressionAR | expressionAR MOD expressionAR | expressionAR POWER expressionAR | item;

item: ID | INTEGER | tableelement ;

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





