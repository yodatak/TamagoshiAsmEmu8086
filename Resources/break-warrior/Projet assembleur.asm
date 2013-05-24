ORG 100h

CALL lancement
CALL cadre
CALL briques
CALL raquette



game:
; On se positionne en haut de l'ecran a gauche


MOV BX, 0
MOV CH, 1
MOV CL, 2

MOV AX, 142h        ; 142h = 322d
MOV DX, 142h


;ici rebond1, rebond2, rebond3 ,
; rebond4 sont les 4 directions possibles de la balle apres une collision



rebond1:	CALL deplacement
	MOV BX, AX			; AX represente l'ancienne position
	MOV [00h+BX], 0x0F20h    ;Couleur de fond
	
	MOV BX, DX			; DX represente la position actuelle
	MOV AX, [00H + BX]
	MOV [00H + BX], 0xF020h		;On utilise AX pour stocker temporairement 


	CMP AH, 0x0Bh              ; couleur de l'obstacle balle
	JNZ test_raquette_rebond1
	         ; traitement de l'obstacle

	MOV BX, AX				;la couleur de la case pour effectuer un test ulterieurement
	MOV AX, DX


	CALL score
	
	CMP BL, 0x2Dh			; on teste le symbole present       2D
	JZ rebond2
	JMP rebond4

test_raquette_rebond1: MOV BX, [0A0h+BX]                           ; vers haut gauche
                  MOV AX, DX
                  CMP BL, 58h
                  JZ rebond2 

suite_rebond1:

	ADD DX,0xA2h
	
	INC CL
	INC CH
	
	CMP CL,26
	JGE fin_de_jeu

	CMP CH,79
	JGE rebond4
	
	JMP rebond1
	


	
rebond2:	CALL deplacement
	MOV BX, AX
	MOV [00h+BX], 0x0F20    	;Couleur de fond DE LA balle
	
	MOV BX, DX
	MOV AX, [00H + BX]
	MOV [00H + BX], 0xF020h
	
	CMP AH, 0x0Bh              ; couleur de l'obstacle ??
	JNZ test_raquette_rebond2
	         ; traitement de l'obstacle
	         
	MOV BX, AX
	MOV AX, DX
	
	CALL score
	
	CMP BL, 0x2Dh			;on teste le symbole present 2D= '-'
	JZ rebond1
	JMP rebond3
	
test_raquette_rebond2: MOV BX, [0A0h+BX]                   ; vers haut droite
               MOV AX, DX
               CMP BL, 3Dh                       ; 3Dh destination balle apres collision raquette
               JZ rebond2 
	
suite_rebond2:
	SUB DX,0x9Eh
	
	DEC CL
	INC CH
	
	CMP CL,2
	JLE rebond1

	CMP CH,79
	JGE rebond3
	
	JMP rebond2






rebond3:	CALL deplacement
	MOV BX, AX
	MOV [00h+BX], 0x0F20    	;Couleur de fond
	
	MOV BX, DX
	MOV AX, [00H + BX]
	MOV [00H + BX], 0xF020h     
	
	CMP AH, 0x0Bh              ; couleur de l'obstacle ??
	JNZ test_raquette_rebond3
	         ; traitement de l'obstacle
	
	MOV BX, AX
	MOV AX, DX
	
	CMP BH, 0x0Ah
	JNZ suite_rebond3
	CALL score
	
	CMP BL, 0x2Dh			; on teste le symbole present
	JZ rebond4
	
	JMP rebond2 
	
	test_raquette_rebond3: MOV BX, [0A0h+BX]                   ; vers haut droite
               MOV AX, DX
               CMP BL, 3Dh                       ; 3Dh destination balle apres collision raquette
               JZ rebond4 
	
Suite_rebond3:
	SUB DX,0xA2h
	
	
	DEC CL
	DEC CH
	
	
	CMP CL,2
	JLE rebond4

	CMP CH,1
	JLE rebond2
	
	JMP rebond3
	





rebond4:	CALL deplacement
	MOV BX, AX
	MOV [00h+BX], 0x0F20    	;Couleur de fond
	
	MOV BX, DX
	MOV AX, [00H + BX]
	MOV [00H + BX], 0xF020h 
	
	CMP AH, 0x0Bh              ; couleur de l'obstacle ??
	JNZ test_raquette_rebond4
	         ; traitement de l'obstacle
	
	MOV BX, AX
	MOV AX, DX
	
	CMP BH, 0x0Ah
	JNZ suite_rebond4
	CALL score
	
	
	CMP BL, 0x2Dh			;on teste le symbole present
	JZ rebond3
	JMP rebond1         
	
	test_raquette_rebond4: MOV BX, [0A0h+BX]                   ; vers haut droite
               MOV AX, DX
               CMP BL, 58h                       ; 3Dh destination balle apres collision raquette
               JZ rebond3

	
Suite_rebond4:
	ADD DX,0x9eh
	
	INC CL
	DEC CH
	
	CMP CL,26
	JGE fin_de_jeu

	CMP CH,1
	JLE rebond1
	
	JMP rebond4
	
	
	
fin_de_jeu:

CALL vie

CMP ES:[2], 0       ; compare ES:[2] (nbr de vies) avec 0 si = 0 jump at procedure perdue 
	  
JNZ game 

CALL perdue	           ; appelle procedure perdu

RET   ; FIN DU PROGRAMME PRINCIPAL, ON REND LA MAIN AU DOS




;!!!!!!!!!!!!!!!!!!!!   PROCEDURE LANCEMENT  !!!!!!!!!!!!!!!!!!!!!!!!!



lancement PROC

MOV AX, 0B800h  ; On initialise le registre DS a B800h qui correspond au debut de la memoire video
MOV DS, AX

MOV AX, 02000h  ; On initialise le registre ES a 2000h pour stocker des valeurs necessaires au fonctionnement du jeu
MOV ES, AX 

MOV ES:[0], 0   ; score a 0
MOV ES:[2], 3   ; nombre de point de vie a 3
MOV ES:[4], 50  ; position raquette a l'ecran 50 / 160

MOV [00h], 'S'
MOV [02h], 'c'
MOV [04h], 'o'
MOV [06h], 'r'
MOV [08h], 'e'
MOV [0Ah], ':'
MOV [0Eh], '0'
MOV [10h], '0'
MOV [12h], '0'
MOV [14h], '0'
MOV [16h], '0'

MOV [32h], 'V'
MOV [34h], 'i'
MOV [36h], 'e'
MOV [38h], 's'
MOV [3Ch], ':'
MOV [3Eh], '3'




RET

lancement ENDP



; !!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE CADRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



cadre PROC

PUSH AX
PUSH BX 
PUSH CX
PUSH DX

; On trace la partie gauche et droite du cadre

MOV AX, 02h
MOV BX, 00h
MOV CX, 23   ; On a 23 lignes
MOV DX, 0A0h

cadre2:
         MOV [0140h + BX], 0x0F49h
         MOV [01DEh + BX], 0x0F49h	
	     ADD BX, 0A0h
	
         LOOP cadre2  ; Si CX != 0, on reboucle
         
         
         

; On trace le haut du cadre

MOV BX, 00h
MOV CX, 80    ; On a 80 colonnes

cadre1: 
         MOV [0A0h + BX], 0x0F5Fh
         ADD BX, 2

         LOOP cadre1  ; Si CX != 0, on reboucle


POP DX
POP CX
POP BX
POP AX  

RET

cadre ENDP




; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  PROCEDURE BRIQUE  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



briques PROC

PUSH AX
PUSH BX 
PUSH CX
PUSH DX

MOV DX, 0A0h
MOV BX, 00h
MOV AX, 02h
MOV CX, 10

MOV [7D0h + BX], 0x0B2Bh			; Equivaut A MOV [7D0h], '+'(creation symbole milieu)

boucle: 
         ADD BX, AX
         MOV [7D0h + BX], 0x0B2Dh		
         SUB BX, AX
	
         SUB BX, AX
         MOV [7D0h + BX], 0x0B2Dh		; Equivaut à MOV [7D0h], '-' 2D = '-' (symbole brique)
         ADD BX, AX
	
         ADD BX, DX
         MOV [7D0h + BX], 0x0B7Ch		; Equivaut à MOV [7D0h], '|'  7C = '|'(symbole brique)
         SUB BX, DX
	
         SUB BX, DX
         MOV [7D0h + BX], 0x0B7Ch
         ADD BX, DX
	
         ADD AX, 2
         ADD DX, 0A0h

         LOOP boucle  ; Si CX != 0, on reboucle

POP DX
POP CX
POP BX
POP AX  

RET

briques ENDP




;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE SCORE   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



score PROC

PUSH AX
PUSH BX 
PUSH CX
PUSH DX

       
INC ES:[0]
          
MOV AX, ES:[0]  

MOV DX, 0  
MOV BX, 10000

DIV BX  

ADD AX, 48 

; affichage de ax

MOV [0Eh], AL

MOV AX, DX
MOV DX, 0 
MOV BX, 1000
 
DIV BX  

ADD AX, 48 

; affichage de ax
MOV [10h], AL

MOV AX, DX
MOV DX, 0 
MOV BX, 100
 
DIV BX  

ADD AX, 48 

; affichage de ax
MOV [12h], AL 

MOV AX, DX
MOV DX, 0 
MOV BX, 10
 
DIV BX  

ADD AX, 48 

; affichage de ax
MOV [14h], AL  

ADD DX, 48

; affichage de ax
MOV [16h], DL

POP DX
POP CX
POP BX
POP AX    

RET            
       
score ENDP





;!!!!!!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE VIE  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



vie PROC

PUSH AX
PUSH BX 
PUSH CX
PUSH DX
 
DEC ES:[2]
                       ; decremente le nombre de point de vie
MOV AX, ES:[2]  

ADD AX, 48

; affichage de ax
MOV [3Eh], AL                ; 3CH position de l'affichage des points de vie

POP DX
POP CX
POP BX
POP AX    

RET            

vie ENDP





;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!PROCEDURE PERDUE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



perdue PROC

PUSH AX
PUSH BX 
PUSH CX
PUSH DX
PUSH DS

; Ecriture de la premiere barre (du haut)

MOV DH, 11
MOV DL, 30
MOV BH, 0
MOV AH, 2
int 10h


MOV AX, SEG msg2
MOV DS, AX
MOV DX, OFFSET msg2
MOV AH, 9
int 21h

; Ecriture du texte

MOV DH, 12
MOV DL, 30
MOV BH, 0
MOV AH, 2
int 10h


MOV AX, SEG msg
MOV DS, AX
MOV DX, OFFSET msg
MOV AH, 9
int 21h




; Ecriture de la seconde barre (du bas)
MOV DH, 13
MOV DL, 30
MOV BH, 0
MOV AH, 2
int 10h


MOV AX, SEG msg1
MOV DS, AX
MOV DX, OFFSET msg1
MOV AH, 9
int 21h
                
                
msg1 db " +-----------------+ $"
msg db " |  Manche Perdue  | $"
msg2 db " +-----------------+ $"


POP DS
POP DX 
POP CX
POP BX 
POP AX


RET

perdue ENDP





;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE RAQUETTE  !!!!!!!!!!!!!!!!!!!!!!!



raquette PROC 
    
PUSH AX    
PUSH BX
PUSH CX
PUSH DX
   
MOV BX, ES:[4] ; On recupere la position (la colonne) du centre de la raquette
               ; On ajoute F00h (24eme ligne)pour se trouver sur la derniere ligne

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






;!!!!!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE EFFACE RAQUETTE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!


dropraquette PROC 
    
PUSH AX    
PUSH BX
PUSH CX
PUSH DX
   
MOV BX, ES:[4] ; On recupere la position (la colonne) du centre de la raquette
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








                                            
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! PROCEDURE DEPLACEMENT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!


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
CMP B.ES:[4], 4
JLE fin
CALL dropraquette 
SUB B.ES:[4], 2
JMP suite


vers_la_droite:
CMP B.ES:[4], 160
JZ fin
CALL dropraquette
ADD B.ES:[4], 2         ; ES:[4] POSITION RAQUETTE
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
