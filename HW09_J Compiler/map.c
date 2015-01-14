#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "map.h"

// put a key value pair in the linked list map
void put (map_elt **root, char *k, int v) {
	map_elt *elt;
	map_elt *current = *root;

	while (current != NULL) {
		if (strcmp(current->key, k) == 0) {
			printf("!!!~ ERROR: Duplicate Identifier %s ~!!!\n", k);
			exit(1);
		}

		current = current->next;
	}

	elt = malloc(sizeof(*elt));

	// printf("\n Put %s into map with value %d\n", k, v);
	// terminate if malloc fails

	if (elt == NULL) {
		printf("Out of memory when using map\n");
		exit(1);
	}

	elt->value = v;

	elt->key = malloc(sizeof(k));
	strcpy(elt->key, k);

	elt->next = (*root);

	*root = elt;
}


//treat the map as a stack (it's linked that way) and remove the top
char* pop (map_elt **top) {
	char *k;
	map_elt *next;
	
	// if stack empty return NaN
	if (top == NULL || *top == NULL) {
		printf("Map is empty, returned 0\n");
		return "";
	}
	
	k = (*top)->key;
	next = (*top)->next;
	free (*top);

	*top = next;
	return k;
}

// find the value associated with the ket
int get (map_elt **root, char *k) {
	// pointer to an element
	map_elt *current = *root;

	if (current == NULL) {
		printf("%s not mapped: null map \n", k);
		return 0;
	}

	while (current != NULL) {
		if (strcmp(current->key, k) == 0) {
			return current->value;
		}

		current = current->next;
	}

	printf("%s not mapped: not found in map \n", k);
	return 0;

}

// free everything in the map
void clear (map_elt **root) {
	map_elt *next;

	while (*root != NULL) {
		next = (*root)->next;
		free ((*root)->key);
		free (*root);
		*root = next;
	}
}