ORG 100h

;initialisation de la memoire video 

MOV AX, 0B800h
MOV DS, AX



MOV AX,0
MOV DX,0
ADD BX,0
MOV CX,0 
 

;========================PROCEDURE REBOND========================




rebond1:   

    MOV BX,AX            
    MOV [01h+BX], 40h    ; couleur du tracer laisser par  la balle (rouge)
    
    MOV BX,DX            
	MOV [01h+BX], 0F0h   ; couleur de la balle 
	
	MOV AX,BX            
	ADD BX, 162          
	MOV DX,BX            
	 

	
	INC CL 
	INC CH  
	
	
	;on verifie si la balle est touche le bas de la fenetre
	
	CMP CL,24  
	JGE rebond2
    
    
    ;on verifie si la balle touche le cote droit de la fenetre
    
	CMP CH,79
	JGE rebond4
	  
	
	; si aucunes de ces 2 conditions n'est concretise on relance l'etiquette executee
	
	JMP rebond1



	
rebond2:  

    MOV BX,AX
    MOV [01h+BX], 40h   ;couleur du tracer laisser par  la balle (rouge)
    
    MOV BX,DX
	MOV [01h+BX], 0F0h 

	MOV AX,BX
	SUB BX,158
	MOV DX,BX 

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




rebond3: 

    MOV BX,AX
    MOV [01h+BX], 40h              ;couleur du tracer laisser par  la balle (rouge)
    
    MOV BX,DX
	MOV [01h+BX], 0F0h 
	
	
	MOV AX,BX
	SUB BX,162
	MOV DX,BX 
	
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




rebond4:      

    MOV BX,AX
    MOV [01h+BX], 40h         ;couleur du tracer laisser par  la balle (rouge)
    
    MOV BX,DX
	MOV [01h+BX], 0F0h 
	
	MOV AX,BX
	ADD BX,158
	MOV DX,BX 

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