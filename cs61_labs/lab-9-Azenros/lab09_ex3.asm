s;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 9
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================
.ORIG x3000
;Initialize Registers
LD R4, STACK_ARR_PTR
ADD R5, R4, #5
ADD R6, R4, #0
AND R2, R2, #0

INPUT_LOOP
  LEA R0, INTRO_1
  PUTS
  GETC
  OUT
  ADD R2, R2, #1
  LD R3, STAR_CHECK
  ADD R1, R0, R3
  BRz AFTER_INPUT
  
  LD R3, NINE_TEST
  ADD R1, R0, R3
  BRp INVALID_INPUT
  
  LD R3, ZERO_TEST
  ADD R1, R0, R3
  BRn INVALID_INPUT
  
  ADD R1, R2, #-5
  BRp INVALID_INPUT
  
  LD R1, SUB_3300
  JSRR R1
  LD R0, NEWLINE
  OUT
  BRp INPUT_LOOP
  
AFTER_INPUT
  ADD R2, R2, #-2
  BRnz INVALID_INPUT
  LD R0, SUB_3200
  JSRR R0
  LDR R0, R6, #0
  LD R3, ZERO_TEST
  ADD R1, R0, R3
  LD R3, SUB_4300
  JSRR R3
  LD R0, NEWLINE
  OUT
  BR INPUT_LOOP

INVALID_INPUT
  LEA R0, INVALID
  PUTS
  ADD R2, R2, #-1
  BR INPUT_LOOP
  
HALT

SUB_3200 .FILL x3200 ;SUB_RPN_MULTIPLY
SUB_3300 .FILL x3300 ;SUB_PUSH
SUB_3600 .FILL x3600 ;SUB_POP
SUB_4300 .FILL x4300 ;SUB_PRINT

STACK_ARR_PTR .FILL xA000
ZERO_TEST .FILL #-48
NINE_TEST .FILL #-57
INTRO_1 .STRINGZ "Enter a single digit number or '*': "
INVALID .STRINGZ "INVALID INPUT\n"
NEWLINE .FILL '\n'
STAR_CHECK .FILL #-42

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (​ one less than​ the lowest available
;                 address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​ current ​ top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;                multiplied them together, and pushed the resulting value back
;                onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
.ORIG x3200
SUB_RPN_MULTIPLY
  ST R1, R1_3200B
  ST R2, R2_3200B
  ST R3, R3_3200B
  ST R5, R5_3200B
  ST R7, R7_3200B
  
  LD R1, SUB_POP
  JSRR R1
  ADD R2, R0, #0
  JSRR R1
  ADD R3, R0, #0
  
  LD R1, SUB_MUL
  JSRR R1
  LD R1, SUB_PUSH
  JSRR R1
  
END_3200
  LD R1, R1_3200B
  LD R2, R2_3200B
  LD R3, R3_3200B
  LD R5, R5_3200B
  LD R7, R7_3200B
  RET
  
  
;----------------
; Data
;----------------
SUB_PUSH .FILL x3300
SUB_POP  .FILL x3600
SUB_MUL  .FILL x3900

R1_3200B .BLKW #1
R2_3200B .BLKW #1
R3_3200B .BLKW #1
R5_3200B .BLKW #1
R7_3200B .BLKW #1
  
;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (​ one less than​ the lowest available
;                 address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​ current ​ top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
;                If the stack was already full (TOS = MAX), the subroutine has printed an
;                overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3300

SUB_STACK_PUSH
  ST R0, R0_3300B
  ST R1, R1_3300B
  ST R2, R2_3300B
  ST R4, R4_3300B
  ST R5, R5_3300B
  ST R7, R7_3300B
  
  ADD R6, R6, #1
  NOT R5, R5
  ADD R5, R5, #1
  ADD R2, R6, R5
  BRp FULL_STACK
  
  STR R0, R6, #0
  BR END_3300
  
  FULL_STACK
    LEA R0, ERROR_OVERFLOW
    PUTS
    ADD R6, R6, #-1
  
END_3300
  LD R0, R0_3300B
  LD R1, R1_3300B
  LD R2, R2_3300B
  LD R4, R4_3300B
  LD R5, R5_3300B
  LD R7, R7_3300B
  RET

;--------------------
; Subroutine Data
;--------------------
ERROR_OVERFLOW .STRINGZ "ERROR: Tried to call push on a full stack\n"

R0_3300B .BLKW #1
R1_3300B .BLKW #1
R2_3300B .BLKW #1
R4_3300B .BLKW #1
R5_3300B .BLKW #1
R7_3300B .BLKW #1

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (​ one less than​ the lowest available
;                 address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​ current ​ top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;                If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
;               R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3600

SUB_STACK_POP
  ST R1, R1_3600B
  ST R2, R2_3600B
  ST R4, R4_3600B
  ST R5, R5_3600B
  ST R7, R7_3600B
  
  LDR R0, R6, #0
  ADD R6, R6, #-1
  NOT R4, R4
  ADD R4, R4, #1
  ADD R1, R6, R4
  BRn EMPTY_STACK
  BR END_3600
  
  EMPTY_STACK
    LEA R0, ERROR_UNDERFLOW
    PUTS
    ADD R6, R6, #1
  
END_3600
  LD R1, R1_3600B
  LD R2, R2_3600B
  LD R4, R4_3600B
  LD R5, R5_3600B
  LD R7, R7_3600B
  RET

;--------------------
; Subroutine Data
;--------------------
ERROR_UNDERFLOW .STRINGZ "ERROR: Tried to call pop on an empty stack\n"

R1_3600B .BLKW #1
R2_3600B .BLKW #1
R4_3600B .BLKW #1
R5_3600B .BLKW #1
R7_3600B .BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_MULTIPLY
; Parameter (R2): One number
; Parameter (R3): Another number
; Postcondition: The subroutine computes the total and stores it into R0
; Return Value (R0) : The multiplication result
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3900
SUB_MULTIPLY
  ST R1, R1_3900B
  ST R2, R2_3900B
  ST R3, R3_3900B
  ST R7, R7_3900B
  AND R0, R0, #0
  
  LD R1, DIGIT_CONVERT
  ADD R2, R2, R1
  ADD R3, R3, R1
  
  LOOP_3900
    ADD R0, R0, R3
    ADD R2, R2, #-1
    BRp LOOP_3900
    
END_3900
  LD R1, DIGIT_REVERSE
  ADD R0, R0, R1
  LD R1, R1_3900B
  LD R2, R2_3900B
  LD R3, R3_3900B
  LD R7, R7_3900B
  RET
  
;--------------
; Data
;--------------
DIGIT_CONVERT .FILL #-48
DIGIT_REVERSE .FILL #48
R1_3900B .BLKW #1
R2_3900B .BLKW #1
R3_3900B .BLKW #1
R7_3900B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Input (R1): The decimal number
; Postcondition: The subroutine prints the number that is in (R1)
; Return Value : (none)
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4300
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
PRINT_NUMBER
  ST R2, R2_4300B
  ST R3, R3_4300B
  ST R4, R4_4300B
  ST R5, R5_4300B
  ST R6, R6_4300B
  ST R7, R7_4300B
  
  LEA R5, DIGIT_ARRAY
  LD R4, CLEANUP
  LD R3, PRINT_COUNT
  
  CLEAN_LOOP
    STR R4, R5, #0
    ADD R5, R5, #1
    ADD R3, R3, #-1
    BRp CLEAN_LOOP

  LEA R5, DIGIT_ARRAY
  ADD R5, R5, #4
  AND R3, R3, #0
  AND R4, R4, #0
  
  
SIGN_CHECK
    ADD R0, R1, #0
    BRn NEG_NUM
  
ONES_CHECK
  ADD R0, R1, #0
  LD R2, DECREMENT
  ADD R0, R0, R2
  BRn ONES_DIGIT
 
PRINT_LOOP
  AND R3, R3, #0
  ADD R0, R1, #0
  LD R2, DECREMENT
  
  COUNT
    ADD R3, R3, #1
    ADD R0, R0, R2
    BRzp COUNT

  RESULT
    ADD R0, R0, #10
    LD R2, ASCII
    ADD R0, R0, R2
    STR R0, R5, #0
    ADD R5, R5, #-1
    
    ADD R3, R3, #-1
    ADD R1, R3, #0
    JSR ONES_CHECK
  
    ONES_DIGIT
	ADD R0, R1, #0
	LD R2, ASCII
	ADD R0, R0, R2
	STR R0, R5, #0
	JSR PRINT_ARRAY
	
    NEG_NUM
      LD R0, MINUS_SIGN
      OUT
      NOT R1, R1
      ADD R1, R1, #1
      JSR ONES_CHECK
  
  PRINT_ARRAY
    LD R6, PRINT_COUNT
    LEA R5, DIGIT_ARRAY
    LD R4, ZERO_MINUS
    LOOP
      LDR R0, R5, #0
      ADD R1, R0, R4
      BRn SKIP_OUT
      OUT
      SKIP_OUT
	ADD R5, R5, #1
	ADD R6, R6, #-1
	BRzp LOOP
  
END_4300
;   LD R0, ENDL
;   OUT
  
  LD R2, R2_4300B
  LD R3, R3_4300B 
  LD R4, R4_4300B 
  LD R5, R5_4300B 
  LD R6, R6_4300B
  LD R7, R7_4300B
  
  RET
;---------
;Data
;---------
ASCII                   .FILL #48
DECREMENT               .FILL #-10
PRINT_COUNT             .FILL #5
ENDL                    .FILL #10
DIGIT_ARRAY             .BLKW #5
MINUS_SIGN              .FILL '-'
ZERO_MINUS              .FILL #-48
CLEANUP                 .FILL #0

R2_4300B .BLKW #1
R3_4300B .BLKW #1
R4_4300B .BLKW #1
R5_4300B .BLKW #1
R6_4300B .BLKW #1
R7_4300B .BLKW #1



.ORIG xA000
STACK_ARR .BLKW #5

.END