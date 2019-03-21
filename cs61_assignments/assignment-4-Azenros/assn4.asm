;=================================================
; Name: Steven Tran
; Email: stran050
; GitHub username: Azenros
; 
; Assignment name: Assignment 4
; Lab section: 25
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
;Example of how to Output Intro Message

INTRO
  LD R0, introMessagePtr  ; Get pointer to Intro Message
  PUTS
  AND R1, R1, #0 ;STORING DECIMAL
  AND R2, R2, #0 ;LOAD MISC NUMBERS/CHAR
  AND R3, R3, #0 ;STORE TEMP RESULTS
  AND R4, R4, #0 ;just in case
  AND R5, R5, #0 ;IF SIGN USED, FLAG THIS REGISTER
  AND R6, R6, #0 ;INPUT COUNT
  LD R6, INPUT_COUNT

INPUT_LOOP
  GETC
;   ADD R1, R0, #0
;   LD R2, ENDL_CHECK  ;prevents duplicate endl's
;   ADD R4, R2, R0
;   BRz AFTER_INPUT
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
  ADD R1, R1, R0
  ADD R6, R6, #-2
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
  LEA R0, GO_TO_SUBR
  LDR R0, R0, #0
  JSRR R0
  LD R0, ENDLINE
  OUT
  HALT
 


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


ENDLINE                 .FILL '\n'
GO_TO_SUBR       .FILL x3200

;==================================================================
; Subroutine: Printing From Array
; Parameter (R1): The number to print to binary
; Postcondition: The subroutine has printed to consle all characters 
;                of every number in the array.
; Return Value: None
;===================================================================

.ORIG x3200   ;Side note: taken from lab06_ex3.asm

PRINT_SUBROUTINE
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LD R6, COUNTER
LD R0, LETTER_B
OUT
AND R0, R0, #0

PRINT_LOOP
  
  ADD R1, R1, #0
  BRzp ZERO
  ADD R1, R1, #0
  BRn ONE

LEFT_SHIFT
  ADD R1, R1, R1
  ADD R6, R6, #-1
  ADD R7, R6, #-12
  BRz SPACE_PRINT
  ADD R7, R6, #-8
  BRz SPACE_PRINT
  ADD R7, R6, #-4
  BRz SPACE_PRINT
  
SPACE_AFTER
  ADD R6, R6, #0
  BRp PRINT_LOOP
  LD R0, SPACE
  OUT
  JSR END_SUBR
  
ZERO
  LD R5, CONVERT_ASCII
  AND R0, R0, #0
  ADD R0, R0, R5
  OUT
  BR LEFT_SHIFT

ONE
  LD R5, CONVERT_ASCII
  AND R0, R0, #0
  ADD R0, R0, #1
  ADD R0, R0, R5
  OUT
  BR LEFT_SHIFT
  
SPACE_PRINT
  LD R0,SPACE
  OUT
  BR SPACE_AFTER
  
END_SUBR
  LD R0, BACKUP_R0_3200
  LD R1, BACKUP_R1_3200
  LD R2, BACKUP_R2_3200
  LD R6, BACKUP_R6_3200
  LD R7, BACKUP_R7_3200
  RET
  
;=====================
;  Subroutine Data
;=====================
SPACE .FILL ' '
ENDL .FILL '\n'
COUNTER .FILL #16
LETTER_B .FILL x62

SPACE_1 .FILL #-12
SPACE_2 .FILL #-8
SPACE_3 .FILL #-4
CONVERT_ASCII .FILL #48

BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1


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
;-------------------
;PURPOSE of PROGRAM
;-------------------
