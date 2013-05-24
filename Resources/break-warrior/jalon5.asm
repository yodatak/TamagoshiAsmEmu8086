ORG 100h

MOV AX, 0B800h
MOV DS, AX


; initialisation des registres
           
MOV AX, 02h
MOV BX, 00h 
MOV CX, 10 
MOV DX, 0A0h


  



croix:  

MOV [7D0h + BX], 0F2Bh   ; affiche le plus au centre de la croix
ADD BX, AX  

MOV [7D0h + BX], 0F2Dh   ; affiche les tiret a droite de la croix
SUB BX, AX
SUB BX, AX  

MOV [7D0h + BX], 0F2Dh   ; affiche les tiret a gauche de la croix
ADD BX, AX
ADD BX, DX   

MOV [7D0h + BX], 0F7Ch   ; affiche les tiret en bas de la croix
SUB BX, DX
SUB BX, DX

MOV [7D0h + BX], 0F7Ch   ; affiche les tiret en haut de la croix
ADD BX, DX
	
	
ADD AX, 2
ADD DX, 0A0h


LOOP croix  
         

RET