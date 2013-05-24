

org 100h

jmp start

msg:    db      "Donnez votre saisie : ", 0Dh,0Ah, 24h

start:  mov     dx, msg
        mov     ah, 09h 
        int     21h 
        
        mov     ah, 0 
        int     16h      
        
        tableau db 10 dup ('') 
        
        mov cx,9
        
saisie:
        
ret 