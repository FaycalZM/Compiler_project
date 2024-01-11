
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "syntax.tab.h"
   

    extern int currentColumnNum;
    int currentLineNum = 1; 	    
    int showsuccess = 1;
    
    void yysuccess(const char *s, const char *token, int length);
    void yyerror(const char *s);
    void showLexicalError();
    void printSymbolTable();
%}

/*Used to get the current line INTEGER*/
%option yylineno
%option noyywrap 
/* the lexical analyzer will be in this file */  
%option outfile = "scanner.c"    


/*Reserved keywords*/
PROG "MAIN_PROG"
L_FOR iterate
L_WHILE considering
INPUT input
OUTPUT output
IF check
ELSE else

/*Identifiers*/


ID [a-zA-Z_][a-zA-Z0-9_]*

TEXTVALUE .*
DOT \.
NEWLINE "\n"|"\r"
SEMICOLON ;
COMMA \,

OPENINGBRACE \{
CLOSINGBRACE \}
OPENINGBRACKET \[
CLOSINGBRACKET \]
OPENINGPARENTHESIS \(
CLOSINGPARENTHESIS \)


/*Logical and arithmetic operators*/
EQUAL ===
NONEQUAL !==
AND AND
OR OR
NON NOT
INFERIOR \<
SUPERIOR \>
INFERIOREQUAL \<\=
SUPERIOREQUAL \>\=
ADD \+
SUB -
MULT \*
DIV div
MOD \%
POWER \*\*
INCREMENT \+\+
DECREMENT --


/*Elementary instructions*/
ASSIGN =

/*Constant strings and numbers*/
NUMBER ([1-9][0-9]*|"0")
INTEGER -?{NUMBER}
FLOAT -?{NUMBER}"\."[0-9]+
STR (\"{TEXTVALUE}\")|(\'{TEXTVALUE}\') 
BOOL Vrai|Faux
SPACE " "
TABULATION \t

/*Declarations*/
INTDEC int
STRDEC str
BOOLDEC bln
FLTDEC flt
STRUCTDEC structure

/*Comments*/
INLINECOMMENT #{TEXTVALUE}
BLOCCOMMENT \/\*{TEXTVALUE}\*\/

%%

{PROG} {
    
    
    yysuccess("main_program", yytext, yyleng);
    currentColumnNum +=yyleng;    
}

{L_FOR} {
    
    
    yysuccess("for", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}
{L_WHILE} {
    
    
    yysuccess("while", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INPUT} {
    
    
    yysuccess("input", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OUTPUT} {
    
    
    yysuccess("output", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{IF} {
    
    
    yysuccess("check", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{ELSE} {
    
    
    yysuccess("else", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}



{DOT} {
    
    
    yysuccess("dot", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{COMMA} {
    
    
    yysuccess("comma", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{SEMICOLON} {
    
    
    yysuccess("semicolon", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{OPENINGPARENTHESIS} {
    
    
    yysuccess("opening_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGPARENTHESIS} {
    
    
    yysuccess("closing_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OPENINGBRACE} {
    
    
    yysuccess("opening_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGBRACE} {
    
    
    yysuccess("closing_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OPENINGBRACKET} {
    
    
    yysuccess("opening_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGBRACKET} {
    
    
    yysuccess("closing_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}
			
{EQUAL} {
    
    
    yysuccess("equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{NONEQUAL} {
    
    
    yysuccess("non_equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{AND} {
    
    
    yysuccess("AND", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OR} {
    
    
    yysuccess("OR", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{NON} {
    
    
    yysuccess("NON", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INFERIOR} {
    
    
    yysuccess("inf_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUPERIOR} {
    
    
    yysuccess("sup_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INFERIOREQUAL} {
    
    
    yysuccess("inforequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUPERIOREQUAL} {
    
    
    yysuccess("suporequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{ADD} {
    
    
    yysuccess("add", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUB} {
    
    
    yysuccess("sub", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{MULT} {
    
    
    yysuccess("mult", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{DIV} {
    
    
    yysuccess("div", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{MOD} {
    
    
    yysuccess("mod", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{POWER} {
    
    
    yysuccess("power", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{ASSIGN} {
    
    
    yysuccess("assignment_op", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{BOOL} {
    
    
    yysuccess("bool", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{INTEGER} {
    
    
    yysuccess("integer", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{FLOAT} {
    
    
    yysuccess("float", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}



{INTDEC} {
    
    
    yysuccess("int_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{STRDEC} {
    
    
    yysuccess("str_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}


{BOOLDEC} {
    
    
    yysuccess("bool_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{FLTDEC} {
    
    
    yysuccess("float_declaration",yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{STRUCTDEC} {
    
    
    yysuccess("struct_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{INLINECOMMENT} {
    
    
    yysuccess("inline_comment", "", yyleng);
    currentColumnNum +=yyleng;
    
}

{BLOCCOMMENT} {
    
    
    yysuccess("bloc_comment", "", yyleng);
    currentColumnNum +=yyleng;
    
}

{NEWLINE} {
    
    
    currentColumnNum = 1;
    currentLineNum++;
}


{ID} {
    
    
    yysuccess("identifier", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{STR} {
    
    
    yysuccess("string", yytext, yyleng);
    currentColumnNum +=yyleng;
    
} 


{SPACE} {
    yysuccess("space", yytext, yyleng);
    currentColumnNum+=yyleng;
}

{TABULATION} {
    yysuccess("tabulation", yytext, yyleng);
    currentColumnNum+=yyleng;
}

<<EOF>> yyterminate();

. {
    yyerror("Unrecognized character");
    showLexicalError();
    yyterminate();
}


%%

/*int main (){
    yyin = fopen("input_test","r");
    
    // initializing the symbols table
    symbolTable = allocateLine();
    currentLineNum++;
    currentLine = symbolTable;
    
    yylex();
    
    printSymbolTable();
    
    fclose(yyin);
    fclose(yyout);
}*/


void yysuccess(const char *s, const char *token, int length) {
    if(showsuccess) {
        printf("Found %s : ", s);
        printf("\033[0;32m");
        printf("'%s'", token); 
        printf("\033[0m"); 
        printf(" at Ln %d Col %d \n", yylineno, currentColumnNum);
    }
}

void yyerror(const char *s) {
    printf("\033[0;31m"); 
    printf("\033[0m"); 
}

void showLexicalError() {    
    fprintf(yyout, "Lexical error in Line %d Column %d : Unrecognized character: %s \n", yylineno, currentColumnNum, yytext);
}

/*void printSymbolTable() {
    	Line *line = symbolTable;
    	while (line != NULL) {
        	printf("Line %d:\n", line->numLine);

        	Column *column = line->Columns;
        	while (column != NULL) {
		    	printf("  Column %d:\n", column->numColumn);
		    	printf("    Type: %s\n", column->typeToken);
		    	printf("    Name: %s\n", column->nameToken);
            		printf("    Value: %s\n", column->valeurToken);

            		column = column->suivC;
        	}

        	line = line->suivL;
    }
}*/

