//
// test_parser.c
//

#include <stdio.h>
#include <stdlib.h>
#include "token.h"
#include "parser.h"

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

  // Parse the program
  program (theFile);

  fclose (theFile);
  
}
