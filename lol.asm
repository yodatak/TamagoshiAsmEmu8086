; a short program to check how
; set and get pixel color works

name "pixel"

org  100h

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
mov bx, 0   ; disable blinking. 
int 10h     ; set it!



appuie_touche: ;teste de l'appuie de touches
                        ;On regarde si il y a un caractère dans le buffer clavier
                        mov ah,00h
                        int 16h
                        jnz action_touches
                        
                       
                action_touches:
                        cmp ax,4D00h;Touche droite
                         jnz lol
                        cmp ax,4B00h;Touche gauche
                         jnz trolol 
                        cmp ax,3920h;Barre d'espace
                         jnz trolollol
                        cmp ax,011Bh ;Esc
                        jnz trolollol
                        ret
                        
lol:
mov cx, 40 ;position x du sprite
mov dx, 40 ;position y du sprite
mov ah, 0ch
mov al, 5
int 10h
jmp appuie_touche 
trolol:        
mov cx, 50 ;position x du sprite
mov dx, 50 ;position y du sprite
mov ah, 0ch
mov al, 5
int 10h
jmp appuie_touche      
trolollol:
ret
ret      
        
        
;#afficher un pixel#
;
;cx colonne
;dx ligne
;               
;al couleur
;   0 black
;   1 blue
;   2 green
;   3 cyan
;   4 red
;   5 magenta
;   6 brown
;   7 light gray
;   8 dark gray
;   9 light blue
;   A light green
;   B light cyan
;   C light red
;   D light magenta
;   E yellow      
;   F white
;
;mov ah, 0ch
;int 10h                      



END