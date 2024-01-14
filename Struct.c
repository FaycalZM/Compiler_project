#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct Column
{
    char typeToken[256];
    char nameToken[256];
    char valeurToken[256];
    struct Column *suivC; 
}Column;



typedef struct Line
{
    Column *Columns;
    struct Line *suivL; 
}Line;


Column* allocateColumn(){
    Column *col = (Column*)malloc(sizeof(Column));
    col->suivC=NULL;

    return col;
} 


Line* allocateLine(){
    Line *li = (Line*)malloc(sizeof(Line));

    li->Columns=NULL;
    li->suivL=NULL;

    return li;
}

    Line* insertLine(Line **Lign){
        Line *li ;
        Line *newLine;
        if(*Lign==NULL){
            newLine = allocateLine();
            return newLine;
        }else{
            li = *Lign;
            while (li->suivL!=NULL)
            {
                li = li->suivL;
            }
            newLine = allocateLine();
            li->suivL=newLine;
            return newLine;    
        }
    }



    void insertColumn(Line *Lign,char* typeToken,char* nameToken,char* valeurToken){
        Column *col,*c = Lign->Columns;
        if(c==NULL){
            col= allocateColumn(); 
            strcpy(col->typeToken,typeToken);
            strcpy(col->nameToken,nameToken);
            strcpy(col->valeurToken,valeurToken);
            Lign->Columns=col;
        }else{
            while (c->suivC!=NULL)
            {
                c=c->suivC;
            }
            col= allocateColumn(); 
            strcpy( col->typeToken,typeToken);
            strcpy(col->nameToken,nameToken);
            strcpy(  col->valeurToken,valeurToken);
            c->suivC=col;
        }
    }


    Column* get_id(Line *Lign , char id[]){
        Column *col = Lign->Columns;
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
