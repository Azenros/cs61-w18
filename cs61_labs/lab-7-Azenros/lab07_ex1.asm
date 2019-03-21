;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 7
; Lab section: 25
; TA: Daniel Handojo
;=================================================

.ORIG x3000


LD R0, SUB_3200_PTR
JSRR R0
ADD R1, R1, #1
LD R0, SUB_3400_PTR
JSRR R0

HALT

SUB_3200_PTR .FILL x3200
SUB_3400_PTR .FILL x3400

;==================================================================
; Subroutine: Inserting into Array
; Parameter: No Parameters 
; Postcondition: The subroutine has finished inputting all 16
;                binary numbers and stored the correct decimal value.
; Return Value(R1): The decimal value of the inputted binary
;===================================================================
.ORIG x3200
  
INSERT_SUBROUTINE
  ST R0, BACKUP_R0_3200
  ST R2, BACKUP_R2_3200
  ST R3, BACKUP_R3_3200
  ST R4, BACKUP_R4_3200
  ST R5, BACKUP_R5_3200
  ST R6, BACKUP_R6_3200
  ST R7, BACKUP_R7_3200
  
INTRO
LD R0, introMessagePtr
PUTS
LD R6, INPUT_COUNT
LD R4, DUPLICATE_COUNT
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
  ADD R2, R6, #0
  ADD R2, R2, #-5
  BRz CHAR_2
  
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
  
CHAR_2
  LD R2, ZERO_CHECK
  ADD R0, R0, R2
  BRz LEADING_ZERO
  ADD R1, R1, R0
  ADD R6, R6, #-1
  JSR INPUT_LOOP
  
  
LEADING_ZERO
  ADD R4, R4, #-1
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
  
NEWLINE
  ADD R4, R4, #0
  BRnz NO_ZERO_ERROR
  ADD R2, R6, #0
  ADD R2, R2, #-6
  BRz ERROR_57
  ADD R2, R6, #0
  ADD R2, R2, #-5
  BRnp NEG_CHECK
  RESUME_CHECK
  ADD R5, R5, #0
  BRnp OUTPUT_ERROR
  BRz NEG_CHECK
  
NO_ZERO_ERROR
  AND R5, R5, #0
  JSR RESUME_CHECK
  
ASCII_48
  LD R2, PLUS_CHECK
  ADD R3, R0, R2
  BRz PLUS
  
  LD R2, MINUS_CHECK
  ADD R3, R0, R2
  BRz MINUS
  
  LD R2, ENDL_CHECK
  ADD R3, R0, R2
  BRz NEWLINE
  
  
ERROR_57
  ADD R2, R0, #0
  LD R3, ENDL_CHECK
  ADD R2, R2, R3
  BRnp OUTPUT_ENDL
  
OUTPUT_ERROR
  LD R0, errorMessagePtr
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
  LD R0, ENDLINE
  OUT
  LD R0, BACKUP_R0_3200
  LD R2, BACKUP_R2_3200
  LD R3, BACKUP_R3_3200
  LD R4, BACKUP_R4_3200
  LD R5, BACKUP_R5_3200
  LD R6, BACKUP_R6_3200
  LD R7, BACKUP_R7_3200
  RET
 


;Example of how to Output Error Message
;LD R0, errorMessagePtr  ; Get pointer to Error Message
;PUTS
;---------------	
;Data
;---------------
introMessagePtr		.FILL x6000
errorMessagePtr		.FILL x6100

INPUT_COUNT             .FILL #6
ENDL_CHECK              .FILL #-10
PLUS_CHECK              .FILL #-43
MINUS_CHECK             .FILL #-45
ZERO_CHECK              .FILL #-48
NINE_CHECK              .FILL #-57
DUPLICATE_COUNT         .FILL #1


ENDLINE                 .FILL '\n'


BACKUP_R0_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1

;================================================================================
;Subroutine: Print Binary Register as Digit
;Input (R1): A binary number between the value of [-32768, 32767] is passed into
;the subroutine and manipulated back into an ASCII value. 
;Post-Condition: The ASCII conversion of the binary number is output with its proper sign.
;Return Value: none
;================================================================================
.ORIG x3400

PRINT_DIGITS
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


;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_msg1	.STRINGZ	"ERROR INVALID INPUT\n"

;---------------
;END of PROGRAM
;---------------
.END

