
org 100h

mov bx, 0  ;ici bx=0

mov cx, 0  ;ici cx=0

mov dx, 10 ;ici on stock 10 dans dx

lol:       ;ici une belle etiquette

add bx,cx  ;Add two numbers bx,cx
inc cx     ;Incremente cx de 1

cmp	dx,cx  ;ici on compare dx et cx si dx>cx alors on 
 

ja lol     ;jump if above dx>cx then jump


 

ret

