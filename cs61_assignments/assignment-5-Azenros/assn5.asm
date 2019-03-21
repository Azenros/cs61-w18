;=================================================
; Name: Steven Tran
; Email: stran050@ucr.edu
; GitHub username: Azenros
; 
; Assignment name: Assignment 5
; Lab section: 25
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
MENU_LOOP
  AND R1, R1, #0
  AND R2, R2, #0
  AND R3, R3, #0
  LD R0, SUB_3200
  JSRR R0
  LD R0, NEWLINE_PRINT_3000
  OUT

JUMP_CHECK
  ADD R1, R1, #-1
  BRz JUMP_3300 ;ALL_MACHINES_BUSY
  ADD R1, R1, #-1
  BRz JUMP_3400 ;ALL_MACHINES_FREE
  ADD R1, R1, #-1
  BRz JUMP_3500 ;NUM_BUSY_MACHINES
  ADD R1, R1, #-1
  BRz JUMP_3600 ;NUM_FREE_MACHINES
  ADD R1, R1, #-1
  BRz JUMP_3700 ;MACHINE_STATUS
  ADD R1, R1, #-1
  BRz JUMP_3800 ;FIRST_FREE
  BRnp QUIT
  
JUMP_3300           ;ALL_MACHINES_BUSY
  LD R0, SUB_3300
  JSRR R0
  ADD R2, R2, #0
  BRp BUSY_YES
  BRnz BUSY_NO
  
  BUSY_YES
    LEA R0, ALLBUSY
    PUTS
    BR RETURN_3300
  
  BUSY_NO
    LEA R0, ALLNOTBUSY
    PUTS
  
  RETURN_3300
    JSR MENU_LOOP
  
JUMP_3400           ;ALL_MACHINES_FREE
  LD R0, SUB_3400
  JSRR R0
  ADD R2, R2, #0
  BRp FREE_YES
  BRz FREE_NO
  
  FREE_YES
    LEA R0, FREE
    PUTS
    BR RETURN_3400
    
  FREE_NO
    LEA R0, NOTFREE
    PUTS
    
  RETURN_3400
    JSR MENU_LOOP
    
JUMP_3500            ;NUM_BUSY_MACHINES
  LD R0, SUB_3500
  JSRR R0
  LEA R0, BUSYMACHINE1
  PUTS
  LD R0, SUB_4300
  ADD R1, R2, #0
  JSRR R0
  LEA R0, BUSYMACHINE2
  PUTS
  BR MENU_LOOP
    
JUMP_3600            ;NUM_FREE_MACHINES
  LD R0, SUB_3600
  JSRR R0
  LEA R0, FREEMACHINE1
  PUTS
  LD R0, SUB_4300
  ADD R1, R2, #0
  JSRR R0
  LEA R0, FREEMACHINE2
  PUTS
  BR MENU_LOOP
  
JUMP_3700            ;MACHINE_STATUS
  LD R0, SUB_3700
  JSRR R0
  LEA R0, STATUS1
  PUTS
  LD R0, SUB_4300
  JSRR R0
  ADD R2, R2, #0
  BRp ISFREE
  BRz ISBUSY
  
  ISBUSY
    LEA R0, STATUS2
    PUTS
    BR RETURN_3700
  
  ISFREE
    LEA R0, STATUS3
    PUTS
  
  RETURN_3700
    BR MENU_LOOP

JUMP_3800            ;FIRST_FREE
  LD R0, SUB_3800
  JSRR R0
  LD R5, NO_FREE_CHECK
  ADD R4, R2, R5
  BRzp LAST_FREE
  
  MACHINE_PRINT
    LEA R0, FIRSTFREE1
    PUTS
    ADD R1, R2, #0
    LD R0, SUB_4300
    JSRR R0
    BR RETURN_3800
    
  LAST_FREE
    LEA R0, FIRSTFREE2
    PUTS
    BR RETURN_3800
    
  RETURN_3800
    LD R0, NEWLINE_PRINT_3000
    OUT
    BR MENU_LOOP
    
    
QUIT
  LEA R0, Goodbye
  PUTS
  HALT
;---------------	
;Data
;---------------
;Add address for subroutines
SUB_3200 .FILL x3200
SUB_3300 .FILL x3300
SUB_3400 .FILL x3400
SUB_3500 .FILL x3500
SUB_3600 .FILL x3600
SUB_3700 .FILL x3700
SUB_3800 .FILL x3800
SUB_4200 .FILL x4200
SUB_4300 .FILL x4300

;Other data 
NO_FREE_CHECK .FILL #-17
NEWLINE_PRINT_3000 .FILL '\n'


;Strings for options
Goodbye         .STRINGZ "Goodbye!\n"
ALLNOTBUSY      .STRINGZ "Not all machines are busy\n"
ALLBUSY         .STRINGZ "All machines are busy\n"
FREE            .STRINGZ "All machines are free\n"
NOTFREE		      .STRINGZ "Not all machines are free\n"
BUSYMACHINE1    .STRINGZ "There are "
BUSYMACHINE2    .STRINGZ " busy machines\n"
FREEMACHINE1    .STRINGZ "There are "
FREEMACHINE2    .STRINGZ " free machines\n"
STATUS1         .STRINGZ "Machine "
STATUS2		      .STRINGZ " is busy\n"
STATUS3		      .STRINGZ " is free\n"
FIRSTFREE1      .STRINGZ "The first available machine is number "
FIRSTFREE2      .STRINGZ "No machines are free\n"
NEWLINE         .FILL '\n'

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
MENU
  ;HINT back up 
  ST R0, R0_3200B
  ST R2, R2_3200B
  ST R3, R3_3200B
  ST R4, R4_3200B
  ST R7, R7_3200B

  LD R3, ERROR_CHECK_3200
  LD R2, CONVERT_3200

INPUT_3200
  LD R0, Menu_string_addr
  PUTS
  GETC
  OUT

  ADD R4, R3, R0
  BRp INVALID_3200
  
  ADD R4, R2, R0
  BRnz INVALID_3200
  
  ADD R1, R0, R2
  BR END_3200
  
INVALID_3200
  LD R0, NEW_LINE
  OUT
  LEA R0, Error_msg_1
  PUTS
  BR INPUT_3200
  
END_3200
  ;HINT Restore
  LD R0, R0_3200B
  LD R2, R2_3200B
  LD R3, R3_3200B
  LD R4, R4_3200B
  LD R7, R7_3200B
  RET

;--------------------------------
;Data for subroutine MENU
;--------------------------------
ERROR_CHECK_3200 .FILL #-55
NEW_LINE .FILL '\n'
CONVERT_3200 .FILL #-48
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6000

R0_3200B .BLKW #1
R2_3200B .BLKW #1
R3_3200B .BLKW #1
R4_3200B .BLKW #1
R7_3200B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3300
;HINT back up 
ALL_MACHINES_BUSY
  ST R1, R1_3300B
  ST R3, R3_3300B
  ST R4, R4_3300B
  ST R7, R7_3300B

  LD R3, BUSYNESS_ADDR_ALL_MACHINES_BUSY
  LDR R1, R3, #0
  LD R3, ZEROx4_CHECK

  NOT R1, R1
  NOT R3, R3
  AND R4, R1, R3
  NOT R4, R4
  
  ADD R4, R4, #0
  BRz ALL_BUSY
  BRnp END_3300
  
ALL_BUSY
  AND R2, R2, #0
  ADD R2, R2, #1

END_3300
  LD R1, R1_3300B
  LD R3, R3_3300B
  LD R4, R4_3300B
  LD R7, R7_3300B
  RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
ZEROx4_CHECK .FILL x0
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD200

R1_3300B .BLKW #1
R3_3300B .BLKW #1
R4_3300B .BLKW #1
R7_3300B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3400
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up
ALL_MACHINES_FREE
  ST R1, R1_3400B
  ST R3, R3_3400B
  ST R4, R4_3400B
  ST R7, R7_3400B
  
  LD R3, BUSYNESS_ADDR_ALL_MACHINES_FREE
  LDR R1, R3, #0
  LD R3, MASK_3400
  LD R4, COMPARE_COUNT
  
  COMPARE_LOOP_3400
    AND R2, R1, R3
    BRz NOT_FREE
    ADD R3, R3, R3
    ADD R4, R4, #-1
    BRp COMPARE_LOOP_3400
    BRz ALL_FREE

NOT_FREE
  AND R2, R2, #0
  BR END_3400
    
ALL_FREE
  AND R2, R2, #0
  ADD R2, R2, #1

END_3400
  ;HINT Restore
  LD R1, R1_3400B
  LD R3, R3_3400B
  LD R4, R4_3400B
  LD R7, R7_3400B
  RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
MASK_3400 .FILL #1
COMPARE_COUNT .FILL #16
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD200

R1_3400B .BLKW #1
R3_3400B .BLKW #1
R4_3400B .BLKW #1
R7_3400B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3500
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 
NUM_BUSY_MACHINES
  ST R1, R1_3500B
  ST R3, R3_3500B
  ST R4, R4_3500B
  ST R5, R5_3500B
  ST R7, R7_3500B
  
  LD R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
  LDR R3, R1, #0
  LD R1, MASK_3500
  LD R4, COUNT_3500
  
  LOOP_3500
    AND R5, R1, R3
    BRnp SKIP_ADD_1_3500
    ADD R2, R2, #1
    
    SKIP_ADD_1_3500
      ADD R1, R1, R1
      ADD R4, R4, #-1
      BRp LOOP_3500
  
END_3500
  ;HINT Restore
  LD R1, R1_3500B
  LD R3, R3_3500B
  LD R4, R4_3500B
  LD R5, R5_3500B
  LD R7, R7_3500B
  RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
MASK_3500 .FILL #1
COUNT_3500 .FILL #16
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD200

R1_3500B .BLKW #1
R3_3500B .BLKW #1
R4_3500B .BLKW #1
R5_3500B .BLKW #1
R7_3500B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3600
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
NUM_FREE_MACHINES
  ST R1, R1_3600B
  ST R3, R3_3600B
  ST R4, R4_3600B
  ST R5, R5_3600B
  ST R7, R7_3600B
  
  LD R1, BUSYNESS_ADDR_NUM_FREE_MACHINES
  LDR R3, R1, #0
  LD R1, MASK_3600
  LD R4, COUNT_3600
  
  LOOP_3600
    AND R5, R1, R3
    BRz SKIP_ADD_1_3600
    ADD R2, R2, #1
    
    SKIP_ADD_1_3600
      ADD R1, R1, R1
      ADD R4, R4, #-1
      BRp LOOP_3600
  
END_3600
  ;HINT Restore
  LD R1, R1_3600B
  LD R3, R3_3600B
  LD R4, R4_3600B
  LD R5, R5_3600B
  LD R7, R7_3600B
  RET

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------

MASK_3600 .FILL #1
COUNT_3600 .FILL #16
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD200

R1_3600B .BLKW #1
R3_3600B .BLKW #1
R4_3600B .BLKW #1
R5_3600B .BLKW #1
R7_3600B .BLKW #1  

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3700
;--------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
MACHINE_STATUS
  ;HINT back up 
  ST R1, R1_3700B
  ST R3, R3_3700B
  ST R4, R4_3700B
  ST R5, R5_3700B
  ST R7, R7_3700B
  
  LD R1, CALL_INPUT_SUB
  JSRR R1
  
  ADD R5, R1, #0
  LD R3, BUSYNESS_ADDR_MACHINE_STATUS
  LDR R4, R3, #0
  LD R3, MASK_3700
  
  LOOP_3700
    ADD R1, R1, #0
    BRz COMPARE_3700
    ADD R3, R3, R3
    ADD R1, R1, #-1
    BR LOOP_3700
    
  COMPARE_3700
    AND R2, R3, R4
    BRz END_3700
    AND R2, R2, #0
    ADD R2, R2, #1

;HINT Restore
END_3700
  ADD R1, R5, #0
  LD R3, R3_3700B
  LD R4, R4_3700B
  LD R5, R5_3700B
  LD R7, R7_3700B
  RET

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
MASK_3700 .FILL #1
BUSYNESS_ADDR_MACHINE_STATUS .Fill xD200
CALL_INPUT_SUB .FILL x4200

R1_3700B .BLKW #1
R3_3700B .BLKW #1
R4_3700B .BLKW #1
R5_3700B .BLKW #1
R7_3700B .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3800
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
FIRST_FREE
  ;HINT back up 
  ST R1, R1_3800B
  ST R3, R3_3800B
  ST R4, R4_3800B
  ST R5, R5_3800B
  ST R7, R7_3800B
  AND R2, R2, #0
  
  LD R3, BUSYNESS_ADDR_FIRST_FREE
  LDR R1, R3, #0
  LD R3, MASK_3800
  LD R4, NO_FREE_COUNT
  
  LOOP_3800
    AND R5, R1, R3
    BRnp END_3800
    ADD R3, R3, R3
    ADD R2, R2, #1
    ADD R4, R4, #-1
    BRnz NO_FREE_MACHINE
    BRp LOOP_3800
    
  NO_FREE_MACHINE
    LD R2, NO_FREE_FILL
    
END_3800
  ;HINT Restore
  LD R1, R1_3800B
  LD R3, R3_3800B
  LD R4, R4_3800B
  LD R5, R5_3800B
  LD R7, R7_3800B
  RET
  
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
MASK_3800 .FILL #1
NO_FREE_COUNT .FILL #16
NO_FREE_FILL .FILL #17
BUSYNESS_ADDR_FIRST_FREE .Fill xD200

R1_3800B .BLKW #1
R3_3800B .BLKW #1
R4_3800B .BLKW #1
R5_3800B .BLKW #1
R7_3800B .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5 (4? -Steven)
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4200
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
INSERT_SUBROUTINE
  ST R0, R0_4200B
  ST R2, R2_4200B
  ST R3, R3_4200B
  ST R4, R4_4200B
  ST R5, R5_4200B
  ST R6, R6_4200B
  ST R7, R7_4200B
  
INTRO
  AND R5, R5, #0
  LEA R0, prompt
  PUTS
  LD R6, INPUT_COUNT
  AND R1, R1, #0
  INPUT_LOOP
    GETC
    OUT
  
  AFTER_INPUT
    LD R2, ZERO_CHECK
    ADD R3, R0, R2
    BRn ASCII_48
    
    LD R2, NINE_CHECK
    ADD R3, R0, R2
    BRp ERROR_57

    ADD R2, R6, #0
    ADD R2, R2, #-6
    BRz CHAR_1
    
    ADD R1, R1, R1 ;x+x=2x
    ADD R2, R1, R1 ;2x+2x=4x
    ADD R2, R2, R2 ;4x+4x=8x
    ADD R1, R1, R2 ;8x+2x=10x
    
    LD R2, ZERO_CHECK
    ADD R0, R0, R2
    ADD R1, R1, R0
    ADD R6, R6, #-1
    BRp INPUT_LOOP
    BRz NEG_CHECK

  CHAR_1
    LD R2, ZERO_CHECK
    ADD R0, R0, R2
    BRz LEADING_ZERO
    ADD R1, R1, R0
    ADD R6, R6, #-2
    JSR INPUT_LOOP
    
  LEADING_ZERO
    JSR INPUT_LOOP
    
  PLUS
    ADD R2, R6, #0
    ADD R2, R2, #-6
    BRnp ERROR_57
    ADD R5, R5, #1
    ADD R6, R6, #-1
    JSR INPUT_LOOP
    
  MINUS
    ADD R2, R6, #0
    ADD R2, R2, #-6
    BRnp ERROR_57
    ADD R5, R5, #-1
    ADD R6, R6, #-1
    JSR INPUT_LOOP
    
  NEWLINE_PRINT_4200
    ADD R2, R6, #0
    ADD R2, R2, #-6
    BRz ERROR_57
    ADD R2, R6, #0
    ADD R2, R2, #-5
    BRnp NEG_CHECK
    ADD R5, R5, #0
    BRnp OUTPUT_ERROR
    BRz NEG_CHECK
    
  ASCII_48
    LD R2, PLUS_CHECK
    ADD R3, R0, R2
    BRz PLUS
    
    LD R2, MINUS_CHECK
    ADD R3, R0, R2
    BRz MINUS
    
    LD R2, ENDL_CHECK
    ADD R3, R0, R2
    BRz NEWLINE_PRINT_4200
    
    
  ERROR_57
    ADD R2, R0, #0
    LD R3, ENDL_CHECK
    ADD R2, R2, R3
    BRnp OUTPUT_ENDL
    
  OUTPUT_ERROR
    LEA R0, Error_msg_2
    PUTS
    JSR INTRO

  OUTPUT_ENDL
    LD R0, ENDLINE
    OUT
    JSR OUTPUT_ERROR
    
  NEG_CHECK
    ADD R5, R5, #0
    BRzp END
    NOT R1, R1
    ADD R1, R1, #1

END
;   LD R0, ENDLINE
;   OUT
  ADD R1, R1, #0
  
  
  
  BRn OUTPUT_ERROR
  LD R0, VALID_CHECK_1
  ADD R0, R0, R1
  BRzp OUTPUT_ERROR
  
  LD R0, R0_4200B
  LD R2, R2_4200B
  LD R3, R3_4200B
  LD R4, R4_4200B
  LD R5, R5_4200B
  LD R6, R6_4200B
  LD R7, R7_4200B

  RET

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"

INPUT_COUNT             .FILL #6
ENDL_CHECK              .FILL #-10
PLUS_CHECK              .FILL #-43
MINUS_CHECK             .FILL #-45
ZERO_CHECK              .FILL #-48
NINE_CHECK              .FILL #-57
VALID_CHECK_1           .FILL #-16
ENDLINE                 .FILL '\n'

R0_4200B .BLKW #1
R2_4200B .BLKW #1
R3_4200B .BLKW #1
R4_4200B .BLKW #1
R5_4200B .BLKW #1
R6_4200B .BLKW #1
R7_4200B .BLKW #1
	
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



.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD200			; Remote data
BUSYARR .FILL xFFFF		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
