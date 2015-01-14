/*
 * LC4.c
 */

#include <stdlib.h>
#include "LC4.h"


// Reset the machine state as Pennsim would do
void Reset (MachineState *theMachineState) {
	theMachineState->PSR = 0x8002;
	unsigned short int* mem = theMachineState->memory;
	unsigned short int* reg = theMachineState->R;
	theMachineState->PC = 0x8200;

	int i = 0;
	for (i = 0; i < 8; i++) {
		reg[i] = 0;
	}
	for (i = 0; i < 65536; i++) {
		mem[i] = 0;
	}
}

// helper function: update the NZP bits of PSR
void UpdateNZP (MachineState *theMachineState, unsigned short int ALUresult) {
	short int a = (signed short int) ALUresult;
	// im casting this as signed here but you could say a >= 2^15 is negative
	if (a < 0) {
		//n
		theMachineState->PSR = (theMachineState->PSR & 0x8000) + 4;
	} else if (a == 0) {
		//z
		theMachineState->PSR = (theMachineState->PSR & 0x8000) + 2;
	} else {
		//p
		theMachineState->PSR = (theMachineState->PSR & 0x8000) + 1;
	}
}

// Update Machine State - simulate how the state of the machine changes over a single clock cycle
int UpdateMachineState (MachineState *theMachineState) {
	unsigned short int insn = theMachineState->memory[theMachineState->PC];
	// first four bits of instruction
	unsigned short int opCode = insn >> 12;
	// for identifying specific instruction
	unsigned short int subOpCode;
	// for giving register destination
	unsigned short int rd;
	// for updating nzp
	short int result;


	if (theMachineState->PC >= 0x8000 && (theMachineState->PSR >> 15) == 0) {
		// attempting to do something in OS without privelege bit
		return 3;
	}

	if ((theMachineState->PC >= 0x4000 && theMachineState->PC < 8000) || 
		(theMachineState->PC >= 0xA000 && theMachineState->PC <= 0xFFFF)) {
		// attempting to execute data as code
		return 1;
	}


	if (opCode == 0) {
		// branching
		subOpCode = insn >> 9;
		subOpCode = subOpCode & 7;
		if (subOpCode == 0) {
			// NOP
			theMachineState->PC = PCMux(theMachineState, RS(theMachineState, '0'), '1');
		} else {
			theMachineState->PC = PCMux(theMachineState, RS(theMachineState, '0'), '0');
		}

	} else if (opCode == 1) {
		// arithmetic
		subOpCode = (insn >> 3) & 7;
		rd = (insn >> 9) & 7;

		if (subOpCode == 0) {
			// add
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'0', '0', '0', '0', '0', '0', '0', '0') ,'0');
		} else if (subOpCode == 1) {
			// multiply
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'1', '0', '0', '0', '0', '0', '0', '0') ,'0');
		} else if (subOpCode == 2) {
			// subtract
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'2', '0', '0', '0', '0', '0', '0', '0') ,'0');
		} else if (subOpCode == 3) {
			// divide
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'3', '0', '0', '0', '0', '0', '0', '0') ,'0');
		} else {
			// add immediate
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '1', '0', '0', '0', '0', '0', '0') ,'0');
		}

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 2) {
		// comparisons
		subOpCode = (insn >> 7) & 3;

		if (subOpCode == 0) {
			// signed comparison
			result = regInputMux(theMachineState, ALUMux(insn, RS(theMachineState, '2'), 
					RT(theMachineState, '0'),'0', '0', '0', '0', '0', '0', '0', '4'), '0');
		} else if (subOpCode == 1) {
			// unsigned comparison
			result = regInputMux(theMachineState, ALUMux(insn, RS(theMachineState, '2'), 
					RT(theMachineState, '0'),'0', '0', '0', '0', '0', '0', '1', '4'), '0');
		} else if (subOpCode == 2) {
			// signed immediate comparison
			result = regInputMux(theMachineState, ALUMux(insn, RS(theMachineState, '2'), 
					0,'0', '0', '0', '0', '0', '0', '2', '4'), '0');
		} else {
			// unsigned immediate comparison
			result = regInputMux(theMachineState, ALUMux(insn, RS(theMachineState, '2'), 
					0,'0', '0', '0', '0', '0', '0', '3', '4'), '0');
		}

		// update nzp
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 4) {
		// jump to subroutine
		subOpCode = (insn >> 11) & 1;

		if (subOpCode == 0) {
			// JSRR
			rd = regInputMux(theMachineState, 0, '2');
			theMachineState->PC = PCMux(theMachineState, RS(theMachineState, '0'), '3');
			theMachineState->R[7] = rd;
		} else {
			// JSR
			theMachineState->R[7] = regInputMux(theMachineState, 0, '2');
			theMachineState->PC = PCMux(theMachineState, 0, '5');
		}

	} else if (opCode == 5) {
		// logical operations
		subOpCode = (insn >> 3) & 7;
		rd = (insn >> 9) & 7;

		if (subOpCode == 0) {
			// and
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'0', '0', '0', '0', '0', '0', '0', '1') ,'0');
		} else if (subOpCode == 1) {
			// not
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '0', '1', '0', '0', '0', '0', '1') ,'0');
		} else if (subOpCode == 2) {
			// or
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'0', '0', '2', '0', '0', '0', '0', '1') ,'0');
		} else if (subOpCode == 3) {
			// xor
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'0', '0', '3', '0', '0', '0', '0', '1') ,'0');
		} else {
			// and immediate
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '0', '0', '1', '0', '0', '0', '1') ,'0');
		}

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 6) {
		// load

		rd = (insn >> 9) & 7;

		result = ALUMux(insn, RS(theMachineState, '0'), 0,
						'0', '2', '0', '0', '0', '0', '0', '0');

		if ((unsigned short int) result < 0x2000 || 
			(((unsigned short int) result >= 0x8000 && (unsigned short int) result < 0xA000))) {
			// attempting to read code as data
			return 2;
		} else if ((unsigned short int) result >= 0xA000 && 
			(theMachineState->PSR >> 15) == 0) {
			// attempting to read OS data without privelege bit
			return 3;
		}

		theMachineState->R[rd] = regInputMux(theMachineState,
								result,'1');

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 7) {
		// store
		result = regInputMux(theMachineState,
					ALUMux(insn, RS(theMachineState, '0'), 0,
					'0', '2', '0', '0', '0', '0', '0', '0'),'0');

		if ((unsigned short int) result < 0x2000 || 
			(((unsigned short int) result >= 0x8000) && ((unsigned short int) result < 0xA000))) {
			// attempting to write code as data
			return 2;
		} else if ((unsigned short int) result >= 0xA000 && (
			theMachineState->PSR >> 15) == 0) {
			// attempting to write OS data without privelege bit
			return 3;
		}

		theMachineState->memory[(unsigned short int) result] = RT(theMachineState, '1');

		// UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 8) {
		// RTI
		theMachineState->PSR = theMachineState->PSR & 0x7FFF;
		theMachineState->PC = PCMux(theMachineState, RS(theMachineState, '1'), '3');

	} else if (opCode == 9) {
		// constant
		rd = (insn >> 9) & 7;
		theMachineState->R[rd] = regInputMux(theMachineState,
								ALUMux(insn, 0, 0,
								'0', '0', '0', '0', '0', '0', '0', '3') ,'0');

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 10) {
		// shift
		rd = (insn >> 9) & 7;
		subOpCode = (insn >> 4) & 3;

		if (subOpCode == 0) {
			// sll
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '0', '0', '0', '0', '0', '0', '2') ,'0');
		} else if (subOpCode == 1) {
			// sra
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '0', '0', '0', '1', '0', '0', '2') ,'0');
		} else if (subOpCode == 2) {
			// srl
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), 0,
									'0', '0', '0', '0', '2', '0', '0', '2') ,'0');
		} else {
			// mod
			theMachineState->R[rd] = regInputMux(theMachineState,
									ALUMux(insn, RS(theMachineState, '0'), RT(theMachineState, '0'),
									'4', '0', '0', '0', '0', '0', '0', '0') ,'0');
		}

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');
	} else if (opCode == 12) {
		// jump
		subOpCode = (insn >> 11) & 1;

		if (subOpCode) {
			// jmp
			theMachineState->PC = PCMux(theMachineState, 0, '2');
		} else {
			// jmpr
			theMachineState->PC = PCMux(theMachineState, RS(theMachineState, '0'), '3');
		}
	} else if (opCode == 13) {
		// high constant
		rd = (insn >> 9) & 7;
		result = theMachineState->R[rd];
		
		result = regInputMux(theMachineState,
				ALUMux(insn, 0, 0,
				'0', '0', '0', '0', '0', '1', '0', '3') ,'0');

		result = result | (theMachineState->R[rd] & 0x00FF);
		theMachineState->R[rd] = result;

		result = (short int) theMachineState->R[rd];
		UpdateNZP(theMachineState, result);
		theMachineState->PC = PCMux(theMachineState, 0, '1');

	} else if (opCode == 15) {
		// trap
		theMachineState->PSR = theMachineState->PSR | 0x8000;
		theMachineState->R[7] = PCMux(theMachineState, 0, '1');
		theMachineState->PC = PCMux(theMachineState, 0, '4');
	} else {
		return 1;
	}

	return 0;
}


// Compute the current output of the RS port
unsigned short int RS (MachineState *theMachineState, unsigned char rsMux_CTL) {
	// get the instruction
	unsigned short int insn = theMachineState->memory[theMachineState -> PC];

	// shift bits as appropriate and and them
	if (rsMux_CTL == '0') {
		// bits 8, 7, 6
		insn = insn >> 6;
		insn = insn & 7;
	} else if (rsMux_CTL == '1') {
		// register 7
		return theMachineState->R[7];
	} else if (rsMux_CTL == '2') {
		// bits 11, 10, 9
		insn = insn >> 9;
		insn = insn & 7;
	} else {
		// invalid mux input
		exit(1);
	}

	return theMachineState->R[insn];

}


// Compute the current output of the RT port
unsigned short int RT (MachineState *theMachineState, unsigned char rtMux_CTL) {
	// get the instruction
	unsigned short int insn = theMachineState->memory[theMachineState -> PC];

	// shift bits as appropriate and and them
	if (rtMux_CTL == '0') {
		// bits 2, 1, 0
		insn = insn & 7;
	} else if (rtMux_CTL == '1') {
		// bits 11, 10, 9
		insn = insn >> 9;
		insn = insn & 7;
	} else {
		// invalid mux input
		exit(1);
	}

	return theMachineState->R[insn];
}

// Note that the UpdateMachineState function must perform its action using the helper functions
// declared below which should be used to simulate the operation of portions of the datapath.
//
// Note that all of the control signals passed as arguments to these functions are represented
// as unsigned 8 bit values although none of them use more than 3 bits. You should use the lower
// bits of the fields to store the mandated control bits. Please refer to the LC4 information sheets
// on Canvas for an explanation of the control signals and their role in the datapath.


// Compute the current output of the ALUMux
unsigned short int ALUMux (unsigned short int INSN,   // current instruction
			   unsigned short int RSOut,  // current RS port output
			   unsigned short int RTOut,  // current RT port output
			   unsigned char Arith_CTL,
			   unsigned char ArithMux_CTL,
			   unsigned char LOGIC_CTL,
			   unsigned char LogicMux_CTL,
			   unsigned char SHIFT_CTL,
			   unsigned char CONST_CTL,
			   unsigned char CMP_CTL,
			   unsigned char ALUMux_CTL) {

	unsigned short int arith_in, logic_in, msb, result;
	short int imm;

	if (ALUMux_CTL == '0') {
		// Arithmetic

		if (ArithMux_CTL == '0') {
			// rt
			arith_in = RTOut;
		} else if (ArithMux_CTL == '1') {
			// imm5
			msb = (INSN >> 4) & 1;
			imm = (short int) (INSN & (0x001F)); 
		
			if (msb) {
				imm = imm + 0xFFE0;
			}

			arith_in = (unsigned short int) imm;
		} else if (ArithMux_CTL == '2') {
			// imm6
			msb = (INSN >> 5) & 1;
			imm = (short int) (INSN & (0x003F)); 
		
			if (msb) {
				imm = imm + 0xFFC0;
			}

			arith_in = (unsigned short int) imm;
		} else {
			exit(1);
		}

		if (Arith_CTL == '0') {
			//add
			result = RSOut + arith_in;
		} else if (Arith_CTL == '1') {
			// multiply
			result = RSOut * arith_in;
		} else if (Arith_CTL == '2') {
			// subtract
			result = RSOut - arith_in;
		} else if (Arith_CTL == '3') {
			// divide
			result = RSOut / arith_in;
		} else if (Arith_CTL == '4') {
			// mod
			result = RSOut % arith_in;
		} else {
			exit(1);
		}

	} else if (ALUMux_CTL == '1') {
		// Logic

		if (LogicMux_CTL == '0') {
			// rt
			logic_in = RTOut;
		} else if (LogicMux_CTL == '1') {
			// imm5	
			msb = (INSN >> 4) & 1;
			imm = (short int) (INSN & (0x001F)); 
		
			if (msb) {
				imm = imm + 0xFFE0;
			}

			logic_in = (unsigned short int) imm;
		} else {
			exit(1);
		}

		if (LOGIC_CTL == '0') {
			// and
			result = RSOut & logic_in;
		} else if (LOGIC_CTL == '1') {
			// not 
			result = ~RSOut;
		} else if (LOGIC_CTL == '2') {
			// or
			result = RSOut | logic_in;
		} else if (LOGIC_CTL == '3') {
			// xor
			result = RSOut ^ logic_in;
		} else {
			exit(1);
		}
	} else if (ALUMux_CTL == '2') {
		// Shift

		if (SHIFT_CTL == '0') {
			// SLL
			result = RSOut << (INSN & 0x000F);
		} else if (SHIFT_CTL == '1') {
			// SRA

			msb = RSOut >> 15;
			// if uppermost bit is a one, 
			// shift by 1 and add uppermost 1 IMM4 times
			if (msb) {
				result = RSOut;
				for (imm = (INSN & 0x000F); imm > 0; imm--) {
					result = result >> 1;
					result = result | 0x8000;
				}
			} else {
				result = RSOut >> (INSN & 0x000F);
			}

		} else if (SHIFT_CTL == '2') {
			// SRL
			result = RSOut >> (INSN & 0x000F);
		} else {
			exit(1);
		}
	} else if (ALUMux_CTL == '3') {
		// Constant

		if (CONST_CTL == '0') {
			// lower bits
			// imm9
			msb = (INSN >> 8) & 1;
			
			if (msb) {
				result = (INSN & 0x01FF) + 0xFE00;
			} else {
				result = (INSN & 0x01FF);
			}
		} else {
			// upper bits (hiconst)
			// Rd & 0XFF | UIMM8 << 8
			// clearing lower 8 bits must be handled in call
			result = ((INSN & 0x00FF) << 8);
		}


	} else if (ALUMux_CTL == '4') {
		// Comparator

		if (CMP_CTL == '0') {
			// signed rs - rt
			if ((short int) RSOut > (short int) RTOut) {
				return 1;
			} else if ((short int) RSOut < (short int) RTOut) {
				return -1;
			} else {
				return 0;
			}
		} else if (CMP_CTL == '1') {
			// unsigned rs - rt
			if (RSOut > RTOut) {
				return 1;
			} else if (RSOut < RTOut) {
				return -1;
			} else {
				return 0;
			}
		} else if (CMP_CTL == '2') {
			// imm 7
			msb = (INSN >> 6) & 1;

			imm = INSN & 0x007F;
			if (msb) {
				imm = imm + 0xFF80;
			}

			if ((short int) RSOut > imm) {
				return 1;
			} else if ((short int) RSOut < imm) {
				return -1;
			} else {
				return 0;
			}
		} else {
			// uimm7
			imm = INSN & 0x007F;
			if (RSOut > imm) {
				return 1;
			} else if (RSOut < imm) {
				return -1;
			} else {
				return 0;
			}
		} 
	} else {
		exit(1);
	}

	return result;
}

// Compute the current output of the regInputMux
unsigned short int regInputMux (MachineState *theMachineState,
				unsigned short int ALUMuxOut, // current ALUMux output
				unsigned char regInputMux_CTL){

	if (regInputMux_CTL == '0') {
		return ALUMuxOut;
	} else if (regInputMux_CTL == '1') {
		return theMachineState->memory[ALUMuxOut];
	} else if (regInputMux_CTL == '2') {
		return (theMachineState->PC + 1);
	} else {
		exit(1);
	}
}

// Compute the current output of the PCMux
unsigned short int PCMux (MachineState *theMachineState,
			  unsigned short int RSOut,
			  unsigned char PCMux_CTL) {

	unsigned short int insn = theMachineState->memory[theMachineState -> PC];
	unsigned short int newPC = theMachineState->PC;
	unsigned short int nzpTest;
	unsigned short int msb;
	// for immediate statements
	short int imm;

	if (PCMux_CTL == '0') {
		// nzp test
		nzpTest = (insn >> 9) & 7;
		nzpTest = nzpTest & theMachineState->PSR;
		if (nzpTest) {
			// success: increment and add imm9
			newPC++;
			msb = (insn >> 8) & 1;
			imm = (short int) insn & (0x01FF);

			if (msb) {
				imm = imm + 0xFE00;
			}

			newPC += imm;
		} else {
			// fail: continue
			newPC++;
		}
	} else if (PCMux_CTL == '1') {
		newPC++;
	} else if (PCMux_CTL == '2') {
		// increment plus sign extend 11
		newPC++;
		msb = (insn >> 10) & 1;
		imm = (short int) insn & (0x07FF); 
		
		if (msb) {
			imm = imm + 0xF800;
		}

		newPC += imm;
	} else if (PCMux_CTL == '3') {
		// RS
		newPC = RSOut;
	} else if (PCMux_CTL == '4') {
		// 0x8000 | UIMM8
		newPC = 0x8000 | (insn & (0x00FF)); 
	} else {
		// (PCMux_CTL == '5')
		// PC & 0x8000 | IMM11 << 4
		newPC = newPC & 0x8000;
		msb = (insn >> 10) & 1;
		imm = (short int) (insn & (0x07FF)); 

		if (msb) {
			imm = imm + 0xF800;
		}

		imm = imm << 4;

		newPC = newPC | imm;
	} 

	return newPC;
}
