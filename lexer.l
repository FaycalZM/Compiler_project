
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "syntax.tab.h"
   

    extern int currentColumnNum;
    
    extern int i; // utilisé dans l'analyseur sémantique(quadruplets)
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
CHAR \'.\'
BOOL VRAI|FAUX
SPACE " "
TABULATION \t

/*Declarations*/
INTDEC int
STRDEC str
BOOLDEC bln
FLTDEC flt
CHRDEC chr
STRUCTDEC structure

/*Comments*/
INLINECOMMENT #{TEXTVALUE}
BLOCCOMMENT \/\*{TEXTVALUE}\*\/

%%

{PROG} {
    yysuccess("main_program", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(PROG);    
}

{L_FOR} {
    yysuccess("for", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(L_FOR);
}
{L_WHILE} {
    
    
    yysuccess("while", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(L_WHILE);
}

{INPUT} {
    yysuccess("input", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(INPUT);
}

{OUTPUT} {
    yysuccess("output", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(OUTPUT);
}

{IF} {
    yysuccess("check", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(IF);
}

{ELSE} {
    yysuccess("else", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(ELSE);    
}



{DOT} {
    yysuccess("dot", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(DOT);
}

{COMMA} {
    yysuccess("comma", yytext, yyleng);
    currentColumnNum +=yyleng;
    yylval.val_char=',';
    return(COMMA);
}

{SEMICOLON} {
    yysuccess("semicolon", yytext, yyleng);
    currentColumnNum +=yyleng;
    yylval.val_char=';';
    return(SEMICOLON);
    
}

{OPENINGPARENTHESIS} {
    yysuccess("opening_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(OPENINGPARENTHESIS);
}

{CLOSINGPARENTHESIS} {
    yysuccess("closing_parenthesis", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(CLOSINGPARENTHESIS);
}

{OPENINGBRACE} {
    yysuccess("opening_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(OPENINGBRACE);
}

{CLOSINGBRACE} {
    
    
    yysuccess("closing_brace", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(CLOSINGBRACE);
}

{OPENINGBRACKET} {
    yysuccess("opening_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(OPENINGBRACKET);
}

{CLOSINGBRACKET} {
    yysuccess("closing_bracket", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(CLOSINGBRACKET);
}
			
{EQUAL} {
    yysuccess("equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(EQUAL);
}

{NONEQUAL} {
    yysuccess("non_equal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(NONEQUAL);
}

{AND} {
    yysuccess("AND", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(AND);
}

{OR} {
    yysuccess("OR", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(OR);
}

{NON} {
    yysuccess("NON", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(NON);
}

{INFERIOR} {
    yysuccess("inf_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(INFERIOR);
}

{SUPERIOR} {
    yysuccess("sup_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(SUPERIOR);
}

{INFERIOREQUAL} {
    yysuccess("inforequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(INFERIOREQUAL);
}

{SUPERIOREQUAL} {
    yysuccess("suporequal_sign", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(SUPERIOREQUAL);
}

{ADD} {
    yysuccess("add", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(ADD);
    
}

{SUB} {
    
    
    yysuccess("sub", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(SUB);

}

{MULT} {
    
    
    yysuccess("mult", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(MULT);

}

{DIV} {
    
    
    yysuccess("div", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(DIV);

}

{MOD} {
    
    
    yysuccess("mod", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(MOD);

}

{POWER} {
    
    
    yysuccess("power", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(POWER);

}


{ASSIGN} {
    
    
    yysuccess("assignment_op", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(ASSIGN);

}

{BOOL} {
    
    
    yysuccess("bool", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(BOOL);

}

{CHAR} {
    yysuccess("char", yytext, yyleng);
    currentColumnNum +=yyleng;
    yylval.val_char=yytext[0];
    return(CHAR);
}


{INTEGER} {
    
    
    yysuccess("integer", yytext, yyleng);
    currentColumnNum +=yyleng;
    yylval.val_int=atoi(yytext);
    return(INTEGER);

}


{FLOAT} {
    
    
    yysuccess("float", yytext, yyleng);
    currentColumnNum +=yyleng;
    yylval.val_float=atof(yytext);
    return(FLOAT);

}



{INTDEC} {
    
    yysuccess("int_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str ,"int");
    return(INTDEC);
}

{STRDEC} {
    
    
    yysuccess("str_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str ,"str");
    return(STRDEC);

    
}


{BOOLDEC} {
    
    
    yysuccess("bool_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str ,"bln");
    return(BOOLDEC);

    
}

{FLTDEC} {
    
    
    yysuccess("float_declaration",yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str ,"flt");
    return(FLTDEC);

}

{CHRDEC} {
    yysuccess("char_declaration",yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str , "chr");
    return(CHRDEC);
}
{STRUCTDEC} {
    
    
    yysuccess("struct_declaration", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(STRUCTDEC);

}


{INLINECOMMENT} {
    
    
    yysuccess("inline_comment", "", yyleng);
    currentColumnNum +=yyleng;
    return(INLINECOMMENT);

}

{BLOCCOMMENT} {
    yysuccess("bloc_comment", "", yyleng);
    currentColumnNum +=yyleng;
    return(BLOCCOMMENT);

}

{NEWLINE} {
    
    
    currentColumnNum = 1;

}


{ID} {
    
    
    yysuccess("identifier", yytext, yyleng);
    currentColumnNum +=yyleng;
    strcpy( yylval.val_str,yytext);
    i=100;
    return(ID);
}

{STR} {
    
    
    yysuccess("string", yytext, yyleng);
    currentColumnNum +=yyleng;
    return(STR);
    
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

