// map.h: declaration of functions


// used to map the identifier names to their values
// key: identifier name / label
// value: int indicating the shift from frame pointer in assembly
typedef struct map_elt_tag {
	char *key;
	int value;
	struct map_elt_tag *next;
} map_elt;

// put a key value pair in the linked list map
void put (map_elt **root, char *k, int v);

// find the value associated with the key
int get (map_elt **root, char* k);

// pop the top off this map, like a stack
char* pop (map_elt **top);

// free everything in the map
void clear (map_elt **root);
