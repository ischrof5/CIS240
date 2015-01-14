#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "stack.h"

//create a node and put at the top
void push (stack_elt **top, float value) {
	stack_elt *elt;
	elt = malloc(sizeof(*elt));

	// terminate if malloc fails

	if (elt == NULL) {
		printf("Out of memory when pushing stack\n");
		exit(1);
	}

	elt->value = value;

	// does not matter if top refers to null
	elt->next = (*top);

	*top = elt;
}

//remove top element of stack and return its value
float pop (stack_elt **top) {
	float v;
	stack_elt *next;
	
	// if stack empty return NaN
	if (top == NULL || *top == NULL) {
		printf("Popped NaN from empty stack!\n");
		return (0.0/0.0);
	}
	
	v = (*top)->value;
	next = (*top)->next;
	free (*top);

	*top = next;
	return v;
}

// return top of stack but do not delete
float peek (stack_elt **top) {
	float v;

	if (top == NULL || *top == NULL) {
		printf("Peeked at empty stack!\n");
		return (0.0/0.0);
	}
	
	v = (*top)->value;

	return v;
}

// free everything in the stack
void clear (stack_elt **top) {
	stack_elt *next;

	while (*top != NULL) {
		next = (*top)->next;
		free (*top);
		*top = next;
	}
}
