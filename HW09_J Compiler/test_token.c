//
// test_token.c
//

#include <stdio.h>
#include <stdlib.h>
#include "token.h"


int main (int argc, char *argv[]) {

  FILE *theFile;

  if (argc < 2) {
    printf ("First argument should be a filename\n");
    exit(1);
  }

  theFile = fopen (argv[1], "r");

  if (!theFile) {
    printf ("Problem opening the file\n");
    exit (1);
  }

  while (get_token(theFile) == 0) {
    
    switch (current_token.type) {
      
      case IDENT:
	printf ("IDENT %s", current_token.str);
	break;
	
      case NUMBER:
	printf ("NUMBER %d", current_token.value);
	break;

      default:
	printf ("%s", tokenType_to_string (current_token.type));
	break;

    }
    
    printf ("\n\n");
  }

  fclose (theFile);
  
}
