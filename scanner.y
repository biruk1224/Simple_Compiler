%{
#include <stdio.h>
#define border printf("\n----------------------------------------------------\n")
int yydebug=1;
%}

// tokens

%token MELEYA
%token STRING_LIT STRING_VAR
%token EQ PLUS MINUS MUL DIVIDE LBRACKET RBRACKET HULET_NETIB BRACKET NUMBER ARAT_NETIB HULET_NETIB
%token PRINT KEYWORD EXCLA INV_EXCLA
%token ALPHA
//set precedence

%right EQ
%left PLUS MINUS
%left MUL DIVIDE


%%

//grammer

start:  statements ARAT_NETIB { printf("Valid ፖ++ statement"); YYACCEPT;}


statements: assign_arithmetic
	  | assign_str
	  | display
	  | functions
	
	    
	   
identifier: MELEYA
	   | keyword {yyerror("\nError:You have used ፖ++ keyword as an identifier\n"); YYABORT; }

keyword: KEYWORD 

functions: identifier LBRACKET RBRACKET body


body: HULET_NETIB statements ARAT_NETIB

assign_arithmetic: identifier EQ expr	   

assign_str: identifier EQ strings

strings:  STRING_LIT
	| STRING_VAR

display: PRINT strings
	| PRINT strings MUL NUMBER
	| PRINT strings PLUS strings
	| PRINT expr 
expr: expr PLUS expr
      | expr MINUS expr
      | expr MUL expr
      | expr DIVIDE expr
      | factor
      | LBRACKET expr RBRACKET
      | SIGN factor


  
   
factor: identifier 
	|NUMBER 
	     	           
SIGN: PLUS
     | MINUS	


%%

main()
{
 printf("  		 .....................ፓ++ expression parser........................ 		\n\n");
 printf("Enter a ፓ++ expression\n");
 return(yyparse());
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap()
{
  return(1);
}


