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
    Line *Table_sym = NULL;  
    
    int i =25;
    int ri=1;
    typedef struct quadruplet{
        char op[20];
        char opr1[20];
        char opr2[20];
        char res[20];
    }quadruplet;
    int sauv_if_fin = 0;
    int sauv_else =0;
    int sauv_else_fin=0;
    int  sauv_for_test=0;
    int sauv_for_init_id=0;
    quadruplet quadruplets[1000];
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
code: code code | affectation | commentaire | tabledeclaration | structdeclaration | declaration | statements | expression  | read | write ;

declaration: type ID SEMICOLON {
    if(get_id(Table_sym,$2)!=NULL){
        printf("Variable already declared : %s \n ",$2);
        YYERROR;
    }else{
        insertColumn(Table_sym,$<val_str>1,$2,""); 
    }
} ;
type: INTDEC  | FLTDEC | STRDEC  | BOOLDEC | CHRDEC | structure ;

structdeclaration: STRUCTDEC structure OPENINGBRACE declarations CLOSINGBRACE ;
declarations : declaration | declaration declarations;
structure: ID ;

tableelement : ID OPENINGBRACKET item CLOSINGBRACKET;


tabledeclaration: type OPENINGBRACKET tablesize CLOSINGBRACKET ID SEMICOLON;
tablesize: ID | expressionAR | INTEGER;

statements : if_stmt | if_else_stmt | for_stmt | while_stmt ;

if_stmt: B1 OPENINGBRACE code CLOSINGBRACE {
	/* sauvegarder la fin du bloc "if" */
	sprintf(quadruplets[sauv_if_fin].opr1,"%d",taille+1);
};

B1:IF  expressionLG{
    sauv_if_fin = taille-1;
};
if_else_stmt: A1 ELSE OPENINGBRACE code CLOSINGBRACE {
	sprintf(quadruplets[sauv_else_fin].opr1,"%d",taille+1);
} ;
A1: A2 OPENINGBRACE code CLOSINGBRACE {
	sprintf(quadruplets[sauv_else].opr1,"%d",taille+2); 
    strcpy(quadruplets[taille].op,"BR");
    strcpy(quadruplets[taille].opr1,"");
    strcpy(quadruplets[taille].opr2,"");
    strcpy(quadruplets[taille].res,"");
    sauv_else_fin = taille;
    taille++;
} ;

A2:IF OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS{
	sauv_else=taille-1;
};


for_stmt: R1 OPENINGBRACE code CLOSINGBRACE{
	char res[10];
    strcpy( quadruplets[taille].op,"+");    	          
    strcpy( quadruplets[taille].opr1,quadruplets[sauv_for_init_id].res);
    strcpy( quadruplets[taille].opr2,pas);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( quadruplets[taille].op,"=");
    sprintf(quadruplets[taille].opr1,"%s",res);
    strcpy( quadruplets[taille].opr2,"");
    strcpy( quadruplets[taille].res,quadruplets[sauv_for_init_id].res);
    taille++;
    strcpy( quadruplets[taille].op,"BR");
    sprintf( quadruplets[taille].opr1,"%d", sauv_for_test + 1);
    strcpy( quadruplets[taille].opr2,"");
    strcpy( quadruplets[taille].res,"");
    taille++;
    sprintf(quadruplets[sauv_for_test].opr1,"%d",taille+1);
};
R1:R2 SEMICOLON INTEGER CLOSINGPARENTHESIS{
	sprintf(pas,"%d",$<val_int>3);
};
R2:R3 SEMICOLON expressionLG {
    sauv_for_test = taille-1;
};
R3:L_FOR OPENINGPARENTHESIS ID ASSIGN expressionAR{
	if(get_id(Table_sym,$<val_str>3)!=NULL){
        strcpy( quadruplets[taille].op,"=");
        strcpy(quadruplets[taille].opr1,$<val_str>5);
        strcpy( quadruplets[taille].opr2,"");
        strcpy( quadruplets[taille].res,$<val_str>3);
        sauv_for_init_id =taille;
        taille++;
    }else{
        printf("Undeclared variable (first use in this operation) : %s\n",$<val_str>3);
        YYERROR;
    }
};

while_stmt: C1 OPENINGBRACE code CLOSINGBRACE{
    
};
C1:L_WHILE OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS;

expression : expressionAR | expressionLG;

read: INPUT OPENINGPARENTHESIS ID CLOSINGPARENTHESIS SEMICOLON {
	if(get_id(Table_sym,$<val_str>3)!=NULL){
        strcpy( quadruplets[taille].op,"READ");
        strcpy( quadruplets[taille].opr1,$<val_str>3);
        strcpy( quadruplets[taille].opr2,"");
        strcpy( quadruplets[taille].res,"");
        taille++;
    }else{
        printf("Undeclared variable (first use in this operation) : %s\n",$<val_str>3);
        YYERROR;
    }
};
write: OUTPUT OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS SEMICOLON {
    strcpy( quadruplets[taille].op,"WRITE");
    strcpy( quadruplets[taille].opr1,$<val_str>3);
    strcpy( quadruplets[taille].opr2,"");
    strcpy( quadruplets[taille].res,"");
    taille++;
};

commentaire: commentaire commentaire | INLINECOMMENT | BLOCCOMMENT ;

expressionAR :OPENINGPARENTHESIS expressionAR CLOSINGPARENTHESIS { 
	strcpy( $<val_str>$,$<val_str>2);
} 
| expressionAR ADD expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"+");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}
| expressionAR SUB expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"-");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}
| SUB expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"-");
    strcpy( quadruplets[taille].opr1,"0");
    strcpy( quadruplets[taille].opr2,$<val_str>2);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}| expressionAR MULT expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"*");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}| expressionAR DIV expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"/");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
} | expressionAR MOD expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"\%");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}| expressionAR POWER expressionAR {
    char res[10];
    strcpy( quadruplets[taille].op,"**");
    strcpy( quadruplets[taille].opr1,$<val_str>1);
    strcpy( quadruplets[taille].opr2,$<val_str>3);
    sprintf(res, "R%d", ri);
    strcpy( quadruplets[taille].res,res);
    taille++;
    ri++;
    strcpy( $<val_str>$,res);
}| item;

item: ID {
    if(get_id(Table_sym,$<val_str>1)!=NULL){
    	strcpy($<val_str>$, $<val_str>1); 
    }else{
        printf("Undeclared variable (first use in this operation) : %s\n",$<val_str>1);
        YYERROR;
    }
}
| INTEGER {
 sprintf($<val_str>$,"%d",$<val_int>1); 
}
| tableelement ;

champenreg: ID DOT ID ;

expressionLG: OPENINGPARENTHESIS expressionLG CLOSINGPARENTHESIS 
{
	strcpy($<val_str>$,$<val_str>2);
}
| expressionLG AND expressionLG
| expressionLG OR expressionLG 
| NON expressionLG 
| element ;
 
element : ID | BOOL | tableelement | champenreg
| expressionAR EQUAL expressionAR {
	strcpy( quadruplets[taille].op,"BNE");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
}
| expressionAR NONEQUAL expressionAR {
	strcpy( quadruplets[taille].op,"BE");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
}
| expressionAR INFERIOR expressionAR {
	strcpy( quadruplets[taille].op,"BGE");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
}
| expressionAR INFERIOREQUAL expressionAR {
	strcpy( quadruplets[taille].op,"BG");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
}
| expressionAR SUPERIOR expressionAR {
	strcpy( quadruplets[taille].op,"BLE");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
}
| expressionAR SUPERIOREQUAL expressionAR {
	strcpy( quadruplets[taille].op,"BL");
    strcpy( quadruplets[taille].opr1,"");
    strcpy( quadruplets[taille].opr2,$<val_str>1);
    strcpy( quadruplets[taille].res,$<val_str>3);
    taille++;
};

affectation : ID ASSIGN expressionAR SEMICOLON {
    if(get_id(Table_sym,$1)!=NULL){
        strcpy( quadruplets[taille].op,"=");
        strcpy(quadruplets[taille].opr1,$<val_str>3);
        strcpy( quadruplets[taille].opr2,"");
        strcpy( quadruplets[taille].res,$1);
        taille++;
    }else{
        printf("Undeclared variable (first use in this operation) :%s\n",$1);
        YYERROR;
    }
}| type ID ASSIGN expressionAR SEMICOLON{
    if(get_id(Table_sym,$2)==NULL){
        insertColumn(Table_sym,$<val_str>1,$2,""); 
        strcpy( quadruplets[taille].op,"=");
        strcpy(quadruplets[taille].opr1,$<val_str>4);
        strcpy( quadruplets[taille].opr2,"");
        strcpy( quadruplets[taille].res,$2);
        taille++;
    }else{
        printf("Variable already declared :%s\n",$2);
        YYERROR;
    }
};

%%

void printSymbolTable() {
    	Line *line = Table_sym;
    	while (line != NULL) {
        	Column *column = line->Columns;
        	while (column != NULL) {
		    	
		    	printf("    Type: %s\n", column->typeToken);
		    	printf("    Name: %s\n", column->nameToken);
            		printf("    Value: %s\n", column->valeurToken);

            		column = column->suivC;
        	}

        	line = line->suivL;
    }
}

int main(int argc, char **argv) {
    Table_sym = insertLine(&Table_sym);
    yyin = fopen(argv[1], "r");
    yyout = fopen("quadruplets.txt", "w+");
    int value = yyparse();
    
    // stocker les quadruplets dans un fichiers
    for(i=0 ; i<taille ; i++){
        fprintf(yyout,"%d-(%s,%s,%s,%s)\n",i+1,quadruplets[i].op,quadruplets[i].opr1,quadruplets[i].opr2,
        quadruplets[i].res);
    }
    
    if(value==1){
        printf("\nError in line :%d and column : %d\n",yylineno,currentColumnNum);
    }else{
        printf("Compilation finished successfully!\n");
    }
    printSymbolTable();
    fclose(yyin);
    fclose(yyout);
    return 0;
}







