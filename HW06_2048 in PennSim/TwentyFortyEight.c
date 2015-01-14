/*
 * TwentyFortyEight.c : Camillo J. Taylor - Sept. 23, 2014
 */

#include "lc4libc.h"


/*
 * #############  DATA STRUCTURES THAT STORE THE GAME STATE ######################
 */

// The game state is encoded in this 4x4 array where tile[0][0] corresponds to the upper left tile, tile[0][1] is the tile
// immediately to its right and tile[1][0] is the tile immediately below etc. etc. The legal entries are 0, 2, 4, 8, 16 etc
// where 0 corresponds to an empty spot.

int tile[4][4];

int score;


lc4uint color[12];

/*
 * #############  HELPER FUNCTIONS ######################
 */


//
// routine for printing out 2C 16 bit numbers in LC4
//
void printnum (int n) {
  int abs_n;
  char str[10], *ptr;

  // Corner case (n == 0)
  if (n == 0) {
    lc4_puts ((lc4uint*)"0");
    return;
  }
 
  abs_n = (n < 0) ? -n : n;

  // Corner case (n == -32768) no corresponding +ve value
  if (abs_n < 0) {
    lc4_puts ((lc4uint*)"-32768");
    return;
  }

  ptr = str + 10; // beyond last character in string

  *(--ptr) = 0; // null termination

  while (abs_n) {
    *(--ptr) = (abs_n % 10) + 48; // generate ascii code for digit
    abs_n /= 10;
  }

  // Handle -ve numbers by adding - sign
  if (n < 0) *(--ptr) = '-';

  lc4_puts((lc4uint*)ptr);
}

void endl () {
  lc4_puts((lc4uint*)"\n");
}

// rand16 returns a pseudo-random number between 0 and 15 by simulating the action of a 16 bit Linear Feedback Shift Register.
int rand16 ()
{
  int lfsr;

  // Advance the lfsr four times
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();

  // return the last 4 bits
  return (lfsr & 0xF);
}

/*
 * #############  CODE THAT DRAWS THE SCENE ######################
 */

// COLOR_2 : BLUE - 0 00000 00000 11111
#define COLOR_2       0x001FU

// COLOR_2 : GREEN - 0 000001 1 111 0 0000
#define COLOR_4       0x03E0U

// COLOR_8 :      - 0 00000 11 111 1 1111
#define COLOR_8       0x03FFU

// COLOR_16 :      - 0 111 11 11 111 0 0000 
#define COLOR_16      0x7FE0U

// COLOR_32 :      - 0 111 11 00 000 1 1111
#define COLOR_32      0x7C1FU

// COLOR_64 :      - 0 111 11 00 000 1 0000
#define COLOR_64      0x07C10U

// COLOR_128 :      - 0 100 00 00 000 1 1111
#define COLOR_128     0x401FU

// COLOR_256 :      - 0 111 11 10 000 1 1111
#define COLOR_256     0x7E1FU

// COLOR_512 :      - 0 100 00 00 000 1 1111
#define COLOR_512     0x401FU

// COLOR_1024 :    - 0 111 11 10 000 0 0000
#define COLOR_1024    0x7E00U

// COLOR_2048 : RED - 0 11111 00000 00000
#define COLOR_2048    0x7C00U

// define constants for number drawing

// COLOR_BLACK : BLACK - 0 00000 00000 00000
#define COLOR_BLACK	0x0000U

// SEVSEG_0
#define SEVSEG_0 	0x0077U

// SEVSEG_1
#define SEVSEG_1 	0x0024U

// SEVSEG_2
#define SEVSEG_2	0x005DU

// SEVSEG_3
#define SEVSEG_3	0x006DU

// SEVSEG_4
#define SEVSEG_4	0x002EU

// SEVSEG_5
#define SEVSEG_5	0x006BU

// SEVSEG_6
#define SEVSEG_6	0x007BU

// SEVSEG_7
#define SEVSEG_7	0x0025U

// SEVSEG_8
#define SEVSEG_8	0x007FU

// SEVSEG_9
#define SEVSEG_9	0x002FU

// draw the specific number
void drawNumber (int cornerX, int cornerY, int number) {
	lc4uint x = (lc4uint) cornerX;
	lc4uint y = (lc4uint) cornerY;
	
	x = x + 1;
	y = y + 9;
	
	if (number == 2) {
		x = x + 9;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
	} else if (number == 4) {
		x = x + 9;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_4);
	} else if (number == 8) {
		x = x + 9;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_8);
	} else if (number == 16) {
		x = x + 5;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_1);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_6);
	} else if (number == 32) {
		x = x + 5;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_3);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
	} else if (number == 64) {
		x = x + 5;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_6);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_4);
	} else if (number == 128) {
		x = x + 2;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_1);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_8);
	} else if (number == 256) {
		x = x + 2;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_5);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_6);
	} else if (number == 512) {
		x = x + 2;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_5);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_1);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
	} else if (number == 1024) {
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_1);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_0);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_4);
	} else if (number == 2048) {
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_2);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_0);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_4);
		x = x + 7;
		lc4_draw_seven_seg(x,  y, BLACK, SEVSEG_8);
	}
}

void drawTiles () {
  
	/// YOUR CODE HERE

	int x = 2;
	int y = 2;
	int i, j;
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			int val = tile[i][j];
			int val2 = val;
			int pow = 0;
			
			// power of two determines color of square
			while (val > 1) {
				val = val / 2;
				pow++;
			}
			
			// draw square
			if (val != 0) {
				lc4_draw_rect(x, y, 29, 29, color[pow]);
				drawNumber(x, y, val2);
			}
			
			// increment square column
			x = x + 31;
		}
		// reset square column
		x = 2;
		// increment square row
		y = y + 31;
	}

}

void redraw ()
{
  // This function assumes that PennSim is being run in double buffered mode
  // In this mode we first clear the video memory buffer with lc4_reset_vmem,
  // then draw the scene, then call lc4_blt_vmem to swap the buffer to the screen
  // NOTE that you need to run PennSim with the following command:
  // java -jar PennSim.jar -d

  lc4_reset_vmem();

  drawTiles ();

  lc4_blt_vmem();
}

/*
 * #############  CODE THAT HANDLES GAME PLAY ######################
 */
 // ascii keycodes
#define KEY_i		0x0069U
#define KEY_j		0x006AU
#define KEY_k		0x006BU
#define KEY_l		0x006CU
#define KEY_q		0x0071U

// tile spawning
void spawn_tile() {
	int index = rand16();
	int val = rand16();
	//randomly select available index
	while (tile[index / 4][index % 4] != 0) {
		index = rand16();
	}
	
	//randomly select 2 or 4 for new tile
	if (val >= 2) {
		tile[index / 4][index % 4] = 2;
		score += 2;
	} else { 
		tile[index / 4][index % 4] = 4;
		score += 4;
	}
	
	//print score
	lc4_puts ((lc4uint*)"Score: ");
	printnum(score);
	lc4_puts ((lc4uint*)"\n");
}


void reset_game_state ()
{

  /// YOUR CODE HERE
  //	put color values into array for redrawing
	color[0] = BLACK;
	color[1] = COLOR_2;
	color[2] = COLOR_4;
	color[3] = COLOR_8;
	color[4] = COLOR_16;
	color[5] = COLOR_32;
	color[6] = COLOR_64;
	color[7] = COLOR_128;
	color[8] = COLOR_256;
	color[9] = COLOR_512;
	color[10] = COLOR_1024;
	color[11] = COLOR_2048;
	score = 0;
	
	tile[0][0] = 0;
	tile[0][1] = 0;
	tile[0][2] = 0;
	tile[0][3] = 0;
	tile[1][0] = 0;
	tile[1][1] = 0;
	tile[1][2] = 0;
	tile[1][3] = 0;
	tile[2][0] = 0;
	tile[2][1] = 0;
	tile[2][2] = 0;
	tile[2][3] = 0;
	tile[3][0] = 0;
	tile[3][1] = 0;
	tile[3][2] = 0;
	tile[3][3] = 0;
	
	spawn_tile();
	spawn_tile();
	
}

// routine to rotate tile canvas for simplifying merge
void rotateTiles (int arr[4][4]) 
{
	int temp[4][4];
	int x, y;
	for (y = 0; y < 4; y++) {
		for (x = 0; x < 4; x++) {
			temp[y][x] = arr[x][3 - y];
		}
	}
	
	for (y = 0; y < 4; y++) {
		for (x = 0; x < 4; x++) {
			arr[y][x] = temp[y][x];
		}
	}
}


// basic routine to merge four tile values
void mergeTiles (int *a)
{

  /// YOUR CODE HERE
	int i;
	//boolean value for edge cases
	int justMerged = 0;
	
	for (i = 1; i < 4; i++) {
		// for every nonzero number in the row
		if (a[i] != 0) {
			int j = i - 1;
			// find previous index with nonzero content or index 0
			while (j > 0 && a[j] == 0) {
				j--;
			}

			// if it's a zero, move the value there
			if (a[j] == 0) {
				a[j] = a[i];
				a[i] = 0;
			} else if (a[j] == a[i]) {
				// if it is equal but just merged, make adjacent
				// if it is equal and did not just merge, combine
				if (justMerged) {
					int t = a[i];
					a[i] = 0;
					a[j + 1] = t;
					justMerged = 0;
				} else {
					a[j] = 2 * a[i];
					a[i] = 0;
					justMerged = 1;
				}
			} else {
				// if it is not equal, make adjacent
				int t = a[i];
				a[i] = 0;
				a[j + 1] = t;
				justMerged = 0;
			}
		}
	}
}

typedef enum {SAME, DIFFERENT, FULL, WIN} StateType;

// helper, compare array before and after changes and return enum
//StateType check_game_state (int old[4][4], int current[4][4]) {
StateType check_game_state (int *old, int *current) {
	// return 1 if there is a difference
	StateType state = SAME;
	int remainingspace = 16;
	int i, j;
	int o, n;
	for (i = 0; i < 16; i++) {
		//for (j = 0; j < 4; j++) {
		o = old[i];
		n = current[i];
		if (o != n) {
			state = DIFFERENT;
		}
		if (n != 0) {
			remainingspace--;
		}
		if (n == 2048) {
			// precedence: winning condition
			return WIN;
		}
		//}
	}
	if (remainingspace == 1) {
		//for checking failure state:
		//last space will be filled by a number and it will test shift
		return FULL;
	}
	return state;
}


void shift_up (int arr[4][4])  {
	int i;
	rotateTiles(arr);
	for (i = 0; i < 4; i++) {
		mergeTiles(&arr[i][0]);
	}
	rotateTiles(arr);
	rotateTiles(arr);
	rotateTiles(arr);
}

void shift_left (int arr[4][4])  {
	int i;
	for (i = 0; i < 4; i++) {
		mergeTiles(&arr[i][0]);
	}
}

void shift_down (int arr[4][4])  {
	int i;
	rotateTiles(arr);
	rotateTiles(arr);
	rotateTiles(arr);
	for (i = 0; i < 4; i++) {
		mergeTiles(&arr[i][0]);
	}
	rotateTiles(arr);
}

void shift_right (int arr[4][4])  {
	int i;
	rotateTiles(arr);
	rotateTiles(arr);
	for (i = 0; i < 4; i++) {
		mergeTiles(&arr[i][0]);
	}
	rotateTiles(arr);
	rotateTiles(arr);
}

void update_game_state (lc4uint key)
{
  /// YOUR CODE HERE
  
	// copy the current array to check for differences
	StateType current_state = SAME;
	StateType fail_state = DIFFERENT;
	int i, j;
	int state[4][4];
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			state[i][j] = tile[i][j];
		}
	}
	
	
	if (key == KEY_i) {
		shift_up(tile);
		current_state = check_game_state(&state[0][0], &tile[0][0]);
	} else if (key == KEY_j) {
		shift_left(tile);
		current_state = check_game_state(&state[0][0], &tile[0][0]);
	} else if (key == KEY_k) {
		shift_down(tile);
		current_state = check_game_state(&state[0][0], &tile[0][0]);
	} else if (key == KEY_l) {
		shift_right(tile);
		current_state = check_game_state(&state[0][0], &tile[0][0]);
	} else if (key == KEY_q) {
		reset_game_state();
	}
	if (current_state == DIFFERENT) {
		spawn_tile();
		
	} else if (current_state == WIN) {
		lc4_puts ((lc4uint*)"Congratulations! You reached 2048\n");
		lc4_puts ((lc4uint*)"Your final score is: ");
		printnum(score);
		lc4_puts ((lc4uint*)"\nPress q to restart\n");
		
	} else if (current_state == FULL) {
		//if the tiles have one remaining space, fill it
		spawn_tile();
		
		for (i = 0; i < 4; i++) {
			for (j = 0; j < 4; j++) {
				state[i][j] = tile[i][j];
			}
		}
		//try shifting copied array sideways and vertically
		
		
		shift_down(state);
		fail_state = check_game_state(&tile[0][0], &state[0][0]);
		if (fail_state == SAME) {
			shift_left(state);
			fail_state = check_game_state(&tile[0][0], &state[0][0]);
		}
		
		// if its the same, you lose
		
		if (fail_state == SAME) {
			lc4_puts ((lc4uint*)"Game Over! No more possible moves.\n");
			lc4_puts ((lc4uint*)"Your final score is: ");
			printnum(score);
			lc4_puts ((lc4uint*)"\nPress q to restart\n");
		}
	}
}

/*
 * #############  MAIN PROGRAM ######################
 */

int main ()
{
  lc4uint key;

  lc4_puts ((lc4uint*)"!!! Welcome to 2048 !!!\n");
  lc4_puts ((lc4uint*)"Press i to slide up\n");
  lc4_puts ((lc4uint*)"Press k to slide down\n");
  lc4_puts ((lc4uint*)"Press j to slide left\n");
  lc4_puts ((lc4uint*)"Press l to slide right\n");
  lc4_puts ((lc4uint*)"Press q to reset\n");

  reset_game_state();

  redraw ();

  while (1) {
    key = lc4_wait_for_char();

    lc4_puts ((lc4uint*)"Got a keystroke\n");

    update_game_state(key);

    redraw ();
  }

  return 0;
}
