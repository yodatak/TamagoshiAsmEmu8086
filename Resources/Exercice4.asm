org  100h ; set location counter to 100h

mov bx, 5

jmp Decrementation   ;appel de la "fonction"


Decrementation:        ; "fonction"
cmp bx,0 
jle fin                ; comparaison bx et 0
dec bx                 ; bx--
jmp Decrementation     ;appel de la "fonction"
fin:                   ; fin decerementation


ret