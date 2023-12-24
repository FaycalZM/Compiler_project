
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "Struct.c"
   

    int currentColumnNum = 1;
    int currentLineNum = 1; 	    
    int showsuccess = 1;
    
    Line* symbolTable;
    Line* currentLine;
    
    
    
    void yysuccess(const char *s, const char *token, int length);
    void yyerror(const char *s);
    void showLexicalError();
    void printSymbolTable();
%}

/*Used to get the current line INTEGER*/
%option yylineno
/* the lexical analyzer will be in this file */  
%option outfile = "scanner.c"    


/*Reserved keywords*/
PROG "MAIN_PROG"
L_FOR use
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
    
    insertColumn(currentLine, "main_prog",yytext,"",currentColumnNum);
    yysuccess("main_program", yytext, yyleng);
    currentColumnNum +=yyleng;    
}

{L_FOR} {
    
    insertColumn(currentLine, "for_loop",yytext,"",currentColumnNum);
    yysuccess("for", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}
{L_WHILE} {
    
    insertColumn(currentLine, "while_loop",yytext,"",currentColumnNum);
    yysuccess("while", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INPUT} {
    
    insertColumn(currentLine, "read",yytext,"",currentColumnNum);
    yysuccess("input", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OUTPUT} {
    
    insertColumn(currentLine, "write",yytext,"",currentColumnNum);
    yysuccess("output", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{IF} {
    
    insertColumn(currentLine, "if",yytext,"",currentColumnNum);
    yysuccess("check", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{ELSE} {
    
    insertColumn(currentLine, "else",yytext,"",currentColumnNum);
    yysuccess("else", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}



{DOT} {
    
    insertColumn(currentLine, "dot",yytext,"",currentColumnNum);
    yysuccess("dot", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{COMMA} {
    
    insertColumn(currentLine, "comma",yytext,"",currentColumnNum);
    yysuccess("comma", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{SEMICOLON} {
    
    insertColumn(currentLine, "semicolon",yytext,"",currentColumnNum);
    yysuccess("semicolon", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{OPENINGPARENTHESIS} {
    
    insertColumn(currentLine, "opening_parenthesis",yytext,"",currentColumnNum);
    yysuccess("opening_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGPARENTHESIS} {
    
    insertColumn(currentLine, "closing_parenthesis",yytext,"",currentColumnNum);
    yysuccess("closing_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OPENINGBRACE} {
    
    insertColumn(currentLine, "opening_brace",yytext,"",currentColumnNum);
    yysuccess("opening_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGBRACE} {
    
    insertColumn(currentLine, "closing_brace",yytext,"",currentColumnNum);
    yysuccess("closing_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OPENINGBRACKET} {
    
    insertColumn(currentLine, "opening_bracket",yytext,"",currentColumnNum);
    yysuccess("opening_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{CLOSINGBRACKET} {
    
    insertColumn(currentLine, "closing_bracket",yytext,"",currentColumnNum);
    yysuccess("closing_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}
			
{EQUAL} {
    
    insertColumn(currentLine, "equal_sign",yytext,"",currentColumnNum);
    yysuccess("equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{NONEQUAL} {
    
    insertColumn(currentLine, "non_equal_sign",yytext,"",currentColumnNum);
    yysuccess("non_equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{AND} {
    
    insertColumn(currentLine, "and_op",yytext,"",currentColumnNum);
    yysuccess("AND", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{OR} {
    
    insertColumn(currentLine, "or_op",yytext,"",currentColumnNum);
    yysuccess("OR", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{NON} {
    
    insertColumn(currentLine, "non_op",yytext,"",currentColumnNum);
    yysuccess("NON", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INFERIOR} {
    
    insertColumn(currentLine, "inferior",yytext,"",currentColumnNum);
    yysuccess("inf_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUPERIOR} {
    
    insertColumn(currentLine, "superior",yytext,"",currentColumnNum);
    yysuccess("sup_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{INFERIOREQUAL} {
    
    insertColumn(currentLine, "inferior_or_equal",yytext,"",currentColumnNum);
    yysuccess("inforequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUPERIOREQUAL} {
    
    insertColumn(currentLine, "superior_or_equal",yytext,"",currentColumnNum);
    yysuccess("suporequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{ADD} {
    
    insertColumn(currentLine, "addition",yytext,"",currentColumnNum);
    yysuccess("add", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{SUB} {
    
    insertColumn(currentLine, "substraction",yytext,"",currentColumnNum);
    yysuccess("sub", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{MULT} {
    
    insertColumn(currentLine, "multiplication",yytext,"",currentColumnNum);
    yysuccess("mult", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{DIV} {
    
    insertColumn(currentLine, "division",yytext,"",currentColumnNum);
    yysuccess("div", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{MOD} {
    
    insertColumn(currentLine, "modulo",yytext,"",currentColumnNum);
    yysuccess("mod", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{POWER} {
    
    insertColumn(currentLine, "power",yytext,"",currentColumnNum);
    yysuccess("power", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{ASSIGN} {
    
    insertColumn(currentLine, "assign",yytext,"",currentColumnNum);
    yysuccess("assignment_op", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{BOOL} {
    
    insertColumn(currentLine, "bool_type",yytext,"",currentColumnNum);
    yysuccess("bool", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{INTEGER} {
    
    insertColumn(currentLine, "int_type",yytext,"",currentColumnNum);
    yysuccess("integer", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{FLOAT} {
    
    insertColumn(currentLine, "float_type",yytext,"",currentColumnNum);
    yysuccess("float", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}



{INTDEC} {
    
    insertColumn(currentLine, "int_declaration",yytext,"",currentColumnNum);
    yysuccess("int_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}

{STRDEC} {
    
    insertColumn(currentLine, "string_declaration",yytext,"",currentColumnNum);
    yysuccess("str_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
    
}


{BOOLDEC} {
    
    insertColumn(currentLine, "boolean_declaration",yytext,"",currentColumnNum);
    yysuccess("bool_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{FLTDEC} {
    
    insertColumn(currentLine, "float_declaration",yytext,"",currentColumnNum);
    yysuccess("float_declaration",yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{STRUCTDEC} {
    
    insertColumn(currentLine, "structure_declaration",yytext,"",currentColumnNum);
    yysuccess("struct_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}


{INLINECOMMENT} {
    
    insertColumn(currentLine, "inline_comment",yytext,"",currentColumnNum);
    yysuccess("inline_comment", "", yyleng);
    currentColumnNum +=yyleng;
    
}

{BLOCCOMMENT} {
    
    insertColumn(currentLine, "bloc_comment",yytext,"",currentColumnNum);
    yysuccess("bloc_comment", "", yyleng);
    currentColumnNum +=yyleng;
    
}

{NEWLINE} {
    currentLine = insertLine(&symbolTable,currentLineNum);
    insertColumn(currentLine, "linebreak",yytext,"",currentColumnNum);
    currentColumnNum = 1;
    currentLineNum++;
}


{ID} {
    
    insertColumn(currentLine, "identifier",yytext,"",currentColumnNum);
    yysuccess("identifier", yytext, yyleng);
    currentColumnNum +=yyleng;
    
}

{STR} {
    
    insertColumn(currentLine, "string",yytext,"",currentColumnNum);
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

int main (){
    yyin = fopen("input_test","r");
    
    // initializing the symbols table
    symbolTable = allocateLine();
    currentLineNum++;
    currentLine = symbolTable;
    
    yylex();
    
    printSymbolTable();
    
    fclose(yyin);
    fclose(yyout);
}


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

void printSymbolTable() {
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
}

