
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define MAX 1000
int noVector3 = 0;
int noVector2 = 0;
int wasError = 0;
float min = 100000000;
float max  = 0.0;
int indexNumber = 0;
int indexPointMin = 0;
int indexPointMax = 0;
float *arr_distan = NULL;
struct Point
{
    int x[100];
    int y[100];
};

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

 
__list: _list ST {	 printf("No. of Points: %d\n", $1); 
			         printf("The smallest distance is: %f \n", sqrt(min));
                     printf("Position of the pair of points: %d\n", indexPointMin);
                     printf("The smallest distance is: %f \n", sqrt(max));
                     printf("Position of the pair of points: %d\n", indexPointMax);
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
                        *(arr_distan + indexNumber) = $2;
                        indexNumber = indexNumber+ 1;
                        *(arr_distan + indexNumber) = $4;
                        indexNumber = indexNumber +1;
                        if(distanct(0,0,$2,$4) < min){
                            min = distanct(0,0,$2,$4);
                            indexPointMin = (indexNumber+1)/2;
                        }
                        if(distanct(0,0,$2,$4) >= max){
                            max = distanct(0,0,$2,$4);
                            indexPointMax = (indexNumber+1)/2;
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
