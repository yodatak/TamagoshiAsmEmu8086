ORG 100h

;initialisation de la memoire vidéo   

MOV AX, 0B800h
MOV DS, AX
 

MOV AX,0
MOV DX,0
ADD BX,0
MOV CX,0 
 

;==================     PROCEDURE REBOND DE LA BALLE       =================    



;procedure rebond 1


rebond1: 
 

	MOV [01h+BX], 10h    	;couleur du trait laisser pas la balle en  bleu (10h)
	
	ADD BX, 162
	
	INC CL ; represente l'axe des Y
	INC CH ; represente l'axe des X 
	
	
	;on verifie si la balle touche le bas de la fenetre 
	
	CMP CL,24  
	JGE rebond2
    
    
    ;verifie si la balle arrive au cote droit de la fenetre 
    
	CMP CH,79
	JGE rebond4
	  
	
	; si aucune de ces 2 conditions n'est concretise on relance l'etiquette executee
	JMP rebond1


;procedure rebond 2

	
rebond2:  

	MOV [01h+BX], 20h  ;couleur du trait laisser pas la balle en  vert (20h)
	
	SUB BX,158
	
	DEC CL
	INC CH    
	
	
	;on verifie si la balle touche le haut de la fenetre
	CMP CL,0
	JLE rebond1   
	
	
    ;on verifie si la balle touche le cote droit de la fenetre
	CMP CH,79
	JGE rebond3  
	
	
	;si aucunes de ces 2 conditions n'est concretise on relance l'etiquette executee
	JMP rebond2



;procedure rebond 3



rebond3: 

	MOV [01h+BX], 30h    	;couleur du trait laisser pas la balle en  vert (20h)
	
	SUB BX,162
	
	
	DEC CL
	DEC CH   
	
	      
	;on verifie si la balle touche le haut de la fenetre
	CMP CL,0
	JLE rebond4 
	
	
	;on verifie si la balle touche le cote gauche de la fenetre
	CMP CH,0
	JLE rebond2 
	
	
	;si aucunes de ces 2 conditions n'est concretise on relance l'etiquette executee
	JMP rebond3
                    
                    
                    
;procedure rebond 4


rebond4:      

	MOV [01h+BX], 40h    	;couleur du trait laisser pas la balle en  rouge (40h)
	
	ADD BX,158
	
	INC CL
	DEC CH  
	
	
	;on verifie si la balle touche le bas de la fenetre
	CMP CL,24
	JGE rebond3
	
	
	;on verifie si la balle touche le cote gauche de la fenetre
	CMP CH,0
	JLE rebond1 
	
	
	;si aucunes de ces 2 conditions n'est concretise on relance l'etiquette executee
	JMP rebond4

RET