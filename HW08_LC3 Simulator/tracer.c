/*
 * Code by Daniel McCann, CIS 240 fall 2014
 *
 * Tracer.c: read compiled assembly (obj) files and execute them
 * while printing their instructions in order of occurence and writing to a file
 * tracer.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ObjectFiles.h"


void printTrace (unsigned short int PC, unsigned short int insn) {
  // first four bits of instruction
  unsigned short int opCode = insn >> 12;
  // for identifying specific instruction
  unsigned short int subOpCode;
  unsigned short int rs, rt, rd, imm;

  printf("%04x: ", PC);

  if (opCode == 0) {
    // branching
    subOpCode = insn >> 9;
    subOpCode = subOpCode & 7;
    imm = insn & 0x01FF;
    rs = insn >> 9;

    if (subOpCode == 0) {
      // NOP
      printf("NOP\n");
    } else {
      if (rs == 1) {
        printf("BRp %d\n", imm);
      } else if (rs == 2) {
        printf("BRz %d\n", imm);
      } else if (rs == 4) {
        printf("BRn %d\n", imm);
      } else if (rs == 3) {
        printf("BRzp %d\n", imm);
      } else if (rs == 5) {
        printf("BRnp %d\n", imm);
      } else if (rs == 6) {
        printf("BRnz %d\n", imm);
      } else if (rs == 7) {
        printf("BRnzp %d\n", imm);
      }
    }

  } else if (opCode == 1) {
    // arithmetic
    subOpCode = (insn >> 3) & 7;
    rd = (insn >> 9) & 7;
    rs = (insn >> 6) & 7;
    rt = insn & 7;
    imm = insn & 0x001F;

    if (subOpCode == 0) {
      // add
      printf("ADD R%d R%d R%d\n", rd, rs, rt);
    } else if (subOpCode == 1) {
      // multiply
      printf("MUL R%d R%d R%d\n", rd, rs, rt);
    } else if (subOpCode == 2) {
      // subtract
      printf("SUB R%d R%d R%d\n", rd, rs, rt);
    } else if (subOpCode == 3) {
      // divide
      printf("DIV R%d R%d R%d\n", rd, rs, rt);
    } else {
      // add immediate
      printf("ADD R%d R%d %d\n", rd, rs, imm);
    }

  } else if (opCode == 2) {
    // comparisons
    subOpCode = (insn >> 7) & 3;
    rs = (insn >> 9) & 7;
    rt = insn & 7;
    imm = insn & 0x007F;

    if (subOpCode == 0) {
      // signed comparison
      printf("CMP R%d R%d\n", rs, rt);
    } else if (subOpCode == 1) {
      // unsigned comparison
      printf("CMPU R%d R%d\n", rs, rt);
    } else if (subOpCode == 2) {
      // signed immediate comparison
      printf("CMPI R%d %d\n", rs, imm);
    } else {
      // unsigned immediate comparison
      printf("CMPIU R%d %d\n", rs, imm);
    }

  } else if (opCode == 4) {
    // jump to subroutine
    subOpCode = (insn >> 11) & 1;
    rs = (insn >> 6) & 7;
    imm = insn & 0x07FF;

    if (subOpCode) {
      // JSRR
      printf("JSRR %d\n", imm);
    } else {
      // JSR
      printf("JSR %d\n", rs);
    }

  } else if (opCode == 5) {
    // logical operations
    subOpCode = (insn >> 3) & 7;
    rd = (insn >> 9) & 7;
    rs = (insn >> 6) & 7;
    rt = insn & 7;
    imm = insn & 0x001F;

    if (subOpCode == 0) {
      // and
      printf("AND R%d R%d R%d\n", rd, rs, rt);
    } else if (subOpCode == 1) {
      // not
      printf("NOT R%d R%d\n", rd, rs);
    } else if (subOpCode == 2) {
      // or
      printf("OR R%d R%d R%d\n", rd, rs, rt);
    } else if (subOpCode == 3) {
      // xor
      printf("XOR R%d R%d R%d\n", rd, rs, rt);
    } else {
      // and immediate
      printf("ADD R%d R%d %d\n", rd, rs, imm);
    }

  } else if (opCode == 6) {
    // load

    rd = (insn >> 9) & 7;
    rs = (insn >> 6) & 7;
    imm = insn & 0x003F;

    printf("LDR R%d R%d %d\n", rd, rs, imm);

  } else if (opCode == 7) {
    // store
    rd = (insn >> 9) & 7;
    rs = (insn >> 6) & 7;
    imm = insn & 0x003F;

    printf("STR R%d R%d %d\n", rd, rs, imm);

  } else if (opCode == 8) {
    // RTI

    printf("RTI\n");

  } else if (opCode == 9) {
    // constant
    rd = (insn >> 9) & 7;
    imm = insn & 0x01FF;

    printf("CONST R%d %d\n", rd, imm);

  } else if (opCode == 10) {
    // shift
    rd = (insn >> 9) & 7;
    rs = (insn >> 6) & 7;
    imm = insn & 0x000F;
    subOpCode = (insn >> 4) & 3;

    if (subOpCode == 0) {
      // sll
      printf("SLL R%d R%d %d\n", rd, rs, imm);
    } else if (subOpCode == 1) {
      // sra
      printf("SRA R%d R%d %d\n", rd, rs, imm);
    } else if (subOpCode == 2) {
      // srl
      printf("SRL R%d R%d %d\n", rd, rs, imm);
    } else {
      // mod
      rt = insn & 7;
      printf("MOD R%d R%d R%d\n", rd, rs, rt);
    }

  } else if (opCode == 12) {
    // jump
    subOpCode = (insn >> 11) & 1;
    imm = insn & 0x07FF;
    rs = (insn >> 6) & 7;

    if (subOpCode) {
      // jmp
      printf("JMP %d\n", imm);
    } else {
      // jmpr
      printf("JMP R%d\n", rs);
    }
  } else if (opCode == 13) {
    // high constant
    rd = (insn >> 9) & 7;
    imm = insn & 0x00FF;

    printf("HICONST R%d %d\n", rd, imm);
  } else if (opCode == 15) {
    // trap
    imm = insn & 0x00FF;

    printf("TRAP %d\n", imm);
  }
}


int main (int argc, char *argv[]) {
  MachineState *simulation;
  FILE *output;
  short int i, simOutput;
  unsigned short int currentPC, currentINSN;

  if (argc < 3) {
    printf("Insufficient command line arguments:\n");
    printf(">> trace (output_name) input1.obj input2.obj...\n");
    exit(4);
  }

  // open binary file for writing
  output = fopen(argv[1], "wb");

  if (output == NULL) {
    printf ("Couldn't open output file\n");
    exit(4);
  }

  // initialize virtual machine
  simulation = malloc(sizeof(MachineState));

  if (simulation == NULL) {
    printf("Couldn't allocate memory to virtual machine\n");
    fclose(output);
    exit(4);
  }

  // reset virtual machine and load input files
  Reset(simulation);

  for (i = 2; i < argc; i++) {
    if (ReadObjectFile(argv[i], simulation) == 1) {
      printf("Couldn't open input file %d\n", i);
      free(simulation);
      fclose(output);
      exit(4);
    }
  }


  currentPC = simulation->PC;
  currentINSN = simulation->memory[currentPC];

  // attempt to write the output
  
  while (currentPC != 0x80FF) {

    // try to advance the simulation
    simOutput = UpdateMachineState(simulation);
    if (simOutput == 0) {
      // write valid counter and instruction to binary file
      fwrite (&currentPC, sizeof(unsigned short int), 1, output);
      fwrite (&currentINSN, sizeof(unsigned short int), 1, output);
      printTrace(currentPC, currentINSN);

      // debugging print statements: output the registers
      // for (i = 0; i < 8; i++) {
      //   printf("Register[%d]: %04x\n", i, simulation->R[i]);
      // }

    } else if (simOutput == 1) {
      printf("Tried to execute data as code\n");
      fclose(output);
      free(simulation);
      exit(1);
    } else if (simOutput == 2) {
      printf("Tried to read/write code as data\n");
      fclose(output);
      free(simulation);
      exit(2);
    } else if (simOutput == 3) {
      printf("Tried to access operating system without permission\n");
      fclose(output);
      free(simulation);
      exit(3);
    }

    // find new PC and instruction of simulation and continue
    currentPC = simulation->PC;
    currentINSN = simulation->memory[currentPC];
    
  }
    
  
  

  fclose(output);
  free(simulation);
  exit(0);
}