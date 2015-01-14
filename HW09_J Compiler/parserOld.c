//
// parser.c : Implements a recursive descent parser for the J language
//

#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>

#include "token.h"
#include "parser.h"


// Variables used to measure s-expression depth
static int s_expr_depth;

// Boolean used to disallow lets in bad places
// If this is non-zero lets will trigger a parse error
static int no_more_lets = 0;

// output file, global so it can be seen by all the functions
FILE *toWrite;

// for if else conditions
static int if_label_int = 0;

// number of let statements, used to 
static int num_lets = 0;

void sexpr (FILE *theFile, map_elt **map)
{
  int arg_no = 0;
  tokenType operator;
  char *functionName;
  
  expect (theFile, LPAREN);
  ++s_expr_depth;

  switch (current_token.type) {

    // Handle built in operators
    case PLUS:
    case MINUS:
    case MPY:
    case DIV:
    case MOD:
    case GT:
    case LT:
    case GEQ:
    case LEQ:
    case EQ:

      if (s_expr_depth == 1) no_more_lets = 1;
      
      // record the operation type for later use
      operator = current_token.type;

      printf ("Handling a %s operation\n", tokenType_to_string (operator));

      // get the next token
      get_token (theFile);

      // handle the first argument
      expr(theFile, map);
    
      // handle the second argument
      expr(theFile, map);

      // pop top two elements off stack and decrement top
      fprintf(toWrite, "\tLDR R0 R6 #0\n");
      fprintf(toWrite, "\tADD R6 R6 #1\n");
      fprintf(toWrite, "\tLDR R1 R6 #0\n");

      switch (operator) {
        case PLUS:
          fprintf(toWrite, "\tADD R1 R1 R0\n");
          // store result of operation on stack
          fprintf(toWrite, "\tSTR R1 R6 #0\n\n");

          break;
        case MINUS:
          fprintf(toWrite, "\tADD R1 R1 R0\n");
          fprintf(toWrite, "\tSTR R1 R6 #0\n\n");

          break;
        case MPY:
          fprintf(toWrite, "\tMUL R1 R1 R0\n");
          fprintf(toWrite, "\tSTR R1 R6 #0\n\n");

          break;
        case DIV:
          fprintf(toWrite, "\tDIV R1 R1 R0\n");
          fprintf(toWrite, "\tSTR R1 R6 #0\n\n");

          break;
        case MOD:
          fprintf(toWrite, "\tMOD R1 R1 R0\n");
          fprintf(toWrite, "\tSTR R1 R6 #0\n\n");

          break;     
        case GT:
          // write a 1 if comparison is true
          // or a 0 if false 
          fprintf(toWrite, "\tCMP R1 R0\n");
          fprintf(toWrite, "\tBRp TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #0\n");
          fprintf(toWrite, "\tBRnzp FALSE%d\n", if_label_int);
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R1 #1\n");
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "FALSE%d\n", if_label_int);
          if_label_int++;

          fprintf(toWrite, "\tSTR R3 R6 #0\n\n");
          break;
        case LT:
          fprintf(toWrite, "\tCMP R1 R0\n");
          fprintf(toWrite, "\tBRn TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #0\n");
          fprintf(toWrite, "\tBRnzp FALSE%d\n", if_label_int);
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #1\n");
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "FALSE%d\n", if_label_int);
          if_label_int++;

          fprintf(toWrite, "\tSTR R3 R6 #0\n\n");
          break;
        case GEQ:
          fprintf(toWrite, "\tCMP R1 R0\n");
          fprintf(toWrite, "\tBRzp TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #0\n");
          fprintf(toWrite, "\tBRnzp FALSE%d\n", if_label_int);
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #1\n");
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "FALSE%d\n", if_label_int);
          if_label_int++;

          fprintf(toWrite, "\tSTR R3 R6 #0\n\n");
          break;
        case LEQ:
          fprintf(toWrite, "\tCMP R1 R0\n");
          fprintf(toWrite, "\tBRnz TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #0\n");
          fprintf(toWrite, "\tBRnzp FALSE%d\n", if_label_int);
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #1\n");
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "FALSE%d\n", if_label_int);
          if_label_int++;

          fprintf(toWrite, "\tSTR R3 R6 #0\n\n");
          break;
        case EQ:
          fprintf(toWrite, "\tCMP R1 R0\n");
          fprintf(toWrite, "\tBRz TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #0\n");
          fprintf(toWrite, "\tBRnzp FALSE%d\n", if_label_int);
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "TRUE%d\n", if_label_int);
          fprintf(toWrite, "\tCONST R3 #1\n");
          fprintf(toWrite, ".FALIGN\n");
          fprintf(toWrite, "FALSE%d\n", if_label_int);
          if_label_int++;

          fprintf(toWrite, "\tSTR R3 R6 #0\n\n");
          break;

        default:
          // should never reach here
          break;
      }

      

      break;

      // Handle let statements
    case LET:

      if (s_expr_depth != 1)
	      parse_error ("Let's cannot be nested inside other s-expressions");

      if (no_more_lets)
	      parse_error ("All let's must occur at the start of the function");

	    expect (theFile, LET);

      if (current_token.type == IDENT) {
	      printf ("Binding %s to a value\n", current_token.str);
      }

      // logic: a valid expression following a let will leave
      // a single new element atop the stack
      // hence the location to be bount will be this stack top
      put(map, current_token.str, --num_lets);

      fprintf(toWrite, "\t;; binding identifier %s ;;\n", 
        current_token.str);

      // get the identifier being bound
      expect (theFile, IDENT);

      // expression value to be associated
      expr(theFile, map);
    
      break;

      // Handle if statements
    case IF:

      if (s_expr_depth == 1) no_more_lets = 1;

      expect (theFile, IF);

      printf ("Handling an IF statement \n");

      // get test expr
      expr(theFile, map);

      // if false, jump past true clause
      fprintf(toWrite, "\tBRnz ELSE%d\n\n", if_label_int);

      // get true clause - to be returned if test is non-zero
      expr(theFile, map);

      // jump past the false clause
      fprintf(toWrite, "\tBRnzp ELSEEND%d\n\n", if_label_int);
      fprintf(toWrite, ".FALIGN\n");
      fprintf(toWrite, "ELSE%d\n", if_label_int);

      // get false clause - to be returned if test is zero
      expr(theFile, map);

      fprintf(toWrite, ".FALIGN\n");
      fprintf(toWrite, "ELSEEND%d\n", if_label_int);
      if_label_int++;

      break;

    // Handle function calls
    case IDENT:

      if (s_expr_depth == 1) no_more_lets = 1;

      // Note the function name

      printf ("Handling a function call to %s\n", current_token.str);

      functionName = malloc(sizeof(current_token.str));
      strcpy(functionName, current_token.str);

      fprintf(toWrite, "\n\t;; calling function %s ;;\n", functionName);

      expect (theFile, IDENT);
    
      // Handle the arguments
      while ((current_token.type == NUMBER) ||
	     (current_token.type == IDENT)  ||
	     (current_token.type == LPAREN)) {

        //
        // Handle each function argument and put it on the stack
       	// at the appropriate location
        //

        // NOTE: to any confused TA looking at this code,
        // avert your eyes and read my note in function()
	      printf ("Argument number %d\n", arg_no);

	      ++arg_no;

	      expr(theFile, map);
      }
  
      fprintf(toWrite, "\n\tJSR %s\n", functionName);

      // function epilogue
      fprintf(toWrite, "\n\t;; function caller epilogue ;;\n");


      // obtain the RV: at this point the top of the stack is 
      // at the local args of the function that was just called
      fprintf(toWrite, "\tLDR R4 R6 #-1\n");

      // free the number of the function's local args, -1
      // -1 provides space for the return value of the function
      fprintf(toWrite, "\tADD R6 R6 #%d\n", arg_no - 1);
      // put the value in the old return value at the top of the stack
      
      fprintf(toWrite, "\tSTR R4 R6 #0\n");

      free(functionName);
      break;

    default:
      parse_error ("Bad sexpr");
      break;
  };

  expect (theFile, RPAREN);
  --s_expr_depth;
}









void expr (FILE *theFile, map_elt **map)
{
  switch (current_token.type) {
    case NUMBER:
      
      // Handle a numeric literal
      printf ("Literal value %d\n", current_token.value);

      // put this value on top of the stack
      if (current_token.value > 0x00FF) {
        
        // value is too great for just const
        fprintf(toWrite, "\tCONST R0 x%x\n", 
          current_token.value &0x00FF);
        fprintf(toWrite, "\tHICONST R0 #%d\n", 
          current_token.value >> 8);
      } else {
        
        // value fits in const
        fprintf(toWrite, "\tCONST R0 #%d\n", current_token.value);
      }

      fprintf(toWrite, "\tSTR R0 R6 #-1\n");
      fprintf(toWrite, "\tADD R6 R6 #-1\n\n");

      if (s_expr_depth == 0) no_more_lets = 1;
    
      expect (theFile, NUMBER);
      break;

    case IDENT:

      // Handle an identifier
      printf ("Identifier %s\n", current_token.str);

      fprintf(toWrite, "\t;; retrieving identifier %s ;;\n", 
        current_token.str);
      // get the value associated with this ident and put on stack
      fprintf(toWrite, "\tLDR R0 R5 #%d\n", 
        get(map, current_token.str));
      fprintf(toWrite, "\tSTR R0 R6 #-1\n");
      fprintf(toWrite, "\tADD R6 R6 #-1\n\n");

      if (s_expr_depth == 0) no_more_lets = 1;
    
      expect (theFile, IDENT);
      break;
      
    case LPAREN:
      sexpr(theFile, map);
      break;
      
    default:
      parse_error ("Bad expression");
      break;
  }
}








// writes a single function in the program file
void function (FILE *theFile)
{
  int arg_no = 0;
  int i;
  map_elt *m = NULL;
  map_elt **map = &m;
  map_elt *t = NULL;
  map_elt **temp = &t;
  char* argName;
  
  expect (theFile, LPAREN);
  expect (theFile, DEFUN);

  s_expr_depth = 0;
  no_more_lets = 0;
  num_lets = 0;

  if (current_token.type == IDENT) {
    printf ("Parsing a function called %s\n", current_token.str);
  }
  
  // write the function name
  fprintf(toWrite, "\n.CODE\n");
  fprintf(toWrite, "\n.FALIGN\n");
  fprintf(toWrite, "%s\n\n", current_token.str);

  // write the function prologue
  fprintf(toWrite, "\t;; function prologue for %s;;", current_token.str);
  // allocate three stack slots
  fprintf(toWrite, "\n\tADD R6 R6 #-3\n");
  // save RA
  fprintf(toWrite, "\tSTR R7 R6 #1\n");
  // save FP
  fprintf(toWrite, "\tSTR R5 R6 #0\n");
  // set up local FP
  fprintf(toWrite, "\tADD R5 R6 #0\n");

  // local variables pushed to stack will be handled with let expressions

  // Parse the function name
  expect (theFile, IDENT);

  // Parse the argument list
  expect (theFile, LPAREN);

  while (current_token.type == IDENT) {
    
    // Do something with each argument

    printf ("\t argument %d : %s\n", arg_no, current_token.str);
    
    // push the argument node onto a temporary stack
    put(temp, current_token.str, 999);

    ++arg_no;
    
    expect (theFile, IDENT);
  }
  

  // NOTE: in the call for a function, the arguments are parsed
  // from left to right (in this code) and put on the stack in that order.
  
  // The arguments here are also parsed left to right by necessity.

  // This is NOT how a function call is supposed to work.
  // It should parse the arguments in the call from left to right.
  // i.e. gcd (a b c) should push c then b then a
  
  // Thus, if the function call pushed a then b then c,
  // we need to assign c then b then a when looking down the stack.
  
  // Therefore, I've made the map act like a stack, pushed the 
  // argument names onto it, then assigned them after popping them off


  // pop each node off temp stack and put in actual map
  for (i = arg_no; i > 0; i--) {
    argName = pop (temp);
    put(map, argName, 3 + arg_no - i);
  }

  clear (temp);
  expect (theFile, RPAREN);

  do {

    // The function body consists of at least one expression.
    // the value of the last expression should be returned as the
    // function value.
    
    expr(theFile, map);
    
  } while ((current_token.type == NUMBER) ||
	   (current_token.type == IDENT)  ||
	   (current_token.type == LPAREN));

  // load the top of the stack into the RV (result of last expr)
  fprintf(toWrite, "\n\t;; function epilogue ;;\n");
  fprintf(toWrite, "\tLDR R0 R6 #0\n");
  fprintf(toWrite, "\tSTR R0 R5 #2\n");
  // free space of local variables
  clear(map);
  fprintf(toWrite, "\tADD R6 R5 #0\n");
  // restore caller frame pointer
  fprintf(toWrite, "\tLDR R5 R6 #0\n");
  // restore the return address
  fprintf(toWrite, "\tLDR R7 R6 #1\n");
  // free RA FP RV
  fprintf(toWrite, "\tADD R6 R6 #3\n");
  // return
  fprintf(toWrite, "\tRET\n\n");

  num_lets = 0;

  expect (theFile, RPAREN);
}








// writes the beginning and ending of the program file
void program (FILE *theFile)
{
  if (get_token(theFile) != 0) {
    parse_error ("problem reading first token");
  }

  printf ("Parsing a J program\n");


  // note: this functionality was actually included in libc.asm

  // first lines from 0: call j main, then halt after
  // fprintf(toWrite, "\n.CODE\n");
  // fprintf(toWrite, ".ADDR 0\n");
  // fprintf(toWrite, "\tJSR main\n");
  // fprintf(toWrite, "\tTRAP xFF      ; HALT\n");

  
  while (current_token.type != END_OF_FILE) {
    function (theFile);
  }


  printf ("Finished parsing a J program\n");
  // set up the initial conditions for lc4

  // note: this functionality was actually included in libc.asm

  // fprintf(toWrite, "\n;; OS statement for pennsim entry ;;\n");

  // fprintf(toWrite, "\n\n.OS\n");
  // fprintf(toWrite, ".CODE\n");
  // fprintf(toWrite, ".ADDR x8200\n");
  // fprintf(toWrite, ".FALIGN\n");

  // // set up stack pointers
  // fprintf(toWrite, "\tCONST R6 xFF\n");
  // fprintf(toWrite, "\tHICONST R6 x7F\n");
  // fprintf(toWrite, "\tCONST R5 xFF\n");
  // fprintf(toWrite, "\tHICONST R5 x7F\n");

  // // jump out of OS to addr 0
  // fprintf(toWrite, "\tCONST R7 #0\n");
  // fprintf(toWrite, "\tRTI\n");

}









// main function, based off of test_parser.c
int main (int argc, char *argv[]) {

  FILE *theFile;
  char *fileName;
  int i = 0;

  if (argc < 2) {
    printf ("First argument should be a filename\n");
    exit(1);
  }

  theFile = fopen (argv[1], "r");

  if (!theFile) {
    printf ("Problem opening the file\n");
    exit (1);
  }

  // remove .j file extension and replace with .asm
  fileName = malloc(sizeof(argv[1]) + 3);

  do {
    fileName[i] = argv[1][i];
    i++;
  } while (argv[1][i] != '.');
  fileName[i] = '.';
  fileName[i+1] = 'a';
  fileName[i+2] = 's';
  fileName[i+3] = 'm';
  fileName[i+4] = '\0';

  // create the new file for writing
  toWrite = fopen (fileName, "w");

  free(fileName);

  // Parse the program
  program (theFile);

  fclose (theFile);
  fclose (toWrite);
  
}
