/*
 * ObjectFiles.c
 */

#include <stdio.h>
#include <stdlib.h>
#include "ObjectFiles.h"


// Read an object file and modify the machine state accordingly
// Return a zero if successful and a non-zero error code if you encounter a problem
int ReadObjectFile (char *filename, MachineState *theMachineState) {
	FILE *objFile;
	unsigned short int num, lowerHalf, PCAdd, sectionSize = 0, i;

	// open file for binary reading
	objFile = fopen (filename, "rb");

	if (objFile == NULL) {
		printf ("Couldn't open binary file\n");
		return 1;
	}

	//read the file and write into machine state
	while (fread(&num, sizeof(unsigned short int), 1, objFile) == 1) {
		// read section header
		// fix little endian formatting
		lowerHalf = (num & 0xFF00) >> 8;
		num = (num << 8) | lowerHalf;

		//printf("Hex read: %x\n", num);
		if (num == 0xDADA || num == 0xCADE) {
			// data or code

			// get starting address
			fread(&PCAdd, sizeof(unsigned short int), 1, objFile);
			lowerHalf = (PCAdd & 0xFF00) >> 8;
			PCAdd = (PCAdd << 8) | lowerHalf;

			// get size of section
			fread(&sectionSize, sizeof(unsigned short int), 1, objFile);
			lowerHalf = (sectionSize & 0xFF00) >> 8;
			sectionSize = (sectionSize << 8) | lowerHalf;

			for (i = sectionSize; i > 0; i--) {
				fread(&num, sizeof(unsigned short int), 1, objFile);
				lowerHalf = (num & 0xFF00) >> 8;
				num = (num << 8) | lowerHalf;
				theMachineState->memory[PCAdd] = num;
				PCAdd++;
			}

		} else if (num == 0xC3B7) {
			// symbol (skip)

			//printf("Symbol found");
			// get starting address
			fread(&PCAdd, sizeof(unsigned short int), 1, objFile);
			lowerHalf = (PCAdd & 0xFF00) >> 8;
			PCAdd = (PCAdd << 8) | lowerHalf;

			// get size of section
			fread(&sectionSize, sizeof(unsigned short int), 1, objFile);
			lowerHalf = (sectionSize & 0xFF00) >> 8;
			sectionSize = (sectionSize << 8) | lowerHalf;

			// characters read are irrelevant
			for (i = sectionSize; i > 0; i--) {
				fread(&num, 1, 1, objFile);
			}

		} else if (num == 0xF17E) {
			// file name (skip)

			// get size of section
			fread(&sectionSize, sizeof(unsigned short int), 1, objFile);
			lowerHalf = (sectionSize & 0xFF00) >> 8;
			sectionSize = (sectionSize << 8) | lowerHalf;

			// characters read are irrelevant
			for (i = sectionSize; i > 0; i--) {
				fread(&num, 1, 1, objFile);
			}
		} else if (num == 0x715E) {
			// line number (skip)

			// advance by 3 more words 
			for (i = 3; i > 0; i--) {
				fread(&num, sizeof(unsigned short int), 1, objFile);
			}
		} else {
			printf("Error: parsed invalid header\n");
			fclose (objFile);
			return 1;
		}

	} 
	fclose (objFile);
	return 0;
}

