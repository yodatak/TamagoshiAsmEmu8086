ORG 100h
 

MOV AX, 0B800h
MOV DS, AX


; on initialise les registres au besoin de notre croix

MOV DX, 0A0h
MOV BX, 00h
MOV AX, 02h
MOV CX, 10  



croix:  

MOV [7D0h + BX], 0A2Bh
ADD BX, AX  

MOV [7D0h + BX], 0A2Dh
SUB BX, AX
SUB BX, AX  

MOV [7D0h + BX], 0A2Dh
ADD BX, AX
ADD BX, DX   

MOV [7D0h + BX], 0A7Ch
SUB BX, DX
SUB BX, DX

MOV [7D0h + BX], 0A7Ch
ADD BX, DX
	
	
ADD AX, 2
ADD DX, 0A0h


LOOP croix  


MOV DX, 00h
MOV BX, 00h
MOV AX, 00h
MOV CX, 00h

rebond1:

MOV BX, AX  
MOV [00H + BX], 04DBh
	
MOV BX, DX
MOV AX, [00H + BX]
MOV [00H + BX], 0FF20h
	
MOV BX, AX
MOV AX, DX


CMP BH, 0x0Ah
JNZ suite_rebond1
	
CMP BL, 0x2Dh
JZ rebond2
JMP rebond4

	
suite_rebond1:

ADD DX,0xA2h
	
INC CL
INC CH
	
CMP CL,24
JGE rebond2

CMP CH,79
JGE rebond4
	
JMP rebond1


	
	
rebond2:

	
MOV BX, AX
MOV [00h+BX], 04DBh    	;Couleur de fond
	
MOV BX, DX
MOV AX, [00H + BX]
MOV [00H + BX], 0xFF20h
	
MOV BX, AX
MOV AX, DX
	
CMP BH, 0x0Ah
JNZ suite_rebond2
	
CMP BL, 0x2Dh
JZ rebond1
JMP rebond3
	
	
suite_rebond2:


SUB DX,0x9Eh
	
DEC CL
INC CH
	
CMP CL,0
JLE rebond1

CMP CH,79
JGE rebond3
	
JMP rebond2




rebond3:


	
MOV BX, AX
MOV [00h+BX], 04DBh      ;Couleur de fond
	    	
	
MOV BX, DX
MOV AX, [00H + BX]
MOV [00H + BX], 0xFF20h
	
MOV BX, AX
MOV AX, DX
	
CMP BH, 0x0Ah
JNZ suite_rebond3
	
CMP BL, 0x2Dh
JZ rebond4
JMP rebond2 

	
Suite_rebond3:


SUB DX,0xA2h
	
	
DEC CL
DEC CH
	
	
CMP CL,0
JLE rebond4

CMP CH,0
JLE rebond2
	
JMP rebond3



rebond4:

MOV BX, AX
MOV [00h+BX], 04DBh    	;Couleur de fond
	
MOV BX, DX
MOV AX, [00H + BX]
MOV [00H + BX], 0xFF20h
	
MOV BX, AX
MOV AX, DX
	
CMP BH, 0x0Ah
JNZ suite_rebond4
	
CMP BL, 0x2Dh
JZ rebond3
JMP rebond1

	
Suite_rebond4:


ADD DX,0x9eh
	
INC CL
DEC CH
	
CMP CL,24
JGE rebond3

CMP CH,0
JLE rebond1
	
JMP rebond4

RET