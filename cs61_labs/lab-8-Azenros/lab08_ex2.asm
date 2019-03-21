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
LD R0, SUB_3400
JSRR R0

HALT

INTRO_PROMPT .STRINGZ "Enter a string of text, ending with the 'ENTER' key: "
SUB_3200 .FILL x3200
SUB_3400 .FILL x3400
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
R7_3200B .BLKW #1
  
  
;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R1): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
;                a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------
.ORIG x3400
SUB_PALINDROME
  ST R0, R0_3400B
  ST R1, R1_3400B
  ST R2, R2_3400B
  ST R3, R3_3400B
  ST R5, R5_3400B
  ST R6, R6_3400B
  ST R7, R7_3400B

AND R4, R4, #0
ADD R4, R4, #1
ADD R2, R1, #0
ADD R2, R2, R5
ADD R2, R2, #-1

COMPARE_LOOP
  LDR R6, R1, #0
  LDR R7, R2, #0
  NOT R7, R7
  ADD R7, R7, #1
  ADD R6, R6, R7
;   AND R3, R2, R1
  BRnp NOT_PALIN
  ADD R1, R1, #1
  ADD R2, R2, #-1
  ADD R5, R5, #-2
  BRnz RETURN_3400
  BRp COMPARE_LOOP
  
NOT_PALIN
  AND R4, R4, #0

RETURN_3400
  LD R0, R0_3400B
  LD R1, R1_3400B
  LD R2, R2_3400B
  LD R3, R3_3400B
  LD R5, R5_3400B
  LD R6, R6_3400B
  LD R7, R7_3400B
  RET

;---------
; Data
;---------

R0_3400B .BLKW #1
R1_3400B .BLKW #1
R2_3400B .BLKW #1
R3_3400B .BLKW #1
R5_3400B .BLKW #1
R6_3400B .BLKW #1
R7_3400B .BLKW #1
  
;--------------
; Distant data
;--------------
.ORIG x6000
STRINGZ_ARRAY .BLKW #20
  
  
  
  
  
  
  
  