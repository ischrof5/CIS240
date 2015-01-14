// rpn.c: Written by Daniel McCann
// cis240 HW7

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include "stack.h"

#define MAX_INPUT_LENGTH 200


int main ()
{
	char input[MAX_INPUT_LENGTH];
	char str1[MAX_INPUT_LENGTH];
	char str2[MAX_INPUT_LENGTH];
	float number;
	stack_elt *stack_top = NULL;
	int i, count = 0;
	float a, b, c;

	printf ("\nWelcome to Postfix Calculator! Written by Dan M.\n");
	printf ("Valid inputs: decimal numbers,\n");
	printf ("Binary operations: +, -, *, /, swap\n");
	printf ("Unary operations: sin, cos, tan, log, dup, exp\n");
	printf ("Press q to quit.\n");

	while (1) {
		printf ("Enter command or press q to quit: ");

		fgets (input, MAX_INPUT_LENGTH, stdin);

		// convert string to lower case
		for (i = 0; i < strlen(input); i++) {
			input[i] = tolower(input[i]);
		}

		// check which command
		if (sscanf (input, "%s %s", str1, str2) == 2) {
			printf("INVALID INPUT\n");
		} else if (sscanf (input, "%f", &number) == 1) {
			push (&stack_top, number);
			count++;
			printf ("Stack top: %f\n", peek(&stack_top));
		} else if (sscanf (input, "%s", str1) == 1) {
			if (strcmp(str1, "q") == 0) {
				clear(&stack_top);
				exit(0);
			} else if (strcmp(str1, "+") == 0) {
				if (count >= 2) {
					a = pop(&stack_top);
					b = pop(&stack_top);
					c = a + b;
					push(&stack_top, c);
					printf ("Stack top: %f\n", peek(&stack_top));
					count--;
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "-") == 0) {
				if (count >= 2) {
					a = pop(&stack_top);
					b = pop(&stack_top);
					c = a - b;
					push(&stack_top, c);
					printf ("Stack top: %f\n", peek(&stack_top));
					count--;
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "/") == 0) {
				if (count >= 2) {
					a = pop(&stack_top);
					b = pop(&stack_top);
					c = a / b;
					push(&stack_top, c);
					printf ("Stack top: %f\n", peek(&stack_top));
					count--;
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "*") == 0) {
				if (count >= 2) {
					a = pop(&stack_top);
					b = pop(&stack_top);
					c = a * b;
					push(&stack_top, c);
					printf ("Stack top: %f\n", peek(&stack_top));
					count--;
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "sin") == 0) {
				if (count >= 1) {
					a = pop(&stack_top);
					c = (float) sin((double) (a));
					push(&stack_top, c);
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}	
			} else if (strcmp(str1, "cos") == 0) {
				if (count >= 1) {
					a = pop(&stack_top);
					c = (float) cos((double) (a));
					push(&stack_top, c);
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "tan") == 0) {
				if (count >= 1) {
					a = pop(&stack_top);
					c = (float) tan((double) (a));
					push(&stack_top, c);
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "log") == 0) {
				if (count >= 1) {
					a = pop(&stack_top);
					c = (float) log((double) (a));
					push(&stack_top, c);
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "exp") == 0) {
				if (count >= 1) {
					a = pop(&stack_top);
					c = (float) exp((double) (a));
					push(&stack_top, c);
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "dup") == 0) {
				if (count >= 1) {
					push(&stack_top, peek(&stack_top));
					count++;
					printf("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else if (strcmp(str1, "swap") == 0) {
				if (count >= 2) {
					a = pop(&stack_top);
					b = pop(&stack_top);
					push(&stack_top, a);
					push(&stack_top, b);
					printf ("Stack top: %f\n", peek(&stack_top));
				} else {
					printf("STACK ERROR\n");
				}
			} else {
				printf("INVALID INPUT\n");
			}
		}
	}
}
