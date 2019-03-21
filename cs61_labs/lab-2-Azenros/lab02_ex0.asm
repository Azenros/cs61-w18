;=================================================
; Name: Steven Tran
; Email: stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: Lab 2
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================

.ORIG x3000

  lea r0, MSG_TO_PRINT
  puts

  halt
;---------
;Local data
;----------

  MSG_TO_PRINT .STRINGZ    "Hello world!!!\n"



.END