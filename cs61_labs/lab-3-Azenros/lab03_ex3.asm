;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
;
; Lab: lab 3
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================

.ORIG x3000

LDI R3, DEC_65_PTR
LDI R4, HEX_41_PTR
ADD R3, R3, #1
ADD R4, R4, #1

STI R3, DEC_65_PTR
STI R4, HEX_41_PTR

LD R5, DEC_65_PTR
LD R6, HEX_41_PTR

LDR R3, R5, #0
LDR R4, R6, #0

STR R3, R5, #0
STR R4, R6, #0

HALT

DEC_65_PTR .FILL x4000
HEX_41_PTR .FILL x4001


.END