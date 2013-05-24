ORG 100h
             
CALL lancement             
CALL raquette  

deplacement_raquette:

MOV BX, 0
MOV CH, 1
MOV CL, 2

MOV AX, 142h
MOV DX, 142h
CALL deplacement
               

JNZ deplacement_raquette  

RET            

lancement PROC

MOV AX, 0B800h  ; On initialise le registre DS a B800h qui correspond au lancement de la memoire video
MOV DS, AX

MOV AX, 02000h  ; On initialise le registre ES a 2000h pour stocker des valeurs necessaires au fonctionnement du jeu
MOV ES, AX 

MOV ES:[0], 80  ; On se positionne au milieu de l'écran


RET

lancement ENDP


raquette PROC 
    
PUSH AX    
PUSH BX
PUSH CX
PUSH DX
   
MOV BX, ES:[0] 

MOV [0EFCh + BX], 'X' ; centre - 4
MOV [0EFEh + BX], 'X' ; centre - 2
MOV [0F00h + BX], 'X' ; centre      +BX pour connaitre la position que le joueur a ajoute
MOV [0F02h + BX], 'X' ; centre + 2
MOV [0F04h + BX], 'X' ; centre + 4  

POP DX
POP CX
POP BX
POP AX

RET 
      
raquette ENDP             

deplacement PROC

PUSH AX    
PUSH BX
PUSH CX
PUSH DX
 
MOV DX, 0
MOV AX, 0

MOV AH, 6
MOV DL, 255
int 21h






CMP AL, 119
JZ vers_la_gauche

CMP AL, 120
JZ vers_la_droite

JMP fin



vers_la_gauche:

CALL dropraquette 
SUB B.ES:[0], 2
JMP suite


vers_la_droite:

CALL dropraquette
ADD B.ES:[0], 2                    ; ES:[0] POSITION RAQUETTE
JMP suite


suite:
	
CALL raquette


fin:
POP DX
POP CX
POP BX
POP AX



RET 
deplacement ENDP
                                          

dropraquette PROC 
    
PUSH AX    
PUSH BX
PUSH CX
PUSH DX
   
MOV BX, ES:[0] ; On recupere la position (la colonne) du centre de la raquette
               ; On ajoute F00h pour se trouver sur la derniere ligne

MOV [0EFCh + BX], ' ' ; centre - 4
MOV [0EFEh + BX], ' ' ; centre - 2
MOV [0F00h + BX], ' ' ; centre 
MOV [0F02h + BX], ' ' ; centre + 2
MOV [0F04h + BX], ' ' ; centre + 4  

POP DX
POP CX
POP BX
POP AX

RET 
dropraquette ENDP
                                        