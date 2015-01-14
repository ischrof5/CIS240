;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L2_TwentyFortyEight
	LEA R7, L4_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_TwentyFortyEight
L2_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L6_TwentyFortyEight
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L7_TwentyFortyEight
L6_TwentyFortyEight
	LDR R7, R5, #3
	STR R7, R5, #-13
L7_TwentyFortyEight
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L8_TwentyFortyEight
	LEA R7, L10_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_TwentyFortyEight
L8_TwentyFortyEight
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L12_TwentyFortyEight
L11_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L12_TwentyFortyEight
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L11_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L14_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L14_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L1_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L17_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L16_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	AND R7, R7, #15
L18_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;drawNumber;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
drawNumber
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	STR R7, R5, #-1
	LDR R7, R5, #4
	STR R7, R5, #-2
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-2
	ADD R7, R7, #9
	STR R7, R5, #-2
	LDR R7, R5, #5
	CONST R3, #2
	CMP R7, R3
	BRnp L20_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #9
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L21_TwentyFortyEight
L20_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #4
	CMP R7, R3
	BRnp L22_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #9
	STR R7, R5, #-1
	CONST R7, #46
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L23_TwentyFortyEight
L22_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #8
	CMP R7, R3
	BRnp L24_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #9
	STR R7, R5, #-1
	CONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L25_TwentyFortyEight
L24_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #16
	CMP R7, R3
	BRnp L26_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #5
	STR R7, R5, #-1
	CONST R7, #36
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #123
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L27_TwentyFortyEight
L26_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #32
	CMP R7, R3
	BRnp L28_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #5
	STR R7, R5, #-1
	CONST R7, #109
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L29_TwentyFortyEight
L28_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #64
	CMP R7, R3
	BRnp L30_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #5
	STR R7, R5, #-1
	CONST R7, #123
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #46
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L31_TwentyFortyEight
L30_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #128
	CMP R7, R3
	BRnp L32_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #2
	STR R7, R5, #-1
	CONST R7, #36
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L33_TwentyFortyEight
L32_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #0
	HICONST R3, #1
	CMP R7, R3
	BRnp L34_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #2
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #107
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #123
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L35_TwentyFortyEight
L34_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #0
	HICONST R3, #2
	CMP R7, R3
	BRnp L36_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #2
	STR R7, R5, #-1
	CONST R7, #107
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #36
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L37_TwentyFortyEight
L36_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #0
	HICONST R3, #4
	CMP R7, R3
	BRnp L38_TwentyFortyEight
	CONST R7, #36
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #119
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #46
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	JMP L39_TwentyFortyEight
L38_TwentyFortyEight
	LDR R7, R5, #5
	CONST R3, #0
	HICONST R3, #8
	CMP R7, R3
	BRnp L40_TwentyFortyEight
	CONST R7, #93
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #119
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #46
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-1
	ADD R7, R7, #7
	STR R7, R5, #-1
	CONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_seven_seg
	ADD R6, R6, #4	;; free space for arguments
L40_TwentyFortyEight
L39_TwentyFortyEight
L37_TwentyFortyEight
L35_TwentyFortyEight
L33_TwentyFortyEight
L31_TwentyFortyEight
L29_TwentyFortyEight
L27_TwentyFortyEight
L25_TwentyFortyEight
L23_TwentyFortyEight
L21_TwentyFortyEight
L19_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;drawTiles;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
drawTiles
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-7	;; allocate stack space for local variables
	;; function body
	CONST R7, #2
	STR R7, R5, #-1
	CONST R7, #2
	STR R7, R5, #-3
	CONST R7, #0
	STR R7, R5, #-4
L43_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-2
L47_TwentyFortyEight
	LDR R7, R5, #-2
	LDR R3, R5, #-4
	SLL R3, R3, #2
	LEA R2, tile
	ADD R3, R3, R2
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R5, #-5
	LDR R7, R5, #-5
	STR R7, R5, #-7
	CONST R7, #0
	STR R7, R5, #-6
	JMP L52_TwentyFortyEight
L51_TwentyFortyEight
	LDR R7, R5, #-5
	CONST R3, #2
	DIV R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #-6
	ADD R7, R7, #1
	STR R7, R5, #-6
L52_TwentyFortyEight
	LDR R7, R5, #-5
	CONST R3, #1
	CMP R7, R3
	BRp L51_TwentyFortyEight
	LDR R7, R5, #-5
	CONST R3, #0
	CMP R7, R3
	BRz L54_TwentyFortyEight
	LDR R7, R5, #-6
	LEA R3, color
	ADD R7, R7, R3
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #29
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #-7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR drawNumber
	ADD R6, R6, #3	;; free space for arguments
L54_TwentyFortyEight
	LDR R7, R5, #-1
	CONST R3, #31
	ADD R7, R7, R3
	STR R7, R5, #-1
L48_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRn L47_TwentyFortyEight
	CONST R7, #2
	STR R7, R5, #-1
	LDR R7, R5, #-3
	CONST R3, #31
	ADD R7, R7, R3
	STR R7, R5, #-3
L44_TwentyFortyEight
	LDR R7, R5, #-4
	ADD R7, R7, #1
	STR R7, R5, #-4
	LDR R7, R5, #-4
	CONST R3, #4
	CMP R7, R3
	BRn L43_TwentyFortyEight
L42_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR drawTiles
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L56_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_tile;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_tile
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-2
	JMP L59_TwentyFortyEight
L58_TwentyFortyEight
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
L59_TwentyFortyEight
	LDR R7, R5, #-1
	CONST R3, #4
	MOD R2, R7, R3
	DIV R7, R7, R3
	SLL R7, R7, #2
	LEA R3, tile
	ADD R7, R7, R3
	ADD R7, R2, R7
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L58_TwentyFortyEight
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRn L61_TwentyFortyEight
	LDR R7, R5, #-1
	CONST R3, #4
	CONST R2, #2
	MOD R1, R7, R3
	DIV R7, R7, R3
	SLL R7, R7, #2
	LEA R3, tile
	ADD R7, R7, R3
	ADD R7, R1, R7
	STR R2, R7, #0
	LEA R7, score
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	JMP L62_TwentyFortyEight
L61_TwentyFortyEight
	LDR R7, R5, #-1
	CONST R3, #4
	MOD R2, R7, R3
	DIV R7, R7, R3
	SLL R7, R7, #2
	LEA R1, tile
	ADD R7, R7, R1
	ADD R7, R2, R7
	STR R3, R7, #0
	LEA R7, score
	LDR R3, R7, #0
	ADD R3, R3, #4
	STR R3, R7, #0
L62_TwentyFortyEight
	LEA R7, L63_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, score
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L64_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L57_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, color
	CONST R3, #0
	STR R3, R7, #0
	CONST R3, #31
	STR R3, R7, #1
	LEA R7, color
	CONST R3, #224
	HICONST R3, #3
	STR R3, R7, #2
	LEA R7, color
	CONST R3, #255
	HICONST R3, #3
	STR R3, R7, #3
	LEA R7, color
	CONST R3, #224
	HICONST R3, #127
	STR R3, R7, #4
	LEA R7, color
	CONST R3, #31
	HICONST R3, #124
	STR R3, R7, #5
	LEA R7, color
	CONST R3, #16
	HICONST R3, #124
	STR R3, R7, #6
	LEA R7, color
	CONST R3, #31
	HICONST R3, #64
	STR R3, R7, #7
	LEA R7, color
	CONST R3, #31
	HICONST R3, #126
	STR R3, R7, #8
	LEA R7, color
	CONST R3, #31
	HICONST R3, #64
	STR R3, R7, #9
	LEA R7, color
	CONST R3, #0
	HICONST R3, #126
	STR R3, R7, #10
	LEA R7, color
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #11
	CONST R7, #0
	LEA R3, score
	STR R7, R3, #0
	LEA R3, tile
	STR R7, R3, #0
	STR R7, R3, #1
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #2
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #3
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #4
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #5
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #6
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #7
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #8
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #9
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #10
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #11
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #12
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #13
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #14
	LEA R7, tile
	CONST R3, #0
	STR R3, R7, #15
	JSR spawn_tile
	ADD R6, R6, #0	;; free space for arguments
	JSR spawn_tile
	ADD R6, R6, #0	;; free space for arguments
L65_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rotateTiles;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rotateTiles
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	CONST R7, #18
	SUB R6, R6, R7	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
L67_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-1
L71_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	SLL R2, R3, #2
	ADD R1, R5, #-16
	ADD R1, R1, #-2
	ADD R2, R2, R1
	ADD R2, R7, R2
	CONST R1, #3
	SUB R3, R1, R3
	SLL R7, R7, #2
	LDR R1, R5, #3
	ADD R7, R7, R1
	ADD R7, R3, R7
	LDR R7, R7, #0
	STR R7, R2, #0
L72_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L71_TwentyFortyEight
L68_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRn L67_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-2
L75_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-1
L79_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	SLL R3, R3, #2
	LDR R2, R5, #3
	ADD R2, R3, R2
	ADD R2, R7, R2
	ADD R1, R5, #-16
	ADD R1, R1, #-2
	ADD R3, R3, R1
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
L80_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L79_TwentyFortyEight
L76_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRn L75_TwentyFortyEight
L66_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;mergeTiles;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
mergeTiles
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	CONST R7, #1
	STR R7, R5, #-1
L84_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L88_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #-1
	STR R7, R5, #-3
	JMP L91_TwentyFortyEight
L90_TwentyFortyEight
	LDR R7, R5, #-3
	ADD R7, R7, #-1
	STR R7, R5, #-3
L91_TwentyFortyEight
	LDR R7, R5, #-3
	STR R7, R5, #-4
	CONST R3, #0
	CMP R7, R3
	BRnz L93_TwentyFortyEight
	LDR R7, R5, #3
	LDR R2, R5, #-4
	ADD R7, R2, R7
	LDR R7, R7, #0
	CMP R7, R3
	BRz L90_TwentyFortyEight
L93_TwentyFortyEight
	LDR R7, R5, #-3
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L94_TwentyFortyEight
	LDR R7, R5, #3
	LDR R3, R5, #-3
	ADD R3, R3, R7
	LDR R2, R5, #-1
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R3, #0
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	JMP L95_TwentyFortyEight
L94_TwentyFortyEight
	LDR R7, R5, #3
	LDR R3, R5, #-3
	ADD R3, R3, R7
	LDR R3, R3, #0
	LDR R2, R5, #-1
	ADD R7, R2, R7
	LDR R7, R7, #0
	CMP R3, R7
	BRnp L96_TwentyFortyEight
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L98_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R5, #-5
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-3
	ADD R7, R7, #1
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R3, R5, #-5
	STR R3, R7, #0
	CONST R7, #0
	STR R7, R5, #-2
	JMP L97_TwentyFortyEight
L98_TwentyFortyEight
	LDR R7, R5, #3
	LDR R3, R5, #-3
	ADD R3, R3, R7
	LDR R2, R5, #-1
	ADD R7, R2, R7
	LDR R7, R7, #0
	SLL R7, R7, #1
	STR R7, R3, #0
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-2
	JMP L97_TwentyFortyEight
L96_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R5, #-5
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-3
	ADD R7, R7, #1
	LDR R3, R5, #3
	ADD R7, R7, R3
	LDR R3, R5, #-5
	STR R3, R7, #0
	CONST R7, #0
	STR R7, R5, #-2
L97_TwentyFortyEight
L95_TwentyFortyEight
L88_TwentyFortyEight
L85_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L84_TwentyFortyEight
L83_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-4
	CONST R7, #16
	STR R7, R5, #-5
	CONST R7, #0
	STR R7, R5, #-1
L102_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R3, R7, R3
	LDR R3, R3, #0
	STR R3, R5, #-3
	LDR R3, R5, #4
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R5, #-2
	LDR R7, R5, #-3
	LDR R3, R5, #-2
	CMP R7, R3
	BRz L106_TwentyFortyEight
	CONST R7, #1
	STR R7, R5, #-4
L106_TwentyFortyEight
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L108_TwentyFortyEight
	LDR R7, R5, #-5
	ADD R7, R7, #-1
	STR R7, R5, #-5
L108_TwentyFortyEight
	LDR R7, R5, #-2
	CONST R3, #0
	HICONST R3, #8
	CMP R7, R3
	BRnp L110_TwentyFortyEight
	CONST R7, #3
	JMP L101_TwentyFortyEight
L110_TwentyFortyEight
L103_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #16
	CMP R7, R3
	BRn L102_TwentyFortyEight
	LDR R7, R5, #-5
	CONST R3, #1
	CMP R7, R3
	BRnp L112_TwentyFortyEight
	CONST R7, #2
	JMP L101_TwentyFortyEight
L112_TwentyFortyEight
	LDR R7, R5, #-4
L101_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;shift_up;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
shift_up
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L115_TwentyFortyEight
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LDR R3, R5, #3
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR mergeTiles
	ADD R6, R6, #1	;; free space for arguments
L116_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L115_TwentyFortyEight
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
L114_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;shift_left;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
shift_left
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L120_TwentyFortyEight
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LDR R3, R5, #3
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR mergeTiles
	ADD R6, R6, #1	;; free space for arguments
L121_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L120_TwentyFortyEight
L119_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;shift_down;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
shift_down
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L125_TwentyFortyEight
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LDR R3, R5, #3
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR mergeTiles
	ADD R6, R6, #1	;; free space for arguments
L126_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L125_TwentyFortyEight
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
L124_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;shift_right;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
shift_right
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L130_TwentyFortyEight
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LDR R3, R5, #3
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR mergeTiles
	ADD R6, R6, #1	;; free space for arguments
L131_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L130_TwentyFortyEight
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotateTiles
	ADD R6, R6, #1	;; free space for arguments
L129_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	CONST R7, #20
	SUB R6, R6, R7	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-19
	CONST R7, #1
	STR R7, R5, #-20
	CONST R7, #0
	STR R7, R5, #-2
L135_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-1
L139_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	SLL R3, R3, #2
	ADD R2, R5, #-16
	ADD R2, R2, #-2
	ADD R2, R3, R2
	ADD R2, R7, R2
	LEA R1, tile
	ADD R3, R3, R1
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
L140_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L139_TwentyFortyEight
L136_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRn L135_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #105
	CMP R7, R3
	BRnp L143_TwentyFortyEight
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_up
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-19
	JMP L144_TwentyFortyEight
L143_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #106
	CMP R7, R3
	BRnp L145_TwentyFortyEight
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_left
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-19
	JMP L146_TwentyFortyEight
L145_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #107
	CMP R7, R3
	BRnp L147_TwentyFortyEight
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_down
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-19
	JMP L148_TwentyFortyEight
L147_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #108
	CMP R7, R3
	BRnp L149_TwentyFortyEight
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_right
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-19
	JMP L150_TwentyFortyEight
L149_TwentyFortyEight
	LDR R7, R5, #3
	CONST R3, #113
	CMP R7, R3
	BRnp L151_TwentyFortyEight
	JSR reset_game_state
	ADD R6, R6, #0	;; free space for arguments
L151_TwentyFortyEight
L150_TwentyFortyEight
L148_TwentyFortyEight
L146_TwentyFortyEight
L144_TwentyFortyEight
	LDR R7, R5, #-19
	CONST R3, #1
	CMP R7, R3
	BRnp L153_TwentyFortyEight
	JSR spawn_tile
	ADD R6, R6, #0	;; free space for arguments
	JMP L154_TwentyFortyEight
L153_TwentyFortyEight
	LDR R7, R5, #-19
	CONST R3, #3
	CMP R7, R3
	BRnp L155_TwentyFortyEight
	LEA R7, L157_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L158_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, score
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L159_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L156_TwentyFortyEight
L155_TwentyFortyEight
	LDR R7, R5, #-19
	CONST R3, #2
	CMP R7, R3
	BRnp L160_TwentyFortyEight
	JSR spawn_tile
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-2
L162_TwentyFortyEight
	CONST R7, #0
	STR R7, R5, #-1
L166_TwentyFortyEight
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	SLL R3, R3, #2
	ADD R2, R5, #-16
	ADD R2, R2, #-2
	ADD R2, R3, R2
	ADD R2, R7, R2
	LEA R1, tile
	ADD R3, R3, R1
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
L167_TwentyFortyEight
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRn L166_TwentyFortyEight
L163_TwentyFortyEight
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #4
	CMP R7, R3
	BRn L162_TwentyFortyEight
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_down
	ADD R6, R6, #1	;; free space for arguments
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-20
	LDR R7, R5, #-20
	CONST R3, #0
	CMP R7, R3
	BRnp L170_TwentyFortyEight
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR shift_left
	ADD R6, R6, #1	;; free space for arguments
	ADD R7, R5, #-16
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, tile
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #2	;; free space for arguments
	STR R7, R5, #-20
L170_TwentyFortyEight
	LDR R7, R5, #-20
	CONST R3, #0
	CMP R7, R3
	BRnp L172_TwentyFortyEight
	LEA R7, L174_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L175_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, score
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L176_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L172_TwentyFortyEight
L160_TwentyFortyEight
L156_TwentyFortyEight
L154_TwentyFortyEight
L134_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, L178_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L179_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L180_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L181_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L182_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L183_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR reset_game_state
	ADD R6, R6, #0	;; free space for arguments
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	JMP L185_TwentyFortyEight
L184_TwentyFortyEight
	JSR lc4_wait_for_char
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LEA R7, L187_TwentyFortyEight
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR update_game_state
	ADD R6, R6, #1	;; free space for arguments
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
L185_TwentyFortyEight
	JMP L184_TwentyFortyEight
	CONST R7, #0
L177_TwentyFortyEight
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
color 		.BLKW 12
		.DATA
score 		.BLKW 1
		.DATA
tile 		.BLKW 16
		.DATA
L187_TwentyFortyEight 		.STRINGZ "Got a keystroke\n"
		.DATA
L183_TwentyFortyEight 		.STRINGZ "Press q to reset\n"
		.DATA
L182_TwentyFortyEight 		.STRINGZ "Press l to slide right\n"
		.DATA
L181_TwentyFortyEight 		.STRINGZ "Press j to slide left\n"
		.DATA
L180_TwentyFortyEight 		.STRINGZ "Press k to slide down\n"
		.DATA
L179_TwentyFortyEight 		.STRINGZ "Press i to slide up\n"
		.DATA
L178_TwentyFortyEight 		.STRINGZ "!!! Welcome to 2048 !!!\n"
		.DATA
L176_TwentyFortyEight 		.STRINGZ "\nPress q to restart\n"
		.DATA
L175_TwentyFortyEight 		.STRINGZ "Your final score is: "
		.DATA
L174_TwentyFortyEight 		.STRINGZ "Game Over! No more possible moves.\n"
		.DATA
L159_TwentyFortyEight 		.STRINGZ "\nPress q to restart\n"
		.DATA
L158_TwentyFortyEight 		.STRINGZ "Your final score is: "
		.DATA
L157_TwentyFortyEight 		.STRINGZ "Congratulations! You reached 2048\n"
		.DATA
L64_TwentyFortyEight 		.STRINGZ "\n"
		.DATA
L63_TwentyFortyEight 		.STRINGZ "Score: "
		.DATA
L17_TwentyFortyEight 		.STRINGZ "\n"
		.DATA
L10_TwentyFortyEight 		.STRINGZ "-32768"
		.DATA
L4_TwentyFortyEight 		.STRINGZ "0"
