;=================================================
; Name: Steven Tran
; Email: stran050@ucr.edu
; GitHub username: Azenros
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE BELOW
;--------------------------------
; LD R2, TEST_A

GETC
OUT
ST R0, TEST_A 
LD R1, TEST_A
LD R0, NEWLINE
OUT

GETC
OUT
ST R0, TEST_B
LD R2, TEST_B
LD R0, NEWLINE
OUT

LD R0, TEST_A
OUT
LEA R0, SUBTRACT
PUTS
LD R0, TEST_B
OUT
LEA R0, EQUALS
PUTS

LD R4, CONVERT
ADD R1, R1, R4
ADD R2, R2, R4

NOT R2, R2
ADD R2, R2, #1
ADD R0, R1, R2

POS_ANS
  BRn NEG_ANS
  ADD R5, R0, #0
  LD R0, RESET
  ADD R0, R0, R5
  OUT
  LD R0, NEWLINE
  OUT
  HALT
BRp POS_ANS

NEG_ANS
  ADD R5, R0, #0
  NOT R5, R5
  ADD R5, R5, #1
  LD R0, MINUS
  OUT
  LD R4, RESET
  ADD R0, R4, R5
  OUT
  LD R0, NEWLINE
  OUT
  

HALT				; Stop execution of program
;------	
;Data
;------
; String to explain what to input 
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with PUTS. Note: already includes terminating newline!
NEWLINE .FILL '\n'	; newline character - use with OUT
SUBTRACT .STRINGZ       " - "
MINUS .FILL '-'
EQUALS .STRINGZ " = "        ; equal character
TEST_A .FILL x3049
TEST_B .FILL x304B
TEST_C .FILL x304D
CONVERT .FILL #-48
RESET .FILL x30

;---------------	
;END of PROGRAM
;---------------	
.END

