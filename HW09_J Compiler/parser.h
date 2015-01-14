//
// parser.h
//

#include <stdio.h>
#include "map.h"

void program (FILE *theFile);
void function (FILE *theFile);
void expr (FILE *theFile, map_elt **map);
void sexpr (FILE *theFile, map_elt **map);
