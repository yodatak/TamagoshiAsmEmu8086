;921
jmp op1
op4: 
    inc AX
    jmp op5
op3: 
    dec AX
    jmp op4

op1:
    mov AX,10  
    jmp op2

op2:
    inc AX
    jmp op3

op5:dec AX