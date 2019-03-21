;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: 
; 
; Lab: lab 8
; Lab section: 25
; TA: Daniel Handojo
;=================================================
.ORIG x3000

LEA R0, INTRO_PROMPT
PUTS
LD R1, ARR_PTR
LD R0, SUB_3200
JSRR R0
LD R0, ARR_PTR
PUTS

HALT

INTRO_PROMPT .STRINGZ "Enter a string of text, ending with the 'ENTER' key: "
SUB_3200 .FILL x3200
ARR_PTR .FILL x6000


;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has allowed the user to input a string,
;                terminated by the [ENTER] key, and has stored it in an array
;                that starts at (R1) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user.
;               R1 still contains the starting address of the array.
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3200

SUB_GET_STRING
  ST R0, R0_3200B
  ST R1, R1_3200B
  ST R2, R2_3200B
  ST R3, R3_3200B
  ST R4, R4_3200B
  ST R6, R6_3200B
  ST R7, R7_3200B

AND R5, R5, #0
LD R2, ENDL_CHECK

INPUT_LOOP
  GETC
  OUT
  ADD R3, R0, R2
  BRz INPUT_STOP
  
  STR R0, R1, #0
  ADD R1, R1, #1
  ADD R5, R5, #1
  BR INPUT_LOOP
  
INPUT_STOP
  LD R2, NULL_CHAR
  STR R2, R1, #0
  
  
RETURN_3200
  LD R0, R0_3200B
  LD R1, R1_3200B
  LD R2, R2_3200B
  LD R3, R3_3200B
  LD R4, R4_3200B
  LD R6, R6_3200B
  LD R7, R7_3200B
  RET
  
;---------
; Data
;---------
NULL_CHAR .FILL x0
ENDL_CHECK .FILL #-10

R0_3200B .BLKW #1
R1_3200B .BLKW #1
R2_3200B .BLKW #1
R3_3200B .BLKW #1
R4_3200B .BLKW #1
R6_3200B .BLKW #1
R7_3200B .BLKW #1
  
  
  
  
  
;--------------
; Distant data
;--------------
.ORIG x6000
STRINGZ_ARRAY .BLKW #20
  
  
  
  
  
  
  
  