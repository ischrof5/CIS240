/*
 * lc4libc.h
 */

typedef int lc4int; 
typedef unsigned int lc4uint;
typedef char lc4char;

#define TRUE  1
#define FALSE 0

#define NULL (void*)0

#define BLACK  0x0000U
#define WHITE  0xFFFFU

lc4int lc4_wait_for_char();
void lc4_puts(lc4uint *str);
void lc4_draw_rect(lc4int x, lc4int y, lc4int width, lc4int height, lc4uint color);
void lc4_draw_seven_seg(lc4int x, lc4int y, lc4uint color, lc4uint code);

void lc4_halt();
void lc4_reset_vmem();
void lc4_blt_vmem();

lc4uint lc4_lfsr();
