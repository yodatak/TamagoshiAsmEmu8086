         
            
            
            
           
pokemon PROC      

    ; E  G  A  E  E  G  A  A  G  
    
    mov bx,note_E ; Frequence de la note    http://courses.engr.illinois.edu/ece390/books/labmanual/io-devices-speaker.html
    mov cx,03h
    call playnote
    mov bx,note_G
    mov cx,03h
    call playnote
    mov bx,note_A
    mov cx,06h
    call playnote
    mov bx,note_E
    mov cx,03h
    call playnote
    mov bx,note_E
    mov cx,03h
    call playnote
    mov bx,note_G
    mov cx,03h
    call playnote
    mov bx,note_A
    mov cx,06h
    call playnote
    mov bx,note_A
    mov cx,06h
    call playnote
    mov bx,note_G
    mov cx,0Eh
    call playnote
     
    ; G A  B  C  B  A  G 
    mov bx,note_A
    mov cx,03h
    call playnote
    mov bx,note_A
    mov cx,03h
    call playnote
    mov bx,note_B
    mov cx,03h
    call playnote
    mov bx,note_C
    mov cx,03h
    call playnote
    mov bx,note_B
    mov cx,03h
    call playnote
    mov bx,note_A
    mov cx,06h
    call playnote
    mov bx,note_A
    mov cx,06h
    call playnote
    mov bx,note_G
    mov cx,09h
    call playnote
  
 ret 

pokemon ENDP
 
note_E equ 3619
note_F equ 3416
note_G equ 3043
note_A equ 2711
note_B equ 2415
note_C equ 2280
note_D equ 2031

;#jouer une note#
;
;bx frequence
;cx duree
;
;call playnote
        
playnote PROC         
          
    mov     al, 182         ; Prepare the speaker for the
    out     43h, al         ;  note.
    mov     ax, bx        ; Frequency number (in decimal)
                            ;  for middle C.
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al 
    in      al, 61h         ; Turn on note (get value from
                            ;  port 61h).
    or      al, 00000011b   ; Set bits 1 and 0.
    out     61h, al         ; Send new value.
    
    
    ;pause pour une duree :
   ;mov cx, 0ah ; 000f4240h = 1,000,000
    mov dx, 4240h
    mov ah, 86h
    int 15h
    
    
    in      al, 61h         ; Turn off note (get value from
                            ;  port 61h).
    and     al, 11111100b   ; Reset bits 1 and 0.
    out     61h, al         ; Send new value.
    
    

    mov cx, 00h ; 000f4240h = 1,000,000
    mov dx, 4240h
    mov ah, 86h
    int 15h

     
    ret
playnote ENDP 
