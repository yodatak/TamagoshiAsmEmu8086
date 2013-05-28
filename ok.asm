lol:
;wait for keypress
mov ah,00h ;
int 16h ;On utilise l'interuption 16h pour le clavier		
CMP AX,4B00h ;code de ASCII pour la touche Left
JNE lol ;On saute a la partie restart  
ret ; Touche Entre enfonce on quite le jeu





action_touche:
;wait for keypress
mov ah,01h ;
int 16h ;On utilise l'interuption 16h pour le clavier
jnz action_touches
ret
   action_touches:
        CMP AX,011Bh ;code de ASCII pour la touche ESC
        ret ; Touche Entre enfonce on quite le jeu
        CMP AX,4B00h ;code de ASCII pour la touche Left
        ret