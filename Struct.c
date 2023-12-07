#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct Column
{
    char typeToken[256];
    char nameToken[256];
    char valeurToken[256];
    int numColumn;
    struct Column *suivC; 
}Column;



typedef struct Line
{
    int numLine;
    Column *Columns;
    struct Line *suivL; 
}Line;


Column* allocateColumn(){
    Column *col = (Column*)malloc(sizeof(Column));

    col->numColumn=1;
    col->suivC=NULL;

    return col;
} 


Line* allocateLine(){
    Line *line = (Line*)malloc(sizeof(Line));

    line->Columns=NULL;
    line->numLine=1;
    line->suivL=NULL;


    return line;
}

Line* insertLine(Line **line , int numLine){
        Line *li ;
        Line *newLine;
        if(*line==NULL){
            newLine = allocateLine();
            return newLine;
        }else{
            li = *line;
            while (li->suivL!=NULL)
            {
                li = li->suivL;
            }
            newLine = allocateLine();
            li->suivL=newLine;
            newLine->numLine=numLine;
            return newLine;    
        }
}



    void insertColumn(Line *line,char* typeToken,char* nameToken,char* valeurToken,int numColumn){
        Column *col,*c = line->Columns;
        if(c==NULL){
            col= allocateColumn(); 
            strcpy(col->typeToken,typeToken);
            strcpy(col->nameToken,nameToken);
            strcpy(col->valeurToken,valeurToken);
            col->numColumn=numColumn;
            line->Columns=col;
        }else{
            while (c->suivC!=NULL)
            {
                c=c->suivC;
            }
            col= allocateColumn(); 
            strcpy( col->typeToken,typeToken);
            strcpy(col->nameToken,nameToken);
            strcpy(  col->valeurToken,valeurToken);
            col->numColumn=numColumn;
            c->suivC=col;
        }
    }


    Column* get_id(Line *line , char id[]){
        Column *col = line->Columns;
        int stop = 0;
        while (stop==0 && col!=NULL){
            if( strcmp(col->nameToken,id)==0){
                stop = 1;
            }
            else{
                col=col->suivC;
            }
        }
        return col;      
    }
    
    

	

