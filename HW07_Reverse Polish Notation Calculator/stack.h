// stack.h: declaration of functions

typedef struct stack_elt_tag {
	float value;
	struct stack_elt_tag *next;
} stack_elt;

// put a stack_elt with float on top of the stack
void push (stack_elt **top, float value);

// take a float off the top of the stack and delete node
float pop (stack_elt **top);

// look at the float on top of the stack
float peek (stack_elt **top);

// free everything in the stack
void clear (stack_elt **top);
