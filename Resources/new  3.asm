name "mycode"   ; output file name (max 8 chars for DOS compatibility)

org  100h ; set location counter to 100h

; add your code here
mov al, -20  
mov bl, 15
imul bl ;multiplication 15 ´ -20 sur 8 bits 

mov al, -10
mov bl, 115
imul bl ;multiplication 115 ´ -10 sur 8 bits 

mov ax, -10
mov bx, 115
imul bx ;multiplication 115 ´ -10 sur 16 bits 

mov ax, 93
mov bl, 3
div bl  ;division 93 / 3 sur 8 bits 

mov ax, 520
mov bx, -10
idiv bx ;division 520 / -10 sur 8 bits 

mov dx, 0
mov ax, 520
mov bx, -10
idiv bx ;division 520 / -10 bits sur 16 bits


mov ah, 0          ; wait for any key....
int 10110b         ; same as int 16h or int 22.

ret   ; return to the operating system.