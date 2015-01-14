/*
 * test_fact.c : Call a function written in J
 */


#include "lc4libc.h"

void printnum (int n);

int main () {
  int n = 7;

  printnum (fact(n));
}
