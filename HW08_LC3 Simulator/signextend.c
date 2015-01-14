/*
 * test c sext
 */
#include <stdio.h>

// testing sign extend method
int main () {
	unsigned short int x = 0x01FF;
	short int y = (short int) (x << 7);

	printf("Unsigned: %d\n", x);
	printf("Signed: %d\n", y);

}
