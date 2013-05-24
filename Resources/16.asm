
org 100h

mov bx, 0x200h

mov w, DS:[bx], -0x10h


mov ax, 0x2F0h
mov dx, 0


div w.DS:bx
mul w.DS:bx
mov w.DS:bx + 2, ax
mov w.DS:bx + 4, ax
ret




