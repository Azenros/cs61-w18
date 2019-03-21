;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 2
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================

.orig x3000

  ld r1, dec_0
  ld r2, dec_12
  ld r3, dec_6
  
  do_while_loop
    add r1, r1, r2
    add r3, r3, #-1
    BRp do_while_loop
  end_do_while_loop
  
  halt
  
  dec_0  .fill #0
  dec_12 .fill #12
  dec_6  .fill #6
  
.end
