name "ex9.2.6"   ; output file name (max 8 chars for DOS compatibility)

org  100h 

         
 
         
MOV ax, 5

 
CMP ax,1 
JNZ case_2
;code execute si ax = 1
JMP stop
         
case_2: 

CMP ax, 5
JNZ case_3 
;code execute si ax = 5
JMP stop 

case_3:

CMP ax, 9
JNZ default
;code execute si ax = 9
JMP stop 

default:

CMP ax, 0
JNZ default
;code execute si ax = 0
JMP stop


stop: ret   ; return to the operating system.

msg         db "press any key..."
msg_size =  $ - offset msg