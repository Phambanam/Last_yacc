
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define MAX 1000
int noVector3 = 0;
int noVector2 = 0;
int wasError = 0;
float firstNumberX = 0;
float firstNumberY = 0;
float oldNumberX = 0;
float oldNumberY = 0;
float max  = -1.0;
float temp = 0.0 ;
int indexNumber = 0;
float *arr_distan = NULL;

float distanct(float x1, float y1, float x2, float y2){
    return (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2);
}

%}
%union {
 float fval; 
 int ival;
}
%token  COMMA LPAREN RPAREN
%token <fval> NUM
%token ST
%type <ival> __list _list list
%start __list
 

 
%%

 
__list: _list ST {	 
                     *(arr_distan + indexNumber - 1 ) = distanct(oldNumberX,oldNumberY,firstNumberX,firstNumberY);
                    //print perimeterPoligon
                    float perimeterPoligon = 0;
                    for(int i = 0; i < indexNumber; i++){
                        perimeterPoligon += sqrt(arr_distan[i]);
                    }
                    printf("The perimeterof poligon is %0.3f \n", perimeterPoligon);
                
			        
			 }
 
_list:  /* empty */ { $$ = 0; }
     | list      
     ;
     
list: item             { $$ = 1; }
    | item   list  { $$ = $2 + 1; }
    ;
 
item: minDic {noVector2++; };
  
minDic: _min; 

_min: LPAREN NUM COMMA NUM RPAREN{
                         if(indexNumber == 0){
                            firstNumberX = $2;
                            firstNumberY = $4;
                            oldNumberX = $2;
                            oldNumberY = $4;
                         } 

                        indexNumber = indexNumber +1;
                        
                        //punkt 3
                        if(max <= distanct(0,0,$2,$4))
                         {
                                max = distanct(0,0,$2,$4);
                         } else {
  
                             return 0;
                         }
                         //pynkt 4
                         if(indexNumber >= 2){
                             *(arr_distan + indexNumber - 2) = distanct(oldNumberX,oldNumberY,$2,$4);
                              oldNumberX = $2;
                              oldNumberY = $4;
                         } 
                         //check dist
                         if(indexNumber >= 3){
                              if(arr_distan[indexNumber-2] <  arr_distan[indexNumber-2])
                               {
                                    yyerror("Error input");    
                                    return 0;
                               }
                         }

                    
}   
%%
main () 
{  arr_distan =  (float*) malloc(MAX * sizeof(float));
	return yyparse(); 
}
yyerror (char *s) 
{  
	fprintf( stderr, "?-%s\n", s );
    printf("error\n"); 
}
