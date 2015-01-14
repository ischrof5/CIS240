/*
 * Code by Daniel McCann, CIS 240 fall 2014
 *
 * this version of tracer is broken down to test inputs one by one
 *
 * Tracer.c: read compiled assembly (obj) files and execute them
 * while printing their instructions in order of occurence and writing to a file
 * tracer.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ObjectFiles.h"


int main (int argc, char *argv[]) {
	MachineState *simulation;
	FILE *output;
	short int i;
	unsigned short int currentPC, currentINSN;
	char input[200];
	char str1[200];

	if (argc < 3) {
		printf("Insufficient command line arguments:\n");
		printf(">> trace (output_name) input1.obj input2.obj...\n");
		exit(1);
	}

	// open binary file for writing
	output = fopen(argv[1], "wb");

	if (output == NULL) {
    	printf ("Couldn't open output file\n");
    	exit(1);
  	}

  	// initialize virtual machine
  	simulation = malloc(sizeof(MachineState));

  	if (simulation == NULL) {
    	printf("Couldn't allocate memory to virtual machine\n");
    	fclose(output);
    	exit(1);
  	}

  	// reset virtual machine and load input files
  	Reset(simulation);

  	for (i = 2; i < argc; i++) {
  		if (ReadObjectFile(argv[i], simulation) == 1) {
  			printf("Couldn't open input file %d\n", i);
  			free(simulation);
  			fclose(output);
  			exit(1);
  		}
  	}


  	currentPC = simulation->PC;
  	currentINSN = simulation->memory[currentPC];

  	// attempt to write the output
  	
  	while (1) {

  		fgets (input, 200, stdin);

  		if (sscanf (input, "%s", str1) == 1) {
  			printf("Got an input\n");

  			if (strcmp(str1, "u") == 0) {

  				printf("Current PC: %04x\n", currentPC);
  				printf("Current instruction: %04x\n", currentINSN);
  				for (i = 0; i < 8; i++) {
  					printf("Register[%d]: %04x\n", i, simulation->R[i]);
  				}

  				// write current counter and instruction to binary file
  				fwrite (&currentPC, sizeof(unsigned short int), 1, output);
  				fwrite (&currentINSN, sizeof(unsigned short int), 1, output);
  		
  				// continue the simulation
  				if (UpdateMachineState(simulation) == 1) {
  					printf("Tried executing invalid instruction\n");
  					fclose(output);
  					free(simulation);
  					exit(1);
  				}

  				// check new PC for input
  				currentPC = simulation->PC;

  				//prevent interaction with data
  				if (currentPC >= 0x4000 && currentPC < 0x8000) {
  					printf("Cannot execute data as code\n");
  					fclose(output);
  					free(simulation);
  					exit(1);
  				}
  				currentINSN = simulation->memory[currentPC];
  			} else if (strcmp(str1, "q") == 0) {
  				fclose(output);
  				free(simulation);
  				printf("Exiting simulation\n");
				exit(0);
  			} else {
  				printf("u to update, q to quit\n");
  			}
  		}
  		
  	}
  	

  	fclose(output);
  	free(simulation);
	exit(0);
}