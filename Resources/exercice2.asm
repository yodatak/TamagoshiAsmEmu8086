;922  
cmp ax, 4
jnz else1
mov bx, 0x10h
jmp fin1     
else1:
mov bx, 0x20h
mov cx, 0x30h
fin1: