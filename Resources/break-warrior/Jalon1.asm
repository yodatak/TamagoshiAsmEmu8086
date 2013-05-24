ORG 100h

MOV AX, 0B800h
MOV DS, AX                            






MOV AX, 0
MOV BX, 0
MOV CX, 0
MOV DX, 0       



trait-oblique:
                              
                              
	MOV [01h+BX], 10h    	;Couleur de fond 
	
	
	ADD BX,162     
	
		
	INC CL   
	                 
	
	CMP CL,25  
	
	JC trait-oblique  
	
	
	
RET