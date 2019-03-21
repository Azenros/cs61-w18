;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 7
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================
.ORIG x3000

LEA R0, PROMPT
PUTS
GETC
OUT
ADD R1, R0, #0
ADD R3, R1, #0
LD R0, NEWLINE
OUT
LD R6, SUB_R3200
JSRR R6
LEA R0, NUMBER_STRING
PUTS
ADD R0, R3, #0
OUT
LEA R0, NUMBER_STRING2
PUTS
LD R6, SUB_R3400
JSRR R6

HALT

NEWLINE .FILL '\n'
PROMPT .STRINGZ "Enter a character: "
NUMBER_STRING .STRINGZ "The number of 1's in '"
NUMBER_STRING2 .STRINGZ "' is: "
SUB_R3200 .FILL x3200
SUB_R3400 .FILL x3400
ASCII_REVERT .FILL #48

;==================================================================
; Subroutine: Counting 1's in binary number
; Parameter (R1) : The keystroke recorded in main
; Postcondition: The subroutine has finished comparing the number to 
;                every mask
; Return Value(R1): The number of 1's in the binary number
;===================================================================
.ORIG x3200

SUB_ROUTING_3200
  ST R0, BACKUP_R0_3200
  ST R2, BACKUP_R2_3200
  ST R3, BACKUP_R3_3200
  ST R4, BACKUP_R4_3200
  ST R5, BACKUP_R5_3200
  ST R7, BACKUP_R7_3200
  
LD R2, MASK
LD R4, COUNTER
LOOP
  AND R3, R1, R2
  BRnz ZERO
  ADD R5, R5, #1
  ZERO
  ADD R2, R2, R2
  ADD R4, R4, #-1
  BRp LOOP
  
  
END_SUBR_3200
  ADD R1, R5, #0
  LD R0, BACKUP_R0_3200
  LD R2, BACKUP_R2_3200
  LD R3, BACKUP_R3_3200
  LD R4, BACKUP_R4_3200
  LD R5, BACKUP_R5_3200
  LD R7, BACKUP_R7_3200
  
RET
;================
;Subroutine Data
;================
MASK .FILL #1
COUNTER .FILL #16

BACKUP_R0_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1




;================================================================================
;Subroutine: Print Binary Register as Digit
;Input (R1): A binary number between the value of [-32768, 32767] is passed into
;the subroutine and manipulated back into an ASCII value. 
;Post-Condition: The ASCII conversion of the binary number is output with its proper sign.
;Return Value: none
;================================================================================
.ORIG x3400

SUB_3400
  ST R2, BACKUP_R2_3400
  ST R3, BACKUP_R3_3400
  ST R4, BACKUP_R4_3400
  ST R5, BACKUP_R5_3400
  ST R6, BACKUP_R6_3400
  ST R7, BACKUP_R7_3400
  
  LEA R5, DIGIT_ARRAY
  ADD R5, R5, #4
  AND R3, R3, #0
  
  
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
    ADD R0, R5, #0
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
    LOOP_2
      LDR R0, R5, #0
      ADD R0, R0, R4
      BRnz SKIP_OUT
      ADD R0, R0, R2
      OUT
      SKIP_OUT
	ADD R5, R5, #1
	ADD R6, R6, #-1
	BRp LOOP_2
  
END_SUB_3400
  LD R0, ENDL
  OUT
  
  LD R2, BACKUP_R2_3400
  LD R3, BACKUP_R3_3400
  LD R4, BACKUP_R4_3400
  LD R5, BACKUP_R5_3400
  LD R6, BACKUP_R6_3400
  LD R7, BACKUP_R7_3400
  
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

BACKUP_R2_3400          .BLKW #1
BACKUP_R3_3400          .BLKW #1
BACKUP_R4_3400          .BLKW #1
BACKUP_R5_3400          .BLKW #1
BACKUP_R6_3400          .BLKW #1
BACKUP_R7_3400          .BLKW #1